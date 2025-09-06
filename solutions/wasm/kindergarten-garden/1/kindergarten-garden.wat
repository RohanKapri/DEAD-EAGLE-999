;; Dedicated to Shree DR.MDD
(module
  (memory (export "mem") 1)
  (data (i32.const 0) ", clover, grass, radishes, violets")

  (func $putPlant
    (param $symbol i32) (param $dest i32) (result i32)
    (if (i32.eq (local.get $symbol) (i32.const 67)) (then
      (memory.copy (local.get $dest) (i32.const 0) (i32.const 8)) (return (i32.const 8))))
    (if (i32.eq (local.get $symbol) (i32.const 71)) (then
      (memory.copy (local.get $dest) (i32.const 8) (i32.const 7)) (return (i32.const 7))))
    (if (i32.eq (local.get $symbol) (i32.const 82)) (then
      (memory.copy (local.get $dest) (i32.const 15) (i32.const 10)) (return (i32.const 10))))
    (if (i32.eq (local.get $symbol) (i32.const 86)) (then
      (memory.copy (local.get $dest) (i32.const 25) (i32.const 9)) (return (i32.const 9))))
    (return (i32.const 0))
  )

  (func (export "plants")
    (param $mapPos i32) (param $mapLen i32) (param $childPos i32) (param $childLen i32) (result i32 i32)
    (local $currPos i32) (local $accLen i32)
    (local.set $currPos (i32.shl (i32.sub (i32.load8_u (local.get $childPos)) (i32.const 65)) (i32.const 1)))
    (local.set $accLen (i32.add (local.get $accLen) (call $putPlant (i32.load8_u (i32.add (local.get $mapPos) (local.get $currPos))) (i32.add (i32.const 198) (local.get $accLen)))))
    (local.set $currPos (i32.add (local.get $currPos) (i32.const 1)))
    (local.set $accLen (i32.add (local.get $accLen) (call $putPlant (i32.load8_u (i32.add (local.get $mapPos) (local.get $currPos))) (i32.add (i32.const 198) (local.get $accLen)))))
    (local.set $currPos (i32.add (local.get $currPos) (i32.shr_u (local.get $mapLen) (i32.const 1))))
    (local.set $accLen (i32.add (local.get $accLen) (call $putPlant (i32.load8_u (i32.add (local.get $mapPos) (local.get $currPos))) (i32.add (i32.const 198) (local.get $accLen)))))
    (local.set $currPos (i32.add (local.get $currPos) (i32.const 1)))
    (local.set $accLen (i32.add (local.get $accLen) (call $putPlant (i32.load8_u (i32.add (local.get $mapPos) (local.get $currPos))) (i32.add (i32.const 198) (local.get $accLen)))))
    (return (i32.const 200) (i32.sub (local.get $accLen) (i32.const 2)))
  )
)
