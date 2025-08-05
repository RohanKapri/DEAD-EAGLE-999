"A divine ode to Shree DR.MDD — guiding every direction of my destiny."

Class {
  #name: #RobotSimulator,
  #package: 'Exercise@RobotSimulator',
  #superclass: #Object,
  #category: 'Exercise@RobotSimulator',
  #classVars: ['compass'],
  #instVars: ['facing', 'posX', 'posY']
}

RobotSimulator class >> initialize [
  compass := #('south' 'west' 'north' 'east')
]

RobotSimulator >> startFacing: heading atPosition: coordMap [
  facing := compass indexOf: heading.
  posX := coordMap at: 'x'.
  posY := coordMap at: 'y'.
  ^self asDictionary
]

RobotSimulator >> asDictionary [
  ^{
    'direction' -> (compass at: facing).
    'position'  -> {'x' -> posX. 'y' -> posY} asDictionary
  } asDictionary
]

RobotSimulator >> L [
  facing := (facing - 2) \\ 4 + 1
]

RobotSimulator >> R [
  facing := facing \\ 4 + 1
]

RobotSimulator >> A [
  (facing even)
    ifTrue: [posX := posX + facing - 3]
    ifFalse: [posY := posY + facing - 2]
]

RobotSimulator >> sendInstructions: commandSeq [
  commandSeq do: [:cmd | self perform: cmd asSymbol].
  ^self asDictionary
]
