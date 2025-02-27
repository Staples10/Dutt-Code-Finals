'<ADbasic Header, Headerversion 001.001>
' Process_Number                 = 2
' Initial_Processdelay           = 151515
' Eventsource                    = Timer
' Control_long_Delays_for_Stop   = No
' Priority                       = High
' Version                        = 1
' ADbasic_Version                = 6.3.0
' Optimize                       = Yes
' Optimize_Level                 = 1
' Stacksize                      = 1000
' Info_Last_Save                 = DUTTLAB8  Duttlab8\Duttlab
'<Header End>
'This script uses counter 1 on the ADwin in combination
'with a waveform on the MCL NanoDrive. 

#Include ADwinGoldII.inc
DIM Data_1[1000] AS LONG    'Array to store count data
DIM index AS LONG

init:
  Cnt_Enable(0)   'disables/stops counting on counter 1
  Cnt_Clear(1)    'sets counter 1 to zero
  Cnt_Mode(1,8)   'sets counter 1 to increment on falling edge; equivalent to Cnt_Mode(1,1000b)
  Cnt_Enable(1)   'enables counting on counter 1
  index = 0       
  
event:
  'Reads counter, puts data in array, then clears counter and increments index         
  IF (index>0) THEN
    Data_1[index] = Cnt_Read(1)
  ENDIF
  Cnt_Clear(1)
  Inc(index)
  
  
finish:
  Cnt_Enable(0)
