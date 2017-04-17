FUNCTION menu ARG 2
FUNCTION menuoption ARG 3

;################################################################################
;#										#
;#			Menu Display Routine By Eugene Evans			#
;#										#
;#	Arguments:	HL -> pointer to menu data				#
;#	Returns:	Value of menu item in A, or -1 if [_Clear] pressed	#
;#										#
;#	Last modified:	01-21-06						#
;#										#
;#			OPEN SOURCE CODE (with credit where due)		#
;################################################################################

;Menu entry format:
;(up to 255 menu items allowed)
;
;Example:
;
;menudata:
;	.DB	10					; Number of menu items (a title is assumed)
;	.DW	menu_title				; Address of menu title
;	.DW	entry_1					; Address of first entry...
;	.DW	entry_2					; ""
;	.DW	entry_3
;	.DW	entry_4
;	.DW	entry_5
;	.DW	entry_6
;	.DW	entry_7
;	.DW	entry_8
;	.DW	entry_9
;	.DW	entry_10
;
;menu_title:
;	.DB	"MenuTest",0
;entry_1:
;	.DB	"Option1",0
;entry_2:
;	.DB	"Option2",0
;entry_3:
;	.DB	"Option3",0
;entry_4:
;	.DB	"Option4",0
;entry_5:
;	.DB	"Option5",0
;entry_6:
;	.DB	"Option6",0
;entry_7:
;	.DB	"Option7",0
;entry_8:
;	.DB	"Option8",0
;entry_9:
;	.DB	"Option9",0
;entry_10:
;	.DB	"Option10",0


BYTE menu_display__entry_num

FSTART menu display__dataptr menu_display__entry_num
INT display__cursor_coord				; Current top-left coordinates of menu cursor
BYTE display__cur_entry					; Current highlighted menu item, relative to top entry in current window (1-5)
BYTE display__top_entry					; Top menu item in current window
BYTE display__entry_end					; Bottom menu item in current window
BYTE display__temp					; Temporary loop variable

STRING display__num_preface 	= " 1234567890"		; Data for displaying the preface
STRING display__begin_preface 	= "   "			; Beginning of the preface
STRING display__2ndhalf_preface = " :  "		; Second half of the preface

FORCE display__cursor_coord
FORCE display__cur_entry
FORCE display__top_entry
FORCE display__entry_end
FORCE display__temp
FORCE display__num_preface
FORCE display__begin_preface
FORCE display__2ndhalf_preface

ASM
menu_display:						; Beginning of main routine
; Draw menu box
	SET	plotLoc, (IY+plotFlags)			; Only draw to display, don't mess up graph buffer
	LD	HL, $0808
	LD	DE, $3857
ENDASM
	_ClearRect				; Clear area
ASM
	LD	HL, $0909
	LD	DE, $3656
ENDASM
	_DrawRectBorder				; Main border
ASM
	LD	BC, $0A08
	LD	DE, $5708
ENDASM
	_ILine					; Horizontal shadow line
ASM
	LD	BC, $5708
	LD	DE, $5735
ENDASM
	_ILine					; Vertical shadow line
ASM
	LD	BC, $0A2E
	LD	A, 38
	LD	D, 1

menu_display_pointdisp:					; Draw points separating title from choices
	DEC	A
ENDASM
	_IPoint
ASM
	INC	B
	INC	B
	AND	A					; CP 0 (saves 1 byte)
	JP	NZ, menu_display_pointdisp

	LD	HL, $0A0B				; Set coordinates of title to top-left of menu box
	LD	(PenCol), HL
	LD	HL, menu_display__entry_num
	LD	A, (HL)
	LD	HL, menu_display__entry_end
	LD	(HL), A					; Set bottom menu item number to the number of menu items (we'll check next to make sure it's not over 5)
	CP	5					; See if a scrolling menu is wanted (if there are _more than 5 items...)
	JP	C, menu_display_resumedisp		; If not, jump!

	LD	(HL), 5					; Adjust the bottom menu item number to 5

menu_display_resumedisp:
	LD	HL, (menu_display__dataptr)		; HL holds address of menu title

	CALL	menu_display_Goto_address		; Make HL point to that address

ENDASM
	_VPutS					; Display away!!
ASM

	LD	HL, (menu_display__dataptr)
	INC	HL
	INC	HL
	LD	(menu_display__dataptr), HL		; temporary pointer now points to first menu item
	LD	HL, PenCol+1
	INC	(HL)
	INC	(HL)					; Increment row down 2, to make room for divider points
	CALL	menu_display_Clear

	LD	HL, menu_display__cur_entry		; Initialize the current menu item and the top menu item to 1 (we're starting at the top...)
	LD	(HL), 1
	LD	HL, menu_display__top_entry
	LD	(HL), 1
	LD	HL, (menu_display__dataptr)
	CALL	menu_display_Choicedisp			; Display menu items

	LD	HL, $130A
	LD	(menu_display__cursor_coord), HL
	CALL	menu_display_Invert			; Display the cursor


menu_display_keyloop:					; Direct input keyloop
	LD	A, $FE					; Key group containing arrow keys
	OUT	(1), A
	NOP
	NOP
	IN	A, (1)
	BIT	0, A
	JP	Z, menu_display_down
	BIT	3, A
	JP	Z, menu_display_up	

menu_display_resume_keyloop:
	LD	A, $FD					; Key group containing [ENTER] and [_Clear]
	OUT	(1), A
	NOP
	NOP
	IN	A, (1)	
	BIT	0, A
	JP	Z, menu_display_enterkey

	LD	HL, menu_display_exit			; Load the exit address
	PUSH	HL					; PUSH the address onto the stack; the following JP routines are terminated with RET, which pops the top entry on the stack into PC, and consequently jumping quickly to the exit address
	BIT	6, A
	JP	Z, menu_display_clearkey

	LD	A, $EF					; Key group containing 0, 1, 4, and 7
	OUT	(1), A
	NOP
	NOP
	IN	A, (1)
	BIT	0, A
	JP	Z, menu_display_key0
	BIT	1, A
	JP	Z, menu_display_key1
	BIT	2, A
	JP	Z, menu_display_key4
	BIT	3, A
	JP	Z, menu_display_key7

	LD	A, $F7					; Key group containing 2, 5, and 8
	OUT	(1), A
	NOP
	NOP
	IN	A, (1)
	BIT	1, A
	JP	Z, menu_display_key2
	BIT	2, A
	JP	Z, menu_display_key5
	BIT	3, A
	JP	Z, menu_display_key8

	LD	A, $FB					; Key group containing 3, 6, and 9
	OUT	(1), A
	NOP
	NOP
	IN	A, (1)
	BIT	1, A
	JP	Z, menu_display_key3
	BIT	2, A
	JP	Z, menu_display_key6
	BIT	3, A
	JP	Z, menu_display_key9
	POP	AF					; Get rid of the PUSH, since it wasn't used this time around
	JP	menu_display_keyloop

							; These next key labels should be self-evident...
menu_display_clearkey:
	LD	B, -1
	RET

menu_display_key0:
	LD	B, 10
	RET

menu_display_key1:
	LD	B, 1
	RET

menu_display_key2:
	LD	B, 2
	RET

menu_display_key3:
	LD	B, 3
	RET

menu_display_key4:
	LD	B, 4
	RET

menu_display_key5:
	LD	B, 5
	RET

menu_display_key6:
	LD	B, 6
	RET

menu_display_key7:
	LD	B, 7
	RET

menu_display_key8:
	LD	B, 8
	RET

menu_display_key9:
	LD	B, 9
	RET	

menu_display_enterkey:
	LD	HL, menu_display__cur_entry
	LD	B, (HL)

menu_display_exit:
	RES	plotLoc, (IY+plotFlags)			; Reset flag
	LD	A, $FF
	OUT	(1), A					; Reset key port
	NOP
	NOP
	IN	A, (1)
	LD	A, B					; A and B both hold the user selection
	LD	L, A
	LD 	H, 0
	CP	$FF
	RET	NZ
	LD	H, $FF
	RET						; Exit menu routine

menu_display_down:					
	LD	HL, menu_display__entry_num
	LD	A, (HL)
	LD	HL, menu_display__cur_entry
	CP	(HL)					; Are we on the last menu item already?
	JP	Z, menu_display_resume_keyloop		; if yes, then return

	INC	(HL)

	CALL	menu_display_Invert			; Erase cursor

	CALL	menu_display_Comp_c_t_entry		; Get ready for comparison to see if we need to scroll the menu

	CP	4
	JP	Z, menu_display_more			; Hmm, need to scroll menu down

	CALL	menu_display_Slowdown			; Slow down transition between menu items (direct input = fast!)

	LD	HL, (menu_display__cursor_coord)
	LD	A, 7
	ADD	A, H
	LD	H, A					; Shift cursor coordinates down 7 pixels to next entry
	LD	(menu_display__cursor_coord), HL
	JP	menu_display_resume_pre_key
	
menu_display_resume_pre_key:
	CALL	menu_display_Invert			; Display cursor
	JP	menu_display_resume_keyloop
	
menu_display_up:
	LD	HL, menu_display__cur_entry
	LD	A, (HL)
	CP	1					; Are we on the first menu item already?
	JP	Z, menu_display_resume_keyloop		; if yes, then return

	DEC	(HL)

	CALL	menu_display_Invert			; Erase cursor

	CALL	menu_display_Comp_c_t_entry		; Get ready for comparison to see if we need to scroll the menu

	CP	-2
	JP	Z, menu_display_less			; Hmm, need to scroll menu up

	CALL	menu_display_Slowdown			; Slow down transition between menu items (direct input = too fast!)

	LD	HL, (menu_display__cursor_coord)
	LD	A, -7
	ADD	A, H
	LD	H, A					; Shift cursor coordinates up 7 pixels to previous entry
	LD	(menu_display__cursor_coord), HL
	JP	menu_display_resume_pre_key

menu_display_Slowdown:					; Slow down loop, adjustable from $1000 to $FFFF
	LD	DE, $2000

menu_display_slowloop:
	DEC	DE
	LD	A, D
	AND	A					; CP 0 (saves 1 byte)
	JP	NZ, menu_display_slowloop
	RET

menu_display_Comp_c_t_entry:				; Routine to ready menu_display__top_entry and menu_display__cur_entry for comparison
	LD	HL, menu_display__top_entry
	LD	A, (HL)
	CPL
	LD	HL, menu_display__cur_entry
	ADD	A, (HL)
	RET

menu_display_Clear:					; Routine to clear the menu window
	LD	HL, $130B
	LD	DE, $3555
ENDASM
	_ClearRect				; Clear that rectangle!
ASM
	RET

menu_display_Invert:					; Routine that calculates DE (lower right coord.) from HL, inverts cursor rectangle
	LD	HL, (menu_display__cursor_coord)				
	LD	D, H
	LD	A, 6
	ADD	A, D
	LD	D, A
	LD	E, $55
ENDASM
	_InvertRect				; Invert that rectangle!
ASM
	RET

menu_display_less:					; Lower-number menu choices wanted, that's why we're here...
	LD	HL, menu_display__top_entry
	DEC	(HL)					; Decrease the top menu entry in the window
	INC	HL
	DEC	(HL)					; Decrease the bottom menu entry in the window (menu_display__entry_end is right after menu_display__top_entry in memory)
	JP	menu_display_mainml

menu_display_more:					; Higher-number menu choices wanted, that's why we're here...
	LD	HL, menu_display__top_entry
	INC	(HL)					; Increase the top menu entry in the window
	INC	HL
	INC	(HL)					; Decrease the bottom menu entry in the window (menu_display__entry_end is right after menu_display__top_entry in memory)

menu_display_mainml:
	CALL	menu_display_Clear			; Clear the window
	LD	HL, $0C0B
	LD	(PenCol), HL				; Reset PenCol to top of menu window for first entry
	LD	HL, menu_display__top_entry
	LD	E, (HL)					; Now we need to calculate how far to jump in memory to get the correct first entry to display
	DEC	E					; Now we know how many entries to go past
	LD	D, 0
	LD	L, E					; Copy this to HL
	LD	H, 0
	ADD	HL, DE					; Double it; have to multiply by 2 because the addresses are 2 bytes
	LD	E, L
	LD	D, H					; DE now holds number bytes of the addresses to jump past
	LD	HL, (menu_display__dataptr)			; Reset HL to beginning of menu data
	ADD	HL, DE					; HL holds address of correct first entry

	CALL	menu_display_Choicedisp			; Display away!!

	JP	menu_display_resume_pre_key

menu_display_Choicedisp:				; Displays the set of menu items, from 1 to 5 (depending what numbers menu_display__top_entry and menu_display__entry_end hold)
	EX	DE, HL					; Save HL
	LD	HL, menu_display__top_entry		; Here we are initializing the loop variable menu_display__temp
	LD	A, (HL)
	DEC	A					; Decrease it, because the loop increases it immediately, and we want to start on the entry number that __top_entry holds
	LD	HL, menu_display__temp
	LD	(HL), A
	EX	DE, HL					; Restore HL

menu_display_disploop:					; Loop to display choices
	PUSH	HL					; Save our position in the list of addresses

	CALL	menu_display_Goto_address		; Make HL point to said address
	
	PUSH	HL					; Save HL
	LD	HL, PenCol
	LD	(HL), $0B				; PenCol reset to edge of menu
	LD	A, 7
	INC	HL
	ADD	A, (HL)
	LD	(HL), A					; PenRow incremented by 7 pixels
	LD	HL, menu_display__temp
	LD	A, (HL)
	INC	A					; Increment the loop variable; this has the added effect of setting A to the number we need to display the preface...
	LD	(HL), A
	CALL menu_display_Disp_preface			; Display the number before the entry (a space if over 10)

	POP	HL			
ENDASM
	_VPutS					; Do the displaying
ASM

	LD	HL, menu_display__entry_end		; Get ready to compare the loop variable with menu_display__entry_end
	LD	B, (HL)
	INC	HL
	LD	A, (HL)
	POP	HL					; Retrieve current position in list of addresses in HL
	INC	HL
	INC	HL					; Advance HL 2 bytes (to address of next menu item)
	CP	B					; See if we've displayed the last of the menu items
	JP	NZ, menu_display_disploop		; If not, loop again
	RET

menu_display_Goto_address:				; Routine to convert the data held by HL into an address that HL points to
	LD	B, (HL)					; Get the first byte of the address we want
	INC	HL					; HL now points to second byte
	LD	C, (HL)					; Get the second byte of the address we want
	LD	H, C					; Load it back up
	LD	L, B					; After this instruction, HL points to the address it formerly held
	RET

menu_display_Disp_preface:				; Routine to display either a number (1-9 and 0), or a space before the current menu item
	LD	B, 0					; B is used as a switch: 0=display number; 1=display space
	CP	11					; See if the current menu item is above number 10
	JP	C, menu_display_continue_preface	; If not, the appropriate number will be displayed in front of it
	
	XOR	A					; LD	A, 0 (saves 1 byte)
	LD	B, 1					; A space will be displayed

menu_display_continue_preface:
	LD	E, A					; Get ready to calculate which character we need to copy
	LD	D, 0
	LD	IX, menu_display__num_preface
	ADD	IX, DE					; IX now points to the character we want
	LD	HL, menu_display__2ndhalf_preface
	LD	A, (IX)					; Get the character from (IX)
	LD	(HL), A					; Put it in (HL)
	LD	A, B					; Now we see if it's a number or a space we want
	AND	A					; CP 0 (saves 1 byte)
	JP	Z, menu_display_res_disp_pref		; If B=0, it's a number

	LD	HL, menu_display__begin_preface		; B=1, so we need a space (in variable-width font, a space has a width of 1 pixel, a number 4 pixels.  Thus, to preserve the proper spacing of the entries, we must display 4 spaces to get a space of the same width as a number)

menu_display_res_disp_pref:
ENDASM
	_VPutS					; Display away!!
FEND

FSTART menuoption HL A DE
  ASM
    CP 0
    JP Z, menuoption_cont
    LD B, A
menuoption_again:
    INC HL
    INC HL
    DJNZ menuoption_again
menuoption_cont:
    LD  (HL), E
    INC HL
    LD  (HL), D
  ENDASM
FEND
