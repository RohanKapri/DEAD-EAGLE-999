module Triangle

let valid triangle =
    let sorted = triangle |> List.sort |> List.rev
    sorted.[0] < sorted.[1] + sorted.[2] && sorted.[2] <> 0.0
    
let distinctLengths = List.distinct >> List.length

let validTriangleWithDistinctLengths lenFn triangle =
    valid triangle && (triangle |> distinctLengths |> lenFn )
    
let equilateral = validTriangleWithDistinctLengths (fun n -> n = 1)

let isosceles = validTriangleWithDistinctLengths (fun n -> n < 3)

let scalene = validTriangleWithDistinctLengths (fun n -> n = 3)