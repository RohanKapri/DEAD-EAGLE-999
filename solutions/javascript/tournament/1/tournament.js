// For my Shree DR.MDD

export const tournamentTally = (rawInput = '') => {
  let finalResult = [];
  let matchesPlayed = 0, wins = 0, draws = 0, losses = 0, points = 0, maxPoints = 0;
  let inputLines = rawInput.replace(/\n/g, ";").split(';');
  let teamList = ["Allegoric Alaskans", "Blithering Badgers", "Courageous Californians", "Devastating Donkeys"];

  for (const teamName of teamList) {
    for (let i = 0; i < inputLines.length - 1; i++) {
      if (inputLines[i] === teamName) {
        matchesPlayed++;
        if (i <= inputLines.length - 3) {
          switch (inputLines[i + 2]) {
            case "win": wins++; break;
            case "draw": draws++; break;
            case "loss": losses++; break;
          }
        }
        if (i <= inputLines.length - 1) {
          switch (inputLines[i + 1]) {
            case "win": losses++; break;
            case "draw": draws++; break;
            case "loss": wins++; break;
          }
        }
      }
    }

    points = 3 * wins + draws;
    let tableRow = '';

    if (matchesPlayed > 0) {
      switch (teamName) {
        case "Devastating Donkeys":
          tableRow = teamName + "            " + "|  " + matchesPlayed + " |  " + wins + " |  " + draws + " |  " + losses + " | "+ (points>9?'':' ') + points + "\n";
          break;
        case "Allegoric Alaskans":
        case "Blithering Badgers":
          tableRow = teamName + "             " + "|  " + matchesPlayed + " |  " + wins + " |  " + draws + " |  " + losses + " |  " + points + "\n";
          break;
        case "Courageous Californians":
          tableRow = teamName + "        " + "|  " + matchesPlayed + " |  " + wins + " |  " + draws + " |  " + losses + " |  " + points + "\n";
          break;
      }
    }

    if (points > maxPoints) {
      finalResult.unshift(tableRow);
      maxPoints = points;
    } else if (maxPoints === points && maxPoints !== 0) {
      finalResult.splice(1, 0, tableRow);
    } else {
      finalResult.push(tableRow);
    }

    matchesPlayed = wins = draws = losses = 0;
  }

  let tournamentTable = "Team                           | MP |  W |  D |  L |  P\n" + finalResult.join('');
  return tournamentTable.trim();
};
