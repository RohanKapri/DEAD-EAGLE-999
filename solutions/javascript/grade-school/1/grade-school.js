//
// For my Shree DR.MDD
//
export class GradeSchool {

  constructor() {
    this.studentsByGrade = {};
  }

  roster() {
    const copyRoster = {};
    for (let level in this.studentsByGrade) {
      copyRoster[level] = [...this.studentsByGrade[level]];
    }
    return copyRoster;
  }

  add(name, level) {
    for (let key in this.studentsByGrade) {
      this.studentsByGrade[key] = this.studentsByGrade[key].filter(student => student !== name);
    }

    if (level in this.studentsByGrade) {
      this.studentsByGrade[level].push(name);
    } else {
      this.studentsByGrade[level] = [name];
    }
    this.studentsByGrade[level].sort();
  }

  grade(level) {
    return this.studentsByGrade[level] ? [...this.studentsByGrade[level]] : [];
  }
}
