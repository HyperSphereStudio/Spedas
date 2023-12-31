FUNCTION sppeva_orbit_history
  compile_opt idl2
  orbit = [$ 
    '11-10-2018 00:00:00        11-13-2018 24:00:00',$;Test
    '08-12-2018 08:15:14        01-20-2019 01:03:58',$;1
    '01-20-2019 01:03:58        06-18-2019 20:15:09',$;2
    '06-18-2019 20:15:09        11-15-2019 15:24:35',$;3
    '11-15-2019 15:24:35        04-03-2020 08:59:48',$;4
    '04-03-2020 08:59:48        08-02-2020 05:01:09',$;5
    '08-02-2020 05:01:09        11-22-2020 13:24:34',$;6
    '11-22-2020 13:24:34        03-09-2021 03:35:46',$;7
    '03-09-2021 03:35:46        06-19-2021 13:58:51',$;8
    '06-19-2021 13:58:51        09-30-2021 00:21:59',$;9
    '09-30-2021 00:21:59        01-08-2022 12:02:45',$;10
    '01-08-2022 12:02:45        04-14-2022 19:16:34',$;11
    '04-14-2022 19:16:34        07-20-2022 02:29:31',$;12
    '07-20-2022 02:29:31        10-24-2022 09:41:34',$;13
    '10-24-2022 09:41:34        01-28-2023 16:54:35',$;14
    '01-28-2023 16:54:35        05-05-2023 00:09:40',$;15
    '05-05-2023 00:09:40        08-09-2023 07:24:16',$;16
    '08-09-2023 07:24:16        11-13-2023 00:12:59',$;17
    '11-13-2023 00:12:59        02-13-2024 01:37:40',$;18
    '02-13-2024 01:37:40        05-15-2024 03:02:14',$;19
    '05-15-2024 03:02:14        08-15-2024 04:27:39',$;20
    '08-15-2024 04:27:39        11-10-2024 05:58:35',$;21
    '11-10-2024 05:58:35        02-06-2025 16:35:15',$;22
    '02-06-2025 16:35:15        05-06-2025 03:12:42',$;23
    '05-06-2025 03:12:42        08-02-2025 13:50:18'];24
  mmax = n_elements(orbit)
  stime = strarr(mmax)
  etime = strarr(mmax)
  for m=0,mmax-1 do begin
    stime[m] = time_string(time_double(strmid(orbit[m],0,19),tformat='MM-DD-YYYY hh:mm:ss'))
    etime[m] = time_string(time_double(strmid(orbit[m],27,19),tformat='MM-DD-YYYY hh:mm:ss'))
  endfor
  orbHist = {stime:stime, etime:etime}
  return, orbHist
END
