; compiler          : jal 0.4.60
; date              : 16-Feb-2005 00:51:31
; main source       : blink_demo
; command line      : -casz -vz -orsctd -sD:\data_www\pic\jalcc\jal++\libs d:\data_www\pic\jalcc\jal++\examples\blink_demo.jal 
; target  chip      : 16f876
;         cpu       : pic 14
;         clock     : 20000000
; input   files     : 7
;         lines     : 2219
;         chars     : 62476
; compilation nodes : 13396
;             stack : 28Kb
;              heap : 4123Kb
;           seconds : 0.296 (7496 lines/second)
; output       code :  122
;              page :    0 (0.0%)
;              bank :    0 (0.0%)
;         page+bank :    0 (0.0%)
;              file :   12
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

;; 242 : var volatile bit  pin_c3 at PORTC : 3
; var H'007:003' pin_c3

;; 275 : var volatile bit  IRP    at STATUS : 7
; var H'003:007' irp

;; 276 : var volatile bit  RP1    at STATUS : 6
; var H'003:006' rp1

;; 277 : var volatile bit  RP0    at STATUS : 5
; var H'003:005' rp0

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

;; 007 : var volatile bit  LED_pin       is pin_C3
; var H'007:003' led_pin

;; 013 : LED_direction = output
  bcf     H'023',3
  bcf     H'00A',3
  bcf     H'00A',4
  call    _6441__vector

;; 016 : forever loop
w_13081_ag: ; 001A

;; 017 :   LED_pin = ! LED_pin  ; toggle the LED
  bcf     H'026',3
  bcf     H'00A',3
  bcf     H'00A',4
  btfsc   H'007',3
  goto    ass_13123_f
ass_13123_t: ; 001F
  bsf     H'026',3
ass_13123_f: ; 0020
  bcf     H'00A',3
  bcf     H'00A',4
  call    _9405__vector

;; 018 :   delay_100ms(5)       ; wait half a period
  movlw   H'05'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _12953__vector
  bcf     H'00A',3
  bcf     H'00A',4
  goto    w_13081_ag

;; 003 :   idle_loop: page goto idle_loop
as_13084_idle_loop: ; 002A
  bcf     H'00A',3
  bcf     H'00A',4
  goto    as_13084_idle_loop
_12953__vector: ; 002D

;; 336 : procedure delay_100ms ( byte in N = 1 ) is
; var H'027:000' n
p_12953_delay_100ms: ; 002D
  movwf   H'027'

;; 337 : var byte counter0
; var H'028:000' counter0

;; 338 : var byte counter1
; var H'029:000' counter1

;; 339 : var byte counter2
; var H'02A:000' counter2

;; 340 :   for N loop
; var H'02B:000' _loop_temp_12979
  movf    H'027',w
  movwf   H'02B'
w_13110_ag: ; 0030
  movf    H'02B',f
  bcf     H'00A',3
  bcf     H'00A',4
  btfss   H'003',2
  goto    w_13110_bo
w_13110_jb: ; 0035
  bcf     H'00A',3
  bcf     H'00A',4
  goto    w_13110_be
w_13110_bo: ; 0038

;; 341 :       counter0 = 3
  movlw   H'03'
  movwf   H'028'

;; 342 :       counter1 = 130
  movlw   H'82'
  movwf   H'029'

;; 343 :       counter2 = 0
  clrf    H'02A'

;; 345 :       local delay
; const H'03F' delay

;; 346 :       page delay
  bcf     H'00A',3
  bcf     H'00A',4

;; 347 :       delay:
as_13002_delay: ; 003F

;; 348 :         decfsz    counter2,f  ;(1)
  decfsz  H'02A',f

;; 349 :         goto      delay       ;(2)
  goto    as_13002_delay

;; 350 :         decfsz    counter1,f  ;(1)
  decfsz  H'029',f

;; 351 :         goto      delay       ;(2)
  goto    as_13002_delay

;; 352 :         decfsz    counter0,f  ;(1)
  decfsz  H'028',f

;; 353 :         goto      delay       ;(2)
  goto    as_13002_delay

  decf    H'02B',f
  bcf     H'00A',3
  bcf     H'00A',4
  goto    w_13110_ag
w_13110_be: ; 0049
e_12953_delay_100ms: ; 0049
  return  

;; 1256 : procedure pin_c3'put( bit in x at _port_c_buffer : 3 ) is
p_9405__pin_c3__put_t: ; 004A
_9405__vector: ; 004A
; var H'026:003' x
p_9405_put: ; 004A

;; 1257 :   _port_c_flush
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _7730__vector
e_9405_put: ; 004D
_7730__vector: ; 004D
p_7730__port_c_flush: ; 004D

;; 1051 :   var volatile byte port_c at 0x07 = _port_c_buffer
; var H'007:000' port_c
  movf    H'026',w
  movwf   H'007'
e_7730__port_c_flush: ; 004F
  return  

;; 843 : procedure pin_c3_direction'put( bit in d at trisc_shadow : 3 ) is
p_6441__pin_c3_direction__put_t: ; 0050
_6441__vector: ; 0050
; var H'023:003' d
p_6441_put: ; 0050

;; 844 :    _trisc_flush
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _5408__vector
e_6441_put: ; 0053
_5408__vector: ; 0053
p_5408__trisc_flush: ; 0053

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
e_5408__trisc_flush: ; 005B
_5192__vector: ; 005B
p_5192_bank_1: ; 005B

;; 611 :   asm bsf STATUS, RP0
  bsf     H'003',5

;; 612 :   asm bcf STATUS, RP1
  bcf     H'003',6
e_5192_bank_1: ; 005D
  return  
_5173__vector: ; 005E
p_5173_bank_0: ; 005E

;; 598 :   asm bcf STATUS, RP0
  bcf     H'003',5

;; 599 :   asm bcf STATUS, RP1
  bcf     H'003',6
e_5173_bank_0: ; 0060
  return  

 END

; ********** variable mapping
; 00:0 : ;
;   indf                           * 0022:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 03:0 : ;
;   status                         * 0034:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 03:5 : ;
;   rp0                            * 0277:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 03:6 : ;
;   rp1                            * 0276:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 03:7 : ;
;   irp                            * 0275:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 04:0 : ;
;   fsr                            * 0040:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 07:0 : ;
;   port_c                         * 1051:21 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
;   portc                          * 0052:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 07:3 : ;
;   led_pin                        * 0007:19 d:\data_www\pic\jalcc\jal++\examples\blink_demo.jal 
;   pin_c3                         * 0242:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 0B:0 : ;
;   intcon                         * 0064:19 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 20:0 : ;
;    transfer_byte                   
;    transfer_bit                    
; 21:0 : ;
;   trisa_shadow                     0653:10 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 22:0 : ;
;   trisb_shadow                     0654:10 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 23:0 : ;
;   trisc_shadow                     0655:10 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 23:3 : ;
;   d                              * 0843:33 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 24:0 : ;
;   trisd_shadow                     0656:10 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 25:0 : ;
;   trise_shadow                     0657:10 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 26:0 : ;
;   _port_c_buffer                   1038:10 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 26:3 : ;
;   x                              * 1256:23 D:\data_www\pic\jalcc\jal++\libs\16F877_inc.jal 
; 27:0 : ;
;   n                                0336:25 D:\data_www\pic\jalcc\jal++\libs\delay_20mc.jal 
; 28:0 : ;
;   counter0                         0337:10 D:\data_www\pic\jalcc\jal++\libs\delay_20mc.jal 
; 29:0 : ;
;   counter1                         0338:10 D:\data_www\pic\jalcc\jal++\libs\delay_20mc.jal 
; 2A:0 : ;
;   counter2                         0339:10 D:\data_www\pic\jalcc\jal++\libs\delay_20mc.jal 
; 2B:0 : ;
;   _loop_temp_12979                 0340:03 D:\data_www\pic\jalcc\jal++\libs\delay_20mc.jal 

