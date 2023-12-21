import pyspedas as sps, numpy as np, math
import pytplot as tplt

#Helper Functions

def tplt_options(name, **kwargs):
    tplt.options(name, opt_dict=kwargs)

def tplotbroadcast(f, names, newname):
    datas = [tplt.get_data(n).y for n in names] 
    tplt.store_data(newname, data={'x': tplt.get_data(names[0]).times, 'y': [f(i, datas) for i in range(len(datas[0]))]})
    return newname
# Figure 1,  Characteristics of KH Waves as Observed by the MMS
# Summary Plot 1,  GSM frame
# 
# # Set time range of interest

date_time_start = '2015-10-16/05:00'
date_time_end = '2015-10-16/16:00'
hours=11


tr = [date_time_start, date_time_end]


timespan, date_time_start, hours, /hours

# set details of data to be retrieved
probe = '2'
datatype = ['des-moms',  'dis-moms']
level = 'l2'
fgm_datarate = 'srvy'
datarate = 'fast'
coords='gsm'


# load FGM data
sps.mms.fgm(trange=tr,  probe=probe,  level=level,  data_rate=fgm_datarate,  time_clip=True,  get_fgm_ephemeris=True)

# load FPI data
sps.mms.fpi(trange=tr,  probe=probe,  datatype=datatype,  level = level,  data_rate=datarate,  time_clip=True)

# load EDP data
#mms_load_edp,  trange=tr,  probes=probe,  level = level,  data_rate=datarate,  /time_clip


# Interpolate all necessary data to FGM cadence
sps.tinterpol('mms'+probe+'_dis_numberdensity_'+datarate,  'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot',  newname='mms'+probe+'_dis_numberdensity_'+fgm_datarate)
sps.tinterpol('mms'+probe+'_des_numberdensity_'+datarate,  'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot',  newname='mms'+probe+'_des_numberdensity_'+fgm_datarate)
sps.tinterpol('mms'+probe+'_dis_temppara_'+datarate,  'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot',  newname='mms'+probe+'_dis_temppara_'+fgm_datarate)
sps.tinterpol('mms'+probe+'_dis_tempperp_'+datarate,  'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot',  newname='mms'+probe+'_dis_tempperp_'+fgm_datarate)
sps.tinterpol('mms'+probe+'_des_temppara_'+datarate,  'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot',  newname='mms'+probe+'_des_temppara_'+fgm_datarate)
sps.tinterpol('mms'+probe+'_des_tempperp_'+datarate,  'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot',  newname='mms'+probe+'_des_tempperp_'+fgm_datarate)
sps.tinterpol('mms'+probe+'_edp_dce_'+coords+'_'+datarate+'_l2',  'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot',  newname='mms'+probe+'_edp_dce_'+coords+'_'+fgm_datarate+'_l2')
sps.tinterpol('mms'+probe+'_dis_bulkv_gse_'+datarate,  'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot',  newname='mms'+probe+'_dis_bulkv_gse_'+fgm_datarate)
sps.tinterpol('mms'+probe+'_des_bulkv_gse_'+datarate,  'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot',  newname='mms'+probe+'_des_bulkv_gse_'+fgm_datarate)


# Rotate velocity data to GSM coordinates
sps.cotrans('mms'+probe+'_dis_bulkv_gse_'+fgm_datarate,  'mms'+probe+'_dis_bulkv_'+coords+'_'+fgm_datarate,  coord_in='gse',  coord_out=coords)

# Calculate average temperatures
tplt.add('mms'+probe+'_dis_tempperp_'+fgm_datarate,  'mms'+probe+'_dis_tempperp_'+fgm_datarate,  new_tvar='mms'+probe+'_dis_2tperp_'+fgm_datarate)
tplt.add('mms'+probe+'_dis_temppara_'+fgm_datarate,  'mms'+probe+'_dis_2tperp_'+fgm_datarate,  new_tvar='mms'+probe+'_dis_tempavg_'+fgm_datarate)
sps.get_data('mms'+probe+'_dis_tempavg_'+fgm_datarate,  data=Tiavg)
Tiavg.y = Tiavg.y/3.
tplt.store_data('mms'+probe+'_dis_tempavg_'+fgm_datarate,  data=Tiavg)

tplt.add('mms'+probe+'_des_tempperp_'+fgm_datarate,  'mms'+probe+'_des_tempperp_'+fgm_datarate,  new_tvar='mms'+probe+'_des_2tperp_'+fgm_datarate)
tplt.add('mms'+probe+'_des_temppara_'+fgm_datarate,  'mms'+probe+'_des_2tperp_'+fgm_datarate,  new_tvar='mms'+probe+'_des_tempavg_'+fgm_datarate)
sps.get_data('mms'+probe+'_des_tempavg_'+fgm_datarate,  data=Teavg)
Teavg.y = Teavg.y/3.
tplt.store_data('mms'+probe+'_des_tempavg_'+fgm_datarate,  data=Teavg)

tplt.divide('mms'+probe+'_dis_tempavg_'+fgm_datarate,  'mms'+probe+'_des_tempavg_'+fgm_datarate,  new_tvar='mms'+probe+'_tempratio_'+fgm_datarate)

# Calculate magnetic,  plasma,  total pressures
tplt.multiply('mms'+probe+'_dis_tempavg_'+fgm_datarate,  'mms'+probe+'_dis_numberdensity_'+fgm_datarate,  new_tvar='mms'+probe+'_ion_plasma_pressure_'+fgm_datarate)
sps.get_data('mms'+probe+'_ion_plasma_pressure_'+fgm_datarate,  data=ion_plas_pressure)
ion_plas_pressure.y = ion_plas_pressure.y*!const.e*10.^15
tplt.store_data('mms'+probe+'_ion_plasma_pressure_'+fgm_datarate,  data=ion_plas_pressure)

tplt.multiply('mms'+probe+'_des_tempavg_'+fgm_datarate,  'mms'+probe+'_des_numberdensity_'+fgm_datarate,  new_tvar='mms'+probe+'_electron_plasma_pressure_'+fgm_datarate)
sps.get_data('mms'+probe+'_electron_plasma_pressure_'+fgm_datarate,  data=elec_plas_pressure)
elec_plas_pressure.y = elec_plas_pressure.y*!const.e*10.^15
tplt.store_data('mms'+probe+'_electron_plasma_pressure_'+fgm_datarate,  data=elec_plas_pressure)

tplt.multiply('mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot',  'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot',  new_tvar='mms'+probe+'_magnetic_pressure_'+fgm_datarate)
sps.get_data('mms'+probe+'_magnetic_pressure_'+fgm_datarate,  data=mag_pressure)
mag_pressure.y = 10.^(-9)*mag_pressure.y/(2*!const.mu0)
tplt.store_data('mms'+probe+'_magnetic_pressure_'+fgm_datarate,  data=mag_pressure)

tplt.add('mms'+probe+'_ion_plasma_pressure_'+fgm_datarate,  'mms'+probe+'_electron_plasma_pressure_'+fgm_datarate,  new_tvar='mms'+probe+'_plasma_pressure_'+fgm_datarate)
tplt.add('mms'+probe+'_plasma_pressure_'+fgm_datarate,  'mms'+probe+'_magnetic_pressure_'+fgm_datarate,  new_tvar='mms'+probe+'_total_pressure_'+fgm_datarate)

tplt.store_data('mms'+probe+'_pressures_'+fgm_datarate,  data=['mms'+probe+'_plasma_pressure_'+fgm_datarate, 'mms'+probe+'_magnetic_pressure_'+fgm_datarate, 'mms'+probe+'_total_pressure_'+fgm_datarate])

# Calculate ion and electron plasma betas
tplt.divide('mms'+probe+'_ion_plasma_pressure_'+fgm_datarate,  'mms'+probe+'_magnetic_pressure_'+fgm_datarate,  new_tvar='mms'+probe+'_ion_beta_'+fgm_datarate)
tplt.divide('mms'+probe+'_electron_plasma_pressure_'+fgm_datarate,  'mms'+probe+'_magnetic_pressure_'+fgm_datarate,  new_tvar='mms'+probe+'_electron_beta_'+fgm_datarate)

# Convert location data to RE
sps.get_data('mms'+probe+'_fgm_r_'+coords+'_'+fgm_datarate+'_l2',  data=xyz_km)
xyz_re = xyz_km
xyz_re.y = xyz_km.y/(R_earth*0.001)
tplt.store_data('mms'+probe+'_fgm_RE_'+coords+'_'+fgm_datarate,  data=xyz_re)
tplt.split_vec('mms'+probe+'_fgm_RE_'+coords+'_'+fgm_datarate)
tplt_options('mms'+probe+'_fgm_RE_'+coords+'_'+fgm_datarate+'_0',  ytitle = 'Xgsm')
tplt_options('mms'+probe+'_fgm_RE_'+coords+'_'+fgm_datarate+'_1',  ytitle = 'Ygsm')
tplt_options('mms'+probe+'_fgm_RE_'+coords+'_'+fgm_datarate+'_2',  ytitle = 'Zgsm')


Ionspec = 'mms'+probe+'_dis_energyspectr_omni_'+datarate
BGSM = 'mms'+probe+'_fgm_b_'+coords+'_srvy_l2'
VGSM = 'mms'+probe+'_dis_bulkv_'+coords+'_'+fgm_datarate
IonT = 'mms'+probe+'_dis_tempavg_'+fgm_datarate
ElecT = 'mms'+probe+'_des_tempavg_'+fgm_datarate
IonN = 'mms'+probe+'_dis_numberdensity_'+fgm_datarate
ElecN = 'mms'+probe+'_des_numberdensity_'+fgm_datarate
IETRat = 'mms'+probe+'_tempratio_'+fgm_datarate
Pres = 'mms'+probe+'_pressures_'+fgm_datarate
IonB = 'mms'+probe+'_ion_beta_'+fgm_datarate
ElecB = 'mms'+probe+'_electron_beta_'+fgm_datarate

tplt_options('mms'+probe+'_total_pressure_'+fgm_datarate,  labels='Total')
tplt_options('mms'+probe+'_plasma_pressure_'+fgm_datarate,  colors='b')
tplt_options('mms'+probe+'_plasma_pressure_'+fgm_datarate,  labels='Plasma')
tplt_options('mms'+probe+'_magnetic_pressure_'+fgm_datarate,  colors='r')
tplt_options('mms'+probe+'_magnetic_pressure_'+fgm_datarate,  labels='Magnetic')

tplt_options(Ionspec,  ytitle = 'Omnidirectional Ion Energy')
tplt_options(BGSM,  ytitle = 'FGM B-Field GSM')
tplt_options(BGSM,  ysubtitle = '[nT]')
tplt_options(VGSM,  ytitle = 'Ion Velocity GSM')
tplt_options(VGSM,  ysubtitle = '[kms=True]')
tplt_options(IonT,  ytitle = 'Ion Temperature')
tplt_options(IonT,  ysubtitle = '[eV]')
tplt_options(IonN,  ytitle='Ion Density')
tplt_options(IonN,  ysubtitle = '[cc=True]')
tplt_options(IonN,  ylog=1)
tplt_options(ElecT,  ytitle = 'Electron Temperature')
tplt_options(ElecT,  ysubtitle = '[eV]')
tplt_options(ElecN,  ytitle = 'Electron Density')
tplt_options(ElecN,  ysubtitle = '[cc=True]')
tplt_options(ElecN,  ylog=1)
tplt_options(IETRat,  ytitle = 'IonElectron=True Temp Ratio')
tplt_options(Pres,  ytitle = 'Total Pressure')
tplt_options(Pres,  ysubtitle = '[nPa]')
tplt_options(IonB,  ytitle = 'Ion Plasma Beta')
tplt_options(ElecB,  ytitle = 'Electron Plasma Beta')

tplt_options(BGSM,  labflag=1)
tplt_options(VGSM,  labflag=1)
tplt_options(IonN,  labflag=3,  labpos=[0])
tplt_options(IonT,  labflag=3,  labpos=[1])
tplt_options(ElecN,  labflag=3,  labpos=[4])

tplt.tplot(options, 'xmargin', [17, 13])
window,  0,  xsize=975,  ysize=1300
window,  1,  xsize=975,  ysize=1300
#tplot_multiaxis,  [Ionspec, BGSM, VGSM, IonT, ElecT, IETRat, Pres, IonB, ElecB], [IonN, ElecN], [4, 5],  window=0

tplt.tplot(multiaxis,  [Ionspec, BGSM, VGSM, IonT, Pres], [IonN], [4],  window=0)

tplt.tplot(['mms'+probe+'_fgm_RE_'+coords+'_'+fgm_datarate+'_2', 'mms'+probe+'_fgm_RE_'+coords+'_'+fgm_datarate+'_1', 'mms'+probe+'_fgm_RE_'+coords+'_'+fgm_datarate+'_0'])

makepng, 'MMS_overview_'+string(probe)
