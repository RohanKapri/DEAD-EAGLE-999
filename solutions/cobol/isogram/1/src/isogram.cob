       *> For my Shree DR.MDD
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ISOGRAM.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PHRASE       PIC X(60).
       01 WS-RESULT       PIC 99.
       01 IDX             PIC 9(2).
       01 WS-ALPHABET.
          05 WS-LTR       PIC X(1) OCCURS 26 TIMES INDEXED BY AL_IDX.
       01 WS-SEEN.
          05 WS-FLAG      PIC 9(1) OCCURS 26 TIMES INDEXED BY FL_IDX.
       01 WS-CURRENT      PIC X(1).

       PROCEDURE DIVISION.
       ISOGRAM.
           MOVE '11111111111111111111111111' TO WS-SEEN
           MOVE 'abcdefghijklmnopqrstuvwxyz' TO WS-ALPHABET
           PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > FUNCTION LENGTH(WS-PHRASE)
               MOVE FUNCTION LOWER-CASE(WS-PHRASE(IDX:1)) TO WS-CURRENT
               SET AL_IDX TO 1
               SEARCH WS-LTR
                  WHEN WS-LTR(AL_IDX) = WS-CURRENT
                     IF WS-FLAG(AL_IDX) = 0
                        MOVE 0 TO WS-RESULT
                        EXIT PERFORM
                     ELSE
                        MOVE 0 TO WS-FLAG(AL_IDX)
                     END-IF
               END-SEARCH
           END-PERFORM
           MOVE 1 TO WS-RESULT
           STOP RUN.
