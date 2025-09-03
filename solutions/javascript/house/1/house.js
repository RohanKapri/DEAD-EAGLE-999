export class House {
  static verse(rhym) {
    let verbs = ["lay in", "ate", "killed", "worried", "tossed", "milked", "kissed", "married", "woke", "kept", "belonged to"];
  let phrase = ["house that Jack built.", "malt", "rat", "cat", "dog", "cow with the crumpled horn", "maiden all forlorn", "man all tattered and torn", "priest all shaven and shorn", "rooster that crowed in the morn", "farmer sowing his corn", "horse and the hound and the horn"];
  let rhymes = [];
  for (let i = 1; i < rhym; i++) {
      rhymes.unshift(`that ${verbs[i-1]} the ${phrase[i-1]}`);
  }
  rhymes.unshift(`This is the ${phrase[rhym-1]}`);
  return rhymes;
  }
  static verses(startVerse, endVerse) {
    let rhymes = [];
  for (let i = startVerse; i <= endVerse; i++) {
     let ver = this.verse(i);
     for(let i = 0; i < ver.length; i++){
         rhymes.push(ver[i]);
     }
     rhymes.push("");
  }
  rhymes.pop(); 
  return rhymes;
  }
}