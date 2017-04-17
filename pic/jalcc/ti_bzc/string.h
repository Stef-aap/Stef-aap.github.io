FUNCTION strlen ARG 1
FUNCTION strcpy ARG 2
FUNCTION strncpy ARG 3
FUNCTION strcat ARG 2
FUNCTION strncat ARG 3

FSTART strlen DE
ASM
	LD HL, 0
strlen_again:
	LD A, (DE)
	INC DE
	INC HL
	OR 0
	JP NZ, strlen_again
ENDASM
FEND

FSTART strcpy HL DE
ASM
strcpy_again:
	LD A, (DE)
	LD (HL), A
	OR 0
	JP NZ, strcpy_again
ENDASM
FEND

FSTART strncpy HL DE A
ASM
	LD B, A
strncpy_again:
	LD A, (DE)
	LD (HL), A
	OR 0
	RET Z
	DJNZ strncpy_again
ENDASM
FEND

FSTART strncat HL DE A
FORCE strlen
FORCE strncpy
ASM
	PUSH HL
	CALL strlen_again
	POP HL
	JP strncpy_again
ENDASM
FEND

FSTART strcat HL DE
FORCE strlen
FORCE strcpy
ASM
	PUSH HL
	CALL strlen_again
	POP HL
	JP strcpy_again
ENDASM
FEND
