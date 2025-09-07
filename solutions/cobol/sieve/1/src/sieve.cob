       *> For my Shree DR.MDD
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SIEVE.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-LIMIT       PIC 9999.
       01 WS-RESULT      PIC 999 OCCURS 1000 TIMES. 
       01 WS-COUNT       PIC 9999 VALUE 0.
       01 TEMP           PIC 999 OCCURS 1000 TIMES VALUE 1. 
       01 ITER1          PIC 9999.
       01 ITER2          PIC 9999.
       01 NUM            PIC 9999.

       PROCEDURE DIVISION.
       SIEVE.
           IF WS-LIMIT IS LESS THAN OR EQUAL TO 1
               GOBACK
           END-IF.
           PERFORM VARYING ITER1 FROM 1 BY 1 UNTIL ITER1 = 1000
               MOVE 0 TO WS-RESULT(ITER1)
           END-PERFORM.
           PERFORM VARYING NUM FROM 2 BY 1 UNTIL NUM = 1000
               ADD 1 TO NUM GIVING ITER2
               PERFORM VARYING ITER1 FROM ITER2 BY 1 UNTIL ITER1 = 1000
                   IF FUNCTION MOD(ITER1, NUM) = 0
                       MOVE 0 TO TEMP(ITER1)
                   END-IF
               END-PERFORM
           END-PERFORM.
           MOVE 1 TO NUM.
           PERFORM VARYING ITER1 FROM 2 BY 1 UNTIL ITER1 = WS-LIMIT
               IF TEMP(ITER1) = 1
                   MOVE ITER1 TO WS-RESULT(NUM)
                   ADD 1 TO NUM
                   ADD 1 TO WS-COUNT
               END-IF
           END-PERFORM.
