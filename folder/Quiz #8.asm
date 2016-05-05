;************************************************************************
; Filename: Quiz #8.asm														
; Function: This program takes two input numbers from the user and displays
;			the product of these two numbers on a set of LEDs.
; 									   									
; Author: 													
; Date: 													
;************************************************************************
		#include <GENERAL.h>
; ================	EQUATES  ============================================
TEMPX		EQU		0x0C
TEMPY		EQU		0x0D
RESULT		EQU		0x0E
TEMP11		EQU		0x0F
TEMP12		EQU		0x10
TEMP13		EQU		0x11
TEMP14		EQU		0x12
TEMP21		EQU		0x13
TEMP22		EQU		0x14
TEMP23		EQU		0x15
TEMP24		EQU		0x16
; =======================================================================				

		__CONFIG	0X3FF2
		ORG			0X0000
		GOTO		START
		ORG			0X0004
		RETFIE
		
Compute
		CLRF 	RESULT
Repeat
		movf 	TEMPX,W
		BTFSC 	TEMPY,0
		addwf 	RESULT
		BCF 	STATUS,C
		RRF 	TEMPY,F
		BCF 	STATUS,C
		RLF 	TEMPX,F
		movf 	TEMPY,F
		BTFSS 	STATUS,Z
		goto 	Repeat
		return

Delay2	
		movlw 	0x06
		movwf 	TEMP21
loop21	movlw 	0xFD
		movwf 	TEMP22
loop22	movlw 	0x00
		movwf 	TEMP23
loop23	movlw 	0x00
		movwf 	TEMP24
loop24	decfsz 	TEMP24, F
		goto 	loop24
		decfsz 	TEMP23, F
		goto 	loop23
		decfsz 	TEMP22, F
		goto 	loop22
		decfsz 	TEMP21, F
		goto 	loop21
		Return
		
Delay1	
		movlw 	0x01
		movwf 	TEMP11
loop11	movlw 	0xFD
		movwf 	TEMP12
loop12	movlw 	0x00
		movwf 	TEMP13
loop13	movlw 	0x00
		movwf 	TEMP14
loop14	decfsz 	TEMP14, F
		goto 	loop14
		decfsz 	TEMP13, F
		goto 	loop13
		decfsz 	TEMP12, F
		goto 	loop12
		decfsz 	TEMP11, F
		goto 	loop11
		Return

Num1	call 		Delay1
		movf	PORTA,W
		movwf	TEMPX
		BCF	TEMPX,4
		goto 	Cont
		
Num2	call 		Delay1
		movf	PORTA,W
		movwf	TEMPY
		BCF	TEMPY,4
		goto 	Cont
		
START
		BSF	STATUS, RP0
		movlw	0xFF
		movwf	TRISA
		movlw	0x00
		movwf	TRISB
		BCF	STATUS, RP0
		
Switch_Loop
		CLRF	PORTB
		CLRF 	TEMPX
		CLRF 	TEMPY
		call 		Delay1
		movlw	0x01
		movwf	PORTB
		BTFSS 	PORTA,4
		goto 	Num1
		goto 	Num2
Cont	movlw	0x02
		movwf	PORTB
		movf	TEMPX,F
		BTFSC	STATUS,Z
		goto	Num1
		movf	TEMPY,F
		BTFSC	STATUS,Z
		goto	Num2
		call 		Compute	
		movf	RESULT,W
		movwf 	PORTB
		call 		Delay2
		goto	Switch_Loop

		END