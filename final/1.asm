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
CounterA  equ  0x13	;
CounterB  equ  0x14	;
CounterC  equ  0x15	;
;-----------------------;

delay_6_sec
	movlw	D'153'
	movwf	CounterC
delay_6_sec_loop
	call	sub_delay_6_sec
	decfsz	CounterC,1
	goto	delay_6_sec_loop
	return

sub_delay_6_sec
	movlw	D'255'
	movwf	CounterB
	movlw	D'162'
	movwf	CounterA
sub_delay_6_sec_loop
	decfsz	CounterA,1
	goto	sub_delay_6_sec_loop
	decfsz	CounterB,1
	goto	sub_delay_6_sec_loop
	return

START
	bsf STATUS, RP0
	movlw 0x00
	movwf TRISB
	bcf STATUS, RP0
	movlw 0x55
	movwf PORTB
	call delay_6_sec
	movlw 0xAA
	movwf PORTB
	call delay_6_sec
	movlw 0xFF
	movwf PORTB
	call delay_6_sec
LOOP
	goto LOOP
	END
