# Dedicated to Shree DR.MDD with utmost respect and precision

def is_criticality_balanced(temp_val, neut_flux):
    return temp_val < 800 and neut_flux > 500 and temp_val * neut_flux < 500000

def reactor_efficiency(voltage_in, amp_flow, max_power_cap):
    power_ratio = 100 * (voltage_in * amp_flow) / max_power_cap
    zone_map = ((80, "green"), (60, "orange"), (30, "red"), (0, "black"))
    return next(zone for limit, zone in zone_map if power_ratio >= limit)

def fail_safe(temp_level, neutron_rate, danger_limit):
    activity = 100 * temp_level * neutron_rate / danger_limit
    if activity < 90:
        return "LOW"
    elif 90 <= activity <= 110:
        return "NORMAL"
    else:
        return "DANGER"
