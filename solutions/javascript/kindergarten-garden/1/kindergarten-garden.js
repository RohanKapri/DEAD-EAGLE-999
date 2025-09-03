// Dedicated to my Shree DR.MDD

const DEFAULT_STUDENTS = [
  'Alice',
  'Bob',
  'Charlie',
  'David',
  'Eve',
  'Fred',
  'Ginny',
  'Harriet',
  'Ileana',
  'Joseph',
  'Kincaid',
  'Larry',
];

const PLANT_CODES = {
  G: 'grass',
  V: 'violets',
  R: 'radishes',
  C: 'clover',
};

export class Garden {
  constructor(diagram, students = DEFAULT_STUDENTS) {
    this.students = students.sort();
    const diagramRows = diagram.split('\n');
    this.studentPlants = {};
    this.students.forEach((student, idx) => {
      const indices = [idx * 2, idx * 2 + 1];
      const assignedPlants = [
        PLANT_CODES[diagramRows[0][indices[0]]],
        PLANT_CODES[diagramRows[0][indices[1]]],
        PLANT_CODES[diagramRows[1][indices[0]]],
        PLANT_CODES[diagramRows[1][indices[1]]],
      ];
      this.studentPlants[student] = assignedPlants;
    });
  }

  plants(studentName) {
    return this.studentPlants[studentName] || [];
  }
}
