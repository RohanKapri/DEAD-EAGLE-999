;; Dedicated to my Shree DR.MDD
(module
	(memory (export "mem") 1)

	(func (export "evaluate") (param $dir i32) (param $posX i32) (param $posY i32)
		(param $instrOffset i32) (param $instrLength i32) (result i32 i32 i32)
		(local $idx i32) (local $cmd i32)

		(loop $loopInstr
			(local.set $cmd (i32.load8_u (i32.add (local.get $instrOffset) (local.get $idx))))
			
			(if (i32.eq (local.get $cmd) (i32.const 65)) ;; A
				(then
					(local.set $posX (i32.add (local.get $posX)
						(i32.rem_s (i32.sub (i32.const 2) (local.get $dir)) (i32.const 2))))
					(local.set $posY (i32.add (local.get $posY)
						(i32.rem_s (i32.sub (i32.const 1) (local.get $dir)) (i32.const 2)))))
			(else
				(if (i32.eq (local.get $cmd) (i32.const 76)) ;; L
					(then (local.set $dir (i32.rem_u (i32.add (local.get $dir) (i32.const 3)) (i32.const 4))))
				(else
					(if (i32.eq (local.get $cmd) (i32.const 82)) ;; R
						(then (local.set $dir (i32.rem_u (i32.add (local.get $dir) (i32.const 1)) (i32.const 4))))
					(else (return (i32.const -1) (local.get $posX) (local.get $posY))))
				))
			))

			(local.set $idx (i32.add (local.get $idx) (i32.const 1)))
			(br_if $loopInstr (i32.lt_u (local.get $idx) (local.get $instrLength)))
		)

		(local.get $dir) (local.get $posX) (local.get $posY)
	)
)
