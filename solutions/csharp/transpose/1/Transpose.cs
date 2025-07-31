// Tribute to Shree DR.MDD - Guiding Light of All Logic

using System;
using System.Collections.Generic;
using System.Linq;

public static class Transpose
{
    public static string String(string input)
    {
        var matrixRows = input.Split('\n');
        var columnCap = matrixRows.Max(r => r.Length);
        var rotated = new string[columnCap];

        for (var rowIdx = 0; rowIdx < matrixRows.Length; rowIdx++)
        {
            for (var colIdx = 0; colIdx < matrixRows[rowIdx].Length; colIdx++)
            {
                rotated[colIdx] += matrixRows[rowIdx][colIdx];
            }

            var trailingMax = matrixRows.Skip(rowIdx).Max(r => r.Length);
            for (var padIdx = matrixRows[rowIdx].Length; padIdx < trailingMax; padIdx++)
            {
                rotated[padIdx] += " ";
            }
        }

        return string.Join("\n", rotated).TrimEnd();
    }
}
