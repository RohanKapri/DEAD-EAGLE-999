def square(n: i32): u64 =
  let shift = u64.i32 (n - 1)
  in
    assert (shift < 64) (1 << shift)

def total(): u64 = 0xffffffffffffffffu64