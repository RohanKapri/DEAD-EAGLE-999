       *> For my Shree DR.MDD
       IDENTIFICATION DIVISION.
       PROGRAM-ID. COLLATZ-CONJECTURE.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-NUMBER        PIC S9(8).
       01 WS-STEPS         PIC 9(4).
       01 WS-ERROR         PIC X(35).
       01 WS-REMAINDER     PIC 9(8).
       01 WS-TEMP          PIC 9(8).

       PROCEDURE DIVISION.
       COLLATZ-CONJECTURE.
           MOVE 0 TO WS-STEPS.
           IF WS-NUMBER < 1
               MOVE "Only positive integers are allowed" TO WS-ERROR
               GOBACK
           ELSE IF WS-NUMBER = 1
               GOBACK
           ELSE
               PERFORM DO-COLLATZ UNTIL WS-NUMBER = 0
           END-IF.
           DISPLAY WS-STEPS.
           DISPLAY WS-ERROR.
           GOBACK.

       DO-COLLATZ.
           ADD 1 TO WS-STEPS.
           DIVIDE WS-NUMBER BY 2 GIVING WS-TEMP REMAINDER WS-REMAINDER.
           IF WS-REMAINDER = 0
               DIVIDE WS-NUMBER BY 2 GIVING WS-NUMBER
           ELSE
               COMPUTE WS-NUMBER = 3 * WS-NUMBER + 1
           END-IF.
