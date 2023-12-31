; $LastChangedBy: davin-mac $
; $LastChangedDate: 2022-01-21 13:49:47 -0800 (Fri, 21 Jan 2022) $
; $LastChangedRevision: 30530 $
; $URL: svn+ssh://thmsvn@ambrosia.ssl.berkeley.edu/repos/spdsoft/tags/spedas_5_0/projects/SWFO/STIS/swfo_stis_memdump_apdat__define.pro $



function swfo_stis_memdump_apdat::decom,ccsds,source_dict=source_dict     

  ;common swfo_stis_memdump_com2, byteimage, bytecount, last_str
;  if n_elements(last_str) eq 0 || (abs(last_str.time-ccsds.time) gt 300) then begin
;    byteimage = bytarr(2UL ^17+1024)
;    bytecount = intarr(2ul ^17+1024)
;  endif

  dd= 24 ;  was 20
  ccsds_data = swfo_ccsds_data(ccsds)
  
 ; memdata = ccsds_data[20:1024+20-1]
 ; memdata = swap_endian( uint(ccsds_data,20,256) ,/swap_if_little_endian)
  
  addr = swfo_data_select(ccsds_data,dd*8,32)

  datalen = ccsds.pkt_size - dd - 4
  memdat = ccsds_data[dd+4: dd+4+datalen-1]
  
  hkpobj = swfo_apdat('stis_hkp2')
  if obj_valid(hkpobj) && isa(hkpobj.last_data,'struct') then mapn = hkpobj.last_data.mapid else mapn = -1
  
  datastr = {time:ccsds.time,  $
         met: ccsds.met,   $
         seqn:    ccsds.seqn,$
         size:    ccsds.pkt_size, $
         mapid:     byte(mapn),  $
         addr:    addr,  $
         datalen:  datalen, $
         data:    memdat,  $
         gap:0b }
         datastr.gap = ccsds.gap
         
  if self.test && debug(2) then begin
       printdat,time_string(datastr.time,/local)
       printdat,/hex,addr
       dprint,datalen
       hexprint,memdat
  endif


  mapn = datastr.mapid
  if ~obj_valid(self.user_dict) then self.user_dict = dictionary()
  ud = self.user_dict
  if ~ud.haskey('maps') then ud.maps = orderedhash()
  if ~ud.maps.haskey(mapn) then ud.maps[mapn] = dictionary()

  d = ud.maps[mapn]
  if ~d.haskey('image_ptr') then d.image_ptr = ptr_new(bytarr(2UL ^17+1024))
  d.last_data = datastr
  ud.last_mapid = mapn
  
  (*d.image_ptr)[datastr.addr:datastr.addr+datastr.datalen-1] = datastr.data
  
  if debug(2) then begin
    byteimage = *d.image_ptr
    sze = n_elements(byteimage)
    rn = 2
    nrows = 512
    ncols = sze /nrows
    wi,1,wsize = [nrows*rn,ncols*rn]
    image2 = reform(byteimage,nrows,ncols)
    image2 = congrid(image2,nrows * rn,ncols *rn)
    tv,image2
    dprint,'hello',dlevel=3
    
    
  endif
         
 ; last_str =datastr       
  return,datastr

end






PRO swfo_stis_memdump_apdat__define

  void = {swfo_stis_memdump_apdat, $
    inherits swfo_gen_apdat, $    ; superclass
 ;   memdict: obj_new(),  $         ; dictionary (or hash) to hold memory maps
    flag: 0 $
  }
END


