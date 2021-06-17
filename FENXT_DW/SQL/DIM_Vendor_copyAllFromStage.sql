CREATE OR REPLACE TABLE "FENXT_DW"."BB"."DIM_Vendor"
(
	VendorDimID  NUMBER(38,0)
	,VendorSystemID  NUMBER(38,0)
	,UserDefinedID  VARCHAR(256)
	,TaxIDNumber  VARCHAR(256)
	,FEImportID  VARCHAR(256)
	,VendorName  VARCHAR(256)
	,VendorSearchName  VARCHAR(256)
	,VendorDisplayName  VARCHAR(256)
	,CustomerNumber  VARCHAR(256)
	,PaymentOption  NUMBER(38,0)
	,Status  VARCHAR(256)
	,HasCreditLimit  VARCHAR(256)
	,CreditLimitAmount  NUMBER(38,0)
	,DefaultPaymentMethod  VARCHAR(256)
	,DateAdded  TIMESTAMP_NTZ(9)
	,DateChanged  TIMESTAMP_NTZ(9)
	,VendorBalance  NUMBER(38,0)
	,HighestBalance  NUMBER(38,0)
	,CheckNotes  VARCHAR(256)
	,DistributedDiscount  VARCHAR(256)
	,IsVendor1099  VARCHAR(256)
	,TotalPurgedInvoicesAmount  NUMBER(38,0)
	,TotalPurgedCreditMemosAmount  NUMBER(38,0)
	,TotalPurgedPOAmount  NUMBER(38,0)
	,BankName  VARCHAR(256)
	,ETLControlID  NUMBER(38,0)
	,SourceID  NUMBER(38,0)
);                                              



COPY INTO "FENXT_DW"."BB"."DIM_Vendor" FROM '@BB_DELTA_STAGE/DIM_VendorAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');

//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';





