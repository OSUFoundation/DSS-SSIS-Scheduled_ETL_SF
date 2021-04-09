--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Creation of Financial Warehouse Indexes
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Account Indexes
CREATE NONCLUSTERED INDEX BBWH_DIM_Account_AccountCategory ON DIM_Account (AccountCategoryDescription) 
CREATE NONCLUSTERED INDEX BBWH_DIM_Account_AccountCode ON DIM_Account (AccountCode) 
CREATE NONCLUSTERED INDEX BBWH_DIM_Account_AccountSystemID ON DIM_Account (AccountSystemID) 
CREATE NONCLUSTERED INDEX BBWH_DIM_Account_AccountDescription ON DIM_Account (AccountDescription) 
CREATE NONCLUSTERED INDEX BBWH_DIM_Account_AccountNumber ON DIM_Account (AccountNumber) 
CREATE NONCLUSTERED INDEX BBWH_DIM_Account_FundID ON DIM_Account (FundID) 
CREATE NONCLUSTERED INDEX BBWH_DIM_Account_ClassDimID ON DIM_Account (ClassDimID) 

-- Project Indexes
CREATE NONCLUSTERED INDEX BBWH_DIM_Project_ProjectID ON DIM_Project(ProjectID)
CREATE NONCLUSTERED INDEX BBWH_DIM_Project_ProjectSystemID ON DIM_Project(ProjectSystemID)
CREATE NONCLUSTERED INDEX BBWH_DIM_Project_ProjectType ON DIM_Project(ProjectTypeDescription)
CREATE NONCLUSTERED INDEX BBWH_DIM_Project_ProjectDescription ON DIM_Project(ProjectDescription)

-- Account Attributes
CREATE NONCLUSTERED INDEX BBWH_DIM_AccountAttribute_AccountDimID ON DIM_AccountAttribute (AccountDimID) 
CREATE NONCLUSTERED INDEX BBWH_DIM_AccountAttribute_AttributeCategory ON DIM_AccountAttribute (AttributeCategory) 
CREATE NONCLUSTERED INDEX BBWH_DIM_AccountAttribute_AttributeDescription ON DIM_AccountAttribute (AttributeDescription) 

-- Project Attributes
CREATE NONCLUSTERED INDEX BBWH_DIM_ProjectAttribute_ProjectDimID ON DIM_ProjectAttribute (ProjectDimID) 
CREATE NONCLUSTERED INDEX BBWH_DIM_ProjectAttribute_AttributeCategory ON DIM_ProjectAttribute (AttributeCategory) 
CREATE NONCLUSTERED INDEX BBWH_DIM_ProjectAttribute_AttributeDescription ON DIM_ProjectAttribute (AttributeDescription) 

-- GL Transaction Distribution Indexes
CREATE NONCLUSTERED INDEX BBWH_FACT_GLTD_AccountDimID ON FACT_GLTransactionDistribution(AccountDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_GLTD_ProjectDimID ON FACT_GLTransactionDistribution(ProjectDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_GLTD_PostDateDimID ON FACT_GLTransactionDistribution(PostDateDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_GLTD_PostStatusDimID ON FACT_GLTransactionDistribution(PostStatusDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_GLTD_TransactionTypeDimID ON FACT_GLTransactionDistribution(TransactionTypeDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_GLTD_ClassDimID ON FACT_GLTransactionDistribution(ClassDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_GLTD_JournalDimID ON FACT_GLTransactionDistribution(JournalDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_GLTD_GLSourceTypeDimID ON FACT_GLTransactionDistribution(GLSourceTypeDimID)

-- AP Transaction Distribution Indexes
CREATE NONCLUSTERED INDEX BBWH_FACT_APTD_AccountDimID ON FACT_APTransactionDistribution(AccountDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_APTD_ProjectDimID ON FACT_APTransactionDistribution(ProjectDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_APTD_InvoiceDateDimID ON FACT_APTransactionDistribution(InvoiceDateDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_APTD_VendorDimID ON FACT_APTransactionDistribution(VendorDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_APTD_TransactionTypeDimID ON FACT_APTransactionDistribution(TransactionTypeDimID)

-- Invoice Indexes
CREATE NONCLUSTERED INDEX BBWH_FACT_Invoice_InvoiceDateDimID ON FACT_Invoice(InvoiceDateDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_Invoice_VendorDimID ON FACT_Invoice(VendorDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_Invoice_PostDateDimID ON FACT_Invoice(PostDateDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_Invoice_PostStatusDimID ON FACT_Invoice(PostStatusDimID)

-- Invoice Attributes
CREATE NONCLUSTERED INDEX BBWH_DIM_InvoiceAttribute_InvoiceFactID ON DIM_InvoiceAttribute (InvoiceFactID) 
CREATE NONCLUSTERED INDEX BBWH_DIM_InvoiceAttribute_AttributeCategory ON DIM_InvoiceAttribute (AttributeCategory) 
CREATE NONCLUSTERED INDEX BBWH_DIM_InvoiceAttribute_AttributeDescription ON DIM_InvoiceAttribute (AttributeDescription) 

-- Project Balances
CREATE NONCLUSTERED INDEX BBWH_FACT_ProjectBalance_ProjectDimID ON FACT_ProjectBalance(ProjectDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_ProjectBalance_BalanceDateDimID ON FACT_ProjectBalance(BalanceDateDimID)

-- Project Account Balances
CREATE NONCLUSTERED INDEX BBWH_FACT_ProjectAccountBalance_ProjectDimID ON FACT_ProjectAccountBalance(ProjectDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_ProjectAccountBalance_AccountDimID ON FACT_ProjectAccountBalance(AccountDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_ProjectAccountBalance_BalanceDateDimID ON FACT_ProjectAccountBalance(BalanceDateDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_ProjectAccountBalance_TransactionCodeDimID ON FACT_ProjectAccountBalance(TransactionCodeDimID)

-- Project Budget
CREATE NONCLUSTERED INDEX BBWH_FACT_ProjectBudget_AccountDimID ON FACT_ProjectBudget(AccountDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_ProjectBudget_ProjectDimID ON FACT_ProjectBudget(ProjectDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_ProjectBudget_PeriodStartDateDimID ON FACT_ProjectBudget(PeriodStartDateDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_ProjectBudget_ScenarioDimID ON FACT_ProjectBudget(ScenarioDimID)

-- Account Budget
CREATE NONCLUSTERED INDEX BBWH_FACT_AccountBudget_AccountDimID ON FACT_AccountBudget(AccountDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_AccountBudget_PeriodStartDateDimID ON FACT_AccountBudget(PeriodStartDateDimID)
CREATE NONCLUSTERED INDEX BBWH_FACT_AccountBudget_ScenarioDimID ON FACT_AccountBudget(ScenarioDimID)


