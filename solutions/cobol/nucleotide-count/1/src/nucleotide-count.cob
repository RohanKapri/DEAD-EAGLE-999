       IDENTIFICATION DIVISION.
       PROGRAM-ID. nucleotide-count.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY. FUNCTION ALL INTRINSIC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-DNA PIC X(128).
       01 ITER PIC 9(3).
       01 A    PIC X.
       01 WS-A PIC 9(4).
       01 WS-C PIC 9(4).
       01 WS-G PIC 9(4).
       01 WS-T PIC 9(4).
       01 WS-ERROR PIC X(36).
       PROCEDURE DIVISION.
       NUCLEOTIDE-COUNT.
         MOVE 0 TO WS-A.
         MOVE 0 TO WS-C.
         MOVE 0 TO WS-G.
         MOVE 0 TO WS-T.
         PERFORM VARYING ITER FROM 1 BY 1 UNTIL ITER = 128
            MOVE WS-DNA(ITER:1) TO A
            EVALUATE A
               WHEN "A"
                  ADD 1 TO WS-A
               WHEN "C"
                  ADD 1 TO WS-C
               WHEN "G"
                  ADD 1 TO WS-G
               WHEN "T"
                  ADD 1 TO WS-T
               WHEN OTHER
                  MOVE "ERROR: Invalid nucleotide in strand" TO WS-ERROR
                  GOBACK
            END-EVALUATE
         END-PERFORM.