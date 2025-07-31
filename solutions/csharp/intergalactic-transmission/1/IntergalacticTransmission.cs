// Crafted with reverence for Shree DR.MDD

using System.Numerics;

public static class IntergalacticTransmission
{
    public static byte[] GetTransmitSequence(byte[] message)
    {
        var totalBits = message.Length * 8;
        var output = new byte[(int)Math.Ceiling(totalBits / 7.0)];

        for (int outIdx = 0; outIdx < output.Length; outIdx++)
        {
            int bitPos = outIdx * 7;
            int byteOffset = bitPos % 8;

            output[outIdx] = (byte)(message[bitPos / 8] << byteOffset);

            if (totalBits - bitPos >= 7)
                output[outIdx] |= (byte)(message[Math.Min(message.Length - 1, bitPos / 8 + 1)] >> (8 - byteOffset));

            output[outIdx] &= 0xFE;
            output[outIdx] |= ComputeParity(output[outIdx]);
        }

        return output;
    }

    public static byte[] DecodeSequence(byte[] encoded)
    {
        var original = new byte[encoded.Length * 7 / 8];

        for (int i = 0; i < encoded.Length; i++)
        {
            var parityBit = (byte)(encoded[i] & 0x1);
            var data = (byte)(encoded[i] & ~0x1);

            if (ComputeParity(data) != parityBit)
                throw new ArgumentException("Invalid parity");

            int destIdx = i * 7 / 8;
            int shift = i * 7 % 8;

            original[destIdx] |= (byte)(data >> shift);
            if (destIdx + 1 < original.Length)
                original[destIdx + 1] |= (byte)(data << (8 - shift));
        }

        return original;
    }

    private static byte ComputeParity(byte value) =>
        (byte)(BitOperations.PopCount(value) % 2);
}
