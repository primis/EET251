
;====================================================================;
; Filename: project.asm                                              ;
; Function: Car Garage                                               ;
; Author:   Nicholas Sargente, Chetanpreet Malhi, Ridwan Rahman,     ;
;            Shawn Dewar, and Justin Parunaparampil                  ;
;====================================================================;


#include <general.inc>		

;-----[ PreStart ]------;	
    __CONFIG 0X3FF2     ; This is the control bits for CONFIG register
    ORG	0X0000          ; RESET or WDT reset vector
    GOTO	START       ; Actual Program
    ORG	0X0004		    ; Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
    RETFIE		        ; Return with Interrupt Enabled
;-----------------------;

;-----[ Variables ]-----;
count       EQU 0x50    ; count register
state       EQU 0x51    ; State Mask for switches
CounterA    EQU 0x13    ;
CounterB    EQU 0x14    ;   
CounterC    EQU 0x15    ;
;------[ Macros ]-------;
MAX_CARS    EQU 0x64    ; 100 Cars Max.
;-----------------------;

;----------[ delay ]--------; Delay 333ms
delay                       ;
    movlw   D'9'            ;
    movwf   CounterC        ;
delay_loop                  ;
    call    sub_delay       ;
    decfsz  CounterC,1      ;
    goto    delay_loop      ;
    return                  ;
                            ;
sub_delay                   ;
    movlw   D'241'          ;
    movwf   CounterB        ;
    movlw   D'124'          ;   
    movwf   CounterA        ;
sub_delay_loop              ;
    decfsz  CounterA,1      ;
    goto    sub_delay_loop  ;
    decfsz  CounterB,1      ;
    goto    sub_delay_loop  ;
    return                  ;
;---------------------------;


;------[ blinky ]-------; Blink lights for a seconds with duty of 50%
blinky                  ; 
    movlw 0xFF          ; Start with lights on
    movwf PORTB         ; 
    call delay          ; delay 333 ms
    movlw 0x00          ; Turn Lights off
    movwf PORTB         ;
    call delay          ; Delay again
    movlw 0xFF          ; Back on
    movwf PORTB         ;
    call delay          ; Delay again
    movf count, W       ; Restore counter
    movwf PORTB         ;
    return              ; Return
;-----------------------;

;-------[ car_in ]------; Check for overflows and stuff
car_in                  ; Car Pulls into lot
    movf count, F       ; Check zero flag
    btfsc status, Z     ; If not zero...
     decf count, F      ; Decremet counter
    btfss status, Z     ; if set, we can't take another car. Blink for a bit
     call blinky        ; Blink those lights!
    return              ; All done, go back
;-----------------------;

;------[ car_out ]------;
car_out                 ;
    movlw MAX_CARS      ; Check to see if we're actually empty...
    subwf count, W      ; Check difference.
    btfsc status, Z     ; If Not zero
     incf count, F      ; Add one to counter
    btfss status, Z     ; Check to see if we're the same as max
     call blinky        ; Blink Lights annoyingly because someone messed up
    btfsc               ;
;-----------------------;

;-----[ Start ]---------;
START			        ; Program Entry 	
    bsf STATUS, RP0     ; Bank 1
    movlw 0x00          ; Set Port B as Outputs
    movwf TRISB         ; Port B
    movlw 0x03          ; Set Inputs
    movwf TRISA         ; Port A 
    bcf STATUS, RP0     ; Bank 0
    movlw MAX_CARS      ; Move number of cars from macro into variable
    movwf count         ; The Car Lot starts empty
    movlw 0x0           ; Bitset starts empty
    movwf state         ;
LOOP                    ;
;--[ Display ]----------;
    movf count, W       ; Pull up count
    movwf PORTB         ; Push out to port B
;--[ Check inputs ]-----;
    btfss state, 0      ; Skip input car_in  if set
     btfsc PORTA, 0     ; See if the switch was pulled up
      call car_in
    btfss state, 1      ; Skip input car_out if set
     btfsc PORTA, 1     ; See if Switch was pulled up
      call car_out      ; Car Left
    movf PORTA, w       ; Get switches back in
    movwf state         ; Put it in state mask
    goto loop           ;
;-----------------------;

;------[ End ]----------;
    goto    $           ; end loop
    end                 ;
;-----------------------;
