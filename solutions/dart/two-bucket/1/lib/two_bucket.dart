import 'dart:math';

const bucketOne = 'one', bucketTwo = 'two';

class _Buckets {
  _Buckets(this.capacityOne, this.capacityTwo, this.startBucket);

  final int capacityOne, capacityTwo;
  var one = 0, two = 0;
  final String startBucket;

  bool get forbiddenState {
    if (startBucket == bucketOne && one == 0 && two == capacityTwo) return true;
    if (startBucket == bucketTwo && two == 0 && one == capacityTwo) return true;

    return false;
  }

  bool get startBucketIsEmpty =>
      (startBucket == bucketOne) ? one == 0 : two == 0;

  bool get nonStartBucketIsFull =>
      (startBucket == bucketOne) ? two == capacityTwo : one == capacityOne;

  void fillEmptyStartBucket() {
    if (startBucket == bucketOne && one == 0)
      one = capacityOne;
    else if (startBucket == bucketTwo && two == 0)
      two = capacityTwo;
    else
      throw Exception('StartBucket to fill is not empty');
  }

  void emptyFilledUpNonStartBucket() {
    if (startBucket == bucketOne && two == capacityTwo)
      two = 0;
    else if (startBucket == bucketTwo && one == capacityOne)
      one = 0;
    else
      throw Exception('NonStartBucket to empty is not full');
  }
}

class TwoBucket {
  TwoBucket({
    required bucketOne,
    required bucketTwo,
    required this.goal,
    required String startBucket,
  }) : _buckets = _Buckets(bucketOne, bucketTwo, startBucket) {
    if (bucketOne <= 0 || bucketTwo <= 0)
      throw ArgumentError('Both buckets must have volumes > 0');

    if (!['one', 'two'].contains(startBucket))
      throw ArgumentError('Unknown startBucket');
  }

  _Buckets _buckets;
  final goal;

  ({int moves, String goalBucket, int otherBucket}) measure() {
    if (goal <= 0 ||
        goal > max(_buckets.capacityOne, _buckets.capacityTwo) ||
        !isGoalPossible(_buckets.capacityOne, _buckets.capacityTwo, goal))
      throw ArgumentError('impossible');

    // 1. fill initial bucket
    _buckets.one = _buckets.startBucket == bucketOne ? _buckets.capacityOne : 0;
    _buckets.two = _buckets.startBucket == bucketTwo ? _buckets.capacityTwo : 0;
    int moves = 1;

    while (_buckets.one != goal && _buckets.two != goal) {
      if (_buckets.forbiddenState) throw ArgumentError('Forbidden state');

      // 2.1 if start bucket is empty: fill it up
      if (_buckets.startBucketIsEmpty)
        _buckets.fillEmptyStartBucket();

      // 2.2 if non start bucket has goal as capacity
      else if (_buckets.capacityOne == goal || _buckets.capacityTwo == goal) {
        if (_buckets.capacityOne == goal)
          _buckets.one = _buckets.capacityOne;
        else if (_buckets.capacityTwo == goal)
          _buckets.two = _buckets.capacityTwo;

        moves++;
        break;
      }

      // 2.3 if non start bucket is full: empty it
      else if (_buckets.nonStartBucketIsFull)
        _buckets.emptyFilledUpNonStartBucket();

      // 2.3 transfer possible volume from start bucket to other bucket
      else {
        int transferable = _buckets.startBucket == bucketOne
            ? min(_buckets.one, _buckets.capacityTwo - _buckets.two)
            : min(_buckets.two, _buckets.capacityOne - _buckets.one);

        if (_buckets.startBucket == bucketOne) {
          _buckets.one -= transferable;
          _buckets.two += transferable;
        } else {
          _buckets.two -= transferable;
          _buckets.one += transferable;
        }
      }

      moves++;
    }

    return (
      moves: moves,
      goalBucket: _buckets.one == goal ? bucketOne : bucketTwo,
      otherBucket: _buckets.one == goal ? _buckets.two : _buckets.one,
    );
  }

  bool isGoalPossible(int firstBucket, int secondBucket, int goal) {
    while (secondBucket != 0) {
      int temp = secondBucket;
      secondBucket = firstBucket % secondBucket;
      firstBucket = temp;
    }

    return goal % firstBucket.abs() == 0;
  }
}