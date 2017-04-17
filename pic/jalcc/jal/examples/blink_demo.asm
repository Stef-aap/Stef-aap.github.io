; compiler          : jal 0.4.59
; date              : 15-Feb-2005 23:04:19
; main source       : blink_demo
; command line      : -casz -vz -orsctd -sD:\PIC-tools\JAL\lib d:\data_www\pic\jalcc\jal\examples\blink_demo.jal 
; target  chip      : 16f876
;         cpu       : pic 14
;         clock     : 20000000
; input   files     : 6
;         lines     : 1535
;         chars     : 39872
; compilation nodes : 10095
;             stack : 18Kb
;              heap : 2499Kb
;           seconds : 0.109 (14082 lines/second)
; output       code :  106
;              page :    0 (0.0%)
;              bank :    0 (0.0%)
;         page+bank :    0 (0.0%)
;              file :   12
;              stack:    2 (2,0,0)

 errorlevel -306
 list p=PIC16f876

; note: the f876 config is still fixed!
 __CONFIG H'3F72' 
 ORG 0000
  goto    __main
 ORG 0004
 ORG 0004
__interrupt: ; 0004
__main: ; 0004
; var H'020:000'  transfer_bit
; var H'020:000'  transfer_byte

;; 044 : var volatile byte port_c       at  7
; var H'007:000' port_c

;; 105 : var volatile bit  pin_c3 at port_c : 3
; var H'007:003' pin_c3

;; 276 : var byte trisa
; var H'021:000' trisa

;; 277 : var byte trisb
; var H'022:000' trisb

;; 278 : var byte trisc
; var H'023:000' trisc

;; 284 : trisa = all_input
  movlw   H'FF'
  movwf   H'021'

;; 286 :    trisb = all_input
  movlw   H'FF'
  movwf   H'022'

;; 582 : var byte _port_c_buffer
; var H'024:000' _port_c_buffer

;; 015 : disable_a_d_functions
  bcf     H'00A',3
  bcf     H'00A',4
  call    _7757__vector

;; 006 : pin_C3_direction = output
  bcf     H'023',3
  bcf     H'00A',3
  bcf     H'00A',4
  call    _3858__vector

;; 007 : var bit LED is pin_C3
; var H'007:003' led

;; 010 : forever loop
w_9788_ag: ; 000F

;; 011 :   LED = ! LED      ; toggle the LED
  bcf     H'024',3
  bcf     H'00A',3
  bcf     H'00A',4
  btfsc   H'007',3
  goto    ass_9849_f
ass_9849_t: ; 0014
  bsf     H'024',3
ass_9849_f: ; 0015
  bcf     H'00A',3
  bcf     H'00A',4
  call    _6535__vector

;; 012 :   delay_100ms(5)   ; wait half a period
  movlw   H'05'
  bcf     H'00A',3
  bcf     H'00A',4
  call    _9483__vector
  bcf     H'00A',3
  bcf     H'00A',4
  goto    w_9788_ag

;; 003 :   idle_loop: page goto idle_loop
as_9791_idle_loop: ; 001F
  bcf     H'00A',3
  bcf     H'00A',4
  goto    as_9791_idle_loop
_9483__vector: ; 0022

;; 367 : procedure delay_100ms( byte in x = 1 ) is
; var H'025:000' x
p_9483_delay_100ms: ; 0022
  movwf   H'025'

;; 368 :    _delay_100us( x, 100, 10 )
  movf    H'025',w
  movwf   H'026'
  movlw   H'64'
  movwf   H'027'
  movlw   H'0A'
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _8774__vector
e_9483_delay_100ms: ; 002B
_8774__vector: ; 002B

;; 230 : procedure _delay_100us( byte in x, byte in y, byte in z ) is
; var H'026:000' x
; var H'027:000' y
; var H'028:000' z
p_8774__delay_100us: ; 002B
  movwf   H'028'

;; 284 :       var byte minus_one = -1
; var H'029:000' minus_one
  movlw   H'FFFFFFFF'
  movwf   H'029'

;; 286 :       var byte xx, yy
; var H'02A:000' xx
; var H'02B:000' yy

;; 290 :          local loop_x, loop_y, loop_z, loop_w
; const H'035' loop_w

;; 293 :       loop_z:
as_8992_loop_z: ; 002E

;; 296 :          movfw y
  movf    H'027',w

;; 297 :          movwf yy
  movwf   H'02B'

;; 298 :       loop_y:
as_8989_loop_y: ; 0030

;; 301 :          movfw x
  movf    H'026',w

;; 302 :          movwf xx
  movwf   H'02A'

;; 303 :       loop_x:
as_8986_loop_x: ; 0032

;; 305 :          movlw inner_iterations
  movlw   H'77'

;; 306 :          page loop_w
  bcf     H'00A',3
  bcf     H'00A',4

;; 307 :       loop_w:
as_8995_loop_w: ; 0035

;; 308 :          addwf minus_one, w
  addwf   H'029',w

;; 309 :          skpnc
  skpnc   

;; 310 :             goto loop_w
  goto    as_8995_loop_w

;; 312 :          page loop_x
  bcf     H'00A',3
  bcf     H'00A',4

;; 313 :          decfsz xx, f
  decfsz  H'02A',f

;; 314 :          goto loop_x
  goto    as_8986_loop_x

;; 316 :          page loop_y
  bcf     H'00A',3
  bcf     H'00A',4

;; 317 :          decfsz yy, f
  decfsz  H'02B',f

;; 318 :          goto loop_y
  goto    as_8989_loop_y

;; 320 :          page loop_z
  bcf     H'00A',3
  bcf     H'00A',4

;; 321 :          decfsz z, f
  decfsz  H'028',f

;; 322 :          goto loop_z
  goto    as_8992_loop_z
e_8774__delay_100us: ; 0044
  return  
_7757__vector: ; 0045
p_7757_disable_a_d_functions: ; 0045

;; 998 :  bank_1
  bcf     H'00A',3
  bcf     H'00A',4
  call    _2471__vector

;; 999 :  asm movlw 7
  movlw   H'07'

;; 1000 :  asm movwf 0x1F
  movwf   H'01F'

;; 1001 :  bank_0
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _2422__vector
e_7757_disable_a_d_functions: ; 004D

;; 735 : procedure pin_c3'put( bit in x at _port_c_buffer : 3 ) is
p_6535__pin_c3__put_t: ; 004D
_6535__vector: ; 004D
; var H'024:003' x
p_6535_put: ; 004D

;; 736 :    _port_c_flush
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _5234__vector
e_6535_put: ; 0050
_5234__vector: ; 0050
p_5234__port_c_flush: ; 0050

;; 593 :    var volatile byte port_c at 7 = _port_c_buffer
; var H'007:000' port_c
  movf    H'024',w
  movwf   H'007'
e_5234__port_c_flush: ; 0052
  return  

;; 432 : procedure pin_c3_direction'put( bit in d at trisc : 3 ) is
p_3858__pin_c3_direction__put_t: ; 0053
_3858__vector: ; 0053
; var H'023:003' d
p_3858_put: ; 0053

;; 433 :    _trisc_flush
  bcf     H'00A',3
  bcf     H'00A',4
  goto    _2936__vector
e_3858_put: ; 0056
_2936__vector: ; 0056
p_2936__trisc_flush: ; 0056

;; 312 :       bank movfw trisc
  movf    H'023',w

;; 313 :            tris  7
  tris    H'007'
e_2936__trisc_flush: ; 0058
  return  
_2471__vector: ; 0059
p_2471_bank_1: ; 0059
e_2471_bank_1: ; 0059
  return  
_2422__vector: ; 005A
p_2422_bank_0: ; 005A
e_2422_bank_0: ; 005A
  return  

 END

; ********** variable mapping
; 07:0 : ;
;   port_c                         * 0593:22 D:\PIC-tools\JAL\lib\jpic.jal 
;   port_c                         * 0044:19 D:\PIC-tools\JAL\lib\jpic.jal 
; 07:3 : ;
;   led                            * 0007:09 d:\data_www\pic\jalcc\jal\examples\blink_demo.jal 
;   pin_c3                         * 0105:19 D:\PIC-tools\JAL\lib\jpic.jal 
; 20:0 : ;
;    transfer_byte                   
;    transfer_bit                    
; 21:0 : ;
;   trisa                            0276:10 D:\PIC-tools\JAL\lib\jpic.jal 
; 22:0 : ;
;   trisb                            0277:10 D:\PIC-tools\JAL\lib\jpic.jal 
; 23:0 : ;
;   trisc                            0278:10 D:\PIC-tools\JAL\lib\jpic.jal 
; 23:3 : ;
;   d                              * 0432:33 D:\PIC-tools\JAL\lib\jpic.jal 
; 24:0 : ;
;   _port_c_buffer                   0582:10 D:\PIC-tools\JAL\lib\jpic.jal 
; 24:3 : ;
;   x                              * 0735:23 D:\PIC-tools\JAL\lib\jpic.jal 
; 25:0 : ;
;   x                                0367:24 D:\PIC-tools\JAL\lib\jdelay.jal 
; 26:0 : ;
;   x                                0230:25 D:\PIC-tools\JAL\lib\jdelay.jal 
; 27:0 : ;
;   y                                0230:36 D:\PIC-tools\JAL\lib\jdelay.jal 
; 28:0 : ;
;   z                                0230:47 D:\PIC-tools\JAL\lib\jdelay.jal 
; 29:0 : ;
;   minus_one                        0284:16 D:\PIC-tools\JAL\lib\jdelay.jal 
; 2A:0 : ;
;   xx                               0286:16 D:\PIC-tools\JAL\lib\jdelay.jal 
; 2B:0 : ;
;   yy                               0286:20 D:\PIC-tools\JAL\lib\jdelay.jal 

