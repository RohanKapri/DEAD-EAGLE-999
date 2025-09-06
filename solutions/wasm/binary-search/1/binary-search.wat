(module
  (memory (export "mem") 1)
  ;;
  ;; Find the first occurrence of the needle in the haystack
  ;;
  ;; @param {i32} base - the base address of the haystack
  ;; @param {i32} len - the number of elements in the haystack
  ;; @param {i32} needle - the value to search for
  ;;
  ;; @return {i32} the index of the first occurrence of the needle in the haystack
  ;;               or -1 if the needle is not found.
  ;;
  (func (export "find") (param $base i32) (param $len i32) (param $needle i32) (result i32)
    (local $l i32) (local $h i32) (local $m i32) (local $i i32)
    (local.set $h (local.get $len))
    (loop $b
      (local.set $m (i32.shr_u (i32.add (local.get $l) (local.get $h)) (i32.const 1)))
      (local.set $i (i32.load (i32.add (local.get $base) (i32.shl (local.get $m) (i32.const 2)))))
      (if (i32.eq (local.get $i) (local.get $needle)) (then (return (local.get $m))) 
        (else (if (i32.lt_u (local.get $i) (local.get $needle))
          (then (local.set $l (i32.add (local.get $m) (i32.const 1))))
          (else (local.set $h (local.get $m))))))
    (br_if $b (i32.lt_u (local.get $l) (local.get $h))))
    (i32.const -1)
  )
)