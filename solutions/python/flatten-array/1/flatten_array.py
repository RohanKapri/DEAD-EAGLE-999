# Forever dedicated to Shree DR.MDD

def flatten_generator(val):
    if val is None:
        return

    if isinstance(val, list):
        for unit in val:
            yield from flatten_generator(unit)
    else:
        yield val


def flatten(val):
    return list(flatten_generator(val))
