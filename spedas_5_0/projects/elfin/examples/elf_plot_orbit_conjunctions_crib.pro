;
; CRIB: elf_plot_orbit_conjunctions_crib
;
; Shows how to create conjunction orbit plots. 
;
; Note: Two Daily orbit plots are displayed for 12 hour intervalswith a duration of
;       90 minutes each (90 min ~orbital period). Conjunction Orbits include 
;       THEMIS, MMS, ERG, and ELFIN missions. 
;       
; First release: 2020/11/23
;
pro elf_plot_orbit_conjunctions_crib
  ;
  ; the conjunction plots only requires one parameter, the date
  elf_plot_orbit_conjunctions, '2021-01-01'
  ;

  print,'*****************************************************************************'
  print,'Plot files will have the names
  print, '    orbit_multi_mission_conjunctions_yyyymmdd_0012.gif'
  print, 'and orbit_multi_mission_conjunctions_yyyymmdd_1224.gif'
  print,'Print !elf.local_data_dir to locate the plots a
  print,'*****************************************************************************'
  stop
  ;
  print, 'NOTE:'
  print, 'If you do not have an authorization file for MMS science data you might encounter'
  print, 'a pop up window asking for user name and password. You can simply click ok or return'
  print, 'and MMS data will be loaded. A blank authorization file might be created.'
  print, ''
  stop
  
  print, 'Done'
  
end