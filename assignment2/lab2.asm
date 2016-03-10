;====================================================================;
; Filename: lab2.asm                                                 ;
; Function: Assembly program used for lab 2                          ;
; Author:   Nicholas Sargente                                        ;
; Date:     01-28-16                                                 ;
;====================================================================;


#include <general.inc>		

;-----[ PreStart ]------;	
    __CONFIG 0X3FF2     ; This is the control bits for CONFIG register
    ORG	0X0000          ; RESET or WDT reset vector
    GOTO	START       ; Actual Program
    ORG	0X0004		    ; Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
    RETFIE		        ; Return with Interrupt Enabled
;-----------------------;


;-----[ Start ]---------;
START			        ; Program Entry 	
    movlw 0x49		    ;
    sublw 0x37	    	;
    movwf 0x20		    ; Put W in memory
    movf  STATUS, W	    ; Put Status in W
    movwf 0x21		    ; Put Register W (status) in memory
			            ;
    movlw 0x9D		    ;
    sublw 0x95		    ;
    movwf 0x22		    ;
    movf  STATUS, W	    ; Put Status in W
    movwf 0x23		    ; Put Register W (status) in memory
			            ;
    movlw 0xA2		    ;
    sublw 0xD8		    ;
    movwf 0x24		    ;
    movf  STATUS, W	    ; Put Status in W
    movwf 0x25		    ; Put Register W (status) in memory
			            ;
    movlw 0xFE		    ;
    addlw 0x02		    ;
    movwf 0x26		    ;
    movf  STATUS, W	    ; Put Status in W
    movwf 0x27		    ; Put Register W (status) in memory
			            ;
    movlw 0xE7		    ;
    addlw 0xBA		    ;
    movwf 0x28		    ;
    movf  STATUS, W	    ; Put Status in W
    movwf 0x29		    ; Put Register W (status) in memory
			            ;
    movlw 0x0F		    ;
    andlw 0x00		    ;
    movwf 0x2A		    ;
    movf  STATUS, W	    ; Put Status in W
    movwf 0x2B		    ; Put Register W (status) in memory
			            ;
    movlw 0xF1		    ;	  
    iorlw 0xF1		    ;
    movwf 0x2C		    ;
    movf  STATUS, W	    ; Put Status in W
    movwf 0x2D		    ; Put Register W (status) in memory
			            ;
    movlw 0xEB		    ;
    xorlw 0xEB		    ;
    movwf 0x2E		    ;
    movf  STATUS, W	    ; Put Status in W
    movwf 0x2F		    ; Put Register W (status) in memory
			            ;
    GOTO $		        ; Jump to self, infinite loop 
    END			        ;
;-----------------------;
