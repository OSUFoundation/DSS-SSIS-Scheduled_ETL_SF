CREATE OR REPLACE TABLE "FENXT_DW"."BB"."DIM_PostStatus"
(
	PostStatusDimID 		NUMBER(38,0)
	,PostStatusSystemID 	NUMBER(38,0)
	,PostStatus 			VARCHAR(256)
);

COPY INTO "FENXT_DW"."BB"."DIM_PostStatus" FROM '@BB_DELTA_STAGE/DIM_PostStatusAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

