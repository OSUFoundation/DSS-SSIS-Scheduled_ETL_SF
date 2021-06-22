CREATE OR REPLACE TABLE "FENXT_DW"."BB"."DIM_Class"

(	
	ClassDimID  	NUMBER(38,0)
	,ClassSystemID 	NUMBER(38,0)
	,ClassCode      NUMBER(38,0)
	,ClassName      VARCHAR(256)
	,ClassType      VARCHAR(256)
	,Sequence       NUMBER(38,0)
	,SourceID       NUMBER(38,0)
	,ETLControlID   NUMBER(38,0)
	,DateUpdated  	TIMESTAMP_NTZ(9)
);

COPY INTO "FENXT_DW"."BB"."DIM_Class" FROM '@BB_DELTA_STAGE/DIM_ClassAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

