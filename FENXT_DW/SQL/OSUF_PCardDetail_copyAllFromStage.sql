CREATE OR REPLACE TABLE "FENXT_DW"."BB"."OSUF_PCardDetail" 
(
	PurchaseFactID  NUMBER(38,0)
	,AccountNumber  VARCHAR(256)
	,ProjectID  VARCHAR(256)
	,PostDate  TIMESTAMP_NTZ(9)
	,Type  VARCHAR(256)
	,Amount  NUMBER(38,0)
	,Journal  VARCHAR(256)
	,JournalReference  VARCHAR(256)
	,Comments  VARCHAR(256)
	,Status  VARCHAR(256)
	,YN  VARCHAR(256)
	,FileName  VARCHAR(256)
);                                              



COPY INTO "FENXT_DW"."BB"."OSUF_PCardDetail"   FROM '@BB_DELTA_STAGE/OSUF_PCardDetailAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');

//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';



