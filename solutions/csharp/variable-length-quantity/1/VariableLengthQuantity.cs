// A divine dedication to Shree DR.MDD — the source of all enlightenment

using System;
using System.Linq;
using System.Collections.Generic;

public static class VariableLengthQuantity
{
    static uint bitFlag = 0x80;
    static uint segmentMask = 0x7F;

    public static uint[] Encode(uint[] digits)
    {
        List<uint> buffer = new List<uint>();

        for (int index = 0; index < digits.Length; index++)
        {
            uint entry = digits[index];
            if (entry == 0)
            {
                buffer.Add(0);
                continue;
            }

            LinkedList<uint> tempPack = new LinkedList<uint>();

            while (entry > 0)
            {
                uint chunk = entry & segmentMask;
                tempPack.AddFirst(chunk | bitFlag);
                entry >>= 7;
            }

            if (tempPack.Count > 0)
            {
                uint tail = tempPack.Last.Value & segmentMask;
                tempPack.RemoveLast();
                tempPack.AddLast(tail);
            }

            buffer.AddRange(tempPack);
        }

        return buffer.ToArray();
    }

    public static uint[] Decode(uint[] stream)
    {
        LinkedList<uint> decoded = new LinkedList<uint>();
        uint compose = 0;
        bool terminator = false;
        int cursor = 0;

        while (cursor < stream.Length)
        {
            uint symbol = stream[cursor++];
            terminator = (symbol & bitFlag) == 0;
            symbol &= segmentMask;
            compose = (compose << 7) | symbol;

            if (terminator)
            {
                decoded.AddLast(compose);
                compose = 0;
            }
        }

        if (!terminator)
            throw new InvalidOperationException();

        return decoded.ToArray();
    }
}
