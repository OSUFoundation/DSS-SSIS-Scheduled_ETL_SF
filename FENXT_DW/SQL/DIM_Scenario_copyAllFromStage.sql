CREATE OR REPLACE TABLE "FENXT_DW"."BB"."DIM_Scenario"
(
	ScenarioDimID 			NUMBER(38,0)
	,ScenarioSystemID 		NUMBER(38,0)
	,ScenarioID 			NUMBER(38,0)
	,ScenarioName 			varchar(256)
	,Status 				varchar(256)
	,IsLocked 				varchar(256)
	,FiscalYearDescription 	varchar(256)
	,NoFiscalPeriods 		NUMBER(38,0)
	,DateAdded 				TIMESTAMP_NTZ(9)
	,DateChanged 			TIMESTAMP_NTZ(9)
	,ETLControlID 			NUMBER(38,0)
	,SourceID 				NUMBER(38,0)
	,DateUpdated  			TIMESTAMP_NTZ(9)
);

COPY INTO "FENXT_DW"."BB"."DIM_Scenario" FROM '@BB_DELTA_STAGE/DIM_ScenarioAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

