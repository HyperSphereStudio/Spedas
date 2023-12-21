import pyspedas as sps, numpy as np, math
import pytplot as tplt

#Helper Functions

def tplt_options(name, **kwargs):
    tplt.options(name, opt_dict=kwargs)

def tplotbroadcast(f, names, newname):
    datas = [tplt.get_data(n).y for n in names] 
    tplt.store_data(newname, data={'x': tplt.get_data(names[0]).times, 'y': [f(i, datas) for i in range(len(datas[0]))]})
    return newname
#+
# PROCEDURE:
#         mms_fpi_curlometer_crib
#
# PURPOSE:
#         Crib sheet showing how to combine curlometer calculations with FPI data# the output figure includes:
#         
#         1) DIS energy spectra
#         2) DES energy spectra
#         3) B-field in GSE coordinates
#         4) div/curl
#         5) J (Jx,  Jy,  Jz and J magnitude)
#         6) DES velocity (Vx,  Vy,  Vz and V magnitude)
#         7) DIS and DES densities
#         8) DES temperatures
#         9) DIS temperatures
#
#
# $LastChangedBy: egrimes $
# $LastChangedDate: 2022-03-29 10:30:58 -0700 (Tue,  29 Mar 2022) $
# $LastChangedRevision: 30731 $
# $URL: svn+ssh://thmsvn@ambrosia.ssl.berkeley.edu/repos/spdsoft/tags/spedas_5_0/projects/mms/examples/advanced/mms_fpi_curlometer_crib.pro $
#-

trange = ['2015-10-16/05:00',  '2015-10-16/16:00']
probe = '1'   must be a string

sps.mms.fpi(probe=probe,  datatype=['des-moms',  'dis-moms'],  center=True,  trange=trange,  data_rate='brst',  time_clip=True)
sps.mms.fgm(probe=[1,  2,  3,  4],  trange=trange,  data_rate='brst',  time_clip=True,  get_fgm_ephem=True)

# do the curlometer calculations# note: the input data must be in GSE coordinates
sps.mms.lingradest(fields=['mms1_fgm_b_gse_brst_l2_bvec',  $)
                        'mms2_fgm_b_gse_brst_l2_bvec',  $
                        'mms3_fgm_b_gse_brst_l2_bvec',  $
                        'mms4_fgm_b_gse_brst_l2_bvec'],  $
                positions=['mms1_fgm_r_gse_brst_l2',  $
                           'mms2_fgm_r_gse_brst_l2',  $
                           'mms3_fgm_r_gse_brst_l2',  $
                           'mms4_fgm_r_gse_brst_l2']

calc,  '"div/curl"="divB_nT/1000km"/"absCB"'

# calculate the magnitude of J
calc,  '"Jmag"=sqrt("jx"^2+"jy"^2+"jz"^2)'
tplt.store_data('j_data',  data='Jmag jx jy jz')

# combine various variables so that they're plotted in the same panels
tplt.store_data('dis_temp',  data='mms'+probe+'_dis_temppara_brst mms'+probe+'_dis_tempperp_brst')
tplt.store_data('des_temp',  data='mms'+probe+'_des_temppara_brst mms'+probe+'_des_tempperp_brst')
tplt.store_data('fpi_density',  data='mms'+probe+'_dis_numberdensity_brst mms'+probe+'_des_numberdensity_brst')

# add electron velocity magnitude to the velocity variable
sps.get_data('mms'+probe+'_des_bulkv_gse_brst',  data=vel_data,  dlimits=vel_metadata)
vmag=sqrt(vel_data.Y[*,  0]^2+vel_data.Y[*,  1]^2+vel_data.Y[*,  2]^2)
tplt.store_data('des_vel',  data={x: vel_data.x,  y: [[vel_data.Y[*,  0]],  [vel_data.Y[*,  1]],  [vel_data.Y[*,  2]],  [vmag]]},  dlimits=vel_metadata)

# set ytitle/subtitles
tplt_options('mms'+probe+'_dis_energyspectr_omni_brst',  ytitle='DIS')
tplt_options('mms'+probe+'_dis_energyspectr_omni_brst',  ysubtitle='energy (eV)')
tplt_options('mms'+probe+'_des_energyspectr_omni_brst',  ytitle='DES')
tplt_options('mms'+probe+'_des_energyspectr_omni_brst',  ysubtitle='energy (eV)')
tplt_options('mms'+probe+'_fgm_b_gse_brst_l2',  ytitle='B GSE')
tplt_options('mms'+probe+'_fgm_b_gse_brst_l2',  ysubtitle='(nT)')
tplt_options('j_data',  ytitle='j')
tplt_options('j_data',  ysubtitle='(nAm=True^2)')
tplt_options('fpi_density',  ytitle='N')
tplt_options('fpi_density',  ysubtitle='(cm^-3)')
tplt_options('des_temp',  ytitle='T')
tplt_options('des_temp',  ysubtitle='(eV)')
tplt_options('dis_temp',  ytitle='T')
tplt_options('dis_temp',  ysubtitle='(eV)')
tplt_options('des_vel',  ytitle='Ve')
tplt_options('des_vel',  ysubtitle='(kms=True)')

# set labels
tplt_options('mms'+probe+'_dis_temppara_brst',  labels='Ti_para',  colors=6)
tplt_options('mms'+probe+'_dis_tempperp_brst',  labels='Ti_perp',  colors=0)
tplt_options('dis_temp',  labflag=-1)
tplt_options('mms'+probe+'_des_temppara_brst',  labels='Te_para',  colors=6)
tplt_options('mms'+probe+'_des_tempperp_brst',  labels='Te_perp',  colors=0)
tplt_options('des_temp',  labflag=-1)
tplt_options('mms'+probe+'_dis_numberdensity_brst',  linestyle=2 ; dashed ions)
tplt_options('mms'+probe+'_dis_numberdensity_brst',  labels='--Ni',  colors=0)
tplt_options('mms'+probe+'_des_numberdensity_brst',  labels='Ne',  colors=0)
tplt_options('mms'+probe+'_fgm_b_gse_brst_l2',  labels=['B GSE_x',  'B GSE_y',  'B GSE_z',  '|B GSE|'])
tplt_options('fpi_density',  labflag=-1)
tplt_options('des_vel',  labels=['Ve_GSE_x',  'Ve_GSE_y',  'Ve_GSE_z',  '|Ve_GSE|'])
tplt_options('des_vel',  colors=[2,  4,  6,  0])
tplt_options('des_vel',  labflag=1)
tplt_options('divcurl=True',  labels='divBcurlB=True')
tplt_options('divcurl=True',  labflag=-1)
tplt_options('Jmag',  labels='|j_curl|',  colors=0)
tplt_options('j_data',  labflag=-1)

# set ranges
ylim,  'div/curl',  1e-2,  1e1,  1

# create the figure
time_stamp,  /off

tplt.tplot(['mms'+probe+'_dis_energyspectr_omni_brst',  $)
        'mms'+probe+'_des_energyspectr_omni_brst',  $
        'mms'+probe+'_fgm_b_gse_brst_l2',  $
        'div/curl',  $
        'j_data',  $
        'des_vel',  $
        'fpi_density',  $
        'des_temp',  $
        'dis_temp']
        
stop
end
