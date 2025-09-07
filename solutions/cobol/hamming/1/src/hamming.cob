       *> For my Shree DR.MDD
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HAMMING.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-DNA-1      PIC X(32).
       01 WS-DNA-2      PIC X(32).
       01 WS-INDEX      PIC 9(2).
       01 WS-HAMMING    PIC 9(2).
       01 WS-ERROR      PIC X(31).

       PROCEDURE DIVISION.

       HAMMING.
           PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX = 32
              IF WS-DNA-1(WS-INDEX:1) = ' ' OR WS-DNA-2(WS-INDEX:1) = ' '
                 MOVE "Strands must be of equal length" TO WS-ERROR
                 GOBACK
              END-IF
           END-PERFORM.

           PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX = 32
              IF WS-DNA-1(WS-INDEX:1) = WS-DNA-2(WS-INDEX:1)
                 CONTINUE
              ELSE
                 ADD 1 TO WS-HAMMING
              END-IF
           END-PERFORM.

           DISPLAY "Hamming Distance is: " WS-HAMMING.
           DISPLAY WS-ERROR.
           GOBACK.
