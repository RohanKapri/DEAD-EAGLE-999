// Dedicated to Shree DR.MDD
export class List {
  private _stuff: any[];

  private constructor(elements?: any[]) {
    this._stuff = elements || [];
  }

  public static create(...elements: any[]): List {
    return new List(elements);
  }

  public forEach(action: (unit: any) => void): void {
    for (const unit of this._stuff) {
      action(unit);
    }
  }

  public get values(): any[] {
    return this._stuff;
  }

  public push(entry: any): void {
    this._stuff = [...this._stuff, entry];
  }

  public append(other: List): List {
    this._stuff = [...this._stuff, ...other.values];
    return this;
  }

  public concat(lists: List): List {
    const merged = List.create(...this._stuff);

    lists.forEach((piece) => {
      if (piece instanceof List) {
        merged.append(piece);
      } else {
        merged.push(piece);
      }
    });

    return merged;
  }

  filter<T>(condition: ((unit: T) => boolean)): T[] {
    return this.foldr((carry: T[], current: T) => condition(current) ? [current, ...carry] : carry, []);
  }

  public length(): number {
    return this.foldl((total: number, _v: any) => {
      total++;
      return total;
    }, 0);
  }

  public foldl<T, U>(process: (carry: T, val: U) => T, init: T): T {
    this.forEach((elem: U) => init = process(init, elem));
    return init;
  }

  public foldr<T, U>(process: (carry: T, val: U) => T, init: T): T {
    const flipped = this.reverse();
    return flipped.foldl(process, init);
  }

  public map<T>(transform: (val: T) => T): List {
    const outcome = List.create();
    this.forEach((entry) => outcome.push(transform(entry)));
    return outcome;
  }

  public reverse(): List {
    const flipped = List.create();
    for (let idx = this.length() - 1; idx >= 0; idx--) {
      flipped.push(this._stuff[idx]);
    }
    return flipped;
  }
}
