;+
;procedure: thm_cal_fgm
;
;Purpose: applies calibration to THEMIS fluxgate magnetometer data
;
;         searches for the current calibration in ASCII file
;         takes calibration that has time stamp before or at the start of the data
;         converts data to nano Tessla
;         applies the calibration
;         corrects for phase shift from averaging before despinning
;
;keywords:
;  probe = Probe name. The default is 'all', i.e., calibrate data for all
;          available probes.
;          This can be an array of strings, e.g., ['a', 'b'] or a
;          single string delimited by spaces, e.g., 'a b'
;  datatype = The type of data to be loaded, 'fge', 'fgh', or 'fgl'. If  
;         name_thx_fgx_in,name_thx_fgx_hed, or name_thx_fgx_out,$
;         are specified, then this keyword is required.
;  in_suffix =  optional suffix to add to name of input data quantity, which
;          is generated from probe and datatype keywords.
;  out_suffix = optional suffix to add to name for output tplot quantity,
;          which is generated from probe and datatype keywords.
;  coord = apply thm_cotrans if output other
;          than spinning spacecraft (SSL) is desired.
;  cal_dac_offset = apply calibrations that remove digital analog
;                   converter nonlinearity by addition of offset.
;                   Algorithm generated by Dragos Constantine
;                   <d.constantinescu@tu-bs.de>. This is the default
;                   process as of 7-Jan-2010, to disable, explicitly
;                   set this keyword to 0.
;  cal_spin_harmonics = apply calibrations from a file that remove
;                       spin harmonics by applying spin-dependent
;                       offsets generated by David Fischer
;                       <david.fischer@oeaw.ac.at>. This is the default  
;                       process as of 7-Jan-2010, to disable, explicitly
;                       set this keyword to 0. 
;  cal_tone_removal = fitting algorithm removes orbit dependent
;                     spintone without removing scientifically salient
;                     features. Algorithm generated by Ferdinand Plaschke
;                     <f.plaschke@tu-bs.de>. This is the default  
;                     process as of 7-Jan-2010, to disable, explicitly
;                     set this keyword to 0. 
;  cal_get_fulloffset = returns the offset used for spintone removal.(this keyword used for valididation)
;                       Because there may be a different offset for each combination of probe and datatype, 
;                       This is returned as a struct of structs, with each element in the child structs being an N by 3 array.
;                       For example, if offset_struct is the name of a struct with the return value from the cal_get_fulloffset keyword,
;                         print,offset_struct.tha.fgl
;                       Will print the fulloffset for probe a and datatype fgl.
;  cal_get_dac_dat = Returns the raw data from directly after the DAC(non-linearity offset) calibration is applied.  For verification.
;  cal_get_spin_dat = Returns the raw data from directly after the spin harmonic(solar array current) calibration is applied.  For verification.
;  interpolate_cal = if it is set, then thm_cal values are interpolated to 10 min time intervals
;
;
; use_eclipse_corrections:  Only applies when loading and calibrating
;   Level 1 data. Defaults to 0 (no eclipse spin model corrections 
;   applied).  use_eclipse_corrections=1 applies partial eclipse 
;   corrections (not recommended, used only for internal SOC processing).  
;   use_eclipse_corrections=2 applies all available eclipse corrections.
; no_spin_tone_batch: As of 2015-11-10, the deafult is to split the
;    spin tone removal step into batches if the calibration parameters
;    change during the input time range. Setting /no_spin_tone_batch
;    turns this behavior off, and the full time range is used for spin
;    tone removal. Use this for short time intervals.
; cal_file_in: A full path to the calibration file, for testing. This
;              will only work for single probe proecessing
;optional parameters:
;
;         name_thx_fgx_in   --> input data (t-plot variable name)
;         name_thx_fgx_hed  --> header information for input data (t-plot variable name)
;         name_thx_fgx_out  --> name for output (t-plot variable name)
;         pathfile          --> path and filename of the calibration file
;
;keywords:
;Example:
;      tha_cal_fgm, probe = 'a', datatype= 'fgl'
;
;Notes: under construction!!
;
;Written by Hannes Schwarzl.
; $LastChangedBy: jwl $
; $LastChangedDate: 2016-12-20 16:18:08 -0800 (Tue, 20 Dec 2016) $
; $LastChangedRevision: 22467 $
; $URL: svn+ssh://thmsvn@ambrosia.ssl.berkeley.edu/repos/spdsoft/tags/spedas_5_0/projects/themis/spacecraft/fields/thm_cal_fgm.pro $
;Changes by Edita Georgescu
;eg 6/3/2007     - matrix multiplication
;eg 30/3/2007   - keyword deleted, fgmtype determined from: name_thx_fgx_in
;                - calibrates fgl,fgh,fge
;                - calibrate only mode=0 data
; 2007-03-30 Modified by Hannnes S to use multiple calibrations for a selected interval
;            and use spinperiod from the statefile
;            Search this string to see changes ;Hannes 30/3/2007
; 2007-03-30 Modified by Hannnes S correction for filter delay removed
;            Search this string to see changes: Hannes 05/21/2007
;-

pro thm_interpolate_cal_apply, thx_fgx, utcStr=utcStr, offi=offi, cali=cali, ncal=ncal
  ; interpolate the cal file parameter to 10-min intervals
  ; we use +- a week for a fit
  compile_opt idl2, hidden
  
  if (size(thx_fgx,/type) ne 8) then return 
  if (n_elements(thx_fgx.X) lt 2) then return 
  fit_interval = 10.0*60.0 ; ten minutes 
  fit_span = 7*24*3600.0  ; one week interpolation window
  
  utcd=time_double(utcStr)
  start_time=time_double(thx_fgx.X[0]) - fit_span
  end_time=time_double(thx_fgx.X[n_elements(thx_fgx.X)-1]) + fit_span
  
   ; there are cases where corrections are too sparse
  idx = where((utcd ge start_time) and (utcd le end_time), ct)
  if ct lt 1 then return
  if (idx[ct-1] lt (n_elements(utcd)-1)) then idx = [idx , idx[ct-1]+1]
  if (idx[0] gt 0) then idx = [idx[0]-1, idx]
  ct = n_elements(idx)
  
  start_time = utcd[idx[0]]
  end_time = utcd[idx[ct-1]]
  
  fit_count = floor((end_time-start_time)/fit_interval)+1
  fit_times = dblarr(fit_count)
  for i=0, fit_count-1 do begin
    fit_times[i] = start_time + fit_interval*i
  endfor

  ; now compute calibration values using interpolation
  new_offi_0 = INTERPOL(offi[idx,0], utcd[idx], fit_times)
  new_offi_1 = INTERPOL(offi[idx,1], utcd[idx], fit_times)
  new_offi_2 = INTERPOL(offi[idx,2], utcd[idx], fit_times)
  
  ncal = fit_count
  offi=dblarr(ncal,3)
  cali_new=dblarr(ncal,9)
  utcStr=strarr(ncal)  
  
  utcStr = time_string(fit_times)
  offi[*,0] = new_offi_0
  offi[*,1] = new_offi_1
  offi[*,2] = new_offi_2  
          
  m = MAKE_ARRAY(ct, 3, 3, /double)
  for k=0, ct-1 do begin
    for i=0,2 do begin
      for j=0,2 do begin
        m[k,j,i] = cali[idx[k],3*i+j]
      endfor
    endfor
  endfor
  q_in = mtoq(m)
  qi = qvalidate(q_in,'qi','qslerp')    
  if (qi[0] eq -1) then begin
    ; validation failed, use the previous value for each vector    
    for i=0, fit_count-1 do begin
      idc = max([0,where(utcd le fit_times[i])])
      cali_new[i,*] = cali[idc,*]
    endfor 
  endif else begin
    ;interpolate quaternions
    q_out = qslerp(q_in,utcd[idx],fit_times)
    ;turn quaternions back into matrices
    cali_out = qtom(q_out)
    for i=0,2 do begin
      for j=0,2 do begin
        cali_new[*,3*i+j] = cali_out[*,j,i]
      endfor
    endfor
  endelse     
  cali = dblarr(ncal,9) 
  cali = cali_new

  DPRINT, dlevel=4, 'Interpollation was applied for cal parameters.'

end


pro thm_cal_fgm,$
         probe=probe,$
         datatype=datatype,$
         in_suffix=in_suf,$
         out_suffix=out_suf,$
         coord=coord,$
         name_thx_fgx_in,$
         name_thx_fgx_hed,$
         name_thx_fgx_out,$
         pathfile,$
         interpolate_cal=interpolate_cal,$
         interpolate_state=interpolate_state,$
         cal_spin_harmonics=cal_spin_harmonics,$
         cal_dac_offset=cal_dac_offset,$
         cal_tone_removal=cal_tone_removal,$
         cal_get_fulloffset=cal_get_fulloffset,$
         cal_get_dac_dat=cal_get_dac_dat,$
         cal_get_spin_dat=cal_get_spin_dat,$
         use_eclipse_corrections=use_eclipse_corrections,$
         cal_file_in=cal_file_in, no_spin_tone_batch=no_spin_tone_batch, $
         _extra=_extra      
         ;eg 30/3/2007;Hannes 30/3/2007 ;kb


compile_opt idl2, hidden

if ~keyword_set(interpolate_cal) then interpolate_cal=0 else interpolate_cal=1

  ;; implement the 'standard' interface as a wrapper around the original
  ;; interface if no positional parameters are present.

if n_params() eq 0 then begin
   vprobes = ['a','b','c','d','e']
   vdatatypes = ['fgl', 'fgh', 'fge']
   if keyword_set(valid_names) then begin
      probe = vprobes
      datatypes = vdatatypes
      return
   endif
   if not keyword_set(probe) then probes = vprobes $
   else probes = ssl_check_valid_name(strlowcase(probe), vprobes, /include_all)
   if not keyword_set(probes) then return

   if not keyword_set(datatype) then dts = vdatatypes $
   else dts = ssl_check_valid_name(strlowcase(datatype), vdatatypes, $
                                         /include_all)
   if not keyword_set(dts) then return

   if not keyword_set(in_suf) then in_suf = ''
   if not keyword_set(out_suf) then out_suf = ''

   if arg_present(cal_get_fulloffset) then begin
     cal_get_fulloffset = 0
   endif

   for i = 0, n_elements(probes)-1 do begin
      thx = 'th' + probes[i]
      If(keyword_set(cal_file_in)) Then cal_file = cal_file_in Else Begin
         cal_relpathname = thx+'/l1/fgm/0000/'+thx+'_fgmcal.txt'
         cal_file = spd_download(remote_file=cal_relpathname, _extra=!themis)
      Endelse

      files = file_search(cal_file,count=fc)
      if fc eq 0 then begin
        dprint, dlevel=0, 'FGM cal file not found: '
        dprint, dlevel=0, cal_file
        dprint, dlevel=0, 'FGM data for probe '+probes[i]+' cannot be calibrated.'
        continue
      endif


      for j = 0, n_elements(dts)-1 do begin
         raw_name = 'th'+probes[i]+'_'+dts[j]+in_suf
         cal_name = 'th'+probes[i]+'_'+dts[j]+out_suf
         hed_name = 'th'+probes[i]+'_'+dts[j]+'_hed'

           if arg_present(cal_get_fulloffset) then begin
             fulloffset = 0
           endif
           
           if arg_present(cal_get_dac_dat) then begin
             dac_dat = 0
           endif 
           
           if arg_present(cal_get_spin_dat) then begin
             spin_dat = 0
           endif

           thm_cal_fgm, raw_name,$ 
                        hed_name,$
                        cal_name,$
                        cal_file,$
                        interpolate_cal=interpolate_cal,$
                        coord=coord,$
                        in_suffix=in_suf,$
                        out_suffix=out_suf,$
                        cal_spin_harmonics=cal_spin_harmonics,$
                        cal_dac_offset=cal_dac_offset,$
                        datatype=dts[j],$
                        cal_tone_removal=cal_tone_removal,$
                        cal_get_fulloffset=fulloffset,$
                        cal_get_dac_dat=dac_dat,$
                        cal_get_spin_dat=spin_dat,$
                        use_eclipse_corrections=use_eclipse_corrections,$
                        cal_file_in=cal_file_in, no_spin_tone_batch=no_spin_tone_batch,$
                        _extra=_extra      
     
           if arg_present(cal_get_fulloffset) && keyword_set(fulloffset) then begin  
             str_element,cal_get_fulloffset,thx+'.'+dts[j],fulloffset,/add
           endif
           
           if arg_present(cal_get_dac_dat) && keyword_set(dac_dat) then begin
             str_element,cal_get_dac_dat,thx+'.'+dts[j],dac_dat,/add
           endif 
           
           if arg_present(cal_get_spin_dat) && keyword_set(spin_dat) then begin
             str_element,cal_get_spin_dat,thx+'.'+dts[j],spin_dat,/add
           endif
          
      endfor
   endfor
   return
endif else if n_params() ne 4 then begin
   dprint, dlevel=1,  'usage: thm_cal_fgm, probe=probe, datatype=datatype $'
   dprint, dlevel=1,  '                    [, in_suffix=in_suf, out_suffix=out_suf]'
   dprint, dlevel=1,  'or: thm_cal_fgm, raw_name, hed_name, cal_name, cal_file]'
   return
endif

; what follows is exactly the original thm_cal_fgm, before 'standardization'
; (plus some metadata in dlimit.data_att) ;kb

; get the data using t-plot names
get_data,name_thx_fgx_in,data=thx_fgx_in,dl=thx_fgx_dl  ;kb
get_data,name_thx_fgx_hed,data=thx_fgx_hed

; kb

if size(thx_fgx_in,/type) ne 8 then begin
   dprint,  name_thx_fgx_in, " does not exist."
   return
endif

if size(thx_fgx_hed,/type) ne 8 then begin
   dprint,   name_thx_fgx_hed, " does not exist:  "
   dprint, "  Support data not found."
   return
endif

if thm_data_calibrated(thx_fgx_dl) then begin
   dprint, name_thx_fgx_in + " has already been calibrated."
   return
endif
; end kb

;Hannes 30/3/2007
;get the spinperiod from the state file, first check to see if the
;state data is loaded
probe_letter = strmid(name_thx_fgx_in, 2, 1)
if undefined(out_suf) then out_suf=''
thm_autoload_support, vname=name_thx_fgx_in, probe_in = probe_letter[0], /spinmodel, /spinaxis
preSpin=strmid(name_thx_fgx_in,0,4)
name_thx_spinper=preSpin+'state_spinper'
name_thx_spinphase=preSpin+'state_spinphase'
get_data, name_thx_spinper, data = thx_spinper
get_data, name_thx_spinphase, data = thx_spinphase 
;if ~is_struct(thx_spinper) || ~is_struct(thx_spinphase) then begin ;load the state data
;  thm_load_state, probe = probe_letter[0], /get_support_data, trange = minmax(thx_fgx_in.x)
;endif 

if keyword_set(interpolate_state) then begin
   DPRINT, dlevel=4, 'take spin period from state file ...'
   thx_spinper_interp=thm_interpolate_state(thx_xxx_in=thx_fgx_in,thx_spinper=thx_spinper) ;--> linear interpolation
   thx_spinphase_interp=thm_interpolate_state(thx_xxx_in=thx_fgx_in,thx_spinper=thx_spinphase) ;--> linear interpolation
   thx_spinphase_model = tha_spinphase_interp.y 
   ;end Hannes 30/3/2007
endif else begin
   DPRINT, dlevel=4, 'take spin period from spin model ...'
   spinmodel_ptr=spinmodel_get_ptr(probe_letter,use_eclipse_corrections=use_eclipse_corrections)
   if ~obj_valid(spinmodel_ptr) then begin
      message,'No valid state data'
   endif
       
   spinmodel_interp_t,model=spinmodel_ptr,time=thx_fgx_in.X,spinper=thx_spinper_model,spinphase=thx_spinphase_model,use_spinphase_correction=1
   spinmodel_get_info,model=spinmodel_ptr,shadow_start=shadow_start,shadow_end=shadow_stop,shadow_count=shadow_count
   
   if shadow_count gt 0 then begin
     shadow_struct = {start:shadow_start,stop:shadow_stop}
   endif
   ; thx_spinper_model is an array of interpolated spin periods, but the
   ; following code wants a tplot structure thx_spinper_interp
   thx_spinper_interp={X:thx_fgx_in.X, Y:thx_spinper_model}
   
endelse

; make STRUCTRE thx_fgx; converting egineering units from LONG to DOUBLE
thx_fgx = CREATE_STRUCT('X',thx_fgx_in.X , 'Y', DOUBLE(thx_fgx_in.Y))     ;, 'V', thx_fgx_in.V) -mattd,5/2

; scale factor
kr=2.980232238769531E-3   ;kr=25000.0/2^23 --> see *CALPROC*.doc
; fillvalue for output vector
;fillvalue=1.e-31
fillvalue=!values.f_nan ;Hannes 30/3/2007

; check input             ;eg 30/3/2007
fgt=['fgl','fgh','fge']
fgtype=strmid(name_thx_fgx_in,strpos(name_thx_fgx_in,'_fg')+1,3)
tm=where(fgtype eq fgt) & dprint, dlevel=4, name_thx_fgx_in
                           ;eg 30/3/2007

; get array sizes
count=SIZE(thx_fgx.X,/N_ELEMENTS)
countHed=SIZE(thx_fgx_HED.X,/N_ELEMENTS)

DPRINT, dlevel=4, 'get header information ...'

; get the information from the header
fgmhed=thx_fgx_HED.Y[*,12:15] ; store relevant header information

DPRINT, dlevel=4, 'get sampling frequencies ...'
; get fs [vector]   ;eg 30/3/2007
case tm of
 0 :  fs=float(2^(2+(fgmhed[*,3] and '111'B)))
 1 :  fs=replicate(128.0,countHed)
 2 :  fs=replicate(8.0,countHed)
endcase

DPRINT, dlevel=4, 'get filter-modes ...'
; get filtermode [vector]
if tm lt 2 then ff=ishft('F0'X and fgmhed[*,1],-6) else ff=replicate(0,countHed)

; get mode [vector] only mode=0 is science data and have to be calibrated   ;eg 30/3/2007
if tm lt 2 then mode=ishft(fgmhed[*,1] and '1100'B,-2) else mode=replicate(0,countHed)
;eg 30/3/2007

DPRINT, dlevel=4, 'done getting header information'

;read the calibration file

DPRINT, dlevel=4, 'read calibration file:'
DPRINT, dlevel=4, pathfile

;check for existence of cal file
files = file_search(pathfile,count=fc)
if fc eq 0 then begin
  dprint, dlevel=0, 'FGM cal file not found: '
  dprint, dlevel=0, pathfile
  dprint, dlevel=0, 'Calibration of '+name_thx_fgx_in+' canceled.'
  return
endif

ncal=file_lines(pathfile)
calstr=strarr(ncal)
openr, 2, pathfile
readf, 2, calstr
close, 2
ok_cal = where(calstr Ne '', ncal) ;jmm, 8-nov-2007, cal files have carriage returns at the end
calstr = calstr[ok_cal]

;define variables
spinperi=dblarr(ncal)
offi=dblarr(ncal,3)
cali=dblarr(ncal,9)
utci='2006-01-01T00:00:00.000Z'
utc=dblarr(ncal)
utcStr=strarr(ncal)

for i=0,ncal-1 DO BEGIN
    split_result = strsplit(calstr[i], COUNT=lct, /EXTRACT) 
    if lct ne 14 then begin
      msg = 'Error in FGM cal file. Line: ' + string(i) + ", File: " + pathfile
      dprint, dlevel=1, msg
      continue
    endif
    utci=split_result[0]
    offi[i,*]=split_result[1:3]
    cali[i,*]=split_result[4:12]
    spinperi[i]=split_result[13]
    utcStr[i]=utci
    ;translate time information
    STRPUT, utci, '/', 10
    utc[i]=time_double(utci)
ENDFOR
DPRINT, dlevel=4, 'done reading calibration file'


if (interpolate_cal eq 1) then begin
  thm_interpolate_cal_apply, thx_fgx, utcStr=utcStr, offi=offi, cali=cali, ncal=ncal
  utc=dblarr(ncal)
  utc=time_double(utcStr)
endif  

DPRINT, dlevel=4, 'search calibration for selected time interval ...'
calIndex=0
compTime=utc[0]
refTime=thx_fgx.X[0]
i=0
WHILE ((compTime lt reftime) && (i lt ncal-1)) DO BEGIN
    i=i+1
    compTime=utc[i]
    IF (compTime gt reftime) THEN BEGIN
       i=i-1
       BREAK
    ENDIF
ENDWHILE

;change  2007-03-29
istart=i
compTime=utc[i]
refTime=thx_fgx.X[count-1L]
;i=0
WHILE ((compTime lt reftime) && (i lt ncal-1)) DO BEGIN
    i=i+1
    compTime=utc[i]
    IF (compTime gt reftime) THEN BEGIN
       i=i-1
       BREAK
    ENDIF
ENDWHILE

istop=i

DPRINT, dlevel=4,  'Select calibrations from:'
if (interpolate_cal eq 1) then begin 
  DPRINT, dlevel=4,  'Start time: ' + utcStr[istart]
  DPRINT, dlevel=4,  'End time: ' + utcStr[istop]
  DPRINT, dlevel=4,  'Count: ' + string(istop-istart)
endif else begin
  FOR i=istart,istop DO BEGIN
    DPRINT, dlevel=4,  utcStr[i]
  ENDFOR
endelse

;DPRINT, 'offsets: ',TRANSPOSE(offs)
;DPRINT, 'cal matrix: '
;DPRINT, calm
;DPRINT, 'spin period: ',spinper


;DPRINT,  'Select calibration from:'
;DPRINT,  utcStr(i)

;offs=offi(i,*)
;calim=TRANSPOSE(cali(i,*))
;calm=[[calim[0:2]],[calim[3:5]],[calim[6:8]]]
;spinper=spinperi(i) Hannes 30/3/2007
;if abs(spinper-mean(tspin.y))/spinper gt 1.e-4 then spinper=mean(tspin.y)  ;eg 30/3/2007,Hannes 30/3/2007

;DPRINT, 'offsets: ',TRANSPOSE(offs)
;DPRINT, 'cal matrix: '
;DPRINT, calm
;DPRINT, 'spin period: ',spinper Hannes 30/3/2007




;end Hannes 30/3/2007

probe_letter=strmid(name_thx_fgx_in,2,1)

;This code block will remove DAC nonlinearity(Should only occur when data is at large magntitudes)
If(n_elements(cal_dac_offset) Eq 0 || cal_dac_offset[0] Ne 0) Then Begin ;jmm, 6-jan-2010
  dat = thx_fgx.y
  ; fgl frequency can be either 4.0 or 16.0 and is needed by thm_fgm_find_shift_1p1c 
  calc_freq = 4.0
  if (n_elements(thx_fgx.x) gt 2) then calc_freq = 1.0/(thx_fgx.x[1]-thx_fgx.x[0])
  thm_cal_fgm_dac_offset,dat,probe_letter,datatype,error=error, calc_freq=calc_freq
  ;skip generation of any error quanties.  Compromise between using message to halt execution and warning only
  if keyword_set(error) then return
  thx_fgx.y = dat
  
  if arg_present(cal_get_dac_dat) then begin
    cal_get_dac_dat = dat
  endif
  
endif

DPRINT, dlevel=4, 'apply scale factor ...'
;apply scale factor
thx_fgx.Y=thx_fgx.Y*kr

;This code block removes harmonics created by the solar array
;current. Correction not applied during shadow.
If(n_elements(cal_spin_harmonics) Eq 0 || cal_spin_harmonics[0] Ne 0) Then Begin ;jmm, 6-jan-2010
  dprint, dlevel=4,'Performing spin harmonic removal. Probe: "'+probe_letter+'" Datatype: "' + datatype + '"'
  dat = thx_fgx.y
  thm_cal_fgm_spin_harmonics,thx_fgx.x,thx_spinphase_model,dat,probe_letter,error=error,shadows=shadow_struct
  ;skip generation of any error quanties.  Compromise between using message to halt execution and warning only
  if keyword_set(error) then return
  thx_fgx.y = dat
  
  if arg_present(cal_get_spin_dat) then begin
    cal_get_spin_dat = dat
  endif
endif

DPRINT, dlevel=4, 'apply calibration ...'

;apply calibration matrix and offset
;lastfs=0

i=0L
ffi=ff[i]
fsi=fs[i]
modi=mode[i]     ;eg 30/3/2007
timei=thx_fgx_HED.X[i]

;Hannes 30/3/2007
;starting calibration
offs=offi[istart,*]
calim=TRANSPOSE(cali[istart,*])
calm=[[calim[0:2]],[calim[3:5]],[calim[6:8]]]
;spinper=spinperi(istart)

iact=istart

IF (iact eq istop) THEN BEGIN
	nextCalChangeTime=thx_fgx.X[count-1L]+10.d0 ;something greater than the last point in time
ENDIF ELSE BEGIN
	nextCalChangeTime=utc[iact+1L]
	DPRINT, dlevel=4,  'nextCalChangeTime:'
	DPRINT, dlevel=4,  utcStr[iact+1L]
ENDELSE
;end Hannes 30/3/2007

; Pull data array out of structure...workaround for IDL 8.2.2 slowdown.
; jwl 2013-04-19

ydata=thx_fgx.Y

for j=0L,count-1L do begin
    ;Hannes 30/3/2007
	;apply the right calibration at the right time
	IF (thx_fgx.X[j] ge nextCalChangeTime) THEN BEGIN
		iact=iact+1
		IF (iact eq istop) THEN BEGIN
			nextCalChangeTime=thx_fgx.X[count-1L]+10.d0 ;something greater than the last point in time
		ENDIF ELSE BEGIN
			nextCalChangeTime=utc[iact+1L]
			DPRINT, dlevel=4,  'nextCalChangeTime:'
			DPRINT, dlevel=4,  utcStr[iact+1L]
		ENDELSE
		offs=offi[iact,*]
		calim=TRANSPOSE(cali[iact,*])
		calm=[[calim[0:2]],[calim[3:5]],[calim[6:8]]]
		;spinper=spinperi(iact)
	ENDIF
	;end Hannes 30/3/2007

    ; update header information if necessary (WHILE loop should work for all possible cases)
    while ((thx_fgx.X[j] gt timei) && (i lt countHed-1)) do begin
       i=i+1
       ffi=ff[i]
       fsi=fs[i]
       modi=mode[i]
       timei=thx_fgx_HED.X[i]
    endwhile


 if modi eq 0 then begin ;eg 30/3/2007

 ;   thx_fgx.Y[j,*]=MATRIX_MULTIPLY(calm, thx_fgx.Y[j,*], /BTRANSPOSE)-offs     ;eg 6/3/2007
 ydata[j,*]=calm ## ydata[j,*] - offs       ;eg 6/3/2007

    ;correct for filter
    if ffi eq 2 then begin
    	spinper=thx_spinper_interp.Y[j];Hannes 30/3/2007
        arg=-!dpi/fsi/spinper
        dfilt=128./fsi*sin(!dpi/128.d0/spinper)/sin(-arg)
        dfm=identity(3,/double)
        dfm[1,1]=dfilt
        dfm[0,0]=dfilt
        ;sarg=sin(arg)                    /delay removed Hannes 05/21/2007
        ;carg=cos(arg) ;& print,arg,dfilt /delay removed Hannes 05/21/2007
        ;delaym=identity(3,/double)       /delay removed Hannes 05/21/2007
        ;delaym[0,1]=-sarg   ;eg 6/3/2007 /delay removed Hannes 05/21/2007
        ;delaym[1,0]=sarg    ;eg 6/3/2007 /delay removed Hannes 05/21/2007
        ;delaym[0,0]=carg                 /delay removed Hannes 05/21/2007
        ;delaym[1,1]=carg                 /delay removed Hannes 05/21/2007
        ;mfilt=dfm#delaym                 /delay removed Hannes 05/21/2007
        mfilt=dfm                        ;/apply only amplitude correction Hannes 05/21/2007
       ; thx_fgx.Y[j,*]=MATRIX_MULTIPLY(mfilt, thx_fgx.Y[j,*],/BTRANSPOSE)      ;eg 6/3/2007
       ydata[j,*]=mfilt ## ydata[j,*]        ;eg 6/3/2007
    endif  ;correct for filter
endif else ydata[j,*]=fillvalue ;eg 30/3/2007 set vectors to fillvalue ???

endfor

DPRINT, dlevel=4, 'calibration applied'

;Removes the remaining orbital dependent spintone using a fitting
;algorithm.
If(n_elements(cal_tone_removal) Eq 0 || cal_tone_removal[0] Gt 0) Then Begin;jmm, 6-jan-2010
  dprint, dlevel=4,'Performing spintone removal. Probe: "'+probe_letter+'" Datatype: "' + datatype + '"'

  if arg_present(cal_get_fulloffset) then begin
    cal_get_fulloffset = dblarr(dimen(thx_fgx.y))
  endif


;Do in batches, ala SCM, if calibrations change, jmm, 2015-11-10
  If(istart Eq istop Or keyword_set(no_spin_tone_batch)) Then Begin ;this is easy
     ss_start = 0 & ss_end = count-1L
  Endif Else Begin
     nbatch = istop-istart+1
     btimes = [utc[istart:istop], thx_fgx.x[count-1]+1.0];time interval edges
     btimes[0] = thx_fgx.x[0]                            ;utc[istart] may be a week ago...
     ss_start = lonarr(nbatch)-1
     ss_end = lonarr(nbatch)-1
     dtbatch = dblarr(nbatch) & dtbatch[*] = 0
     For jbatch = 0,nbatch-1 Do Begin
        ss_batch = where(thx_fgx.x Ge btimes[jbatch] And $
                         thx_fgx.x Lt btimes[jbatch+1], nss_batch)
        If(nss_batch Gt 0) Then Begin
           ss_start[jbatch] = min(ss_batch)
           ss_end[jbatch] = max(ss_batch)
           dtbatch[jbatch] = thx_fgx.x[ss_end[jbatch]]-thx_fgx.x[ss_start[jbatch]]
        Endif
     Endfor
;There is a 10 minute minimum time enforced below, if a batch is
;too short, append it to the next batch, or if it's the last
;batch, append it to the previous batch
     For jbatch = 0, nbatch-1 Do Begin
        If(dtbatch[jbatch] Lt 10D*60D) Then Begin
           If(jbatch Lt nbatch-1) Then begin
              ss_end[jbatch] = ss_end[jbatch+1]
              ss_start[jbatch+1] = -1 & ss_end[jbatch+1] = -1;flag the next batch as bad
           Endif Else Begin
              ss_start[jbatch] = ss_start[jbatch-1]
              ss_start[jbatch-1] = -1 & ss_end[jbatch-1] = -1;flag the previous batch as bad
           Endelse
        Endif
     Endfor
     ok_batch = where(ss_start Ne -1, nbatch)
     If(nbatch Eq 0) Then Begin
        dprint, 'Spin tone batching data for different cal times failed, '
        dprint, 'Processing single batch'
        ss_start = 0 & ss_end = count-1L
     Endif Else Begin
        ss_start = ss_start[ok_batch]
        ss_end = ss_end[ok_batch]
     Endelse
  Endelse
  nbatch = n_elements(ss_start)

;Process spin_tone_removal 
  For jbatch = 0, nbatch-1 Do Begin
     tjbatch = thx_fgx.x[ss_start[jbatch]:ss_end[jbatch]]
     max_tm = max(tjbatch,min=min_tm)
     if max_tm-min_tm lt 10D*60D then begin
        dprint, dlevel=2,'WARNING: Less than 10 min time range for data Probe: "'+probe_letter+'" Datatype: "' + datatype + '" spin tone removal may not be applied.'
     endif
     for i = 0,1 do begin
        ydbatch = ydata[ss_start[jbatch]:ss_end[jbatch], i]
        if arg_present(cal_get_fulloffset) then begin
           thm_cal_fgm_spintone_removal,tjbatch,ydbatch,dat,datatype,fulloffset=fulloffset
           cal_get_fulloffset[ss_start[jbatch], i] = fulloffset
        endif else begin
           thm_cal_fgm_spintone_removal,tjbatch,ydbatch,dat,datatype
        endelse
;       ydata[ss_start[jbatch]:ss_end[jbatch], i] = dat
        ydata[ss_start[jbatch], i] = dat ;using only the start subscript should work, right?
     endfor  
  Endfor
  
  dprint, dlevel=4,'Spintone Removal Complete'

endif
  
; Restore tplot data structure (workaround for IDL 8.2.2 slowdown)
thx_fgx.Y=ydata

DPRINT, dlevel=2, 'done'
;store data, where mode = 0

; kb
units = 'nT'
dl = thx_fgx_dl
str_element, dl, 'data_att', data_att, success=has_data_att
if has_data_att then begin
   str_element, data_att, 'data_type', 'calibrated', /add
endif else data_att = { data_type: 'calibrated' }
str_element, data_att, 'coord_sys',  'ssl', /add
str_element, data_att, 'units', units, /add
str_element, dl, 'data_att', data_att, /add
str_element, dl, 'ytitle', name_thx_fgx_out, /add
str_element, dl, 'ysubtitle', '['+units+']', /add
str_element, dl, 'labels', [ 'x', 'y', 'z'], /add
str_element, dl, 'labflag', 1, /add
str_element, dl, 'colors', [ 2, 4, 6], /add
str_element, dl, 'color_table', 39, /add
; end kb

store_data,name_thx_fgx_out,data=thx_fgx,dl=dl

; kb
if keyword_set(coord) && strlowcase(coord) ne 'ssl' then begin
   thm_cotrans, name_thx_fgx_out, out_coord = coord,use_spinaxis_correction=1, use_spinphase_correction=1,use_eclipse_corrections=use_eclipse_corrections
   options, tplot_var, 'ytitle', /def, $
            string( name_thx_fgx_out, units, format='(A,"!C!C[",A,"]")'), /add
endif
; end kb

;return,thx_fgx
end
