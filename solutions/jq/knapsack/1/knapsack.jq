def knapsack(items; maximumWeight):
  reduce range(1; (items | length) + 1) as $item ([[0]];
      items[$item - 1] as $itemObject 
      | reduce range(1; maximumWeight + 1) as $weight (.;
          (.[$item - 1][$weight] // 0) as $lastValue
          | .[$item][$weight] = 
          if $itemObject.weight > $weight then
            $lastValue
          else 
            [
              $lastValue,
              .[$item - 1][$weight - $itemObject.weight] + $itemObject.value
            ]
            | max
          end
      )
  )
  | last # item
  | last # weight
;
.items as $items
| .maximumWeight as $maximumWeight
| knapsack($items; $maximumWeight)