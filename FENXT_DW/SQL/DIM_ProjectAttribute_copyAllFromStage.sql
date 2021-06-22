DROP TABLE "FENXT_DW"."BB"."DIM_ProjectAttribute";

CREATE OR REPLACE TABLE "FENXT_DW"."BB"."DIM_ProjectAttribute"
(
	ProjectAttributeDimID  NUMBER(38,0)
	,ProjectAttributeSystemID  NUMBER(38,0)
	,ProjectDimID  NUMBER(38,0)
	,ProjectSystemID  NUMBER(38,0)
	,AttributeCategory  VARCHAR(256)
	,AttributeDescription  VARCHAR(256)
	,AttributeDescriptionShort  VARCHAR(256)
	,Sequence  NUMBER(38,0)
	,Comments  VARCHAR(256)
	,AttributeDate  TIMESTAMP_NTZ(9)
	,TypeOfData  VARCHAR(256)
	,Required  VARCHAR(256)
	,MustBeUnique  VARCHAR(256)
	,ETLControlID  NUMBER(38,0)
	,SourceID  NUMBER(38,0)
	,ImportID  VARCHAR(256)
	,DateAdded  TIMESTAMP_NTZ(9)
	,DateChanged  TIMESTAMP_NTZ(9)
	,DateUpdated  TIMESTAMP_NTZ(9)
);                                              



COPY INTO "FENXT_DW"."BB"."DIM_ProjectAttribute" FROM '@BB_DELTA_STAGE/DIM_ProjectAttributeAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

