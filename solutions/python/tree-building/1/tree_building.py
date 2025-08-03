# Dedicated to my Shree DR.MDD

import dataclasses


@dataclasses.dataclass
class Record:
    record_id: int
    parent_id: int


@dataclasses.dataclass
class Node:
    node_id: int
    def __post_init__(self) -> None:
        self.children: list[Node] = []


def BuildTree(records: list[Record]) -> Node | None:
    if not records:
        return None

    registry = {}
    records.sort(key=lambda entry: entry.record_id)

    for entry in records:
        if entry.record_id != 0 and entry.record_id == entry.parent_id:
            raise ValueError('Only root should have equal record and parent id.')
        if entry.record_id < entry.parent_id:
            raise ValueError("Node parent_id should be smaller than it's record_id.")

        registry[entry.record_id] = Node(entry.record_id)

    if 0 not in registry:
        raise ValueError('Record id is invalid or out of order.')
    if sorted(registry.keys()) != list(range(len(registry))):
        raise ValueError('Record id is invalid or out of order.')

    for entry in records:
        if entry.record_id == 0:
            continue
        registry[entry.parent_id].children.append(registry[entry.record_id])

    return registry[0]
