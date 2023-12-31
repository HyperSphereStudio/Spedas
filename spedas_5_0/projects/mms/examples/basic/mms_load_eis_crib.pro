;+
; MMS EIS crib sheet
; 
;  prime EIS scientific products are: 
;    ExTOF proton spectra
;    ExTOF He spectra
;    ExTOF Oxygen spectra
;    PHxTOF proton spectra
;    
;  
; do you have suggestions for this crib sheet? 
;   please send them to egrimes@igpp.ucla.edu
;   
; $LastChangedBy: egrimes $
; $LastChangedDate: 2021-08-05 09:42:01 -0700 (Thu, 05 Aug 2021) $
; $LastChangedRevision: 30177 $
; $URL: svn+ssh://thmsvn@ambrosia.ssl.berkeley.edu/repos/spdsoft/tags/spedas_5_0/projects/mms/examples/basic/mms_load_eis_crib.pro $
;-
probe = '1'
prefix = 'mms'+probe
trange = ['2015-10-16', '2015-10-17']
tplot_options, 'xmargin', [20, 15]
level = 'l2'

; load ExTOF data:
mms_load_eis, probes=probe, trange=trange, datatype='extof', level = level 

; plot the H+ flux for all channels
tplot, '*_extof_proton_flux_omni_spin'
stop

; calculate the PAD for 48-106keV protons
mms_eis_pad, combine=0, probe=probe, datatype='extof', species='proton', data_units='flux', energy=[48, 106], level = level

; calculate the PAD for 105-250 keV protons
mms_eis_pad, combine=0, probe=probe, datatype='extof', species='proton', data_units='flux', energy=[105, 250], level = level

; plot the PAD for 66-97 keV (top), 98-143 keV (bottom) protons
tplot, ['mms'+probe+'_epd_eis_srvy_l2_extof_66-97keV_proton_flux_omni_pad_spin', 'mms'+probe+'_epd_eis_srvy_l2_extof_98-143keV_proton_flux_omni_pad_spin']
stop

; plot the He++ flux for all channels
tplot, '*extof_helium_flux_omni_spin'

stop

; plot the O+ flux for all channels
tplot, '*_extof_oxygen_flux_omni_spin'

stop

; load PHxTOF data:
mms_load_eis, probes=probe, trange=trange, datatype='phxtof', level = level

; plot the PHxTOF proton spectra
tplot, '*_phxtof_proton_flux_omni_spin'
stop

; calculate the PHxTOF PAD for protons
mms_eis_pad, probe=probe, datatype='phxtof', species='proton', data_units='flux', energy=[0, 30], level = level

tplot, ['*_epd_eis_srvy_l2_phxtof_proton_flux_omni_spin', $
        '*_epd_eis_srvy_l2_phxtof_10-41keV_proton_flux_omni_pad_spin']
stop

; load some electron data; note that the datatype for electron data is "electronenergy"
mms_load_eis, probes=probe, trange=trange, datatype='electronenergy', level = level
mms_eis_pad, probe=probe, species='electron', datatype='electronenergy', data_units='flux', level = level

; plot the electron spectra
tplot, ['*_epd_eis_srvy_l2_electronenergy_electron_flux_omni_spin', '*_epd_eis_srvy_l2_electronenergy_52-1199keV_electron_flux_omni_pad_spin']

stop
end