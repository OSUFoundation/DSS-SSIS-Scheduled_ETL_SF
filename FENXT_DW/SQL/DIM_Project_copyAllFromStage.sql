CREATE OR REPLACE TABLE "FENXT_DW"."BB"."DIM_Project"
(
	ProjectDimID  NUMBER(38,0)
	,ProjectSystemID  NUMBER(38,0)
	,ProjectID  VARCHAR(256)
	,ProjectDescription  VARCHAR(256)
	,ProjectStatusSystemID  NUMBER(38,0)
	,ProjectStatusDescription  VARCHAR(256)
	,ProjectTypeSystemID  NUMBER(38,0)
	,ProjectTypeDescription  VARCHAR(256)
	,ProjectStartDate  TIMESTAMP_NTZ(9)
	,ProjectEndDate  TIMESTAMP_NTZ(9)
	,ProjectStartDateDimID  NUMBER(38,0)
	,ProjectEndDateDimID  NUMBER(38,0)
	,ProjectActive  VARCHAR(256)
	,PreventPostDate  TIMESTAMP_NTZ(9)
	,DateAdded  TIMESTAMP_NTZ(9)
	,DateChanged  TIMESTAMP_NTZ(9)
	,GrantID  VARCHAR(256)
	,AnnotationText  VARCHAR(256)
	,ETLControlID  NUMBER(38,0)
	,SourceID  NUMBER(38,0)
	,ParentProjectSystemID  NUMBER(38,0)
	,ParentProjectDimID  NUMBER(38,0)
	,ImportID  VARCHAR(256)
);                                              



COPY INTO "FENXT_DW"."BB"."DIM_Project" FROM '@BB_DELTA_STAGE/DIM_ProjectAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

