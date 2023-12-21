;+
;
;PROCEDURE:       VEX_ASP_IMA_ENE_THETA
;
;PURPOSE:         
;                 Reads VEX/ASPERA-4 (IMA) Energy-Polar angle table.
;
;INPUTS:          time and polar angle indices.
;
;REFERENCE:       ftp://psa.esac.esa.int/pub/mirror/VENUS-EXPRESS/ASPERA4/VEX-V-SW-ASPERA-2-EXT4-IMA-V1.0/DOCUMENT/VE-ASP-TN-060402.PDF
;
;CREATED BY:      Takuya Hara on 2018-04-19.
;
;LAST MODIFICATION:
; $LastChangedBy: hara $
; $LastChangedDate: 2020-10-16 09:59:03 -0700 (Fri, 16 Oct 2020) $
; $LastChangedRevision: 29259 $
; $URL: svn+ssh://thmsvn@ambrosia.ssl.berkeley.edu/repos/spdsoft/tags/spedas_5_0/projects/vex/aspera/vex_asp_ima_ene_theta.pro $
;
;-
PRO vex_asp_ima_ene_theta, time, polar, energy=energy, theta=theta, verbose=verbose, eprom=eprom

  ndat    = N_ELEMENTS(time)
  nenergy = 96
  nbins   = 16
  nmass   = 32

  ; See, Table 1 at Ref. pp318 

  etable_v1 = [29999.9, 27629.1, 25444.8, 23431.6, 21581.6, 19871.5, 18301.3, 16855.5, $
               15526.2, 14298.1, 13163.2, 12121.6, 11165.5, 10287.1,  9470.9,  8724.7, $
                8032.9,  7395.5,  6812.5,  6276.1,  5778.7,  5320.0,  4900.3,  4511.6, $
                4155.7,  3828.1,  3524.6,  3246.5,  2989.7,  2753.1,  2535.1,  2334.6, $
                2150.0,  1980.2,  1823.8,  1679.4,  1547.0,  1424.0,  1311.7,  1208.7, $
                1112.5,  1024.2,   944.0,   869.1,   800.9,   736.7,   679.2,   625.8, $
                 576.3,   530.8,   488.0,   449.3,   414.5,   381.1,   351.7,   323.6, $
                 298.2,   274.1,   252.7,   232.7,   213.9,   197.9,   181.9,   167.1, $
                 153.8,   141.7,   131.0,   120.3,   111.0,   101.6,    93.6,    86.6, $
                  79.8,    73.5,    67.6,    62.3,    57.4,    52.8,    48.7,    44.8, $
                  41.3,    38.0,    35.0,    32.2,    29.7,    27.4,    25.2,    23.2, $
                  21.4,    19.7,    18.1,    16.7,    15.4,    14.1,    13.0,    12.0  ]


  ; See, https://irfpy.irf.se/projects/aspera/_modules/irfpy/vima/energy.html#get_default_table_v3

  etable_v3 = [20003.6, 18309.0, 16762.2, 15347.5, 14049.3, 12860.0, 11771.8, 10776.8, $
                9867.4,  9035.6,  8266.1,  7566.5,  6929.1,  6346.1,  5809.8,  5320.0, $
                4869.2,  4457.2,  4079.5,  3734.5,  3418.9,  3130.1,  2865.4,  2623.4, $
                2401.4,  2198.2,  2012.3,  1842.5,  1687.4,  1544.3,  1413.3,  1294.3, $
                1184.7,  1084.4,   993.5,   909.2,   831.7,   762.1,   698.0,   639.1, $
                 584.3,   534.8,   489.4,   447.9,   410.5,   375.7,   343.6,   315.6, $
                 288.8,   263.4,   242.0,   220.6,   201.9,   185.9,   169.8,   155.1, $
                 141.7,   129.7,   119.0,   109.6,   100.3,    90.9,    84.2,    76.7, $
                  70.2,    64.3,    58.8,    53.8,    49.3,    45.1,    41.3,    37.8, $
                  34.6,    31.7,    29.0,    26.6,    24.3,    22.3,    20.4,    18.7, $
                  17.1,    15.6,    14.3,    13.1,    12.0,    10.0,     8.0,     6.0, $
                   4.0,     2.0,     0.0,    -2.0,    -4.0,    -6.0,    -8.0,   -10.0  ]
 
  IF NOT KEYWORD_SET(eprom) THEN BEGIN
     etable = etable_v1
     energy = REBIN(etable, nenergy, nbins, nmass, ndat, /sample)
  ENDIF ELSE BEGIN
     etable = [ [etable_v1], [etable_v3] ]
     idx = INTARR(N_ELEMENTS(time))
     w = WHERE(eprom GT 0, nw)
     IF nw GT 0 THEN idx[w] = 1
     energy = TRANSPOSE(REBIN(etable[*, idx], nenergy, ndat, nbins, nmass, /sample), [0, 2, 3, 1])
  ENDELSE 
  energy = DOUBLE(TRANSPOSE(energy, [3, 0, 1, 2]))

  IF SIZE(polar, /type) EQ 0 THEN RETURN

  ; See, Table 2 at Ref. pp318-320
  the_table = [ [ -100, -100, -100, -100, -100, -14, -8.4, -2.8, 2.8, 8.4, 14, -100, -100, -100, -100, -100], $
                [ -100, -100, -100, -100, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, -100, -100, -100, -100], $
                [ -100, -100, -100, -100, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, -100, -100, -100, -100], $
                [ -100, -100, -100, -100, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, -100, -100, -100, -100], $
                [ -100, -100, -100, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, -100, -100, -100], $
                [ -100, -100, -100, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, -100, -100, -100], $
                [ -100, -100, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, -100, -100], $
                [ -100, -100, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, -100, -100], $
                [ -100, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, -100], $
                [ -100, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, -100], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -41.9, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.3, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.3, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -41.9, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -41.9, -36.3, -30.7, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.1, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -41.9, -36.3, -30.7, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.1, -19.5, -13.9, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.5, 25.2, 30.7, 36.4, 41.9], $
                [ -42, -36.3, -30.8, -25.2, -19.6, -14, -8.3, -2.8, 2.8, 8.4, 13.9, 19.6, 25.2, 30.8, 36.4, 41.9], $
                [ -42, -36.3, -30.8, -25.1, -19.6, -14, -8.4, -2.8, 2.8, 8.3, 14, 19.5, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.7, -25.1, -19.5, -13.9, -8.3, -2.7, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 41.9], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -41.9, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 41.9], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.5, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.7, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -41.9, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.9, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.3, -30.8, -25.1, -19.6, -13.9, -8.4, -2.7, 2.8, 8.3, 14, 19.6, 25.2, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.1, -19.6, -14, -8.4, -2.9, 2.8, 8.4, 13.9, 19.6, 25.2, 30.8, 36.3, 42], $
                [ -42, -36.3, -30.8, -25.2, -19.6, -13.9, -8.4, -2.8, 2.7, 8.4, 14, 19.6, 25.1, 30.8, 36.4, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.7, -13.9, -8.3, -2.8, 2.8, 8.4, 14, 19.6, 25.2, 30.8, 36.4, 41.9], $
                [ -42, -36.4, -30.9, -25.1, -19.5, -14, -8.4, -2.8, 2.7, 8.3, 14.1, 19.6, 25.2, 30.8, 36.4, 41.9], $
                [ -42, -36.4, -30.8, -25.1, -19.6, -13.9, -8.4, -2.7, 2.8, 8.3, 14, 19.5, 25.2, 30.8, 36.5, 42], $
                [ -42, -36.4, -30.8, -25.2, -19.6, -14, -8.4, -2.8, 2.8, 8.5, 14.1, 19.7, 25.3, 30.7, 36.3, 41.9], $
                [ -42, -36.4, -30.7, -25.2, -19.6, -13.9, -8.4, -2.8, 2.9, 8.3, 14, 19.7, 25.1, 30.8, 36.5, 41.9], $
                [ -42, -36.3, -30.8, -25.1, -19.7, -14, -8.5, -2.8, 2.9, 8.4, 14.1, 19.5, 25.2, 30.7, 36.4, 41.9], $
                [ -41.9, -36.4, -30.7, -25.3, -19.6, -13.9, -8.5, -3, 2.9, 8.4, 14, 19.5, 25.2, 30.9, 36.3, 42], $
                [ -42, -36.3, -30.7, -25.1, -19.7, -14, -8.4, -2.8, 2.9, 8.3, 13.9, 19.6, 25.2, 30.8, 36.5, 41.9], $
                [ -42.1, -36.2, -30.7, -25.2, -19.6, -14.1, -8.5, -2.7, 2.8, 8.4, 13.9, 19.5, 25.3, 30.9, 36.4, 42], $
                [ -41.9, -36.5, -30.8, -25.1, -19.7, -14, -8.3, -2.9, 2.8, 8.5, 13.9, 19.6, 25.3, 30.7, 36.4, 42.1], $
                [ -42.1, -36.5, -30.7, -25.2, -19.7, -13.8, -8.3, -2.8, 2.7, 8.5, 14, 19.5, 25, 30.9, 36.4, 41.9], $
                [ -41.9, -36.3, -30.7, -25.1, -19.5, -13.9, -8.3, -2.7, 2.9, 8.5, 14.1, 19.7, 25.3, 30.9, 36.5, 42.1], $
                [ -41.9, -36.2, -30.9, -25.2, -19.6, -13.9, -8.2, -2.9, 2.7, 8.4, 14.1, 19.8, 25, 30.7, 36.4, 42.1], $
                [ -41.9, -36.2, -30.9, -25.2, -19.5, -14.2, -8.5, -2.8, 3, 8.3, 14, 19.7, 25, 30.7, 36.5, 42.2], $
                [ -42.2, -36.5, -30.7, -25, -19.7, -14, -8.3, -3, 2.7, 8.5, 14.2, 19.5, 25.2, 31, 36.2, 42], $
                [ -42.2, -36.5, -30.8, -25.1, -19.3, -14.2, -8.4, -2.7, 3, 8.2, 13.9, 19.6, 25.3, 31, 36.2, 41.9], $
                [ -41.9, -36.2, -30.6, -25, -19.3, -14.2, -8.6, -3, 2.7, 8.3, 14, 19.6, 25.2, 30.9, 36.5, 42.2], $
                [ -41.8, -36.3, -30.8, -25.3, -19.8, -14.2, -8.1, -2.6, 2.9, 8.4, 13.9, 19.4, 25, 31.1, 36.6, 42.1], $
                [ -42.1, -36.1, -30.8, -25.4, -19.5, -14.1, -8.2, -2.8, 2.5, 8.5, 13.8, 19.8, 25.1, 31.1, 36.4, 41.7], $
                [ -42.1, -36.3, -30.5, -25.5, -19.7, -13.9, -8.9, -3.1, 2.7, 8.5, 14.3, 19.3, 25.1, 30.9, 36.6, 41.7], $
                [ -41.7, -36.3, -30.8, -25.3, -19.8, -14.3, -8, -2.6, 2.9, 8.4, 13.9, 19.4, 24.9, 31.2, 36.6, 42.1], $
                [ -41.9, -36, -30.9, -24.9, -19.8, -13.8, -8.7, -2.8, 3.2, 8.3, 14.3, 19.4, 25.3, 30.4, 36.4, 42.3], $
                [ -41.8, -36.3, -30.7, -25.2, -19.7, -14.1, -8.6, -3, 2.5, 8.1, 13.6, 19.2, 25.6, 31.2, 36.7, 42.3], $
                [ -42.4, -36.4, -30.4, -25.4, -19.3, -14.3, -8.3, -3.3, 2.7, 8.8, 13.8, 19.8, 24.8, 30.9, 35.9, 41.9], $
                [ -41.7, -36.2, -30.8, -25.3, -19.9, -14.5, -7.9, -2.5, 3, 8.4, 13.9, 19.3, 24.8, 30.2, 36.8, 42.2], $
                [ -41.7, -35.8, -31.1, -25.2, -19.2, -14.5, -8.6, -2.7, 3.2, 8, 13.9, 19.8, 25.7, 30.5, 36.4, 42.3], $
                [ -41.4, -36.3, -31.2, -24.8, -19.6, -15.8, -8, -2.9, 2.2, 8.7, 13.8, 20.2, 25.4, 30.5, 36.9, 42.1], $
                [ -42.2, -36.6, -31.1, -25.5, -19.9, -14.3, -8.7, -3.2, 2.4, 8, 13.6, 19.2, 24.8, 30.3, 35.9, 41.5], $
                [ -41.3, -36.8, -30.7, -24.6, -20.1, -14, -8, -3.4, 2.6, 8.7, 13.2, 19.3, 25.4, 31.4, 36, 42], $
                [ -41.6, -36.6, -30, -25.1, -20.2, -13.6, -8.7, -2.1, 2.9, 7.8, 14.4, 19.3, 25.9, 30.8, 35.8, 42.4], $
                [ -41.6, -36.2, -30.8, -25.5, -21.9, -14.8, -7.6, -2.3, 3.1, 8.5, 13.8, 19.2, 24.5, 29.9, 37.1, 42.4], $
                [ -41.2, -35.4, -31.5, -25.7, -19.9, -14.1, -8.3, -2.4, 3.4, 9.2, 13.1, 18.9, 24.7, 30.5, 36.4, 42.2], $
                [ -42.7, -36.4, -30, -25.8, -19.5, -13.2, -9, -2.7, 3.7, 7.9, 14.2, 20.5, 24.7, 31.1, 37.4, 41.6], $
                [ -41.8, -37.2, -30.3, -28, -18.9, -14.3, -7.5, -2.9, 1.7, 8.6, 13.1, 20, 24.6, 31.4, 36, 42.9], $
                [ -42.9, -35.4, -30.5, -25.5, -20.5, -13.1, -8.1, -3.1, 1.8, 9.3, 14.3, 19.2, 24.2, 31.6, 36.6, 41.6], $
                [ -41.2, -35.8, -33.1, -25, -19.6, -14.2, -8.8, -3.4, 2, 7.4, 12.8, 20.9, 26.3, 31.7, 37.1, 42.5], $
                [ -41.8, -35.9, -30.1, -24.2, -18.3, -15.4, -9.6, -3.7, 2.2, 8, 13.9, 19.7, 25.6, 31.5, 37.3, 43.2], $
                [ -42.2, -39, -29.5, -26.3, -19.9, -13.6, -7.2, -4, 2.4, 8.7, 15.1, 18.3, 24.6, 31, 37.3, 40.5], $
                [ -42.3, -35.4, -32, -25.1, -18.2, -14.7, -7.8, -4.4, 2.6, 9.5, 12.9, 19.8, 26.7, 30.2, 37.1, 40.5], $
                [ -46, -34.7, -31, -23.5, -19.7, -12.2, -8.5, -1, 2.8, 6.5, 14, 17.8, 25.3, 29, 36.5, 40.3], $
                [ -41.8, -37.7, -29.6, -25.5, -21.4, -13.3, -9.2, -1.1, 3, 7.1, 15.2, 19.3, 23.4, 31.5, 35.6, 43.7], $
                [ -40.9, -36.5, -32.1, -23.3, -18.8, -14.4, -10, -1.2, 3.3, 7.7, 12.1, 21, 25.4, 29.8, 34.2, 43.1], $
                [ -39.7, -34.9, -30.1, -25.3, -20.5, -15.7, -6.1, -1.3, 3.5, 8.3, 13.1, 17.9, 27.5, 32.3, 37.2, 42], $
                [ -43.1, -37.8, -32.6, -27.4, -17, -11.8, -6.6, -1.4, 3.9, 9.1, 14.3, 19.5, 24.7, 29.9, 35.1, 40.3]  ]
              
  theta = the_table[polar, *]
  theta = REBIN(theta, nbins, nmass, /sample)
  theta *= -1. ; looking direction -> particle moving direction

  RETURN
END 