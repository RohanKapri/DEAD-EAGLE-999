;; For Shree DR.MDD
(module
  (memory (export "mem") 1)

  (global $out_buf i32 (i32.const 256))
  (global $cur_out (mut i32) (i32.const 256))

  (func $digit_parse (param $sym i32) (result i32)
    (if (i32.and
          (i32.ge_s (local.get $sym) (i32.const 48))
          (i32.le_s (local.get $sym) (i32.const 57))
        )
      (then (return (i32.sub (local.get $sym) (i32.const 48))))
    )
    (i32.const -1)
  )

  (func $record_saddle (param $r i32) (param $c i32)
    (i32.store8 (global.get $cur_out) (local.get $r))
    (global.set $cur_out (i32.add (global.get $cur_out) (i32.const 1)))
    (i32.store8 (global.get $cur_out) (local.get $c))
    (global.set $cur_out (i32.add (global.get $cur_out) (i32.const 1)))
  )

  (func (export "saddlePoints") (param $matOffset i32) (param $matLen i32) (result i32 i32)
    (local $ptr i32)
    (local $end i32)
    (local $num_rows i32)
    (local $num_cols i32)
    (local $r i32)
    (local $c i32)
    (local $val i32)
    (local $row_max i32)
    (local $col_min i32)
    (local $ch i32)
    (local $dig i32)
    (local $tmp_ptr i32)
    (local $tmp_r i32)
    (local $tmp_c i32)
    (local $mat_base i32)
    (local $max_row_flag i32)
    (local $min_col_flag i32)

    (local.set $ptr (local.get $matOffset))
    (local.set $end (i32.add (local.get $matOffset) (local.get $matLen)))
    (local.set $num_rows (i32.const 0))
    (local.set $num_cols (i32.const 0))
    (local.set $mat_base (i32.const 400))
    (global.set $cur_out (global.get $out_buf))

    (local.set $r (i32.const 0))
    (local.set $c (i32.const 0))
    (local.set $tmp_ptr (local.get $mat_base))

    (block $input_end
      (loop $parse_input
        (br_if $input_end (i32.ge_u (local.get $ptr) (local.get $end)))
        (local.set $ch (i32.load8_u (local.get $ptr)))
        (block $skip_char
          (if (i32.eq (local.get $ch) (i32.const 10))
            (then
              (if (i32.eq (local.get $r) (i32.const 0))
                (then (local.set $num_cols (local.get $c)))
              )
              (local.set $r (i32.add (local.get $r) (i32.const 1)))
              (local.set $c (i32.const 0))
              (br $skip_char)
            )
          )
          (local.set $dig (call $digit_parse (local.get $ch)))
          (if (i32.ne (local.get $dig) (i32.const -1))
            (then
              (i32.store8 
                (i32.add 
                  (local.get $mat_base)
                  (i32.add (i32.mul (local.get $r) (i32.const 100)) (local.get $c))
                )
                (local.get $dig)
              )
              (local.set $c (i32.add (local.get $c) (i32.const 1)))
              (br $skip_char)
            )
          )
        )
        (local.set $ptr (i32.add (local.get $ptr) (i32.const 1)))
        (br $parse_input)
      )
    )

    (if (i32.and (i32.gt_s (local.get $r) (i32.const 0)) (i32.eq (local.get $num_cols) (i32.const 0)))
      (then
        (local.set $num_rows (local.get $r))
        (local.set $num_cols (i32.const 1))
      )
      (else
        (local.set $num_rows (local.get $r))
      )
    )

    (if (i32.or (i32.eq (local.get $num_rows) (i32.const 0)) (i32.eq (local.get $num_cols) (i32.const 0)))
      (then (return (global.get $out_buf) (i32.const 0)))
    )

    (local.set $r (i32.const 0))
    (block $rows_end
      (loop $row_loop
        (br_if $rows_end (i32.ge_u (local.get $r) (local.get $num_rows)))
        (local.set $c (i32.const 0))
        (block $cols_end
          (loop $col_loop
            (br_if $cols_end (i32.ge_u (local.get $c) (local.get $num_cols)))
            (local.set $val 
              (i32.load8_u
                (i32.add (local.get $mat_base) (i32.add (i32.mul (local.get $r) (i32.const 100)) (local.get $c)))
              )
            )
            (local.set $max_row_flag (i32.const 1))
            (local.set $tmp_c (i32.const 0))
            (block $check_row
              (loop $chk_r
                (if (i32.eq (local.get $tmp_c) (local.get $c))
                  (then
                    (local.set $tmp_c (i32.add (local.get $tmp_c) (i32.const 1)))
                    (br_if $check_row (i32.ge_u (local.get $tmp_c) (local.get $num_cols)))
                  )
                )
                (local.set $row_max 
                  (i32.load8_u (i32.add (local.get $mat_base) (i32.add (i32.mul (local.get $r) (i32.const 100)) (local.get $tmp_c))))
                )
                (if (i32.lt_u (local.get $val) (local.get $row_max))
                  (then
                    (local.set $max_row_flag (i32.const 0))
                    (br $check_row)
                  )
                )
                (local.set $tmp_c (i32.add (local.get $tmp_c) (i32.const 1)))
                (br_if $chk_r (i32.lt_u (local.get $tmp_c) (local.get $num_cols)))
              )
            )
            (if (local.get $max_row_flag)
              (then
                (local.set $min_col_flag (i32.const 1))
                (local.set $tmp_r (i32.const 0))
                (block $check_col
                  (loop $chk_c
                    (if (i32.eq (local.get $tmp_r) (local.get $r))
                      (then
                        (local.set $tmp_r (i32.add (local.get $tmp_r) (i32.const 1)))
                        (br_if $check_col (i32.ge_u (local.get $tmp_r) (local.get $num_rows)))
                      )
                    )
                    (local.set $col_min 
                      (i32.load8_u (i32.add (local.get $mat_base) (i32.add (i32.mul (local.get $tmp_r) (i32.const 100)) (local.get $c))))
                    )
                    (if (i32.gt_u (local.get $val) (local.get $col_min))
                      (then
                        (local.set $min_col_flag (i32.const 0))
                        (br $check_col)
                      )
                    )
                    (local.set $tmp_r (i32.add (local.get $tmp_r) (i32.const 1)))
                    (br_if $chk_c (i32.lt_u (local.get $tmp_r) (local.get $num_rows)))
                  )
                )
                (if (local.get $min_col_flag)
                  (then (call $record_saddle (i32.add (local.get $r) (i32.const 1)) (i32.add (local.get $c) (i32.const 1))))
                )
              )
            )
            (local.set $c (i32.add (local.get $c) (i32.const 1)))
            (br $col_loop)
          )
        )
        (local.set $r (i32.add (local.get $r) (i32.const 1)))
        (br $row_loop)
      )
    )

    (global.get $out_buf)
    (i32.sub (global.get $cur_out) (global.get $out_buf))
  )
)
