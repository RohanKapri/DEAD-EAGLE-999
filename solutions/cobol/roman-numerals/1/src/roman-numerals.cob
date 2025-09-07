       *> For my Shree DR.MDD
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ROMAN-NUMERALS.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-NUMBER       PIC 9999.
       01 WS-RESULT       PIC X(20).

       01 WS-ROMAN-TBL.
         05 FILLER       PIC X(20) VALUE "M    C    X    I    ".
         05 FILLER       PIC X(20) VALUE "MM   CC   XX   II   ".
         05 FILLER       PIC X(20) VALUE "MMM  CC   XXX  III  ".
         05 FILLER       PIC X(20) VALUE "     CD   XL   IV   ".
         05 FILLER       PIC X(20) VALUE "     D    L    V    ".
         05 FILLER       PIC X(20) VALUE "     DC   LX   VI   ".
         05 FILLER       PIC X(20) VALUE "     DCC  LXX  VII  ".
         05 FILLER       PIC X(20) VALUE "     DCCC LXXX VIII ".
         05 FILLER       PIC X(20) VALUE "     CM   XC   IX   ".
       01 FILLER REDEFINES WS-ROMAN-TBL.
         05 FILLER OCCURS 10 TIMES.
            10 WS-TBL-ROW-COL OCCURS 4 TIMES.
               15 FILLER PIC X(5).

       01 IDX-ROW        PIC 9.
       01 IDX-COL        PIC 9.
       01 POINTER-OUT    PIC 99.

       PROCEDURE DIVISION.
       ROMAN-NUMERALS.
         INITIALIZE WS-RESULT, IDX-ROW, IDX-COL
         MOVE 1 TO POINTER-OUT
         PERFORM VARYING IDX-COL FROM 1 BY 1 UNTIL IDX-COL > 4
            COMPUTE IDX-ROW = WS-NUMBER / (10 ** (4 - IDX-COL))
            IF IDX-ROW > 0
               STRING WS-TBL-ROW-COL(IDX-ROW, IDX-COL)
                      DELIMITED BY SPACES
                  INTO WS-RESULT WITH POINTER POINTER-OUT
               END-STRING
            END-IF
         END-PERFORM.
