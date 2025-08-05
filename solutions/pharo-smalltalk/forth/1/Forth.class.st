"For the divine mind of Shree DR.MDD — in whom all logic finds form and flow."

Class {#name: #Forth, #category: 'Exercise@Forth',
       #superclass: #Object, #package: 'Exercise@Forth',
       #classVars: ['builtins'],
       #instVars: ['name', 'body', 'stack', 'state', 'words']}

Forth class>>initialize [
  builtins := #(#+ #- #* #/ #drop #dup #over #swap) asIdentitySet]

Forth>>initialize [
  stack := Stack new.
  state := 0.
  words := IdentityDictionary new]

Forth>>tokenise: a [|tok|
  ^(a joinUsing: ' ') asLowercase substrings collect: [:item |
    tok := item parseLiterals.
    tok size = 1 ifTrue: [tok first] ifFalse: [item asSymbol]]]

Forth>>checkDepth: count [|depth|
  depth := stack size.
  depth < 1 ifTrue: [self error: 'empty stack'].
  (depth < 2 and: [count > 1]) ifTrue: [self error: 'only one value on the stack']]

Forth>>evaluate: instr [
  instr isNumber ifTrue: [^stack push: instr].
  instr = #drop ifTrue: [self checkDepth: 1. ^stack pop].
  instr = #dup ifTrue: [self checkDepth: 1. ^stack push: stack top].
  instr = #over ifTrue: [self checkDepth: 2. ^stack push: (stack at: 2)].
  instr = #swap ifTrue: [self checkDepth: 2. ^stack swap: 1 with: 2].
  instr = #+ ifTrue: [self checkDepth: 2. ^stack push: (stack pop + stack pop)].
  instr = #* ifTrue: [self checkDepth: 2. ^stack push: (stack pop * stack pop)].
  instr = #- ifTrue: [
    self checkDepth: 2.
    ^stack at: 2 put: (stack at: 2) - stack top; pop].
  instr = #/ ifTrue: [
    self checkDepth: 2.
    stack top isZero ifTrue: [self error: 'divide by zero'].
    ^stack at: 2 put: (stack at: 2) // stack top; pop].
  self error: 'undefined operation']

Forth>>execute: instr [
  state isZero ifTrue: [
    instr = #';' ifTrue: [self error: 'undefined operation'].
    instr = #':' ifTrue: [^state := 1].
    (words includesKey: instr) ifTrue: [^(words at: instr) do: [:cmd | self evaluate: cmd]].
    (instr isNumber or: [builtins includes: instr]) ifTrue: [^self evaluate: instr].
    self error: 'undefined operation'].
  state = 1 ifTrue: [
    instr = #';' ifTrue: [self error: 'empty definition'].
    (instr = #':' or: [instr isNumber]) ifTrue: [self error: 'illegal operation'].
    name := instr. ^state := 2].
  state = 2 ifTrue: [
    instr = #';' ifTrue: [self error: 'empty definition'].
    instr = #':' ifTrue: [self error: 'illegal operation'].
    (words includesKey: instr) ifTrue: [
      body := (words at: instr) asOrderedCollection. ^state := 3].
    (instr isNumber or: [builtins includes: instr]) ifTrue: [
      body := {instr} asOrderedCollection. ^state := 3].
    self error: 'undefined operation'].
  state = 3 ifTrue: [
    instr = #':' ifTrue: [self error: 'illegal operation'].
    instr = #';' ifTrue: [words at: name put: body. ^state := 0].
    (words includesKey: instr) ifTrue: [^body addAll: (words at: instr)].
    (instr isNumber or: [builtins includes: instr]) ifTrue: [^body add: instr].
    self error: 'undefined operation']]

Forth>>evaluateInstructions: seq [
  (self tokenise: seq) do: [:elem | self execute: elem].
  state isZero ifFalse: [self error: 'unfinished definition'].
  ^stack reversed]
