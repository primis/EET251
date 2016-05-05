;************************************************************************
; Filename: Assignment #3.asm															
; Function:	
; Author: 													
; Date: 													
;************************************************************************
		#include <GENERAL.h>
; ================	EQUATES  =========================================
TEMP		EQU		0x4C
TEMP2		EQU		0x4B
TEMP3		EQU		0x4A
COUNT		EQU		0x49
; =======================================================================				

		__CONFIG	0X3FF2		;This is the control bits for CONFIG register
		ORG			0X0000		;RESET or WDT reset vector
		GOTO		START
		ORG			0X0004		;Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
		RETFIE
		ORG			0X0300
ByteCLR
		BCF TEMP, 7
		BCF TEMP, 6
		BCF TEMP, 5
		BCF TEMP, 4
		return
Bittest
		btfss 0x4F,7
		goto add
		btfss 0x4F,6
		goto add
		btfss 0x4F,5
		goto add
		btfss 0x4F,4
		goto add
		goto CheckADD
level		movlw 0x10
		addwf 0x4E
add		movf TEMP,W
		addwf 0x4F
		return

CheckADD	
		movf 0x4F,W
		movwf TEMP3
		movf TEMP,W
		addwf TEMP3
		btfsc TEMP3,7
		goto add
		goto level

START
		clrf 0x4A
		clrf 0x4B
		clrf 0x4C
		clrf 0x4D
		clrf 0x4E
		clrf 0x4F
		movlw 0x21
		movwf COUNT
		movlw 0x20
		movwf FSR
		movlw 0x23
		movwf TEMP
loop1
		movf TEMP, W
		movwf INDF
		INCF FSR, F
		addlw 0x02
		movwf TEMP
		decfsz COUNT, F
		goto loop1
		
		movlw 0x21
		movwf COUNT
		movlw 0x20
		movwf FSR
loop2
		movf INDF, W
		movwf TEMP
		swapf TEMP, F
		call ByteCLR
		movf TEMP, W
		addwf 0x4E
		movf INDF, W
		movwf TEMP
		call ByteCLR
		call Bittest
		INCF FSR, F 
		decfsz COUNT, F
		goto loop2

		movf STATUS, W
		movwf 0x4D
		movf 0x4F,W
		movwf TEMP
		swapf TEMP
		call ByteCLR
		movf TEMP,W
		addwf TEMP2
		movf 0x4E,W
		movwf TEMP
		call ByteCLR
		movf TEMP,W
		addwf TEMP2
		movf 0x4F,W
		movwf TEMP
		call ByteCLR
		movf TEMP,W
		movwf 0x4F
		movf 0x4E,W
		movwf TEMP
		swapf TEMP
		call ByteCLR
		movf TEMP,W
		movwf 0x4E
		movf TEMP2,W
		movwf TEMP
		call ByteCLR
		swapf TEMP
		movf TEMP,W
		addwf 0x4F
		movf TEMP2,W
		movwf TEMP
		swapf TEMP
		call ByteCLR
		movf TEMP,W
		addwf 0x4E
		END