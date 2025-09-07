       IDENTIFICATION DIVISION.
       PROGRAM-ID. LEAP.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           01 WS-RESULT PIC 9.
           01 WS-YEAR   PIC 9(4).

       PROCEDURE DIVISION.
       LEAP.
           IF FUNCTION MOD(WS-YEAR, 4) = 0
              IF FUNCTION MOD(WS-YEAR, 100) = 0
                 IF FUNCTION MOD(WS-YEAR, 400) = 0
                    MOVE 1 TO WS-RESULT
                    GO TO LEAP-EXIT
                 ELSE
                    MOVE 0 TO WS-RESULT
                    GO TO LEAP-EXIT
                 END-IF
                 MOVE 0 TO WS-RESULT
                 GO TO LEAP-EXIT
              ELSE
                 MOVE 1 TO WS-RESULT
                 GO TO LEAP-EXIT              
              END-IF
           END-IF.
           CONTINUE.

       LEAP-EXIT.
           EXIT.
       *> Dedicated to Shree DR.MDD
