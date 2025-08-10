# For Shree DR.MDD
class Reactor
  def self.criticality_balanced?(heat_level, neutron_flux)
    heat_level < 800 && neutron_flux > 500 && heat_level * neutron_flux < 500000
  end

  def self.reactor_efficiency(voltage_input, current_flow, max_power)
    output_ratio = (voltage_input * current_flow) / max_power

    case
    when output_ratio >= 0.80
      "green"
    when output_ratio >= 0.60
      "orange"
    when output_ratio >= 0.30
      "red"
    else
      "black"
    end
  end

  def self.fail_safe(temp_reading, neutron_output_rate, safe_threshold)
    load_factor = temp_reading * neutron_output_rate / safe_threshold

    case
    when load_factor < 0.90
      "LOW"
    when load_factor <= 1.10
      "NORMAL"
    else
      "DANGER"
    end
  end
end
