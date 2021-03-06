CREATE OR REPLACE TABLE "DIM_PROJECT"
(
    "ProjectDimID" number(38,0),                
    "ProjectSystemID" number(38,0),           
    "ProjectDescription" varchar(256),             
    "ProjectStatusID" number(38,0),            
    "ProjectStatusDescription" varchar(256),                 
    "ProjectTypeID" number(38,0),              
    "ProjectTypeDescription" varchar(256),                 
    "ProjectStartDate" TIMESTAMP_NTZ(9),                     
    "ProjectEndDate" TIMESTAMP_NTZ(9),                       
    "ProjectActive" varchar(256), 
    "PreventPostDate" TIMESTAMP_NTZ(9),
	"DateAdded" TIMESTAMP_NTZ(9),
    "DateChanged" TIMESTAMP_NTZ(9),        
    "AnnotationText" varchar(256),                     
    "ProjectID" varchar(256),             
    "ImportID" varchar(256),
    "UpdatedStatus" varchar(256)
    
);                                              



COPY INTO "DIM_PROJECT" FROM '@BB_DELTA_STAGE/DIM_ProjectDelta.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

