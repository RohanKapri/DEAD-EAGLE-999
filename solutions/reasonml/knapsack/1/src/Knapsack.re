open Item;
let maximum_value = (items, max_weight) => {
  let n = List.length(items);
  let dp = Array.make_matrix(n + 1, max_weight + 1, 0);
  for (i in 1 to n) {
    let item = List.nth(items, i - 1);
    for (w in 1 to max_weight) {
      if (item.weight <= w) {
        dp[i][w] = max(
          dp[i - 1][w],
          item.value + dp[i - 1][w - item.weight]
        );
      } else {
        dp[i][w] = dp[i - 1][w];
      }
    }
  }
  dp[n][max_weight];
};
type item = {
    weight: int,
    value: int,
};