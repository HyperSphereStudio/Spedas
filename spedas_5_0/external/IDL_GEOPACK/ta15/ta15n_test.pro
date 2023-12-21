;+
; ts07_test
;
; Purpose: A few tests to verify that the model and the wrapper
; procedures work correctly
;
; $LastChangedBy: jwl $
; $LastChangedDate: 2021-07-28 18:16:15 -0700 (Wed, 28 Jul 2021) $
; $LastChangedRevision: 30156 $
; $URL: svn+ssh://thmsvn@ambrosia.ssl.berkeley.edu/repos/spdsoft/tags/spedas_5_0/external/IDL_GEOPACK/ta15/ta15n_test.pro $
;-

;takes a matrix whose columns define a plane
;and an Nx3 series of points
;returns an Nx2 series of points generated by projecting x into a
function project_ta15n, a, x

  p = a ## invert(transpose(a) ## a) ## transpose(a)

  return, p ## x

end

;constructs a vector field from orbital data, useful for visualization
;of results
pro orbital_vf_ta15n, name

  get_data, name, data = d

  tta15n,name,pdyn=2.0D,yimf=0.0D,zimf=-5.0D,xind=1.5D,error=e

  get_data, name+'_bta15n', data = td

  t_size = n_elements(d.x)

  ;3 points selected to define a plane
  v1 = d.y[0, *]

  v2 = d.y[floor(t_size/3), *]

  v3 = d.y[floor(2*t_size/3), *]

  ;plane vectors are just v2, and v3 shifted by the reference point v1
  vp1 = v2-v1

  vp2 = v3-v1

  proj_pos = project_ta15n([vp1, vp2], d.y)

  proj_mag = project_ta15n([vp1, vp2], td.y)

  ivector, interpol(proj_mag[*, 0],20),interpol(proj_mag[*, 1],20), interpol(proj_pos[*, 0],20), interpol(proj_pos[*, 1],20),renderer=1

end

timespan, '2008-03-23'

;load state data
thm_load_state, probe = 'b', coord = 'gsm'

;test with single number argument
tta15n, 'thb_state_pos',pdyn=2.0D,yimf=0.0D,zimf=-5.0D,xind=1.5D,error=e

if e eq 0 then begin
  message,/continue,'error detected, stopping'
  stop
endif

tplot,'thb_state_pos_bta15n'

stop

del_data,'thb_state_pos_bta15n'

get_data,'thb_state_pos',data=d

n = n_elements(d.x)

;test with an array argument
tta15n, 'thb_state_pos',pdyn=replicate(2.0D,n),yimf=replicate(0.0D,n),zimf=replicate(-5.0D,n),xind=replicate(1.5D,n),error=e

if e eq 0 then begin
  message,/continue,'error detected, stopping'
  stop
endif

tplot,'thb_state_pos_bta15n'

stop

del_data,'thb_state_pos_bta15n'

d2 = {x:d.x[0],y:2.0D}

store_data,'t_pdyn',data=d2

d2 = {x:d.x[0],y:-30.0D}

store_data,'t_yimf',data=d2

d2 = {x:d.x[0],y:-5.0D}

store_data,'t_zimf',data=d2

d2 = {x:d.x[0],y:1.5D}

store_data,'t_xind',data=d2


;test with tplot arguments
tta15n,'thb_state_pos',pdyn='t_pdyn',yimf='t_yimf',zimf='t_zimf',xind='t_xind',error=e

if e eq 0 then begin
  message,/continue,'error detected, stopping'
  stop
endif

tplot,'thb_state_pos_bta15n'

stop

del_data,'thb_state_pos_bta15n'

;test with newname
tta15n, 'thb_state_pos',pdyn=2.0D,yimf=0.0D,zimf=-5.0D,xind=1.5D,newname='test',error=e

if e eq 0 then begin
  message,/continue,'error detected, stopping'
  stop
endif

tplot,'test'

stop

del_data,'test'

;test with a different period

tta15n, 'thb_state_pos',pdyn=2.0D,yimf=0.0D,zimf=-5.0D,xind=1.5D,period=30,error=e

if e eq 0 then begin
  message,/continue,'error detected, stopping'
  stop
endif

tplot,'thb_state_pos_bta15n'

stop

;test with an incremented tilt
tta15n, 'thb_state_pos',pdyn=2.0D,yimf=0.0D,zimf=-5.0D,xind=1.5D,period=30,error=e,get_tilt='tilt_vals',get_nperiod=gn,add_tilt=1

if e eq 0 then begin
  message,/continue,'error detected, stopping'
  stop
endif

tplot,'tilt_vals'

stop

;test with a set tilt
tta15n, 'thb_state_pos',pdyn=2.0D,yimf=0.0D,zimf=-5.0D,xind=1.5D,period=30,error=e,get_tilt='tilt_vals',get_nperiod=gn,set_tilt=1

if e eq 0 then begin
  message,/continue,'error detected, stopping'
  stop
endif

options,'tilt_vals',yrange=[0,2]
tplot,'tilt_vals'
options,'tilt_vals',yrange=[1,1]  ;reset to auto-range
stop

orbital_vf_ta15n,'thb_state_pos'

print,'The plot produced should look like the plot titled ta15n_test.png'

end
