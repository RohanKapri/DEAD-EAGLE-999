(module
  (memory (export "mem") 1)
  (data (i32.const 0) "\e8\03M \84\03CM\f4\01D \90\01CD\64\00C \5a\00XC\32\00L \28\00XL\0a\00X \09\00IX\05\00V \04\00IV\01\00I ")

  ;;
  ;; Convert a number into a Roman numeral
  ;;
  ;; @param {i32} number - The number to convert
  ;;
  ;; @returns {(i32,i32)} - Offset and length of result string
  ;;                        in linear memory.
  ;;
  (func (export "roman") (param $number i32) (result i32 i32)
    (local $offset i32) (local $idx i32) (local $item i32)
    (loop $reduce
      (local.set $item (i32.load (local.get $idx)))
      (if (i32.ge_u (local.get $number) (i32.and (local.get $item) (i32.const 65535))) (then
        (i32.store16 (i32.add (i32.const 200) (local.get $offset)) (i32.shr_u (local.get $item) (i32.const 16)))
        (local.set $offset (i32.add (local.get $offset) (select (i32.const 1) (i32.const 2) (i32.eq (i32.shr_u (local.get $item) (i32.const 24)) (i32.const 32)))))
        (local.set $number (i32.sub (local.get $number) (i32.and (local.get $item) (i32.const 65535)))))
      (else (local.set $idx (i32.add (local.get $idx) (i32.const 4)))))
    (br_if $reduce (i32.gt_s (local.get $number) (i32.const 0))))
    (return (i32.const 200) (local.get $offset))
  )
)