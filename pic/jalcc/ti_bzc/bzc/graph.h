// GRAPH.H	-	GRAPHICAL FUNCTIONS

FUNCTION dialog ARG 1
FUNCTION makedialog ARG 6

CONST DiaOk = 0
CONST DiaOkEsc = 1
CONST DiaYesNo = 2
CONST DiaYesNoEsc = 3

FSTART makedialog A B str1 str2 str3 str4
FORCE strlen
ASM
	LD HL, makedialog_data
	LD (HL), A
	INC HL
	LD (HL), B
	INC HL
	PUSH HL
ENDASM
	strlen str1
ASM
	LD B, L
	POP HL
	LD (HL), B
	
makedialog_again:
	INC HL
	




FSTART dialog HL

	STRING bOK = "Ok"
	STRING bYes = "Yes"
	STRING bNo = "No"
	STRING bEsc = "Esc"

	INT Dataptr

	BYTE buttonnum
	BYTE curbutton

	MEM buttonposition 3

	FORCE bOK
	FORCE bYes
	FORCE bNo
	FORCE bEsc
	FORCE dataptr		;Temporary storage of pointer to dialog box data
	FORCE buttonnum		; Temporary storage location for number of buttons in dialog box
	FORCE curbutton		; Temporary storage location for currently selected button
	FORCE buttonposition	; X-coordinates for use with buttoninvert

ASM

;################################################################################
;#										#
;#			Dialog Box Display Routine By Eugene Evans		#
;#										#
;#	Arguments:	HL -> pointer to dialog box data			#
;#	Returns:	Value of dialog box button in A, -1 if [CLEAR] pressed	#
;#										#
;#	Last modified:	12-19-05						#
;#										#
;#			OPEN SOURCE CODE (with credit where due)		#
;################################################################################

; Dialog box data format:
;
; # of lines of text
; Button combination: 0=[OK]; 1=[OK] and [Esc]; 2=[Yes] and [No]; 3=[Yes], [No], and [Esc]
; Default button (0 < default button <= number of buttons, or else...BOOM!)
; Title, prefaced by length in characters
; Up to 7 lines of text for dialog box text, each line prefaced by length in characters (no terminating 0)
;
;Example:
;
;
;;dialogdata:
;;	.DB	3
;;	.DB	1
;;	.DB	10,"Dialogtest"
;;	.DB	21,"Put anything you want"
;;	.DB	5,"right"
;;	.DB	5,"here!"


dialog_display:
	LD	(dialog_dataptr), HL		; Put dialog box data into temporary storage

	SET	fullScrnDraw, (IY+apiFlg4)	; Allow us to use row 0 and column 95 (for dialog boxes containing 7 lines of text)
	SET	plotLoc, (IY+plotFlags)		; Only draw to display, don't mess up graph buffer
	LD	HL, (dialog_dataptr)
	LD	B, (HL)				; B holds the number of lines of text to display; very important since this dialog box scales to the amount of text!
	LD	H, B				; So much arithmetic in here, it's painful!  I'll attempt to explain...
	LD	L, 6
	RST	$28
	.DW	_HTimesL			; H * L = number of rows (in pixels) that text takes up
	LD	A, 20				; 20 is number of rows (in pixels) that the title, buttons, and frame take up
	ADD	A, L				; B now holds the total rows that the dialog box takes up
	LD	B, A
	LD	A, 64
	SUB	B				; 64 - B = 2 * starting row for area to be cleared (to give a 1 pixel whitespace pad)
	SRA	A				; A/2, now A holds starting row for area
	LD	C, A				; Nothing special, just setting up the coordinates
	LD	H, A
	LD	L, $08
	ADD	A, B
	LD	D, A
	LD	E, $57
	PUSH	BC				; Save lots of stuff
	PUSH	HL
	PUSH	DE
ENDASM
	_ClearRect				; Clear area
ASM
	POP	DE				; Restore most of saved stuff
	POP	HL
	INC	H				; Arithmetic to get the main border
	INC	L
	DEC	D
	DEC	E
	PUSH	HL
	PUSH	DE
ENDASM
	_DrawRectBorder				; Main border
ASM
	POP	DE
	POP	HL
	INC	E				; More arithmetic
	DEC	H
	DEC	H
	INC	L
	LD	B, L
	LD	D, E
	LD	C, H
	LD	E, H
	LD	H, 1
ENDASM
	_ILine					; Horizontal shadow line
ASM
	POP	BC
	LD	A, B				; Even more arithmetic, to get the starting coordinate for the dotted line between the title and the text
	ADD	A, C
	PUSH	BC
	SUB	10
	LD	C, A
	LD	B, D
	DEC	B
	DEC	B
	DEC	B
	LD	A, 38
	PUSH	DE
	LD	D, 1
dialog_pointdisp:					; Loop to display the dotted line
	DEC	A
ENDASM
	_IPoint
ASM
	DEC	B
	DEC	B
	CP	0
	JP	NZ, dialog_pointdisp

	POP	DE
	POP	BC
	LD	A, B				; Would you believe it, MORE arithmetic
	ADD	A, C
	SUB	3
	LD	C, A
	LD	B, D
	LD	H, 1
ENDASM
	_ILine					; Vertical shadow line
ASM


dialog_dialogdisp:
	LD	HL, (dialog_dataptr)
	LD	A, (HL)				; A now holds number of text lines
	PUSH	AF				; Save it!
	LD	A, 63
	SUB	C				; A = top coord of title (DON'T LOSE!)
	PUSH	AF
	LD	HL, (dialog_dataptr)
	INC	HL
	INC	HL
	INC	HL
ENDASM
	_SStringLength				; Figure out the length of the title (for centering purposes)
ASM
	POP	AF
	LD	H, A
	LD	A, 95
	SUB	B
	SRA	A
	LD	L, A
	LD	(PenCol), HL
	LD	HL, (dialog_dataptr)
	INC	HL
	INC	HL
	INC	HL
	LD	B, (HL)
	INC	HL				; HL points to title text
	PUSH	HL				; Save HL
	PUSH	BC				; Save BC
ENDASM
	_VPutSN
ASM
	POP	BC				; Restore BC
	LD	HL, (PenCol)
	INC	H
	INC	H
	LD	(PenCol), HL			; Account for dotted dividing line
	POP	HL				; Restore HL
	POP	AF
dialog_textdisp:				; Display that text!
	DEC	A
	PUSH	AF				; Save AF
	LD	E, B
	LD	D, 0
	ADD	HL, DE
	LD	B, (HL)				; Length of text line
	INC	HL				; HL now points to beginning of text
	PUSH	HL
	LD	HL, (PenCol)
	LD	L, $0B
	LD	A, 6
	ADD	A, H
	LD	H, A
	LD	(PenCol), HL
	POP	HL				; Bring HL back
	PUSH	HL				; Save HL from destruction :-)
	PUSH	BC				; Ditto BC
ENDASM
	_VPutSN
ASM
	POP	BC
	POP	HL
	POP	AF				; Let's check the counter...
	CP	0				; ...and see if it's 0
	JP	NZ, dialog_textdisp		; If not, loop again! (wheee!)

dialog_buttondisp:				; Now we need to display the buttons for the user
	LD	HL, (dialog_dataptr)
	INC	HL
	LD	A, (HL)				; A now holds button type
	INC	HL
	LD	B, (HL)				; B now holds the default (starting button); we now know what button to select first
	LD	HL, dialog_curbutton		; Store this tidbit of info
	LD	(HL), B
	LD	HL, (PenCol)			; Now we get HL ready to accept the coordinates for the buttons
	LD	D, 8
	ADD	HL, DE
	CP	0				; Figure out what button combination is wanted
	CALL	Z, dialog_OK
	CP	1
	CALL	Z, dialog_OKCancel
	CP	2
	CALL	Z, dialog_YesNo
	CP	3
	CALL	Z, dialog_YesNoCancel
	
	CALL	buttoninvert			; Buttons are now displayed, invert the default button!

	
dialog_Keyloop:
	LD	A, $FE				; Direct input keyloop
	OUT	(1), A
	NOP
	NOP
	IN	A, (1)
	LD	HL, dialog_resumekey
	PUSH	HL
	BIT	1, A
	JP	Z, dialog_left			; move one button left
	BIT	2, A
	JP	Z, dialog_right			; move one button right
	POP	HL


dialog_resumekey:
	LD	A, $FD
	OUT	(1), A
	NOP
	NOP
	IN	A, (1)	
	BIT	6, A
	JP	Z, dialog_clear
	BIT	0, A
	JP	Z, dialog_enter
	JP	dialog_Keyloop

dialog_clear:
	LD	B, -1				; B = -1 if [CLEAR] pressed
	JP	dialog_Exit

dialog_enter:
	LD	HL, dialog_curbutton
	LD	B, (HL)				; Load button that user selected into B

dialog_Exit:
	RES	plotLoc, (IY+plotFlags)		; Reset flags
	RES	fullScrnDraw, (IY+apiFlg4)
	LD	A, $FF
	OUT	(1), A				; Reset key port
	IN	A, (1)
	LD	A, B				; Result of user selection returned in both A and B: -1 if canceled; 1, 2, or 3 corresponding to selected button
	RET					; Exit menu routine

dialog_left:
	LD	HL, dialog_curbutton		; Figure out what button are we on right now
	LD	A, (HL)
	CP	1				; If we are all the way to the left (i.e. button 1), return
	RET	Z
	CALL	dialog_buttoninvert		; Otherwise, do the deincrementing; first, deselect current button
	LD	HL, dialog_curbutton
	LD	A, (HL)
	DEC	A				; Deincrement button
	LD	(HL), A
	CALL	dialog_buttoninvert		; Select new button
	CALL	dialog_slowdown			; Wait for a bit, direct input is faaaast!
	RET

dialog_right:
	LD	HL, dialog_curbutton		; Figure out what button are we on right now
	LD	A, (HL)
	LD	HL, dialog_buttonnum
	LD	B, (HL)				; If we are all the way to the right (determined by button combo), return
	CP	B
	RET	Z
	CALL	dialog_buttoninvert		; Otherwise, do the Incrementing; first, deselect current button
	LD	HL, dialog_curbutton
	LD	A, (HL)
	INC	A				; Increment button
	LD	(HL), A
	CALL	dialog_buttoninvert		; Select new button
	CALL	dialog_slowdown			; Wait for a bit, direct input is faaaast!
	RET

dialog_OK:					; This routine will display a single, centered [OK] button
	LD	L, 43
	LD	(PenCol), HL
	CALL	dialog_buttondraw		; Calls routine to draw border of button
	LD	HL, PenCol
	INC	(HL)				; Adjustment of coordinate to center button text (insofar as possible)
	LD	HL, dialog_bOK			; Text for button
ENDASM
	_VPutS
ASM
	LD	HL, dialog_buttonnum		; Load the number of buttons to storage area
	LD	(HL), 1
	LD	HL, dialog_buttonposition	; Load x-coordinate of button to storage area for use with buttoninvert
	LD	(HL), 42
	RET

dialog_OKCancel:				; This routine will display 2 buttons, [OK] and [Esc]
	LD	L, 32
	LD	(PenCol), HL
	CALL	dialog_buttondraw		; Calls routine to draw border of button
	LD	HL, PenCol
	INC	(HL)				; Adjustment of coordinate to center button text (insofar as possible)
	LD	HL, dialog_bOK			; Text for button
ENDASM
	_VPutS
ASM
	LD	HL, (PenCol)
	LD	L, 54
	LD	(PenCol), HL
	CALL	dialog_buttondraw		; Calls routine to draw border of button
	LD	HL, dialog_bEsc			; Text for button
ENDASM
	_VPutS
ASM
	LD	HL, dialog_buttonnum		; Load the number of buttons to storage area
	LD	(HL), 2
	LD	HL, dialog_buttonposition	; Load x-coordinates of buttons to storage area for use with buttoninvert
	LD	(HL), 31
	INC	HL
	LD	(HL), 53
	RET

dialog_YesNo:					; This routine will display 2 buttons, [Yes] and [No]
	LD	L, 32
	LD	(PenCol), HL
	CALL	dialog_buttondraw		; Calls routine to draw border of button
	LD	HL, dialog_bYes			; Text for button
ENDASM
	_VPutS
ASM
	LD	HL, (PenCol)
	LD	L, 54
	LD	(PenCol), HL
	CALL	dialog_buttondraw		; Calls routine to draw border of button
	LD	HL, PenCol
	INC	(HL)				; Adjustment of coordinate to center button text (insofar as possible)
	LD	HL, dialog_bNo			; Text for button
ENDASM
	_VPutS
ASM
	LD	HL, dialog_buttonnum		; Load the number of buttons to storage area
	LD	(HL), 2
	LD	HL, dialog_buttonposition	; Load x-coordinates of buttons to storage area for use with buttoninvert
	LD	(HL), 31
	INC	HL
	LD	(HL), 53
	RET

dialog_YesNoCancel:				; This routine will display 3 buttons, [Yes], [No], and [Esc]
	LD	L, 18
	LD	(PenCol), HL
	CALL	dialog_buttondraw		; Calls routine to draw border of button
	LD	HL, dialog_bYes			; Text for button
ENDASM
	_VPutS
ASM
	LD	HL, (PenCol)
	LD	L, 43
	LD	(PenCol), HL
	CALL	dialog_buttondraw		; Calls routine to draw border of button
	LD	HL, PenCol
	INC	(HL)				; Adjustment of coordinate to center button text (insofar as possible)
	LD	HL, dialog_bNo			; Text for button
ENDASM
	_VPutS
ASM
	LD	HL, (PenCol)
	LD	L, 68
	LD	(PenCol), HL
	CALL	dialog_buttondraw		; Calls routine to draw border of button
	LD	HL, dialog_bEsc			; Text for button
ENDASM
	_VPutS
ASM
	LD	HL, dialog_buttonnum		; Load the number of buttons to storage area
	LD	(HL), 3
	LD	HL, dialog_buttonposition	; Load x-coordinates of buttons to storage area for use with buttoninvert
	LD	(HL), 17
	INC	HL
	LD	(HL), 42
	INC	HL
	LD	(HL), 67
	RET

dialog_buttondraw:				; Routine to draw border of each button, based on the coordinates of the text to go inside
	LD	HL, (PenCol)			; Coordinates of button text
	DEC	L
	DEC	L
	DEC	H
	LD	A, L
	ADD	A, 13				; Button is 13 pixels wide
	LD	E, A
	LD	A, 8				; 8 pixels tall
	ADD	A, H
	LD	D, A
ENDASM
	_DrawRectBorder
ASM
	RET

dialog_buttoninvert:				; Routine to invert the interior of the button, based on the currently selected button in curbutton (row does not change)
	LD	HL, dialog_curbutton		; Get currently selected button
	LD	A, (HL)
	DEC	A
	LD	HL, dialog_buttonposition	; Figure out the position of the x-coordinate in the list
	ADD	A, L
	LD	L, A
	LD	A, (HL)				; Actually load the x-coordinate
	LD	HL, (PenCol)
	LD	L, A				; ...Arithmetic...
	ADD	A, 11
	LD	E, A
	LD	A, 6
	ADD	A, H
	LD	D, A
ENDASM
	_INVERTRECT				; Finally! Invert that button!
ASM
	RET
	
dialog_slowdown:				; Slow down loop, adjustable from $1000 to $FFFF
	LD	DE, $5000
dialog__slowloop:
	DEC	DE
	LD	A, D
	CP	0
	JP	NZ, dialog__slowloop

ENDASM
FEND