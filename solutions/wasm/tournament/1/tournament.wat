(module
  (memory (export "mem") 1)
  
  ;; Constants for memory layout
  (global $outputOffset i32 (i32.const 2048))
  (global $headlineOffset i32 (i32.const 512))
  (global $templateOffset i32 (i32.const 568))
  (global $lineLength i32 (i32.const 56))
  (global $rosterOffset i32 (i32.const 1024))
  
  ;; ASCII constants
  (global $semicolon i32 (i32.const 59))  ;; ';'
  (global $linebreak i32 (i32.const 10))  ;; '\n'
  (global $win i32 (i32.const 119))       ;; 'w'
  (global $draw i32 (i32.const 100))      ;; 'd'
  (global $loss i32 (i32.const 108))      ;; 'l'
  (global $zero i32 (i32.const 48))       ;; '0'
  (global $space i32 (i32.const 32))      ;; ' '
  (global $pipe i32 (i32.const 124))      ;; '|'
  
  ;; Table column positions
  (global $mpPos i32 (i32.const 34))
  (global $wPos i32 (i32.const 39))
  (global $dPos i32 (i32.const 44))
  (global $lPos i32 (i32.const 49))
  (global $pPos i32 (i32.const 54))
  
  ;; Pre-defined strings
  (data (i32.const 512) "Team                           | MP |  W |  D |  L |  P\n                               |    |    |    |    |   \n")
  (data (i32.const 1024) "\00\00\00\00\00\00\00\00\00")
  
  ;; Helper function to compare strings with early exit
  (func $strcmp (export "strcmp") (param $offsetA i32) (param $lengthA i32) (param $offsetB i32) (param $lengthB i32) (result i32)
    (local $pos i32)
    (local $diff i32)
    (local $minLen i32)
    
    ;; Quick length check
    (if (i32.or (i32.eqz (local.get $lengthA)) (i32.eqz (local.get $lengthB))) 
      (then (return (i32.sub (local.get $lengthA) (local.get $lengthB)))))
    
    ;; Find minimum length for comparison
    (local.set $minLen (select (local.get $lengthA) (local.get $lengthB) 
      (i32.lt_u (local.get $lengthA) (local.get $lengthB))))
    
    (local.set $pos (i32.const 0))
    (loop $chars
      (if (i32.lt_u (local.get $pos) (local.get $minLen))
        (then
          (local.set $diff (i32.sub 
            (i32.load8_u (i32.add (local.get $offsetB) (local.get $pos)))
            (i32.load8_u (i32.add (local.get $offsetA) (local.get $pos)))))
          (if (i32.ne (local.get $diff) (i32.const 0))
            (then (return (local.get $diff))))
          (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
          (br $chars))))
    (i32.sub (local.get $lengthA) (local.get $lengthB))
  )
  
  ;; Get or create team with optimized memory access
  (func $getTeam (param $inputOffset i32) (param $inputLength i32) (result i32)
    (local $pos i32)
    (local $offset i32)
    (local $length i32)
    (local $teamData i32)
    
    (local.set $pos (i32.const -1))
    (loop $roster
      (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
      (local.set $teamData (i32.add (global.get $rosterOffset) (i32.shl (local.get $pos) (i32.const 3))))
      
      ;; Load team data efficiently
      (local.set $offset (i32.load16_u (local.get $teamData)))
      (local.set $length (i32.load8_u (i32.add (local.get $teamData) (i32.const 2))))
      
      ;; Create new team if not found
      (if (i32.eqz (local.get $offset))
        (then
          ;; Store team data efficiently
          (i32.store16 (local.get $teamData) (local.get $inputOffset))
          (i32.store8 (i32.add (local.get $teamData) (i32.const 2)) (local.get $inputLength))
          (memory.fill (i32.add (local.get $teamData) (i32.const 3)) (i32.const 0) (i32.const 5))
          (return (local.get $pos))))
      
      ;; Continue search if not found
      (br_if $roster (call $strcmp (local.get $offset) (local.get $length)
        (local.get $inputOffset) (local.get $inputLength))))
    (local.get $pos)
  )
  
  ;; Update team stats efficiently
  (func $updateTeamStats (param $teamPos i32) (param $played i32) (param $won i32) (param $drawn i32) (param $lost i32) (param $points i32)
    (local $teamData i32)
    (local.set $teamData (i32.add (global.get $rosterOffset) (i32.shl (local.get $teamPos) (i32.const 3))))
    
    ;; Update stats using single memory access where possible
    (if (local.get $played)
      (then (i32.store8 (i32.add (local.get $teamData) (i32.const 3)) 
        (i32.add (i32.load8_u (i32.add (local.get $teamData) (i32.const 3))) (local.get $played)))))
    (if (local.get $won)
      (then (i32.store8 (i32.add (local.get $teamData) (i32.const 4)) 
        (i32.add (i32.load8_u (i32.add (local.get $teamData) (i32.const 4))) (local.get $won)))))
    (if (local.get $drawn)
      (then (i32.store8 (i32.add (local.get $teamData) (i32.const 5)) 
        (i32.add (i32.load8_u (i32.add (local.get $teamData) (i32.const 5))) (local.get $drawn)))))
    (if (local.get $lost)
      (then (i32.store8 (i32.add (local.get $teamData) (i32.const 6)) 
        (i32.add (i32.load8_u (i32.add (local.get $teamData) (i32.const 6))) (local.get $lost)))))
    (if (local.get $points)
      (then (i32.store8 (i32.add (local.get $teamData) (i32.const 7)) 
        (i32.add (i32.load8_u (i32.add (local.get $teamData) (i32.const 7))) (local.get $points)))))
  )
  
  ;; Main tournament tally function with optimized processing
  (func (export "tournamentTally") (param $inputOffset i32) (param $inputLength i32) (result i32 i32)
    (local $char i32)
    (local $last i32)
    (local $pos i32)
    (local $outputLength i32)
    (local $team i32)
    (local $teamA i32)
    (local $teamB i32)
    (local $tmp i64)
    
    ;; Initialize
    (local.set $teamA (i32.const -1))
    (local.set $teamB (i32.const -1))
    (local.set $outputLength (i32.const 0))
    
    ;; Process input
    (loop $read 
      (local.set $char (i32.load8_u (i32.add (local.get $inputOffset) (local.get $pos))))
      
      ;; Handle team names
      (if (i32.eq (local.get $char) (global.get $semicolon))
        (then
          (local.set $team (call $getTeam 
            (i32.add (local.get $inputOffset) (local.get $last))
            (i32.sub (local.get $pos) (local.get $last))))
          (if (i32.eq (local.get $teamA) (i32.const -1))
            (then (local.set $teamA (local.get $team)))
            (else (local.set $teamB (local.get $team))))
          (local.set $last (i32.add (local.get $pos) (i32.const 1)))))
      
      ;; Handle match results
      (if (i32.eq (local.get $char) (global.get $linebreak))
        (then
          (local.set $char (i32.load8_u (i32.add (local.get $inputOffset) (local.get $last))))
          
          ;; Update matches played for both teams
          (call $updateTeamStats (local.get $teamA) (i32.const 1) (i32.const 0) (i32.const 0) (i32.const 0) (i32.const 0))
          (call $updateTeamStats (local.get $teamB) (i32.const 1) (i32.const 0) (i32.const 0) (i32.const 0) (i32.const 0))
          
          ;; Process match result
          (if (i32.eq (local.get $char) (global.get $win))
            (then
              (call $updateTeamStats (local.get $teamA) (i32.const 0) (i32.const 1) (i32.const 0) (i32.const 0) (i32.const 3))
              (call $updateTeamStats (local.get $teamB) (i32.const 0) (i32.const 0) (i32.const 0) (i32.const 1) (i32.const 0)))
            (else
              (if (i32.eq (local.get $char) (global.get $draw))
                (then
                  (call $updateTeamStats (local.get $teamA) (i32.const 0) (i32.const 0) (i32.const 1) (i32.const 0) (i32.const 1))
                  (call $updateTeamStats (local.get $teamB) (i32.const 0) (i32.const 0) (i32.const 1) (i32.const 0) (i32.const 1)))
                (else
                  (if (i32.eq (local.get $char) (global.get $loss))
                    (then
                      (call $updateTeamStats (local.get $teamA) (i32.const 0) (i32.const 0) (i32.const 0) (i32.const 1) (i32.const 0))
                      (call $updateTeamStats (local.get $teamB) (i32.const 0) (i32.const 1) (i32.const 0) (i32.const 0) (i32.const 3))))))))
          
          ;; Reset for next match
          (local.set $teamA (i32.const -1))
          (local.set $teamB (i32.const -1))
          (local.set $last (i32.add (local.get $pos) (i32.const 1)))))
      
      (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
      (br_if $read (i32.lt_u (local.get $pos) (local.get $inputLength))))
    
    ;; Sort teams using optimized exchange sort
    (local.set $teamA (i32.const 0))
    (loop $sortA
      (local.set $teamB (i32.add (local.get $teamA) (i32.const 1)))
      (loop $sortB
        ;; Compare points and names
        (local.set $char (i32.sub 
          (i32.load8_u (i32.add (global.get $rosterOffset) (i32.add (i32.shl (local.get $teamA) (i32.const 3)) (i32.const 7))))
          (i32.load8_u (i32.add (global.get $rosterOffset) (i32.add (i32.shl (local.get $teamB) (i32.const 3)) (i32.const 7))))))
        
        ;; Sort by name if points are equal
        (if (i32.eqz (local.get $char))
          (then
            (local.set $char (call $strcmp 
              (i32.load16_u (i32.add (global.get $rosterOffset) (i32.shl (local.get $teamA) (i32.const 3))))
              (i32.load8_u (i32.add (global.get $rosterOffset) (i32.add (i32.shl (local.get $teamA) (i32.const 3)) (i32.const 2))))
              (i32.load16_u (i32.add (global.get $rosterOffset) (i32.shl (local.get $teamB) (i32.const 3))))
              (i32.load8_u (i32.add (global.get $rosterOffset) (i32.add (i32.shl (local.get $teamB) (i32.const 3)) (i32.const 2))))))))
        
        ;; Swap if needed
        (if (i32.lt_s (local.get $char) (i32.const 0))
          (then
            (local.set $tmp (i64.load (i32.add (global.get $rosterOffset) (i32.shl (local.get $teamA) (i32.const 3)))))
            (i64.store (i32.add (global.get $rosterOffset) (i32.shl (local.get $teamA) (i32.const 3)))
              (i64.load (i32.add (global.get $rosterOffset) (i32.shl (local.get $teamB) (i32.const 3)))))
            (i64.store (i32.add (global.get $rosterOffset) (i32.shl (local.get $teamB) (i32.const 3))) (local.get $tmp))))
        
        (local.set $teamB (i32.add (local.get $teamB) (i32.const 1)))
        (br_if $sortB (i32.load16_u (i32.add (global.get $rosterOffset) (i32.shl (local.get $teamB) (i32.const 3))))))
      
      (local.set $teamA (i32.add (local.get $teamA) (i32.const 1)))
      (br_if $sortA (i32.load16_u (i32.add (global.get $rosterOffset) (i32.shl (local.get $teamA) (i32.const 3))))))
    
    ;; Generate output
    (memory.copy (global.get $outputOffset) (global.get $headlineOffset) (global.get $lineLength))
    (local.set $outputLength (global.get $lineLength))
    
    ;; Write team lines
    (local.set $team (i32.const 0))
    (loop $write
      (local.set $pos (i32.load16_u (i32.add (global.get $rosterOffset) (i32.shl (local.get $team) (i32.const 3)))))
      (local.set $last (i32.load8_u (i32.add (global.get $rosterOffset) (i32.add (i32.shl (local.get $team) (i32.const 3)) (i32.const 2)))))
      
      (if (local.get $pos)
        (then
          ;; Write line template and team data
          (memory.copy (i32.add (global.get $outputOffset) (local.get $outputLength))
            (global.get $templateOffset) (global.get $lineLength))
          (memory.copy (i32.add (global.get $outputOffset) (local.get $outputLength))
            (local.get $pos) (local.get $last))
          
          ;; Write stats efficiently
          (local.set $pos (i32.add (global.get $rosterOffset) (i32.shl (local.get $team) (i32.const 3))))
          (i32.store8 (i32.add (i32.add (global.get $outputOffset) (local.get $outputLength)) (global.get $mpPos))
            (i32.add (i32.load8_u (i32.add (local.get $pos) (i32.const 3))) (global.get $zero)))
          (i32.store8 (i32.add (i32.add (global.get $outputOffset) (local.get $outputLength)) (global.get $wPos))
            (i32.add (i32.load8_u (i32.add (local.get $pos) (i32.const 4))) (global.get $zero)))
          (i32.store8 (i32.add (i32.add (global.get $outputOffset) (local.get $outputLength)) (global.get $dPos))
            (i32.add (i32.load8_u (i32.add (local.get $pos) (i32.const 5))) (global.get $zero)))
          (i32.store8 (i32.add (i32.add (global.get $outputOffset) (local.get $outputLength)) (global.get $lPos))
            (i32.add (i32.load8_u (i32.add (local.get $pos) (i32.const 6))) (global.get $zero)))
          
          ;; Write points with proper formatting
          (local.set $last (i32.load8_u (i32.add (local.get $pos) (i32.const 7))))
          (if (i32.gt_u (local.get $last) (i32.const 9))
            (then
              (i32.store8 (i32.add (i32.add (global.get $outputOffset) (local.get $outputLength))
                (i32.sub (global.get $pPos) (i32.const 1)))
                (i32.add (i32.div_u (local.get $last) (i32.const 10)) (global.get $zero)))))
          (i32.store8 (i32.add (i32.add (global.get $outputOffset) (local.get $outputLength)) (global.get $pPos))
            (i32.add (i32.rem_u (local.get $last) (i32.const 10)) (global.get $zero)))
          
          (local.set $outputLength (i32.add (local.get $outputLength) (global.get $lineLength)))))
      
      (local.set $team (i32.add (local.get $team) (i32.const 1)))
      (br_if $write (local.get $pos)))
    
    (global.get $outputOffset) (local.get $outputLength)
  )
)