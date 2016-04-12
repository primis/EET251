
;Lab 4
; Sign detector
jmp start

;data


;code
start:	in 10h
	ral
	cc  negative
	cnc positive 
	mov a, b
	out 12h
	hlt

negative:	mvi b,80h
		ret
positive:	mvi b, 1h
		ret
 	