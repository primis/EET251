;====================================================================;
; Filename: lab4.asm                                                 ;
; Function: I/O Port Functions                                       ;
; Author:   Nicholas Sargente                                        ;
; Date:     03-10-16                                                 ;
;====================================================================;


#include <general.inc>

;-----[ PreStart ]------;
    __CONFIG 0X3FF2     ; This is the control bits for CONFIG register
    ORG	0X0000          ; RESET or WDT reset vector
    GOTO	START         ; Actual Program
    ORG	0X0004		      ; Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
    RETFIE		          ; Return with Interrupt Enabled
;-----------------------;

;----[ Variables ]------;
TEMPA   equ   0x13      ; Variables for storage
TEMPB   equ   0x14      ;
;-----------------------;

SWITCH1                 ; Set a few LED's
  movlw 0x09
  iorwf TEMPA, f
  return

SWITCH2
  movlw 0x04
  iorwf TEMPA, f
  return

SWITCH3
  movlw 0x03
  iorwf TEMPA, f
  return

;-----[ Start ]---------;
START     			        ; Program Entry
    bsf STATUS, RP0     ;
    movlw 0xF0          ; Top 4 bits
    movwf TRISA         ;
    movwf TRISB         ; Move to both tristate registers
    bcf STATUS, RP0     ;
LED_LOOP                ; Main running loop
    clrf TEMPA          ; Zero out temps
    clrf TEMPB          ;
                        ;
    btfsc PORTB, 7      ; Test if switch 1 is set.
    call  SWITCH1       ; Run "play routine"
    btfsc PORTB, 6      ;
    call  SWITCH2       ; Run "play" routine
    btfsc PORTB, 5      ;
    call  SWITCH3       ;
                        ;
    movwf TEMPA, W      ; Make working from TEMPA
    movwf PORTA         ; Set LED's
    goto LED_LOOP       ; Loop back around
    end                 ;
;-----------------------;
