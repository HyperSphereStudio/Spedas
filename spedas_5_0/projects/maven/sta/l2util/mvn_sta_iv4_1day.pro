;+
;NAME:
;mvn_sta_iv4_1day
;PURPOSE:
;reads in a start and end date, and reprocesses all of the days in
;the interval. This is a main program, designed to be called from a
;shell script. Processes 1 day at a time
;CALLING SEQUENCE:
; .run mvn_sta_iv4_1day
;INPUT:
;start_time, end_time are input from files
;mvn_sta_iv4_1day_start_time.txt and
;mvn_sta_iv4_1day_end_time.txt.
;OUTPUT:
; Temporary Maven STA L2 files, round 1 of background creation
;HISTORY:
; 2020-10-19, jmm, jimm@ssl.berkeley.edu
;-
this_file = 'mvn_sta_iv4_1day'
spawn, 'touch '+this_file+'_lock'
;Apparently you cannot compile code in the way we're calling this, so
st_file = this_file+'_start_time.txt'
st_time = strarr(1)
openr, unit, st_file, /get_lun
readf, unit, st_time
free_lun, unit
tstart = time_double(st_time[0])
en_file = this_file+'_end_time.txt'
en_time = strarr(1)
;process days
openr, unit, en_file, /get_lun
readf, unit, en_time
free_lun, unit
tend = time_double(en_time[0])
If(tstart Ge tend) Then exit
;do the process one day at a time, in the local working directory
mvn_sta_l2gen, date = time_string(tstart), temp_dir = './', iv_level = 4
;Add a day and reset start time file
tstart_new = tstart+86400.0d0
openw, unit, this_file+'_start_time.txt', /get_lun
printf, unit, time_string(tstart_new)
free_lun, unit
;All done
spawn, '/bin/rm '+this_file+'_lock'
exit

