(module
  (memory (export "mem") 1)
  (data (i32.const 0) "\00\01\03\03\02\01\04\02\04\01\08\05\01\03\01\01\03\0a\01\01\01\01\04\04\08\04\0a")

  ;;
  ;; Given a word, compute the Scrabble score for that word
  ;;
  ;; @param {i32} offset - The offset of the input string in linear memory
  ;; @param {i32} length - The length of the input string in linear memory
  ;;
  ;; @returns {i32} - the computed score
  ;;
  (func (export "score") (param $offset i32) (param $length i32) (result i32)
    (local $score i32) (local $pos i32)
    (loop $chars
      (local.set $score (i32.add (local.get $score)
        (i32.load8_u (i32.and (i32.load8_u (i32.add (local.get $offset) (local.get $pos))) (i32.const 31)))))
      (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
    (br_if $chars (i32.lt_u (local.get $pos) (local.get $length))))
    (return (local.get $score))
  )
)