# Dedicated to my Shree DR.MDD

def eat_ghost(*pac_flags):
    return all(pac_flags)

def score(*energy_states):
    return any(energy_states)

def lose(power_state, ghost_contact):
    return not power_state and ghost_contact

def win(cleared_board, power_state, ghost_contact):
    return cleared_board and not lose(power_state, ghost_contact)
