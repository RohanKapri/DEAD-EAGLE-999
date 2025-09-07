       *> For my Shree DR.MDD
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TRIANGLE.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-SIDES            PIC X(20).
       01 WS-PROPERTY         PIC X(11).
       01 WS-RESULT           PIC 9.
       01 WS-A                PIC 99V9.
       01 WS-B                PIC 99V9.
       01 WS-C                PIC 99V9.
       01 TEMP                PIC 99V9.
       01 TRIANG              PIC 9.

       PROCEDURE DIVISION.
       TRIANGLE.
           UNSTRING WS-SIDES DELIMITED BY ',' INTO WS-A, WS-B, WS-C
           PERFORM CHECK-IF-TRIANGLE.
           IF TRIANG = 1
               EVALUATE WS-PROPERTY
                   WHEN 'scalene'
                       IF WS-A <> WS-B AND WS-A <> WS-C AND WS-B <> WS-C
                           MOVE 1 TO WS-RESULT
                       ELSE
                           MOVE 0 TO WS-RESULT
                       END-IF
                   WHEN 'equilateral'
                       IF WS-A = WS-B AND WS-A = WS-C
                           MOVE 1 TO WS-RESULT
                       ELSE
                           MOVE 0 TO WS-RESULT
                       END-IF
                   WHEN 'isosceles'
                       IF (WS-A = WS-B AND WS-A <> WS-C) OR
                          (WS-A = WS-C AND WS-A <> WS-B) OR
                          (WS-B = WS-C AND WS-A <> WS-C)
                           MOVE 1 TO WS-RESULT
                       ELSE
                           MOVE 0 TO WS-RESULT
                       END-IF
               END-EVALUATE
           ELSE
               MOVE 0 TO WS-RESULT
           END-IF.

       CHECK-IF-TRIANGLE.
           MOVE 0 TO TEMP.
           ADD WS-A TO WS-B GIVING TEMP
           IF TEMP >= WS-C
               MOVE 0 TO TEMP
               ADD WS-A TO WS-C GIVING TEMP
               IF TEMP >= WS-B
                   MOVE 0 TO TEMP
                   ADD WS-B TO WS-C GIVING TEMP
                   IF TEMP >= WS-A
                       MOVE 1 TO TRIANG
                       EXIT SECTION
                   END-IF
               ELSE
                   MOVE 0 TO TRIANG
                   GOBACK
               END-IF
           ELSE
               MOVE 0 TO TRIANG
               GOBACK
           END-IF.
