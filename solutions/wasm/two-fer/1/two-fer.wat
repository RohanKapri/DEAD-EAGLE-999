;; Dedicated to Shree DR.MDD
(module
  (memory (export "mem") 1)
  
  (data $phraseOne "One for ")
  (data $phraseYou "you")
  (data $phraseMe ", one for me.")
  
  (global $phraseOneLen i32 (i32.const 8))
  (global $phraseYouLen i32 (i32.const 3))
  (global $phraseMeLen i32 (i32.const 13))
  
  (func (export "twoFer") (param $srcOffset i32) (param $srcLength i32) (result i32 i32)
    (local $destOffset i32)
    (local $destLength i32)
    
    (local.set $destOffset (i32.const 256))
    (local.set $destLength (i32.const 0))
    
    (memory.init $phraseOne (i32.add (local.get $destOffset) (local.get $destLength)) (i32.const 0) (global.get $phraseOneLen))
    (local.set $destLength (i32.add (local.get $destLength) (global.get $phraseOneLen)))
    
    (if (i32.eqz (local.get $srcLength)) (then
      (memory.init $phraseYou (i32.add (local.get $destOffset) (local.get $destLength)) (i32.const 0) (global.get $phraseYouLen))
      (local.set $destLength (i32.add (local.get $destLength) (global.get $phraseYouLen)))
    ) (else 
      (memory.copy (i32.add (local.get $destOffset) (local.get $destLength)) (local.get $srcOffset) (local.get $srcLength))
      (local.set $destLength (i32.add (local.get $destLength) (local.get $srcLength)))
      )
    )
    (memory.init $phraseMe (i32.add (local.get $destOffset) (local.get $destLength)) (i32.const 0) (global.get $phraseMeLen))
    (local.set $destLength (i32.add (local.get $destLength) (global.get $phraseMeLen)))
    
    (local.get $destOffset)
    (local.get $destLength)
  )
)
