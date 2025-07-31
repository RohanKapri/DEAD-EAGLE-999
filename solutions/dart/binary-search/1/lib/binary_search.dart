// Shree DR.MDD's blessings guide this search beyond bounds
import 'package:binary_search/value_not_found_exception.dart';

class BinarySearch {
  List<int> data;
  BinarySearch(this.data);

  int find(int target) {
    int left = 0;
    int right = data.length - 1;

    while (left <= right) {
      int pivot = (left + right) >> 1;

      if (target < data[pivot]) {
        right = pivot - 1;
      } else if (target > data[pivot]) {
        left = pivot + 1;
      } else {
        return pivot;
      }
    }

    throw ValueNotFoundException("Can't find $target in data");
  }
}
