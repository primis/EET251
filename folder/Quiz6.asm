;************************************************************************
; Filename: Quiz6.asm														
; Function:	Performs two operations of the division of two numbers with
; 			each operation separated by a delay.	
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
TEMP4		EQU		0x23
temp4		EQU		0x23
TEMPX		EQU		0x24
TEMPY		EQU		0x25
RESULT	EQU		0x26
INDEX		EQU		0x27
; =======================================================================				

		__CONFIG	0X3FF2		;This is the control bits for CONFIG register
		ORG			0X0000		;RESET or WDT reset vector
		GOTO		START
		ORG			0X0004		;Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
		RETFIE

		ORG			0X0300
Delay	
		movlw 0x02
		movwf TEMP1
loop1	movlw 0xA1
		movwf TEMP2
loop2	movlw 0x00
		movwf TEMP3
loop3	movlw 0x00
		movwf TEMP4
loop4	decfsz TEMP4, F
		goto loop4
		decfsz TEMP3, F
		goto loop3
		decfsz TEMP2, F
		goto loop2
		decfsz TEMP1, F
		goto loop1
		Return

		ORG 		0X0320
Compute
		movf  TEMPY,F
		BTFSC STATUS,Z 
		return
		CLRF  RESULT
		movlw  1
		movwf  INDEX
Shift
		BTFSC  TEMPY,7
		goto  Division
		BCF   STATUS,C
		RLF   INDEX,F
		BCF   STATUS,C
		RLF   TEMPY,F
		goto  Shift
Division
		movf  TEMPY,W
		subwf  TEMPX
		BTFSC  STATUS,C
		goto   Count
		addwf  TEMPX
		goto  Final
Count
		movf  INDEX,W
		addwf  RESULT
Final
		BCF   STATUS,C
		RRF   TEMPY,F
		BCF   STATUS,C
		RRF   INDEX,F
		BTFSS   STATUS,C
		goto   Division
		Return

START
		CLRF RESULT
		movlw 0x06
		movwf TEMPX
		movlw 0x03
		movwf TEMPY
		call Compute
		movf RESULT, W
		movwf 0x40

		call Delay

		CLRF RESULT
		movlw 0x08
		movwf TEMPX
		movlw 0x02
		movwf TEMPY
		call Compute
		BCF STATUS,RP0
		CLRF PORTB
		BSF STATUS,RP0
		CLRF TRISB
		BCF STATUS,RP0
		movf RESULT,W
		movwf PORTB
END