;====================================================================;
; Filename: sample.asm                                               ;
; Function: Sample Assembly program used for lab 1                   ;
; Author:   Nicholas Sargente                                        ;
; Date:     01-28-16                                                 ;
;====================================================================;


#include <GENERAL.h>
; ================	EQUATES  =========================================
;The labels below will not be in your GENERAL.H.  You would have EQUATES at the top of
; program that defines all variable names that you use in your program which are not
; covered by your GENERAL.H file.
TEMP		EQU		0x40		;Just picked a GPR at random.  They may or may
temp		EQU		0x40		; not be correct for your program.
COUNT		EQU		0x41		;Feel free to define other variables needed
count		EQU		0x41		; by your program.
; =======================================================================				

		__CONFIG	0X3FF2		;This is the control bits for CONFIG register
		ORG			0X0000		;RESET or WDT reset vector
		GOTO		START
		ORG			0X0004		;Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
		RETFIE

START
		;Put your WELL COMMENTED code here.  Make sure to break it up into sections with section headers.
		;Remember that all macros and subrountines require Full Headers.
		
		GOTO		$			;This is an infinite loop.  Helps in simulation not to let the program 
								; actually end.  Screws up the registers when you might want to
								; look at them.
		END