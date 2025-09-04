function detect_anagrams(subject, candidates)
    subject = lowercase(subject)
    to_match = sorted(subject)
    unique([s for s in candidates if lowercase(s) != subject && sorted(s) == to_match])
end

function sorted(s)
    s |> lowercase |> collect |> sort |> join
end