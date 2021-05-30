CREATE OR REPLACE TABLE "DIM_Account"
(
AccountDimID numeric(38, 0),
AccountSystemID numeric(38, 0),
AccountNumber varchar(256),
AccountCode varchar(256),
AccountCodeSystemID numeric(38, 0),
AccountDescription varchar(256),
AccountCategorySystemID numeric(38, 0),
AccountCategoryDescription varchar(256),
ClassDimID numeric(38, 0),
ClassSystemID numeric(38, 0),
ClassDescription varchar(256),
FundSystemID numeric(38, 0),
FundID varchar(256),
FundDescription varchar(256),
WorkingCapitalSystemID numeric(38, 0),
WorkingCapital varchar(256),
CashFlowSystemID numeric(38, 0),
CashFlow varchar(256),
AccountStatusSystemID numeric(38, 0),
AccountStatusDescription varchar(256),
PreventPostDate TIMESTAMP_NTZ(9),
GeneralInfoSystemID numeric(38, 0),
DateAdded TIMESTAMP_NTZ(9),
DateChanged TIMESTAMP_NTZ(9),
ContraAccount varchar(256),
ControlAccount varchar(256),
CashAccount varchar(256),
AnnotationText varchar(256)
);                                              



COPY INTO "DIM_PROJECT" FROM '@BB_DELTA_STAGE/DIM_AccountDelta.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

