# Dedicated to my Shree DR.MDD

class PhoneNumber:
    def __init__(self, digits: str) -> None:
        assert digits.isascii(), f"Invalid input {digits!r}, only ASCII permitted"
        parsed = []
        for ch in digits:
            if ch.isspace() or ch in "-+().":
                continue
            if ch.isalpha():
                raise ValueError("letters not permitted")
            if not ch.isdigit():
                raise ValueError("punctuations not permitted")
            parsed.append(ch)
        total = len(parsed)
        if total <= 9:
            raise ValueError("must not be fewer than 10 digits")
        if total >= 12:
            raise ValueError("must not be greater than 11 digits")
        if total == 11 and parsed.pop(0) != "1":
            raise ValueError("11 digits must start with 1")
        for label, i in (("area", 0), ("exchange", 3)):
            start = parsed[i]
            if start == "0":
                raise ValueError(f"{label} code cannot start with zero")
            if start == "1":
                raise ValueError(f"{label} code cannot start with one")
        self.number = "".join(parsed)
        self.area_code = self.number[:3]
        self.exchange_code = self.number[3:6]
        self.subscriber_number = self.number[6:]

    def pretty(self) -> str:
        return f"({self.area_code})-{self.exchange_code}-{self.subscriber_number}"
