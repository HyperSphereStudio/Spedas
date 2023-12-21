;+
;Function: IUG_LOAD_GMAG_WDC_VSNAMES
;function iug_load_gmag_wdc_vsnames
;
;Purpose:
;  return valid site names for WDC data.
;
;Notes:
;  This procedure is called from load procedures for WDC format data,
;  'iug_load_gmag_wdc*' provided by WDC Kyoto.
;  WDC station list was provided at online data catalogue:
;  https://wdc.kugi.kyoto-u.ac.jp/catmap/obs.html
;
;Todo:
;  1) Modify to read station-list file.
;  2) Modify to get station-list files from cgi or mdb via file_transfer.
;
;
;Written by:  Daiki Yoshida,  Sep 14, 2010
;
;-

function iug_load_gmag_wdc_vsnames
  vsites = 'dst ae sym asy wp'
  vsites = vsites + ' ' + $
    'ABB AAA AAE ABG ABK ABN ACR ADA AED AGN AHM AIA AIF ALE ALH ALM ALU AMD AML AMN AMS AMT AMU ANC ANK ANN ANO APA API AQU ARC ARE ARK ARS ASC ASH ASK ASO ASP AVE AVI AWS AWY BAG BAL BBG BDE BDV BEL BEY BFE BFO BGA BGY BIN BJI BJN BKC BKK BLC BLT BMT BNA BNG BOC BOD BOP BOU BOX BRD BRS BRT BRW BSL BTI BTV BUZ BYR CAI CAO CAT CAX CBB CBI CCL CCP CCS CDN CDP CDS CEV CFI CHR CHT CKA CLA CLB CLF CLH CLI CLL CMB CMO CNB CNH COI COP CPA CPI CPS CPY CRC CSR CSS CSY CTA CTO CTX CUS CWE CZA CZT DAL DAR DAV DBN DIK DLN DLR DLT DOB DOU DRS DRV DUR DVS EAA EBR EGS EIC EKP ELI ELT ENB ENK EPN ESA ESK ETT EUA EUS EYR FAN FCC FCP FMM FRA FRD FRL FRN FSM FSP FSV FTN FUQ FUR FYU GCK GDH GEL GEN GIB GIM GIR GIT GJO GLM GLN GNA GRM GRW GTT GUA GUI GVD GWC GZH HAD HAN HBA HBK HBT HCR HEA HER HII HIS HKC HLL HLP HLS HLW HNA HON HRB HRI HRN HTY HUA HUS HVN HYB IBD INK IQA IRT ISC ISK ISL IVA IVI IZN JAI JOP JRV JUL KAK KAM KAR KDU KEM KGD KHB KHS KIR KIV KND KNG KNT KNY KNZ KOD KOR KOT KOU KRC KSA KSH KTG KTS KUM KUY KWJ KZA KZN LAA LAS LAU LDV LED LER LGR LIV LMD LMM LNN LNP LOB LOC LOV LOZ LPB LQA LRM LRV LSA LUA LUC LUK LVV LWI LYC LYN LZH LZV MAB MAN MAW MBC MBO MCL MCM MCP MCQ MDS MEA MEL MEV MFP MGD MGS MID MIR MIZ MJR MKL MLT MMB MMH MMK MNH MNK MNN MOG MOL MOS MRI MRN MUB MUT MWC MZL NAI NAL NAQ NCK NDA NEW NGK NGP NHO NKK NMP NMT NOK NOW NPF NPG NPH NPJ NPL NPM NRD NRW NSM NTS NUR NVL NVS NWP NWS NYI OAS ODE OKN ONW ORC OTT OUJ PAB PAF PAG PAI PBK PBQ PCU PEB PEG PET PHU PIL PIO PIU PLS PMG PND PNN POD POK POL POT PPT PRU PSM PST PTS PTU QGZ QIX QSB QUE QZH RAC RBD RDJ RES RIT ROB ROD RPC RSV RYB SAB SAH SAS SBA SCO SDH SED SEO SEY SFS SGG SHB SHL SHT SHU SIL SIM SIT SJG SKT SLU SMG SNA SNK SOD SOG SOR SOU SPA SPB SPL SPT SRE SRO SSH SSO STF STJ STO SUA SUB SVD SWI SYO SZT TAL TAM TAN TEH TEO TEV TFS THJ THL THU THY TIK TIP TIR TJO TKH TKT TLK TMB TMK TMP TNB TND TNG TOK TOL TOO TPA TRD TRO TRW TST TSU TTB TUC TUL TUM TUN UBA UGT UJJ UKH UMA UPS URC VAL VIC VLA VLJ VNA VOS VQS VSK VSS WAT WES WHN WHS WIA WIK WIL WIT WKE WLH WMQ WNG WNP WRH YAK YAU YCB YKC YSH YSS ZAR ZKW ZUY'

  vsnames = strsplit(strlowcase(vsites), ' ', /extract)

  return, vsnames
end
