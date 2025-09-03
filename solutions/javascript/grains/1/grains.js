
export const square = (squares) => {
  if(squares <= 0 || squares > 64){
    throw new Error('square must be between 1 and 64');
}
return BigInt(2) ** BigInt(squares - 1);
};

export const total = () => {
  let total = BigInt(0);
  for (let i = 1; i <= 64; i++) {
    total += square(i);
  }
  return total;
};