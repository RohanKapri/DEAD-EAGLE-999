       *> For my Shree DR.MDD
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ATBASH-CIPHER.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PHRASE                 PIC X(60).
       01 WS-RESULT                 PIC X(60).
       01 WS-ABC                    PIC X(36) VALUE "abcdefghijklmnopqrstuvwxyz0123456789".
       01 WS-ZYX                    PIC X(36) VALUE "zyxwvutsrqponmlkjihgfedcba0123456789".
       01 CNT                       PIC 999.
       01 TXT-LEN                   PIC 999.
       01 IDX                       PIC 999.
       01 CHR                       PIC X.
       01 PICKNEXT                  PIC 9.

       PROCEDURE DIVISION.

       ENCODE.
           PERFORM STR-LENGTH.
           MOVE FUNCTION LOWER-CASE(WS-PHRASE) TO WS-PHRASE.
           MOVE 0 TO PICKNEXT.
           MOVE 1 TO IDX.
           MOVE SPACES TO WS-RESULT.
           PERFORM VARYING CNT FROM 1 BY 1 UNTIL CNT = TXT-LEN
               MOVE WS-PHRASE(CNT:1) TO CHR
               EVALUATE CHR
                   WHEN "," 
                     CONTINUE
                   WHEN " " 
                     CONTINUE
                   WHEN "." 
                     CONTINUE
                   WHEN OTHER
                     IF PICKNEXT = 5
                       MOVE " " TO WS-RESULT(IDX:1)
                       ADD 1 TO IDX
                       MOVE 1 TO PICKNEXT
                       MOVE CHR TO WS-RESULT(IDX:1)
                       ADD 1 TO IDX
                     ELSE
                       ADD 1 TO PICKNEXT
                       MOVE CHR TO WS-RESULT(IDX:1)
                       ADD 1 TO IDX
                     END-IF
               END-EVALUATE
           END-PERFORM.
           INSPECT WS-RESULT CONVERTING WS-ABC TO WS-ZYX.

       DECODE.
           PERFORM STR-LENGTH.
           MOVE FUNCTION LOWER-CASE(WS-PHRASE) TO WS-PHRASE.
           MOVE 1 TO IDX.
           MOVE SPACES TO WS-RESULT.
           PERFORM VARYING CNT FROM 1 BY 1 UNTIL CNT = TXT-LEN
               MOVE WS-PHRASE(CNT:1) TO CHR
               EVALUATE CHR
                   WHEN "," 
                     CONTINUE
                   WHEN " " 
                     CONTINUE
                   WHEN "." 
                     CONTINUE
                   WHEN OTHER
                       MOVE CHR TO WS-RESULT(IDX:1)
                       ADD 1 TO IDX
               END-EVALUATE
           END-PERFORM.
           INSPECT WS-RESULT CONVERTING WS-ZYX TO WS-ABC.

       STR-LENGTH.
           MOVE 0 TO TXT-LEN.
           PERFORM VARYING CNT FROM FUNCTION LENGTH(WS-PHRASE)
                   BY -1 UNTIL WS-PHRASE(CNT:1) <> " "
               ADD 1 TO TXT-LEN
           END-PERFORM.
           COMPUTE TXT-LEN = FUNCTION LENGTH(WS-PHRASE) - TXT-LEN + 1.
