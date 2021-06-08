DELETE FROM "FENXT_DW"."BB"."FACT_GLTransactionDistribution"
WHERE TransactionDistributionFactID IN(SELECT TransactionDistributionFactID From "FENXT_DW"."BB_DELTA"."FACT_GLTransactionDistribution");

Insert Into "FENXT_DW"."BB"."FACT_GLTransactionDistribution"
Select 
 TransactionDistributionFactID
,AccountDimID
,AccountSystemID
,AccountCode
,AccountNumber
,AccountDescription
,AccountCategorySystemID
,AccountCategory
,ProjectDimID
,ProjectSystemID
,ProjectID
,ProjectDescription
,FundID
,FundDescription
,PostDateDimID
,PostDate
,PostStatusDimID
,TransactionTypeDimID
,TransactionType
,TransactionCode1DimID
,TransactionCode2DimID
,TransactionCode3DimID
,TransactionCode4DimID
,TransactionCode5DimID
,Amount
,NaturalAmount
,TransactionNumber
,TransactionSystemID
,FiscalPeriodsSystemID
,PostStatus
,JournalDimID
,Journal
,JournalReference
,BatchNumber
,BatchDescription
,BatchStatus
,SourceRecordsID
,GLSourceTypeDimID
,SourceNumber
,SourceType
,SourceTypeName
,SourceTypeGroup
,TransactionDateAdded
,TransactionDateChanged
,ProjectPeriodSequence
,ClassDimID
,ClassSystemID
,ClassDescription
,ETLControlID
,SourceID
,Notes
,Name
,ADCCode
,BAIndex
,PostedOnDate
,JournalShort
,HistJour 
From "FENXT_DW"."BB_DELTA"."FACT_GLTransactionDistribution"
WHERE UpdatedStatus In('New','Modified');

