       *> For my Shree DR.MDD
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BOB.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-HEYBOB                PIC X(60).
       01 UPCASE                   PIC X(60).
       01 PUNCTUATION              PIC X.
       01 LEN                      PIC 9(2).
       01 TEMP-COUNTER             PIC 9(2).
       01 WS-RESULT                PIC X(40).
       01 TEMP-CHAR                PIC X.
       01 ONLY-NUMS                PIC 9 VALUE 1.

       PROCEDURE DIVISION.
       BOB.
           MOVE FUNCTION UPPER-CASE(WS-HEYBOB) TO UPCASE.
           MOVE FUNCTION TRIM(WS-HEYBOB) TO WS-HEYBOB.
           MOVE FUNCTION LENGTH(WS-HEYBOB) TO LEN.
           SUBTRACT 1 FROM LEN.
           MOVE WS-HEYBOB(LEN:1) TO PUNCTUATION.
           ADD 1 TO LEN.
           PERFORM CHECK-ONLY-NUMS.
           PERFORM PROCESS-RESPONSE.
       PROCESS-RESPONSE.
           EVALUATE TRUE
               WHEN LEN = 0
                   MOVE "Fine. Be that way!" TO WS-RESULT
               WHEN PUNCTUATION = '?'
                   IF WS-HEYBOB = UPCASE
                       MOVE "Calm down, I know what I'm doing!" TO WS-RESULT
                   ELSE
                       MOVE "Sure." TO WS-RESULT
                   END-IF
               WHEN ONLY-NUMS = 1
                   MOVE "Whatever." TO WS-RESULT
               WHEN WS-HEYBOB = UPCASE
                   MOVE "Whoa, chill out!" TO WS-RESULT
               WHEN OTHER
                   MOVE "Whatever." TO WS-RESULT
           END-EVALUATE.
           GOBACK.
       CHECK-ONLY-NUMS.
           PERFORM VARYING TEMP-COUNTER FROM 1 BY 1 UNTIL TEMP-COUNTER = LEN
               MOVE WS-HEYBOB(TEMP-COUNTER:1) TO TEMP-CHAR
               IF TEMP-CHAR = '0' OR TEMP-CHAR = '1' OR TEMP-CHAR = '2' OR TEMP-CHAR = '3'
                  OR TEMP-CHAR = '4' OR TEMP-CHAR = '5' OR TEMP-CHAR = '6' OR TEMP-CHAR = '7'
                  OR TEMP-CHAR = '8' OR TEMP-CHAR = '9'
                   COMPUTE ONLY-NUMS = ONLY-NUMS * 1
               ELSE
                   COMPUTE ONLY-NUMS = ONLY-NUMS * 0
               END-IF
           END-PERFORM.
