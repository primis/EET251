
;Lab 2 - Binary To gray code
; port 0x10 - binary in
; port 0x12 - gray code out

jmp start

;data


;code
start:	in 10h
	mov b,a
	rar
	xra B
	out 12h
	hlt	