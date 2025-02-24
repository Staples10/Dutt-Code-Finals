'<ADbasic Header, Headerversion 001.001>
' Process_Number                 = 2
' Initial_Processdelay           = 30000
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
'This script uses the automatic check every 10ns on the digital inputs and
'triggers counting on counter 1 if it detects a falling edge on ANY channel 

#Include ADwinGoldII.inc

DIM index AS LONG
DIM Data_1[1000] AS LONG
'DIM Data_2[1000] AS LONG
'DIM Data_3[1000] AS LONG
DIM Data_10[1000] AS LONG

init:
  Conf_DIO(1100b) 'Configures digital pins 0-15 as inputs and 16-31 as outputs
  Digin_FIFO_Enable(0) 'stops/disables monitoring of digin channels
  Digin_FIFO_Clear()
  Digin_FIFO_Enable(1) 'sets to monitor digin channel 0
  
  Cnt_Enable(00b)   'disables/stops counting on counter 1 & 2
  Cnt_Clear(11b)    'sets counter 1 & 2 to zero
  Cnt_Mode(1,8)   'sets counter 1 to increment on falling edge; equivalent to Cnt_Mode(1,1000b)
  Cnt_Mode(2,8)   'sets counter 1 to increment on falling edge; equivalent to Cnt_Mode(2,1000b)
  Cnt_Enable(11b)   'enables counting on counter 1 & 2
  index = 0
  Par_1 = 0
  Par_8 = Digin_FIFO_Read_Timer()    'reads current staus of 100MHz timmer
  'Par_3 = 6000
  'Par_9 = 0 
  'Par_10 = 0

event:
  Par_1 = Digin_Edge(1)   'Bit string where each bit corresponds to if the channel saw a rising edge
  Data_10[index] = Par_1          'Checks what value Par_1 actually has
  'Par_9 = Digin_FIFO_Read_Timer()
  IF (Par_1 > 0) THEN
    Data_1[index] = Cnt_Read(1)   'Reads count data and stores in array
    Cnt_Clear(1)
    Inc(index) 
    Par_1 = 0
    'Par_10 = Digin_FIFO_Read_Timer()
  ENDIF
  'Par_2 = Cnt_Read(2)   'clock connected to clock and measures number of pulse from read waveform binding
  Par_3 = Digin_FIFO_Full()
  
finish:
  Cnt_Clear(11b)
  Cnt_Enable(00b)
  Digin_FIFO_Enable(0)

