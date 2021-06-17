CREATE OR REPLACE TABLE "FENXT_DW"."BB"."DIM_TransactionAttribute" 
(
	TransactionAttributeDimID 		NUMBER(38,0)
	,TransactionAttributeSystemID 	NUMBER(38,0)
	,TransactionDimID 				NUMBER(38,0)
	,TransactionSystemID 			NUMBER(38,0)
	,AttributeCategory 				VARCHAR(256)
	,AttributeDescription 			VARCHAR(256)
	,Sequence 						NUMBER(38,0)
	,Comments 						VARCHAR(256)
	,AttributeDate 					TIMESTAMP_NTZ(9)
	,TypeOfData 					VARCHAR(256)
	,Required 						VARCHAR(256)
	,MustBeUnique 					VARCHAR(256)
	,ETLControlID 					NUMBER(38,0)
	,SourceID 						NUMBER(38,0)	
);                                              



COPY INTO "FENXT_DW"."BB"."DIM_TransactionAttribute"   FROM '@BB_DELTA_STAGE/DIM_TransactionAttributeAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');

//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';



