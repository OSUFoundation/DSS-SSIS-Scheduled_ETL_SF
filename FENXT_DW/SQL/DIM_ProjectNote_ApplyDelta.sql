DELETE FROM "FENXT_DW"."BB"."DIM_ProjectNote"
WHERE ImportID IN(SELECT ImportID From "FENXT_DW"."BB_DELTA"."DIM_ProjectNote");

Insert Into "FENXT_DW"."BB"."DIM_ProjectNote"
Select 
     ProjectNoteDimID       
    ,ProjectDimID           
    ,NotesID                
    ,NotePadType            
    ,Description            
    ,Title                  
    ,Author                 
    ,ActualNotes            
    ,NoteDate               
    ,Sequence               
    ,LastChangedBy          
    ,LastChangedByID        
    ,DateChanged            
    ,ImportID               
From "FENXT_DW"."BB_DELTA"."DIM_ProjectNote"
WHERE UpdatedStatus In('New','Modified');

