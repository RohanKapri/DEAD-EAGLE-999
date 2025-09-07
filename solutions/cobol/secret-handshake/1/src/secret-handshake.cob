        IDENTIFICATION DIVISION.
        PROGRAM-ID. SECRET-HANDSHAKE.
        ENVIRONMENT DIVISION.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01  WS-INPUT            PIC 999.
        01  WS-RESULT           PIC X(60).
        01  filler redefines ws-result.
            05  ws-result-char  pic x occurs 60
                                indexed by ws-char-x.
        01  ws-binary.
            05 ws-bit           pic 9 occurs 5
                                indexed by ws-bit-x.
        01  ws-pointer          pic 99 value 1.
        PROCEDURE DIVISION.
        COMMANDS. 
            perform to-binary.
            if ws-bit(1) = 0
                perform go-forward
            else
                perform go-reverse
            end-if
            perform clean-tail
            .

        go-reverse.
            move spaces to ws-result.
            move 1 to ws-pointer
            if ws-bit(2) = 1
                string 'jump,'delimited by size 
                    into ws-result
                    with pointer ws-pointer
            end-if
            if ws-bit(3) = 1
                string 'close your eyes,' delimited by size
                    into ws-result
                    with pointer ws-pointer
            end-if
            if ws-bit(4) = 1
                string 'double blink,' delimited by size 
                    into ws-result
                    with pointer ws-pointer
            end-if
            if ws-bit(5) = 1
                string 'wink,' delimited by size 
                    into ws-result
                    with pointer ws-pointer
            end-if
            .
            
        go-forward.
            move spaces to ws-result.
            move 1 to ws-pointer
            if ws-bit(5) = 1
                string 'wink' ',' delimited by size 
                    into ws-result
                    with pointer ws-pointer
            end-if
            if ws-bit(4) = 1
                string 'double blink' ',' delimited by size
                    into ws-result
                    with pointer ws-pointer
            end-if
            if ws-bit(3) = 1
                string 'close your eyes' ',' delimited by size 
                    into ws-result
                    with pointer ws-pointer
            end-if
            if ws-bit(2) = 1
                string 'jump' ',' delimited by size 
                    into ws-result
                    with pointer ws-pointer
                
            end-if
            .
        
        clean-tail.
            perform varying ws-char-x from 60 by -1
                    until ws-result-char(ws-char-x) = ','  
                    or ws-char-x < 1
            end-perform
            move space to ws-result-char(ws-char-x)
            .
            
        to-binary.
            move zeros to ws-binary
        
            perform varying ws-bit-x from 5 by -1
                    until ws-input < 1
                    or ws-bit-x < 1
                compute ws-bit(ws-bit-x) =
                    function mod(ws-input, 2)
                divide ws-input by 2 giving ws-input
            end-perform
            .