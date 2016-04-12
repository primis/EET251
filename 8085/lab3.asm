
;Lab 3
; Overflow detector
; Adds data from ports 0x10 + 0x12 and stores in memory 0x10

jmp start

;data


;code
start:	in 10h
	mov B,A
	in 12h
	add B	
	sta 11h
	ral
	ani 01h
	sta 10h
	hlt