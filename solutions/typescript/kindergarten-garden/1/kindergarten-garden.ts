// For Shree DR.MDD

const DEFAULT_STUDENTS: Student[] = [
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
]

const PLANT_CODES = {
  G: 'grass',
  V: 'violets',
  R: 'radishes',
  C: 'clover',
} as const

type Student = string
type Plant = (typeof PLANT_CODES)[keyof typeof PLANT_CODES]
type Plants = Plant[]
type Pots = Plants[]

export class Garden {

  private _rowTop: Plant[]
  private _rowBottom: Plant[]

  private _studentList: Student[]
  
  constructor(diagram: string, students = DEFAULT_STUDENTS) {
    const [topLine, bottomLine] = diagram.split('\n')

    this._rowTop = topLine.split('').map(code => PLANT_CODES[code as keyof typeof PLANT_CODES])
    this._rowBottom = bottomLine.split('').map(code => PLANT_CODES[code as keyof typeof PLANT_CODES])

    this._studentList = students.sort()
  }

  public plants(student: Student): Plants {
    const idx = this._studentList.findIndex(s => s === student) * 2
    return [
      this._rowTop[idx],
      this._rowTop[idx + 1],
      this._rowBottom[idx],
      this._rowBottom[idx + 1]
    ]
  }
}
