USE OSUF_INTERFACES.FACULTY_STAFF;


CREATE OR REPLACE STAGE CSV_Stage
  FILE_FORMAT = CSV_DBLQT;
  
PUT file://E:\BI\Scheduled_ETL_SF\GradLoad\FilesForImport\STW_OSUGRAD.csv @CSV_Stage;


COPY INTO "GradLoad_STW"
  FROM @CSV_Stage/STW_OSUGRAD.csv
  FILE_FORMAT = (format_name = CSV_DBLQT)
  ON_ERROR = 'skip_file';
  