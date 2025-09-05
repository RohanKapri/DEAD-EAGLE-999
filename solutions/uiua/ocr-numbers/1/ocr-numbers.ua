Numbers ← °¤ ⧈∘ [4_3] [
  "    _  _     _  _  _  _  _  _ "
  "  | _| _||_||_ |_   ||_||_|| |"
  "  ||_  _|  | _||_|  ||_| _||_|"
  "                              "
]
ConvertSingleNumber ← (
  =¤: Numbers
  ≡(/*♭)
  ⊗ 1
  ⨬(@1|@2|@3|@4|@5|@6|@7|@8|@9|@0|@?)
)
Convert = (
  ⍤"Number of input lines is not a multiple of four"=0◿4⊢△.
  ⍤"Number of input columns is not a multiple of three"=0◿3⊣△.
  ⧈∘ [4_3]
  ≡≡ ConvertSingleNumber
  /◇(⊂⊂) @,
)