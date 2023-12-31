C-----------------------------------------------------------------------
C
C  NSSDC/CDF                       Include file for FORTRAN interface.
C
C  Version 3.4a, 21-Feb-97, Hughes STX.
C
C  Modification history:
C
C   V1.0  22-Jan-91, J Love     Original version (for CDF V2.0).
C   V2.0  28-May-91, J Love     Modified for CDF V2.1 enhancements.
C   V2.1   2-Aug-91, J Love     Increment for CDF V2.1.2.  Added
C				declarations for library functions.
C				Renamed a few items.
C   V3.0  19-May-92, J Love     IBM PC & HP port.  CDF V2.2.
C   V3.1  23-Sep-92, J Love     CDF V2.3 (shareable/NeXT/zVar).
C   V3.1a  5-Oct-92, J Love     CDF V2.3.0a (NeXT/encoding).
C   V3.1b  6-Oct-92, J Love     CDF V2.3.0b (CDFcompare).
C   V3.1c 27-Oct-92, J Love     CDF V2.3.0c (pad values).
C   V3.2  12-Jan-94, J Love     CDF V2.4.
C   V3.2a  4-Feb-94, J Love	DEC Alpha/OpenVMS port.
C   V3.2b 22-Feb-94, J Love	Spelling lesson.  Shortened all lines
C				to 72 columns or less.
C   V3.3  20-Dec-94, J Love	CDF V2.5.
C   V3.3a 12-Jun-95, J Love	EPOCH custom format.
C   V3.4  16-Sep-96, J Love	CDF V2.6.
C   V3.4a 21-Feb-97, J Love	Removed RICE.
C
C-----------------------------------------------------------------------

C-----------------------------------------------------------------------
C Limits.
C-----------------------------------------------------------------------

	INTEGER*4 CDF_MIN_DIMS
	PARAMETER (CDF_MIN_DIMS = 0)

	INTEGER*4 CDF_MAX_DIMS
	PARAMETER (CDF_MAX_DIMS = 10)

C-----------------------------------------------------------------------
C Lengths.
C-----------------------------------------------------------------------

	INTEGER*4 CDF_VAR_NAME_LEN
	PARAMETER (CDF_VAR_NAME_LEN = 64)

	INTEGER*4 CDF_ATTR_NAME_LEN
	PARAMETER (CDF_ATTR_NAME_LEN = 64)

	INTEGER*4 CDF_COPYRIGHT_LEN
	PARAMETER (CDF_COPYRIGHT_LEN = 256)

	INTEGER*4 CDF_STATUSTEXT_LEN
	PARAMETER (CDF_STATUSTEXT_LEN = 80)

	INTEGER*4 CDF_PATHNAME_LEN
	PARAMETER (CDF_PATHNAME_LEN = 128)

	INTEGER*4 EPOCH_STRING_LEN
	PARAMETER (EPOCH_STRING_LEN = 24)

	INTEGER*4 EPOCH1_STRING_LEN
	PARAMETER (EPOCH1_STRING_LEN = 16)

	INTEGER*4 EPOCH2_STRING_LEN
	PARAMETER (EPOCH2_STRING_LEN = 14)

	INTEGER*4 EPOCH3_STRING_LEN
	PARAMETER (EPOCH3_STRING_LEN = 24)

	INTEGER*4 EPOCHx_STRING_MAX
	PARAMETER (EPOCHx_STRING_MAX = 30)

	INTEGER*4 EPOCHx_FORMAT_MAX
	PARAMETER (EPOCHx_FORMAT_MAX = 60)

C-----------------------------------------------------------------------
C Data types.
C-----------------------------------------------------------------------

	INTEGER*4 CDF_INT1
	PARAMETER (CDF_INT1 = 1)

	INTEGER*4 CDF_INT2
	PARAMETER (CDF_INT2 = 2)

	INTEGER*4 CDF_INT4
	PARAMETER (CDF_INT4 = 4)

	INTEGER*4 CDF_UINT1
	PARAMETER (CDF_UINT1 = 11)

	INTEGER*4 CDF_UINT2
	PARAMETER (CDF_UINT2 = 12)

	INTEGER*4 CDF_UINT4
	PARAMETER (CDF_UINT4 = 14)

	INTEGER*4 CDF_REAL4
	PARAMETER (CDF_REAL4 = 21)

	INTEGER*4 CDF_REAL8
	PARAMETER (CDF_REAL8 = 22)

	INTEGER*4 CDF_EPOCH
	PARAMETER (CDF_EPOCH = 31)

	INTEGER*4 CDF_BYTE
	PARAMETER (CDF_BYTE = 41)

	INTEGER*4 CDF_FLOAT
	PARAMETER (CDF_FLOAT = 44)

	INTEGER*4 CDF_DOUBLE
	PARAMETER (CDF_DOUBLE = 45)

	INTEGER*4 CDF_CHAR
	PARAMETER (CDF_CHAR = 51)

	INTEGER*4 CDF_UCHAR
	PARAMETER (CDF_UCHAR = 52)

C-----------------------------------------------------------------------
C Encodings.
C-----------------------------------------------------------------------

	INTEGER*4 NETWORK_ENCODING
	PARAMETER (NETWORK_ENCODING = 1)

	INTEGER*4 SUN_ENCODING
	PARAMETER (SUN_ENCODING = 2)

	INTEGER*4 VAX_ENCODING
	PARAMETER (VAX_ENCODING = 3)

	INTEGER*4 DECSTATION_ENCODING
	PARAMETER (DECSTATION_ENCODING = 4)

	INTEGER*4 SGi_ENCODING
	PARAMETER (SGi_ENCODING = 5)

	INTEGER*4 IBMPC_ENCODING
	PARAMETER (IBMPC_ENCODING = 6)

	INTEGER*4 IBMRS_ENCODING
	PARAMETER (IBMRS_ENCODING = 7)

	INTEGER*4 HOST_ENCODING
	PARAMETER (HOST_ENCODING = 8)

	INTEGER*4 MAC_ENCODING
	PARAMETER (MAC_ENCODING = 9)

	INTEGER*4 HP_ENCODING
	PARAMETER (HP_ENCODING = 11)

	INTEGER*4 NeXT_ENCODING
	PARAMETER (NeXT_ENCODING = 12)

	INTEGER*4 ALPHAOSF1_ENCODING
	PARAMETER (ALPHAOSF1_ENCODING = 13)

	INTEGER*4 ALPHAVMSd_ENCODING
	PARAMETER (ALPHAVMSd_ENCODING = 14)

	INTEGER*4 ALPHAVMSg_ENCODING
	PARAMETER (ALPHAVMSg_ENCODING = 15)

C-----------------------------------------------------------------------
C Decodings.
C-----------------------------------------------------------------------

	INTEGER*4 NETWORK_DECODING
	PARAMETER (NETWORK_DECODING = NETWORK_ENCODING)

	INTEGER*4 SUN_DECODING
	PARAMETER (SUN_DECODING = SUN_ENCODING)

	INTEGER*4 VAX_DECODING
	PARAMETER (VAX_DECODING = VAX_ENCODING)

	INTEGER*4 DECSTATION_DECODING
	PARAMETER (DECSTATION_DECODING = DECSTATION_ENCODING)

	INTEGER*4 SGi_DECODING
	PARAMETER (SGi_DECODING = SGi_ENCODING)

	INTEGER*4 IBMPC_DECODING
	PARAMETER (IBMPC_DECODING = IBMPC_ENCODING)

	INTEGER*4 IBMRS_DECODING
	PARAMETER (IBMRS_DECODING = IBMRS_ENCODING)

	INTEGER*4 HOST_DECODING
	PARAMETER (HOST_DECODING = HOST_ENCODING)

	INTEGER*4 MAC_DECODING
	PARAMETER (MAC_DECODING = MAC_ENCODING)

	INTEGER*4 HP_DECODING
	PARAMETER (HP_DECODING = HP_ENCODING)

	INTEGER*4 NeXT_DECODING
	PARAMETER (NeXT_DECODING = NeXT_ENCODING)

	INTEGER*4 ALPHAOSF1_DECODING
	PARAMETER (ALPHAOSF1_DECODING = ALPHAOSF1_ENCODING)

	INTEGER*4 ALPHAVMSd_DECODING
	PARAMETER (ALPHAVMSd_DECODING = ALPHAVMSd_ENCODING)

	INTEGER*4 ALPHAVMSg_DECODING
	PARAMETER (ALPHAVMSg_DECODING = ALPHAVMSg_ENCODING)

C-----------------------------------------------------------------------
C Variances (record and dimension).
C-----------------------------------------------------------------------

	INTEGER*4 VARY
	PARAMETER (VARY = -1)

	INTEGER*4 NOVARY
	PARAMETER (NOVARY = 0)

C-----------------------------------------------------------------------
C Majorities.
C-----------------------------------------------------------------------

	INTEGER*4 ROW_MAJOR
	PARAMETER (ROW_MAJOR = 1)

	INTEGER*4 COLUMN_MAJOR
	PARAMETER (COLUMN_MAJOR = 2)

C-----------------------------------------------------------------------
C Formats.
C-----------------------------------------------------------------------

	INTEGER*4 SINGLE_FILE
	PARAMETER (SINGLE_FILE = 1)

	INTEGER*4 MULTI_FILE
	PARAMETER (MULTI_FILE = 2)

C-----------------------------------------------------------------------
C Scopes.
C-----------------------------------------------------------------------

	INTEGER*4 GLOBAL_SCOPE
	PARAMETER (GLOBAL_SCOPE = 1)

	INTEGER*4 VARIABLE_SCOPE
	PARAMETER (VARIABLE_SCOPE = 2)

C-----------------------------------------------------------------------
C Readonly modes.
C-----------------------------------------------------------------------

	INTEGER*4 READONLYon
	PARAMETER (READONLYon = -1)

	INTEGER*4 READONLYoff
	PARAMETER (READONLYoff = 0)

C-----------------------------------------------------------------------
C zModes.
C-----------------------------------------------------------------------

	INTEGER*4 zMODEoff
	PARAMETER (zMODEoff = 0)

	INTEGER*4 zMODEon1
	PARAMETER (zMODEon1 = 1)

	INTEGER*4 zMODEon2
	PARAMETER (zMODEon2 = 2)

C-----------------------------------------------------------------------
C Negative to positive floating point zero modes.
C-----------------------------------------------------------------------

	INTEGER*4 NEGtoPOSfp0on
	PARAMETER (NEGtoPOSfp0on = -1)

	INTEGER*4 NEGtoPOSfp0off
	PARAMETER (NEGtoPOSfp0off = 0)

C-----------------------------------------------------------------------
C Compression/sparseness constants.
C-----------------------------------------------------------------------

	INTEGER*4 CDF_MAX_PARMS
	PARAMETER (CDF_MAX_PARMS = 5)

	INTEGER*4 NO_COMPRESSION
	PARAMETER (NO_COMPRESSION = 0)

	INTEGER*4 RLE_COMPRESSION
	PARAMETER (RLE_COMPRESSION = 1)

	INTEGER*4 HUFF_COMPRESSION
	PARAMETER (HUFF_COMPRESSION = 2)

	INTEGER*4 AHUFF_COMPRESSION
	PARAMETER (AHUFF_COMPRESSION = 3)

	INTEGER*4 GZIP_COMPRESSION
	PARAMETER (GZIP_COMPRESSION = 5)

	INTEGER*4 RLE_OF_ZEROs
	PARAMETER (RLE_OF_ZEROs = 0)

	INTEGER*4 OPTIMAL_ENCODING_TREES
	PARAMETER (OPTIMAL_ENCODING_TREES = 0)

	INTEGER*4 NO_SPARSEARRAYS
	PARAMETER (NO_SPARSEARRAYS = 0)

	INTEGER*4 NO_SPARSERECORDS
	PARAMETER (NO_SPARSERECORDS = 0)

	INTEGER*4 PAD_SPARSERECORDS
	PARAMETER (PAD_SPARSERECORDS = 1)

	INTEGER*4 PREV_SPARSERECORDS
	PARAMETER (PREV_SPARSERECORDS = 2)

C-----------------------------------------------------------------------
C Status codes.
C-----------------------------------------------------------------------

C       !---------------------------------------------------------------
C       ! INFO codes.
C       !---------------------------------------------------------------

	INTEGER*4 VIRTUAL_RECORD_DATA
	PARAMETER (VIRTUAL_RECORD_DATA = 1001)

	INTEGER*4 DID_NOT_COMPRESS
	PARAMETER (DID_NOT_COMPRESS = 1002)

	INTEGER*4 VAR_ALREADY_CLOSED
	PARAMETER (VAR_ALREADY_CLOSED = 1003)

	INTEGER*4 SINGLE_FILE_FORMAT
	PARAMETER (SINGLE_FILE_FORMAT = 1004)

	INTEGER*4 NO_PADVALUE_SPECIFIED
	PARAMETER (NO_PADVALUE_SPECIFIED = 1005)

	INTEGER*4 NO_VARS_IN_CDF
	PARAMETER (NO_VARS_IN_CDF = 1006)

	INTEGER*4 MULTI_FILE_FORMAT
	PARAMETER (MULTI_FILE_FORMAT = 1007)

	INTEGER*4 SOME_ALREADY_ALLOCATED
	PARAMETER (SOME_ALREADY_ALLOCATED = 1008)

	INTEGER*4 PRECEEDING_RECORDS_ALLOCATED
	PARAMETER (PRECEEDING_RECORDS_ALLOCATED = 1009)

C       !---------------------------------------------------------------
C       ! OK code.
C       !---------------------------------------------------------------

	INTEGER*4 CDF_OK
	PARAMETER (CDF_OK = 0)

C       !---------------------------------------------------------------
C       ! WARNING codes.
C       !---------------------------------------------------------------

	INTEGER*4 ATTR_NAME_TRUNC
	PARAMETER (ATTR_NAME_TRUNC = -1001)

	INTEGER*4 CDF_NAME_TRUNC
	PARAMETER (CDF_NAME_TRUNC = -1002)

	INTEGER*4 VAR_NAME_TRUNC
	PARAMETER (VAR_NAME_TRUNC = -1003)

	INTEGER*4 NEGATIVE_FP_ZERO
	PARAMETER (NEGATIVE_FP_ZERO = -1004)

C	-1005 unused.

	INTEGER*4 FORCED_PARAMETER
	PARAMETER (FORCED_PARAMETER = -1006)

	INTEGER*4 NA_FOR_VARIABLE
	PARAMETER (NA_FOR_VARIABLE = -1007)

C       !---------------------------------------------------------------
C       ! Warning threshold, not actually a status code.
C       !---------------------------------------------------------------

	INTEGER*4 CDF_WARN
	PARAMETER (CDF_WARN = -2000)

C       !---------------------------------------------------------------
C       ! ERROR codes.
C       !---------------------------------------------------------------

	INTEGER*4 ATTR_EXISTS
	PARAMETER (ATTR_EXISTS = -2001)

	INTEGER*4 BAD_CDF_ID
	PARAMETER (BAD_CDF_ID = -2002)

	INTEGER*4 BAD_DATA_TYPE
	PARAMETER (BAD_DATA_TYPE = -2003)

	INTEGER*4 BAD_DIM_SIZE
	PARAMETER (BAD_DIM_SIZE = -2004)

	INTEGER*4 BAD_DIM_INDEX
	PARAMETER (BAD_DIM_INDEX = -2005)

	INTEGER*4 BAD_ENCODING
	PARAMETER (BAD_ENCODING = -2006)

	INTEGER*4 BAD_MAJORITY
	PARAMETER (BAD_MAJORITY = -2007)

	INTEGER*4 BAD_NUM_DIMS
	PARAMETER (BAD_NUM_DIMS = -2008)

	INTEGER*4 BAD_REC_NUM
	PARAMETER (BAD_REC_NUM = -2009)

	INTEGER*4 BAD_SCOPE
	PARAMETER (BAD_SCOPE = -2010)

	INTEGER*4 BAD_NUM_ELEMS
	PARAMETER (BAD_NUM_ELEMS = -2011)

	INTEGER*4 CDF_OPEN_ERROR
	PARAMETER (CDF_OPEN_ERROR = -2012)

	INTEGER*4 CDF_EXISTS
	PARAMETER (CDF_EXISTS = -2013)

	INTEGER*4 BAD_FORMAT
	PARAMETER (BAD_FORMAT = -2014)

	INTEGER*4 BAD_ALLOCATE_RECS
	PARAMETER (BAD_ALLOCATE_RECS = -2015)

	INTEGER*4 BAD_CDF_EXTENSION
	PARAMETER (BAD_CDF_EXTENSION = -2016)

	INTEGER*4 NO_SUCH_ATTR
	PARAMETER (NO_SUCH_ATTR = -2017)

	INTEGER*4 NO_SUCH_ENTRY
	PARAMETER (NO_SUCH_ENTRY = -2018)

	INTEGER*4 NO_SUCH_VAR
	PARAMETER (NO_SUCH_VAR = -2019)

	INTEGER*4 VAR_READ_ERROR
	PARAMETER (VAR_READ_ERROR = -2020)

	INTEGER*4 VAR_WRITE_ERROR
	PARAMETER (VAR_WRITE_ERROR = -2021)

	INTEGER*4 BAD_ARGUMENT
	PARAMETER (BAD_ARGUMENT = -2022)

	INTEGER*4 IBM_PC_OVERFLOW
	PARAMETER (IBM_PC_OVERFLOW = -2023)

	INTEGER*4 TOO_MANY_VARS
	PARAMETER (TOO_MANY_VARS = -2024)

	INTEGER*4 VAR_EXISTS
	PARAMETER (VAR_EXISTS = -2025)

	INTEGER*4 BAD_MALLOC
	PARAMETER (BAD_MALLOC = -2026)

	INTEGER*4 NOT_A_CDF
	PARAMETER (NOT_A_CDF = -2027)

	INTEGER*4 CORRUPTED_V2_CDF
	PARAMETER (CORRUPTED_V2_CDF = -2028)

	INTEGER*4 VAR_OPEN_ERROR
	PARAMETER (VAR_OPEN_ERROR = -2029)

	INTEGER*4 BAD_INITIAL_RECS
	PARAMETER (BAD_INITIAL_RECS = -2030)

	INTEGER*4 BAD_BLOCKING_FACTOR
	PARAMETER (BAD_BLOCKING_FACTOR = -2031)

	INTEGER*4 END_OF_VAR
	PARAMETER (END_OF_VAR = -2032)

C	-2033 unused.

	INTEGER*4 BAD_CDFSTATUS
	PARAMETER (BAD_CDFSTATUS = -2034)

	INTEGER*4 CDF_INTERNAL_ERROR
	PARAMETER (CDF_INTERNAL_ERROR = -2035)

	INTEGER*4 BAD_NUM_VARS
	PARAMETER (BAD_NUM_VARS = -2036)

	INTEGER*4 BAD_REC_COUNT
	PARAMETER (BAD_REC_COUNT = -2037)

	INTEGER*4 BAD_REC_INTERVAL
	PARAMETER (BAD_REC_INTERVAL = -2038)

	INTEGER*4 BAD_DIM_COUNT
	PARAMETER (BAD_DIM_COUNT = -2039)

	INTEGER*4 BAD_DIM_INTERVAL
	PARAMETER (BAD_DIM_INTERVAL = -2040)

	INTEGER*4 BAD_VAR_NUM
	PARAMETER (BAD_VAR_NUM = -2041)

	INTEGER*4 BAD_ATTR_NUM
	PARAMETER (BAD_ATTR_NUM = -2042)

	INTEGER*4 BAD_ENTRY_NUM
	PARAMETER (BAD_ENTRY_NUM = -2043)

	INTEGER*4 BAD_ATTR_NAME
	PARAMETER (BAD_ATTR_NAME = -2044)

	INTEGER*4 BAD_VAR_NAME
	PARAMETER (BAD_VAR_NAME = -2045)

	INTEGER*4 NO_ATTR_SELECTED
	PARAMETER (NO_ATTR_SELECTED = -2046)

	INTEGER*4 NO_ENTRY_SELECTED
	PARAMETER (NO_ENTRY_SELECTED = -2047)

	INTEGER*4 NO_VAR_SELECTED
	PARAMETER (NO_VAR_SELECTED = -2048)

	INTEGER*4 BAD_CDF_NAME
	PARAMETER (BAD_CDF_NAME = -2049)

C	-2050 unused.

	INTEGER*4 CANNOT_CHANGE
	PARAMETER (CANNOT_CHANGE = -2051)

	INTEGER*4 NO_STATUS_SELECTED
	PARAMETER (NO_STATUS_SELECTED = -2052)

	INTEGER*4 NO_CDF_SELECTED
	PARAMETER (NO_CDF_SELECTED = -2053)

	INTEGER*4 READ_ONLY_DISTRIBUTION
	PARAMETER (READ_ONLY_DISTRIBUTION = -2054)

	INTEGER*4 CDF_CLOSE_ERROR
	PARAMETER (CDF_CLOSE_ERROR = -2055)

	INTEGER*4 VAR_CLOSE_ERROR
	PARAMETER (VAR_CLOSE_ERROR = -2056)

C	-2057 unused.

	INTEGER*4 BAD_FNC_OR_ITEM
	PARAMETER (BAD_FNC_OR_ITEM = -2058)

C	-2059 unused.

	INTEGER*4 ILLEGAL_ON_V1_CDF
	PARAMETER (ILLEGAL_ON_V1_CDF = -2060)

C	-2061 unused.
C	-2062 unused.

	INTEGER*4 BAD_CACHE_SIZE
	PARAMETER (BAD_CACHE_SIZE = -2063)

C	-2064 unused.
C	-2065 unused.

	INTEGER*4 CDF_CREATE_ERROR
	PARAMETER (CDF_CREATE_ERROR = -2066)

	INTEGER*4 NO_SUCH_CDF
	PARAMETER (NO_SUCH_CDF = -2067)

	INTEGER*4 VAR_CREATE_ERROR
	PARAMETER (VAR_CREATE_ERROR = -2068)

C	-2069 unused.

	INTEGER*4 READ_ONLY_MODE
	PARAMETER (READ_ONLY_MODE = -2070)

	INTEGER*4 ILLEGAL_IN_zMODE
	PARAMETER (ILLEGAL_IN_zMODE = -2071)

	INTEGER*4 BAD_zMODE
	PARAMETER (BAD_zMODE = -2072)

	INTEGER*4 BAD_READONLY_MODE
	PARAMETER (BAD_READONLY_MODE = -2073)

	INTEGER*4 CDF_READ_ERROR
	PARAMETER (CDF_READ_ERROR = -2074)

	INTEGER*4 CDF_WRITE_ERROR
	PARAMETER (CDF_WRITE_ERROR = -2075)

	INTEGER*4 ILLEGAL_FOR_SCOPE
	PARAMETER (ILLEGAL_FOR_SCOPE = -2076)

	INTEGER*4 NO_MORE_ACCESS
	PARAMETER (NO_MORE_ACCESS = -2077)

C	-2078 unused.

	INTEGER*4 BAD_DECODING
	PARAMETER (BAD_DECODING = -2079)

C	-2080 unused.

	INTEGER*4 BAD_NEGtoPOSfp0_MODE
	PARAMETER (BAD_NEGtoPOSfp0_MODE = -2081)

	INTEGER*4 UNSUPPORTED_OPERATION
	PARAMETER (UNSUPPORTED_OPERATION = -2082)

C	-2083 unused.
C	-2084 unused.
C	-2085 unused.

	INTEGER*4 NO_WRITE_ACCESS
	PARAMETER (NO_WRITE_ACCESS = -2086)

	INTEGER*4 NO_DELETE_ACCESS
	PARAMETER (NO_DELETE_ACCESS = -2087)

	INTEGER*4 CDF_DELETE_ERROR
	PARAMETER (CDF_DELETE_ERROR = -2088)

	INTEGER*4 VAR_DELETE_ERROR
	PARAMETER (VAR_DELETE_ERROR = -2089)

	INTEGER*4 UNKNOWN_COMPRESSION
	PARAMETER (UNKNOWN_COMPRESSION = -2090)

	INTEGER*4 CANNOT_COMPRESS
	PARAMETER (CANNOT_COMPRESS = -2091)

	INTEGER*4 DECOMPRESSION_ERROR
	PARAMETER (DECOMPRESSION_ERROR = -2092)

	INTEGER*4 COMPRESSION_ERROR
	PARAMETER (COMPRESSION_ERROR = -2093)

C	-2094 unused.
C	-2095 unused.

	INTEGER*4 EMPTY_COMPRESSED_CDF
	PARAMETER (EMPTY_COMPRESSED_CDF = -2096)

	INTEGER*4 BAD_COMPRESSION_PARM
	PARAMETER (BAD_COMPRESSION_PARM = -2097)

	INTEGER*4 UNKNOWN_SPARSENESS
	PARAMETER (UNKNOWN_SPARSENESS = -2098)

	INTEGER*4 CANNOT_SPARSERECORDS
	PARAMETER (CANNOT_SPARSERECORDS = -2099)

	INTEGER*4 CANNOT_SPARSEARRAYS
	PARAMETER (CANNOT_SPARSEARRAYS = -2100)

	INTEGER*4 TOO_MANY_PARMS
	PARAMETER (TOO_MANY_PARMS = -2101)

	INTEGER*4 NO_SUCH_RECORD
	PARAMETER (NO_SUCH_RECORD = -2102)

	INTEGER*4 CANNOT_ALLOCATE_RECORDS
	PARAMETER (CANNOT_ALLOCATE_RECORDS = -2103)

C	-2104 unused.
C	-2105 unused.

	INTEGER*4 SCRATCH_DELETE_ERROR
	PARAMETER (SCRATCH_DELETE_ERROR = -2106)

	INTEGER*4 SCRATCH_CREATE_ERROR
	PARAMETER (SCRATCH_CREATE_ERROR = -2107)

	INTEGER*4 SCRATCH_READ_ERROR
	PARAMETER (SCRATCH_READ_ERROR = -2108)

	INTEGER*4 SCRATCH_WRITE_ERROR
	PARAMETER (SCRATCH_WRITE_ERROR = -2109)

	INTEGER*4 BAD_SPARSEARRAYS_PARM
	PARAMETER (BAD_SPARSEARRAYS_PARM = -2110)

	INTEGER*4 BAD_SCRATCH_DIR
	PARAMETER (BAD_SCRATCH_DIR = -2111)

C-----------------------------------------------------------------------
C Functions (for INTERNAL interface).
C NOTE: These values must be different from those of the items.
C-----------------------------------------------------------------------

	INTEGER*4 CREATE_
	PARAMETER (CREATE_ = 1001)

	INTEGER*4 OPEN_
	PARAMETER (OPEN_ = 1002)

	INTEGER*4 DELETE_
	PARAMETER (DELETE_ = 1003)

	INTEGER*4 CLOSE_
	PARAMETER (CLOSE_ = 1004)

	INTEGER*4 SELECT_
	PARAMETER (SELECT_ = 1005)

	INTEGER*4 CONFIRM_
	PARAMETER (CONFIRM_ = 1006)

	INTEGER*4 GET_
	PARAMETER (GET_ = 1007)

	INTEGER*4 PUT_
	PARAMETER (PUT_ = 1008)

	INTEGER*4 NULL_
	PARAMETER (NULL_ = 1000)

C-----------------------------------------------------------------------
C Items on which functions are performed (for INTERNAL interface).
C NOTE: These values must be different from those of the functions.
C-----------------------------------------------------------------------

	INTEGER*4 CDF_
	PARAMETER (CDF_ = 1)

	INTEGER CDF_NAME_
	PARAMETER (CDF_NAME_ = 2)

	INTEGER*4 CDF_ENCODING_
	PARAMETER (CDF_ENCODING_ = 3)

	INTEGER*4 CDF_DECODING_
	PARAMETER (CDF_DECODING_ = 4)

	INTEGER*4 CDF_MAJORITY_
	PARAMETER (CDF_MAJORITY_ = 5)

	INTEGER*4 CDF_FORMAT_
	PARAMETER (CDF_FORMAT_ = 6)

	INTEGER*4 CDF_COPYRIGHT_
	PARAMETER (CDF_COPYRIGHT_ = 7)

	INTEGER*4 CDF_NUMrVARS_
	PARAMETER (CDF_NUMrVARS_ = 8)

	INTEGER*4 CDF_NUMzVARS_
	PARAMETER (CDF_NUMzVARS_ = 9)

	INTEGER*4 CDF_NUMATTRS_
	PARAMETER (CDF_NUMATTRS_ = 10)

	INTEGER*4 CDF_NUMgATTRS_
	PARAMETER (CDF_NUMgATTRS_ = 11)

	INTEGER*4 CDF_NUMvATTRS_
	PARAMETER (CDF_NUMvATTRS_ = 12)

	INTEGER*4 CDF_VERSION_
	PARAMETER (CDF_VERSION_ = 13)

	INTEGER*4 CDF_RELEASE_
	PARAMETER (CDF_RELEASE_ = 14)

	INTEGER*4 CDF_INCREMENT_
	PARAMETER (CDF_INCREMENT_ = 15)

	INTEGER*4 CDF_STATUS_
	PARAMETER (CDF_STATUS_ = 16)

	INTEGER*4 CDF_READONLY_MODE_
	PARAMETER (CDF_READONLY_MODE_ = 17)

	INTEGER*4 CDF_zMODE_
	PARAMETER (CDF_zMODE_ = 18)

	INTEGER*4 CDF_NEGtoPOSfp0_MODE_
	PARAMETER (CDF_NEGtoPOSfp0_MODE_ = 19)

	INTEGER*4 LIB_COPYRIGHT_
	PARAMETER (LIB_COPYRIGHT_ = 20)

	INTEGER*4 LIB_VERSION_
	PARAMETER (LIB_VERSION_ = 21)

	INTEGER*4 LIB_RELEASE_
	PARAMETER (LIB_RELEASE_ = 22)

	INTEGER*4 LIB_INCREMENT_
	PARAMETER (LIB_INCREMENT_ = 23)

	INTEGER*4 LIB_subINCREMENT_
	PARAMETER (LIB_subINCREMENT_ = 24)

	INTEGER*4 rVARs_NUMDIMS_
	PARAMETER (rVARs_NUMDIMS_ = 25)

	INTEGER*4 rVARs_DIMSIZES_
	PARAMETER (rVARs_DIMSIZES_ = 26)

	INTEGER*4 rVARs_MAXREC_
	PARAMETER (rVARs_MAXREC_ = 27)

	INTEGER*4 rVARs_RECDATA_
	PARAMETER (rVARs_RECDATA_ = 28)

	INTEGER*4 rVARs_RECNUMBER_
	PARAMETER (rVARs_RECNUMBER_ = 29)

	INTEGER*4 rVARs_RECCOUNT_
	PARAMETER (rVARs_RECCOUNT_ = 30)

	INTEGER*4 rVARs_RECINTERVAL_
	PARAMETER (rVARs_RECINTERVAL_ = 31)

	INTEGER*4 rVARs_DIMINDICES_
	PARAMETER (rVARs_DIMINDICES_ = 32)

	INTEGER*4 rVARs_DIMCOUNTS_
	PARAMETER (rVARs_DIMCOUNTS_ = 33)

	INTEGER*4 rVARs_DIMINTERVALS_
	PARAMETER (rVARs_DIMINTERVALS_ = 34)

	INTEGER*4 rVAR_
	PARAMETER (rVAR_ = 35)

	INTEGER*4 rVAR_NAME_
	PARAMETER (rVAR_NAME_ = 36)

	INTEGER*4 rVAR_DATATYPE_
	PARAMETER (rVAR_DATATYPE_ = 37)

	INTEGER*4 rVAR_NUMELEMS_
	PARAMETER (rVAR_NUMELEMS_ = 38)

	INTEGER*4 rVAR_RECVARY_
	PARAMETER (rVAR_RECVARY_ = 39)

	INTEGER*4 rVAR_DIMVARYS_
	PARAMETER (rVAR_DIMVARYS_ = 40)

	INTEGER*4 rVAR_NUMBER_
	PARAMETER (rVAR_NUMBER_ = 41)

	INTEGER*4 rVAR_DATA_
	PARAMETER (rVAR_DATA_ = 42)

	INTEGER*4 rVAR_HYPERDATA_
	PARAMETER (rVAR_HYPERDATA_ = 43)

	INTEGER*4 rVAR_SEQDATA_
	PARAMETER (rVAR_SEQDATA_ = 44)

	INTEGER*4 rVAR_SEQPOS_
	PARAMETER (rVAR_SEQPOS_ = 45)

	INTEGER*4 rVAR_MAXREC_
	PARAMETER (rVAR_MAXREC_ = 46)

	INTEGER*4 rVAR_MAXallocREC_
	PARAMETER (rVAR_MAXallocREC_ = 47)

	INTEGER*4 rVAR_DATASPEC_
	PARAMETER (rVAR_DATASPEC_ = 48)

	INTEGER*4 rVAR_PADVALUE_
	PARAMETER (rVAR_PADVALUE_ = 49)

	INTEGER*4 rVAR_INITIALRECS_
	PARAMETER (rVAR_INITIALRECS_ = 50)

	INTEGER*4 rVAR_BLOCKINGFACTOR_
	PARAMETER (rVAR_BLOCKINGFACTOR_ = 51)

	INTEGER*4 rVAR_nINDEXRECORDS_
	PARAMETER (rVAR_nINDEXRECORDS_ = 52)

	INTEGER*4 rVAR_nINDEXENTRIES_
	PARAMETER (rVAR_nINDEXENTRIES_ = 53)

	INTEGER*4 rVAR_EXISTENCE_
	PARAMETER (rVAR_EXISTENCE_ = 54)

	INTEGER*4 zVARs_MAXREC_
	PARAMETER (zVARs_MAXREC_ = 55)

	INTEGER*4 zVARs_RECDATA_
	PARAMETER (zVARs_RECDATA_ = 56)

	INTEGER*4 zVAR_
	PARAMETER (zVAR_  = 57)

	INTEGER*4 zVAR_NAME_
	PARAMETER (zVAR_NAME_ = 58)

	INTEGER*4 zVAR_DATATYPE_
	PARAMETER (zVAR_DATATYPE_ = 59)

	INTEGER*4 zVAR_NUMELEMS_
	PARAMETER (zVAR_NUMELEMS_ = 60)

	INTEGER*4 zVAR_NUMDIMS_
	PARAMETER (zVAR_NUMDIMS_ = 61)

	INTEGER*4 zVAR_DIMSIZES_
	PARAMETER (zVAR_DIMSIZES_ = 62)

	INTEGER*4 zVAR_RECVARY_
	PARAMETER (zVAR_RECVARY_ = 63)

	INTEGER*4 zVAR_DIMVARYS_
	PARAMETER (zVAR_DIMVARYS_ = 64)

	INTEGER*4 zVAR_NUMBER_
	PARAMETER (zVAR_NUMBER_ = 65)

	INTEGER*4 zVAR_DATA_
	PARAMETER (zVAR_DATA_ = 66)

	INTEGER*4 zVAR_HYPERDATA_
	PARAMETER (zVAR_HYPERDATA_ = 67)

	INTEGER*4 zVAR_SEQDATA_
	PARAMETER (zVAR_SEQDATA_ = 68)

	INTEGER*4 zVAR_SEQPOS_
	PARAMETER (zVAR_SEQPOS_ = 69)

	INTEGER*4 zVAR_MAXREC_
	PARAMETER (zVAR_MAXREC_ = 70)

	INTEGER*4 zVAR_MAXallocREC_
	PARAMETER (zVAR_MAXallocREC_ = 71)

	INTEGER*4 zVAR_DATASPEC_
	PARAMETER (zVAR_DATASPEC_ = 72)

	INTEGER*4 zVAR_PADVALUE_
	PARAMETER (zVAR_PADVALUE_ = 73)

	INTEGER*4 zVAR_INITIALRECS_
	PARAMETER (zVAR_INITIALRECS_ = 74)

	INTEGER*4 zVAR_BLOCKINGFACTOR_
	PARAMETER (zVAR_BLOCKINGFACTOR_ = 75)

	INTEGER*4 zVAR_nINDEXRECORDS_
	PARAMETER (zVAR_nINDEXRECORDS_ = 76)

	INTEGER*4 zVAR_nINDEXENTRIES_
	PARAMETER (zVAR_nINDEXENTRIES_ = 77)

	INTEGER*4 zVAR_EXISTENCE_
	PARAMETER (zVAR_EXISTENCE_ = 78)

	INTEGER*4 zVAR_RECNUMBER_
	PARAMETER (zVAR_RECNUMBER_ = 79)

	INTEGER*4 zVAR_RECCOUNT_
	PARAMETER (zVAR_RECCOUNT_ = 80)

	INTEGER*4 zVAR_RECINTERVAL_
	PARAMETER (zVAR_RECINTERVAL_ = 81)

	INTEGER*4 zVAR_DIMINDICES_
	PARAMETER (zVAR_DIMINDICES_ = 82)

	INTEGER*4 zVAR_DIMCOUNTS_
	PARAMETER (zVAR_DIMCOUNTS_ = 83)

	INTEGER*4 zVAR_DIMINTERVALS_
	PARAMETER (zVAR_DIMINTERVALS_ = 84)

	INTEGER*4 ATTR_
	PARAMETER (ATTR_ = 85)

	INTEGER*4 ATTR_SCOPE_
	PARAMETER (ATTR_SCOPE_ = 86)

	INTEGER*4 ATTR_NAME_
	PARAMETER (ATTR_NAME_ = 87)

	INTEGER*4 ATTR_NUMBER_
	PARAMETER (ATTR_NUMBER_ = 88)

	INTEGER*4 ATTR_MAXgENTRY_
	PARAMETER (ATTR_MAXgENTRY_ = 89)

	INTEGER*4 ATTR_NUMgENTRIES_
	PARAMETER (ATTR_NUMgENTRIES_ = 90)

	INTEGER*4 ATTR_MAXrENTRY_
	PARAMETER (ATTR_MAXrENTRY_ = 91)

	INTEGER*4 ATTR_NUMrENTRIES_
	PARAMETER (ATTR_NUMrENTRIES_ = 92)

	INTEGER*4 ATTR_MAXzENTRY_
	PARAMETER (ATTR_MAXzENTRY_ = 93)

	INTEGER*4 ATTR_NUMzENTRIES_
	PARAMETER (ATTR_NUMzENTRIES_ = 94)

	INTEGER*4 ATTR_EXISTENCE_
	PARAMETER (ATTR_EXISTENCE_ = 95)

	INTEGER*4 gENTRY_
	PARAMETER (gENTRY_ = 96)

	INTEGER*4 gENTRY_EXISTENCE_
	PARAMETER (gENTRY_EXISTENCE_ = 97)

	INTEGER*4 gENTRY_DATATYPE_
	PARAMETER (gENTRY_DATATYPE_ = 98)

	INTEGER*4 gENTRY_NUMELEMS_
	PARAMETER (gENTRY_NUMELEMS_ = 99)

	INTEGER*4 gENTRY_DATASPEC_
	PARAMETER (gENTRY_DATASPEC_ = 100)

	INTEGER*4 gENTRY_DATA_
	PARAMETER (gENTRY_DATA_ = 101)

	INTEGER*4 rENTRY_
	PARAMETER (rENTRY_ = 102)

	INTEGER*4 rENTRY_NAME_
	PARAMETER (rENTRY_NAME_ = 103)

	INTEGER*4 rENTRY_EXISTENCE_
	PARAMETER (rENTRY_EXISTENCE_ = 104)

	INTEGER*4 rENTRY_DATATYPE_
	PARAMETER (rENTRY_DATATYPE_ = 105)

	INTEGER*4 rENTRY_NUMELEMS_
	PARAMETER (rENTRY_NUMELEMS_ = 106)

	INTEGER*4 rENTRY_DATASPEC_
	PARAMETER (rENTRY_DATASPEC_ = 107)

	INTEGER*4 rENTRY_DATA_
	PARAMETER (rENTRY_DATA_ = 108)

	INTEGER*4 zENTRY_
	PARAMETER (zENTRY_ = 109)

	INTEGER*4 zENTRY_NAME_
	PARAMETER (zENTRY_NAME_ = 110)

	INTEGER*4 zENTRY_EXISTENCE_
	PARAMETER (zENTRY_EXISTENCE_ = 111)

	INTEGER*4 zENTRY_DATATYPE_
	PARAMETER (zENTRY_DATATYPE_ = 112)

	INTEGER*4 zENTRY_NUMELEMS_
	PARAMETER (zENTRY_NUMELEMS_ = 113)

	INTEGER*4 zENTRY_DATASPEC_
	PARAMETER (zENTRY_DATASPEC_ = 114)

	INTEGER*4 zENTRY_DATA_
	PARAMETER (zENTRY_DATA_ = 115)

	INTEGER*4 STATUS_TEXT_
	PARAMETER (STATUS_TEXT_ = 116)

	INTEGER*4 CDF_CACHESIZE_
	PARAMETER (CDF_CACHESIZE_ = 117)

	INTEGER*4 rVARs_CACHESIZE_
	PARAMETER (rVARs_CACHESIZE_ = 118)

	INTEGER*4 zVARs_CACHESIZE_
	PARAMETER (zVARs_CACHESIZE_ = 119)

	INTEGER*4 rVAR_CACHESIZE_
	PARAMETER (rVAR_CACHESIZE_ = 120)

	INTEGER*4 zVAR_CACHESIZE_
	PARAMETER (zVAR_CACHESIZE_ = 121)

	INTEGER*4 zVARs_RECNUMBER_
	PARAMETER (zVARs_RECNUMBER_ = 122)

	INTEGER*4 rVAR_ALLOCATERECS_
	PARAMETER (rVAR_ALLOCATERECS_ = 123)

	INTEGER*4 zVAR_ALLOCATERECS_
	PARAMETER (zVAR_ALLOCATERECS_ = 124)

	INTEGER*4 DATATYPE_SIZE_
	PARAMETER (DATATYPE_SIZE_ = 125)

	INTEGER*4 CURgENTRY_EXISTENCE_
	PARAMETER (CURgENTRY_EXISTENCE_ = 126)

	INTEGER*4 CURrENTRY_EXISTENCE_
	PARAMETER (CURrENTRY_EXISTENCE_ = 127)

	INTEGER*4 CURzENTRY_EXISTENCE_
	PARAMETER (CURzENTRY_EXISTENCE_ = 128)

	INTEGER*4 CDF_INFO_
	PARAMETER (CDF_INFO_ = 129)

	INTEGER*4 CDF_COMPRESSION_
	PARAMETER (CDF_COMPRESSION_ = 130)

	INTEGER*4 zVAR_COMPRESSION_
	PARAMETER (zVAR_COMPRESSION_ = 131)

	INTEGER*4 zVAR_SPARSERECORDS_
	PARAMETER (zVAR_SPARSERECORDS_ = 132)

	INTEGER*4 zVAR_SPARSEARRAYS_
	PARAMETER (zVAR_SPARSEARRAYS_ = 133)

	INTEGER*4 zVAR_ALLOCATEBLOCK_
	PARAMETER (zVAR_ALLOCATEBLOCK_ = 134)

	INTEGER*4 zVAR_NUMRECS_
	PARAMETER (zVAR_NUMRECS_ = 135)

	INTEGER*4 zVAR_NUMallocRECS_
	PARAMETER (zVAR_NUMallocRECS_ = 136)

	INTEGER*4 rVAR_COMPRESSION_
	PARAMETER (rVAR_COMPRESSION_ = 137)

	INTEGER*4 rVAR_SPARSERECORDS_
	PARAMETER (rVAR_SPARSERECORDS_ = 138)

	INTEGER*4 rVAR_SPARSEARRAYS_
	PARAMETER (rVAR_SPARSEARRAYS_ = 139)

	INTEGER*4 rVAR_ALLOCATEBLOCK_
	PARAMETER (rVAR_ALLOCATEBLOCK_ = 140)

	INTEGER*4 rVAR_NUMRECS_
	PARAMETER (rVAR_NUMRECS_ = 141)

	INTEGER*4 rVAR_NUMallocRECS_
	PARAMETER (rVAR_NUMallocRECS_ = 142)

	INTEGER*4 rVAR_ALLOCATEDFROM_
	PARAMETER (rVAR_ALLOCATEDFROM_ = 143)

	INTEGER*4 rVAR_ALLOCATEDTO_
	PARAMETER (rVAR_ALLOCATEDTO_ = 144)

	INTEGER*4 zVAR_ALLOCATEDFROM_
	PARAMETER (zVAR_ALLOCATEDFROM_ = 145)

	INTEGER*4 zVAR_ALLOCATEDTO_
	PARAMETER (zVAR_ALLOCATEDTO_ = 146)

	INTEGER*4 zVAR_nINDEXLEVELS_
	PARAMETER (zVAR_nINDEXLEVELS_ = 147)

	INTEGER*4 rVAR_nINDEXLEVELS_
	PARAMETER (rVAR_nINDEXLEVELS_ = 148)

	INTEGER*4 CDF_SCRATCHDIR_
	PARAMETER (CDF_SCRATCHDIR_ = 149)

	INTEGER*4 rVAR_RESERVEPERCENT_
	PARAMETER (rVAR_RESERVEPERCENT_ = 150)

	INTEGER*4 zVAR_RESERVEPERCENT_
	PARAMETER (zVAR_RESERVEPERCENT_ = 151)

	INTEGER*4 rVAR_RECORDS_
	PARAMETER (rVAR_RECORDS_ = 152)

	INTEGER*4 zVAR_RECORDS_
	PARAMETER (zVAR_RECORDS_ = 153)

	INTEGER*4 STAGE_CACHESIZE_
	PARAMETER (STAGE_CACHESIZE_ = 154)

	INTEGER*4 COMPRESS_CACHESIZE_
	PARAMETER (COMPRESS_CACHESIZE_ = 155)

C-----------------------------------------------------------------------
C Declarations for functions.  These may cause compiler warnings on some
C machines if the functions are not used.  If that is a problem, remove
C them from here and declare the functions only in the routines that use
C them.  Some compilers also have command line options that can be used
C to supress the warning messages.
C-----------------------------------------------------------------------

	INTEGER*4 CDF_var_num
	INTEGER*4 CDF_attr_num
	INTEGER*4 CDF_lib
	INTEGER*4 CDF_lib_4
	INTEGER*4 CDF_lib_5
	INTEGER*4 CDF_lib_6
	INTEGER*4 CDF_lib_7
	INTEGER*4 CDF_lib_8
	INTEGER*4 CDF_lib_9
	INTEGER*4 CDF_lib_10
	INTEGER*4 CDF_lib_11
	INTEGER*4 CDF_lib_12
	INTEGER*4 CDF_lib_13
	INTEGER*4 CDF_lib_14
	INTEGER*4 CDF_lib_15
	INTEGER*4 CDF_lib_16
	INTEGER*4 CDF_lib_17
	INTEGER*4 CDF_lib_18
	INTEGER*4 CDF_lib_19
	INTEGER*4 CDF_lib_20
	INTEGER*4 CDF_lib_21
	INTEGER*4 CDF_lib_22
	INTEGER*4 CDF_lib_23
	INTEGER*4 CDF_lib_24
	INTEGER*4 CDF_lib_25

C-----------------------------------------------------------------------
C Synonyms for compatibility with older releases.
C-----------------------------------------------------------------------

	INTEGER*4 CDF_DOCUMENT_LEN
	PARAMETER (CDF_DOCUMENT_LEN = CDF_COPYRIGHT_LEN)

	INTEGER*4 CDF_ERRTEXT_LEN
	PARAMETER (CDF_ERRTEXT_LEN = CDF_STATUSTEXT_LEN)

	INTEGER*4 CDF_NUMDIMS_
	PARAMETER (CDF_NUMDIMS_ = rVARs_NUMDIMS_)

	INTEGER*4 CDF_DIMSIZES_
	PARAMETER (CDF_DIMSIZES_ = rVARs_DIMSIZES_)

	INTEGER*4 CDF_MAXREC_
	PARAMETER (CDF_MAXREC_ = rVARs_MAXREC_)

	INTEGER*4 CDF_RECNUMBER_
	PARAMETER (CDF_RECNUMBER_ = rVARs_RECNUMBER_)

	INTEGER*4 CDF_RECCOUNT_
	PARAMETER (CDF_RECCOUNT_ = rVARs_RECCOUNT_)

	INTEGER*4 CDF_RECINTERVAL_
	PARAMETER (CDF_RECINTERVAL_ = rVARs_RECINTERVAL_)

	INTEGER*4 CDF_DIMINDICES_
	PARAMETER (CDF_DIMINDICES_ = rVARs_DIMINDICES_)

	INTEGER*4 CDF_DIMCOUNTS_
	PARAMETER (CDF_DIMCOUNTS_ = rVARs_DIMCOUNTS_)

	INTEGER*4 CDF_DIMINTERVALS_
	PARAMETER (CDF_DIMINTERVALS_ = rVARs_DIMINTERVALS_)

	INTEGER*4 CDF_NUMVARS_
	PARAMETER (CDF_NUMVARS_ = CDF_NUMrVARS_)

	INTEGER*4 VAR_
	PARAMETER (VAR_ = rVAR_)

	INTEGER*4 VAR_NAME_
	PARAMETER (VAR_NAME_ = rVAR_NAME_)

	INTEGER*4 VAR_DATATYPE_
	PARAMETER (VAR_DATATYPE_ = rVAR_DATATYPE_)

	INTEGER*4 VAR_NUMELEMS_
	PARAMETER (VAR_NUMELEMS_ = rVAR_NUMELEMS_)

	INTEGER*4 VAR_RECVARY_
	PARAMETER (VAR_RECVARY_ = rVAR_RECVARY_)

	INTEGER*4 VAR_DIMVARYS_
	PARAMETER (VAR_DIMVARYS_ = rVAR_DIMVARYS_)

	INTEGER*4 VAR_NUMBER_
	PARAMETER (VAR_NUMBER_ = rVAR_NUMBER_)

	INTEGER*4 VAR_DATA_
	PARAMETER (VAR_DATA_ = rVAR_DATA_)

	INTEGER*4 VAR_HYPERDATA_
	PARAMETER (VAR_HYPERDATA_ = rVAR_HYPERDATA_)

	INTEGER*4 VAR_SEQDATA_
	PARAMETER (VAR_SEQDATA_ = rVAR_SEQDATA_)

	INTEGER*4 VAR_SEQPOS_
	PARAMETER (VAR_SEQPOS_ = rVAR_SEQPOS_)

	INTEGER*4 VAR_MAXREC_
	PARAMETER (VAR_MAXREC_ = rVAR_MAXREC_)

	INTEGER*4 VAR_DATASPEC_
	PARAMETER (VAR_DATASPEC_ = rVAR_DATASPEC_)

	INTEGER*4 VAR_FILLVALUE_
	PARAMETER (VAR_FILLVALUE_ = rVAR_PADVALUE_)

	INTEGER*4 VAR_INITIALRECS_
	PARAMETER (VAR_INITIALRECS_ = rVAR_INITIALRECS_)

	INTEGER*4 VAR_EXTENDRECS_
	PARAMETER (VAR_EXTENDRECS_ = rVAR_BLOCKINGFACTOR_)

	INTEGER*4 ATTR_MAXENTRY_
	PARAMETER (ATTR_MAXENTRY_ = ATTR_MAXrENTRY_)

	INTEGER*4 ATTR_NUMENTRIES_
	PARAMETER (ATTR_NUMENTRIES_ = ATTR_NUMrENTRIES_)

	INTEGER*4 ENTRY_
	PARAMETER (ENTRY_ = rENTRY_)

	INTEGER*4 ENTRY_DATATYPE_
	PARAMETER (ENTRY_DATATYPE_ = rENTRY_DATATYPE_)

	INTEGER*4 ENTRY_NUMELEMS_
	PARAMETER (ENTRY_NUMELEMS_ = rENTRY_NUMELEMS_)

	INTEGER*4 ENTRY_DATA_
	PARAMETER (ENTRY_DATA_ = rENTRY_DATA_)

	INTEGER*4 MIPSEL_ENCODING
	PARAMETER (MIPSEL_ENCODING = DECSTATION_ENCODING)

	INTEGER*4 MIPSEB_ENCODING
	PARAMETER (MIPSEB_ENCODING = SGi_ENCODING)

	INTEGER*4 rVAR_EXISTANCE_
	PARAMETER (rVAR_EXISTANCE_ = rVAR_EXISTENCE_)

	INTEGER*4 zVAR_EXISTANCE_
	PARAMETER (zVAR_EXISTANCE_ = zVAR_EXISTENCE_)

	INTEGER*4 ATTR_EXISTANCE_
	PARAMETER (ATTR_EXISTANCE_ = ATTR_EXISTENCE_)

	INTEGER*4 gENTRY_EXISTANCE_
	PARAMETER (gENTRY_EXISTANCE_ = gENTRY_EXISTENCE_)

	INTEGER*4 rENTRY_EXISTANCE_
	PARAMETER (rENTRY_EXISTANCE_ = rENTRY_EXISTENCE_)

	INTEGER*4 zENTRY_EXISTANCE_
	PARAMETER (zENTRY_EXISTANCE_ = zENTRY_EXISTENCE_)

	INTEGER*4 GLOBAL_SCOPE_ASSUMED
	PARAMETER (GLOBAL_SCOPE_ASSUMED = GLOBAL_SCOPE)

	INTEGER*4 VARIABLE_SCOPE_ASSUMED
	PARAMETER (VARIABLE_SCOPE_ASSUMED = VARIABLE_SCOPE)

	INTEGER*4 BAD_EXTEND_RECS
	PARAMETER (BAD_EXTEND_RECS = BAD_BLOCKING_FACTOR)

	INTEGER*4 rVAR_EXTENDRECS_
	PARAMETER (rVAR_EXTENDRECS_ = rVAR_BLOCKINGFACTOR_)

	INTEGER*4 zVAR_EXTENDRECS_
	PARAMETER (zVAR_EXTENDRECS_ = zVAR_BLOCKINGFACTOR_)

	INTEGER*4 COL_MAJOR
	PARAMETER (COL_MAJOR = COLUMN_MAJOR)
