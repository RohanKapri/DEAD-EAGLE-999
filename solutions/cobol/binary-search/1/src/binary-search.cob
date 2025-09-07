       IDENTIFICATION DIVISION.
       PROGRAM-ID. BINARY-SEARCH.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-ITEM                  PIC 9999.
       01 WS-RESULT                PIC 99.
       01 WS-ERROR                 PIC X(40).
       01 WS-COUNT                 PIC 99.    
       01 WS-ARRAY                 PIC X(60). 
       01 i                        PIC 99.
       01 WS-INDEX                 PIC 99.
       01 WS-TEMP                  PIC X(60).
       01 WS-LENGTH                PIC 99.

       PROCEDURE DIVISION.
       
       BINARY-SEARCH.
         MOVE 1 TO WS-INDEX
         MOVE SPACES TO WS-TEMP
         MOVE 0 TO WS-RESULT
         COMPUTE WS-LENGTH = FUNCTION LENGTH(FUNCTION TRIM(WS-ARRAY))
         PERFORM VARYING i FROM 1 BY 1 UNTIL i > WS-LENGTH
            IF WS-ARRAY(i:1) = ","
               IF FUNCTION NUMVAL(WS-TEMP) = WS-ITEM
                  MOVE WS-INDEX TO WS-RESULT
                  EXIT PERFORM
               END-IF
               MOVE SPACES TO WS-TEMP
               ADD 1 TO WS-INDEX
            ELSE
               STRING WS-TEMP DELIMITED BY SPACES
                  WS-ARRAY(i:1) DELIMITED BY SIZE
                  INTO WS-TEMP
            END-IF
         END-PERFORM
         IF FUNCTION NUMVAL(WS-TEMP) = WS-ITEM
            MOVE WS-INDEX TO WS-RESULT
         END-IF
         IF WS-RESULT = 0
            MOVE "value not in array" TO WS-ERROR
         END-IF.