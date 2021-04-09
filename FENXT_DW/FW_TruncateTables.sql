------------------------------------------------------------------------------------------------------------
-- Truncate Financial Warehouse Tables
------------------------------------------------------------------------------------------------------------

TRUNCATE TABLE CTL_IndexHistory
TRUNCATE TABLE CTL_LoadHistory
TRUNCATE TABLE CTL_LoadStatus
TRUNCATE TABLE CTL_WHTableStats
TRUNCATE TABLE DIM_Account
TRUNCATE TABLE DIM_AccountAttribute
TRUNCATE TABLE DIM_Class
TRUNCATE TABLE DIM_InvoiceAttribute
TRUNCATE TABLE DIM_Journal
TRUNCATE TABLE DIM_Project
TRUNCATE TABLE DIM_ProjectAttribute
TRUNCATE TABLE DIM_Scenario
TRUNCATE TABLE DIM_Source
TRUNCATE TABLE DIM_TransactionCode
TRUNCATE TABLE DIM_VCO
TRUNCATE TABLE DIM_Vendor
TRUNCATE TABLE FACT_AccountBudget
TRUNCATE TABLE FACT_APCreditMemo
TRUNCATE TABLE FACT_APTransactionDistribution
TRUNCATE TABLE FACT_CRDeposit
TRUNCATE TABLE FACT_GLTransactionDistribution
TRUNCATE TABLE FACT_Invoice
TRUNCATE TABLE FACT_InvoicePayment
TRUNCATE TABLE FACT_ProjectAccountBalance
TRUNCATE TABLE FACT_ProjectBalance
TRUNCATE TABLE FACT_ProjectBudget
TRUNCATE TABLE TEMP_Allocations
TRUNCATE TABLE TEMP_BeginningBalances
TRUNCATE TABLE TEMP_CodeTables
TRUNCATE TABLE TEMP_GLSourceTypes
TRUNCATE TABLE TEMP_GLSummary

-- Static Tables
/*
TRUNCATE TABLE DIM_Date
TRUNCATE TABLE DIM_GLSourceType
TRUNCATE TABLE DIM_PostStatus
TRUNCATE TABLE DIM_TransactionType
*/