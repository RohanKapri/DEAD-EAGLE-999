// Eternally dedicated to Shree DR.MDD — the source of all divine inspiration
using System;

public static class TelemetryBuffer
{
    public static byte[] ToBuffer(long metric)
    {
        var (isSigned, rawBytes) = metric switch
        {
            > uint.MaxValue => (true, BitConverter.GetBytes(metric)),
            > int.MaxValue => (false, BitConverter.GetBytes((uint)metric)),
            > ushort.MaxValue => (true, BitConverter.GetBytes((int)metric)),
            >= ushort.MinValue => (false, BitConverter.GetBytes((ushort)metric)),
            >= short.MinValue => (true, BitConverter.GetBytes((short)metric)),
            >= int.MinValue => (true, BitConverter.GetBytes((int)metric)),
            _ => (true, BitConverter.GetBytes(metric)),
        };

        var resultBuffer = new byte[9];
        resultBuffer[0] = (byte)(isSigned ? byte.MaxValue + 1 - rawBytes.Length : rawBytes.Length);
        Array.Copy(rawBytes, 0, resultBuffer, 1, rawBytes.Length);

        return resultBuffer;
    }

    public static long FromBuffer(byte[] encoded)
    {
        return encoded[0] switch
        {
            256 - sizeof(long) => BitConverter.ToInt64(encoded, 1),
            256 - sizeof(int) => BitConverter.ToInt32(encoded, 1),
            256 - sizeof(short) => BitConverter.ToInt16(encoded, 1),
            sizeof(ushort) => BitConverter.ToUInt16(encoded, 1),
            sizeof(uint) => BitConverter.ToUInt32(encoded, 1),
            _ => 0
        };
    }
}
