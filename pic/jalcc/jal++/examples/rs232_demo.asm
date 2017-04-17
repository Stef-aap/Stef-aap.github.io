; compiler          : jal 0.4.60
; date              : 01-Feb-2005 01:34:10
; main source       : rs232_demo
; command line      : -casz -vz -orsctd -sD:\data_www\pic\jalcc\examples\jal++\libs d:\data_www\pic\jalcc\examples\jal++\examples\rs232_demo.jal 
; target  chip      : 16f876
;         cpu       : pic 14
;         clock     : 20000000
; input   files     : 8
;         lines     : 2606
;         chars     : 75086
; compilation nodes : 14906
;             stack : 28Kb
;              heap : 4585Kb
;           seconds : 0.390 (6682 lines/second)
; output       code :  341
;              page :    0 (0.0%)
;              bank :    0 (0.0%)
;         page+bank :    0 (0.0%)
;              file :   14
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

;; 064 : var volatile byte INTCON      at 0x0B
; var H'00B:000' intcon

;; 070 : var volatile byte PIR1        at 0x0C
; var H'00C:000' pir1

;; 106 : var volatile byte RCSTA       at 0x18
; var H'018:000' rcsta

;; 109 : var volatile byte TXREG       at 0x19
; var H'019:000' txreg

;; 112 : var volatile byte RCREG       at 0x1A
; var H'01A:000' rcreg

;; 152 : var volatile byte _PIE1       at 0x8C
; var H'08C:000' _pie1

;; 275 : var volatile bit  IRP    at STATUS : 7
; var H'003:007' irp

;; 301 : var volatile bit  RCIF   at PIR1 : 5
; var H'00C:005' rcif

;; 302 : var volatile bit  TXIF   at PIR1 : 4
; var H'00C:004' txif

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

;; 1561 : INTCON = 0
  clrf    H'00B'

;; 377 :   asynch_init_hw
  bcf     H'00A',3
  bcf     H'00A',4
  call    _13612__vector

;; 017 : var byte character
; var H'027:000' character

;; 018 : forever loop
w_13974_ag: ; 0019

;; 020 :   if asynch_read_hw (character) then
  bcf     H'00A',3
  bcf     H'00A',4
  call    _13715__vector
  movf    H'028',w
  movwf   H'027'
  bcf     H'00A',3
  bcf     H'00A',4
  btfss   H'020',2
  goto    if_13945_by
if_13945_th: ; 0022

;; 021 :     asynch_send_hw (character + 1)
  movf    H'027',w
  addlw   H'01'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _13687__vector
if_13945_by: ; 0027
  bcf     H'00A',3
  bcf     H'00A',4
  goto    w_13974_ag

;; 003 :   idle_loop: page goto idle_loop
as_13977_idle_loop: ; 002A
  bcf     H'00A',3
  bcf     H'00A',4
  goto    as_13977_idle_loop
_13715__vector: ; 002D

;; 303 : function asynch_read_hw ( byte out x ) return bit is
; var H'028:000' x
p_13715_asynch_read_hw: ; 002D
; var H'020:002'  return value
  movwf   H'028'

;; 304 : var bit result
; var H'020:003' result
  bcf     H'00A',3
  bcf     H'00A',4

;; 308 :   if RCIF then
  btfss   H'00C',5
  goto    if_13735_el
if_13735_th: ; 0032

;; 309 :     x = RCREG
  movf    H'01A',w
  movwf   H'028'

;; 310 :     result = true
  bsf     H'020',3
  bcf     H'00A',3
  bcf     H'00A',4
  goto    if_13735_by
if_13735_el: ; 0038

;; 312 :     result = false
  bcf     H'020',3
if_13735_by: ; 0039

;; 317 :   if ( RCSTA & 0b_0000_0010 ) > 0 then
  movf    H'018',w
  andlw   H'02'
  sublw   H'00'
  bcf     H'00A',3
  bcf     H'00A',4
  btfsc   H'003',0
  goto    if_13756_by
if_13756_th: ; 0040

;; 318 :     RCSTA = RCSTA & ( ! 0x10)
  movlw   H'FFFFFFEF'
  andwf   H'018',f

;; 319 :     RCSTA = RCSTA | (0x10)
  movlw   H'10'
  iorwf   H'018',f
if_13756_by: ; 0044

;; 322 :   return result
  bcf     H'020',2
  bcf     H'00A',3
  bcf     H'00A',4
  btfss   H'020',3
  goto    ass_13790_f
ass_13790_t: ; 0049
  bsf     H'020',2
ass_13790_f: ; 004A
e_13715_asynch_read_hw: ; 004A
  return  
_13687__vector: ; 004B

;; 289 : procedure asynch_send_hw ( byte in x ) is
; var H'028:000' x
p_13687_asynch_send_hw: ; 004B
  movwf   H'028'

;; 291 :   while ! TXIF loop end loop
w_13704_ag: ; 004C
  bcf     H'00A',3
  bcf     H'00A',4
  btfsc   H'00C',4
  goto    w_13704_be
w_13704_bo: ; 0050
  bcf     H'00A',3
  bcf     H'00A',4
  goto    w_13704_ag
w_13704_be: ; 0053

;; 294 :   TXREG = x
  movf    H'028',w
  movwf   H'019'
e_13687_asynch_send_hw: ; 0055
  return  
_13612__vector: ; 0056
p_13612_asynch_init_hw: ; 0056

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
  call    _13052__vector

;; 255 :   RCSTA = 0x80
  movlw   H'80'
  movwf   H'018'

;; 258 :   RCSTA = RCSTA | 0x10
  movlw   H'10'
  iorwf   H'018',f
e_13612_asynch_init_hw: ; 0065
  return  
_13052__vector: ; 0066
p_13052__calculate_and_set_baudrate: ; 0066

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
  goto    if_13364_el
if_13364_th: ; 006F

;; 136 :       TXSTA = TXSTA | _b_BRGH         -- set baudrate-high flag
  bcf     H'00A',3
  bcf     H'00A',4
  call    _11520__vector
  movf    H'029',w
  iorlw   H'04'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _11473__vector
  bcf     H'00A',3
  bcf     H'00A',4
  goto    if_13364_by
if_13364_el: ; 007A

;; 138 :       TXSTA = TXSTA & ! ( _b_BRGH )   -- clear baudarte-high flag
  bcf     H'00A',3
  bcf     H'00A',4
  call    _11520__vector
  movf    H'029',w
  andlw   H'FFFFFFFB'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _11473__vector
if_13364_by: ; 0082
e_13052__calculate_and_set_baudrate: ; 0082
  return  

;; 1478 : procedure SPBRG'put( byte in x ) is
p_11566__spbrg__put_t: ; 0083
_11566__vector: ; 0083
; var H'027:000' x
p_11566_put: ; 0083
  movwf   H'027'

;; 1479 :   _file_put( high_SPBRG, low_SPBRG, x )
  clrf    H'028'
  movlw   H'99'
  movwf   H'029'
  movf    H'027',w
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _9928__vector
e_11566_put: ; 008B
_11520__vector: ; 008B
p_11520_get: ; 008B

;; 1472 : function TXSTA'get return byte is
; var H'029:000'  return value

;; 1473 : var byte x
; var H'02A:000' x

;; 1474 :   _file_get( high_TXSTA, low_TXSTA, x )
  clrf    H'02B'
  movlw   H'98'
  movwf   H'02C'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _9872__vector
  movf    H'02D',w
  movwf   H'02A'

;; 1475 :   return x
  movf    H'02A',w
  movwf   H'029'
e_11520_get: ; 0095
  return  

;; 1469 : procedure TXSTA'put( byte in x ) is
p_11473__txsta__put_t: ; 0096
_11473__vector: ; 0096
; var H'027:000' x
p_11473_put: ; 0096
  movwf   H'027'

;; 1470 :   _file_put( high_TXSTA, low_TXSTA, x )
  clrf    H'028'
  movlw   H'98'
  movwf   H'029'
  movf    H'027',w
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _9928__vector
e_11473_put: ; 009E
_9928__vector: ; 009E

;; 059 : procedure _file_put( byte in Haddr , byte in Laddr , byte in data ) is begin 
; var H'028:000' haddr
; var H'029:000' laddr
; var H'02A:000' data
p_9928__file_put: ; 009E
  movwf   H'02A'

;; 060 : var volatile bit local_irp
; var H'020:002' local_irp

;; 061 : var volatile bit HAddr0 at Haddr : 0
; var H'028:000' haddr0
  bcf     H'00A',3
  bcf     H'00A',4

;; 062 :    local_irp = IRP
  btfss   H'003',7
  goto    ass_9961_f
ass_9961_t: ; 00A3
  bsf     H'020',2
  bcf     H'00A',3
  bcf     H'00A',4
  goto    ass_9961_b
ass_9961_f: ; 00A7
  bcf     H'020',2
ass_9961_b: ; 00A8
  bcf     H'00A',3
  bcf     H'00A',4

;; 063 :    IRP = HAddr0
  btfss   H'028',0
  goto    ass_9965_f
ass_9965_t: ; 00AC
  bsf     H'003',7
  bcf     H'00A',3
  bcf     H'00A',4
  goto    ass_9965_b
ass_9965_f: ; 00B0
  bcf     H'003',7
ass_9965_b: ; 00B1

;; 064 :    fsr = Laddr
  movf    H'029',w
  movwf   H'004'

;; 065 :    INDF = data
  movf    H'02A',w
  movwf   H'000'
  bcf     H'00A',3
  bcf     H'00A',4

;; 066 :    IRP = local_irp
  btfss   H'020',2
  goto    ass_9977_f
ass_9977_t: ; 00B9
  bsf     H'003',7
  bcf     H'00A',3
  bcf     H'00A',4
  goto    ass_9977_b
ass_9977_f: ; 00BD
  bcf     H'003',7
ass_9977_b: ; 00BE
e_9928__file_put: ; 00BE
  return  
_9872__vector: ; 00BF

;; 049 : procedure _file_get( byte in Haddr , byte in Laddr , byte out data ) is begin 
; var H'02B:000' haddr
; var H'02C:000' laddr
; var H'02D:000' data
p_9872__file_get: ; 00BF
  movwf   H'02D'

;; 050 : var volatile bit local_irp
; var H'020:002' local_irp

;; 051 : var volatile bit HAddr0 at Haddr : 0
; var H'02B:000' haddr0
  bcf     H'00A',3
  bcf     H'00A',4

;; 052 :    local_irp = IRP
  btfss   H'003',7
  goto    ass_9905_f
ass_9905_t: ; 00C4
  bsf     H'020',2
  bcf     H'00A',3
  bcf     H'00A',4
  goto    ass_9905_b
ass_9905_f: ; 00C8
  bcf     H'020',2
ass_9905_b: ; 00C9
  bcf     H'00A',3
  bcf     H'00A',4

;; 053 :    IRP = HAddr0
  btfss   H'02B',0
  goto    ass_9909_f
ass_9909_t: ; 00CD
  bsf     H'003',7
  bcf     H'00A',3
  bcf     H'00A',4
  goto    ass_9909_b
ass_9909_f: ; 00D1
  bcf     H'003',7
ass_9909_b: ; 00D2

;; 054 :    fsr = Laddr
  movf    H'02C',w
  movwf   H'004'

;; 055 :    data = INDF
  movf    H'000',w
  movwf   H'02D'
  bcf     H'00A',3
  bcf     H'00A',4

;; 056 :    IRP = local_irp
  btfss   H'020',2
  goto    ass_9921_f
ass_9921_t: ; 00DA
  bsf     H'003',7
  bcf     H'00A',3
  bcf     H'00A',4
  goto    ass_9921_b
ass_9921_f: ; 00DE
  bcf     H'003',7
ass_9921_b: ; 00DF
e_9872__file_get: ; 00DF
  return  

 END

; ********** variable mapping
; 00:0 : ;
;   indf                           * 0022:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 03:0 : ;
;   status                         * 0034:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 03:7 : ;
;   irp                            * 0275:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 04:0 : ;
;   fsr                            * 0040:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 0B:0 : ;
;   intcon                         * 0064:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 0C:0 : ;
;   pir1                           * 0070:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 0C:4 : ;
;   txif                           * 0302:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 0C:5 : ;
;   rcif                           * 0301:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 18:0 : ;
;   rcsta                          * 0106:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 19:0 : ;
;   txreg                          * 0109:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 1A:0 : ;
;   rcreg                          * 0112:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 20:0 : ;
;    transfer_bit                    
; 20:1 : ;
;   baudrate_high                    0081:11 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_hw.jal 
; 20:2 : ;
;   local_irp                        0050:18 D:\data_www\pic\jalcc\examples\jal++\libs\indf_bits.jal 
;   local_irp                        0060:18 D:\data_www\pic\jalcc\examples\jal++\libs\indf_bits.jal 
;    return value                    0303:10 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_hw.jal 
; 20:3 : ;
;   result                           0304:09 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_hw.jal 
; 21:0 : ;
;    transfer_byte                   
; 22:0 : ;
;   trisa_shadow                     0653:10 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 23:0 : ;
;   trisb_shadow                     0654:10 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 24:0 : ;
;   trisc_shadow                     0655:10 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 25:0 : ;
;   trisd_shadow                     0656:10 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 26:0 : ;
;   trise_shadow                     0657:10 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 27:0 : ;
;   x                                1469:22 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
;   x                                1478:22 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
;   character                        0017:10 d:\data_www\pic\jalcc\examples\jal++\examples\rs232_demo.jal 
; 28:0 : ;
;   haddr0                         * 0061:18 D:\data_www\pic\jalcc\examples\jal++\libs\indf_bits.jal 
;   haddr                            0059:22 D:\data_www\pic\jalcc\examples\jal++\libs\indf_bits.jal 
;   x                                0289:28 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_hw.jal 
;   x                                0303:27 D:\data_www\pic\jalcc\examples\jal++\libs\rs232_hw.jal 
; 29:0 : ;
;   laddr                            0059:38 D:\data_www\pic\jalcc\examples\jal++\libs\indf_bits.jal 
;    return value                    1472:10 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 2A:0 : ;
;   data                             0059:54 D:\data_www\pic\jalcc\examples\jal++\libs\indf_bits.jal 
;   x                                1473:10 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 
; 2B:0 : ;
;   haddr0                         * 0051:18 D:\data_www\pic\jalcc\examples\jal++\libs\indf_bits.jal 
;   haddr                            0049:22 D:\data_www\pic\jalcc\examples\jal++\libs\indf_bits.jal 
; 2C:0 : ;
;   laddr                            0049:38 D:\data_www\pic\jalcc\examples\jal++\libs\indf_bits.jal 
; 2D:0 : ;
;   data                             0049:54 D:\data_www\pic\jalcc\examples\jal++\libs\indf_bits.jal 
; 8C:0 : ;
;   _pie1                          * 0152:19 D:\data_www\pic\jalcc\examples\jal++\libs\16F877_inc.jal 

