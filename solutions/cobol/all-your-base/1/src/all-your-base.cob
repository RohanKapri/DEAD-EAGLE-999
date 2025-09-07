       IDENTIFICATION DIVISION.
       PROGRAM-ID. ALL-YOUR-BASE.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-INPUTBASE          PIC s9(02) VALUE ZEROS.
       01 WS-OUTPUTBASE         PIC s9(02) VALUE ZEROS.
       01 WS-DIGITS            PIC X(15) VALUE SPACES.
       01 WS-RESULT            PIC X(30) VALUE SPACES.
       01 WS-RES          PIC X(30) VALUE SPACES.

       01 WS-LEN               PIC 9(02) VALUE ZEROS.
       01 DIGITS.
          02 WS-DIGIT  OCCURS 9 PIC 9(02) VALUE ZEROS.
          02 WS-DIGIT-X REDEFINES WS-DIGIT PIC X(02).
       01 WS-ERROR             PIC X(45) VALUE SPACES.
       01 WS-D                 PIC 99.
       01 WS-E   REDEFINES WS-D PIC X(2).
       01 I                    PIC 9(02) VALUE ZEROS.
       01 DIGIT-X              PIC X(02) VALUE SPACES.
       01 REST                 PIC X(15) VALUE ZEROS.
       01 WS-BASE10            PIC 9(8) VALUE ZEROS.
       01 WS-GIVING            PIC 9(03) VALUE ZEROS.
       01 WS-REMAINDER         PIC 9(03) VALUE ZEROS.
       01 WS-TEMP              PIC Z(8).
       01 WS-A                 PIC X(8).
       01 WS-J                 PIC 9(2).
       01 WS-I                 PIC 9(2).
       01 WS-OUT               PIC 9(2).
  
       PROCEDURE DIVISION.
       REBASE.
           MOVE SPACES                 TO WS-RESULT 
                                          WS-ERROR
           MOVE ZEROS                  TO WS-BASE10
                                          DIGITS
                                          WS-REMAINDER
           MOVE 1                      TO WS-LEN
           EVALUATE TRUE
              WHEN WS-INPUTBASE < 2
                 MOVE 'input base must be >= 2'  
                       TO WS-ERROR
              WHEN WS-OUTPUTBASE <  2
                 MOVE 'output base must be >= 2' 
                       TO WS-ERROR
              WHEN WS-DIGITS EQUAL TO SPACE
                 MOVE "0" TO WS-RESULT
              WHEN WS-DIGITS = "0"
                 MOVE "0" TO WS-RESULT
              WHEN WS-DIGITS = "0,0,0"
                 MOVE "0" TO WS-RESULT
              WHEN OTHER
                 INSPECT WS-DIGITS TALLYING 
                    WS-LEN FOR ALL ','
                 PERFORM TO-BASE-10
                 IF WS-OUTPUTBASE NOT EQUAL TO 10
                     PERFORM CHANGE-BASE
                 ELSE
                     MOVE SPACES TO WS-RESULT WS-A 
                     MOVE WS-BASE10 TO WS-TEMP
                     MOVE WS-TEMP TO WS-A
                     MOVE ZERO TO WS-J
                     PERFORM VARYING WS-I FROM 1 BY 1
                       UNTIL WS-I>8
                   IF WS-A(WS-I:1) NOT EQUAL TO SPACES
                         ADD 1 TO WS-J
                        MOVE WS-A(WS-I:1) TO WS-RESULT(WS-J:1)
                        ADD 1 TO WS-I
                   IF WS-A(WS-I: 1) IS NUMERIC
                          ADD 1 TO WS-J 
                          MOVE "," TO WS-RESULT(WS-J:1)
                    END-IF
                    SUBTRACT 1 FROM WS-I
                   END-IF
               END-PERFORM
               
           END-EVALUATE
           MOVE FUNCTION TRIM(WS-RESULT) TO WS-RESULT
           DISPLAY WS-RESULT

           EXIT PROGRAM.
       CHANGE-BASE.
         MOVE 99 TO WS-REMAINDER WS-GIVING
                 MOVE SPACES TO WS-RESULT WS-RES
                 MOVE 1 TO WS-OUT
                 PERFORM VARYING I FROM 1 BY 1
                         UNTIL 
                        (WS-GIVING < WS-OUTPUTBASE)
                    DIVIDE WS-BASE10 BY 
                           WS-OUTPUTBASE
                           GIVING WS-GIVING
                           REMAINDER WS-REMAINDER
                          MOVE WS-REMAINDER  TO WS-D

                    MOVE WS-GIVING  TO WS-BASE10

                     IF WS-d < 10
                         STRING WS-E(2:1) "," DELIMITED BY
                            SIZE
                             WS-RESULT DELIMITED BY SPACES
                             INTO WS-RES
                           MOVE WS-RES TO WS-RESULT
                     END-IF
                     IF WS-D >= 10 
                          STRING WS-E ","
                             WS-RESULT DELIMITED BY SPACES
                             INTO WS-RES
                           MOVE WS-RES TO WS-RESULT
                     END-IF 
                     
                   IF I=1
                      INSPECT WS-RESULT 
                        REPLACING all ',' BY "" 

                              END-IF
                    MOVE FUNCTION TRIM(WS-RESULT) TO
                            WS-RESULT
                 END-PERFORM
                 MOVE WS-BASE10       TO WS-D
                    IF WS-d < 10
                         STRING WS-E(2:1) "," DELIMITED BY
                            SIZE
                             WS-RESULT DELIMITED BY SPACES
                             INTO WS-RES
                           MOVE WS-RES TO WS-RESULT
                     END-IF
                     IF WS-D >10 
                          STRING WS-E ","
                             WS-RESULT DELIMITED BY SPACES
                             INTO WS-RES
                           MOVE WS-RES TO WS-RESULT
                     END-IF 

                       
            .
       TO-BASE-10.
           PERFORM VARYING I FROM WS-LEN BY -1 
                         UNTIL (I = ZEROS)
              INSPECT WS-DIGITS 
                      REPLACING FIRST ','
                      BY '/'
              UNSTRING WS-DIGITS 
                       DELIMITED BY '/' 
                       INTO DIGIT-X REST
              MOVE REST                TO WS-DIGITS
              MOVE FUNCTION NUMVAL(DIGIT-X) TO 
                            WS-DIGIT(I)
              IF WS-DIGIT(I) < 0 or WS-DIGIT(I) <
                        WS-INPUTBASE
           MOVE 
         "all digits must satisfy 0 <= d < input base"
                TO WS-ERROR
              END-IF
              COMPUTE WS-BASE10 = WS-BASE10 + 
                  WS-DIGIT(I) * WS-INPUTBASE**(I - 1)
           END-PERFORM.