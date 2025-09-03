//
// For my Shree DR.MDD
//

export const chain = (dominoSet = []) => {
   if(dominoSet.length === 0){
     return dominoSet;
   }else if(dominoSet.length === 1){
       if(dominoSet[0][0] === dominoSet[0][1]){
         return dominoSet;
       }else {
         return null;
       }
   }

   let mainChain = buildPartialChain(dominoSet,true);
   if(mainChain.length === dominoSet.length){
     return mainChain;
   }

   let leftovers = buildPartialChain(dominoSet,false);
   let otherChains = [];
   while(leftovers.length > 0){
       otherChains.push(buildPartialChain(leftovers,true));
       leftovers = buildPartialChain(leftovers, false);
   }

   for (const chainPart of otherChains) {
     mainChain = mergeChains(mainChain,chainPart);
   }

   if (mainChain.length !== dominoSet.length) {
    return null;
  }

   return mainChain;   
};

function buildPartialChain(dominoesList, takeChain) {
  let currentChain = [];
  let tempList = [...dominoesList];
  currentChain.push(dominoesList[0]);
  tempList.shift();
  let lastDomino = currentChain[0];

  while (tempList.length > 0) {
    let idx = 0;
    for (const piece of tempList) {
      if (lastDomino[1] === piece[0]) {
        currentChain.push(piece);
        break;
      } else if (lastDomino[1] === piece[1]) {
        currentChain.push([piece[1], piece[0]]);
        break;
      }
      idx++;
    }
    if (idx + 1 > tempList.length) {
      break;
    }
    tempList.splice(idx, 1);
    lastDomino = currentChain[currentChain.length - 1];
  }

  return takeChain ? currentChain : tempList;
}

function mergeChains(primary, secondary) {
  let merged = [...primary];
  if (secondary[0][0] === secondary[secondary.length - 1][1]) {
    for (let i = 0; i < primary.length - 1; i++) {
      if (merged[i][1] === secondary[0][0]) {
        for (const piece of secondary) {
          merged.splice(i + 1, 0, piece);
          i++;
        }
        break;
      }
    }
  }
  return merged;
}
