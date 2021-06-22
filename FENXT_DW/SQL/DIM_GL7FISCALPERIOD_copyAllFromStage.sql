CREATE OR REPLACE TABLE "FENXT_DW"."BB"."DIM_GL7FISCALPERIOD"
(
	GL7FISCALPERIODSID  NUMBER(38,0)
	,STARTDATE  TIMESTAMP_NTZ(9)
	,ENDDATE  TIMESTAMP_NTZ(9)
	,CLOSED  NUMBER(38,0)
	,GL7FISCALYEARSID  NUMBER(38,0)
	,SEQUENCE  NUMBER(38,0)
	,GL7GENERALINFOID  NUMBER(38,0)
	,ADJPERIOD  NUMBER(38,0)	
	,DateUpdated  TIMESTAMP_NTZ(9)
);

COPY INTO "FENXT_DW"."BB"."DIM_GL7FISCALPERIOD" FROM '@BB_DELTA_STAGE/DIM_GL7FISCALPERIODAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';
