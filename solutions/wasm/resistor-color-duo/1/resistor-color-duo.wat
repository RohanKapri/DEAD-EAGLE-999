(module
  (memory (export "mem") 1)

  ;;
  ;; Converts color codes, as used on resistors, to a numeric value.
  ;;
  ;; @param {i32} firstOffset - The offset of the first string in linear memory.
  ;; @param {i32} firstLength - The length of the first string in linear memory.
  ;; @param {i32} secondOffset - The offset of the second string in linear memory.
  ;; @param {i32} secondLength - The length of the second string in linear memory.
  ;;
  ;; @returns {i32} - The numeric value specified by the color codes.
  ;;
  (func (export "value")
    (param $firstOffset i32) (param $firstLength i32) (param $secondOffset i32) (param $secondLength i32) (result i32)
      (i32.add
        (i32.mul
          (i32.const 10)
          (call $colorToCode (local.get $firstOffset))
        )
        (call $colorToCode (local.get $secondOffset))
      )
  )

  (func $colorToCode (param $offset i32) (result i32)
    (local $char i32)
    (local.set $char (i32.load8_u (local.get $offset)))

    (if (result i32) (i32.eq (local.get $char) (i32.const 98))
      (then
        (local.set $char (i32.load8_u offset=2 (local.get $offset))) ;; starts with b
        (if (result i32) (i32.eq (local.get $char) (i32.const 97)) ;; is-black
          (then (i32.const 0))
          (else
            (select
              (i32.const 1) ;; brown
              (i32.const 6) ;; blue
              (i32.eq (local.get $char) (i32.const 111)) ;; is-brown
            )
          ) 
        )
      )
      (else
        (if (result i32) (i32.eq (local.get $char) (i32.const 103)) ;; starts with g
          (then 
            (select
              (i32.const 5) ;; green
              (i32.const 8) ;; grey
              (i32.eq (i32.load8_u offset=3 (local.get $offset)) (i32.const 101)) ;; is-green
            )
          )
          (else
            (select
              (i32.const 2) ;; red
              (select
                (i32.const 3) ;; orange
                (select
                  (i32.const 4) ;; yellow
                  (select
                    (i32.const 7) ;; violet
                    (i32.const 9) ;; white
                    (i32.eq (local.get $char) (i32.const 118)) ;; is-violet
                  )
                  (i32.eq (local.get $char) (i32.const 121)) ;; is-yellow
                )
                (i32.eq (local.get $char) (i32.const 111)) ;; is-orange
              )
              (i32.eq (local.get $char) (i32.const 114)) ;; is-red
            )
          )
        )
      )
    )
  )
)