       *> For my Shree DR.MDD
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ARMSTRONG-NUMBERS.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY. FUNCTION ALL INTRINSIC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-NUMBER        PIC X(8).
       01 WS-RESULT        PIC 9.
       01 NUM              PIC 9(8).
       01 LEN              PIC 9(2).
       01 TEMP             PIC 9(8) VALUE 0.
       01 EKSP             PIC 9(8) VALUE 0.
       01 A                PIC 9.

       PROCEDURE DIVISION.
       ARMSTRONG-NUMBERS.
           MOVE 0 TO EKSP.
           MOVE 0 TO TEMP.
           MOVE FUNCTION TRIM(WS-NUMBER) TO NUM.
           MOVE 1 TO LEN.
           PERFORM WITH TEST BEFORE UNTIL WS-NUMBER(LEN:1) = ' '
                 MOVE WS-NUMBER(LEN:1) TO A
                 ADD 1 TO EKSP
                 ADD 1 TO LEN
           END-PERFORM.
           MOVE 1 TO LEN.
           PERFORM WITH TEST BEFORE UNTIL WS-NUMBER(LEN:1) = ' '
                 MOVE WS-NUMBER(LEN:1) TO A
                 COMPUTE TEMP = TEMP + A ** EKSP
                 ADD 1 TO LEN
           END-PERFORM.
           IF TEMP = NUM
              MOVE 1 TO WS-RESULT
           ELSE
              MOVE 0 TO WS-RESULT
           END-IF.
