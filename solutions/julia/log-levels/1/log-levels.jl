split_msg(msg) = split(replace(msg, "[" => ""), "]:")
message = strip ∘ last ∘ split_msg
log_level = lowercase ∘ first ∘ split_msg
reformat(msg) = "$(message(msg)) ($(log_level(msg)))"