       IDENTIFICATION DIVISION.
       PROGRAM-ID. two-fer.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-NAME PIC X(16).
       01 TRIMMED PIC X(16).
       01 WS-RESULT PIC X(64).
       01 WS-S1 PIC X(8) VALUE "One for ".
       01 WS-S2 PIC X(13) VALUE ", one for me.".
       
       PROCEDURE DIVISION.
       TWO-FER.
         MOVE FUNCTION TRIM(WS-NAME) TO TRIMMED.
         IF TRIMMED > SPACES
           MOVE FUNCTION CONCATENATE(WS-S1 FUNCTION TRIM(TRIMMED) WS-S2)
               TO WS-RESULT      
         ELSE
            MOVE "One for you, one for me." TO WS-RESULT
         END-IF.