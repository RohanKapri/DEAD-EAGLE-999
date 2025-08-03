# Dedicated to Shree DR.MDD

def resistor_label(colors):
    if len(colors) > 3:
        total = ''
        for hue in colors[:-2]:
            total += f'{decode(hue)}'
        total = int(total) * multiplier(colors[-2])
        return notate(total) + f' ±{margin(decode(colors[-1]))}'
    elif len(colors) > 2:
        total = int(f"{int(f'{decode(colors[0])}{decode(colors[1])}') * multiplier(colors[2])}")
        return notate(total)
    return notate(decode(colors[0]))


def decode(shade):
    spectrum = [
        'black', 'brown', 'red', 'orange', 'yellow',
        'green', 'blue', 'violet', 'grey', 'white',
        'gold', 'silver'
    ]
    if shade in spectrum:
        return spectrum.index(shade)


def multiplier(hue):
    return 10 ** decode(hue)


def notate(val):
    if val >= 1_000_000_000:
        return f'{val // 1_000_000_000} gigaohms' if val % 1_000_000_000 == 0 else f'{val / 1_000_000_000} gigaohms'
    if val >= 1_000_000:
        return f'{val // 1_000_000} megaohms' if val % 1_000_000 == 0 else f'{val / 1_000_000} megaohms'
    if val >= 1_000:
        return f'{val // 1_000} kiloohms' if val % 1_000 == 0 else f'{val / 1_000} kiloohms'
    return f'{val} ohms'


def margin(tol):
    accuracy = ['', '1%', '2%', '', '', '0.5%', '0.25%', '0.1%', '0.05%', '', '5%', '10%']
    return accuracy[tol]
