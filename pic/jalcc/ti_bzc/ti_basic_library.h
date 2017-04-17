

//-----------------------------------------------------
// TI-BASIC        Line  (X1, Y1, X2, Y2, Draw)
// limitation, should always be called with 5 parameters
//-----------------------------------------------------
Function Basic_Line_2  arg 5
FSTART Basic_Line_2  HL, A,  D,  E,  Draw
  ASM
    LD  B, A         ; B = X1 coordinate
    LD  C, L         ; C = Y1 coordinate
  ENDASM 

  HL = Draw          ; HL = (0=Erase, 1=Draw, 2=Toggle)

  ASM
    LD  H, L         ; H = (0=Erase, 1=Draw, 2=Toggle)
  ENDASM 
  _ILine             ; Draw the line
FEnd
//-----------------------------------------------------

