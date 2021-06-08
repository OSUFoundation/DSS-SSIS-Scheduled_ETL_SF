CREATE OR REPLACE TABLE "FACT_GLTransactionDistribution"
(
	TransactionDistributionFactID numeric(38,0),
	AccountDimID numeric(38,0),
	AccountSystemID numeric(38,0),
	AccountCode varchar(256),
	AccountNumber varchar(256),
	AccountDescription varchar(256),
	AccountCategorySystemID numeric(38,0),
	AccountCategory varchar(256),
	ProjectDimID numeric(38,0),
	ProjectSystemID numeric(38,0),
	ProjectID varchar(256),
	ProjectDescription varchar(256),
	FundID varchar(256),
	FundDescription varchar(256),
	PostDateDimID numeric(38,0),
	PostDate  TIMESTAMP_NTZ(9),
	PostStatusDimID numeric(38,0),
	TransactionTypeDimID numeric(38,0),
	TransactionType varchar(256),
	TransactionCode1DimID numeric(38,0),
	TransactionCode2DimID numeric(38,0),
	TransactionCode3DimID numeric(38,0),
	TransactionCode4DimID numeric(38,0),
	TransactionCode5DimID numeric(38,0),
	Amount numeric(18,2),
	NaturalAmount numeric(18,2),
	TransactionNumber varchar(256),
	TransactionSystemID numeric(38,0),
	FiscalPeriodsSystemID numeric(38,0),
	PostStatus varchar(256),
	JournalDimID numeric(38,0),
	Journal varchar(256),
	JournalReference varchar(256),
	BatchNumber varchar(256),
	BatchDescription varchar(256),
	BatchStatus varchar(256),
	SourceRecordsID numeric(38,0),
	GLSourceTypeDimID numeric(38,0),
	SourceNumber varchar(256),
	SourceType numeric(38,0),
	SourceTypeName varchar(256),
	SourceTypeGroup varchar(256),
	TransactionDateAdded  TIMESTAMP_NTZ(9),
	TransactionDateChanged  TIMESTAMP_NTZ(9),
	ProjectPeriodSequence numeric(38,0),
	ClassDimID numeric(38,0),
	ClassSystemID numeric(38,0),
	ClassDescription varchar(256),
	ETLControlID numeric(38,0),
	SourceID numeric(38,0),
	Notes varchar(8000),
	Name varchar(256),
	ADCCode varchar(256),
	BAIndex varchar(256),
	PostedOnDate  TIMESTAMP_NTZ(9),
	JournalShort varchar(256),
	HistJour varchar(256),
    UpdatedStatus varchar(256)
);                                              



COPY INTO "FACT_GLTransactionDistribution" FROM '@BB_DELTA_STAGE/FACT_GLTransactionDistributionDelta.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

