
.actual_minutes_in_oven //= 0 |
.number_of_layers       //= 1 |

40 as $expected_minutes_in_oven |
2  as $preparation_minutes_per_layer |

($preparation_minutes_per_layer * .number_of_layers)  as $preparation_time |

{
  $expected_minutes_in_oven,
  remaining_minutes_in_oven: ($expected_minutes_in_oven - .actual_minutes_in_oven),
  $preparation_time,
  total_time: ($preparation_time + .actual_minutes_in_oven)
}