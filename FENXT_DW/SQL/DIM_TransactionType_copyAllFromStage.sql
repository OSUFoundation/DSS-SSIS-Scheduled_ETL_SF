CREATE OR REPLACE TABLE "FENXT_DW"."BB"."DIM_TransactionType"
(
	TransactionTypeDimID NUMBER(38,0)
	,TransactionTypeSystemID NUMBER(38,0)
	,TransactionType VARCHAR(256)	
	
);

COPY INTO "FENXT_DW"."BB"."DIM_TransactionType" FROM '@BB_DELTA_STAGE/DIM_TransactionTypeAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

