;+
; This crib sheet will help explain how to use the SWFO STIS Ground processing software
; Typically a crib sheet can be used to "copy" and "paste" commands into an IDL command window
; This crib sheet can be used as a program to be run from beginning to end.
; 
; These tools are not intended as a final product but can be used to create high level ouput.
; 
; 
; $LastChangedBy: davin-mac $
; $LastChangedDate: 2022-03-07 08:30:03 -0800 (Mon, 07 Mar 2022) $
; $LastChangedRevision: 30654 $
; $URL: svn+ssh://thmsvn@ambrosia.ssl.berkeley.edu/repos/spdsoft/tags/spedas_5_0/projects/SWFO/STIS/swfo_stis_crib.pro $
; $ID: $
;-


; sample plotting procedure
pro  swfo_stis_plot_example,nsamples=nsamples    ; This is very simple sample routine to demonstrate how to plot recently collecte spectra
  sci = swfo_apdat('stis_sci')
  da = sci.data    ; the dynamic array that contains all the data collected  (it gets bigger with time)
  size= da.size    ;  Current size of the data  (it gets bigger with time)

  if ~keyword_set(nsamples) then nsamples = 20
  index = [size-nsamples:size-1]    ; get indices of last N samples
  samples=da.slice(index)           ; extract the last N samples

  spectra = total(samples.counts,2)    ;  get the total over slice
  xval = findgen( n_elements( spectra)) * 1.
  wi,2                                ; Open window

  plot,xval,spectra,psym=10,xtitle='Bin Number',ytitle='Counts', $
    title='Science Data (Integrated over '+strtrim(nsamples,2)+' samples)',/ylog,yrange=minmax(/pos,[spectra,[8,10]]);[.5,max(spectra)]

  store_data,'mem',systime(1),memory(/cur)/(2.^6),/append
end




file_type ='ptp_file'
file_type ='gse_file'



;  Define the "options" dictionary -   Opts
if ~isa(opts,'dictionary') || opts.refresh eq 1 then begin   ; set default options
  !quiet = 1
  opts=dictionary()
  opts.root = root_data_dir()
  opts.remote_data_dir = 'sprg.ssl,berkeley.edu/data/
  ;opts.local_data_dir = root_data_dir()
  ;opts.reldir = 'swfo/data/stis/prelaunch/stis/realtime/'
  opts.reldir = 'swfo/data/sci/stis/prelaunch/realtime/
  opts.fileformat = 'YYYY/MM/DD/swfo_stis_socket_YYYYMMDD_hh.dat.gz'
  opts.host = '128.32.98.57'
  opts.title = 'SWFO STIS'
  opts.port = 2428
  opts.init_realtime = 1                 ; Set to 1 to start realtime stream widget
  opts.init_stis =1                      ; set to 1 to initialize the STIS APID definitions
  opts.exec_text = ['tplot,verbose=0,trange=systime(1)+[-1.,.05]*600','timebar,systime(1)']                    ; commands to be run in exec widget
  ;opts.exec_text = ['tplot,verbose=0,trange=systime(1)+[-1.,.05]*600','swfo_stis_plot_example','timebar,systime(1)']                    ; commands to be run in exec widget
  opts.file_trange = ['2021-10-10', '2021-10-19']   ; Temp margin test data
  opts.file_trange =  ['2021-08-23/4', '2021-08-24/02']   ; This time range includes some good sample data to test robustness of the code - includes a version change
  opts.file_trange = 2  ;   ; set a time range for the last N hours
  opts.file_trange = ['2021-10-18/14', '2021-10-18/16']   ; Temp margin test data
  opts.file_trange = !null
  opts.file_trange = ['2022-03-01','2022-03-02/01']
  ;opts.filenames=['socket_128.32.98.57.2028_20211216_004610.dat', 'socket_128.32.98.57.20484_20211216_005158.dat']
  opts.filenames = ''
  opts.stepbystep = 0               ; this flag allows a step by step progress through this crib sheet
  opts.refresh = 0                  ; set to zero to skip this section next time
  opts.file_type = 'gse_file'
  printdat,opts
  dprint,'The variable "OPTS" is a dictionary of options.  These can be changed by the user as desired.'
  if opts.stepbystep then stop
endif





if opts.init_stis then begin
  dprint,'Initialize the STIS apid objects.  This will define the decomumutators for each of the STIS APIDS'
  swfo_stis_apdat_init,/save_flag
  if opts.stepbystep then stop
endif


dprint,'Displaying APID definitions and current status'
swfo_apdat_info,/print,/all
if opts.stepbystep then stop



if keyword_set(opts.file_trange) then begin
  trange = opts.file_trange
  pathformat = opts.reldir + opts.fileformat
  if opts.stepbystep then stop

  ;  if stepbystep then stop
  ;filenames = file_retrieve(pathformat,trange=trange,/hourly_,remote_data_dir=opts.remote_data_dir,local_data_dir= opts.local_data_dir)
  if n_elements(trange eq 1)  then trange = systime(1) + [-trange[0],0]*3600.
  dprint,dlevel=2,'Download raw telemetry files...'
  filenames = swfo_file_retrieve(pathformat,trange=trange,/hourly_names)

  dprint,dlevel=2, "Print the raw data files..."
  dprint,dlevel=2,filenames
  opts.filenames = filenames
endif


; delete following line after testing



;'/Users/davin/analysis/socket_128.32.98.57.2028_20211214_181537.dat', '/Users/davin/analysis/socket_128.32.98.57.2028_20211214_182909.dat']

if keyword_set(opts.filenames) then begin
  dprint,dlevel=2, "Reading in the data files...."
  
  swfo_ptp_file_read,opts.filenames,file_type=file_type
  dprint,dlevel=2,'A list of packet types and their statistics should be displayed after all the files have been read.'
  if opts.stepbystep then stop
endif


if keyword_set(opts.init_realtime) then begin
  ;if stepbystep then stop
  swfo_init_realtime,/stis   ,opts = opts
  dprint,'"swfo_init_realtime" will create a widget that can read a realtime data stream.'
  dprint,'Click on "Connect to:" to connect to the host:port'
  dprint,'(If a connection can not be made then there is nothing more to do here.)'
  dprint,'Click on "Write to:" to record the stream to a local file.  (not required)'
  dprint,'Click on the "Procedure" checkbox to start decummutating data.'
  if opts.stepbystep then stop
endif


if keyword_set(opts.exec_text) then begin
  dprint,'Create a generic widget that can execute a list of IDL commands at regular intervals.  These are defined by the user.'
  exec, exec_text = opts.exec_text,title=opts.title+' EXEC',interval=7
endif


!except =0
dprint,dlevel=2,'Create a "Time Plot" (tplot) showing key parameters of the STIS instrument'
swfo_stis_tplot,/setlim

if 0 then $
  tplot,'*hkp1_ADC_TEMP_S1 *hkp1_ADC_BIAS_* *hkp1_ADC_?5? swfo_stis_hkp1_RATES_CNTR swfo_stis_sci_COUNTS swfo_stis_nse_NHIST swfo_stis_hkp1_CMDS'


dprint,'Statistics of all packets:'
swfo_apdat_info,/print,/all


dprint,dlevel=2,'Obtain IDL objects that hold data from each of the STIS APIDS:'
hkp1 = swfo_apdat('stis_hkp1') ; obtain object that contains all the "housekeeping 1" packets
hkp2 = swfo_apdat('stis_hkp2') ; obtain object that contains all the "housekeeping 2" packets
nse = swfo_apdat('stis_nse')    ; obtain object that contains all the "noise" packets
sci = swfo_apdat('stis_sci')   ; obtain object that contains all the "science data" packets
mem = swfo_apdat('stis_mem') ; obtain object that contains all the "memory dump" packets


if 0 then begin
  if opts.stepbystep then stop
  dprint,'Display contents of most recent decomutated data product'
  printdat,hkp1.last_data   ; Display decommutated contents of most recent hkp1 packet
  printdat,hkp2.last_data
  printdat,nse.last_data
  printdat,sci.last_data   ; Display decommutated contents of most recent science packet
endif


if 1 then begin
  
  dprint,'Create Level 0B netcdf file for science packets:'
  
  sci.level_0b = dynamicarray()   ; Turn on storage of level_0b data by giving it a place to store data
  
  sci.file_resolution = 3600
  
  sci.ncdf_make_file , ret_filename=f   ; the filename is returned in the variable f   
  printdat,f
  hkp1.ncdf_make_file , ret_filename=f   ; the filename is returned in the variable f
  printdat,f
  hkp2.ncdf_make_file , ret_filename=f   ; the filename is returned in the variable f
  printdat,f
  nse.ncdf_make_file , ret_filename=f   ; the filename is returned in the variable f
  printdat,f

  
  sci_l0b  =  sci.data.array   ; obtain level 0B data directly from sci object
  sci_l0b_copy = swfo_ncdf_read(file=f)  ; read copy of data from file that was just created
  
    ; sci_l0b and sci_l0b_copy should be identical  
    ; Note that sci_l0b_copy might have more samples if it was produced after sci_l0b was generated
    
  sci_l1a =   swfo_stis_sci_level_1(sci_l0b)   ; create l1a data from l0b data
  swfo_ncdf_create,sci_l1a, file='test_sci_l1a.nc'     ; write data to a file.  still awaiting meta data.

endif


end
