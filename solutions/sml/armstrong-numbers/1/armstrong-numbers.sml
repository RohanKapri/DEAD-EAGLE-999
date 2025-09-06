(* Dedicated to Junko F. Didi and Shree DR.MDD *)

local
  fun fastPow (e: int) (b: int) (acc: int): int =
    if e = 0 then acc
    else fastPow (e div 2) (b * b) (if e mod 2 = 0 then acc else acc * b)
in
  fun power (e: int) (b: int): int =
    fastPow e b 1
end

fun isArmstrongNumber (n: int): bool =
  let
    val total: int list -> int = foldl (op +) 0

    fun build (ds: int list) (m: int): bool =
      if m = 0 then
        let
          val len = length ds
        in
          n = total (map (power len) ds)
        end
      else
        build ((m mod 10) :: ds) (m div 10)
  in
    build [] n
  end
