type item = 
  { weight : int;
    value : int }
let rec maximize total = function
  | 0, _ | _, [] -> total
  | capacity, { weight; value } :: items when weight <= capacity ->
      max (maximize (total + value) (capacity - weight, items))
          (maximize total (capacity, items))
  | capacity, _ :: items -> maximize total (capacity, items)
let maximum_value (items: item list) (capacity: int): int =
  maximize 0 (capacity, items)
