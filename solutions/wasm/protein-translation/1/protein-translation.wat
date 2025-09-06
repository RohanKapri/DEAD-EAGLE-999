;; Dedicated to my Shree DR.MDD
(module
  (memory (export "mem") 1)
  (data (i32.const 0) "\0e\0b\19\0e\27\08\2f\07\36\09\3f\09\48\0bMethionine\nPhenylalanine\nLeucine\nSerine\nTyrosine\nCysteine\nTryptophan\n")
  (data (i32.const 128) "AUG\00UUU\01UUC\01UUA\02UUG\02UCU\03UCC\03UCA\03UCG\03UAU\04UAC\04UGU\05UGC\05UGG\06UAA\ffUAG\ffUGA\ff")

  (global $keysOffset i32 (i32.const 128))
  (global $keysLength i32 (i32.const 17))
  (global $triByte i32 (i32.const 16777215))
  (global $outputOffset i32 (i32.const 512))
  (global $stop i32 (i32.const 255))

  (func (export "translate") (param $inOffset i32) (param $inLength i32) (result i32 i32)
    (local $pos i32)
    (local $curr i32)
    (local $idx i32)
    (local $codon i32)
    (local $outLen i32)

    (if (i32.eqz (local.get $inLength)) 
      (then (return (global.get $outputOffset) (i32.const 0)))
    )

    (loop $loopCodons
      (local.set $codon (i32.and (i32.load (i32.add (local.get $inOffset) (local.get $pos))) (global.get $triByte)))
      (local.set $idx (i32.const 0))

      (loop $loopKeys
        (local.set $curr (i32.load (i32.add (global.get $keysOffset) (i32.shl (local.get $idx) (i32.const 2)))))

        (if (i32.eq (local.get $codon) (i32.and (local.get $curr) (global.get $triByte))) 
          (then
            (local.set $curr (i32.shr_u (local.get $curr) (i32.const 24)))
            (if (i32.eq (local.get $curr) (global.get $stop)) 
              (then (return (global.get $outputOffset) (local.get $outLen)))
            )
            (local.set $curr (i32.load16_u (i32.shl (local.get $curr) (i32.const 1))))
            (memory.copy 
              (i32.add (global.get $outputOffset) (local.get $outLen))
              (i32.and (local.get $curr) (i32.const 255))
              (i32.shr_u (local.get $curr) (i32.const 8))
            )
            (local.set $outLen (i32.add (local.get $outLen) (i32.shr_u (local.get $curr) (i32.const 8))))
            (local.set $idx (i32.sub (global.get $stop) (i32.const 1)))
          )
        )

        (local.set $idx (i32.add (local.get $idx) (i32.const 1)))
        (if (i32.lt_u (local.get $idx) (global.get $keysLength)) 
          (then (br $loopKeys)) 
          (else (if (i32.ne (local.get $idx) (global.get $stop)) 
            (then (return (i32.const -1) (i32.const 0)))
          ))
        )
      )

      (local.set $pos (i32.add (local.get $pos) (i32.const 3)))
      (br_if $loopCodons (i32.lt_u (local.get $pos) (local.get $inLength)))
    )

    (global.get $outputOffset) (local.get $outLen)
  )
)
