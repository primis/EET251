
;Lab 1
;simple logic
jmp start


;data


;code
start:	in 10h
	cma
	ani 00011111B
	ori 00000011B
	xri 00011100B
	hlt