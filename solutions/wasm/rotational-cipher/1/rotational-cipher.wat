;; For Shree DR.MDD
(module
  (memory (export "mem") 1)
  (export "memory" (memory 0))

  (func (export "rotate") (param $txtOffset i32) (param $txtLen i32) (param $key i32) (result i32 i32)
    (local $idx i32)
    (local $sym i32)
    (local $newSym i32)
    (local $lowA i32)
    (local $upA i32)
    (local $lowZ i32)
    (local $upZ i32)

    (local.set $lowA (i32.const 97))
    (local.set $upA (i32.const 65))
    (local.set $lowZ (i32.const 122))
    (local.set $upZ (i32.const 90))

    (local.set $idx (i32.const 0))
    (block $exit
      (loop $iterate
        (br_if $exit (i32.ge_u (local.get $idx) (local.get $txtLen)))

        (local.set $sym (i32.load8_u (i32.add (local.get $txtOffset) (local.get $idx))))

        (if (i32.and (i32.ge_u (local.get $sym) (local.get $lowA))
                     (i32.le_u (local.get $sym) (local.get $lowZ)))
          (then
            (local.set $newSym 
              (i32.add (local.get $lowA)
                (i32.rem_u (i32.add (i32.sub (local.get $sym) (local.get $lowA)) (local.get $key))
                           (i32.const 26)))))
          (else
            (if (i32.and (i32.ge_u (local.get $sym) (local.get $upA))
                         (i32.le_u (local.get $sym) (local.get $upZ)))
              (then
                (local.set $newSym 
                  (i32.add (local.get $upA)
                    (i32.rem_u (i32.add (i32.sub (local.get $sym) (local.get $upA)) (local.get $key))
                               (i32.const 26)))))
              (else
                (local.set $newSym (local.get $sym))
              )
            )
          )
        )

        (i32.store8 (i32.add (local.get $txtOffset) (local.get $idx)) (local.get $newSym))
        (local.set $idx (i32.add (local.get $idx) (i32.const 1)))
        (br $iterate)
      )
    )

    (return (local.get $txtOffset) (local.get $txtLen))
  )
)
