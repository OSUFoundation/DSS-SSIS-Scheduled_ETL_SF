CREATE OR REPLACE TABLE "FENXT_DW"."BB"."DIM_GLAccounts"
(
	GLAccountDimID  NUMBER(38,0)
	,GLAccountSystemID  NUMBER(38,0)
	,AccountNumber  VARCHAR(256)
	,AccountType  VARCHAR(256)
	,Category  VARCHAR(256)
	,Description  VARCHAR(256)
	,FinancialPosition  VARCHAR(256)
	,Cashflow  NUMBER(38,0)
	,NetAssetClass  VARCHAR(256)
	,IsInactive  VARCHAR(256)
	,SubtotalLevel  NUMBER(38,0)
	,Indentation  NUMBER(38,0)
	,SkipLines  NUMBER(38,0)
	,NewPage  NUMBER(38,0)
	,DateAdded  TIMESTAMP_NTZ(9)
	,DateChanged  TIMESTAMP_NTZ(9)
	,ConsolidationAcct  NUMBER(38,0)
	,FundID  VARCHAR(256)
	,AccountSystemID  NUMBER(38,0)
	,ETLControlID  NUMBER(38,0)
	,SourceID  NUMBER(38,0)
	,DateUpdated  TIMESTAMP_NTZ(9)
);

COPY INTO "FENXT_DW"."BB"."DIM_GLAccounts" FROM '@BB_DELTA_STAGE/DIM_GLAccountsAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

