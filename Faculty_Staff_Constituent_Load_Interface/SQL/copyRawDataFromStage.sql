CREATE OR REPLACE TABLE "01_NewData"
(
  "CWID"                         varchar(10)
, "Preferred_FName"              varchar(150)
, "FirstName"                    varchar(150)
, "MiddleName"                   varchar(150)
, "LastName"                     varchar(150)
, "Suffix"                       varchar(10)
, "Gender"                       varchar(25)
, "PrimaryBusinessPosition"      varchar(150)
, "Campus"                       varchar(150)
, "PrimaryBusinessOrgName"       varchar(150)
, "PrimaryBusinessAddress"       varchar(150)
, "HIRING_LOCATION"              varchar(150)
, "HIRING_LOCATION_DESC"         varchar(150)
, "PrimaryBusinessCity"          varchar(150)
, "PrimaryBusinessState"         varchar(10)
, "PrimaryBusinessZip"           varchar(10)
, "EMAIL_PREFERRED_ADDRESS"      varchar(150)
, "StudentEmployee?"             varchar(3)
, "EmployeeStatus"               varchar(25)
, "Job Type"                     varchar(25)
, "OSU Grad Self Rpt"            varchar(3)
, "Retiree"                      varchar(3)
, "Separated"                    date 
, "LastUpdateDate"               date
);

COPY INTO "01_NewData" FROM '@STAGE/FoundationFacultyStaffFile.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@STAGE';

