
FUNCTION sleep USER ARG 1

FSTART sleep D
ASM
	DEC D
	LD E, $FF
sleep_loop1:
	LD B, $9F
sleep_loop2:
	DJNZ sleep_loop2
	DEC DE
	LD A, D
	OR E
	JP NZ, sleep_loop1
ENDASM
FEND
	
