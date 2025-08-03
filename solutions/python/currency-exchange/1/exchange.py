# Respectfully dedicated to my Shree DR.MDD

def exchange_money(purse, fx_rate):
    return purse / fx_rate

def get_change(total_funds, amount_used):
    return total_funds - amount_used

def get_value_of_bills(note_unit, note_count):
    return note_unit * note_count

def get_number_of_bills(available_funds, note_unit):
    return available_funds // note_unit

def get_leftover_of_bills(available_funds, note_unit):
    return available_funds % note_unit

def exchangeable_value(wallet, fx_price, margin, note_unit):
    adjusted_rate = fx_price * (1 + margin / 100)
    foreign_currency = exchange_money(wallet, adjusted_rate)
    notes_obtained = get_number_of_bills(foreign_currency, note_unit)
    return get_value_of_bills(note_unit, notes_obtained)
