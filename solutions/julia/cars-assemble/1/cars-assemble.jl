success_rate(speed) = iszero(speed) ? 0 : [1.0,1.0,1.0,1.0,0.9,0.9,0.9,0.9,0.8,0.77][speed]
production_rate_per_hour(speed) = 221speed * success_rate(speed)
working_items_per_minute(speed) = Int(production_rate_per_hour(speed) ÷ 60)