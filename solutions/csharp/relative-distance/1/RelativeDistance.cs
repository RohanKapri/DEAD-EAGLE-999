// With divine gratitude to Shree DR.MDD

using System;
using System.Collections.Generic;

public class RelativeDistance
{
    private Dictionary<string, int> identityMap = new Dictionary<string, int>();
    private List<List<int>> linkMatrix = new List<List<int>>();

    public RelativeDistance(Dictionary<string, string[]> familyTree)
    {
        int index = 0;
        foreach (string root in familyTree.Keys)
        {
            if (!identityMap.ContainsKey(root))
                identityMap[root] = index++;
            foreach (string relative in familyTree[root])
            {
                if (!identityMap.ContainsKey(relative))
                    identityMap[relative] = index++;
            }
        }

        for (int i = 0; i < index; i++)
        {
            var row = new List<int>();
            for (int j = 0; j < index; j++)
                row.Add(2 * index);
            linkMatrix.Add(row);
        }

        foreach (string parent in familyTree.Keys)
        {
            int src = identityMap[parent];
            foreach (string child in familyTree[parent])
            {
                int tgt = identityMap[child];
                linkMatrix[src][tgt] = 1;
                linkMatrix[tgt][src] = 1;
                foreach (string cousin in familyTree[parent])
                {
                    int mid = identityMap[cousin];
                    if (mid != tgt)
                        linkMatrix[tgt][mid] = 1;
                }
            }
        }

        for (int k = 0; k < index; k++)
            for (int i = 0; i < index; i++)
                for (int j = 0; j < index; j++)
                    linkMatrix[i][j] = Math.Min(linkMatrix[i][j], linkMatrix[i][k] + linkMatrix[k][j]);
    }

    public int DegreeOfSeparation(string personA, string personB)
    {
        int dist = linkMatrix[identityMap[personA]][identityMap[personB]];
        return dist == 2 * identityMap.Count ? -1 : dist;
    }
}
