EXEC dbo.BBBI_IndexHistory 'DROP'
EXEC dbo.BBBI_IndexHistory 'ADD', 'SUMMARY_'
EXEC dbo.BBBI_IndexHistory 'NOW'
EXEC dbo.BBBI_IndexHistory 'HISTORY'

SELECT * FROM DIM_Scenario
SELECT * FROM DIM_TransactionCode
SELECT * FROM DIM_Journal
SELECT * FROM DIM_Account
SELECT * FROM DIM_Project
SELECT * FROM DIM_Vendor
SELECT * FROM DIM_AccountAttribute
SELECT * FROM DIM_ProjectAttribute

SELECT * FROM FACT_AccountBudget
SELECT * FROM FACT_ProjectBudget
SELECT TOP 1000 * FROM FACT_GLTransactionDistribution
SELECT TOP 1000 * FROM FACT_APTransactionDistribution
SELECT * FROM FACT_Invoice
SELECT * FROM FACT_ProjectBalance

SELECT * FROM TEMP_GLSummary

/*
TRUNCATE TABLE DIM_Account
TRUNCATE TABLE DIM_Project
TRUNCATE TABLE DIM_Scenario
TRUNCATE TABLE DIM_Journal
TRUNCATE TABLE DIM_Vendor
*/

SELECT 
COALESCE(MAX(JournalDimID), 0) AS MaxDimKey
FROM dbo.DIM_Journal