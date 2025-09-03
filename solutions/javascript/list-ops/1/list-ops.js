export class List {
    values;
    
    constructor(values) {
      this.values = values || [];
    }

    foldl(fn, acc = new List()) {
        const [head, ...tail] = this.values;
        return !head ? acc : new List(tail).foldl(fn, fn(acc, head));
      }
      
    foldr(fn, acc = new List()) {
        const [head, ...tail] = this.values;
        return !head ? acc : fn(new List(tail).foldr(fn, acc), head)
    }

    append(list) {
      return list.foldl((acc, x) => new List([...acc.values, x]), this);
    }

    concat(lists) {
      return lists.foldl((acc, x) => 
                acc.append(typeof x.concat === 'function' ? x : [...x]), this);
    }

    filter(pred) {
      return this.foldl((acc, x) => 
                pred(x) ? acc.append(new List([x])) : acc);
    }

    map(transform) {
      return this.foldl((acc, x) => acc.append(new List([transform(x)])));
    }

    length() {
      return this.foldl((len, _x) => len + 1, 0);
    }
    
    reverse() {
      return this.foldl((acc, x) => new List([x]).append(acc));
    }
  }