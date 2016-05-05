;************************************************************************
; Filename: Assignment #2.asm															
; Function:	This program performs mathimatical and logical operations
;			and stores them in memory and checks the STATUS register flags
;			and stores them in memory. 									
; Author: 												
; Date: 													
;************************************************************************
		#include <GENERAL.h>
; ================	EQUATES  =========================================
TEMP		EQU		0x40		;Just picked a GPR at random. They may or may
temp		EQU		0x40		;not be correct for your program.
COUNT		EQU		0x41		;Feel free to define other variables needed
count		EQU		0x41		;by your program.
; =======================================================================				

		__CONFIG	0X3FF2		;This is the control bits for CONFIG register
		ORG			0X0000		;RESET or WDT reset vector
		GOTO		START
		ORG			0X0004		;Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
		RETFIE

START
		movlw 0x49		;This section performs 0x37-0x49 and saves
		sublw 0x37		;the result at address 0x20 and saves the STATUS
		movwf 0x20		;byte at address 0x21 for later verification
		movf STATUS, W
		movwf 0x21
		
		movlw 0x9D		;This section performs 0x95-0x9D and saves
		sublw 0x95		;the result at address 0x22 and saves the STATUS
		movwf 0x22		;byte at address 0x23 for later verification
		movf STATUS, W
		movwf 0x23
		
		movlw 0xA2		;This section performs 0xD8-0xA2 and saves
		sublw 0xD8		;the result at address 0x24 and saves the STATUS
		movwf 0x24		;byte at address 0x25 for later verification
		movf STATUS, W
		movwf 0x25
		
		movlw 0x02		;This section performs 0xFE+0x02 and saves
		sublw 0xFE		;the result at address 0x26 and saves the STATUS
		movwf 0x26		;byte at address 0x27 for later verification
		movf STATUS, W
		movwf 0x27
		
		movlw 0xBA		;This section performs 0xE7+0xBA and saves
		sublw 0xE7		;the result at address 0x28 and saves the STATUS
		movwf 0x28		;byte at address 0x29 for later verification
		movf STATUS, W
		movwf 0x29
		
		movlw 0x00		;This section performs 0xFF AND 0x00 and saves
		andlw 0xFF		;the result at address 0x2A and saves the STATUS
		movwf 0x2A		;byte at address 0x2B for later verification
		movf STATUS, W
		movwf 0x2B
		
		movlw 0xF1		;This section performs 0xF1 IOR 0xF1 and saves
		iorlw 0xF1		;the result at address 0x2C and saves the STATUS
		movwf 0x2C		;byte at address 0x2D for later verification
		movf STATUS, W
		movwf 0x2D
		
		movlw 0xEB		;This section performs 0xEB XOR 0xEB and saves
		xorlw 0xEB		;the result at address 0x2E and saves the STATUS
		movwf 0x2E		;byte at address 0x2F for later verification
		movf STATUS, W
		movwf 0x2F
		END