       IDENTIFICATION DIVISION.
       PROGRAM-ID. square-root.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-NUMBER    PIC 9(32).
       01 WS-SQRT      PIC 9(32). 
       01 X            PIC 9999999V99999999.
       01 Y            PIC 9999999V99999999.

       PROCEDURE DIVISION.
       SQUARE-ROOT.
           MOVE WS-NUMBER TO X.
           MOVE 0 TO Y.
           PERFORM 200 TIMES
              COMPUTE Y = 0.5 * (X + WS-NUMBER / X)
              MOVE Y TO X
           END-PERFORM.
           MOVE Y TO WS-SQRT.
