// romcalls.h by Erik van 't Wout
//
// All the TI-83+ TIOS ROMCALLS.

//======================================================================
// Include File for the TI-83 Plus
// Last Updated 9/17/2002 
//
// Copyright (c) 1999, 2001, 2002 Texas Instruments: The Licensed Materials are
// copyrighted by TI. LICENSEE agrees that it will 
// not delete the copyright notice, trademarks or
// protective notices from any copy made by LICENSEE.
//
// Warranty: TI does not warrant that the Licensed Materials will
// be free from errors or will meet your specific requirements.
// The Licensed Materials are made available "AS IS" to LICENSEE.
//
// Limitations: TI MAKES NO WARRANTY OR CONDITION, EITHER EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO ANY IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE,
// REGARDING THE LICENSED MATERIALS.  IN NO EVENT SHALL
// TI OR ITS SUPPLIERS BE LIABLE FOR ANY INDIRECT, INCIDENTAL
// OR CONSEQUENTIAL DAMAGES, LOSS OF PROFITS, LOSS OF USE OR DATA, 
// OR INTERRUPTION OF BUSINESS, WHETHER THE ALLEGED DAMAGES ARE
// LABELED IN TORT, CONTRACT OR INDEMNITY.
//=======================================================================
// THANKS TO: DAVID LINDSRÖM
// CIRRUS PROGRAMMING
// http://cirrus.tigalaxy.com
//=======================================================================

//======================================================================
//           System Variable Equates
//======================================================================
//       Entry Points : RclSysTok, StoSysTok
//

CONST XSCLt	= 2
CONST YSCLt	= 3
CONST XMINt	= $0A
CONST XMAXt	= $0B
CONST YMINt	= $0C
CONST YMAXt	= $0D
CONST TMINt	= $0E
CONST TMAXt	= $0F
CONST THETMINt	= $10
CONST THETMAXt	= $11
CONST TBLMINt	= $1A
CONST PLOTSTARTt	= $1B
CONST NMAXt	= $1D
CONST NMINt	= $1F
CONST TBLSTEPt	= $21
CONST TSTEPt	= $22
CONST THETSTEPt	= $23
CONST DELTAXt	= $26
CONST DELTAYt	= $27
CONST XFACTt	= $28
CONST YFACTt	= $29
CONST FINNt	= $2B
CONST FINIt	= $2C
CONST FINPVt	= $2D
CONST FINPMTt	= $2E
CONST FINFVt	= $2F
CONST FINPYt	= $30
CONST FINCYt	= $31
CONST PLOTSTEPt	= $34
CONST XRESt	= $36

//======================================================================
//           Run indicators
//======================================================================

CONST busyPause	= #10101010
CONST busyNormal	= #11110000

//======================================================================
//           Common subroutine RST numbers  
//======================================================================

CONST rOP1TOOP2	= $08
CONST rFINDSYM	= $10
CONST rPUSHREALO1	= $18
CONST rMOV9TOOP1	= $20
CONST rFPADD	= $30

//
//======================================================================
//           System-defined RAM Variable Address Equates
//======================================================================
//

SYSVAR ramStart             =  $8000
SYSVAR appData              =  $8000
SYSVAR ramCode              =  $8100
SYSVAR ramCodeEnd           =  $822F
SYSVAR baseAppBrTab         =  $8230
SYSVAR bootTemp             =  $8251
SYSVAR appSearchPage        =  $82A3
SYSVAR tempSwapArea         =  $82A5
SYSVAR appID                =  $838D
SYSVAR ramReturnData        =  $83ED
SYSVAR arcInfo              =  $83EE
SYSVAR savedArcInfo         =  $8406
SYSVAR appInfo              =  $8432
SYSVAR appBank_jump         =  $843C
SYSVAR appPage              =  $843E
SYSVAR kbdScanCode          =  $843F
SYSVAR kbdKey               =  $8444
SYSVAR kbdGetKy             =  $8445
SYSVAR keyExtend            =  $8446
SYSVAR contrast             =  $8447
SYSVAR apdSubTimer          =  $8448
SYSVAR apdTimer             =  $8449
SYSVAR curTime              =  $844A
SYSVAR curRow               =  $844B
SYSVAR curCol               =  $844C
SYSVAR curOffset            =  $844D
SYSVAR curUnder             =  $844E
SYSVAR curY                 =  $844F
SYSVAR curType              =  $8450
SYSVAR curXRow              =  $8451
SYSVAR prevDData            =  $8452
SYSVAR lFont_record         =  $845A
SYSVAR sFont_record         =  $8462
SYSVAR tokVarPtr            =  $846A
SYSVAR tokLen               =  $846C
SYSVAR indicMem             =  $846E
SYSVAR indicCounter         =  $8476
SYSVAR indicBusy            =  $8477
SYSVAR OP1                  =  $8478
SYSVAR OP1M                 =  $847A
SYSVAR OP2                  =  $8483
SYSVAR OP2M                 =  $8485
SYSVAR OP2EXT               =  $848C
SYSVAR OP3                  =  $848E
SYSVAR OP3M                 =  $8490
SYSVAR OP4                  =  $8499
SYSVAR OP4M                 =  $849B
SYSVAR OP5                  =  $84A4
SYSVAR OP5M                 =  $84A6
SYSVAR OP6                  =  $84AF
SYSVAR OP6M                 =  $84B1
SYSVAR OP6EXT               =  $84B8
SYSVAR progToEdit           =  $84BF
SYSVAR nameBuff             =  $84C7
SYSVAR equ_edit_save        =  $84D2
SYSVAR iMathPtr1            =  $84D3
SYSVAR iMathPtr2            =  $84D5
SYSVAR iMathPtr3            =  $84D7
SYSVAR iMathPtr4            =  $84D9
SYSVAR iMathPtr5            =  $84DB
SYSVAR chkDelPtr1           =  $84DD
SYSVAR chkDelPtr2           =  $84DF
SYSVAR insDelPtr            =  $84E1
SYSVAR upDownPtr            =  $84E3
SYSVAR fOutDat              =  $84E5
SYSVAR asm_data_ptr1        =  $84EB
SYSVAR asm_data_ptr2        =  $84ED
SYSVAR asm_sym_ptr1         =  $84EF
SYSVAR asm_sym_ptr2         =  $84F1
SYSVAR asm_ram              =  $84F3
SYSVAR asm_ind_call         =  $8507
SYSVAR textShadow           =  $8508
SYSVAR textShadCur          =  $8588
SYSVAR textShadTop          =  $858A
SYSVAR textShadAlph         =  $858B
SYSVAR textShadIns          =  $858C
SYSVAR cxMain               =  $858D
SYSVAR cxPPutAway           =  $858F
SYSVAR cxPutAway            =  $8591
SYSVAR cxRedisp             =  $8593
SYSVAR cxErrorEP            =  $8595
SYSVAR cxSizeWind           =  $8597
SYSVAR cxPage               =  $8599
SYSVAR cxCurApp             =  $859A
SYSVAR cxPrev               =  $859B
SYSVAR monQH                =  $85AA
SYSVAR monQT                =  $85AB
SYSVAR monQueue             =  $85AC
SYSVAR onSP                 =  $85BC
SYSVAR promptRow            =  $85C0
SYSVAR promptCol            =  $85C1
SYSVAR promptIns            =  $85C2
SYSVAR promptShift          =  $85C3
SYSVAR promptRet            =  $85C4
SYSVAR promptValid          =  $85C6
SYSVAR promptTop            =  $85C8
SYSVAR promptCursor         =  $85CA
SYSVAR promptTail           =  $85CC
SYSVAR promptBtm            =  $85CE
SYSVAR varType              =  $85D0
SYSVAR varCurrent           =  $85D1
SYSVAR varClass             =  $85D9
SYSVAR menuActive           =  $85DC
SYSVAR menuAppDepth         =  $85DD
SYSVAR MenuCurrent          =  $85DE
SYSVAR ProgCurrent          =  $85E8
SYSVAR userMenuSA           =  $85FE
SYSVAR ioPrompt             =  $865F
SYSVAR dImageWidth          =  $8660
SYSVAR RectFillPHeight      =  $8660
SYSVAR RectFillPWidth       =  $8661
SYSVAR RectFillPattern      =  $8662
SYSVAR ioFlag               =  $8670
SYSVAR sndRecState          =  $8672
SYSVAR ioErrState           =  $8673
SYSVAR header               =  $8674
SYSVAR ioData               =  $867D
SYSVAR ioNewData            =  $8689
SYSVAR bakHeader            =  $868B
SYSVAR penCol               =  $86D7
SYSVAR penRow               =  $86D8
SYSVAR rclQueue             =  $86D9
SYSVAR rclQueueEnd          =  $86DB
SYSVAR errNo                =  $86DD
SYSVAR errSP                =  $86DE
SYSVAR errOffset            =  $86E0
SYSVAR saveSScreen          =  $86EC
SYSVAR bstCounter           =  $89EE
SYSVAR flags                =  $89F0
SYSVAR statVars             =  $8A3A
SYSVAR anovaf_vars          =  $8C17
SYSVAR infVars              =  $8C4D
SYSVAR curGStyle            =  $8D17
SYSVAR curGY                =  $8D18
SYSVAR curGX                =  $8D19
SYSVAR curGY2               =  $8D1A
SYSVAR curGX2               =  $8D1B
SYSVAR freeSaveY            =  $8D1C
SYSVAR freeSaveX            =  $8D1D
SYSVAR XOffset              =  $8DA1
SYSVAR YOffset              =  $8DA2
SYSVAR lcdTallP             =  $8DA3
SYSVAR pixWideP             =  $8DA4
SYSVAR pixWide_m_1          =  $8DA5
SYSVAR pixWide_m_2          =  $8DA6
SYSVAR lastEntryPTR         =  $8DA7
SYSVAR lastEntryStk         =  $8DA9
SYSVAR numLastEntries       =  $8E29
SYSVAR currLastEntry        =  $8E2A
SYSVAR curInc               =  $8E67
SYSVAR uXmin                =  $8E7E
SYSVAR uXmax                =  $8E87
SYSVAR uXscl                =  $8E90
SYSVAR uYmin                =  $8E99
SYSVAR uYmax                =  $8EA2
SYSVAR uYscl                =  $8EAB
SYSVAR uThetMin             =  $8EB4
SYSVAR uThetMax             =  $8EBD
SYSVAR uThetStep            =  $8EC6
SYSVAR uTmin                =  $8ECF
SYSVAR uTmax                =  $8ED8
SYSVAR uTStep               =  $8EE1
SYSVAR uPlotStart           =  $8EEA
SYSVAR unMax                =  $8EF3
SYSVAR uu0                  =  $8EFC
SYSVAR uv0                  =  $8F05
SYSVAR unMin                =  $8F0E
SYSVAR uu02                 =  $8F17
SYSVAR uv02                 =  $8F20
SYSVAR uw0                  =  $8F29
SYSVAR uPlotStep            =  $8F32
SYSVAR uXres                =  $8F3B
SYSVAR uw02                 =  $8F44
SYSVAR Xmin                 =  $8F50
SYSVAR Xmax                 =  $8F59
SYSVAR Xscl                 =  $8F62
SYSVAR Ymin                 =  $8F6B
SYSVAR Ymax                 =  $8F74
SYSVAR Yscl                 =  $8F7D
SYSVAR ThetaMin             =  $8F86
SYSVAR ThetaMax             =  $8F8F
SYSVAR ThetaStep            =  $8F98
SYSVAR TminPar              =  $8FA1
SYSVAR TmaxPar              =  $8FAA
SYSVAR Tstep                =  $8FB3
SYSVAR PlotStart            =  $8FBC
SYSVAR nMax                 =  $8FC5
SYSVAR u0                   =  $8FCE
SYSVAR v0                   =  $8FD7
SYSVAR nMin                 =  $8FE0
SYSVAR u02                  =  $8FE9
SYSVAR v02                  =  $8FF2
SYSVAR w0                   =  $8FFB
SYSVAR PlotStep             =  $9004
SYSVAR XresO                =  $900D
SYSVAR w02                  =  $9016
SYSVAR un1                  =  $901F
SYSVAR un2                  =  $9028
SYSVAR vn1                  =  $9031
SYSVAR vn2                  =  $903A
SYSVAR wn1                  =  $9043
SYSVAR wn2                  =  $904C
SYSVAR fin_N                =  $9055
SYSVAR fin_I                =  $905E
SYSVAR fin_PV               =  $9067
SYSVAR fin_PMT              =  $9070
SYSVAR fin_FV               =  $9079
SYSVAR fin_PY               =  $9082
SYSVAR fin_CY               =  $908B
SYSVAR cal_N                =  $9094
SYSVAR cal_I                =  $909D
SYSVAR cal_PV               =  $90A6
SYSVAR cal_PMT              =  $90AF
SYSVAR cal_FV               =  $90B8
SYSVAR cal_PY               =  $90C1
SYSVAR smallEditRAM         =  $90D3
SYSVAR XFact                =  $913F
SYSVAR YFact                =  $9148
SYSVAR Xres_int             =  $9151
SYSVAR deltaX               =  $9152
SYSVAR deltaY               =  $915B
SYSVAR shortX               =  $9164
SYSVAR shortY               =  $916D
SYSVAR lower                =  $9176
SYSVAR upper                =  $917F
SYSVAR XOutSym              =  $918C
SYSVAR XOutDat              =  $918E
SYSVAR YOutSym              =  $9190
SYSVAR YOutDat              =  $9192
SYSVAR inputSym             =  $9194
SYSVAR inputDat             =  $9196
SYSVAR prevData             =  $9198
SYSVAR TblMin               =  $92B3
SYSVAR TblStep              =  $92BC
SYSVAR P1Type	     =  $92C9
SYSVAR SavX1List	     =  $92CA
SYSVAR SavY1List	     =  $92CF
SYSVAR SavF1List	     =  $92D4
SYSVAR P1FrqOnOff	     =  $92D9
SYSVAR P2Type		     =  $92DA
SYSVAR SavX2List	     =  $92DB
SYSVAR SavY2List	     =  $92E0
SYSVAR SavF2List	     =  $92E5
SYSVAR P2FrqOnOff	     =  $92EA
SYSVAR P3Type		     =  $92EB
SYSVAR SavX3List	     =  $92EC
SYSVAR SavY3List	     =  $92F1
SYSVAR SavF3List	     =  $92F6
SYSVAR P3FrqOnOff	     =  $92FB
SYSVAR plotSScreen          =  $9340
SYSVAR seed1                =  $9640
SYSVAR seed2                =  $9649
SYSVAR cmdShadow            =  $966E
SYSVAR cmdShadCur           =  $96EE
SYSVAR cmdShadAlph          =  $96F0
SYSVAR cmdShadIns           =  $96F1
SYSVAR cmdCursor            =  $96F2
SYSVAR editTop              =  $96F4
SYSVAR editCursor           =  $96F6
SYSVAR editTail             =  $96F8
SYSVAR editBtm              =  $96FA
SYSVAR editSym              =  $9706
SYSVAR editDat              =  $9708
SYSVAR GY0		= $977F
SYSVAR GY1		= $9776
SYSVAR GY2		= $9777
SYSVAR GY3		= $9778
SYSVAR GY4		= $9779
SYSVAR GY5		= $977A
SYSVAR GY6		= $977B
SYSVAR GY7		= $977C
SYSVAR GY8		= $977D
SYSVAR GY9		= $977E
SYSVAR GX1		= $9780
SYSVAR GX2		= $9781
SYSVAR GX3		= $9782
SYSVAR GX4		= $9783
SYSVAR GX5		= $9784
SYSVAR GX6		= $9785
SYSVAR GU		= $978C
SYSVAR GV		= $978D
SYSVAR GW		= $978E
SYSVAR GR1		= $9786
SYSVAR GR2		= $9787
SYSVAR GR3		= $9788
SYSVAR GR4		= $9789
SYSVAR GR5		= $978A
SYSVAR GR6		= $978B
SYSVAR winTop               =  $97A5
SYSVAR winBtm               =  $97A6
SYSVAR winLeftEdge          =  $97A7
SYSVAR winLeft              =  $97A8
SYSVAR winAbove             =  $97AA
SYSVAR winRow               =  $97AC
SYSVAR winCol               =  $97AE
SYSVAR fmtDigits            =  $97B0
SYSVAR fmtString            =  $97B1
SYSVAR fmtConv              =  $97F2
SYSVAR fmtLeft              =  $9804
SYSVAR fmtIndex             =  $9806
SYSVAR fmtMatSym            =  $9808
SYSVAR fmtMatMem            =  $980A
SYSVAR EQS                  =  $980C
SYSVAR tSymPtr1             =  $9818
SYSVAR tSymPtr2             =  $981A
SYSVAR chkDelPtr3           =  $981C
SYSVAR chkDelPtr4           =  $981E
SYSVAR tempMem              =  $9820
SYSVAR fpBase               =  $9822
SYSVAR FPS                  =  $9824
SYSVAR OPBase               =  $9826
SYSVAR OPS                  =  $9828
SYSVAR pTempCnt             =  $982A
SYSVAR cleanTmp             =  $982C
SYSVAR pTemp                =  $982E
SYSVAR progPtr              =  $9830
SYSVAR newDataPtr           =  $9832
SYSVAR pagedCount           =  $9834
SYSVAR pagedPN              =  $9835
SYSVAR pagedGetPtr          =  $9836
SYSVAR pagedPutPtr          =  $9838
SYSVAR pagedBuf             =  $983A
SYSVAR appErr1              =  $984D
SYSVAR appErr2              =  $985A
SYSVAR flashByte1           =  $9867
SYSVAR flashByte2           =  $9868
SYSVAR freeArcBlock         =  $9869
SYSVAR arcPage              =  $986B
SYSVAR arcPtr               =  $986C
SYSVAR appRawKeyHandle      =  $9870
SYSVAR appBackUpScreen      =  $9872
SYSVAR customHeight         =  $9B72
SYSVAR localLanguage        =  $9B73
SYSVAR cursorHookPtr        =  $9B7C
SYSVAR rawKeyHookPtr        =  $9B84
SYSVAR getKeyHookPtr        =  $9B88
SYSVAR fontHookPtr          =  $9B9C
SYSVAR restartClr           =  $9BD0
SYSVAR localTokStr          =  $9D65
SYSVAR keyForStr            =  $9D76
SYSVAR keyToStrRam          =  $9D77
SYSVAR sedMonSp             =  $9D88
SYSVAR bpSave               =  $9D8A
SYSVAR userMem              =  $9D95
SYSVAR symTable             =  $FE66

//======================================================================
//		Language localization equates
//======================================================================

CONST LANG_NEUTRAL                       = $00
CONST LANG_DANISH                        = $06
CONST LANG_DUTCH                         = $13
CONST LANG_ENGLISH                       = $09
CONST LANG_FINNISH                       = $0b
CONST LANG_FRENCH                        = $0c
CONST LANG_GERMAN                        = $07
CONST LANG_HUNGARIAN                     = $0e
CONST LANG_ITALIAN                       = $10
CONST LANG_NORWEGIAN                     = $14
CONST LANG_POLISH                        = $15
CONST LANG_PORTUGUESE                    = $16
CONST LANG_SPANISH                       = $0a
CONST LANG_SWEDISH                       = $1d

CONST SUBLANG_NEUTRAL                    = $00   // language neutral
CONST SUBLANG_DUTCH                    =   $01   // Dutch
CONST SUBLANG_ENGLISH_US               =   $01   // English (USA)
CONST SUBLANG_FRENCH                   =   $01   // French
CONST SUBLANG_GERMAN                   =   $01   // German
CONST SUBLANG_ITALIAN                  =   $01   // Italian
CONST SUBLANG_NORWEGIAN_BOKMAL         =   $01   // Norwegian (Bokmal)
CONST SUBLANG_PORTUGUESE               =   $02   // Portuguese
CONST SUBLANG_SPANISH                  =   $01   // Spanish (Castilian)



//======================================================================
//           System and State Flags
//======================================================================


CONST trigFlags	=  0		//Trigonometry mode settings
CONST trigDeg 	=    2	// 1=degrees, 0=radians

CONST kbdFlags	=  0		//Keyboard scan
CONST kbdSCR		=    3	// 1=scan code ready
CONST kbdKeyPress	=    4	// 1=key has been pressed

CONST doneFlags	=  0		//display "Done"
CONST donePrgm	=    5	// 1=display "Done" after prgm

CONST ioDelFlag	=  0
CONST inDelete	=    0	//1 = DELETE SCREEN 

//----------------------------------------------------------------------
CONST editFlags	=  1
CONST editOpen	=    2	// 1=edit buffer is open

CONST monFlags	=  1		//monitor flags
CONST monAbandon	=    4	// 1=don't start any long process
				// in put away (#715)
//----------------------------------------------------------------------
CONST plotFlags	=  2		//plot generation flags
CONST plotTrace	=  0
CONST plotLoc 	=    1	// 0=bkup & display, 1=display only
CONST plotDisp	=    2	// 1=plot is in display, 0=text in display


CONST grfModeFlags	=  2		//graph mode settings
CONST grfFuncM	=    4	// 1=function graph
CONST grfPolarM	=    5	// 1=polar graph
CONST grfParamM	=    6	// 1=parametric graph
CONST grfRecurM       =    7        // 1=RECURSION graph

CONST graphFlags	=  3
CONST graphDraw	=    0	// 0=graph is valid, 1=redraw graph

CONST grfDBFlags	=  4
CONST grfDot		=    0	// 0=line, 1=dot
CONST grfSimul	=    1	// 0=sequential, 1=simultaneous
CONST grfGrid 	=    2	// 0=no grid, 1=grid
CONST grfPolar	=    3	// 0=rectangular, 1=polar coordinates
CONST grfNoCoord	=    4	// 0=display coordinates, 1=off
CONST grfNoAxis	=    5	// 0=axis, 1=no axis
CONST grfLabel	=    6	// 0=off, 1=axis label

CONST textFlags	=  5		//Text output flags
CONST textEraseBelow	=    1	// 1=erase line below small char
CONST textScrolled	=    2	// 1=screen scrolled
CONST textInverse	=    3	// 1=display inverse bit-map
CONST textInsMode	=    4	// 0=overstrike, 1=insert mode

CONST ParsFlag2	=  7		//PARSER flags
CONST numOP1		=    0	// 1=RESULT IN OP1, 0=NO RESULT

CONST newDispF        =  8		//Derivative mode flags
CONST preClrForMode   =    0	// 1=HELP BLINK ON MODE SCREEN

CONST apdFlags	=  8		//Automatic power-down
CONST apdAble 	=    2	// 1=APD enabled
CONST apdRunning	=    3	// 1=APD clock running


CONST web_err_mask    = $60

CONST onFlags 	=  9		//on key flags
CONST onRunning	=  3		// 1 = calculator is running
CONST onInterrupt	=    4	// 1=on key interrupt request

CONST statFlags	=  9		//statistics flags
CONST statsValid	=    6	// 1=stats are valid
CONST statANSDISP	=  7		// 1=display stat results


CONST fmtFlags	=  10		//numeric format flags
CONST fmtExponent	=    0	// 1=show exponent, 0=no exponent
CONST fmtEng		=    1	// 1=engineering notion, 0=scientific
CONST fmtHex		=    2	// 1=hexadecimal
CONST fmtOct		=    3	// 1=octal
CONST fmtBin		=    4	// 1=binary
//
CONST numMode         =  10
CONST fmtReal         =    5
CONST fmtRect         =    6
CONST fmtPolar        =    7

CONST realMode        =    5
CONST rectMode        =    6
CONST polarMode       =    7
//					//   if Hex and Oct both = 1
//					//   then Bin=0 means >Frac
//					//	 Bin=1 means >DMS
CONST fmtBaseMask     =  #00011100		// mask to base flags
CONST fmtBaseShift    =  2			// offset to base flags
//
//       CHECK IF THESE ARE USED BY NUMFORM,
//
//               =  6
//               =  7

CONST fmtOverride	=  11		//copy of fmtFlags with conversion override

CONST fmtEditFlags	=  12		//numeric editing flags
CONST fmtEdit 	=    0	// 1=format number for editing

CONST curFlags	=  12		//Cursor
CONST curAble 	=    2	// 1=cursor flash is enabled
CONST curOn		=    3	// 1=cursor is showing
CONST curLock 	=    4	// 1=cursor is locked off

CONST appFlags	=  13		//application flags
CONST appWantIntrpt	=    0		// 1=want ON key interrupts
CONST appTextSave	=    1		// 1=save characters in textShadow
CONST appAutoScroll	=    2		// 1=auto-scroll text on last line
CONST appMenus	=    3		// 1=process keys that bring up menus
					// 0=check Lock menu flag
CONST appLockMenus	=    4		// 1=ignore menu keys
					// 0=switch to home screen and bring up menu
CONST appCurGraphic	=    5		// 1=graphic cursor
CONST appCurWord	=    6		// 1=text cursor covers entire word
CONST appExit 	=    7		// 1=application handles [EXIT] key itself

//CONST appWantIntrptF	=	1<<appWantIntrpt
//CONST appTextSaveF	=	1<<appTextSave
//CONST appAutoScrollF	=	1<<appAutoScroll
//CONST appMenusF	=	1<<appMenus
//CONST appLockMenusF	=	1<<appLockMenus
//CONST appCurGraphicF	=	1<<appCurGraphic
//CONST appCurWordF	=	1<<appCurWord
//CONST appExitF	=	1<<appExit


CONST seqFlags        =  15              // Sequential Graph flags
CONST webMode         =    0             // 0 = NORMAL SEQ MODE, 1 = WEB MODE
CONST webVert         =    1             //
CONST sequv           =    2             // U vs V
CONST seqvw           =    3             // V vs W
CONST sequw           =    4             // U vs W


CONST promptFlags	=  17		//prompt line flags
CONST promptEdit	=    0	// 1=editing in prompt buffer

CONST indicFlags	=  18		//Indicator flags
CONST indicRun	=    0	// 1=run indicator ON
CONST indicInUse	=    1	// indicator save area in use=1, free=0
CONST indicOnly	=    2	// interrupt handler only checks run indicator

CONST shiftFlags	=  18		//[2nd] and [ALPHA] flags
CONST shift2nd	=    3	// 1=[2nd] has been pressed
CONST shiftAlpha	=    4	// 1=[ALPHA] has been pressed
CONST shiftLwrAlph	=    5	// 1=lower case, 0=upper case
CONST shiftALock	=    6	// 1=alpha lock has been pressed
CONST shiftKeepAlph	=    7	// 1=cannot cancel alpha shift


CONST tblFlags        =  19		//table flags.
CONST autoFill        =    4	// 1=prompt, 0=fillAuto
CONST autoCalc        =    5	// 1=prompt, 0=CalcAuto
CONST reTable         =    6	// 0=table is ok, 1=must recompute table.

CONST sGrFlags	=  20
CONST grfSplit        =    0	// 1=Split Graph, 0=Normal
CONST vertSplit       =    1	// 1=Vertical (left-right) Split
CONST grfSChanged     =    2	// 1=Graph just changed Split <-> normal
CONST grfSplitOverride =   3	// 1 = ignore graph split flag if set
CONST write_on_graph  =    4	// 1 = TEXT OR = WRITING TO GRAPH SCREEN
CONST g_style_active  =    5	// 1 = GRAPH STYLES ARE ENABLED, USE THEM
CONST cmp_mod_box     =    6	// 1 = DOING MOD BOX PLOT COMPUTATION
CONST textWrite       =    7	// 1 = Small font writes to buffer
			// 0 = Small font writes to display
//

CONST newIndicFlags   =  21
CONST extraIndic      =    0
CONST saIndic         =    1

CONST newFlags2	    =  22
CONST noRestores	    =  5

CONST smartFlags      =  23
//
//----------------------------------------------------------------------
// Note: Fix these Equates if smartFlags are moved                            
//----------------------------------------------------------------------
//
CONST smarter_mask    =  3
CONST smarter_test    =  1
CONST smartGraph      =  0
CONST smartGraph_inv  =  1                                                 

CONST more_Flags	= 26

CONST No_Del_Stat	= 2
//----------------------------------------------------------------------
//           Available for ASM programming
//----------------------------------------------------------------------

CONST asm_Flag1       =  33          // ASM CODING
CONST asm_Flag2       =  34          // ASM CODING
CONST asm_Flag3       =  35          // ASM CODING

//----------------------------------------------------------------------
//
CONST getSendFlg	=  36
CONST comFailed	=  1	      // 1 = Get/Send Communication Failed
//
CONST appLwrCaseFlag  =  36
CONST lwrCaseActive   =  3
//
CONST apiFlg3		=  42 
//
CONST apiFlg4		=  43
CONST fullScrnDraw	=    2	// DRAW INTO LAST ROW/COL OF SCREEN

CONST groupFlags	=  38
CONST inGroup		=  1		//1 = IN GROUP CONTEXT


CONST xapFlag0        =  46      // external app flags
CONST xapFlag1        =  47
CONST xapFlag2        =  48
CONST xapFlag3        =  49

CONST fontFlags	=  50
CONST fracDrawLFont	=    2
CONST fracTallLFont	=    3
CONST customFont	=    7  

CONST plotFlag3	=  60  
CONST bufferOnly	=    0
CONST useFastCirc	=    4

CONST DBKeyFlags      =     61              //dbus keyboard flags
//Modifier         =     0..3          //Reserved for LSNibble of Modifiers
CONST repeatMost        =     4             //set if repeat normal keys
CONST haveDBKey         =     5             //set if have DBus key
CONST keyDefaultsF      =     6             //set if don't use system default keys.
CONST HWLinkErrF        =     7             //have a SE Hardware Link error.

//
CONST varTypeMask	=  $1F
CONST varGraphRef	=    6

//
//======================================================================
//           Character Font equates  
//======================================================================
//
// Large font equates
//
CONST LrecurN         =    $001
CONST LrecurU 	= $002
CONST LrecurV 	= $003
CONST LrecurW		= $004
CONST Lconvert	= $005
CONST LsqUp		= $006
CONST LsqDown		= $007
CONST Lintegral	= $008
CONST Lcross		= $009
CONST LboxIcon 	=    $00A
CONST LcrossIcon 	=    $00B
CONST LdotIcon 	=    $00C
CONST LsubT   	=    $00D		//small capital T for parametric mode.
CONST LcubeR  	=    $00E		//slightly different 3 for cubed root.
CONST LhexF		= $00F
CONST Lroot		= $010
CONST Linverse	= $011
CONST Lsquare		= $012
CONST Langle		= $013
CONST Ldegree		= $014
CONST Lradian		= $015
CONST Ltranspose	= $016
CONST LLE		= $017
CONST LNE		= $018
CONST LGE		= $019
CONST Lneg		= $01A
CONST Lexponent	= $01B
CONST Lstore		= $01C
CONST Lten		= $01D
CONST LupArrow	= $01E
CONST LdownArrow	= $01F
CONST Lspace		= $020
CONST Lexclam		= $021
CONST Lquote		= $022
CONST Lpound		= $023
CONST Lfourth		= $024
CONST Lpercent	= $025
CONST Lampersand	= $026
CONST Lapostrophe	= $027
CONST LlParen		= $028
CONST LrParen		= $029
CONST Lasterisk	= $02A
CONST LplusSign	= $02B
CONST Lcomma		= $02C
CONST Ldash		= $02D
CONST Lperiod		= $02E
CONST Lslash		= $02F
CONST L0		= $030
CONST L1		= $031
CONST L2		= $032
CONST L3		= $033
CONST L4		= $034
CONST L5		= $035
CONST L6		= $036
CONST L7		= $037
CONST L8		= $038
CONST L9		= $039
CONST Lcolon		= $03A
CONST Lsemicolon	= $03B
CONST LLT		= $03C
CONST LEQ		= $03D
CONST LGT		= $03E
CONST Lquestion	= $03F
CONST LatSign		= $040
CONST LcapA	= $04
CONST LcapB	= $04
CONST LcapC	= $043
CONST LcapD	= $044
CONST LcapE	= $045
CONST LcapF	= $046
CONST LcapG	= $047
CONST LcapH	= $048
CONST LcapI	= $049
CONST LcapJ	= $04A
CONST LcapK	= $04B
CONST LcapL	= $04C
CONST LcapM	= $04D
CONST LcapN	= $04E
CONST LcapO	= $04F
CONST LcapP	= $050
CONST LcapQ	= $051
CONST LcapR	= $052
CONST LcapS	= $053
CONST LcapT	= $054
CONST LcapU	= $055
CONST LcapV	= $056
CONST LcapW	= $057
CONST LcapX	= $058
CONST LcapY	= $059
CONST LcapZ	= $05A
CONST Ltheta  = $05B
CONST Lbackslash	= $05C
CONST LrBrack		= $05D
CONST Lcaret		= $05E
CONST Lunderscore	= $05F
CONST Lbackquote	= $060
CONST La	= $061
CONST Lb	= $062
CONST Lc	= $063
CONST Ld	= $064
CONST Le	= $065
CONST Lf	= $066
CONST Lg	= $067
CONST Lh	= $068
CONST Li	= $069
CONST Lj	= $06A
CONST Lk	= $06B
CONST Ll	= $06C
CONST Lm	= $06D
CONST Ln	= $06E
CONST Lo	= $06F
CONST Lp	= $070
CONST Lq	= $071
CONST Lr	= $072
CONST Ls	= $073
CONST Lt	= $074
CONST Lu	= $075
CONST Lv	= $076
CONST Lw	= $077
CONST Lx	= $078
CONST Ly	= $079
CONST Lz	= $07A
CONST LlBrace	= $07B
CONST Lbar	= $07C
CONST LrBrace	= $07D
CONST Ltilde	= $07E
CONST LinvEQ	= $07F
CONST Lsub0	= $080
CONST Lsub1	= $081
CONST Lsub2	= $082
CONST Lsub3	= $083
CONST Lsub4	= $084
CONST Lsub5	= $085
CONST Lsub6	= $086
CONST Lsub7	= $087
CONST Lsub8	= $088
CONST Lsub9	= $089
CONST LcapAAcute	= $08A
CONST LcapAGrave	= $08B
CONST LcapACaret	= $08C
CONST LcapADier	= $08D
CONST LaAcute		= $08E
CONST LaGrave		= $08F
CONST LaCaret		= $090
CONST LaDier		= $091
CONST LcapEAcute	= $092
CONST LcapEGrave	= $093
CONST LcapECaret	= $094
CONST LcapEDier	= $095
CONST LeAcute		= $096
CONST LeGrave		= $097
CONST LeCaret		= $098
CONST LeDier		= $099
CONST LcapIAcute	= $09A
CONST LcapIGrave	= $09B
CONST LcapICaret	= $09C
CONST LcapIDier	= $09D
CONST LiAcute		= $09E
CONST LiGrave		= $09F
CONST LiCaret		= $0A0
CONST LiDier		= $0A1
CONST LcapOAcute	= $0A2
CONST LcapOGrave	= $0A3
CONST LcapOCaret	= $0A4
CONST LcapODier	= $0A5
CONST LoAcute		= $0A6
CONST LoGrave		= $0A7
CONST LoCaret		= $0A8
CONST LoDier		= $0A9
CONST LcapUAcute	= $0AA
CONST LcapUGrave	= $0AB
CONST LcapUCaret	= $0AC
CONST LcapUDier	= $0AD
CONST LuAcute		= $0AE
CONST LuGrave		= $0AF
CONST LuCaret		= $0B0
CONST LuDier		= $0B1
CONST LcapCCed	= $0B2
CONST LcCed		= $0B3
CONST LcapNTilde	= $0B4
CONST LnTilde		= $0B5
CONST Laccent		= $0B6
CONST Lgrave		= $0B7
CONST Ldieresis	= $0B8
CONST LquesDown	= $0B9
CONST LexclamDown	= $0BA
CONST Lalpha		= $0BB
CONST Lbeta		= $0BC
CONST Lgamma		= $0BD
CONST LcapDelta	= $0BE
CONST Ldelta		= $0BF
CONST Lepsilon	= $0C0
CONST LlBrack 	= $0C1
CONST Llambda		= $0C2
CONST Lmu		= $0C3
CONST Lpi		= $0C4
CONST Lrho		= $0C5
CONST LcapSigma	= $0C6
CONST Lsigma		= $0C7
CONST Ltau		= $0C8
CONST Lphi		= $0C9
CONST LcapOmega	= $0CA
CONST LxMean		= $0CB
CONST LyMean		= $0CC
CONST LsupX		= $0CD
CONST Lellipsis	= $0CE
CONST Lleft		= $0CF
CONST Lblock		= $0D0
CONST Lper		= $0D1
CONST Lhyphen		= $0D2
CONST Larea		= $0D3
CONST Ltemp		= $0D4
CONST Lcube		= $0D5
CONST Lenter		= $0D6
CONST LimagI		= $0D7
CONST Lphat		= $0D8
CONST Lchi		= $0D9
CONST LstatF		= $0DA
CONST Llne		= $0DB
CONST LlistL		= $0DC
CONST LfinanN 	= $0DD
CONST L2_r_paren 	= $0DE
CONST LblockArrow     = $0DF
CONST LcurO   	= $0E0
CONST LcurO2  	= $0E1
CONST LcurOcapA       = $0E2
CONST LcurOa  	= $0E3
CONST LcurI   	= $0E4
CONST LcurI2  	= $0E5
CONST LcurIcapA       = $0E6
CONST LcurIa  	= $0E7
CONST LGline          = $0E8    // = 0
CONST LGthick         = $0E9    // = 1
CONST LGabove         = $0EA    // = 2
CONST LGbelow         = $0EB    // = 3
CONST LGpath          = $0EC    // = 4
CONST LGanimate       =     $0ED    // = 5
CONST LGdot           =     $0EE    // = 6
CONST LUpBlk          =     $0EF    //Up arrow and Block in solver
CONST LDnBlk          =     $0F0    //Down arrow and Block in solver
CONST LcurFull        =     $0F1    //note: must be last char (PutMap checks)

//Small font equates
//
CONST SrecurN         =    $001
CONST SrecurU		= $002
CONST SrecurV		= $003
CONST SrecurW		= $004
CONST Sconvert	= $005
CONST SFourSpaces 	= $006
CONST SsqDown		= $007
CONST Sintegral	= $008
CONST Scross		= $009
CONST SboxIcon 	= $00A
CONST ScrossIcon 	= $00B
CONST SdotIcon 	= $00C
CONST SsubT   	= $00D
CONST ScubeR  	= $00E
CONST ShexF		= $00F
CONST Sroot		= $010
CONST Sinverse	= $011
CONST Ssquare		= $012
CONST Sangle		= $013
CONST Sdegree		= $014
CONST Sradian		= $015
CONST Stranspose	= $016
CONST SLE		= $017
CONST SNE		= $018
CONST SGE		= $019
CONST Sneg		= $01A
CONST Sexponent	= $01B
CONST Sstore		= $01C
CONST Sten		= $01D
CONST SupArrow	= $01E
CONST SdownArrow	= $01F
CONST Sspace		= $020
CONST Sexclam		= $021
CONST Squote		= $022
CONST Spound		= $023
CONST Sdollar		= $024
CONST Spercent	= $025
CONST Sampersand	= $026
CONST Sapostrophe	= $027
CONST SlParen		= $028
CONST SrParen		= $029
CONST Sasterisk	= $02A
CONST SplusSign	= $02B
CONST Scomma		= $02C
CONST Sdash		= $02D
CONST Speriod		= $02E
CONST Sslash		= $02F
CONST S0		= $030
CONST S1		= $031
CONST S2		= $032
CONST S3		= $033
CONST S4		= $034
CONST S5		= $035
CONST S6		= $036
CONST S7		= $037
CONST S8		= $038
CONST S9		= $039
CONST Scolon		= $03A
CONST Ssemicolon	= $03B
CONST SLT		= $03C
CONST SEQ		= $03D
CONST SGT		= $03E
CONST Squestion	= $03F
CONST SatSign		= $040
CONST ScapA		= $041
CONST ScapB		= $042
CONST ScapC		= $043
CONST ScapD		= $044
CONST ScapE		= $045
CONST ScapF		= $046
CONST ScapG		= $047
CONST ScapH		= $048
CONST ScapI		= $049
CONST ScapJ		= $04A
CONST ScapK		= $04B
CONST ScapL		= $04C
CONST ScapM		= $04D
CONST ScapN		= $04E
CONST ScapO		= $04F
CONST ScapP		= $050
CONST ScapQ		= $051
CONST ScapR		= $052
CONST ScapS		= $053
CONST ScapT		= $054
CONST ScapU		= $055
CONST ScapV		= $056
CONST ScapW		= $057
CONST ScapX		= $058
CONST ScapY		= $059
CONST ScapZ		= $05A
CONST Stheta  	= $05B
CONST Sbackslash	= $05C
CONST SrBrack		= $05D
CONST Scaret		= $05E
CONST Sunderscore	= $05F
CONST Sbackquote	= $060
CONST SmallA		= $061
CONST SmallB		= $062
CONST SmallC		= $063
CONST SmallD		= $064
CONST SmallE		= $065
CONST SmallF		= $066
CONST SmallG		= $067
CONST SmallH		= $068
CONST SmallI		= $069
CONST SmallJ		= $06A
CONST SmallK		= $06B
CONST SmallL		= $06C
CONST SmallM		= $06D
CONST SmallN		= $06E
CONST SmallO		= $06F
CONST SmallP		= $070
CONST SmallQ		= $071
CONST SmallR		= $072
CONST SmallS		= $073
CONST SmallT		= $074 
CONST SmallU		= $075
CONST SmallV		= $076
CONST SmallW		= $077
CONST SmallX		= $078
CONST SmallY		= $079
CONST SmallZ		= $07A
CONST SlBrace		= $07B
CONST Sbar		= $07C
CONST SrBrace		= $07D
CONST Stilde		= $07E
CONST SinvEQ		= $07F
CONST Ssub0		= $080
CONST Ssub1		= $081
CONST Ssub2		= $082
CONST Ssub3		= $083
CONST Ssub4		= $084
CONST Ssub5		= $085
CONST Ssub6		= $086
CONST Ssub7		= $087
CONST Ssub8		= $088
CONST Ssub9		= $089
CONST ScapAAcute	= $08A
CONST ScapAGrave	= $08B
CONST ScapACaret	= $08C
CONST ScapADier	= $08D
CONST SaAcute		= $08E
CONST SaGrave		= $08F
CONST SaCaret		= $090
CONST SaDier		= $091
CONST ScapEGrave	= $092
CONST ScapEAcute	= $093
CONST ScapECaret	= $094
CONST ScapEDier	= $095
CONST SeAcute		= $096
CONST SeGrave		= $097
CONST SeCaret		= $098
CONST SeDier		= $099
CONST ScapIAcute	= $09A
CONST ScapIGrave	= $09B
CONST ScapICaret	= $09C
CONST ScapIDier	= $09D
CONST SiAcute		= $09E
CONST SiGrave		= $09F
CONST SiCaret		= $0A0
CONST SiDier		= $0A1
CONST ScapOAcute	= $0A2
CONST ScapOGrave	= $0A3
CONST ScapOCaret	= $0A4
CONST ScapODier	= $0A5
CONST SoAcute		= $0A6
CONST SoGrave		= $0A7
CONST SoCaret		= $0A8
CONST SoDier		= $0A9
CONST ScapUAcute	= $0AA
CONST ScapUGrave	= $0AB
CONST ScapUCaret	= $0AC
CONST ScapUDier	= $0AD
CONST SuAcute		= $0AE
CONST SuGrave		= $0AF
CONST SuCaret		= $0B0
CONST SuDier		= $0B1
CONST ScapCCed	= $0B2
CONST ScCed		= $0B3
CONST ScapNTilde	= $0B4
CONST SnTilde		= $0B5
CONST Saccent		= $0B6
CONST Sgrave		= $0B7
CONST Sdieresis	= $0B8
CONST SquesDown	= $0B9
CONST SexclamDown	= $0BA
CONST Salpha		= $0BB
CONST Sbeta		= $0BC
CONST Sgamma		= $0BD
CONST ScapDelta	= $0BE
CONST Sdelta		= $0BF
CONST Sepsilon	= $0C0
CONST SlBrack 	= $0C1
CONST Slambda		= $0C2
CONST Smu		= $0C3
CONST Spi		= $0C4
CONST Srho		= $0C5
CONST ScapSigma	= $0C6
CONST Ssigma		= $0C7
CONST Stau		= $0C8
CONST Sphi		= $0C9
CONST ScapOmega	= $0CA
CONST SxMean		= $0CB
CONST SyMean		= $0CC
CONST SsupX		= $0CD
CONST Sellipsis	= $0CE
CONST Sleft		= $0CF
CONST Sblock		= $0D0
CONST Sper		= $0D1
CONST Shyphen		= $0D2
CONST Sarea		= $0D3
CONST Stemp		= $0D4
CONST Scube		= $0D5
CONST Senter		= $0D6
CONST SimagI		= $0D7
CONST Sphat		= $0D8
CONST Schi		= $0D9
CONST SstatF  	= $0DA
CONST Slne		= $0DB
CONST SlistL		= $0DC
CONST SfinanN 	= $0DD
CONST S2_r_paren 	= $0DE
CONST SnarrowCapE     = $0DF
CONST SListLock 	= $0E0
CONST Sscatter1 	=	$0E1
CONST Sscatter2 	=	$0E2
CONST Sxyline1  	=	$0E3
CONST Sxyline2  	= $0E4
CONST Sboxplot1 	= $0E5
CONST Sboxplot2 	= $0E6
CONST Shist1    	= $0E7
CONST Shist2    	= $0E8
CONST SmodBox1  	= $0E9
CONST SmodBox2  	= $0EA
CONST Snormal1  	= $0EB
CONST Snormal2  	= $0EC
//
//======================================================================
//           Keypress Equates
//======================================================================
//           Keyboard key names
//
//
CONST kRight          =      $001
CONST kLeft           =      $002
CONST kUp             =      $003
CONST kDown           =      $004
CONST kEnter          =      $005
CONST kAlphaEnter     =      $006
CONST kAlphaUp        =      $007
CONST kAlphaDown      =      $008
CONST kClear          =      $009
CONST kDel            =      $00A
CONST kIns            =      $00B
CONST kRecall         =      $00C
CONST kLastEnt        =      $00D
CONST kBOL            =      $00E
CONST kEOL            =      $00F
//kSelAll         =     $010
CONST kUnselAll       =      $011
CONST kLtoTI82        =      $012
CONST kBackup         =      $013
CONST kRecieve        =      $014
CONST kLnkQuit        =      $015
CONST kTrans          =      $016
CONST kRename         =      $017
CONST kOverw          =      $018
CONST kOmit           =      $019
CONST kCont           =      $01A
CONST kSendID         =      $01B
CONST kSendSW         =      $01C
CONST kYes            =      $01D
CONST kNoWay          =      $01E
CONST kvSendType      =      $01F
CONST kOverWAll       =      $020
//kNo             =     $025
CONST kKReset         =      $026
CONST kApp            =      $027
//
CONST kDoug           =      $028
CONST kListflag       =      $029
CONST menuStart       =      $02B
//CONST kAreYouSure     =     $02B
CONST kAppsMenu       =      $02C
CONST kPrgm           =      $02D
CONST kZoom           =      $02E
CONST kDraw           =      $02F
CONST kSPlot          =      $030
CONST kStat           =      $031
CONST kMath           =      $032
CONST kTest           =      $033
CONST kChar           =      $034
CONST kVars           =      $035
CONST kMem            =      $036
CONST kMatrix         =      $037
CONST kDist           =      $038
CONST kAngle          =      $039
CONST kList           =      $03A
CONST kCalc           =      $03B
CONST kFin            =      $03C
//
CONST menuEnd         =       $03C
//
CONST kCatalog        =      $03E
CONST kInputDone      =      $03F
CONST kOff            =      $03F
//
CONST kQuit           =      $040
CONST appStart        =       $040

//
CONST kLinkIO         =      $041
CONST kMatrixEd       =      $042
CONST kStatEd         =      $043
CONST kGraph          =      $044
CONST kMode           =      $045
CONST kPrgmEd         =      $046        // PROGRAM EDIT
CONST kPrgmCr         =      $047        // PROGRAM CREATE
CONST kWindow         =      $048        // RANGE EDITOR
CONST kYequ           =       $049        // EQUATION EDITOR
CONST kTable          =       $04A        // TABLE EDITOR
CONST kTblSet         =       $04B        // TABLE SET
CONST kChkRAM         =       $04C        // CHECK RAM
CONST kDelMem         =       $04D        // DELETE MEM
CONST kResetMem       =       $04E        // RESET MEM
CONST kResetDef	=	$04F        // RESET DEFAULT
CONST kPrgmInput      =       $050        // PROGRAM INPUT
CONST kZFactEd        =       $051        // ZOOM FACTOR EDITOR
CONST kError          =       $052        // ERROR
CONST kSolveTVM       =       $053        // TVM SOLVER
CONST kSolveRoot	=	$054        // SOLVE EDITOR
CONST kStatP          =       $055        // stat plot
CONST kInfStat 	=	$056	      // Inferential Statistic
CONST kFormat         =       $057        // FORMAT
CONST kExtApps        =       $058        // External Applications.     NEW
CONST kNewApps        =       $059        // New Apps for Cerberus.
//
CONST append          =       $059
//
CONST echoStart1      =      $05A
//
CONST kTrace          =      $05A
CONST kZFit           =      $05B
CONST kZIn            =      $05C
CONST kZOut           =      $05D
CONST kZPrev          =      $05E
CONST kBox            =      $05F
CONST kDecml          =      $060
CONST kSetZm          =      $061
CONST kSquar          =      $062
CONST kStd            =      $063
CONST kTrig           =      $064
CONST kUsrZm          =      $065
CONST kZSto           =      $066
CONST kZInt           =      $067
CONST kZStat          =      $068
//
CONST echoStart2      =      $069
//
CONST kSelect         =      $069
CONST kCircl          =      $06A
CONST kClDrw          =      $06B
CONST kLine           =      $06C
CONST kPen            =      $06D
CONST kPtChg          =      $06E
CONST kPtOff          =      $06F
CONST kPtOn           =      $070
CONST kVert           =      $071
CONST kHoriz          =      $072
CONST kText           =      $073
CONST kTanLn          =      $074
//
CONST kEval           =      $075
CONST kInters         =      $076
CONST kDYDX           =      $077
CONST kFnIntg         =      $078
CONST kRootG          =      $079
CONST kDYDT           =      $07A
CONST kDXDT           =      $07B
CONST kDRDo           =      $07C
CONST kGFMin          =      $07D
CONST kGFMax          =      $07E
//
//
CONST EchoStart       =      $07F
//
CONST kListName       =      $07F
CONST kAdd            =      $080
CONST kSub            =      $081
CONST kMul            =      $082
CONST kDiv            =      $083
CONST kExpon          =      $084
CONST kLParen         =      $085
CONST kRParen         =      $086
CONST kLBrack         =      $087
CONST kRBrack         =      $088
CONST kShade          =      $089
CONST kStore          =      $08A
CONST kComma          =      $08B
CONST kChs            =      $08C
CONST kDecPnt         =      $08D
CONST k0              =      $08E
CONST k1              =      $08F
CONST k2              =      $090
CONST k3              =      $091
CONST k4              =      $092
CONST k5              =      $093
CONST k6              =      $094
CONST k7              =      $095
CONST k8              =      $096
CONST k9              =      $097
CONST kEE             =      $098
CONST kSpace          =      $099
CONST kCapA           =      $09A
CONST kCapB           =      $09B
CONST kCapC           =      $09C
CONST kCapD           =      $09D
CONST kCapE           =      $09E
CONST kCapF           =      $09F
CONST kCapG           =      $0A0
CONST kCapH           =      $0A1
CONST kCapI           =      $0A2
CONST kCapJ           =      $0A3
CONST kCapK           =      $0A4
CONST kCapL           =      $0A5
CONST kCapM           =      $0A6
CONST kCapN           =      $0A7
CONST kCapO           =      $0A8
CONST kCapP           =      $0A9
CONST kCapQ           =      $0AA
CONST kCapR           =      $0AB
CONST kCapS           =      $0AC
CONST kCapT           =      $0AD
CONST kCapU           =      $0AE
CONST kCapV           =      $0AF
CONST kCapW           =      $0B0
CONST kCapX           =      $0B1
CONST kCapY           =      $0B2
CONST kCapZ           =      $0B3
CONST kVarx           =      $0B4
CONST kPi             =      $0B5
CONST kInv            =      $0B6
CONST kSin            =      $0B7
CONST kASin           =      $0B8
CONST kCos            =      $0B9
CONST kACos           =      $0BA
CONST kTan            =      $0BB
CONST kATan           =      $0BC
CONST kSquare         =      $0BD
CONST kSqrt           =      $0BE
CONST kLn             =      $0BF
CONST kExp            =      $0C0
CONST kLog            =      $0C1
CONST kALog           =      $0C2
CONST kToABC          =      $0C3
//
CONST kClrTbl         =      $0C4
//
CONST kAns            =      $0C5
CONST kColon          =      $0C6
//
CONST kNDeriv         =      $0C7
CONST kFnInt          =      $0C8
CONST kRoot           =      $0C9
//
CONST kQuest          =      $0CA
CONST kQuote          =      $0CB
CONST kTheta          =      $0CC
CONST kIf             =      $0CD
CONST kThen           =      $0CE
CONST kElse           =      $0CF
CONST kFor            =      $0D0
CONST kWhile          =      $0D1
CONST kRepeat         =      $0D2
CONST kEnd            =      $0D3
CONST kPause          =      $0D4
CONST kLbl            =      $0D5
CONST kGoto           =      $0D6
CONST kISG            =      $0D7
CONST kDSL            =      $0D8
CONST kMenu           =      $0D9
CONST kExec           =      $0DA
CONST kReturn         =      $0DB
CONST kStop           =      $0DC
CONST kInput          =      $0DD
CONST kPrompt         =      $0DE
CONST kDisp           =      $0DF
CONST kDispG          =      $0E0
CONST kDispT          =      $0E1
CONST kOutput         =      $0E2
CONST kGetKey         =      $0E3
CONST kClrHome        =      $0E4
CONST kPrtScr         =      $0E5
CONST kSinH           =      $0E6
CONST kCosH           =      $0E7
CONST kTanH           =      $0E8
CONST kASinH          =      $0E9
CONST kACosH          =      $0EA
CONST kATanH          =      $0EB
CONST kLBrace         =      $0EC
CONST kRBrace         =      $0ED
CONST kI              =      $0EE
CONST kCONSTeA        =      $0EF
CONST kPlot3          =      $0F0
CONST kFMin           =      $0F1
CONST kFMax           =      $0F2
CONST kL1A            =      $0F3
CONST kL2A            =      $0F4
CONST kL3A            =      $0F5
CONST kL4A            =      $0F6
CONST kL5A            =      $0F7
CONST kL6A            =      $0F8
CONST kunA            =      $0F9
CONST kvnA            =      $0FA
CONST kwnA            =      $0FB
//
//======================================================================
//       THIS KEY MEANS THAT IT IS A 2 BYTE KEYCODE
//       THERE ARE 2 OF THESE KEYS// BE CAREFUL WITH USAGE
//======================================================================
//
CONST kExtendEcho2    =      $0FC
//
//======================================================================//
//       THIS KEY MEANS THAT THE KEY PRESS IS ONE THAT ECHOS
//       INTO A BUFFER, AND IT IS A 2 BYTE KEY CODE, GO LOOK AT
//       (EXTECHO) FOR THE KEY VALUE 
//======================================================================
//
CONST kExtendEcho     =      $0FE
//

CONST kE1BT           =       0

CONST kDrawInv        =       0
CONST kDrawF          =       1
CONST kPixelOn        =       2
CONST kPixelOff       =       3
CONST kPxlTest        =       4
CONST kRCGDB          =       5
CONST kRCPic          =       6
CONST kSTGDB          =       7
CONST kSTPic          =       8
CONST kAbs            =       9
CONST kTEqu           =       10    // ==
CONST kTNoteQ         =       11    // <>
CONST kTGT            =       12    // >
CONST kTGTE           =       13    // > =
CONST kTLT            =       14    // <
CONST kTLTE           =       15    // < =

CONST kAnd            =       16
CONST kOr             =       17
CONST kXor            =       18
CONST kNot            =       19

CONST kLR1            =       20

CONST kXRoot          =       21
CONST kCube           =       22
CONST kCbRt           =       23    // Cube ROOT
CONST kToDec          =       24
//
CONST kCubicR         =       25
CONST kQuartR         =       26
//
CONST kPlot1          =       27
CONST kPlot2          =       28
//

CONST kRound          =       29
CONST kIPart          =       30
CONST kFPart          =       31
CONST kInt            =       32

CONST kRand           =       33
CONST kNPR            =       34
CONST kNCR            =       35
CONST kXFactorial     =       36

CONST kRad            =       37
CONST kDegr           =       38    // DEGREES CONV
CONST kAPost          =       39
CONST kToDMS          =       40
CONST kRToPo          =       41    // R
CONST kRToPr          =       42
CONST kPToRx          =       43
CONST kPToRy          =       44

CONST kRowSwap        =       45
CONST kRowPlus        =       46
CONST kTimRow         =       47
CONST kTRowP          =       48

CONST kSortA          =       49
CONST kSortD          =       50
CONST kSeq            =       51

CONST kMin            =       52
CONST kMax            =       53
CONST kMean           =       54
CONST kMedian         =       55
CONST kSum            =       56
CONST kProd           =       57

CONST kDet            =       58
CONST kTransp         =       59
CONST kDim            =       60
CONST kFill           =       61
CONST kIdent          =       62
CONST kRandm          =       63
CONST kAug            =       64

CONST kOneVar         =       65
CONST kTwoVar         =       66
CONST kLR             =       67
CONST kLRExp          =       68
CONST kLRLn           =       69
CONST kLRPwr          =       70
CONST kMedMed         =       71
CONST kQuad           =       72
CONST kClrLst         =       73
CONST kHist           =       74
CONST kxyLine         =       75
CONST kScatter        =       76

CONST kmRad           =       77
CONST kmDeg           =       78
CONST kmNormF         =       79
CONST kmSci           =       80
CONST kmEng           =       81
CONST kmFloat         =       82

CONST kFix            =       83
CONST kSplitOn        =       84
CONST kFullScreen     =       85
CONST kStndrd         =       86
CONST kParam          =       87
CONST kPolar          =       88
CONST kSeqG           =       89
CONST kAFillOn        =       90
CONST kAFillOff       =       91
CONST kACalcOn        =       92
CONST kACalcOff       =       93
CONST kFNOn           =       94
CONST kFNOff          =       95

CONST kPlotsOn        =       96
CONST kPlotsOff       =       97

CONST kPixelChg       =       98

CONST kSendMBL        =       99
CONST kRecvMBL        =       100

CONST kBoxPlot        =       101
CONST kBoxIcon        =       102
CONST kCrossIcon      =       103
CONST kDotIcon        =       104

CONST kE2BT           =       105

CONST kSeqential      =       105
CONST kSimulG         =       106
CONST kPolarG         =       107
CONST kRectG          =       108
CONST kCoordOn        =       109
CONST kCoordOff       =       110
CONST kDrawLine       =       111
CONST kDrawDot        =       112
CONST kAxisOn         =       113
CONST kAxisOff        =       114
CONST kGridOn         =       115
CONST kGridOff        =       116
CONST kLblOn          =       117
CONST kLblOff         =       118

CONST kL1             =       119
CONST kL2             =       120
CONST kL3             =       121
CONST kL4             =       122
CONST kL5             =       123
CONST kL6             =       124

//
//======================================================================
//           These keys are layed on top of existing keys to
//           enable localization in the inferential stats editor
//======================================================================
//
CONST kinfData        =       119
CONST kinfStats       =       120
CONST kinfYes         =       121
CONST kinfNo          =       122
CONST kinfCalc        =       123
CONST kinfDraw        =       124
CONST kinfAlt1ne      =       125
CONST kinfAlt1lt      =       126
CONST kinfAlt1gt      =       127
CONST kinfAlt2ne      =       128
CONST kinfAlt2lt      =       129
CONST kinfAlt2gt      =       130
CONST kinfAlt3ne      =       131
CONST kinfAlt3lt      =       132
CONST kinfAlt3gt      =       133
CONST kinfAlt4ne      =       134
CONST kinfAlt4lt      =       135
CONST kinfAlt4gt      =       136
CONST kinfAlt5ne      =       137
CONST kinfAlt5lt      =       138
CONST kinfAlt5gt      =       139
CONST kinfAlt6ne      =       140
CONST kinfAlt6lt      =       141
CONST kinfAlt6gt      =       142
//
//
CONST kMatA           =       125
CONST kMatB           =       126
CONST kMatC           =       127
CONST kMatD           =       128
CONST kMatE           =       129

CONST kXmin           =       130
CONST kXmax           =       131
CONST kXscl           =       132
CONST kYmin           =       133
CONST kYmax           =       134
CONST kYscl           =       135
CONST kTmin           =       136
CONST kTmax           =       137
CONST kTStep          =       138
CONST kOmin           =       139
CONST kOmax           =       140
CONST kOStep          =       141
CONST ku0             =       142
CONST kv0             =       143
CONST knMin           =       144
CONST knMax           =       145
CONST kDeltaY         =       146
CONST kDeltaX         =       147

CONST kZXmin          =       148
CONST kZXmax          =       149
CONST kZXscl          =       150
CONST kZYmin          =       151
CONST kZYmax          =       152
CONST kZYscl          =       153
CONST kZTmin          =       154
CONST kZTmax          =       155
CONST kZTStep         =       156
CONST kZOmin          =       157
CONST kZOmax          =       158
CONST kZOStep         =       159
CONST kZu0            =       160
CONST kZv0            =       161
CONST kZnMin          =       162
CONST kZnMax          =       163

CONST kDelLast        =       164
CONST kSinReg         =       165
CONST kConstE         =       166

CONST kPic1           =       167
CONST kPic2           =       168
CONST kPic3           =       169

CONST kDelVar         =       170
CONST kGetCalc        =       171
CONST kRealM          =       172
CONST kPolarM         =       173
CONST kRectM          =       174
CONST kuv             =       175    // U vs V
CONST kvw             =       176    // V vs W
CONST kuw             =       177    // U vs W
CONST kFinPMTend      =       178
CONST kFinPMTbeg      =       179
//
CONST kGraphStyle     =       180
//
CONST kExprOn         =       181
CONST kExprOff        =       182
CONST kStatA          =       183
CONST kStatB          =       184
CONST kStatC          =       185
CONST kCorr           =       186
CONST kStatD          =       187
CONST kStatE          =       188
CONST kRegEq          =       189
CONST kMinX           =       190
CONST kQ1             =       191
CONST kMD             =       192
CONST kQ3             =       193
CONST kMaxX           =       194
CONST kStatX1         =       195
CONST kStatY1         =       196
CONST kStatX2         =       197
CONST kStatY2         =       198
CONST kStatX3         =       199
CONST kStatY3         =       200
CONST kTblMin         =       201
CONST kTblStep        =       202
CONST kSetupLst       =       203
CONST kClrAllLst      =       204
CONST kLogistic       =       205
CONST kZTest          =       206
CONST kTTest          =       207
CONST k2SampZTest     =       208
CONST k2SampTTest     =       209
CONST k1PropZTest     =       210
CONST k2PropZTest     =       211
CONST kChiTest        =       212
CONST k2SampFTest     =       213
CONST kZIntVal        =       214
CONST kTIntVal        =       215
CONST k2SampTInt      =       216
CONST k2SampZInt      =       217
CONST k1PropZInt      =       218
CONST k2PropZInt      =       219
CONST kDNormal        =       220
CONST kInvNorm        =       221
CONST kDT             =       222
CONST kChi            =       223
CONST kDF             =       224
CONST kBinPDF         =       225
CONST kBinCDF         =       226
CONST kPoiPDF         =       227
CONST kPoiCDF         =       228
CONST kun             =       229
CONST kvn             =       230
CONST kwn             =       231
CONST kRecn           =       232
CONST kPlotStart      =       233
CONST kZPlotStart     =       234   // recursion n
CONST kXFact          =       235   // PlotStart
CONST kYFact          =       236   // ZPlotStart
CONST kANOVA          =       237   // XFact
CONST kMaxY           =       238   // YFact
CONST kWebOn          =       239   // MinY
CONST kWebOff         =       240   // MaxY
CONST kTblInput       =       241   // WEB ON
CONST kGeoPDF         =       242   // WEB OFF
CONST kGeoCDF         =       243   // WEB OFF
CONST kShadeNorm      =       244
CONST kShadeT         =       245
CONST kShadeChi       =       246
CONST kShadeF         =       247
CONST kPlotStep       =       248
CONST kZPlotStep      =       249
CONST kLinRegtTest    =       250
CONST kMGT	    =	251   // VERT SPLIT
CONST kSelectA        =       152
CONST kZFitA          =       253
CONST kE2BT_End       =       253
//
//
//======================================================================
//           More 2 Byte Keys 
//======================================================================

CONST kE2BT2		=       0

CONST kGDB1		=       0
CONST kGDB2		=       1
CONST kGDB3		=       2
CONST kY1		=       3
CONST kY2		=       4
CONST kY3		=       5
CONST kY4		=       6
CONST kY5		=       7
CONST kY6		=       8
CONST kY7		=       9
CONST kY8		=       10
CONST kY9		=       11
CONST kY0		=       12
CONST kX1T		=       13
CONST kY1T		=       14
CONST kX2T		=       15
CONST kY2T		=       16
CONST kX3T		=       17
CONST kY3T		=       18
CONST kX4T		=       19
CONST kY4T		=       20
CONST kX5T		=       21
CONST kY5T		=       22
CONST kX6T		=       23
CONST kY6T		=       24
CONST kR1		=       25
CONST kR2		=       26
CONST kR3		=       27
CONST kR4		=       28
CONST kR5		=       29
CONST kR6		=       30
CONST kGDB4		=       31
CONST kGDB5		=       32
CONST kGDB6		=       33
CONST kPic4		=       34
CONST kPic5		=       35
CONST kPic6		=       36
CONST kGDB7		=       37
CONST kGDB8		=       38
CONST kGDB9		=       39
CONST kGDB0		=       40
CONST kPic7		=       41
CONST kPic8		=       42
CONST kPic9		=       43
CONST kPic0		=       44
CONST kStatN		=       45
CONST kXMean		=       46
CONST kConj		=       47
CONST kReal		=       48
CONST kFAngle		=       49
CONST kLCM		=       50
CONST kGCD		=       51
CONST kRandInt	=       52
CONST kRandNorm	=       53
CONST kToPolar	=       54
CONST kToRect		=       55
CONST kYMean		=       56
CONST kStdX		=       57
CONST kStdX1		=       58
CONST kw0		=       59
CONST kMatF		=       60
CONST kMatG		=       61
CONST kMatRH		=       62
CONST kMatI		=       63
CONST kMatJ		=       64
CONST kYMean1		=       65
CONST kStdY		=       66
CONST kStdY1		=       67
CONST kMatToLst	=       68
CONST kLstToMat	=       69
CONST kCumSum		=       70
CONST kDeltaLst	=       71
CONST kStdDev		=       72
CONST kVariance	=       73
CONST kLength		=       74
CONST kEquToStrng	=       75
CONST kStrngToEqu	=       76
CONST kExpr		=       77
CONST kSubStrng	=       78
CONST kInStrng	=       79
CONST kStr1		=       80
CONST kStr2		=       81
CONST kStr3		=       82
CONST kStr4           =       83
CONST kStr5           =       84
CONST kStr6           =       85
CONST kStr7           =       86
CONST kStr8           =       87
CONST kStr9           =       88
CONST kStr0           =       89
CONST kFinN           =       90
CONST kFinI           =       91
CONST kFinPV          =       92
CONST kFinPMT         =       93
CONST kFinFV          =       94
CONST kFinPY          =       95
CONST kFinCY          =       96
CONST kFinFPMT        =       97
CONST kFinFI          =       98
CONST kFinFPV         =       99
CONST kFinFN          =       100
CONST kFinFFV         =       101
CONST kFinNPV         =       102
CONST kFinIRR         =       103
CONST kFinBAL         =       104
CONST kFinPRN         =       105
CONST kFinINT         =       106
CONST kSumX           =       107
CONST kSumX2          =       108
CONST kFinToNom       =       109
CONST kFinToEff       =       110
CONST kFinDBD         =       111
CONST kStatVP         =       112
CONST kStatZ          =       113
CONST kStatT          =       114
CONST kStatChi        =       115
CONST kStatF          =       116
CONST kStatDF         =       117
CONST kStatPhat       =       118
CONST kStatPhat1      =       119
CONST kStatPhat2      =       120
CONST kStatMeanX1     =       121
CONST kStatMeanX2     =       122
CONST kStatStdX1      =       123
CONST kStatStdX2      =       124
CONST kStatStdXP      =       125
CONST kStatN1         =       126
CONST kStatN2         =       127
CONST kStatLower      =       128
CONST kStatUpper      =       129
CONST kuw0            =       130
CONST kImag           =       131
CONST kSumY           =       132
CONST kXres           =       133
CONST kStat_s         =       134
CONST kSumY2          =       135
CONST kSumXY          =       136
CONST kuXres          =       137
CONST kModBox		=       138
CONST kNormProb	=       139
CONST kNormalPDF      =       140
CONST kTPDF           =       141
CONST kChiPDF         =       142
CONST kFPDF           =       143
CONST kMinY           =       144   // MinY
CONST kRandBin        =       145
CONST kRef            =       146
CONST kRRef           =       147
CONST kLRSqr          =       148
CONST kBRSqr          =       149
CONST kDiagOn         =       150
CONST kDiagOff        =       151
CONST kun1            =       152   // FOR RCL USE WHEN GOTTEN FROM 82
CONST kvn1            =       153   // FOR RCL USE WHEN GOTTEN FROM 82
//
CONST k83_00End       =	153            //end of original keys...
CONST kArchive        =     154
CONST kUnarchive      =     155 
CONST kAsm            =     156   // Asm(
CONST kAsmPrgm        =     157   // AsmPrgm
CONST kAsmComp        =     158   // AsmComp(
//
CONST kcapAAcute	=       159
CONST kcapAGrave	=       160
CONST kcapACaret	=       161
CONST kcapADier	=       162
CONST kaAcute		=       163
CONST kaGrave		=       164
CONST kaCaret		=       165
CONST kaDier		=       166
CONST kcapEAcute	=       167
CONST kcapEGrave	=       168
CONST kcapECaret	=       169
CONST kcapEDier	=       170
CONST keAcute		=       171
CONST keGrave		=       172
CONST keCaret		=       173
CONST keDier		=       174
CONST kcapIAcute	=       175
CONST kcapIGrave	=       176
CONST kcapICaret	=       177
CONST kcapIDier	=       178
CONST kiAcute		=       179
CONST kiGrave		=       180
CONST kiCaret		=       181
CONST kiDier		=       182
CONST kcapOAcute	=       183
CONST kcapOGrave	=       184
CONST kcapOCaret	=       185
CONST kcapODier	=       186
CONST koAcute		=       187
CONST koGrave		=       188
CONST koCaret		=       189
CONST koDier		=       190
CONST kcapUAcute	=       191
CONST kcapUGrave	=       192
CONST kcapUCaret	=       193
CONST kcapUDier	=       194
CONST kuAcute		=       195
CONST kuGrave		=       196
CONST kuCaret		=       197
CONST kuDier		=       198
CONST kcapCCed	=       199
CONST kcCed		=       200
CONST kcapNTilde	=       201
CONST knTilde		=       202
CONST kaccent		=       203
CONST kgrave		=       204
CONST kdieresis	=       205
CONST kquesDown	=       206
CONST kexclamDown     =       207
CONST kalpha          =       208
CONST kbeta           =      209
CONST kgamma          =      210
CONST kcapDelta       =      211
CONST kdelta          =      212
CONST kepsilon        =      213
CONST klambda         =      214
CONST kmu             =      215
CONST kpi2            =      216
CONST krho            =      217
CONST kcapSigma       =      218
CONST ksigma          =      219
CONST ktau            =      220
CONST kphi            =      221
CONST kcapOmega       =      222
CONST kphat           =      223
CONST kchi2           =      224
CONST kstatF2         =      225
CONST kLa		=     226
CONST kLb		=     227
CONST kLc		=     228
CONST kLd		=     229
CONST kLe		=     230
CONST kLf		=     231
CONST kLg		=     232
CONST kLh		=     233
CONST kLi		=     234
CONST kLj		=     235
CONST kLk		=     236
CONST kLl		=     237
CONST kLm		=     238
CONST kLsmalln	=    239
CONST kLo		=    240
CONST kLp		=    241
CONST kLq		=    242
CONST kLsmallr	=    243
CONST kLs		=    244
CONST kLt		=    245
CONST kLu		=    246
CONST kLv		=    247
CONST kLw		=    248
CONST kLx		=    249
CONST kLy		=    250
CONST kLz		=    251
CONST kGarbageC	=  252 // GarbageCollect
//
CONST kE2BT2_End	=     252

// the following keys were added in OS version 1.15
CONST KE2BT3          =       0
//
CONST kReserved         =     01       //01 - 001d
CONST kAtSign         =     02       //02 - 002d
CONST kPound          =     03       //03 - 003d
CONST kDollar         =     04       //04 - 004d
CONST kAmpersand      =     05       //05 - 005d
CONST kBackQuote      =     06       //06 - 006d
CONST kSemicolon      =     07       //07 - 007d
CONST kBackSlash      =     8       //08 - 008d
CONST kVertSlash      =     9       //09 - 009d
CONST kUnderscore     =     10       //0A - 010d
CONST kTilde          =     11       //0B - 011d
CONST kPercent        =     12       //0C - 012d
CONST kLastUsedK3     =     12

CONST kTab            =     13       //0D - 013d
CONST kShftTaB        =     14       //0E - 014d
CONST kShftDel        =     15       //0F - 015d
CONST kShftBack       =     16       //10 - 016d
CONST kShftPgUp       =     17       //11 - 017d
CONST kShftPgDn       =     18       //12 - 018d
CONST kShftLeft       =     19       //13 - 019d
CONST kShftRight      =     20       //14 - 020d
CONST kShftUp         =     21       //15 - 021d
CONST kShftDn         =     22       //16 - 022d
//
CONST kDiamond        =     23

//
CONST kDiaAdd         =     23     //17 - 023d
CONST kDiaSub         =     24     //18 - 024d
CONST kDiaTilde       =     25     //19 - 025d
CONST kDiaDiv         =     26     //1A - 026d
CONST kDiaBkSlash     =     27     //1B - 027d
CONST kDiaColon       =     28     //1C - 028d
CONST kDiaQuote       =     29     //1D - 029d
CONST kDiaLBrack      =     30     //1E - 030d



