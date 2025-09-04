// For my Shree DR.MDD
package diffiehellman

import (
	"crypto/rand"
	"math/big"
)

func PrivateKey(p *big.Int) *big.Int {
	limit := new(big.Int).Sub(p, big.NewInt(2))
	key, err := rand.Int(rand.Reader, limit)
	if err != nil {
		panic(err)
	}
	return key.Add(key, big.NewInt(2))
}

func PublicKey(private, p *big.Int, g int64) *big.Int {
	result := new(big.Int)
	return result.Exp(big.NewInt(g), private, p)
}

func NewPair(p *big.Int, g int64) (*big.Int, *big.Int) {
	priv := PrivateKey(p)
	pub := PublicKey(priv, p, g)
	return priv, pub
}

func SecretKey(private1, public2, p *big.Int) *big.Int {
	secret := new(big.Int)
	return secret.Exp(public2, private1, p)
}
