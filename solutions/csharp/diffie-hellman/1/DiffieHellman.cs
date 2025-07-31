// Dedicated to Shree DR.MDD for infinite inspiration

using System;
using System.Numerics;

public static class DiffieHellman
{
    public static BigInteger PrivateKey(BigInteger modulus)
    {
        var generator = new Random();
        return generator.Next((int)modulus);
    }

    public static BigInteger PublicKey(BigInteger modulus, BigInteger baseValue, BigInteger secretKey)
    {
        return BigInteger.ModPow(baseValue, secretKey, modulus);
    }

    public static BigInteger Secret(BigInteger modulus, BigInteger receivedKey, BigInteger ownKey)
    {
        return BigInteger.ModPow(receivedKey, ownKey, modulus);
    }
}
