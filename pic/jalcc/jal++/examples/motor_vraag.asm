; compiler          : jal 0.4.59
; date              : 02-Mar-2005 00:19:10
; main source       : motor_vraag
; command line      : -casz -vz -orsctd -sD:\data_www\pic\jalcc\jal++\libs d:\data_www\pic\jalcc\jal++\examples\motor_vraag.jal 
; target  chip      : 16f876
;         cpu       : pic 14
;         clock     : 20000000
; input   files     : 10
;         lines     : 3897
;         chars     : 114075
; compilation nodes : 19474
;             stack : 37Kb
;              heap : 4848Kb
;           seconds : 0.359 (10855 lines/second)
; output       code :  735
;              page :    0 (0.0%)
;              bank :    0 (0.0%)
;         page+bank :    0 (0.0%)
;              file :   28
;              stack:    4 (4,0,0)

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
; var H'021:000'  transfer_byte

;; 022 : var volatile byte INDF        at 0x00
; var H'000:000' indf

;; 034 : var volatile byte STATUS      at 0x03
; var H'003:000' status

;; 040 : var volatile byte FSR         at 0x04
; var H'004:000' fsr

;; 046 : var volatile byte PORTA       at 0x05
; var H'005:000' porta

;; 064 : var volatile byte INTCON      at 0x0B
; var H'00B:000' intcon

;; 070 : var volatile byte PIR1        at 0x0C
; var H'00C:000' pir1

;; 106 : var volatile byte RCSTA       at 0x18
; var H'018:000' rcsta

;; 109 : var volatile byte TXREG       at 0x19
; var H'019:000' txreg

;; 124 : var volatile byte ADRESH      at 0x1E
; var H'01E:000' adresh

;; 127 : var volatile byte ADCON0      at 0x1F
; var H'01F:000' adcon0

;; 152 : var volatile byte _PIE1       at 0x8C
; var H'08C:000' _pie1

;; 215 : var volatile bit  pin_a0 at PORTA : 0
; var H'005:000' pin_a0

;; 275 : var volatile bit  IRP    at STATUS : 7
; var H'003:007' irp

;; 276 : var volatile bit  RP1    at STATUS : 6
; var H'003:006' rp1

;; 277 : var volatile bit  RP0    at STATUS : 5
; var H'003:005' rp0

;; 282 : var volatile bit  C      at STATUS : 0
; var H'003:000' c

;; 302 : var volatile bit  TXIF   at PIR1 : 4
; var H'00C:004' txif

;; 394 : var volatile bit  GO       at ADCON0 : 2
; var H'01F:002' go

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
; var H'022:000' trisa_shadow

;; 654 : var byte trisb_shadow
; var H'023:000' trisb_shadow

;; 655 : var byte trisc_shadow
; var H'024:000' trisc_shadow

;; 656 : var byte trisd_shadow
; var H'025:000' trisd_shadow

;; 657 : var byte trise_shadow
; var H'026:000' trise_shadow

;; 661 :    trisa_shadow = all_input
  movlw   H'FF'
  movwf   H'022'

;; 662 :    trisb_shadow = all_input
  movlw   H'FF'
  movwf   H'023'

;; 663 :    trisc_shadow = all_input
  movlw   H'FF'
  movwf   H'024'

;; 664 :    trisd_shadow = all_input
  movlw   H'FF'
  movwf   H'025'

;; 665 :    trise_shadow = 0x0F ;all_input
  movlw   H'0F'
  movwf   H'026'

;; 1036 : var byte _port_a_buffer
; var H'027:000' _port_a_buffer

;; 1561 : INTCON = 0
  clrf    H'00B'

;; 017 : ADCON1 = 7    -- set portA to normal digital IO
  movlw   H'07'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _11752__vector

;; 377 :   asynch_init_hw
  bcf     H'00A',3
  bcf     H'00A',4
  call    _13618__vector

;; 077 : var byte x4,x3,x2,x1
; var H'028:000' x4
; var H'029:000' x3
; var H'02A:000' x2
; var H'02B:000' x1

;; 078 : var byte y4,y3,y2,y1
; var H'02C:000' y4
; var H'02D:000' y3
; var H'02E:000' y2
; var H'02F:000' y1

;; 092 : var volatile byte _ADCON0_shadow = 0
; var H'030:000' _adcon0_shadow
  clrf    H'030'

;; 093 : var volatile byte _PIC_ADC_conversion_time
; var H'031:000' _pic_adc_conversion_time

;; 018 : PIC_ADC_init
  bcf     H'00A',3
  bcf     H'00A',4
  call    _17095__vector

;; 019 : ADCON1 = 7    -- set portA to normal digital IO
  movlw   H'07'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _11752__vector

;; 024 : var volatile bit  motor_pin       is pin_A0
; var H'005:000' motor_pin

;; 030 : motor_pin = high
  bsf     H'027',0
  bcf     H'00A',3
  bcf     H'00A',4
  call    _8854__vector

;; 035 : var byte x
; var H'032:000' x

;; 036 : var byte N
; var H'033:000' n

;; 037 : var byte P = 0
; var H'034:000' p
  clrf    H'034'

;; 038 : var byte nultime = 0
; var H'035:000' nultime
  clrf    H'035'

;; 089 : forever loop
w_17455_ag: ; 002B

;; 091 :   motor_pin = high
  bsf     H'027',0
  bcf     H'00A',3
  bcf     H'00A',4
  call    _8854__vector

;; 092 :   motor_direction = output
  bcf     H'022',0
  bcf     H'00A',3
  bcf     H'00A',4
  call    _5762__vector

;; 093 :   delay_10us (P)
  movf    H'034',w
  bcf     H'00A',3
  bcf     H'00A',4
  call    _12745__vector

;; 097 :   motor_pin = low
  bcf     H'027',0
  bcf     H'00A',3
  bcf     H'00A',4
  call    _8854__vector

;; 100 :   motor_direction = input
  bsf     H'022',0
  bcf     H'00A',3
  bcf     H'00A',4
  call    _5762__vector

;; 101 :   ADCON1 = 0b_0000_1110
  movlw   H'0E'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _11752__vector

;; 102 :   PIC_ADC_read_low_res(0,x)
  clrf    H'036'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _15850__vector
  movf    H'037',w
  movwf   H'032'

;; 107 :   ADCON1 = 7    -- set portA to normal digital IO
  movlw   H'07'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _11752__vector

;; 108 :   motor_direction = output
  bcf     H'022',0
  bcf     H'00A',3
  bcf     H'00A',4
  call    _5762__vector

;; 110 :   x2 = 0
  clrf    H'02A'

;; 111 :   x1 = x
  movf    H'032',w
  movwf   H'02B'

;; 112 :   byte2_add     -- Y = Y + X
  bcf     H'00A',3
  bcf     H'00A',4
  call    _14722__vector

;; 113 :   N = N + 1
  incf    H'033',f

;; 114 :   if N > 64 then
  movf    H'033',w
  sublw   H'40'
  bcf     H'00A',3
  bcf     H'00A',4
  btfsc   H'003',0
  goto    if_17346_by
if_17346_th: ; 005E

;; 115 :     byte2_shr (3)
  movlw   H'03'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _14362__vector

;; 116 :     asynch_send_hw (y2)
  movf    H'02E',w
  bcf     H'00A',3
  bcf     H'00A',4
  call    _13693__vector

;; 117 :     asynch_send_hw (y1)
  movf    H'02F',w
  bcf     H'00A',3
  bcf     H'00A',4
  call    _13693__vector

;; 120 :     Y1 = 0x00
  clrf    H'02F'

;; 121 :     Y2 = 0x00
  clrf    H'02E'

;; 123 :     N = 0
  clrf    H'033'

;; 125 :     if nultime < 20 then
  movlw   H'14'
  subwf   H'035',w
  bcf     H'00A',3
  bcf     H'00A',4
  btfsc   H'003',0
  goto    if_17406_el
if_17406_th: ; 0073

;; 126 :       nultime = nultime + 1
  incf    H'035',f
  bcf     H'00A',3
  bcf     H'00A',4
  goto    if_17406_by
if_17406_el: ; 0077

;; 128 :       if P < 230 then
  movlw   H'E6'
  subwf   H'034',w
  bcf     H'00A',3
  bcf     H'00A',4
  btfsc   H'003',0
  goto    if_17422_by
if_17422_th: ; 007D

;; 129 :         P = P + 4
  movlw   H'04'
  addwf   H'034',f
if_17422_by: ; 007F
if_17406_by: ; 007F
if_17346_by: ; 007F

;; 134 :   delay_10us (255 - P)
  movf    H'034',w
  sublw   H'FF'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _12745__vector
  bcf     H'00A',3
  bcf     H'00A',4
  goto    w_17455_ag

;; 140 : forever loop
w_17551_ag: ; 0087

;; 141 :   motor_pin = high
  bsf     H'027',0
  bcf     H'00A',3
  bcf     H'00A',4
  call    _8854__vector

;; 142 :   motor_direction = output
  bcf     H'022',0
  bcf     H'00A',3
  bcf     H'00A',4
  call    _5762__vector

;; 143 :   delay_1ms (5)
  movlw   H'05'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _12891__vector

;; 146 :   motor_pin = low
  bcf     H'027',0
  bcf     H'00A',3
  bcf     H'00A',4
  call    _8854__vector

;; 149 :   motor_direction = input
  bsf     H'022',0
  bcf     H'00A',3
  bcf     H'00A',4
  call    _5762__vector

;; 150 : delay_10us (5)
  movlw   H'05'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _12745__vector
  bcf     H'00A',3
  bcf     H'00A',4

;; 151 :   if motor_pin then
  btfss   H'005',0
  goto    if_17506_by
if_17506_th: ; 00A3

;; 152 :     asynch_send_hw (0xAA)
  movlw   H'AA'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _13693__vector
if_17506_by: ; 00A7

;; 155 :   motor_pin = low
  bcf     H'027',0
  bcf     H'00A',3
  bcf     H'00A',4
  call    _8854__vector

;; 156 :   motor_direction = output
  bcf     H'022',0
  bcf     H'00A',3
  bcf     H'00A',4
  call    _5762__vector

;; 157 :   delay_1ms (5)
  movlw   H'05'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _12891__vector

;; 158 :   motor_direction = input
  bsf     H'022',0
  bcf     H'00A',3
  bcf     H'00A',4
  call    _5762__vector
  bcf     H'00A',3
  bcf     H'00A',4
  goto    w_17551_ag

;; 003 :   idle_loop: page goto idle_loop
as_17554_idle_loop: ; 00BA
  bcf     H'00A',3
  bcf     H'00A',4
  goto    as_17554_idle_loop
_17095__vector: ; 00BD
p_17095_pic_adc_init: ; 00BD

;; 357 : 	  if    PIC_ADC_NVref == 0 then _PIC_ADC_init_NO_Vref
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _16351__vector
e_17095_pic_adc_init: ; 00C0
_16351__vector: ; 00C0
p_16351__pic_adc_init_no_vref: ; 00C0

;; 187 : 	    ADCON1 = 0b_0000_1110  
  movlw   H'0E'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _11752__vector

;; 188 : 			pin_A0_direction = input	 		 		 
  bsf     H'022',0
  bcf     H'00A',3
  bcf     H'00A',4
  call    _5762__vector

;; 224 : 		_ad_init_general
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _16009__vector
e_16351__pic_adc_init_no_vref: ; 00CB
_16009__vector: ; 00CB
p_16009__ad_init_general: ; 00CB

;; 161 : 		if    target_clock >  5_000_000       then _ADCON0_shadow = 0b_1000_0001	 
  movlw   H'81'
  movwf   H'030'

;; 171 : 	_PIC_ADC_conversion_time = PIC_ADC_conversion_delay
  movlw   H'02'
  movwf   H'031'
e_16009__ad_init_general: ; 00CF
  return  
_15850__vector: ; 00D0

;; 101 :   (byte in PIC_ADC_chan, byte out PIC_ADC_byte) is
; var H'036:000' pic_adc_chan
; var H'037:000' pic_adc_byte
p_15850_pic_adc_read_low_res: ; 00D0
  movwf   H'037'
; var H'038:000' sq_temp_15900

;; 106 :     ADCON0 = _ADCON0_shadow | ((PIC_ADC_chan & 0x07) << 3) -- setup multiplexer
  movf    H'036',w
  andlw   H'07'
  movwf   H'039'
  movlw   H'03'
  movwf   H'03A'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _1069__vector
  movf    H'03B',w
  movwf   H'038'
  movf    H'038',w
  iorwf   H'030',w
  movwf   H'01F'

;; 108 :   delay_10us (_PIC_ADC_conversion_time)	 -- wait acquisition time
  movf    H'031',w
  bcf     H'00A',3
  bcf     H'00A',4
  call    _12745__vector

;; 109 :   GO = true	 														 -- start conversion
  bsf     H'01F',2

;; 110 :   while GO loop end loop								 -- wait till conversion finished
w_15926_ag: ; 00E3
  bcf     H'00A',3
  bcf     H'00A',4
  btfss   H'01F',2
  goto    w_15926_be
w_15926_bo: ; 00E7
  bcf     H'00A',3
  bcf     H'00A',4
  goto    w_15926_ag
w_15926_be: ; 00EA

;; 111 :   PIC_ADC_byte = ADRESH									 -- read high byte 
  movf    H'01E',w
  movwf   H'037'
e_15850_pic_adc_read_low_res: ; 00EC
  return  
_14722__vector: ; 00ED
p_14722_byte2_add: ; 00ED

;; 410 :   byteN_add
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _14623__vector
e_14722_byte2_add: ; 00F0
_14623__vector: ; 00F0
p_14623_byten_add: ; 00F0

;; 373 :   local carry_y2, carry_y3, carry_y4, start
; const H'0F7' start

;; 375 :     goto     start       ;
  goto    as_14639_start

;; 378 :   carry_y2:              ;aggregate the Carry through all the bytes
as_14630_carry_y2: ; 00F1

;; 379 :     incfsz   y2,f        ;
  incfsz  H'02E',f

;; 380 :     return               ;
  return  

;; 381 :   carry_y3:
as_14633_carry_y3: ; 00F3

;; 382 :     incfsz   y3,f        ;
  incfsz  H'02D',f

;; 383 :     return               ;
  return  

;; 384 :   carry_y4:
as_14636_carry_y4: ; 00F5

;; 385 :     incf     y4,f        ;
  incf    H'02C',f

;; 386 :     return               ;
  return  

;; 388 :   start:                 ;
as_14639_start: ; 00F7

;; 389 :     movf     x1,w        ; W = X1
  movf    H'02B',w

;; 390 :     addwf    y1,f        ; Y1 = Y1 + X1
  addwf   H'02F',f

;; 391 :     btfsc    status,C    ; skip if no Carry
  btfsc   H'003',0

;; 392 :     call     carry_y2    ; add Carry
  call    as_14630_carry_y2

;; 394 :     movf     x2,w        ; W = X2
  movf    H'02A',w

;; 395 :     addwf    y2,f        ; Y2 = Y2 + X2
  addwf   H'02E',f

;; 396 :     btfsc    status,C    ; skip if no Carry
  btfsc   H'003',0

;; 397 :     call     carry_y3    ; add Carry
  call    as_14633_carry_y3

;; 399 :     movf     x3,w        ; W = X3
  movf    H'029',w

;; 400 :     addwf    y3,f        ; Y3 = Y3 + X3
  addwf   H'02D',f

;; 401 :     btfsc    status,C    ; skip if no Carry
  btfsc   H'003',0

;; 402 :     call     carry_y4    ; add Carry
  call    as_14636_carry_y4

;; 404 :     movf     x4,w        ; W = X4
  movf    H'028',w

;; 405 :     addwf    y4,f        ; Y4 = Y4 + X4
  addwf   H'02C',f
e_14623_byten_add: ; 0105
  return  
_14362__vector: ; 0106

;; 260 : procedure byte2_SHR ( byte in N = 1 ) is
; var H'036:000' n
p_14362_byte2_shr: ; 0106
  movwf   H'036'

;; 264 :   next:                  ;
as_14380_next: ; 0107

;; 265 :     bcf      status,C    ;clear Carry
  bcf     H'003',0

;; 266 :     rrf      y2,f        ;
  rrf     H'02E',f

;; 267 :     rrf      y1,f        ;
  rrf     H'02F',f

;; 268 :     decfsz   N,f         ;
  decfsz  H'036',f

;; 269 :     goto     next        ;
  goto    as_14380_next
e_14362_byte2_shr: ; 010C
  return  
_13693__vector: ; 010D

;; 289 : procedure asynch_send_hw ( byte in x ) is
; var H'036:000' x
p_13693_asynch_send_hw: ; 010D
  movwf   H'036'

;; 291 :   while ! TXIF loop end loop
w_13710_ag: ; 010E
  bcf     H'00A',3
  bcf     H'00A',4
  btfsc   H'00C',4
  goto    w_13710_be
w_13710_bo: ; 0112
  bcf     H'00A',3
  bcf     H'00A',4
  goto    w_13710_ag
w_13710_be: ; 0115

;; 294 :   TXREG = x
  movf    H'036',w
  movwf   H'019'
e_13693_asynch_send_hw: ; 0117
  return  
_13618__vector: ; 0118
p_13618_asynch_init_hw: ; 0118

;; 243 :   _PIE1 = _PIE1 & (! _b_RCIE)
  movlw   H'FFFFFFDF'
  andwf   H'08C',f

;; 244 :   _PIE1 = _PIE1 & (! _b_TXIE)
  movlw   H'FFFFFFEF'
  andwf   H'08C',f

;; 248 :   TXSTA = 0x20
  movlw   H'20'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _11473__vector

;; 252 :   _calculate_and_set_baudrate
  bcf     H'00A',3
  bcf     H'00A',4
  call    _13058__vector

;; 255 :   RCSTA = 0x80
  movlw   H'80'
  movwf   H'018'

;; 258 :   RCSTA = RCSTA | 0x10
  movlw   H'10'
  iorwf   H'018',f
e_13618_asynch_init_hw: ; 0127
  return  
_13058__vector: ; 0128
p_13058__calculate_and_set_baudrate: ; 0128

;; 081 :   var bit baudrate_high
; var H'020:001' baudrate_high

;; 108 :       if usart_div >= 0 then SPBRG = usart_div else SPBRG = 0 end if
  movlw   H'0A'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _11566__vector

;; 109 :       baudrate_high = true
  bsf     H'020',1
  bcf     H'00A',3
  bcf     H'00A',4

;; 135 :     if baudrate_high then
  btfss   H'020',1
  goto    if_13370_el
if_13370_th: ; 0131

;; 136 :       TXSTA = TXSTA | _b_BRGH         -- set baudrate-high flag
  bcf     H'00A',3
  bcf     H'00A',4
  call    _11520__vector
  movf    H'02A',w
  iorlw   H'04'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _11473__vector
  bcf     H'00A',3
  bcf     H'00A',4
  goto    if_13370_by
if_13370_el: ; 013C

;; 138 :       TXSTA = TXSTA & ! ( _b_BRGH )   -- clear baudarte-high flag
  bcf     H'00A',3
  bcf     H'00A',4
  call    _11520__vector
  movf    H'02A',w
  andlw   H'FFFFFFFB'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _11473__vector
if_13370_by: ; 0144
e_13058__calculate_and_set_baudrate: ; 0144
  return  
_12891__vector: ; 0145

;; 311 : procedure delay_1ms ( byte in N = 1 ) is
; var H'036:000' n
p_12891_delay_1ms: ; 0145
  movwf   H'036'

;; 312 : var byte counter1
; var H'037:000' counter1

;; 313 : var byte counter2
; var H'038:000' counter2

;; 314 :   for N loop
; var H'039:000' _loop_temp_12914
  movf    H'036',w
  movwf   H'039'
w_17593_ag: ; 0148
  movf    H'039',f
  bcf     H'00A',3
  bcf     H'00A',4
  btfss   H'003',2
  goto    w_17593_bo
w_17593_jb: ; 014D
  bcf     H'00A',3
  bcf     H'00A',4
  goto    w_17593_be
w_17593_bo: ; 0150

;; 315 :       counter1 = 7
  movlw   H'07'
  movwf   H'037'

;; 316 :       counter2 = 100
  movlw   H'64'
  movwf   H'038'

;; 318 :       local delay
; const H'156' delay

;; 319 :       page delay
  bcf     H'00A',3
  bcf     H'00A',4

;; 320 :       delay:
as_12931_delay: ; 0156

;; 321 :         decfsz    counter2,f  ;(1)
  decfsz  H'038',f

;; 322 :         goto      delay       ;(2)
  goto    as_12931_delay

;; 323 :         decfsz    counter1,f  ;(1)
  decfsz  H'037',f

;; 324 :         goto      delay      ;(2)
  goto    as_12931_delay

  decf    H'039',f
  bcf     H'00A',3
  bcf     H'00A',4
  goto    w_17593_ag
w_17593_be: ; 015E
e_12891_delay_1ms: ; 015E
  return  
_12745__vector: ; 015F

;; 255 : procedure delay_10uS (byte in N = 1 ) is
; var H'039:000' n
p_12745_delay_10us: ; 015F
  movwf   H'039'

;; 256 : var byte counter1
; var H'03A:000' counter1

;; 257 : var byte counter2
; var H'03B:000' counter2

;; 263 :   if N == 0 then
  movf    H'039',f
  bcf     H'00A',3
  bcf     H'00A',4
  btfsc   H'003',2
  goto    if_12782_by
if_12782_el: ; 0165

;; 267 :   elsif N == 1 then
  movf    H'039',w
  sublw   H'01'
  bcf     H'00A',3
  bcf     H'00A',4
  btfss   H'003',2
  goto    if_12789_el
if_12789_th: ; 016B

;; 270 :         movlw     10          ;
  movlw   H'0A'

;; 271 :         movwf     counter1    ;
  movwf   H'03A'

;; 272 :         nop
  nop     

;; 273 :         nop                  ;
  nop     

;; 274 :       delay0:                 ;
as_12797_delay0: ; 016F

;; 275 :         decfsz    counter1,f  ;
  decfsz  H'03A',f

;; 276 :         goto      delay0      ;
  goto    as_12797_delay0
  bcf     H'00A',3
  bcf     H'00A',4
  goto    if_12789_by
if_12789_el: ; 0174

;; 279 :     counter2 =  N - 1
  movlw   H'01'
  subwf   H'039',w
  movwf   H'03B'

;; 283 :         movlw     10           ;
  movlw   H'0A'

;; 284 :         movwf     counter1    ;
  movwf   H'03A'

;; 285 :       delay0:                 ;
as_12832_delay0: ; 0179

;; 286 :         decfsz    counter1,f  ;
  decfsz  H'03A',f

;; 287 :         goto      delay0      ;
  goto    as_12832_delay0

;; 290 :       delay1:                 ;
as_12835_delay1: ; 017B

;; 291 :         movlw     15          ;(1)
  movlw   H'0F'

;; 292 :         movwf     counter1    ;(1)
  movwf   H'03A'

;; 293 :       delay2:
as_12838_delay2: ; 017D

;; 294 :         decfsz    counter1,f  ;(1)
  decfsz  H'03A',f

;; 295 :         goto      delay2      ;(2)
  goto    as_12838_delay2

;; 297 :         decfsz    counter2,f  ;(1)
  decfsz  H'03B',f

;; 298 :         goto      delay1      ;(2)
  goto    as_12835_delay1
if_12789_by: ; 0181
if_12782_by: ; 0181
e_12745_delay_10us: ; 0181
  return  

;; 1496 : procedure ADCON1'put( byte in x ) is
p_11752__adcon1__put_t: ; 0182
_11752__vector: ; 0182
; var H'036:000' x
p_11752_put: ; 0182
  movwf   H'036'

;; 1497 :   _file_put( high_ADCON1, low_ADCON1, x )
  clrf    H'037'
  movlw   H'9F'
  movwf   H'038'
  movf    H'036',w
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _9928__vector
e_11752_put: ; 018A

;; 1478 : procedure SPBRG'put( byte in x ) is
p_11566__spbrg__put_t: ; 018A
_11566__vector: ; 018A
; var H'028:000' x
p_11566_put: ; 018A
  movwf   H'028'

;; 1479 :   _file_put( high_SPBRG, low_SPBRG, x )
  clrf    H'037'
  movlw   H'99'
  movwf   H'038'
  movf    H'028',w
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _9928__vector
e_11566_put: ; 0192
_11520__vector: ; 0192
p_11520_get: ; 0192

;; 1472 : function TXSTA'get return byte is
; var H'02A:000'  return value

;; 1473 : var byte x
; var H'02B:000' x

;; 1474 :   _file_get( high_TXSTA, low_TXSTA, x )
  clrf    H'02C'
  movlw   H'98'
  movwf   H'02D'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _9872__vector
  movf    H'02E',w
  movwf   H'02B'

;; 1475 :   return x
  movf    H'02B',w
  movwf   H'02A'
e_11520_get: ; 019C
  return  

;; 1469 : procedure TXSTA'put( byte in x ) is
p_11473__txsta__put_t: ; 019D
_11473__vector: ; 019D
; var H'028:000' x
p_11473_put: ; 019D
  movwf   H'028'

;; 1470 :   _file_put( high_TXSTA, low_TXSTA, x )
  clrf    H'037'
  movlw   H'98'
  movwf   H'038'
  movf    H'028',w
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _9928__vector
e_11473_put: ; 01A5
_9928__vector: ; 01A5

;; 059 : procedure _file_put( byte in Haddr , byte in Laddr , byte in data ) is begin 
; var H'037:000' haddr
; var H'038:000' laddr
; var H'039:000' data
p_9928__file_put: ; 01A5
  movwf   H'039'

;; 060 : var volatile bit local_irp
; var H'020:002' local_irp

;; 061 : var volatile bit HAddr0 at Haddr : 0
; var H'037:000' haddr0
  bcf     H'00A',3
  bcf     H'00A',4

;; 062 :    local_irp = IRP
  btfss   H'003',7
  goto    ass_9961_f
ass_9961_t: ; 01AA
  bsf     H'020',2
  bcf     H'00A',3
  bcf     H'00A',4
  goto    ass_9961_b
ass_9961_f: ; 01AE
  bcf     H'020',2
ass_9961_b: ; 01AF
  bcf     H'00A',3
  bcf     H'00A',4

;; 063 :    IRP = HAddr0
  btfss   H'037',0
  goto    ass_9965_f
ass_9965_t: ; 01B3
  bsf     H'003',7
  bcf     H'00A',3
  bcf     H'00A',4
  goto    ass_9965_b
ass_9965_f: ; 01B7
  bcf     H'003',7
ass_9965_b: ; 01B8

;; 064 :    fsr = Laddr
  movf    H'038',w
  movwf   H'004'

;; 065 :    INDF = data
  movf    H'039',w
  movwf   H'000'
  bcf     H'00A',3
  bcf     H'00A',4

;; 066 :    IRP = local_irp
  btfss   H'020',2
  goto    ass_9977_f
ass_9977_t: ; 01C0
  bsf     H'003',7
  bcf     H'00A',3
  bcf     H'00A',4
  goto    ass_9977_b
ass_9977_f: ; 01C4
  bcf     H'003',7
ass_9977_b: ; 01C5
e_9928__file_put: ; 01C5
  return  
_9872__vector: ; 01C6

;; 049 : procedure _file_get( byte in Haddr , byte in Laddr , byte out data ) is begin 
; var H'02C:000' haddr
; var H'02D:000' laddr
; var H'02E:000' data
p_9872__file_get: ; 01C6
  movwf   H'02E'

;; 050 : var volatile bit local_irp
; var H'020:002' local_irp

;; 051 : var volatile bit HAddr0 at Haddr : 0
; var H'02C:000' haddr0
  bcf     H'00A',3
  bcf     H'00A',4

;; 052 :    local_irp = IRP
  btfss   H'003',7
  goto    ass_9905_f
ass_9905_t: ; 01CB
  bsf     H'020',2
  bcf     H'00A',3
  bcf     H'00A',4
  goto    ass_9905_b
ass_9905_f: ; 01CF
  bcf     H'020',2
ass_9905_b: ; 01D0
  bcf     H'00A',3
  bcf     H'00A',4

;; 053 :    IRP = HAddr0
  btfss   H'02C',0
  goto    ass_9909_f
ass_9909_t: ; 01D4
  bsf     H'003',7
  bcf     H'00A',3
  bcf     H'00A',4
  goto    ass_9909_b
ass_9909_f: ; 01D8
  bcf     H'003',7
ass_9909_b: ; 01D9

;; 054 :    fsr = Laddr
  movf    H'02D',w
  movwf   H'004'

;; 055 :    data = INDF
  movf    H'000',w
  movwf   H'02E'
  bcf     H'00A',3
  bcf     H'00A',4

;; 056 :    IRP = local_irp
  btfss   H'020',2
  goto    ass_9921_f
ass_9921_t: ; 01E1
  bsf     H'003',7
  bcf     H'00A',3
  bcf     H'00A',4
  goto    ass_9921_b
ass_9921_f: ; 01E5
  bcf     H'003',7
ass_9921_b: ; 01E6
e_9872__file_get: ; 01E6
  return  

;; 1178 : procedure pin_a0'put( bit in x at _port_a_buffer : 0 ) is
p_8854__pin_a0__put_t: ; 01E7
_8854__vector: ; 01E7
; var H'027:000' x
p_8854_put: ; 01E7

;; 1179 :   _port_a_flush
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _7684__vector
e_8854_put: ; 01EA
_7684__vector: ; 01EA
p_7684__port_a_flush: ; 01EA

;; 1043 :   var volatile byte port_a at 0x05 = _port_a_buffer
; var H'005:000' port_a
  movf    H'027',w
  movwf   H'005'
e_7684__port_a_flush: ; 01EC
  return  

;; 749 : procedure pin_a0_direction'put( bit in d at trisa_shadow : 0 ) is
p_5762__pin_a0_direction__put_t: ; 01ED
_5762__vector: ; 01ED
; var H'022:000' d
p_5762_put: ; 01ED

;; 750 :    _trisa_flush
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _5346__vector
e_5762_put: ; 01F0
_5346__vector: ; 01F0
p_5346__trisa_flush: ; 01F0

;; 674 :     asm movfw trisa_shadow
  movf    H'022',w

;; 676 :     bank_1
  bcf     H'00A',3
  bcf     H'00A',4
  call    _5192__vector

;; 677 :     asm movwf  0x5
  movwf   H'005'

;; 679 :     bank_0
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _5173__vector
e_5346__trisa_flush: ; 01F8
_5192__vector: ; 01F8
p_5192_bank_1: ; 01F8

;; 611 :   asm bsf STATUS, RP0
  bsf     H'003',5

;; 612 :   asm bcf STATUS, RP1
  bcf     H'003',6
e_5192_bank_1: ; 01FA
  return  
_5173__vector: ; 01FB
p_5173_bank_0: ; 01FB

;; 598 :   asm bcf STATUS, RP0
  bcf     H'003',5

;; 599 :   asm bcf STATUS, RP1
  bcf     H'003',6
e_5173_bank_0: ; 01FD
  return  
_1069__vector: ; 01FE

;; 039 :    operator << ( byte in a, byte in n ) return byte is   
; var H'039:000' a
; var H'03A:000' n
p_1069_shift_left: ; 01FE
; var H'03B:000'  return value

;; 040 :       while n > 0 loop   
w_1105_ag: ; 01FE
  movf    H'03A',w
  sublw   H'00'
  bcf     H'00A',3
  bcf     H'00A',4
  btfss   H'003',0
  goto    w_1105_bo
w_1105_jb: ; 0204
  bcf     H'00A',3
  bcf     H'00A',4
  goto    w_1105_be
w_1105_bo: ; 0207

;; 041 :          asm      clrc   
  clrc    

;; 042 :          asm bank rlf  a,f   
  rlf     H'039',f

;; 043 :          n = n - 1   
  movlw   H'01'
  subwf   H'03A',w
  movwf   H'03A'
  bcf     H'00A',3
  bcf     H'00A',4
  goto    w_1105_ag
w_1105_be: ; 020F

;; 045 :       return a   
  movf    H'039',w
  movwf   H'03B'
e_1069_shift_left: ; 0211
  return  

 END

; ********** variable mapping
; 00:0 : ;
;   indf                           * 0022:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 03:0 : ;
;   c                              * 0282:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
;   status                         * 0034:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 03:5 : ;
;   rp0                            * 0277:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 03:6 : ;
;   rp1                            * 0276:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 03:7 : ;
;   irp                            * 0275:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 04:0 : ;
;   fsr                            * 0040:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 05:0 : ;
;   port_a                         * 1043:21 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
;   motor_pin                      * 0024:19 d:\data_www\pic\jalcc\jal++\examples\motor_vraag.jal 
;   pin_a0                         * 0215:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
;   porta                          * 0046:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 0B:0 : ;
;   intcon                         * 0064:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 0C:0 : ;
;   pir1                           * 0070:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 0C:4 : ;
;   txif                           * 0302:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 18:0 : ;
;   rcsta                          * 0106:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 19:0 : ;
;   txreg                          * 0109:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 1E:0 : ;
;   adresh                         * 0124:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 1F:0 : ;
;   adcon0                         * 0127:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 1F:2 : ;
;   go                             * 0394:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 20:0 : ;
;    transfer_bit                    
; 20:1 : ;
;   baudrate_high                    0081:11 D:\data_www\pic\jalcc\jal++\libs\rs232_hw.jal 
; 20:2 : ;
;   local_irp                        0050:18 D:\data_www\pic\jalcc\jal++\libs\indf_bits.jal 
;   local_irp                        0060:18 D:\data_www\pic\jalcc\jal++\libs\indf_bits.jal 
; 21:0 : ;
;    transfer_byte                   
; 22:0 : ;
;   d                              * 0749:33 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
;   trisa_shadow                     0653:10 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 23:0 : ;
;   trisb_shadow                     0654:10 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 24:0 : ;
;   trisc_shadow                     0655:10 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 25:0 : ;
;   trisd_shadow                     0656:10 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 26:0 : ;
;   trise_shadow                     0657:10 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 27:0 : ;
;   x                              * 1178:23 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
;   _port_a_buffer                   1036:10 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 28:0 : ;
;   x                                1469:22 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
;   x                                1478:22 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
;   x4                               0077:10 D:\data_www\pic\jalcc\jal++\libs\byte3_math.jal 
; 29:0 : ;
;   x3                               0077:13 D:\data_www\pic\jalcc\jal++\libs\byte3_math.jal 
; 2A:0 : ;
;    return value                    1472:10 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
;   x2                               0077:16 D:\data_www\pic\jalcc\jal++\libs\byte3_math.jal 
; 2B:0 : ;
;   x                                1473:10 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
;   x1                               0077:19 D:\data_www\pic\jalcc\jal++\libs\byte3_math.jal 
; 2C:0 : ;
;   haddr0                         * 0051:18 D:\data_www\pic\jalcc\jal++\libs\indf_bits.jal 
;   haddr                            0049:22 D:\data_www\pic\jalcc\jal++\libs\indf_bits.jal 
;   y4                               0078:10 D:\data_www\pic\jalcc\jal++\libs\byte3_math.jal 
; 2D:0 : ;
;   laddr                            0049:38 D:\data_www\pic\jalcc\jal++\libs\indf_bits.jal 
;   y3                               0078:13 D:\data_www\pic\jalcc\jal++\libs\byte3_math.jal 
; 2E:0 : ;
;   data                             0049:54 D:\data_www\pic\jalcc\jal++\libs\indf_bits.jal 
;   y2                               0078:16 D:\data_www\pic\jalcc\jal++\libs\byte3_math.jal 
; 2F:0 : ;
;   y1                               0078:19 D:\data_www\pic\jalcc\jal++\libs\byte3_math.jal 
; 30:0 : ;
;   _adcon0_shadow                   0092:19 D:\data_www\pic\jalcc\jal++\libs\pic_adc.jal 
; 31:0 : ;
;   _pic_adc_conversion_time         0093:19 D:\data_www\pic\jalcc\jal++\libs\pic_adc.jal 
; 32:0 : ;
;   x                                0035:10 d:\data_www\pic\jalcc\jal++\examples\motor_vraag.jal 
; 33:0 : ;
;   n                                0036:10 d:\data_www\pic\jalcc\jal++\examples\motor_vraag.jal 
; 34:0 : ;
;   p                                0037:10 d:\data_www\pic\jalcc\jal++\examples\motor_vraag.jal 
; 35:0 : ;
;   nultime                          0038:10 d:\data_www\pic\jalcc\jal++\examples\motor_vraag.jal 
; 36:0 : ;
;   x                                1496:23 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
;   n                                0311:23 D:\data_www\pic\jalcc\jal++\libs\delay_20mc.jal 
;   x                                0289:28 D:\data_www\pic\jalcc\jal++\libs\rs232_hw.jal 
;   n                                0260:23 D:\data_www\pic\jalcc\jal++\libs\byte3_math.jal 
;   pic_adc_chan                     0101:04 D:\data_www\pic\jalcc\jal++\libs\pic_adc.jal 
; 37:0 : ;
;   haddr0                         * 0061:18 D:\data_www\pic\jalcc\jal++\libs\indf_bits.jal 
;   haddr                            0059:22 D:\data_www\pic\jalcc\jal++\libs\indf_bits.jal 
;   counter1                         0312:10 D:\data_www\pic\jalcc\jal++\libs\delay_20mc.jal 
;   pic_adc_byte                     0101:26 D:\data_www\pic\jalcc\jal++\libs\pic_adc.jal 
; 38:0 : ;
;   laddr                            0059:38 D:\data_www\pic\jalcc\jal++\libs\indf_bits.jal 
;   counter2                         0313:10 D:\data_www\pic\jalcc\jal++\libs\delay_20mc.jal 
;   sq_temp_15900                    
; 39:0 : ;
;   a                                0039:18 D:\data_www\pic\jalcc\jal++\libs\jrtl.jal 
;   data                             0059:54 D:\data_www\pic\jalcc\jal++\libs\indf_bits.jal 
;   n                                0255:23 D:\data_www\pic\jalcc\jal++\libs\delay_20mc.jal 
;   _loop_temp_12914                 0314:03 D:\data_www\pic\jalcc\jal++\libs\delay_20mc.jal 
; 3A:0 : ;
;   n                                0039:29 D:\data_www\pic\jalcc\jal++\libs\jrtl.jal 
;   counter1                         0256:10 D:\data_www\pic\jalcc\jal++\libs\delay_20mc.jal 
; 3B:0 : ;
;    return value                    0039:13 D:\data_www\pic\jalcc\jal++\libs\jrtl.jal 
;   counter2                         0257:10 D:\data_www\pic\jalcc\jal++\libs\delay_20mc.jal 
; 8C:0 : ;
;   _pie1                          * 0152:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 

