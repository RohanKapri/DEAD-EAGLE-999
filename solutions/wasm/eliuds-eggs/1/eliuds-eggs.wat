(module
  ;;
  ;; count the number of 1 bits in the binary representation of a number
  ;;
  ;; @param {i32} number - the number to count the bits of
  ;;
  ;; @returns {i32} the number of 1 bits in the binary representation of the number
  ;;
  (func (export "eggCount") (param $number i32) (result i32)
    (local $count i32)
    (local $n i32)
    ;; Initialize local variables
    (local.set $count (i32.const 0))
    (local.set $n (local.get $number))
    ;; Loop to count the number of 1 bits
    (block $break
      (loop $loop
        ;; If $n is zero, break the loop
        (br_if $break (i32.eqz (local.get $n)))
        ;; Increment count if the least significant bit is 1
        (local.set $count
          (i32.add (local.get $count)
                   (i32.and (local.get $n) (i32.const 1))
          )
        )
        ;; Right shift $n by 1 to check the next bit
        (local.set $n
          (i32.shr_u (local.get $n) (i32.const 1))
        )
        ;; Continue the loop
        (br $loop)
      )
    )
    ;; Return the count of 1 bits
    (local.get $count)
  )
)