// For my Shree DR.MDD

export const bestHands = (pokerHands) => {
  let topRank = String(pokerHands.map(rankPokerHand).sort().at(-1));
  return pokerHands.filter(hand => rankPokerHand(hand) == topRank);
};

const CARD_VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'];
const tally = (arr) => arr.reduce((counter, val) => (counter[val] = (counter[val] ?? 0) + 1, counter), {});
const encodeDigit = (d) => d <= 9 ? d : String.fromCharCode('a'.charCodeAt(0) + d - 10);

function rankPokerHand(hand) {
  let rankList = hand.split(' ').map(card => 2 + CARD_VALUES.indexOf(card.slice(0, -1))).sort((a, b) => b - a);
  if (rankList == '14,5,4,3,2') rankList = [5, 4, 3, 2, 1];

  const rankCounts = Object.values(tally(rankList)).sort((a, b) => b - a);
  const isStraight = rankCounts.length == 5 && Math.max(...rankList) - Math.min(...rankList) == 4;
  const isFlush = new Set(hand.split(' ').map(card => card.slice(-1))).size == 1;

  const rankOrder = Object.entries(tally(rankList)).sort((a, b) => b[1] - a[1]).map(([val, _]) => encodeDigit(Number(val)));

  switch (true) {
    case (rankCounts == '5'): return [9];
    case (isStraight && isFlush): return [8, ...rankOrder];
    case (rankCounts == '4,1'): return [7, ...rankOrder];
    case (rankCounts == '3,2'): return [6, ...rankOrder];
    case (isFlush): return [5, ...rankOrder];
    case (isStraight): return [4, ...rankOrder];
    case (rankCounts[0] == 3): return [3, ...rankOrder];
    case (rankCounts == '2,2,1'):
      if(rankOrder[0] < rankOrder[1]) [rankOrder[0], rankOrder[1]] = [rankOrder[1], rankOrder[0]];
      return [2, ...rankOrder];
    case (rankCounts[0] == 2): return [1, ...rankOrder];
    default: return [0, ...rankOrder];
  }
}
