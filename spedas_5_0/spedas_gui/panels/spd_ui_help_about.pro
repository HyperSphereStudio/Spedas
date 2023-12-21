;+
;
;NAME:
; spd_ui_help_about
;
;PURPOSE:
; A widget to display About information (SPEDAS Version)
;
;
;$LastChangedBy: jwl $
;$LastChangedDate: 2022-03-04 11:48:01 -0800 (Fri, 04 Mar 2022) $
;$LastChangedRevision: 30648 $
;$URL: svn+ssh://thmsvn@ambrosia.ssl.berkeley.edu/repos/spdsoft/tags/spedas_5_0/spedas_gui/panels/spd_ui_help_about.pro $
;-

function spd_ui_help_about_dlm, type

  dlm_result = ""
  help, type, /dlm, output=dlm_about
  if (!D.NAME eq 'WIN') then newline = string([13B, 10B]) else newline = string(10B)
  
  if n_elements(dlm_about) gt 0 then begin
    for i=0, n_elements(dlm_about)-1 do begin
      dlm_result = dlm_result + STRTRIM(dlm_about[i], 2)
      if i lt n_elements(dlm_about)-1 then  dlm_result = dlm_result + newline + newline
    endfor
  endif else begin
    dlm_result = dlm_about[0]
  endelse   
  
  return, dlm_result
end

pro spd_ui_help_about_update_dlm
  plugin_mission='themis'
  GETRESOURCEPATH, path ; start at the resources folder
  update_dlm_info = path + PATH_SEP() + 'update_dlm_info.txt'
  if file_test(update_dlm_info, /READ) then begin
    xdisplayfile, update_dlm_info, done_button='CLOSE', height=50, /modal, title='How to update CDF and GEOPACK' 
  endif else begin
      
  endelse
  
end

Pro spd_ui_help_about_event, ev
    plugin_mission = ''
    widget_control, ev.id, get_uvalue=uval
  
  ; check if this event was generated by a button on the about plugins menu
  uval_arr = strsplit(uval, ':', /extract)
  uval = uval_arr[0]
  if n_elements(uval_arr) eq 3 then begin
    plugin_mission = uval_arr[1]
    plugin_about_file = uval_arr[2]
  endif

  case uval of
    'ABOUT': begin
        GETRESOURCEPATH, path ; start at the resources folder
        plugin_about_path = path+ PATH_SEP() + PATH_SEP(/PARENT_DIRECTORY)+ PATH_SEP() + PATH_SEP(/PARENT_DIRECTORY) + PATH_SEP() +  'projects'+ PATH_SEP() + strlowcase(plugin_mission) +PATH_SEP() 
        if ~file_test(plugin_about_path, /directory) then plugin_about_path = path + PATH_SEP() + 'terms_of_use' + PATH_SEP()
        xdisplayfile, plugin_about_path + strlowcase(plugin_about_file), done_button='CLOSE', height=50, /modal, title='About ' + plugin_mission
    end    
    'SPEDASWEB' : begin
      spd_ui_open_url, 'http://spedas.org/'
    end
    'UPDATEDLM' : begin
      spd_ui_help_about_update_dlm
    end
    'QUIT' : begin
      widget_control, ev.top, /destroy
    end
  endcase

end

Pro spd_ui_help_about, gui_id, historywin
  ;aboutlabel should show the SPEDAS version and some other info (perhaps build date, web site URL, etc)
  spedas_version, spd_ver=spd_ver, spd_date=spd_date
  aboutString= ' SPEDAS '  + spd_ver +  string(10B) + string(10B) $
    + ' Space Physics Environment Data Analysis Software ' $
    + string(10B) + string(10B) + spd_date + string(10B) + string(10B)  $
    + ' For support or bug reports, contact: THEMIS_Science_Support@ssl.berkeley.edu '

  cdf_about = spd_ui_help_about_dlm('cdf')
  geopack_about = spd_ui_help_about_dlm('geopack')

  aboutBase = widget_base(/col, title = 'About', /modal, Group_Leader=gui_id)
  aboutLabel = widget_label(aboutBase, value=aboutString, /align_center, SCR_XSIZE=600, SCR_YSIZE=100, UNITS=0)
  
  cdfBase = widget_base(aboutBase, /row)
 ; cdfLabel = widget_label(cdfBase, value=cdf_about, /align_center, SCR_XSIZE=300, SCR_YSIZE=100, UNITS=0, /SUNKEN_FRAME)
 ; geoLabel = widget_label(cdfBase, value=geopack_about, /align_center, SCR_XSIZE=300, SCR_YSIZE=100, UNITS=0, /SUNKEN_FRAME)
  
  
  cdfLabel = widget_text(cdfBase, value=cdf_about, /align_center, SCR_XSIZE=300, SCR_YSIZE=130, UNITS=0, /SCROLL, /WRAP)
  geoLabel = widget_text(cdfBase, value=geopack_about, /align_center, SCR_XSIZE=300, SCR_YSIZE=130, UNITS=0, /SCROLL, /WRAP)
  ;aboutLabel0 = widget_label(aboutBase, value=' ', /align_center, SCR_XSIZE=500, SCR_YSIZE=5, UNITS=0)
    
  dlmButton = widget_button(aboutBase, value = ' How to update CDF and GEOPACK ', uvalue= 'UPDATEDLM', /align_center)    
  aboutPluginButtons = widget_button(aboutBase, value='About SPEDAS Plugins...', uvalue='ABOUTPLUGINS', /align_center, /menu)
  spedasButton = widget_button(aboutBase, value = ' Go to http://spedas.org/ ', uvalue= 'SPEDASWEB', /align_center)
  
  widget_control, gui_id, get_uvalue=info
  about_plugins = info.pluginManager->getAboutPlugins()

  if is_struct(about_plugins) then begin
    ; add the items to the about plugins menu
      about_plugins_menu = lonarr(n_elements(about_plugins))
      for i=0, n_elements(about_plugins)-1 do $
          about_plugins_menu[i] = widget_button(aboutPluginButtons, $
            value=about_plugins[i].mission_name, uvalue='ABOUT:' $
            +about_plugins[i].mission_name+':'+about_plugins[i].text_file)
  endif else begin
    ; disable if there weren't any plugins loaded
    widget_control, aboutPluginButtons, sensitive = 0
  endelse
  
  aboutLabel = widget_label(aboutBase, value=' ', /align_center, SCR_XSIZE=500, SCR_YSIZE=20, UNITS=0)
  exitButton = widget_button(aboutBase, value = ' Close ', uvalue= 'QUIT', /align_center, scr_xsize = 150)

  widget_control, aboutBase, /realize
  xmanager, 'spd_ui_help_about', aboutBase, /no_block
end