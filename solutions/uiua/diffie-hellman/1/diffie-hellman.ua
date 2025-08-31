# Generate a private key
# Key ? PrimeP
GeneratePrivateKey ← |1 ⍜(-₂|⌊×⚂)

# calculate (Base^Power) mod Divisor
# it's the same calculation for PublicKey and Secret
# Result ? Divisor Base Power
Calculate ↚ |3 ◿⊃(∘|ⁿ:⋅⊙∘)

# Calculate the public key
# PublicKey ? PrimeP PrimeG PrivateKey
PublicKey ← |3 Calculate

# Calculate the secret
# Secret ? PrimeP PublicKey PrivateKey
Secret ← |3 Calculate