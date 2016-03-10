
;====================================================================;
; Filename: lab3.asm                                                 ;
; Function: Index assembly language Programming                      ;
; Author:   Nicholas Sargente                                        ;
; Date:     03-03-16                                                 ;
;====================================================================;


#include <general.inc>		

;-----[ PreStart ]------;	
    __CONFIG 0X3FF2     ; This is the control bits for CONFIG register
    ORG	0X0000          ; RESET or WDT reset vector
    GOTO	START       ; Actual Program
    ORG	0X0004		    ; Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
    RETFIE		        ; Return with Interrupt Enabled
;-----------------------;

;-----[ Variables ]-----;
count       EQU 0x50    ; count register
data        EQU 0x4E    ; (also at 0x4F)
;-----------------------;

;---[ MACROS ]----------;
addw16  MACRO DST       ; Add Work Register to 16 bit dst (little endian)
    addwf   (DST+1), f  ; Add low 8 bits
    skpnc               ; Skip if no carry
    incf    (DST), f    ; add carry to high bit if needed
    ENDM                ; End Macro
;-----------------------;

;-----[ Start ]---------;
START			        ; Program Entry 	
    movlw   0x19        ; initial register location
    movwf   FSR         ; FSR for indicating address
    movlw   0x21        ; loop length
    movwf   count       ; Move to counter
    movlw   0x23        ; Value of first register (0x20)
LOOP 
    incf    FSR         ; Go to next register
    movwf   INDF        ; Put working register in location
    addlw   0x2         ; inrement Work by two
    decf    count,F     ; Decrement counter
    btfsc   status,Z    ; Check if zero
    goto    LOOP        ; if not, keep going
;-----------------------;

;-----[ Count Loop ]----;
    movlw   0x19        ; starting at 0x20 again
    movwf   FSR         ; moving into fsr
    movlw   0x21        ; same length
    movwf   count       ; into counter
    clrf    data        ; clear data's high byte
    clrf    data+1      ; clear data's low byte
CLOOP                   ;
    incf    FSR         ; increment pointer
    movf    INDF, W     ; Move register into work
    addw16  dat_hi      ; Add work to data register
    decf    count,F     ; Decrement counter
    btfsc   status,Z    ; are we finished?
    goto    CLOOP       ; Redo until finished
;------[ End ]----------;
    goto    $           ; end loop
    end                 ;
;-----------------------;
