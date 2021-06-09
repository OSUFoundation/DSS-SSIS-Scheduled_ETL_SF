CREATE OR REPLACE TABLE "FENXT_DW"."BB"."DIM_Journal"
(
	JournalDimID 		NUMBER(38,0)
	,JournalSystemID 	NUMBER(38,0)
	,JournalLabel 		VARCHAR(256)
	,JournalName 		VARCHAR(256)
	,JournalShortName 	VARCHAR(256)
	,TableSequence 		NUMBER(38,0)
	,ETLControlID 		NUMBER(38,0)
	,SourceID 			NUMBER(38,0)
);

COPY INTO "FENXT_DW"."BB"."DIM_Journal" FROM '@BB_DELTA_STAGE/DIM_JournalAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

