sub transform (%input) is export {
    Hash[Int:D, Str:D].new:
        %input.map: { .value>>.lc X .key }
}