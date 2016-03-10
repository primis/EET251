;====================================================================;
; Filename: quiz4.asm                                                ;
; Function: Multiply 5x8                                             ;
; Author:   Nicholas Sargente                                        ;
; Date:     02-16-16                                                 ;
;====================================================================;


#include <general.inc>		
;-----[ Datum ]---------;
RESULT  EQU 0x40        ; Kill two birds with one stone
TEMPX   EQU 0x41        ; X Variable
TEMPY   EQU 0x42        ; Y Variable
;-----------------------;

;-----[ PreStart ]------;	
    __CONFIG 0X3FF2     ; This is the control bits for CONFIG register
    ORG	0X0000          ; RESET or WDT reset vector
    GOTO	START       ; Actual Program
    ORG	0X0004		    ; Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
    RETFIE		        ; Return with Interrupt Enabled
;-----------------------;

;----[ MUL8 ]-----------; 
MUL8:			; Multiply 8 bit function
    CLRF RESULT         ; Clear Result Register
MUL8LOOP:                ; Inner Loop of multiplication
    MOVF  TEMPX,  W     ; Move X into work register
    BTFSC TEMPY,  0     ; Is Y an odd number?
    ADDWF RESULT        ; Add X to result
    RRF   TEMPY,  F     ; Multiply Y by 2
    BCF   STATUS, C     ; Clear the carry flag
    RLF   TEMPX,  F     ; Divide X by 2
    MOVF  TEMPY,  F     ; Set the flags without modifying anything
    BTFSS STATUS, Z     ; Check to see if we're done
    GOTO  MUL8LOOP      ; There's more to do!
    RETURN              ; All done, go back to caller
;-----------------------;

;-----[ Start ]---------;
START			        ; Program Entry 	
    MOVLW 0x5           ; Setup for X value
    MOVWF TEMPX         ; Put that into X
    MOVLW 0x8           ; Setup for Y value
    MOVWF TEMPY         ; Put into Y
    CALL MUL8           ; Call multiplication Function
    GOTO $		; Jump to self, infinite loop 
    END			;
;-----------------------;

