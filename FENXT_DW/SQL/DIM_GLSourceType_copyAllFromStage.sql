CREATE OR REPLACE TABLE "FENXT_DW"."BB"."DIM_GLSourceType"
(
	SourceTypeDimID  NUMBER(38,0)
	,SourceTypeSystemID  NUMBER(38,0)
	,SourceType  VARCHAR(256)
	,SourceTypeGroup  VARCHAR(256)
	,DateUpdated  TIMESTAMP_NTZ(9)
);

COPY INTO "FENXT_DW"."BB"."DIM_GLSourceType" FROM '@BB_DELTA_STAGE/DIM_GLSourceTypeAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

