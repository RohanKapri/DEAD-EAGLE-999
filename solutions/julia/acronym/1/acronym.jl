function acronym(phrase)
    join(uppercase.(first.(split(
        replace(phrase, "-"=>" ", r"[^a-zA-Z ]" => "")), 1)))
end