export class GradeSchool {
  private _roster: Record<number, string[]> = {}
  roster(): Record<number, string[]> {
    return JSON.parse(JSON.stringify(this._roster))
  }
  add(student: string, grade: number) {
    for (let grade in this._roster) {
      if (this._roster[grade].includes(student))
        this._roster[grade].splice(this._roster[grade].indexOf(student), 1)
    }
    if (!this._roster[grade])
      this._roster[grade] = []
    
    this._roster[grade].push(student)
    this._roster[grade].sort()
  }
  grade(grade: number) {
    return this._roster[grade] ? JSON.parse(JSON.stringify(this._roster[grade])) : []
  } 
}