DELETE FROM "FENXT_DW"."BB"."DIM_Account"
WHERE AccountDimID IN(SELECT AccountDimID From "FENXT_DW"."BB_DELTA"."DIM_Account");

Insert Into "FENXT_DW"."BB"."DIM_Account"
Select 
  AccountDimID                
, AccountSystemID             
, AccountNumber               
, AccountCode                 
, AccountCodeSystemID         
, AccountDescription          
, AccountCategorySystemID     
, AccountCategoryDescription  
, ClassDimID                  
, ClassSystemID               
, ClassDescription            
, FundSystemID                
, FundID                      
, FundDescription             
, WorkingCapitalSystemID      
, WorkingCapital              
, CashFlowSystemID            
, CashFlow                    
, AccountStatusSystemID       
, AccountStatusDescription    
, PreventPostDate             
, GeneralInfoSystemID         
, DateAdded                   
, DateChanged                 
, ContraAccount               
, ControlAccount              
, CashAccount                 
, AnnotationText   
From "FENXT_DW"."BB_DELTA"."DIM_Account"
WHERE UpdatedStatus In('New','Modified');

