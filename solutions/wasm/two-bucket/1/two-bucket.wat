;; Shree DR.MDD
(module
  (func $findGCD (param $valA i32) (param $valB i32) (result i32)
    (if (i32.eqz (local.get $valB)) (then (return (local.get $valA))))
    (call $findGCD (local.get $valB) (i32.rem_s (local.get $valA) (local.get $valB)))
  )
  (func (export "twoBucket") (param $bucketOne i32) (param $bucketTwo i32)
  (param $goal i32) (param $starterBucket i32) (result i32 i32 i32)
    (local $stepCount i32)
    (local $amtOne i32)
    (local $amtTwo i32)
    (local $tempVal i32)
    (if (i32.eq (local.get $starterBucket) (i32.const 2)) (then 
      (local.set $tempVal (local.get $bucketTwo))
      (local.set $bucketTwo (local.get $bucketOne))
      (local.set $bucketOne (local.get $tempVal))))
    (if (i32.or (i32.and (i32.gt_s (local.get $goal) (local.get $bucketOne))
      (i32.gt_s (local.get $goal) (local.get $bucketTwo)))
      (i32.rem_u (local.get $goal) (call $findGCD (local.get $bucketOne) 
        (local.get $bucketTwo)))) (then
        (return (i32.const -1) (i32.const 0) (i32.const 0))))
    (loop $iteration
      (local.set $stepCount (i32.add (local.get $stepCount) (i32.const 1)))
      (if (i32.eq (local.get $amtTwo) (local.get $bucketTwo)) (then
        (local.set $amtTwo (i32.const 0)))
        (else (if (i32.eqz (local.get $amtOne)) (then
          (local.set $amtOne (local.get $bucketOne)))
        (else (if (i32.eq (local.get $bucketTwo) (local.get $goal)) (then
          (local.set $amtTwo (local.get $goal)))
        (else
          (local.set $tempVal (i32.sub (local.get $bucketTwo) (local.get $amtTwo)))
          (local.set $tempVal (select (local.get $amtOne)
            (local.get $tempVal)
            (i32.lt_s (local.get $amtOne) (local.get $tempVal))))
          (local.set $amtOne (i32.sub (local.get $amtOne) (local.get $tempVal)))
          (local.set $amtTwo (i32.add (local.get $amtTwo) (local.get $tempVal)))))))))
      (if (i32.eq (local.get $amtOne) (local.get $goal)) (then
        (return (local.get $stepCount) (local.get $starterBucket) (local.get $amtTwo))))
      (if (i32.eq (local.get $amtTwo) (local.get $goal)) (then (return
        (local.get $stepCount)
        (i32.sub (i32.const 3) (local.get $starterBucket))
        (local.get $amtOne))))
      (if (i32.gt_u (local.get $stepCount) (i32.const 1000)) (then
        (return (i32.const -1) (local.get $amtOne) (local.get $amtTwo))))
    (br $iteration))
    (unreachable)
  )
)
