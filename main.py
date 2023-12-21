import pyspedas, numpy as np
from pyspedas.mms import fgm, fpi, edp
import pytplot as tplt

''' Figure 1, Characteristics of KH Waves as Observed by the MMS
 Summary Plot 1, GSM frame
 
  Set time range of interest '''
date_time_start = '2015-10-16/05:00'
date_time_end = '2015-10-16/16:00'
hours = 11


tr = [date_time_start, date_time_end]

probe = '2'
datatype = ['des-moms', 'dis-moms']
level = 'l2'
fgm_datarate = 'srvy'
datarate = 'fast'
coords = 'gsm'

mms_fgm = fgm(trange=tr, probe=probe, level=level, data_rate=fgm_datarate, time_clip=True, get_fgm_ephemeris=True)
mms_fpi = fpi(trange=tr, probe=probe, level=level, datatype=datatype, data_rate=fgm_datarate)
mms_edp = edp(trange=tr, probe=probe, level=level, data_rate=fgm_datarate)

pyspedas.tinterpol('mms'+probe+'_dis_numberdensity_'+datarate, 'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot', newname='mms'+probe+'_dis_numberdensity_'+fgm_datarate)
pyspedas.tinterpol('mms'+probe+'_des_numberdensity_'+datarate, 'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot', newname='mms'+probe+'_des_numberdensity_'+fgm_datarate)
pyspedas.tinterpol('mms'+probe+'_dis_temppara_'+datarate, 'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot', newname='mms'+probe+'_dis_temppara_'+fgm_datarate)
pyspedas.tinterpol('mms'+probe+'_dis_tempperp_'+datarate, 'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot', newname='mms'+probe+'_dis_tempperp_'+fgm_datarate)
pyspedas.tinterpol('mms'+probe+'_des_temppara_'+datarate, 'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot', newname='mms'+probe+'_des_temppara_'+fgm_datarate)
pyspedas.tinterpol('mms'+probe+'_des_tempperp_'+datarate, 'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot', newname='mms'+probe+'_des_tempperp_'+fgm_datarate)
pyspedas.tinterpol('mms'+probe+'_edp_dce_'+coords+'_'+datarate+'_l2', 'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot', newname='mms'+probe+'_edp_dce_'+coords+'_'+fgm_datarate+'_l2')
pyspedas.tinterpol('mms'+probe+'_dis_bulkv_gse_'+datarate, 'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot', newname='mms'+probe+'_dis_bulkv_gse_'+fgm_datarate)
pyspedas.tinterpol('mms'+probe+'_des_bulkv_gse_'+datarate, 'mms'+probe+'_fgm_b_'+coords+'_'+fgm_datarate+'_l2_btot', newname='mms'+probe+'_des_bulkv_gse_'+fgm_datarate)

pyspedas.tinterpol()

#Rotate velocity data to GSM coordinates
pyspedas.cotrans('mms'+probe+'_dis_bulkv_gse_'+fgm_datarate, 'mms'+probe+'_dis_bulkv_'+coords+'_'+fgm_datarate, in_coord='gse', out_coord=coords)

pyspedas.avg_data(['mms'+probe+'_dis_tempperp_'+fgm_datarate, 'mms'+probe+'_des_tempperp_'+fgm_datarate],
                  width=3,
                  new_names=['mms'+probe+'_dis_tempavg_'+fgm_datarate, 'mms'+probe+'_des_tempavg_'+fgm_datarate])


tplt.divide('mms'+probe+'_dis_tempavg_'+fgm_datarate, 'mms'+probe+'_des_tempavg_'+fgm_datarate, new_tvar='mms'+probe+'_tempratio_'+fgm_datarate)

tplt.options()