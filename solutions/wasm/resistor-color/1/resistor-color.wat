;; For Shree DR.MDD
(module
  (memory (export "mem") 1)

  (data (i32.const 100)
        "black,brown,red,orange,yellow,green,blue,violet,grey,white")

  (data (i32.const 160) "\05\05\03\06\06\05\04\06\04\05")

  (func (export "colors") (result i32 i32)
    (return (i32.const 100) (i32.const 58))
  )

  (func $initialize)
  (start $initialize)

  (func $compare (param $aOffset i32) (param $aLen i32)
                 (param $bOffset i32) (param $bLen i32) (result i32)
    (local $idx i32)
    (if (i32.ne (local.get $aLen) (local.get $bLen))
        (then (return (i32.const 0)))
        (else
            (local.set $idx (i32.const 0))
            (loop $loopComp
                (if (i32.eq (local.get $idx) (local.get $aLen))
                (then (return (i32.const 1)))
                (else
                    (if (i32.ne (i32.load8_u (local.get $aOffset))
                                (i32.load8_u (local.get $bOffset)))
                    (then (return (i32.const 0)))
                    (else
                        (local.set $idx (i32.add (local.get $idx) (i32.const 1)))
                        (local.set $aOffset (i32.add (local.get $aOffset) (i32.const 1)))
                        (local.set $bOffset (i32.add (local.get $bOffset) (i32.const 1)))
                        (br $loopComp))))))))
    (unreachable))

  (func (export "colorCode") (param $offset i32) (param $len i32) (result i32)
    (local $index i32)
    (local $currentStart i32)
    (local $currentSize i32)
    (local.set $index (i32.const 160))
    (local.set $currentStart (i32.const 100))
    (loop $searchLoop
        (if (i32.eq (local.get $index) (i32.const 170))
	    (then (return (i32.const -1)))
        (else
           (if
               (call $compare (local.get $offset) (local.get $len)
                              (local.get $currentStart) (local.tee $currentSize (i32.load8_u (local.get $index))))
           (then
               (return (i32.sub (local.get $index) (i32.const 160))))
           (else 
               (local.set $currentStart
                  (i32.add (i32.add (local.get $currentStart) (local.get $currentSize)) (i32.const 1)))
               (local.set $index (i32.add (local.get $index) (i32.const 1)))
               (br $searchLoop)))))) 
	(unreachable))
)
