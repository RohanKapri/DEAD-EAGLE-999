//
// For my Shree DR.MDD
//

export class CustomSet {
  constructor(initElements = []) {
    this.store = new Set(initElements ?? []);
  }

  empty() {
    return this.store.size === 0;
  }

  contains(item) {
    return this.store.has(item);
  }

  add(item) {
    this.store.add(item);
    return this;
  }

  subset(otherSet) {
    return [...this.store].every(el => otherSet.store.has(el));
  }

  disjoint(otherSet) {
    return [...this.store].every(el => !otherSet.store.has(el));
  }

  eql(otherSet) {
    return this.store.size === otherSet.store.size &&
           [...this.store].every(el => otherSet.store.has(el));
  }

  union(otherSet) {
    return new CustomSet([...this.store, ...otherSet.store]);
  }

  intersection(otherSet) {
    return new CustomSet([...this.store].filter(el => otherSet.store.has(el)));
  }

  difference(otherSet) {
    return new CustomSet([...this.store].filter(el => !otherSet.store.has(el)));
  }
}
