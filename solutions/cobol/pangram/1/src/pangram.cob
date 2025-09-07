        IDENTIFICATION DIVISION.
        PROGRAM-ID. PANGRAM.
        ENVIRONMENT DIVISION.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01 WS-SENTENCE PIC X(60).
        01 WS-RESULT   PIC 9.
        01 ITER        PIC 9(2).
        01 WS-TABLE.
           05 WS-A PIC X(1) OCCURS 26 TIMES INDEXED BY I.
        01 WS-CHECK.   
           05 WS-B PIC 9(1) OCCURS 26 TIMES INDEXED BY J.
        01 WS-SRCH PIC X(1).

       PROCEDURE DIVISION.
       PANGRAM.
           MOVE '11111111111111111111111111' TO WS-CHECK.
           MOVE 'abcdefghijklmnopqrstuvwxyz' TO WS-TABLE.
           PERFORM SEARCH-CHAR VARYING ITER FROM 1 BY 1 UNTIL ITER = 60.

           SET I TO 1.
           SET J TO I.
           MOVE "1" TO WS-SRCH.
           SEARCH WS-B
              AT END MOVE 1 TO WS-RESULT
              WHEN WS-B(I) = WS-SRCH
                 MOVE 0 TO WS-RESULT
           END-SEARCH.           
           STOP RUN.

       SEARCH-CHAR.
           SET I TO 1.
           SET J TO I.
           MOVE WS-SENTENCE(ITER:1) TO WS-SRCH.
           SEARCH WS-A
              WHEN WS-A(I) = WS-SRCH
                 MOVE 0 TO WS-B(I)
           END-SEARCH.
        
        