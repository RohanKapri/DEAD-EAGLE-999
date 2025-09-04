module PalindromeProducts exposing (largest, smallest, PalindromeProduct)

type alias PalindromeProduct =
    { value : Int
    , factors : List ( Int, Int )
    }


-- Check if a number is palindrome
isPalindrome : Int -> Bool
isPalindrome n =
    let
        s = String.fromInt n
    in
    s == String.reverse s


-- Find largest palindrome product with factors in [min..max]
largest : Int -> Int -> Result String (Maybe PalindromeProduct)
largest min max =
    if min > max then
        Err "min must be <= max"

    else
        let
            -- Recursive helper:
            -- a, b: current factor candidates
            -- best: current best palindrome value
            -- bestPairs: list of factor pairs producing best
            search a b best bestPairs =
                if a < min then
                    if best == 0 then
                        Nothing
                    else
                        Just { value = best, factors = bestPairs }

                else if b < min then
                    -- decrement a and reset b
                    search (a - 1) (a - 1) best bestPairs

                else
                    let
                        product = a * b
                    in
                    if product < best then
                        -- No larger palindrome possible with smaller b
                        search (a - 1) (a - 1) best bestPairs

                    else if isPalindrome product then
                        if product > best then
                            -- Found a bigger palindrome, reset pairs
                            search a (b - 1) product [(a, b)]
                        else if product == best then
                            -- Same palindrome value, add pair
                            search a (b - 1) best ((a, b) :: bestPairs)
                        else
                            search a (b - 1) best bestPairs
                    else
                        search a (b - 1) best bestPairs
        in
        case search max max 0 [] of
            Nothing -> Ok Nothing
            Just res ->
                        let
                            sortedFactors =
                                res.factors
                                    |> List.map normalizePair
                                    |> sortFactors
                        in
                        Ok (Just { res | factors = sortedFactors })



-- Find smallest palindrome product with factors in [min..max]
smallest : Int -> Int -> Result String (Maybe PalindromeProduct)
smallest min max =
    if min > max then
        Err "min must be <= max"


    else
        let
            -- Recursive helper:
            -- a, b: current factor candidates
            -- best: current best palindrome value
            -- bestPairs: list of factor pairs producing best
            search a b best bestPairs =
                if a > max then
                    if best == 0 then
                        Nothing
                    else
                        Just { value = best, factors = bestPairs }

                else if b > max then
                    -- increment a and reset b
                    search (a + 1) (a + 1) best bestPairs

                else
                    let
                        product = a * b
                    in
                    if best /= 0 && product > best then
                        -- No smaller palindrome possible with larger b
                        search (a + 1) (a + 1) best bestPairs

                    else if isPalindrome product then
                        if best == 0 || product < best then
                            -- Found smaller palindrome, reset pairs
                            search a (b + 1) product [(a, b)]
                        else if product == best then
                            -- Same palindrome value, add pair
                            search a (b + 1) best ((a, b) :: bestPairs)
                        else
                            search a (b + 1) best bestPairs
                    else
                        search a (b + 1) best bestPairs
        in
        case search min min 0 [] of
            Nothing -> Ok Nothing
            Just res ->
                        let
                            sortedFactors =
                                res.factors
                                    |> List.map normalizePair
                                    |> sortFactors
                        in
                        Ok (Just { res | factors = sortedFactors })



normalizePair : (Int, Int) -> (Int, Int)
normalizePair (a, b) =
    if a <= b then
        (a, b)
    else
        (b, a)

sortFactors : List (Int, Int) -> List (Int, Int)
sortFactors =
    List.sortWith (\(a1,b1) (a2,b2) -> compare (a1,b1) (a2,b2))