;+
;FUNCTION:   nn2
;PURPOSE:
;  Returns the indices of the nearest neighbors in one time array to the
;  times in a second array.  This routine is MUCH faster than nn.pro.
;  Based on an idea by Shaosui Xu.
;
;  If times outside the range of the first time array are present, 
;  the index of the first or last element of the first time array
;  will be taken as the nearest neighbor.  Use keyword MAXDT to ensure
;  reasonable output.
;
;USAGE:
;  i = nn2(time1, time2)
;
;INPUTS:
;   time1:      Input time array, in any format accepted by time double.
;               Must be monotonically increasing or decreasing.
;
;   time2:      Another time array, in any format accepted by time_double,
;               for which you want the indices of the nearest neighbors in
;               time1.
;
;OUTPUTS:
;   i:          Indices of the nearest neighbors in time1 to the elements of
;               time2.  Note that i indexes time1 and has the same number of
;               elements as time2.
;
;KEYWORDS:
;
;   MAXDT:      Maximum time difference in seconds between an element of 
;               time2 and its nearest neighbor in time1.  If exceeded, the
;               corresponding index will be set to -1.
;
;               Note: Later versions of IDL allow -1 as a valid array index,
;               so you must filter the output of this routine before using
;               it to index an array.
;
;   VALID:      Remove all occurrences of -1 from array before returning.
;
;   VINDEX:     Indicies of time2 with valid neighbors in time1.
;
;                   time1[i] <--> time2[VINDEX]
;
; $LastChangedBy: dmitchell $
; $LastChangedDate: 2020-09-07 12:21:29 -0700 (Mon, 07 Sep 2020) $
; $LastChangedRevision: 29120 $
; $URL: svn+ssh://thmsvn@ambrosia.ssl.berkeley.edu/repos/spdsoft/tags/spedas_5_0/general/misc/nn2.pro $
;
;CREATED BY:	David L. Mitchell  2018-08-23
;FILE:  nn2.pro
;-
function nn2, time1, time2, maxdt=maxdt, valid=valid, vindex=vindex

  t1 = time_double(time1)
  n = n_elements(t1)
  t2 = time_double(time2)
  i = round(interpol(dindgen(n), t1, t2)) > 0L < (n-1L) ;-)

  if (size(maxdt,/type) gt 0) then begin
    j = where(abs(t2 - t1[i]) gt min(abs(double(maxdt))), count)
    if (count gt 0L) then i[j] = -1L
  endif

  if keyword_set(valid) then begin
    j = where(i ge 0L, count)
    if (count gt 0L) then i = i[j] else i = -1L
    vindex = j
  endif

  return, i

end
