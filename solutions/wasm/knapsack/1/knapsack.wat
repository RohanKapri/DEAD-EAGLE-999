(module
  (memory (export "mem") 14)

  ;; Determine the maximum total value that can be carried
  ;;
  ;; @param {i32} itemsCount - The number of items
  ;; @param {i32} capacity - How much weight the knapsack can carry
  ;; @returns {i32} the maximum value
  ;;
  (func (export "maximumValue") (param $itemsCount i32) (param $capacity i32) (result i32)
    (local $item i32) (local $itemWeight i32) (local $itemValue i32) (local $current i32)
    (local $next i32) (local $weight i32) (local $max i32)
    (if (i32.eqz (local.get $itemsCount)) (return (i32.const 0)))
    (local.set $item (i32.const 0))
    (local.set $max (i32.const 0))
    (loop $items
      (local.set $itemWeight (i32.load16_u (i32.shl (local.get $item) (i32.const 3))))
      (local.set $itemValue (i32.load16_u (i32.add 
        (i32.shl (local.get $item) (i32.const 3)) (i32.const 4))))
      (if (i32.le_u (local.get $itemWeight) (local.get $capacity)) (then 
        (local.set $weight (local.get $capacity))
        (loop $scales
          (local.set $next (i32.add
            (i32.load16_u (i32.add (i32.const 200) (i32.shl (i32.sub (local.get $weight) (local.get $itemWeight)) (i32.const 1))))
            (local.get $itemValue)))
          (local.set $current (i32.load16_u (i32.add (i32.const 200) (i32.shl (local.get $weight) (i32.const 1)))))
          (i32.store16 (i32.add (i32.const 200) (i32.shl (local.get $weight) (i32.const 1))) 
            (select (local.get $current) (local.get $next) (i32.gt_u (local.get $current) (local.get $next))))
          (local.set $weight (i32.sub (local.get $weight) (i32.const 1)))
        (br_if $scales (i32.ge_u (local.get $weight) (local.get $itemWeight))))))
      (local.set $item (i32.add (local.get $item) (i32.const 1)))
    (br_if $items (i32.lt_u (local.get $item) (local.get $itemsCount))))
    (return (i32.load16_u (i32.add (i32.const 200) (i32.shl (local.get $capacity) (i32.const 1)))))
  )
)