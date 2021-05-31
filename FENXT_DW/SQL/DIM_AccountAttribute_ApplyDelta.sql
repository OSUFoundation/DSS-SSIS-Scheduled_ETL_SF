DELETE FROM "FENXT_DW"."BB"."DIM_AccountAttribute"
WHERE AccountAttributeDimID IN(SELECT AccountAttributeDimID From "FENXT_DW"."BB_DELTA"."DIM_AccountAttribute");

Insert Into "FENXT_DW"."BB"."DIM_AccountAttribute"
Select
 AccountAttributeDimID    
,AccountAttributeSystemID 
,AccountDimID             
,AccountSystemID          
,AttributeCategory        
,AttributeDescription     
,AttributeDescriptionShort
,Sequence                 
,Comments                 
,AttributeDate            
,TypeOfData               
,Required                 
,MustBeUnique      
From "FENXT_DW"."BB_DELTA"."DIM_AccountAttribute"
WHERE UpdatedStatus In('New','Modified');

