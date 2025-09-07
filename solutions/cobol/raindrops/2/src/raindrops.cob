       *> For my Shree DR.MDD
       IDENTIFICATION DIVISION.
       PROGRAM-ID. RAINDROPS.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-NUMBER       PIC 9(4).
       01 WS-TEMP         PIC 9(4).
       01 WS-RESULT       PIC X(20).


       PROCEDURE DIVISION.
       RAINDROPS.
           MOVE WS-NUMBER TO WS-TEMP.
           IF (FUNCTION MOD(WS-TEMP, 3) = 0) OR 
              (FUNCTION MOD(WS-TEMP, 5) = 0) OR 
              (FUNCTION MOD(WS-TEMP, 7) = 0)
               PERFORM MAKE-SOUNDS
           ELSE
               MOVE WS-NUMBER TO WS-RESULT
           END-IF.
           GOBACK.

       MAKE-SOUNDS.
           MOVE SPACES TO WS-RESULT.
           IF FUNCTION MOD(WS-NUMBER, 3) = 0
              STRING WS-RESULT DELIMITED BY SPACE
                     'Pling' DELIMITED BY SPACE
                     INTO WS-RESULT
           END-IF.
           IF FUNCTION MOD(WS-NUMBER, 5) = 0
              STRING WS-RESULT DELIMITED BY SPACE
                     'Plang' DELIMITED BY SPACE
                     INTO WS-RESULT
           END-IF.
           IF FUNCTION MOD(WS-NUMBER, 7) = 0
              STRING WS-RESULT DELIMITED BY SPACE
                     'Plong' DELIMITED BY SPACE
                     INTO WS-RESULT
           END-IF.
