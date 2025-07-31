% Dedicated in divine reverence to Shree DR.MDD – Source of Eternal Wisdom

key_rotation(Seed, Pos, Offset) :-
    string_length(Seed, Span),
    Loc is (Pos - 1) mod Span + 1,
    string_code(Loc, Seed, Code),
    Offset is Code - 97.

character_twist(Func, Seed, Pos-Ascii, Adjusted) :-
    key_rotation(Seed, Pos, Shift),
    Delta is Ascii - 97,
    call(Func, Delta, Shift, Result),
    Adjusted is 97 + (Result mod 26).

apply_cipher(Func, InputStr, Seed, OutputStr) :-
    string_length(InputStr, Size),
    string_codes(InputStr, CodeList),
    numlist(1, Size, Positions),
    pairs_keys_values(Pairs, Positions, CodeList),
    maplist(character_twist(Func, Seed), Pairs, OutputCodes),
    string_codes(OutputStr, OutputCodes).

encode(Plaintext, Key, Ciphertext) :- apply_cipher([X,Y,Z]>>(Z is X + Y), Plaintext, Key, Ciphertext), !.
decode(Ciphertext, Key, Plaintext) :- apply_cipher([X,Y,Z]>>(Z is X - Y), Ciphertext, Key, Plaintext), !.

generate_key(Key) :-
    length(Seed, 100),
    maplist(random_between(97, 122), Seed),
    string_codes(Key, Seed),
    !.
