CREATE OR REPLACE TABLE "DIM_PROJECTATTRIBUTE"
(
  ProjectAttributeDimID Number(38,0),
  ProjectAttributeSystemID Number(38,0),
  ProjectDimID Number(38,0),
  ProjectSystemID Number(38,0),
  AttributeCategory varchar(256),
  AttributeDescription varchar(256),
  Comments varchar(256),
  AttributeDate TIMESTAMP_NTZ(9),
  Sequence Number(38,0),
  TypeOfData varchar(256),
  Required varchar(256),
  MustBeUnique varchar(256),
  ImportID varchar(256),
  DateAdded TIMESTAMP_NTZ(9),
  DateChanged TIMESTAMP_NTZ(9)
    
);                                              



COPY INTO "DIM_PROJECTATTRIBUTE" FROM '@BB_DELTA_STAGE/DIM_ProjectAttributeDelta.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

