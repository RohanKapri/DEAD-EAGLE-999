import java.util.List;
class BinarySearch {
    private final List<Integer> items;
    BinarySearch(List<Integer> items) {
        this.items = items;
    }
    int indexOf(int item) throws ValueNotFoundException {
        int left = 0, right = items.size() - 1;
        while (left <= right) {
            int middle = (left + right) / 2;
            int middleItem = items.get(middle);
            if (item == middleItem) {
                return middle;
            } else if (item > middleItem) {
                left = middle + 1;
            } else {
                right = middle - 1;
            }
        }
        throw new ValueNotFoundException("Value not in array");
    }
}
