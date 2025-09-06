(module
  (memory (export "mem") 1)

    (func $measure (param $listoffset i32) (param $price i32) (result i32)
    (local $i i32)
    (local $item i32)
    (local $howmanytosell i32)
    (local $newoffset i32)
    (local $lowest i32)
    (local $lowest_index i32)
    (local $price1 i32)
    (local $price2 i32)
    (loop $measureloop1
      (if (i32.ne (local.get $i) (i32.const 5))
      (then
        (local.set $item (i32.load8_u(i32.add(local.get $listoffset) (local.get $i))))
        (if (i32.gt_s (local.get $item) (i32.const 0))
        (then
          (local.set $howmanytosell (i32.add (local.get $howmanytosell) (i32.const 1)))
        ))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $measureloop1)
      ))
    )
    (if (i32.eq (local.get $howmanytosell) (i32.const 5))
    (then
      (local.set $newoffset (i32.add (local.get $listoffset) (i32.const 5)))
      (local.set $lowest (i32.const 6))
      (local.set $i (i32.const 0))
      (loop $measureloop2
        (if (i32.ne (local.get $i (i32.const 5)))
        (then
          (local.set $item (i32.load8_u(i32.add(local.get $listoffset) (local.get $i))))
          (if (i32.lt_s (local.get $item) (local.get $lowest))
          (then
            (local.set $lowest (local.get $item))
            (local.set $lowest_index (local.get $i))
          ))
          (i32.store8(i32.add(local.get $newoffset) (local.get $i)) (i32.sub(local.get $item) (i32.const 1)))
          (local.set $i (i32.add (local.get $i) (i32.const 1)))
          (br $measureloop2)
        ))
      )
      (local.set $price1 (call $measure (local.get $newoffset) (i32.add(local.get $price) (i32.const 3000))))
      (i32.store8(i32.add(local.get $newoffset) (local.get $lowest_index)) (local.get $lowest))
      (local.set $price2 (call $measure (local.get $newoffset) (i32.add(local.get $price) (i32.const 2560))))
      (if (i32.lt_s (local.get $price1) (local.get $price2))
      (then
        (return (local.get $price1))
      )
      (else
        (return (local.get $price2))
      ))
    )
    (else 
      (if (i32.ne (local.get $howmanytosell) (i32.const 0))
      (then
        (local.set $newoffset (i32.add (local.get $listoffset) (i32.const 5)))
        (local.set $i (i32.const 0))
        (loop $measureloop3
          (if (i32.ne (local.get $i (i32.const 5)))
          (then
            (local.set $item (i32.load8_u(i32.add(local.get $listoffset) (local.get $i))))
            (if (i32.gt_s (local.get $item) (i32.const 0))
            (then
              (i32.store8(i32.add(local.get $newoffset) (local.get $i)) (i32.sub(local.get $item) (i32.const 1)))
            )
            (else
              (i32.store8(i32.add(local.get $newoffset) (local.get $i)) (i32.const 0))
            ))
            (local.set $i (i32.add (local.get $i) (i32.const 1)))
            (br $measureloop3)
          ))
        )   
        (if (i32.eq (local.get $howmanytosell) (i32.const 1)) (then (local.set $price1 (i32.const 800)) ))
        (if (i32.eq (local.get $howmanytosell) (i32.const 2)) (then (local.set $price1 (i32.const 1520)) ))
        (if (i32.eq (local.get $howmanytosell) (i32.const 3)) (then (local.set $price1 (i32.const 2160)) ))
        (if (i32.eq (local.get $howmanytosell) (i32.const 4)) (then (local.set $price1 (i32.const 2560)) ))
        (local.set $price2 (call $measure (local.get $newoffset) (i32.add(local.get $price) (local.get $price1))))
        (return (local.get $price2))
      ))
    ))
    (return (local.get $price))
  )
  ;;
  ;; Calculate the price of shopping basket of books
  ;;
  ;; @param {i32} basketOffset - offset of input u32[] array
  ;; @param {i32} basketLength - length of input u32[] array in elements
  ;;
  ;; @return {i32} - price of shopping basket
  ;;
  (func (export "total") (param $basketOffset i32) (param $basketLength i32) (result i32)
    (local $i i32)
    (local $item i32)
    (local $inlist i32)

    (loop $emptyloop
      (if (i32.ne (local.get $i) (i32.const 5))
      (then
        (i32.store8 (i32.add(i32.const 1024) (i32.sub (local.get $i) (i32.const 1))) (i32.const 0))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $emptyloop)
      ))
    )
    
    (local.set $i (i32.const 0))
    (loop $totalloop
      (if (i32.ne (local.get $i) (local.get $basketLength))
      (then
        (local.set $item (i32.load(i32.add(local.get $basketOffset) (i32.mul (local.get $i) (i32.const 4)))))
        (local.set $inlist (i32.load8_u(i32.add(i32.const 1024) (i32.sub (local.get $item) (i32.const 1)))))
        (i32.store8 (i32.add(i32.const 1024) (i32.sub (local.get $item) (i32.const 1))) (i32.add (local.get $inlist) (i32.const 1)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $totalloop)
      ))
    )
    (return (call $measure (i32.const 1024) (i32.const 0)))
  )
)