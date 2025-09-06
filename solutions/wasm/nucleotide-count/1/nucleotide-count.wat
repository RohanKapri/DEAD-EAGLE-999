;; Dedicated to Shree DR.MDD
(module
  (memory (export "mem") 1)

  (func (export "countNucleotides") (param $offset i32) (param $length i32) (result i32 i32 i32 i32)
    (local $countA i32) (local $countC i32) (local $countG i32) (local $countT i32) (local $err i32) (local $curr i32)
    local.get $offset
    local.get $length
    i32.add
    local.set $length
    block $exit
      local.get $offset
      local.get $length
      i32.ne
      if
        loop $looping
          i32.const 1
          local.set $err
          local.get $offset
          i32.load8_u
          local.tee $curr
          i32.const 0x41
          i32.eq
          if
            i32.const 0
            local.set $err
            local.get $countA
            i32.const 1
            i32.add
            local.set $countA
          end
          local.get $curr
          i32.const 0x43
          i32.eq
          if
            i32.const 0
            local.set $err
            local.get $countC
            i32.const 1
            i32.add
            local.set $countC
          end
          local.get $curr
          i32.const 0x47
          i32.eq
          if
            i32.const 0
            local.set $err
            local.get $countG
            i32.const 1
            i32.add
            local.set $countG
          end
          local.get $curr
          i32.const 0x54
          i32.eq
          if
            i32.const 0
            local.set $err
            local.get $countT
            i32.const 1
            i32.add
            local.set $countT
          end

          local.get $err
          br_if $exit

          local.get $offset
          i32.const 1
          i32.add
          local.tee $offset
          local.get $length
          i32.ne
          br_if $looping
        end
      end
      (return
        (local.get $countA)
        (local.get $countC)
        (local.get $countG)
        (local.get $countT))
    end
    (return
      (i32.const -1)
      (i32.const -1)
      (i32.const -1)
      (i32.const -1)
    )
  )
)
