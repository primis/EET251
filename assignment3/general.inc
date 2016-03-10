;====================================================================;
; Filename: general.h                                                ;
; Function: Define all special function register and their locations ;
;           For the PIC68F84A Microcontroller                        ;
; Author:   Nicholas Sargente                                        ;
; Date:     01-28-16                                                 ;
;====================================================================;

;----[ Destination Designator ]-----;
W	equ	0x0							; Register W					
w	equ 0x0							;
F	equ 0x1							; Flags Register
f	equ 0x1							;
MSB	equ 7							; Most Significant bit
LSB	equ 0							; Least Significant Bit
;-----------------------------------;


;---[ PIC68F84A MEM MAP ]---;
INDF		equ    	0x00 	; Indirect File Register
TMR0       	equ    	0x01 	; Real-Time Clock/Counter
PCL        	equ    	0x02 	; Program Counter
STATUS     	equ    	0x03 	; Status Register
FSR        	equ    	0x04 	; File Select Register
PORTA      	equ    	0x05 	; I/O Port A
PORTB      	equ    	0x06 	; I/O Port B
EEDATA		equ		0x08	; EEPROM Data Register
EEADR		equ		0x09	; EEPROM Address Register
PCLATH		equ		0x0A	; PC High Byte
INTCON		equ		0x0B	; Interrupt Control Register
OPTION_REG	equ		0x81	; Option Register
TRISA		equ		0x85	; TRISA Control Register
TRISB		equ		0x86	; TRISB Control Register
EECON1		equ		0x88	; EEPROM Control Register 1
EECON2		equ		0x89	; EEPROM Control Register 2
;---------------------------;

;------[ Flags ]------------;
C           EQU   	0X0  	; Carry Flag
DC          EQU    	0X1  	; Digit Carry Flag
Z           EQU    	0X2  	; Zero Flag
PD	        EQU    	0X3  	; Power Down Bit
TO	        EQU    	0X4  	; Watch Dog Time out Bit
RP0         EQU    	0X5  	; Bank Select
RP1         EQU    	0X6  	; Bank Select, Unused
IRP         EQU    	0X7  	; Unused

;------[ Option Bits ]------;
PS0         EQU    	0X0  	; Watchdog Timer Prescaler Rate
PS1         EQU    	0X1		;
PS2         EQU    	0X2		;
PSA         EQU    	0X3  	; Prescaler Assign to WDT or Timer0
TOSE        EQU    	0X4  	; Timer0 Source Edge Select
TOCS        EQU    	0X5		; Timer0 Source Select
INTEDG      EQU    	0X6 	; Interrupt Edge Select
RBPU        EQU    	0X7  	; Port B Pull Up Enable
;---------------------------;


;------[ INTCON Bits ]------;
RBIF        EQU    	0X0  	; Port B INT Flag
INTF        EQU    	0X1  	; Ext INT Flag
TOIF        EQU    	0X2  	; Timer0 Overflow INT Flag
RBIE        EQU    	0X3  	; Port B INT Enable
INTE        EQU    	0X4 	; Ext INT Enable
TOIE        EQU    	0X5 	; Timer0 Overflow INT Enable
EEIE        EQU		0X6		; EE Write Complete INT Enable
GIE	        EQU    	0X7  	; Global INT Enable
;---------------------------;

;-----[ Port A Pins ]-------;
RA0        	EQU    	0X0 	; RA General I/O
RA1         EQU    	0X1 	; RA General I/O
RA2         EQU    	0X2  	; RA General I/O 
RA3         EQU    	0X3 	; RA General I/O 
RA4         EQU    	0X4 	; RA General I/O or Timer0 clock input 
;---------------------------;

;----[ Port B Pins ]--------;
RB0        	EQU    	0X0 	; RB General I/O
RB1         EQU    	0X1 	; RB General I/O
RB2         EQU    	0X2  	; RB General I/O 
RB3         EQU    	0X3 	; RB General I/O 
RB4         EQU    	0X4 	; RB General I/O
RB5         EQU    	0X5 	; RB General I/O 
RB6         EQU    	0X6 	; RB General I/O 
RB7         EQU    	0X7 	; RB General I/O 
;---------------------------;

;------[ EECON1 Pins ]------;
RD        	EQU    	0X0 	; Read Control Bit
WR          EQU    	0X1 	; Write Control Bit
WREN        EQU    	0X2  	; EE Write Enable 
WRERR       EQU    	0X3 	; EE Error Flag 
EEIF        EQU    	0X4 	; EE Write INT Flag
;---------------------------;

;-----[ CONFIG Register ]---;
CP_ON		EQU     0x000F	; Code Protection on
CP_OFF		EQU     0x3FFF	; Code Protection off
PWRTE_ON	EQU     0x3FF7	; Power Up Timer enable
PWRTE_OFF	EQU     0x3FFF	; Power Up Timer disable
WDT_ON		EQU     0x3FFF	; Watch Dog Timer enable
WDT_OFF		EQU     0x3FFB	; Watch Dog Timer Disable
LP_OSC		EQU     0x3FFC	; CPU uses low power crystal (32K - 200K Hz)
XT_OSC		EQU    	0x3FFD	; CPU uses crystal/resonator (100K - 4M Hz)
HS_OSC		EQU     0x3FFE	; CPU uses high speed crystal/resonator (4M - 20m Hz)
RC_OSC		EQU     0x3FFF	; CPU uses resistor/capacitor 
HS_NO_WDT	EQU		0x3FFA	; CPU runs above 10MHz and WDT off
HS_N0_WDT_PTM	EQU	0x3FF2	; CPU runs above 10MHz and WDT&PTM off
;---------------------------;
