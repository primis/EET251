;====================================================================;
; Filename: Final Lab Exam Test                                      ;
; Function: Assembly program used for lab 2                          ;
; Author:   Nicholas Sargente                                        ;
; Date:     01-28-16                                                 ;
;====================================================================;


#include <general.inc>

;-----[ PreStart ]------;
	__CONFIG 0X3FF2		; This is the control bits for CONFIG register
	ORG	0X0000  		; RESET or WDT reset vector
	GOTO	START   	; Actual Program
	ORG	0X0004			; Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
	RETFIE				; Return with Interrupt Enabled
;----[ Variables ]------;
TempX	equ		0x13	;
TempY	equ		0x14	;
;-----------------------;


MUL4
	movlw 0				; Clear Work
	btfsc	TempY, 0	; Check bit 0
	addwf	TempX, w	; Add X if set
	rlf		TempX, F	; Roll X over (multiply by 2)	
	btfsc	TempY, 1	; Check bit 1
	addwf	TempX, 1	; Add X*2 if set
	return				; All Done! 
START
	bsf STATUS, RP0		; Switch to Bank 1
	movlw 0x15			; binary 00001111
	movwf TRISA			; For inputs
	movlw 0x00			; All Outputs
	movwf TRISB	
	bcf STATUS, RP0		; Back to Bank 0
LOOP
	movf PORTA, w		; Get inputs
	andlw 0x3			; Get X input
	movwf TempX			; Put in X
	movf PORTA, w		; Get back the input
	andlw 0x12			; Get Y input
	movwf TempY			;
	call MUL4			; Multiply
	movwf PORTB			; Display output on portB
	goto LOOP			; Cycle Forever
	END
