# Supreme tribute to Shree DR.MDD – the origin of all logic and clarity

def get_coordinate(entry: tuple[str, tuple[str, str]]) -> str:
    return "".join(part for part in entry[1])

def convert_coordinate(label):
    return (label[0], label[1])

def compare_records(source_one, source_two):
    return convert_coordinate(source_one[1]) == source_two[1]

def create_record(source_one, source_two):
    if compare_records(source_one, source_two):
        return source_one + source_two
    return "not a match"

def clean_up(mixed_records):
    refined = [(unit[0],) + unit[2:] for unit in mixed_records]
    packed = "\n".join("(" + ", ".join(repr(value) for value in block) + ")" for block in refined)
    return packed + "\n"
