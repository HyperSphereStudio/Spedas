; $LastChangedBy: ali $
; $LastChangedDate: 2022-03-03 12:58:24 -0800 (Thu, 03 Mar 2022) $
; $LastChangedRevision: 30647 $
; $URL: svn+ssh://thmsvn@ambrosia.ssl.berkeley.edu/repos/spdsoft/tags/spedas_5_0/projects/SWFO/STIS/swfo_stis_ccsds_header_decom.pro $


function swfo_stis_ccsds_header_decom,ccsds
  ccsds_data = swfo_ccsds_data(ccsds)

  str = {$
    time:ccsds.time,  $
    time_delta:ccsds.time_delta, $
    met:ccsds.met,   $
    apid:ccsds.apid,  $
    seqn:ccsds.seqn,$
    seqn_delta:ccsds.seqn_delta,$
    pkt_size:ccsds.pkt_size,$
    day:                    swfo_data_select(ccsds_data,(6) *8,  24),$
    millisec:               swfo_data_select(ccsds_data,(9) *8,  32),$
    microsec:               swfo_data_select(ccsds_data,(13)*8,  16),$
    fpga_rev:               swfo_data_select(ccsds_data,(15)*8,  8 ),$
    lccs_bits:              swfo_data_select(ccsds_data,(16)*8,  4 ),$
    time_res:               swfo_data_select(ccsds_data,(16)*8+4,12),$
    user_09:                swfo_data_select(ccsds_data,(18)*8,  16),$
    pulser_bits:            swfo_data_select(ccsds_data,(20)*8,  8 ),$
    detector_bits:          swfo_data_select(ccsds_data,(21)*8,  8 ),$
    aa00:                   swfo_data_select(ccsds_data,(22)*8,  4 ),$
    noise_bits:             swfo_data_select(ccsds_data,(22)*8+4,12),$
    noise_period:0b,$
    noise_res:0b,$
    duration:0$
  }
  str.duration=1+str.time_res
  str.noise_period=str.noise_bits and 255u
  str.noise_res=ishft(str.noise_bits,-8) and 7u
 
  return,str

end