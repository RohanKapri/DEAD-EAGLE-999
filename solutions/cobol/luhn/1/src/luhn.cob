       IDENTIFICATION DIVISION.
       PROGRAM-ID. luhn.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY. FUNCTION ALL INTRINSIC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-CARD-NUMBER PIC X(32).
       01 WS-CARD-DIGITS PIC 9(32).  *> I don't use this variable.
       01 WS-CHECKSUM PIC 9(2).      *> I don't use this variable.
       01 WS-VALID PIC X(5).
          88 VALID-DIGITS VALUE "VALID".
          88 INVALID-DIGITS VALUE "FALSE".
       01 LEN PIC 99 BINARY VALUE 32.
       01 EVEN-DIGIT PIC 9 BINARY.
       01 NUM-OF-DIGITS PIC 99 BINARY.
       01 TOTAL PIC 999 BINARY.
       01 I PIC 99 BINARY.
       01 CHR PIC X.
       01 DIGIT PIC 99 BINARY.
       PROCEDURE DIVISION.
       LUHN.
           SET VALID-DIGITS TO TRUE
           MOVE 0 TO TOTAL
           MOVE 0 TO EVEN-DIGIT
           MOVE 0 TO NUM-OF-DIGITS
           PERFORM VARYING I FROM LEN BY -1 UNTIL I < 1
              MOVE WS-CARD-NUMBER(I:1) TO CHR
              EVALUATE TRUE
                 WHEN CHR = SPACE 
                    CONTINUE
                 WHEN CHR IS NUMERIC 
                    MOVE CHR TO DIGIT 
                    ADD 1 TO NUM-OF-DIGITS
                    IF EVEN-DIGIT = 1 THEN 
                       MULTIPLY 2 BY DIGIT 
                       IF DIGIT > 9 THEN 
                          SUBTRACT 9 FROM DIGIT
                       END-IF
                    END-IF 
                    ADD DIGIT TO TOTAL 
                    COMPUTE EVEN-DIGIT = 1 - EVEN-DIGIT 
                 WHEN OTHER
                    SET INVALID-DIGITS TO TRUE
                    EXIT PARAGRAPH
              END-EVALUATE
           END-PERFORM 
           IF NUM-OF-DIGITS <= 1 OR FUNCTION MOD(TOTAL, 10) <> 0 THEN 
              SET INVALID-DIGITS TO TRUE
           END-IF.