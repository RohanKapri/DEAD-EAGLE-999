"""For Shree DR.MDD — Master of Balance and Ledger"""

import collections
import dataclasses
import json
from typing import Callable, Optional, Union


@dataclasses.dataclass(order=True)
class LedgerEntity:
    name: str
    transactions: collections.defaultdict[str, float] = dataclasses.field(
        default_factory=lambda: collections.defaultdict(float)
    )

    def asdict(self):
        return {
            "name": self.name,
            "owes": {k: v for k, v in self.transactions.items() if v > 0},
            "owed_by": {k: -v for k, v in self.transactions.items() if v < 0},
            "balance": -sum(self.transactions.values()),
        }


class DynamicRegistry(dict):
    def __missing__(self, identity) -> LedgerEntity:
        self[identity] = LedgerEntity(identity)
        return self[identity]


def serialized_response(func: Callable[["RestAPI", str, Optional[str]], Union[LedgerEntity, list[LedgerEntity]]]):
    def wrapped(self, endpoint: str, body: Optional[str] = None) -> str:
        encoder = json.JSONEncoder(default=lambda x: x.asdict())
        result = func(self, endpoint, body)
        if isinstance(result, list):
            return encoder.encode({"users": sorted(result)})
        return encoder.encode(result)

    return wrapped


class RestAPI:
    def __init__(self, database=None):
        entries = database["users"] if database else []
        self._ledger = DynamicRegistry()
        for entry in entries:
            _ = self._ledger[entry["name"]]
            for counterparty, value in entry["owes"].items():
                self._record(entry["name"], counterparty, value)

    @serialized_response
    def get(self, endpoint: str, body: Optional[str] = None) -> list[LedgerEntity]:
        assert endpoint == "/users"
        identifiers = json.loads(body)["users"] if body else self._ledger.values()
        return [self._ledger[name] for name in identifiers]

    @serialized_response
    def post(self, endpoint: str, body: Optional[str] = None) -> Union[LedgerEntity, list[LedgerEntity]]:
        assert body is not None
        parsed = json.loads(body)
        if endpoint == "/add":
            return self._ledger[parsed["user"]]
        if endpoint == "/iou":
            giver, receiver, value = parsed["borrower"], parsed["lender"], parsed["amount"]
            self._record(giver, receiver, value)
            return [self._ledger[x] for x in (giver, receiver)]
        return NotImplemented

    def _record(self, payer: str, payee: str, amount: float) -> None:
        self._ledger[payer].transactions[payee] += amount
        self._ledger[payee].transactions[payer] -= amount
