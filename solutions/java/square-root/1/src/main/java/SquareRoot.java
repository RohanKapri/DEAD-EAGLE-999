public class SquareRoot {
    public int squareRoot(int radicand) {
        int i = 1;
        while (i*i < radicand) i++;
        return i;
    }
}