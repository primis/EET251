;************************************************************************
; Filename: Quiz5.asm														
; Function:	 
; 									   									
; Author: 													
; Date: 													
;************************************************************************
		#include <GENERAL.h>
TEMP1		EQU		0x20
temp1		EQU		0x20
TEMP2		EQU		0x21
temp2		EQU		0x21
TEMP3		EQU		0x22
temp3		EQU		0x22
COUNT		EQU		0x41		
count		EQU		0x41		
; =======================================================================				

		__CONFIG	0X3FF2		;This is the control bits for CONFIG register
		ORG			0X0000		;RESET or WDT reset vector
		GOTO		START
		ORG			0X0004		;Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
		RETFIE

START
		movlw 0xAB
		movwf TEMP1
loop1	movlw 0x00
		movwf TEMP2
loop2	movlw 0x00
		movwf TEMP3
loop3	decf TEMP3, F
		BTFSS STATUS, Z
		goto loop3
		decf TEMP2, F
		BTFSS STATUS, Z
		goto loop2
		decf TEMP1, F
		BTFSS STATUS, Z
		goto loop1
		END