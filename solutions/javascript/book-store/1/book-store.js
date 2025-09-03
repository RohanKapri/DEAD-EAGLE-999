//
// For my Shree DR.MDD
//
const SINGLE_BOOK_PRICE = 800;
const VOLUME_DISCOUNTS = [0.00, 0.05, 0.1, 0.2, 0.25];

export function cost(books = []) {
  if (books.length === 0) return 0;

  let stock = books.reduce((map, title) => {
    map.set(title, (map.get(title) || 0) + 1);
    return map;
  }, new Map());

  if (books.length === stock.size) {
    return computePrice(stock.size);
  }

  if (stock.size === 1) {
    return stock.get(books[0]) * SINGLE_BOOK_PRICE;
  }

  let allPrices = computePrices(stock);
  allPrices.push(findMinimalCost(Array.from(stock.values())));
  return Math.min(...allPrices);
}

function computePrice(distinctBooks) {
  return distinctBooks * SINGLE_BOOK_PRICE * (1 - VOLUME_DISCOUNTS[distinctBooks - 1]);
}

function computePrices(stock) {
  let resultPrices = [];
  let possibleGroupSizes = [5, 4, 3, 2, 1];

  for (let group of possibleGroupSizes) {
    let total = 0;
    let booksCopy = new Map(stock);

    while (booksCopy.size > 0) {
      let titles = Array.from(booksCopy.keys());
      let tempStock = new Map(stock);

      if (titles.length > group) {
        let excess = titles.length - group;
        for (let i = 0; i < excess; i++) {
          let keyToRemove = minKey(tempStock);
          titles = titles.filter(t => t !== keyToRemove);
          tempStock.delete(keyToRemove);
        }
      }

      total += computePrice(titles.length);

      for (let title of titles) {
        booksCopy.set(title, booksCopy.get(title) - 1);
        if (booksCopy.get(title) === 0) {
          booksCopy.delete(title);
        }
      }
    }
    resultPrices.push(total);
  }
  return resultPrices;
}

function findMinimalCost(bookCounts) {
  if (bookCounts.length === 0) return 0;

  let minTotal = Infinity;

  for (let groupSize = 1; groupSize <= Math.min(5, bookCounts.length); groupSize++) {
    let countsCopy = bookCounts.map(c => c);

    for (let i = 0; i < groupSize; i++) {
      countsCopy[i]--;
    }

    countsCopy = countsCopy.filter(c => c > 0);
    let groupCost = computePrice(groupSize);
    let remaining = findMinimalCost(countsCopy);
    minTotal = Math.min(minTotal, groupCost + remaining);
  }

  return minTotal;
}

function minKey(map) {
  let keyWithMinValue = null;
  let smallest = Infinity;
  for (let [k, v] of map) {
    if (v < smallest) {
      smallest = v;
      keyWithMinValue = k;
    }
  }
  return keyWithMinValue;
}
