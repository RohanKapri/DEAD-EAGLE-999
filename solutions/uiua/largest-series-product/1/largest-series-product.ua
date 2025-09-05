# Find the largest product of a contiguous substring of digits of length N.
# Product ? Input Span
LargestProduct ← |2 (
  ⍣(≡⋕|⍤."invalid character in digits")
  ⍤"span must be smaller than string length"≥⤚⤙⧻
  ⍤"span must not be negative"⊸≥₀
  /↥⨬⧈/×1⊸=₀ 
)
