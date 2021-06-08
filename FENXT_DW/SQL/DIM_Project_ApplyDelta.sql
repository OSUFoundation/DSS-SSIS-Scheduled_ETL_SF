DELETE FROM "FENXT_DW"."BB"."DIM_Project"
WHERE ProjectDimID IN(SELECT "ProjectDimID" From "FENXT_DW"."BB_DELTA"."DIM_PROJECT");

Insert Into "FENXT_DW"."BB"."DIM_Project"
Select 
  "ProjectDimID"
, "ProjectSystemID"
, "ProjectDescription"
, "ProjectStatusID"
, "ProjectStatusDescription"
, "ProjectTypeID"
, "ProjectTypeDescription"
, "ProjectStartDate"
, "ProjectEndDate"
, "ProjectActive"
, "DateAdded"
, "DateChanged"
, "AnnotationText"
, "ProjectID"
, "ImportID"
From "FENXT_DW"."BB_DELTA"."DIM_PROJECT"
WHERE "UpdatedStatus" In('New','Modified');

