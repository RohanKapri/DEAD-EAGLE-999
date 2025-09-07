       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROTEIN-TRANSLATION.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-INPUT                  PIC X(60).
       01 WS-PROTEIN                PIC X(120).
       01 WS-ERROR                  PIC X(60).

       77 WS-INPUT-INDEX            PIC 99.
       77 WS-SEARCH-STRING          PIC X(3).
       77 WS-STOP-CONDITION         PIC X.
          88 WS-STOP-PROCESSING     VALUE 'Y'.
       01 WS-TABLE. 
          05 WS-CODON-TABLE OCCURS 17 TIMES INDEXED BY WS-CODON-IDX.
            10 WS-CODON-VALUE       PIC X(3).
            10 WS-PROTEIN-VALUE     PIC X(13).
       PROCEDURE DIVISION.
      
       TRANSLATE-CODON.
      * Check if the entered sequence is a multiple of 3   
           MOVE 'N' TO WS-ERROR.
           IF FUNCTION MOD 
            (FUNCTION LENGTH(FUNCTION TRIM(WS-INPUT)) 3) > 0 THEN
              MOVE "Invalid codon" TO WS-ERROR
           END-IF. 
           IF WS-ERROR = 'N' THEN
               CONTINUE
           ELSE 
               EXIT 
           END-IF.
           PERFORM LOAD-LOOKUP-TABLE.
           PERFORM TRANSLATE.
           EXIT.
       TRANSLATE-RNA.
           MOVE 'N' TO WS-ERROR.
           PERFORM LOAD-LOOKUP-TABLE.
           PERFORM TRANSLATE.
           EXIT.  
       TRANSLATE.            
           MOVE SPACES TO WS-PROTEIN.
           MOVE 1 TO WS-INPUT-INDEX.
           MOVE 'N' TO WS-STOP-CONDITION.
           PERFORM VARYING WS-INPUT-INDEX FROM 1 BY 3 UNTIL    
               WS-INPUT-INDEX > LENGTH OF FUNCTION TRIM(WS-INPUT) OR
               WS-STOP-PROCESSING
               SET WS-CODON-IDX TO 1
               MOVE WS-INPUT(WS-INPUT-INDEX:3) TO WS-SEARCH-STRING 
               SEARCH WS-CODON-TABLE VARYING WS-CODON-IDX 
               AT END 
                   MOVE "Invalid codon" to WS-ERROR    
               WHEN WS-CODON-VALUE(WS-CODON-IDX) = WS-SEARCH-STRING
                   IF FUNCTION 
                       TRIM(WS-PROTEIN-VALUE(WS-CODON-IDX)) = 
                       "Stp" THEN
                       MOVE 'Y' TO WS-STOP-CONDITION
                       EXIT
                   ELSE                                       
                      STRING FUNCTION TRIM(WS-PROTEIN) DELIMITED BY
                      SIZE "," DELIMITED BY SIZE
                      WS-PROTEIN-VALUE(WS-CODON-IDX) DELIMITED BY SIZE
                      INTO WS-PROTEIN
                   END-IF
               END-SEARCH      
           END-PERFORM.   
           IF WS-PROTEIN NOT EQUAL TO SPACES THEN
              INSPECT WS-PROTEIN REPLACING FIRST ',' BY ' '
              MOVE FUNCTION TRIM(WS-PROTEIN) TO WS-PROTEIN
           END-IF
           EXIT.
       LOAD-LOOKUP-TABLE.        
      * Load lookup table with CODON sequences with
      *    corresponding PROTEIN names     
           STRING 
           "AUGMethionine   "  DELIMITED BY SIZE 
           "UUUPhenylalanine"  DELIMITED BY SIZE 
           "UUCPhenylalanine"  DELIMITED BY SIZE 
           "UUALeucine      "  DELIMITED BY SIZE 
           "UUGLeucine      "  DELIMITED BY SIZE 
           "UCUSerine       "  DELIMITED BY SIZE 
           "UCCSerine       "  DELIMITED BY SIZE 
           "UCASerine       "  DELIMITED BY SIZE 
           "UCGSerine       "  DELIMITED BY SIZE 
           "UAUTyrosine     "  DELIMITED BY SIZE 
           "UACTyrosine     "  DELIMITED BY SIZE 
           "UGUCysteine     "  DELIMITED BY SIZE 
           "UGCCysteine     "  DELIMITED BY SIZE 
           "UGGTryptophan   "  DELIMITED BY SIZE 
           "UAAStp          "  DELIMITED BY SIZE 
           "UAGStp          "  DELIMITED BY SIZE 
           "UGAStp          "  DELIMITED BY SIZE 
           INTO WS-TABLE.    
           EXIT.
      
       