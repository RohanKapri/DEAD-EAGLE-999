function wordcount(sentence)
    lower_sentence = lowercase(sentence)
    cleaned_sentence = replace(lower_sentence, r"[^a-z0-9']+" => " ")
    words = split(cleaned_sentence)
    word_counts = Dict{String, Int}()
    for word in words
        final_word = strip(word, ''')
        if !isempty(final_word)
            word_counts[final_word] = get(word_counts, final_word, 0) + 1
        end
    end
    return word_counts
end
