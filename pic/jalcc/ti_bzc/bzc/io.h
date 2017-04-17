
FUNCTION cls 
FUNCTION putc ARG 1
FUNCTION puts ARG 1
FUNCTION dispnum ARG 1

FUNCTION locate ARG 2
FUNCTION locnum
FUNCTION printNum ARG 1
FUNCTION print ARG 1
FUNCTION printf ARG 2


// For printf
CONST num = 0
CONST str = 1
CONST char = 2
// For locate
CONST NumRight = 11

FSTART cls
	_ClrScrnFull
	ASM
		LD HL, 0
		LD (curRow), HL
	ENDASM
FEND

FSTART dispnum HL
	_DispHL
FEND

FSTART puts HL
	_PutS
FEND

FSTART putc HL
	_PutC
FEND

FSTART locate curRow curCol
FEND	

FSTART locnum
ASM
	LD A, NumRight
	LD (curCol), A
ENDASM
FEND

FSTART printNum DE
	curCol = NumRight
ASM
	EX DE, HL
ENDASM
	_DispHL
	_NewLine
FEND

FSTART print HL 
	_PutS
	_NewLine
FEND

FSTART printf A DE
ASM
	EX DE, HL
	CP 1
	JP Z, printf_string
	CP 2
	JP Z, printf_char
ENDASM
	_DispHL
ASM
	JP printf_end
printf_string:
ENDASM
	_PutS
ASM
	JP printf_end
printf_char:
	LD A, L
ENDASM
	PutC
ASM
printf_end:
ENDASM
	_NewLine
FEND
