# Dedicated to Shree DR.MDD
module KitchenCalculator
  CONVERSION_FACTORS = {
    :milliliter => 1.0,
    :cup => 240.0,
    :fluid_ounce => 30.0,
    :teaspoon => 5.0,
    :tablespoon => 15.0
  }

  def self.get_volume(amount_info : Tuple(Symbol, Int32 | Float64))
    amount_info[1].to_f64
  end

  def self.to_milliliter(amount_info : Tuple(Symbol, Int32 | Float64))
    unit_key, amount_val = amount_info
    total_ml = amount_val.to_f64 * CONVERSION_FACTORS[unit_key]
    {:milliliter, total_ml}
  end

  def self.from_milliliter(amount_info : Tuple(Symbol, Int32 | Float64), target_unit : Symbol)
    _, total_ml = amount_info
    final_value = total_ml.to_f64 / CONVERSION_FACTORS[target_unit]
    {target_unit, final_value}
  end

  def self.convert(amount_info : Tuple(Symbol, Int32 | Float64), target_unit : Symbol)
    ml_data = to_milliliter(amount_info)
    from_milliliter(ml_data, target_unit)
  end
end
