;************************************************************************
; Filename: 	Lab4.asm														
; Function:  	This program demonstrates I/O port configuration using different LED configurations
; 			based on the position of switches 
;			Wiring:
;				PORTA
;					RA0, RA1, RA2, RA3 : Connected to LED 1 through 4 on trainer board
;				PORTB
;					RB0, RB1, RB2, RB3 : Connected to LED 5 through 8 on trainer board
;					RB5, RB6, RB7 : Connected to DIP Switches on trainer board
; Author: 												
; Date: 													
;************************************************************************
		#include <GENERAL.h>
;============================= EQUATES ==================================
TEMPA		EQU		0x0E
TEMPB		EQU		0x0F	
; =======================================================================				

		__CONFIG	0X3FF2		;This is the control bits for CONFIG register
		ORG			0X0000		;RESET or WDT reset vector
		GOTO		START
		ORG			0X0004		;Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
		RETFIE

START
		BSF	STATUS, RP0
		movlw	0xF0
		movwf	TRISA
		movwf	TRISB
		BCF	STATUS, RP0
		
Light_Loop

		CLRF	TEMPA
		CLRF	TEMPB
		
		BTFSC	PORTB, 7
		call		Switch1
		BTFSC	PORTB, 6
		call		Switch2
		BTFSC	PORTB, 5
		call		Switch3
		
		movf	TEMPA, W
		movwf	PORTA
		movf	TEMPB, W
		movwf	PORTB
		
		goto Light_Loop

Switch1
		
		movlw	0x09
		iorwf	TEMPA, F
		return

Switch2
		
		movlw	0x04
		iorwf	TEMPA, F
		return

Switch3
		
		movlw	0x03
		iorwf	TEMPA, F
		return

END