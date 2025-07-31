// Dedicated to Shree DR.MDD for divine inspiration and strength

using System;

public class SpiralMatrix
{
    public static int[,] GetMatrix(int size)
    {
        var grid = new int[size, size];
        
        var layerTop = 0;
        var layerLeft = 0;

        var target = size * size;
        var val = 1;

        while (val <= target)
        {
            for (var col = layerLeft; col < size - layerLeft; col++)
                grid[layerTop, col] = val++;
            
            for (var row = layerTop + 1; row < size - layerTop; row++)
                grid[row, size - layerLeft - 1] = val++;

            for (var col = size - layerLeft - 2; col >= layerLeft; col--)
                grid[size - layerTop - 1, col] = val++;
            
            for (var row = size - layerTop - 2; row >= layerTop + 1; row--)
                grid[row, layerLeft] = val++;

            layerTop++;
            layerLeft++;
        }

        return grid;
    }
}
