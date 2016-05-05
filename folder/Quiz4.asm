;************************************************************************
; Filename: Quiz4.asm														
; Function:	This program calculates 5 times 8 in hex. 
; 									   									
; Author: 													
; Date: 												
;************************************************************************
		#include <GENERAL.h>
TEMP		EQU		0x20		;Just picked a GPR at random.  They may or may
temp		EQU		0x20		; not be correct for your program.
COUNT		EQU		0x41		;Feel free to define other variables needed
count		EQU		0x41		; by your program.
; =======================================================================				

		__CONFIG	0X3FF2		;This is the control bits for CONFIG register
		ORG			0X0000		;RESET or WDT reset vector
		GOTO		START
		ORG			0X0004		;Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
		RETFIE

START
		movlw 0x05
		movwf 0x30
		BSF STATUS, C
		RLF 0x30, F
		BCF STATUS, C
		RLF 0x30, F
		BCF STATUS, C
		RLF 0x30, F
		movlw 0x08
		movwf 0x31
		BCF STATUS, C
		RRF 0x31, F
		movf 0x30, W
		movwf 0x40
		movf 0x31, W
		subwf 0x40, 1
		END