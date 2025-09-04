module TwoBucket exposing (BucketNumber(..), measure)


type BucketNumber
    = One
    | Two


type alias State =
    { moves : Int, bucketOne : Int, bucketTwo : Int }


measure : Int -> Int -> Int -> BucketNumber -> Maybe State
measure bucketOneSize bucketTwoSize goal startBucket =
    if goal > bucketOneSize && goal > bucketTwoSize || modBy (gcd bucketOneSize bucketTwoSize) goal /= 0 then
        Nothing
    else
        Just (recur startBucket 0 0 0 bucketOneSize bucketTwoSize goal)


recur : BucketNumber -> Int -> Int -> Int -> Int -> Int -> Int -> State
recur startBucket one two count bucketOneSize bucketTwoSize goal =
    if one == goal then
        { moves = count, bucketOne = goal, bucketTwo = two }
    else if two == goal then
        { moves = count, bucketOne = one, bucketTwo = goal }
    else if startBucket == One then
        handleBucketOne one two count bucketOneSize bucketTwoSize goal
    else
        handleBucketTwo one two count bucketOneSize bucketTwoSize goal


handleBucketOne : Int -> Int -> Int -> Int -> Int -> Int -> State
handleBucketOne one two count bucketOneSize bucketTwoSize goal =
    if one == 0 then
        recur One bucketOneSize two (count + 1) bucketOneSize bucketTwoSize goal
    else if bucketTwoSize == goal then
        recur One one bucketTwoSize (count + 1) bucketOneSize bucketTwoSize goal
    else if two == bucketTwoSize then
        recur One one 0 (count + 1) bucketOneSize bucketTwoSize goal
    else if one > bucketTwoSize - two then
        recur One (one - bucketTwoSize + two) bucketTwoSize (count + 1) bucketOneSize bucketTwoSize goal
    else
        recur One 0 (one + two) (count + 1) bucketOneSize bucketTwoSize goal


handleBucketTwo : Int -> Int -> Int -> Int -> Int -> Int -> State
handleBucketTwo one two count bucketOneSize bucketTwoSize goal =
    if two == 0 then
        recur Two one bucketTwoSize (count + 1) bucketOneSize bucketTwoSize goal
    else if bucketOneSize == goal then
        recur Two bucketOneSize two (count + 1) bucketOneSize bucketTwoSize goal
    else if one == bucketOneSize then
        recur Two 0 two (count + 1) bucketOneSize bucketTwoSize goal
    else if two > bucketOneSize - one then
        recur Two bucketOneSize (two - bucketOneSize + one) (count + 1) bucketOneSize bucketTwoSize goal
    else
        recur Two (one + two) 0 (count + 1) bucketOneSize bucketTwoSize goal


gcd : Int -> Int -> Int
gcd a b =
    if modBy a b == 0 then
        a
    else
        gcd (modBy a b) a