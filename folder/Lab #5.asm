;************************************************************************
; Filename: 	Lab #5.asm														
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
TEMPA		EQU		0x0C
TEMPB		EQU		0x0D
TEMP1		EQU		0x0E
TEMP2		EQU		0x0F
TEMP3		EQU		0x10
TEMP4		EQU		0x11
COUNT		EQU		0x12
; =======================================================================				

		__CONFIG	0X3FF6		;This is the control bits for CONFIG register
		ORG			0X0000		;RESET or WDT reset vector
		GOTO		START
		ORG			0X0004		;Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
		RETFIE
		ORG			0X0300
Delay	
		movlw 	0x01
		movwf 	TEMP1
loop1	movlw 	0x06
		movwf 	TEMP2
loop2	movlw 	0xF0
		movwf 	TEMP3
loop3	movlw 	0xFF
		movwf 	TEMP4
loop4	decfsz 	TEMP4, F
		goto 	loop4
		decfsz 	TEMP3, F
		goto 	loop3
		decfsz 	TEMP2, F
		goto	loop2
		decfsz 	TEMP1, F
		goto 	loop1
		Return

START
		BSF	STATUS, RP0
		movlw 	0xFE
		movwf	OPTION_REG

		BSF	STATUS, RP0
		movlw	0xF0
		movwf	TRISA
		movwf	TRISB
		BCF	STATUS, RP0
		
Light_Test
		CLRWDT
		movlw	0x30
		movwf	COUNT
		movlw	0x0F
		movwf	PORTA
		movlw	0xF0
		movwf	PORTB
		call 		Delay
		movlw	0xF0
		movwf	PORTA
		movlw	0x0F
		movwf	PORTB
		call 		Delay
		decfsz	COUNT,F
		goto 	Light_Test
		
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