
FUNCTION __multiply__ USER 
FUNCTION __devide__ USER
FUNCTION __remainder__ USER

FSTART __multiply__
ASM
	LD B, H
	LD C, L
	LD HL, 0
__multiply___again:
	LD A, B
	OR C
	RET Z
	ADD HL, DE
	DEC BC
	JP __multiply___again
ENDASM
FEND

FSTART __devide__
__remainder__
ASM
	LD H, B
	LD L, C
ENDASM
FEND

FSTART __remainder__
ASM
	EX DE, HL
	LD A, D
	OR E
	JP Z, __remainder___null
	LD BC, 0
__remainder___again:
	LD A, H
	CP D
	RET C
	JR NZ, __remainder___begin
	LD A, L
	CP E
	RET C
__remainder___begin:
	SBC HL, DE
	INC BC
	JP __remainder___again
__remainder___null:
	LD BC, $FFFF
	LD HL, $FFFF
ENDASM
FEND
