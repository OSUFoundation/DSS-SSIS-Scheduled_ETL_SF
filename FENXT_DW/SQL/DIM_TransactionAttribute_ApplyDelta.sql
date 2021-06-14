DELETE FROM "FENXT_DW"."BB"."DIM_TransactionAttribute"
WHERE TransactionAttributeSystemID IN(SELECT TransactionAttributeSystemID From "FENXT_DW"."BB_DELTA"."DIM_TransactionAttribute");

Insert Into "FENXT_DW"."BB"."DIM_TransactionAttribute"
Select 
	TransactionAttributeDimID
	,TransactionAttributeSystemID
	,TransactionDimID
	,TransactionSystemID
	,AttributeCategory
	,AttributeDescription
	,Sequence
	,Comments
	,AttributeDate
	,TypeOfData
	,Required
	,MustBeUnique
	,ETLControlID
	,SourceID
From "FENXT_DW"."BB_DELTA"."DIM_TransactionAttribute"
--WHERE "UpdatedStatus" In('New','Modified');

