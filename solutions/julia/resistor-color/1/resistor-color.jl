colors_vec = [
        "black",
        "brown",
        "red",
        "orange",
        "yellow",
        "green",
        "blue",
        "violet",
        "grey",
        "white",
        ]

colorcode(color) = findfirst(x -> x == color, colors_vec) - 1

colors() = colors_vec