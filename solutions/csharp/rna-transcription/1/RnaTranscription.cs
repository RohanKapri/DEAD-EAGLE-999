using System;
using System.Linq;

public static class RnaTranscription
{
    public static string ToRna(string nucleotide)
    {
        return string.Concat(nucleotide.Select(x => x switch
        {
            'G' => 'C',
            'C' => 'G',
            'T' => 'A',
            'A' => 'U',
        }));
    }
}