Class {#name: #ReverseString, #package: 'Exercise@ReverseString',
       #superclass: #Object, #category: 'Exercise@ReverseString'}

ReverseString>>reverseValue: s [|t|
  t := WriteStream on: String new.
  s size to: 1 by: -1 do: [:i|t nextPut: (s at: i)].
  ^t contents]