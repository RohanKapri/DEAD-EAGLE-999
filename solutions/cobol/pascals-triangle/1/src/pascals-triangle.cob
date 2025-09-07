       IDENTIFICATION DIVISION.
       PROGRAM-ID. PASCALS-TRIANGLE.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-COUNT               PIC 99.
       
       01 WS-RESULT. 
         02 WS-ROW               OCCURS 1 TO 99 DEPENDING ON WS-COUNT.
            05 ROWELEM           PIC X(60).

      * Tableau pour stocker le triangle
       01  PASCAL-TABLE.
           02  PASCAL-ROW OCCURS 10 TIMES.
               05  PASCAL-COLUMN OCCURS 10 TIMES PIC 9(5) VALUE 0.

       01 i                       PIC 99.
       01 j                       PIC 99.
       01 CALC-RES                PIC 9(5).
       01 TEMP                    PIC X(5).
       
       PROCEDURE DIVISION.
       
       ROWS.
         MOVE SPACE TO WS-RESULT
         PERFORM VARYING i FROM 1 BY 1 UNTIL i > WS-COUNT
            MOVE 1 TO PASCAL-COLUMN (i, 1)
            MOVE 1 TO PASCAL-COLUMN (i, i)

            IF i > 2
               PERFORM VARYING j FROM 2 BY 1 UNTIL j >= i
                  COMPUTE PASCAL-COLUMN(i, j) = 
                     PASCAL-COLUMN(i - 1 , j - 1) + PASCAL-COLUMN(i - 1, j)
               END-PERFORM
            END-IF
         END-PERFORM
      * formatter le triangle
         PERFORM VARYING i FROM 1 BY 1 UNTIL i > WS-COUNT
            MOVE 1 TO ROWELEM(i)
            PERFORM VARYING j FROM 2 BY 1 UNTIL j > i
               IF PASCAL-COLUMN(i, j) >= 100
                  STRING FUNCTION TRIM(ROWELEM(i))
                     ","
                     PASCAL-COLUMN(i, j)(3:3)
                     INTO ROWELEM(i)
               ELSE IF PASCAL-COLUMN(i, j) >= 10
                  STRING FUNCTION TRIM(ROWELEM(i))
                     ","
                     PASCAL-COLUMN(i, j)(4:2)
                     INTO ROWELEM(i)
               ELSE
                  STRING FUNCTION TRIM(ROWELEM(i))
                     ","
                     PASCAL-COLUMN(i, j)(5:1)
                     INTO ROWELEM(i)
               
            END-PERFORM
         END-PERFORM.
         