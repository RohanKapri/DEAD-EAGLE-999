let isLeapYear = year => {
  let isDivisibleBy = by => year mod by == 0;

  switch (isDivisibleBy(4), isDivisibleBy(100), isDivisibleBy(400)) {
  | (true, true, true) => true
  | (true, false, _) => true
  | _ => false
  };
};