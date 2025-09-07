       *> For my Shree DR.MDD
       IDENTIFICATION DIVISION.
       PROGRAM-ID. QUEEN-ATTACK.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-QUEEN        PIC X(9).
       01 WS-WHITE_QUEEN  PIC X(9).
       01 WS-BLACK_QUEEN  PIC X(9).
       01 WS-PROPERTY     PIC X(11).
       01 WS-RESULT       PIC 9.
       01 Q1-ROW          PIC 9.
       01 Q1-COL          PIC 9.
       01 Q2-ROW          PIC 9.
       01 Q2-COL          PIC 9.
       01 I               PIC 9(2).
       01 X               PIC 9(2).
       01 Y               PIC 9(2).

       PROCEDURE DIVISION.
       QUEEN-ATTACK.
           IF WS-PROPERTY = "create"
              UNSTRING WS-QUEEN DELIMITED BY ',' INTO Q1-ROW, Q1-COL
              IF Q1-ROW < 0 OR Q1-ROW > 7
                 MOVE 0 TO WS-RESULT
                 GOBACK
              ELSE IF Q1-COL < 0 OR Q1-COL > 7
                 MOVE 0 TO WS-RESULT
                 GOBACK
              END-IF
           ELSE
              UNSTRING WS-WHITE_QUEEN DELIMITED BY ',' INTO Q1-ROW, Q1-COL
              UNSTRING WS-BLACK_QUEEN DELIMITED BY ',' INTO Q2-ROW, Q2-COL
              IF Q1-ROW = Q2-ROW OR Q1-COL = Q2-COL
                 MOVE 1 TO WS-RESULT
                 GOBACK
              ELSE
                 PERFORM VARYING I FROM 0 BY 1 UNTIL I = 8
                    ADD I TO Q1-COL GIVING X
                    IF Q2-COL = X
                       ADD I TO Q1-ROW GIVING Y
                       IF Q2-ROW = Y
                          MOVE 1 TO WS-RESULT
                          GOBACK
                       END-IF
                       SUBTRACT I FROM Q1-ROW GIVING Y
                       IF Q2-ROW = Y
                          MOVE 1 TO WS-RESULT
                          GOBACK
                       END-IF
                    END-IF
                 END-PERFORM
                 PERFORM VARYING I FROM 0 BY 1 UNTIL I = 8
                    SUBTRACT I FROM Q1-COL GIVING X
                    IF Q2-COL = X
                       ADD I TO Q1-ROW GIVING Y
                       IF Q2-ROW = Y
                          MOVE 1 TO WS-RESULT
                          GOBACK
                       END-IF
                       SUBTRACT I FROM Q1-ROW GIVING Y
                       IF Q2-ROW = Y
                          MOVE 1 TO WS-RESULT
                          GOBACK
                       END-IF
                    END-IF
                 END-PERFORM
              END-IF
           END-IF.
