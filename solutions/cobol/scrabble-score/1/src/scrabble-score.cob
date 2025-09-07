       *> For my Shree DR.MDD
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SCRABBLE-SCORE.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 ITER      PIC 9(2).
       01 CHK       PIC X.
       01 WS-WORD   PIC X(60).
       01 WS-RESULT PIC 99.

       PROCEDURE DIVISION.
       SCRABBLE-SCORE.
         MOVE 0 TO WS-RESULT.
         IF FUNCTION LENGTH(WS-WORD) IS GREATER THAN 0
            PERFORM VARYING ITER FROM 1 BY 1 UNTIL WS-WORD(ITER:1) = ' '
               MOVE FUNCTION UPPER-CASE(WS-WORD(ITER:1)) TO CHK
               EVALUATE TRUE
                  WHEN CHK = "A" OR CHK = "E" OR CHK = "I" OR CHK = "O"
                     ADD 1 TO WS-RESULT
                  WHEN CHK = "N" OR CHK = "R" OR CHK = "S" OR CHK = "T"
                     ADD 1 TO WS-RESULT
                  WHEN CHK = "U" OR CHK = "L" 
                     ADD 1 TO WS-RESULT
                  WHEN CHK = "D" OR CHK = "G"
                     ADD 2 TO WS-RESULT
                  WHEN CHK = "B" OR CHK = "C" OR CHK = "M" OR CHK = "P"
                     ADD 3 TO WS-RESULT
                  WHEN CHK = "F" OR CHK = "H" OR CHK = "V" 
                     ADD 4 TO WS-RESULT
                  WHEN CHK = "W" OR CHK = "Y"
                     ADD 4 TO WS-RESULT
                  WHEN CHK = "K"
                     ADD 5 TO WS-RESULT
                  WHEN CHK = "J" OR CHK = "X"
                     ADD 8 TO WS-RESULT
                  WHEN CHK = "Q" OR CHK = "Z"
                     ADD 10 TO WS-RESULT
               END-EVALUATE
            END-PERFORM
         END-IF.
