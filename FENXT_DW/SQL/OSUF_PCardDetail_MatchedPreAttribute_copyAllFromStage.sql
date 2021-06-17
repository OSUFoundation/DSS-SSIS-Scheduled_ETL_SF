CREATE OR REPLACE TABLE "FENXT_DW"."BB"."OSUF_PCardDetail_MatchedPreAttribute" 
(
	TransactionNumber  VARCHAR(256)
	,BusinessPurpose  VARCHAR(256)
	,MerchantName  NUMBER(38,0)
	,MerchantCode  NUMBER(38,0)
	,MerchantType  NUMBER(38,0)
);                                              



COPY INTO "FENXT_DW"."BB"."OSUF_PCardDetail_MatchedPreAttribute"   FROM '@BB_DELTA_STAGE/OSUF_PCardDetail_MatchedPreAttributeAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');

//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';



