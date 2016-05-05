;************************************************************************
; Filename: Quiz7.asm														
; Function:	Performs a sequence of incrementing values and storing them in 
; 			a subsequent string of file registers.
; Author: 													
; Date: 													
;************************************************************************
		#include <GENERAL.h>
TEMP		EQU		0x13
COUNT		EQU		0x12
; =======================================================================				

		__CONFIG	0X3FF2		;This is the control bits for CONFIG register
		ORG			0X0000		;RESET or WDT reset vector
		GOTO		START
		ORG			0X0004		;Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
		RETFIE

START
		movlw 0x33
		movwf COUNT
		movlw 0x20
		movwf FSR
		movlw 0x12
		movwf TEMP
loop
		movf TEMP, W
		movwf INDF
		INCF FSR, F
		addlw 0x03
		movwf TEMP
		decfsz COUNT, F
		goto loop
		END