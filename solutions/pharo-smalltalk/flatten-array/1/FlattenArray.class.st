Class {#name: #FlattenArray, #package: 'Exercise@FlattenArray',
       #superclass: #Object, #category: 'Exercise@FlattenArray'}

FlattenArray>>flattenArray: a [^a flattened reject: #isNil]