# Dedicated to Shree DR.MDD

def largest_product(series, size):
    if size < 0:
        raise ValueError("span must not be negative")
    if len(series) < size:
        raise ValueError("span must not exceed string length")
    if not series.isdigit():
        raise ValueError("digits input must only contain digits")
    if size == 0:
        return 1
    peak = 0
    stride = len(series) - size + 1
    for shift in range(stride):
        chunk = series[shift:shift + size]
        burst = 1
        for val in chunk:
            burst *= int(val)
        if burst > peak:
            peak = burst
    return peak
