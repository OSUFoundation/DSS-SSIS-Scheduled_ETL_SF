CREATE OR REPLACE TABLE "FENXT_DW"."BB"."DIM_Account"
(
	AccountDimID 				NUMBER(38,0)
	,AccountSystemID 			NUMBER(38,0)
	,AccountNumber 				VARCHAR(256)
	,AccountCode 				VARCHAR(256)
	,AccountCodeSystemID 		NUMBER(38,0)
	,AccountDescription 		VARCHAR(256)
	,AccountCategorySystemID 	NUMBER(38,0)
	,AccountCategoryDescription VARCHAR(256)
	,ClassDimID 				NUMBER(38,0)
	,ClassSystemID 				NUMBER(38,0)
	,ClassDescription 			VARCHAR(256)
	,FundSystemID 				NUMBER(38,0)
	,FundID 					VARCHAR(256)
	,FundDescription 			VARCHAR(256)
	,WorkingCapitalSystemID 	NUMBER(38,0)
	,WorkingCapital 			VARCHAR(256)
	,CashFlowSystemID 			NUMBER(38,0)
	,CashFlow 					VARCHAR(256)
	,AccountStatusSystemID 		NUMBER(38,0)
	,AccountStatusDescription 	VARCHAR(256)
	,PreventPostDate 			TIMESTAMP_NTZ(9)
	,GeneralInfoSystemID 		NUMBER(38,0)
	,DateAdded 					TIMESTAMP_NTZ(9)
	,DateChanged 				TIMESTAMP_NTZ(9)
	,ContraAccount 				VARCHAR(256)
	,ControlAccount 			VARCHAR(256)
	,CashAccount 				VARCHAR(256)
	,AnnotationText 			STRING
	,ETLControlID 				NUMBER(38,0)
	,SourceID 					NUMBER(38,0)	
);

COPY INTO "FENXT_DW"."BB"."DIM_Account" FROM '@BB_DELTA_STAGE/DIM_AccountAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

