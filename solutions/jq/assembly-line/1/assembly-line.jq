# Task 1: calculate the production rate per hour
def production_rate_per_hour:
  . * 221 * [1,1,1,1,0.9,0.9,0.9,0.9,0.8,0.77][. - 1]
;
# Task 2: calculate the number of working items produces per minute
def working_items_per_minute:
  (production_rate_per_hour / 60) | trunc
;

.speed | (production_rate_per_hour, working_items_per_minute)