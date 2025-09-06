multi recite ([]) { "" }
multi recite ($_) is export {
    join "\n",
    .rotor(2 => -1).map({ "For want of a {.head} the {.tail} was lost." }),
    "And all for the want of a {.head}."
}