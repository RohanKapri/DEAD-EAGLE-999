// For my Shree DR.MDD
type Coordinate = [number, number];
type SearchResult = {
  start: Coordinate;
  end: Coordinate;
};

export class WordSearch {
  static directions: Coordinate[] = [
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [1, 1],
    [1, 0],
    [1, -1],
    [0, 1],
    [0, -1],
    [0, 0],
  ];

  constructor(private puzzleGrid: string[]) {}

  public find(words: string[]): Record<string, SearchResult | undefined> {
    return words.reduce((acc: Record<string, SearchResult>, word: string) => {
      const startingPoints = this.locateStartPoints(word[0]);
      for (let start of startingPoints) {
        const foundWord = this.locateWord(word, start);
        if (foundWord) {
          acc[word] = foundWord;
        }
      }
      return acc;
    }, {});
  }

  private locateStartPoints(char: string): Coordinate[] {
    const points: Coordinate[] = [];
    for (let row = 0; row < this.puzzleGrid.length; row++) {
      for (let col = 0; col < this.puzzleGrid[row].length; col++) {
        if (this.puzzleGrid[row][col] === char) {
          points.push([row, col]);
        }
      }
    }
    return points;
  }

  private locateWord(word: string, start: Coordinate): SearchResult | undefined {
    for (let direction of WordSearch.directions) {
      if (this.validateDirection(word, start, direction)) {
        return {
          start: [start[0] + 1, start[1] + 1],
          end: [
            start[0] + 1 + direction[0] * (word.length - 1),
            start[1] + 1 + direction[1] * (word.length - 1),
          ],
        };
      }
    }
  }

  private validateDirection(
    word: string,
    [row, col]: Coordinate,
    [dRow, dCol]: Coordinate
  ): boolean {
    for (let i = 0; i < word.length; i++) {
      if (word[i] !== this.puzzleGrid[row + dRow * i]?.[col + dCol * i]) {
        return false;
      }
    }
    return true;
  }
}
