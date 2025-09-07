       IDENTIFICATION DIVISION.
       PROGRAM-ID. ROBOT-SIMULATOR.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-X-COORD               PIC S999.
       01 WS-Y-COORD               PIC S999.
       01 WS-DIRECTION             PIC X(20).
       01 WS-INSTRUCTIONS          PIC X(60) VALUE SPACES.
       01 WS-NEXT-INSTRUCTION      PIC X.
       01 WS-INDEX                 PIC 99 VALUE 1.
       PROCEDURE DIVISION.
       
       CREATE-ROBOT.

       MOVE-ROBOT.
       PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL 
        WS-INSTRUCTIONS(WS-INDEX:1) = ' '
             MOVE WS-INSTRUCTIONS(WS-INDEX:1) TO WS-NEXT-INSTRUCTION
             EVALUATE WS-NEXT-INSTRUCTION
                WHEN 'A'
                   EVALUATE WS-DIRECTION
                      WHEN 'north'
                        ADD 1 TO WS-Y-COORD
                      WHEN 'south'
                        SUBTRACT 1 FROM WS-Y-COORD
                      WHEN 'west'
                        SUBTRACT 1 FROM WS-X-COORD
                      WHEN 'east'
                        ADD 1 TO WS-X-COORD
                   END-EVALUATE
                WHEN 'R'
                  EVALUATE WS-DIRECTION
                     WHEN 'north'
                        MOVE 'east' TO WS-DIRECTION
                     WHEN 'east'
                        MOVE 'south' TO WS-DIRECTION
                     WHEN 'south'
                        MOVE 'west' TO WS-DIRECTION
                     WHEN 'west'
                        MOVE 'north' TO WS-DIRECTION
                  END-EVALUATE
                WHEN 'L'
                  EVALUATE WS-DIRECTION
                     WHEN 'north'
                        MOVE 'west' TO WS-DIRECTION
                     WHEN 'east'
                        MOVE 'north' TO WS-DIRECTION
                     WHEN 'south'
                        MOVE 'east' TO WS-DIRECTION
                     WHEN 'west'
                        MOVE 'south' TO WS-DIRECTION
             END-EVALUATE
            
       END-PERFORM.
       DISPLAY WS-DIRECTION.
            