       IDENTIFICATION DIVISION.
       PROGRAM-ID. PIG-LATIN.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-INPUT                 PIC  X(60).
       01 WC-WORD                  PIC  X(09).
       01 WC-TRANSLATION           PIC  X(11).
       01 WS-RESULT                PIC  X(60).
       01 U                        PIC  9(02).
       01 L                        PIC  9(02).
       01 I                        PIC  9(02).
       01 N                        PIC  9(02).
       01 M                        PIC  9(02).

       PROCEDURE DIVISION.

       TRANSLATE.
          MOVE SPACES TO WS-RESULT
          MOVE 1 TO U I

          PERFORM GET-WORD
          PERFORM UNTIL WC-WORD = SPACES
             MOVE SPACES TO WC-TRANSLATION
             PERFORM RULE-1
             IF WC-TRANSLATION = SPACES
                PERFORM RULE-3
             END-IF
             IF WC-TRANSLATION = SPACES
                PERFORM RULE-4
             END-IF
             IF WC-TRANSLATION = SPACES
                PERFORM RULE-2
             END-IF

             PERFORM ADD-WORD
             PERFORM GET-WORD
         END-PERFORM.

       RULE-1.
          IF (WC-WORD(1:1) = 'a' OR 'e' OR 'i' OR 'o' OR 'u') OR
             (WC-WORD(1:2) = 'xr' OR 'yt')
             MOVE WC-WORD TO WC-TRANSLATION
          END-IF.
      
       RULE-2.
          DISPLAY 'RULE 2'
          PERFORM VARYING N FROM 1 BY 1 
                  UNTIL WC-WORD(N:1) = 'a' OR 'e' OR 'i' OR 'o' OR 'u' 
             CONTINUE
          END-PERFORM
          IF N > 1
             COMPUTE M = N - 1
             STRING WC-WORD(N:) WC-WORD(1:M)
                    DELIMITED BY SPACE
                    INTO WC-TRANSLATION
          END-IF.
      
       RULE-3.
          DISPLAY 'RULE 3'
          MOVE ZEROS TO N M
          INSPECT WC-WORD TALLYING N FOR ALL CHARACTERS BEFORE INITIAL 'qu'
          INSPECT WC-WORD TALLYING M FOR ALL 'a'        BEFORE INITIAL 'qu'
                                   M FOR ALL 'e'        BEFORE INITIAL 'qu'
                                   M FOR ALL 'i'        BEFORE INITIAL 'qu'
                                   M FOR ALL 'o'        BEFORE INITIAL 'qu'
                                   M FOR ALL 'u'        BEFORE INITIAL 'qu'
          IF M = 0 AND N < L
             COMPUTE N = N + 2
             COMPUTE M = N + 1
             STRING WC-WORD(M:) WC-WORD(1:N)
                    DELIMITED BY SPACE
                    INTO WC-TRANSLATION
          END-IF.
      
       RULE-4.
          DISPLAY 'RULE 4'
          MOVE ZEROS TO N M
          INSPECT WC-WORD TALLYING N FOR ALL CHARACTERS BEFORE INITIAL 'y'
          INSPECT WC-WORD TALLYING M FOR ALL 'a'        BEFORE INITIAL 'y'
                                   M FOR ALL 'e'        BEFORE INITIAL 'y'
                                   M FOR ALL 'i'        BEFORE INITIAL 'y'
                                   M FOR ALL 'o'        BEFORE INITIAL 'y'
                                   M FOR ALL 'u'        BEFORE INITIAL 'y'
          IF M = 0 AND N > 0 AND N < L
             COMPUTE M = N + 1
             STRING WC-WORD(M:) WC-WORD(1:N)
                    DELIMITED BY SPACE
                    INTO WC-TRANSLATION
          END-IF.
      
       GET-WORD.
          UNSTRING WS-INPUT DELIMITED BY ' '
                   INTO WC-WORD
                   WITH POINTER U

          MOVE ZEROS TO L
          INSPECT WC-WORD TALLYING L FOR ALL CHARACTERS BEFORE ' '.

       ADD-WORD.
          STRING WC-TRANSLATION 'ay' 
                 DELIMITED SPACE 
                 INTO WS-RESULT(I:)
          COMPUTE I = I + L + 2 + 1.