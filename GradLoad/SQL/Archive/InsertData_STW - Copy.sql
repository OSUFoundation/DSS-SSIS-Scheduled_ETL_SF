USE OSUF_INTERFACES.FACULTY_STAFF;


CREATE OR REPLACE STAGE CSV_Stage
  FILE_FORMAT = CSV_DBLQT;
  
PUT file://E:\BI\Scheduled_ETL_SF\GradLoad\FilesForImport\STW*.csv @CSV_Stage;


COPY INTO "GradLoad_STW"
  FROM @CSV_Stage
  FILE_FORMAT = (format_name = CSV_DBLQT)
  PATTERN = '.*[.]csv[.]gz'
  ON_ERROR = 'skip_file';
  