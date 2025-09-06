def assert(condition; message):
  select(condition) // (message | halt_error);
  . as { $inputBase, $outputBase }
| assert( $inputBase  >= 2 ; "input base must be >= 2"  )
| assert( $outputBase >= 2 ; "output base must be >= 2" )
| assert( .digits | all(0 <= . and . < $inputBase) ; "all digits must satisfy 0 <= d < input base" )
| reduce .digits[] as $d ( 0 ; . * $inputBase + $d )
| [ while( . > 0 ; . / $outputBase | floor ) // 0 | . % $outputBase ]
| reverse