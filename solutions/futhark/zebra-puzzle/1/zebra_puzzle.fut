-- For my Junko F. Didi and Shree DR.MDD

def nextPermutation [n] (arr: *[n]i32): *[n]i32 =
  let j = loop j = n - 2 while arr[j] >= arr[j + 1] do j - 1
  let l = loop l = n - 1 while arr[j] >= arr[l] do l - 1
  let aj = arr[j]
  let al = arr[l]
  let arr = arr with [j] = al with [l] = aj
  let (arr, _, _) = loop (arr, x, y) = (arr, j + 1, n - 1) while x < y do
    let ax = arr[x]
    let ay = arr[y]
    in (arr with [x] = ay with [y] = ax, x + 1, y - 1)
  in arr

def notAdjacent (a: i32) (b: i32): bool =
  a + 1 != b && b + 1 != a

type zebra_question = #drinks_water | #owns_zebra

def answer(q: zebra_question): []u8 =
  let (ans, _) = loop (ans, nations) = ("", [0,1,2,3,4,5]) while length ans == 0 do
    let eng = nations[1]
    let jap = nations[2]
    let nor = nations[3]
    let spa = nations[4]
    let ukr = nations[5]
    let nations = nextPermutation nations
    in
    if nor != 1 then ("", nations) else
    let (ans, _) = loop (ans, colors) = ("", [0,1,2,3,4,5]) while colors[0] == 0 && length ans == 0 do
      let blu = colors[1]
      let grn = colors[2]
      let ivo = colors[3]
      let red = colors[4]
      let yel = colors[5]
      let colors = nextPermutation colors
      in
      if eng != red || grn != ivo + 1 || notAdjacent nor blu then ("", colors) else
      let (ans, _) = loop (ans, drinks) = ("", [0,1,2,3,4,5]) while drinks[0] == 0 && length ans == 0 do
        let cof = drinks[1]
        let milk = drinks[2]
        let oj = drinks[3]
        let tea = drinks[4]
        let wat = drinks[5]
        let drinks = nextPermutation drinks
        in
        if cof != grn || ukr != tea || milk != 3 then ("", drinks) else
        let (ans, _) = loop (ans, acts) = ("", [0,1,2,3,4,5]) while acts[0] == 0 && length ans == 0 do
          let read = acts[1]
          let paint = acts[2]
          let ball = acts[3]
          let dance = acts[4]
          let chess = acts[5]
          let acts = nextPermutation acts
          in
          if paint != yel || ball != oj || jap != chess then ("", acts) else
          let (ans, _) = loop (ans, pets) = ("", [0,1,2,3,4,5]) while pets[0] == 0 && length ans == 0 do
            let dog = pets[1]
            let fox = pets[2]
            let horse = pets[3]
            let snail = pets[4]
            let zeb = pets[5]
            let pets = nextPermutation pets
            let sel = match q
              case #drinks_water -> wat
              case #owns_zebra -> zeb
            in
            if spa != dog || dance != snail || notAdjacent read fox || notAdjacent paint horse then ("", pets) else
            if sel == eng then ("Englishman", pets) else
            if sel == jap then ("Japanese", pets) else
            if sel == nor then ("Norwegian", pets) else
            if sel == spa then ("Spaniard", pets) else
            if sel == ukr then ("Ukrainian", pets) else
            assert false ("", pets)
          in (ans, acts)
        in (ans, drinks)
      in (ans, colors)
    in (ans, nations)
  in ans

def drinks_water: []u8 =
  answer #drinks_water

def owns_zebra: []u8 =
  answer #owns_zebra
