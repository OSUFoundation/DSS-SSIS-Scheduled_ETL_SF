CREATE OR REPLACE TABLE "FENXT_DW"."BB"."DIM_AccountAttribute"
(
	AccountAttributeDimID 		NUMBER(38,0)
	,AccountAttributeSystemID 	NUMBER(38,0)
	,AccountDimID 				NUMBER(38,0)
	,AccountSystemID 			NUMBER(38,0)
	,AttributeCategory 			VARCHAR(256)
	,AttributeDescription 		VARCHAR(256)
	,AttributeDescriptionShort 	VARCHAR(256)
	,Sequence 					NUMBER(38,0)
	,Comments 					VARCHAR(256)
	,AttributeDate 				TIMESTAMP_NTZ(9)
	,TypeOfData 				VARCHAR(256)
	,Required 					VARCHAR(256)
	,MustBeUnique 				VARCHAR(256)
	,ETLControlID 				NUMBER(38,0)
	,SourceID 					NUMBER(38,0)
);

COPY INTO "FENXT_DW"."BB"."DIM_AccountAttribute" FROM '@BB_DELTA_STAGE/DIM_AccountAttributeAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

