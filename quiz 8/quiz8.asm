;====================================================================;
; Filename: quiz8.asm                                                ;
; Function: Multiply and display                                     ;
; Author:   Nicholas Sargente                                        ;
; Date:     03-17-16                                                 ;
;====================================================================;


#include <general.inc>
;-----[ Datum ]---------;
TEMPX   EQU 0x41        ; X Variable
TEMPY   EQU 0x42        ; Y Variable
;-----------------------;

;-----[ PreStart ]------;
    __CONFIG 0X3FF2     ; This is the control bits for CONFIG register
    ORG	    0X0000      ; RESET or WDT reset vector
		    GOTO    START       ; Actual Program
    ORG	    0X0004      ; Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
    RETFIE              ; Return with Interrupt Enabled
;-----------------------;

;----[ Table Lookup ]---;
tablelookup             ;
    addwf   PCL, f      ; Add offset to program counter.
    retlw   0x40        ; '0'
    retlw   0x79        ; '1'
    retlw   0x24        ; '2'
    retlw   0x30        ; '3'
    retlw   0x19        ; '4'
    retlw   0x12        ; '5'
    retlw   0x02        ; '6'
    retlw   0x78        ; '7'
    retlw   0x00        ; '8'
    retlw   0x18        ; '9'
    retlw   0x08        ; 'A'
    retlw   0x03        ; 'B'
    retlw   0x27        ; 'C'
    retlw   0x21        ; 'D'
    retlw   0x06        ; 'E'
    retlw   0x0E        ; 'F'
;-----------------------;

;--[ Display Outputs ]--;
segout                  ; Display Working register to segments
    movf    TEMPX, W    ; Move data into TEMP
	; Done With Init.
    swapf   TEMPX, W    ; Get high nybble into Working
    andlw   b'00001111' ; just want the low nybble
	call    tablelookup ; Translate for 7-Seg
	iorlw	b'10000000' ; Top Segment
    movwf   PORTB       ; Put on Data Bus
    call    mssleep     ; Sleep a bit
	
	movf    TEMPX, W    ; Get number again
    andlw   b'00001111' ; Clear out top nybble
    call    tablelookup ; Get the segment display numbers
    movwf   PORTB       ; Put onto data bus
    call    mssleep     ; Sleep a bit
    movlw   b'00000111' ; Clear Control bus
    movwf   PORTA
    return              ; All done
;-----------------------;

;---[ 1ms sleep ]-------;
mssleep                 ; Sleep for 1ms using loops
    movlw   0xC6        ; 993 Cycles
    movwf   TEMPX       ; Put in TEMPX
    movlw   0x01        ; Just do it once
    movwf   TEMPY       ; Put in TEMPY
mssleep_0               ; Inner loop
    decfsz  TEMPX, f    ; decrement loop counter
    goto    $+2         ;
    decfsz  TEMPY, f    ; Decrement again
    goto    mssleep_0   ; Loop!
    goto    $+1         ; leave loop
    nop                 ; Filler to make exactly right length
    return              ; All in all, 1000 cycles
;-----------------------;

;----[ Get Data ]-------;
datain                  ; Get input, store in X & Y
    movf    PORTA, w    ; Get DIP Switches
	btfss   PORTA, 4	; Are we on the Second nybble?
    movwf   TEMPX       ; Move into TEMPX
	btfsc   PORTA, 4	; Are we on the First nybble?
	movwf	TEMPY		;
    return              ; All done.
;-----------------------;

;------[ Mul 4x4 ]------;
mul4                    ; Multiply TEMPX * TEMPY, Result in W
    movlw   0           ; Clear Work Register
    bcf     STATUS, C   ; Clear Carry Bit
    btfss   TEMPX,0     ; Test bit 0 of X
    addwf   TEMPY,w     ; Add Y once if true
    rlf     TEMPY,f     ; Shift Y left
    btfss   TEMPX,1     ; Test Bit 1 of X
    addwf   TEMPY,w     ; Same as above
    rlf     TEMPY,f     ; Same as above
    btfss   TEMPX,2     ;
    addwf   TEMPY,w     ;
    rlf     TEMPY,f     ;
    btfss   TEMPX,3     ;
    addwf   TEMPY,w     ;
    rlf     TEMPY,f     ;
    swapf   TEMPY,f     ; Move TEMPY back to original position.
    return              ; Back to Calling function
;-----------------------;

;----[START]------------;
START                   ; Actual Program
	bsf     STATUS, 5   ; Switch to Bank 1 by setting status bit 5
    movlw   b'00011111' ; Set Port A to inputs (Data in)
    movwf   TRISA       ; Set tristate A
	movlw   b'00000000' ; Set Port B to outputs
    movwf   TRISB       ; Set tristate B
	bcf 	STATUS, 5	; Back to Bank0
LOOP					;
	call    datain      ; Get input
   ; call    mul4       ; nybble Multiply
    movf	TEMPX		;
	call    segout      ; Display Result
    goto    LOOP        ; Loop.
    END                 ; Finished.
;-----------------------;
