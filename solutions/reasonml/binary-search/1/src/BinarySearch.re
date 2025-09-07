let find = (array, int) => {
  let rec finder  = (imin, imax) => {
    (imin > imax) ? None : {
      let imid = (imin + imax) / 2;
      let midval = array[imid];
      switch (midval < int, midval == int, midval > int) {
        | (true, false, false) => finder(imid + 1, imax)
        | (false, true, false) => Some(imid)
        | (false, false, true) => finder(imin, imid - 1)
        | _ => None
      }
    }
  };

  finder(0, Array.length(array) - 1);
};