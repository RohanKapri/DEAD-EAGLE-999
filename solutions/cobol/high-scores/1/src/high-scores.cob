       *> For my Shree DR.MDD
       IDENTIFICATION DIVISION.
       PROGRAM-ID. high-scores.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PROPERTY       PIC A(20).
       01 WS-SCORES.
           02 SCORES        PIC X(3) OCCURS 20 TIMES
                            INDEXED BY IDX.

       01 WS-RESULT-STRING  PIC X(60).
       01 WS-RESULT-VALUE   PIC 999.
       
       01 CONTADOR          PIC 99.
       01 TEMP              PIC ZZ9.
       01 TEMP2             PIC 999.
       01 LATEST-VAL        PIC 999.
       01 PERSONAL-BEST      PIC 999.
       01 PERSONAL-TOP3.
           05 TOP3          PIC ZZZ OCCURS 3 TIMES.

       PROCEDURE DIVISION.
             
       HIGH-SCORES.
         
       INITIALIZE TEMP CONTADOR LATEST-VAL PERSONAL-BEST PERSONAL-TOP3
                  WS-RESULT-STRING WS-RESULT-VALUE.
         
       PERFORM VARYING CONTADOR FROM 1 BY 1 UNTIL CONTADOR > 20
         MOVE SCORES(CONTADOR) TO TEMP
         EVALUATE TEMP
           WHEN > TOP3(1)
             MOVE TOP3(2) TO TOP3(3)
             MOVE TOP3(1) TO TOP3(2)
             MOVE TEMP      TO TOP3(1)
           WHEN > TOP3(2)
             MOVE TOP3(2) TO TOP3(3)
             MOVE TEMP      TO TOP3(2)
           WHEN > TOP3(3)
             MOVE TEMP      TO TOP3(3)
         END-EVALUATE
         
         MOVE TEMP TO TEMP2
         IF TEMP2 > 0 THEN MOVE TEMP2 TO LATEST-VAL END-IF
       END-PERFORM.
       MOVE TOP3(1) TO PERSONAL-BEST.
       
       EVALUATE WS-PROPERTY
         WHEN "scores"
           STRING WS-SCORES DELIMITED BY SIZE INTO WS-RESULT-STRING
         WHEN "latest"
           MOVE LATEST-VAL TO WS-RESULT-VALUE
         WHEN "personalBest"
           MOVE PERSONAL-BEST TO WS-RESULT-VALUE
         WHEN "personalTopThree"
           MOVE PERSONAL-TOP3 TO WS-RESULT-STRING
       END-EVALUATE.
