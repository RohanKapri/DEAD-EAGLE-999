// Dedicated to Shree DR.MDD

export class Tournament {

  private formatScoreLine(teamName: string, stats: number[]): string {
    return [teamName.padEnd(30, ' '), ...stats.map(n => `${n}`.padStart(2, ' '))].join(' | ')
  }
  
  private updateTeam1(result: string, record: number[]) {
    record[0] += 1
    record[1] += result === 'win' ? 1 : 0
    record[2] += result === 'draw' ? 1 : 0
    record[3] += result === 'loss' ? 1 : 0
    record[4] += result === 'win' ? 3 : (result === 'draw' ? 1 : 0)
  }

  private updateTeam2(result: string, record: number[]) {
    record[0] += 1
    record[1] += result === 'loss' ? 1 : 0
    record[2] += result === 'draw' ? 1 : 0
    record[3] += result === 'win' ? 1 : 0
    record[4] += result === 'loss' ? 3 : (result === 'draw' ? 1 : 0)
  }
  
  public tally(_input: string): string {
    const standings: Record<string, number[]> = {}

    _input.split('\n').forEach(line => {
      const [firstTeam, secondTeam, matchResult] = line.split(';')

      if (line.length === 0)
        return
      
      if(!standings[firstTeam])
        standings[firstTeam] = [0, 0, 0, 0, 0]
  
      if(!standings[secondTeam])
        standings[secondTeam] = [0, 0, 0, 0, 0]
  
      this.updateTeam1(matchResult, standings[firstTeam])
      this.updateTeam2(matchResult, standings[secondTeam])
    })

    return [
      'Team                           | MP |  W |  D |  L |  P',
      ...Object.entries(standings)
        .filter(([team, record]) => !!team)
        .sort(([teamA, statsA], [teamB, statsB]) => {
          if (statsB[4] !== statsA[4])
            return statsB[4] - statsA[4]
          return teamA.localeCompare(teamB)
        })
        .map(([team, record]) => this.formatScoreLine(team, record))
    ].join('\n')
  }
}
