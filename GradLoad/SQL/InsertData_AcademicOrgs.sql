USE OSUF_INTERFACES.FACULTY_STAFF;


CREATE OR REPLACE STAGE CSV_Stage
  FILE_FORMAT = CSV_DBLQT;
  
PUT file://E:\BI\Scheduled_ETL_SF\GradLoad\FilesForImport\SF_AcademicOrg*.csv @CSV_Stage;


COPY INTO "GradLoad_SF_AcademicOrgs"
  FROM @CSV_Stage
  FILE_FORMAT = (format_name = CSV_DBLQT)
  PATTERN = '.*[.]csv[.]gz'
  ON_ERROR = 'skip_file';
  