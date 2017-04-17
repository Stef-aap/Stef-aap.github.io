; compiler          : jal 0.4.60
; date              : 01-Feb-2005 00:41:26
; main source       : rs232sw_demo
; command line      : -casz -vz -orsctd -sD:\data_www\pic\jalcc\examples\jal++\libs d:\data_www\pic\jalcc\examples\jal++\examples\rs232sw_demo.jal 
; target  chip      : 16f876
;         cpu       : pic 14
;         clock     : 20000000
; input   files     : 8
;         lines     : 2961
;         chars     : 88758
; compilation nodes : 15056
;             stack : 31Kb
;              heap : 4685Kb
;           seconds : 0.359 (8247 lines/second)
; output       code :  210
;              page :    0 (0.0%)
;              bank :    0 (0.0%)
;         page+bank :    0 (0.0%)
;              file :   17
;              stack:    2 (2,0,0)

 errorlevel -306
 list p=PIC16f876

; note: the f876 config is still fixed!
 __CONFIG H'3F32' 
 ORG 0000
  goto    __main
 ORG 0004
 ORG 0004
__interrupt: ; 0004
__main: ; 0004
; var H'020:000'  transfer_bit
; var H'020:000'  transfer_byte

;; 022 : var volatile byte INDF        at 0x00
; var H'000:000' indf

;; 034 : var volatile byte STATUS      at 0x03
; var H'003:000' status

;; 040 : var volatile byte FSR         at 0x04
; var H'004:000' fsr

;; 052 : var volatile byte PORTC       at 0x07
; var H'007:000' portc

;; 064 : var volatile byte INTCON      at 0x0B
; var H'00B:000' intcon

;; 275 : var volatile bit  IRP    at STATUS : 7
; var H'003:007' irp

;; 276 : var volatile bit  RP1    at STATUS : 6
; var H'003:006' rp1

;; 277 : var volatile bit  RP0    at STATUS : 5
; var H'003:005' rp0

;; 282 : var volatile bit  C      at STATUS : 0
; var H'003:000' c

;; 287 : var volatile bit  GIE  at INTCON : 7
; var H'00B:007' gie

;; 631 : 	  bcf 		 IRP			   ;be sure bank0/1
  bcf     H'003',7

;; 632 :     movlw		 0x20				 ;
  movlw   H'20'

;; 633 :     movwf		 FSR				 ;WAS movfw !!
  movwf   H'004'

;; 634 :   next:			 						 ;
as_5250_next: ; 0007

;; 635 :   	clrf		 INDF				 ;
  clrf    H'000'

;; 636 :   	incf		 FSR,f			 ;
  incf    H'004',f

;; 637 :   	btfss		 FSR,7			 ;
  btfss   H'004',7

;; 638 :   	goto		 next				 ;
  goto    as_5250_next

;; 653 : var byte trisa_shadow
; var H'021:000' trisa_shadow

;; 654 : var byte trisb_shadow
; var H'022:000' trisb_shadow

;; 655 : var byte trisc_shadow
; var H'023:000' trisc_shadow

;; 656 : var byte trisd_shadow
; var H'024:000' trisd_shadow

;; 657 : var byte trise_shadow
; var H'025:000' trise_shadow

;; 661 :    trisa_shadow = all_input
  movlw   H'FF'
  movwf   H'021'

;; 662 :    trisb_shadow = all_input
  movlw   H'FF'
  movwf   H'022'

;; 663 :    trisc_shadow = all_input
  movlw   H'FF'
  movwf   H'023'

;; 664 :    trisd_shadow = all_input
  movlw   H'FF'
  movwf   H'024'

;; 665 :    trise_shadow = 0x0F ;all_input
  movlw   H'0F'
  movwf   H'025'

;; 1038 : var byte _port_c_buffer
; var H'026:000' _port_c_buffer

;; 1561 : INTCON = 0
  clrf    H'00B'

;; 017 : var volatile byte asynch_sw_out_port      is portc
; var H'007:000' asynch_sw_out_port

;; 019 : var volatile byte asynch_sw_out_buffer    is _port_c_buffer
; var H'026:000' asynch_sw_out_buffer

;; 024 : var volatile byte asynch_sw_in_port      is portc
; var H'007:000' asynch_sw_in_port

;; 082 :   var byte IL_Tx = _IL_Tx
; var H'027:000' il_tx
  movlw   H'07'
  movwf   H'027'

;; 086 :     IL_Tx = _IL_Tx + 1
  movlw   H'08'
  movwf   H'027'

;; 118 : var byte ILval
; var H'028:000' ilval

;; 119 : var byte OLval
; var H'029:000' olval

;; 120 : var byte ILval0
; var H'02A:000' ilval0

;; 128 :   ILval  = _ILval
  movlw   H'08'
  movwf   H'028'

;; 129 :   OLval  = _OLval
  movlw   H'01'
  movwf   H'029'

;; 131 :   if _ILval0 > 0 then ILval0 = _ILval0 else ILval0 = 1 end if
  movlw   H'05'
  movwf   H'02A'

;; 132 :   ILval0 = _ILval0
  movlw   H'05'
  movwf   H'02A'

;; 034 : asynch_sw_init_receive
  bcf     H'00A',3
  bcf     H'00A',4
  call    _14458__vector

;; 035 : asynch_sw_init_transmit
  bcf     H'00A',3
  bcf     H'00A',4
  call    _14418__vector

;; 037 : asynch_send_sw (0xAA)
  movlw   H'AA'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _13471__vector

;; 038 : asynch_send_sw (0x55)
  movlw   H'55'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _13471__vector

;; 039 : asynch_send_sw (0xAA)
  movlw   H'AA'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _13471__vector

;; 057 : var byte character
; var H'02B:000' character

;; 058 : forever loop
w_14650_ag: ; 0034

;; 060 :   asynch_receive_sw (character)
  bcf     H'00A',3
  bcf     H'00A',4
  call    _13765__vector
  movf    H'02C',w
  movwf   H'02B'

;; 062 :      asynch_send_sw (character + 1)
  movf    H'02B',w
  addlw   H'01'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _13471__vector
  bcf     H'00A',3
  bcf     H'00A',4
  goto    w_14650_ag

;; 003 :   idle_loop: page goto idle_loop
as_14653_idle_loop: ; 0041
  bcf     H'00A',3
  bcf     H'00A',4
  goto    as_14653_idle_loop
_14458__vector: ; 0044
p_14458_asynch_sw_init_receive: ; 0044

;; 691 :   asynch_sw_in_direction = input
  bsf     H'023',7
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _6557__vector
e_14458_asynch_sw_init_receive: ; 0048
_14418__vector: ; 0048
p_14418_asynch_sw_init_transmit: ; 0048

;; 672 :    asm bsf  asynch_sw_out_buffer,asynch_sw_out_nr
  bsf     H'026',6

;; 677 :      movfw  asynch_sw_out_buffer
  movf    H'026',w

;; 678 :      movwf  asynch_sw_out_port
  movwf   H'007'

;; 681 :   asynch_sw_out_direction = output
  bcf     H'023',6
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _6528__vector
e_14418_asynch_sw_init_transmit: ; 004F
_13765__vector: ; 004F

;; 336 : procedure asynch_receive_sw ( byte out x ) is
; var H'02C:000' x
p_13765_asynch_receive_sw: ; 004F
  movwf   H'02C'

;; 339 : var byte bitcnt    ;holds the actual number of bits to be sent
; var H'02D:000' bitcnt

;; 340 : var byte outloop   ;loop counter
; var H'02E:000' outloop

;; 341 : var byte inloop    ;inner loop counter
; var H'02F:000' inloop

;; 342 : var byte samp      ;sampled bit
; var H'030:000' samp

;; 344 : var volatile byte pa is asynch_sw_in_port
; var H'007:000' pa

;; 347 :   bitcnt = 8
  movlw   H'08'
  movwf   H'02D'

;; 354 :     local next_bit, next_bit2, next_bit3
; const H'062' next_bit
; const H'066' next_bit2

;; 355 :     page next_bit
  bcf     H'00A',3
  bcf     H'00A',4

;; 357 :     wait_idle:
as_13815_wait_idle: ; 0054

;; 358 :       btfss  pa,pp      ;wait till receiver line is inactive (high)
  btfss   H'007',7

;; 359 :       goto   wait_idle  ;
  goto    as_13815_wait_idle

;; 361 :     wait_start:
as_13818_wait_start: ; 0056

;; 362 :       btfsc  pa,pp      ;(2) wait for startbit
  btfsc   H'007',7

;; 363 :       goto   wait_start ;
  goto    as_13818_wait_start

;; 369 :       movfw   OLval      ;(1) Accumulator = Outer Loop Counter
  movf    H'029',w

;; 370 :       movwf   outloop    ;(1) OUTLOOP = Accumulator
  movwf   H'02E'

;; 373 :     wait_start2:         ;=============  start of double loop
as_13821_wait_start2: ; 005A

;; 374 :       movfw   ILval0     ;(1) Accumulator = Inner Loop Counter
  movf    H'02A',w

;; 375 :       movwf   inloop     ;(1) INLOOP = Accumulator
  movwf   H'02F'

;; 376 :     wait_start3:         ;
as_13824_wait_start3: ; 005C

;; 377 :       decfsz  inloop,f   ;(1)
  decfsz  H'02F',f

;; 378 :       goto    wait_start3;(2)
  goto    as_13824_wait_start3

;; 380 :       decfsz  outloop,f  ;(1)
  decfsz  H'02E',f

;; 381 :       goto    wait_start2;(2)
  goto    as_13821_wait_start2

;; 388 :       btfsc  pa,pp      ;(2)
  btfsc   H'007',7

;; 389 :       goto   wait_idle  ; if not a start bit anymore, error, seek further
  goto    as_13815_wait_idle

;; 392 :     next_bit:
as_13827_next_bit: ; 0062

;; 393 :       movfw   OLval      ;(1) Accumulator = Outer Loop Counter
  movf    H'029',w

;; 394 :       movwf   outloop    ;(1) OUTLOOP = Accumulator
  movwf   H'02E'

;; 399 :       nop                ;(1)
  nop     

;; 400 :       goto    next_bit2  ;(2)
  goto    as_13830_next_bit2

;; 402 :     next_bit2:           ;=============  start of double loop
as_13830_next_bit2: ; 0066

;; 403 :       movfw   ILval      ;(1) Accumulator = Inner Loop Counter
  movf    H'028',w

;; 404 :       movwf   inloop     ;(1) INLOOP = Accumulator
  movwf   H'02F'

;; 405 :     next_bit3:           ;
as_13833_next_bit3: ; 0068

;; 406 :       decfsz  inloop,f   ;(1)
  decfsz  H'02F',f

;; 407 :       goto    next_bit3  ;(2)
  goto    as_13833_next_bit3

;; 409 :       decfsz  outloop,f  ;(1)
  decfsz  H'02E',f

;; 410 :       goto    next_bit2  ;(2)
  goto    as_13830_next_bit2

;; 419 :       movfw  pa          ;(1) always sample once and store in buffer SAMP
  movf    H'007',w

;; 420 :       movwf  samp        ;(1)
  movwf   H'030'

;; 421 :       btfsc  samp,pp     ;(1/2) DATA IS INVERTED !!
  btfsc   H'030',7

;; 422 :       bsf    status,C    ;(1/0) clear Carry (will be shifted in data byte)
  bsf     H'003',0

;; 423 :       btfss  samp,pp     ;(2/1)
  btfss   H'030',7

;; 424 :       bcf    status,C    ;(0/1) set Carry (will be shifted in data byte)
  bcf     H'003',0

;; 427 :       rrf    x,f         ;(1) shift Carry in result byte
  rrf     H'02C',f

;; 430 :       decfsz bitcnt,f    ;(1) decrement bit count, exit routine if zero
  decfsz  H'02D',f

;; 431 :       goto   next_bit    ;(2) continue routine
  goto    as_13827_next_bit
e_13765_asynch_receive_sw: ; 0075
  return  
_13471__vector: ; 0076

;; 188 : procedure asynch_send_sw (byte in x) is
; var H'02C:000' x
p_13471_asynch_send_sw: ; 0076
  movwf   H'02C'

;; 191 : var byte data      ;holds the actual data to be sent
; var H'02D:000' data

;; 192 : var byte bitcnt    ;holds the actual number of bits to be sent
; var H'02E:000' bitcnt

;; 193 : var byte OLcnt     ;loop counter
; var H'02F:000' olcnt

;; 194 : var byte ILcnt     ;inner loop counter
; var H'030:000' ilcnt

;; 198 : var volatile byte port is asynch_sw_out_port
; var H'007:000' port

;; 199 : var volatile byte pa   is asynch_sw_out_buffer
; var H'026:000' pa

;; 203 :   while gie loop
w_13516_ag: ; 0077
  bcf     H'00A',3
  bcf     H'00A',4
  btfsc   H'00B',7
  goto    w_13516_bo
w_13516_jb: ; 007B
  bcf     H'00A',3
  bcf     H'00A',4
  goto    w_13516_be
w_13516_bo: ; 007E

;; 204 :     gie = false
  bcf     H'00B',7
  bcf     H'00A',3
  bcf     H'00A',4
  goto    w_13516_ag
w_13516_be: ; 0082

;; 207 :   data = x
  movf    H'02C',w
  movwf   H'02D'

;; 208 :   bitcnt = 11    ; 11 bits = startbit + 8 databits + 2 stopbits
  movlw   H'0B'
  movwf   H'02E'

;; 214 :     local _bit_time, _bit_time2, _bit_time3, _send_byte, _next_bit
; const H'092' _send_byte
; const H'093' _next_bit

;; 215 :     page _next_bit
  bcf     H'00A',3
  bcf     H'00A',4

;; 217 :     goto   _send_byte    ;jump over delay routine, I don't know any other way
  goto    as_13547__send_byte

;; 220 :     _bit_time:           ;(2) (length of call instruction)
as_13538__bit_time: ; 0089

;; 221 :       movlw   OL_Tx      ;(1) Accumulator = Outer Loop Counter
  movlw   H'01'

;; 222 :       movwf   OLcnt      ;(1) OUTLOOP = Accumulator
  movwf   H'02F'

;; 224 :     _bit_time2:          ;=============  start of double loop
as_13541__bit_time2: ; 008B

;; 225 :       movfw   IL_Tx      ;(1) Accumulator = Inner Loop Counter
  movf    H'027',w

;; 226 :       movwf   ILcnt      ;(1) INLOOP = Accumulator
  movwf   H'030'

;; 227 :     _bit_time3:          ;
as_13544__bit_time3: ; 008D

;; 228 :       decfsz  ILcnt,f    ;(1)
  decfsz  H'030',f

;; 229 :       goto    _bit_time3 ;(2)
  goto    as_13544__bit_time3

;; 230 :       decfsz  OLcnt,f    ;(1)
  decfsz  H'02F',f

;; 231 :       goto    _bit_time2 ;(2)
  goto    as_13541__bit_time2

;; 236 :     return               ;(2)
  return  

;; 242 :     _send_byte:
as_13547__send_byte: ; 0092

;; 243 :        bcf    status,C   ;clear Carry (start bit)
  bcf     H'003',0

;; 244 :     _next_bit:
as_13550__next_bit: ; 0093

;; 250 :        btfsc  status,C   ;(1/2) test Carry, skip if clear
  btfsc   H'003',0

;; 251 :        bsf    pa,pp      ;(1/0) data bit = 1 ==> out = high
  bsf     H'026',6

;; 252 :        btfss  status,C   ;(2/1) test Carry, skip if set
  btfss   H'003',0

;; 253 :        bcf    pa,pp      ;(0/1) data bit = 0 ==> out = low
  bcf     H'026',6

;; 255 :        movfw  pa         ;(1) output buffer to accumulator
  movf    H'026',w

;; 256 :        movwf  port       ;(1) send output buffer to port
  movwf   H'007'

;; 259 :        call   _bit_time  ;( 3*OLval*ILval + 4*OLval + 5 )
  call    as_13538__bit_time

;; 260 :        bsf    status,C   ;(1) set Carry (will be shifted in data byte)
  bsf     H'003',0

;; 261 :        rrf    data,f     ;(1) shift data byte, so next bit goes to Carry
  rrf     H'02D',f

;; 262 :        decfsz bitcnt,f   ;(1) decrement bit count, exit routine if zero
  decfsz  H'02E',f

;; 263 :        goto   _next_bit  ;(2) continue routine
  goto    as_13550__next_bit
e_13471_asynch_send_sw: ; 009E
  return  

;; 859 : procedure pin_c7_direction'put( bit in d at trisc_shadow : 7 ) is
p_6557__pin_c7_direction__put_t: ; 009F
_6557__vector: ; 009F
; var H'023:007' d
p_6557_put: ; 009F

;; 860 :    _trisc_flush
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _5408__vector
e_6557_put: ; 00A2

;; 855 : procedure pin_c6_direction'put( bit in d at trisc_shadow : 6 ) is
p_6528__pin_c6_direction__put_t: ; 00A2
_6528__vector: ; 00A2
; var H'023:006' d
p_6528_put: ; 00A2

;; 856 :    _trisc_flush
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _5408__vector
e_6528_put: ; 00A5
_5408__vector: ; 00A5
p_5408__trisc_flush: ; 00A5

;; 690 :     asm movfw trisc_shadow
  movf    H'023',w

;; 691 :     bank_1
  bcf     H'00A',3
  bcf     H'00A',4
  call    _5192__vector

;; 692 :     asm movwf  0x7
  movwf   H'007'

;; 693 :     bank_0
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _5173__vector
e_5408__trisc_flush: ; 00AD
_5192__vector: ; 00AD
p_5192_bank_1: ; 00AD

;; 611 :   asm bsf STATUS, RP0
  bsf     H'003',5

;; 612 :   asm bcf STATUS, RP1
  bcf     H'003',6
e_5192_bank_1: ; 00AF
  return  
_5173__vector: ; 00B0
p_5173_bank_0: ; 00B0

;; 598 :   asm bcf STATUS, RP0
  bcf     H'003',5

;; 599 :   asm bcf STATUS, RP1
  bcf     H'003',6
e_5173_bank_0: ; 00B2
  return  

 END

; ********** variable mapping
; 00:0 : ;
;   indf                           * 0022:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 03:0 : ;
;   c                              * 0282:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
;   status                         * 0034:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 03:5 : ;
;   rp0                            * 0277:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 03:6 : ;
;   rp1                            * 0276:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 03:7 : ;
;   irp                            * 0275:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 04:0 : ;
;   fsr                            * 0040:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 07:0 : ;
;   port                           * 0198:19 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_sw.jal 
;   pa                             * 0344:19 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_sw.jal 
;   asynch_sw_in_port              * 0024:19 d:\data_www\pic\jalcc\examples\jal++\examples\rs232sw_demo.jal 
;   asynch_sw_out_port             * 0017:19 d:\data_www\pic\jalcc\examples\jal++\examples\rs232sw_demo.jal 
;   portc                          * 0052:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 0B:0 : ;
;   intcon                         * 0064:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 0B:7 : ;
;   gie                            * 0287:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 20:0 : ;
;    transfer_byte                   
;    transfer_bit                    
; 21:0 : ;
;   trisa_shadow                     0653:10 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 22:0 : ;
;   trisb_shadow                     0654:10 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 23:0 : ;
;   trisc_shadow                     0655:10 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 23:6 : ;
;   d                              * 0855:33 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 23:7 : ;
;   d                              * 0859:33 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 24:0 : ;
;   trisd_shadow                     0656:10 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 25:0 : ;
;   trise_shadow                     0657:10 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 26:0 : ;
;   pa                             * 0199:19 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_sw.jal 
;   asynch_sw_out_buffer           * 0019:19 d:\data_www\pic\jalcc\examples\jal++\examples\rs232sw_demo.jal 
;   _port_c_buffer                   1038:10 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 27:0 : ;
;   il_tx                            0082:12 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_sw.jal 
; 28:0 : ;
;   ilval                            0118:10 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_sw.jal 
; 29:0 : ;
;   olval                            0119:10 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_sw.jal 
; 2A:0 : ;
;   ilval0                           0120:10 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_sw.jal 
; 2B:0 : ;
;   character                        0057:10 d:\data_www\pic\jalcc\examples\jal++\examples\rs232sw_demo.jal 
; 2C:0 : ;
;   x                                0188:27 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_sw.jal 
;   x                                0336:31 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_sw.jal 
; 2D:0 : ;
;   data                             0191:10 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_sw.jal 
;   bitcnt                           0339:10 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_sw.jal 
; 2E:0 : ;
;   bitcnt                           0192:10 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_sw.jal 
;   outloop                          0340:10 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_sw.jal 
; 2F:0 : ;
;   olcnt                            0193:10 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_sw.jal 
;   inloop                           0341:10 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_sw.jal 
; 30:0 : ;
;   ilcnt                            0194:10 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_sw.jal 
;   samp                             0342:10 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_sw.jal 

