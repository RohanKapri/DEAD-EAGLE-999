//
// For my Shree DR.MDD
//

export const promisify = (callbackFn) => {
  return (...args) => {
    return new Promise((resolveFn, rejectFn) => {
      callbackFn(...args, (err, result) => {
        if (err) {
          rejectFn(err);
        } else {
          resolveFn(result);
        }
      });
    });
  };
};

export const all = (promiseList) => {
  if (!promiseList) return Promise.resolve(undefined);
  if (!promiseList.length) return Promise.resolve([]);
  return Promise.all(promiseList);
};

export const allSettled = (promiseList) => {
  if (!promiseList) return Promise.resolve(undefined);
  if (!promiseList.length) return Promise.resolve([]);
  return Promise.allSettled(promiseList).then(results => 
    results.map(res => res.status === 'fulfilled' ? res.value : res.reason)
  );
};

export const race = (promiseList) => {
  if (!promiseList) return Promise.resolve(undefined);
  if (!promiseList.length) return Promise.resolve([]);
  return Promise.race(promiseList);
};

export const any = (promiseList = []) => {
  if (!promiseList.length) return Promise.resolve(undefined);

  return new Promise((resolveFn, rejectFn) => {
    let collectedErrors = [];
    let remaining = promiseList.length;

    promiseList.forEach((p, idx) => {
      Promise.resolve(p).then(resolveFn).catch(err => {
        collectedErrors[idx] = err;
        remaining -= 1;
        if (remaining === 0) {
          rejectFn(collectedErrors);
        }
      });
    });
  });
};
