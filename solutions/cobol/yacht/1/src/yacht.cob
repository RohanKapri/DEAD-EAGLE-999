       IDENTIFICATION DIVISION.
       PROGRAM-ID. YACHT.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           01 WS-RESULT      PIC 99 VALUE 0.
           01 WS-CATEGORY    PIC X(15).
           01 WS-DICE        PIC 9(5).
           01 NUMS           PIC 9(6).
           01 ITER           PIC 9(3).
           01 A              PIC 9.
           01 TO-BE-CHECKED  PIC 9.

       PROCEDURE DIVISION.
       YACHT.
           MOVE ZERO TO WS-RESULT.
           MOVE ZEROES TO NUMS.
           PERFORM COUNT-NUMS.
           EVALUATE WS-CATEGORY
              WHEN 'yacht'
                 PERFORM CHECK-YACHT
              WHEN 'ones'
                 PERFORM CHECK-ONES
              WHEN 'twos'
                 PERFORM CHECK-TWOS
              WHEN 'threes'
                 PERFORM CHECK-THREES
              WHEN 'fours'
                 PERFORM CHECK-FOURS
              WHEN 'fives'
                 PERFORM CHECK-FIVES
              WHEN 'sixes'
                 PERFORM CHECK-SIXES
              WHEN 'full house'
                 PERFORM CHECK-FULL-HOUSE
              WHEN 'four of a kind'
                 PERFORM CHECK-4OFKIND
              WHEN 'little straight'
                 PERFORM CHECK-LITTLE-STRAIGHT
              WHEN 'big straight'
                 PERFORM CHECK-BIG-STRAIGHT
              WHEN 'choice'
                 PERFORM CHOICE 
           END-EVALUATE.

           COUNT-NUMS.
              PERFORM VARYING ITER FROM 1 BY 1 UNTIL ITER = 5
                 MOVE WS-DICE(ITER:1) TO TO-BE-CHECKED
                 MOVE NUMS(TO-BE-CHECKED:1) TO A
                 ADD 1 TO A
                 MOVE A TO NUMS(TO-BE-CHECKED:1)
              END-PERFORM.

           CHECK-ONES.
              MOVE NUMS(1:1) TO WS-RESULT.
              GOBACK.

           CHECK-TWOS.
              MOVE NUMS(2:1) TO A.
              COMPUTE WS-RESULT = A * 2.
              GOBACK.

           CHECK-THREES.
              MOVE NUMS(3:1) TO A.
              COMPUTE WS-RESULT = A * 3.
              GOBACK.

           CHECK-FOURS.
              MOVE NUMS(4:1) TO A.
              COMPUTE WS-RESULT = A * 4.
              GOBACK.           

           CHECK-FIVES.
              MOVE NUMS(5:1) TO A.
              COMPUTE WS-RESULT = A * 5.
              GOBACK.           

           CHECK-SIXES.
              MOVE NUMS(6:1) TO A.
              COMPUTE WS-RESULT = A * 6.
              GOBACK.           

           CHECK-FULL-HOUSE.
              IF NUMS(1:1)=3 OR NUMS(2:1)=3 OR NUMS(3:1)=3 OR 
                 NUMS(4:1)=3 OR NUMS(5:1)=3 OR NUMS(6:1)=3
                 IF NUMS(1:1)=2 OR NUMS(2:1)=2 OR NUMS(3:1)=2 OR 
                    NUMS(4:1)=2 OR NUMS(5:1)=2 OR NUMS(6:1)=2 
                    PERFORM VARYING ITER FROM 1 BY 1 UNTIL ITER=5
                       MOVE WS-DICE(ITER:1) TO A
                       ADD A TO WS-RESULT
                    END-PERFORM
                 END-IF
              END-IF.

           CHECK-4OFKIND.
              PERFORM VARYING ITER FROM 1 BY 1 UNTIL ITER = 6
                 IF NUMS(ITER:1) = 4
                    MOVE ITER TO A
                    COMPUTE WS-RESULT = 4 * ITER
                    GOBACK
                 END-IF
              END-PERFORM.

           CHECK-LITTLE-STRAIGHT.
              IF NUMS(1:1) = 1 AND NUMS(2:1) = 1 AND NUMS(3:1) = 1 AND  
                 NUMS(4:1) = 1 AND NUMS(5:1) = 1 AND NUMS(6:1) = 0
                 MOVE 30 TO WS-RESULT
                 GOBACK
              END-IF.

           CHECK-BIG-STRAIGHT.
              IF NUMS(1:1) = 0 AND NUMS(2:1) = 1 AND NUMS(3:1) = 1 AND  
                 NUMS(4:1) = 1 AND NUMS(5:1) = 1 AND NUMS(6:1) = 1
                 MOVE 30 TO WS-RESULT
                 GOBACK
              END-IF.

           CHOICE.
           PERFORM VARYING ITER FROM 1 BY 1 UNTIL ITER = 5
              MOVE WS-DICE(ITER:1) TO A
              ADD A TO WS-RESULT
              GOBACK
           END-PERFORM.

           CHECK-YACHT.
              IF NUMS(1:1) = 5 OR NUMS(2:1) = 5 OR NUMS(3:1) = 5 OR  
                 NUMS(4:1) = 5 OR NUMS(5:1) = 5 OR NUMS(6:1) = 5
                 MOVE 50 TO WS-RESULT
                 GOBACK
              END-IF.
             *> Dedicated to Shree DR.MDD
