;====================================================================;
; Filename: Final Lab Exam Test                                      ;
; Function: Assembly program used for lab 2                          ;
; Author:   Nicholas Sargente                                        ;
; Date:     01-28-16                                                 ;
;====================================================================;


#include <general.inc>

;-----[ PreStart ]------;
	__CONFIG 0X3FF2 ; This is the control bits for CONFIG register
	ORG	0X0000  ; RESET or WDT reset vector
	GOTO	START   ; Actual Program
	ORG	0X0004	; Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
	RETFIE		; Return with Interrupt Enabled

;----[ Variables ]------;
CounterA  equ  0x13	    ;
CounterB  equ  0x14	    ;
CounterC  equ  0x15	    ;
;-----------------------;

delay ; delays for a 3rd of a second (0.33333s)
	movlw	D'9'
	movwf	CounterC
delay_loop
	call	sub_delay
	decfsz	CounterC,1
	goto	delay_loop
	return

sub_delay
	movlw	D'241'
	movwf	CounterB
	movlw	D'124'
	movwf	CounterA
sub_delay_loop
	decfsz	CounterA,1
	goto	sub_delay_loop
	decfsz	CounterB,1
	goto	sub_delay_loop
	return


START
	bsf STATUS, RP0
	movlw 0x00
	movwf TRISB
	bcf STATUS, RP0
LEFTHAND
	movlw 0x01   ; STATE OF PORTB 
	movwf PORTB	 ; 00000001
	call delay
	rlf PORTB, f ; 00000010
	call delay
	rlf PORTB, f ; 00000100
	call delay
	rlf PORTB, f ; 00001000
	call delay
	rlf PORTB, f ; 00010000
	call delay
	rlf PORTB, f ; 00100000
	call delay
	rlf PORTB, f ; 01000000
	call delay
	rlf PORTB, f ; 10000000
RIGHTHAND
	call delay
	rrf PORTB, f ; 01000000
	call delay
	rrf PORTB, f ; 00100000
	call delay
	rrf PORTB, f ; 00010000
	call delay
	rrf PORTB, f ; 00001000
	call delay
	rrf PORTB, f ; 00000100
	call delay
	rrf PORTB, f ; 00000010
	call delay
	goto LEFTHAND
	END
