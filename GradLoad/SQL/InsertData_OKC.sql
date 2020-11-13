USE OSUF_INTERFACES.FACULTY_STAFF;


CREATE OR REPLACE STAGE CSV_Stage
  FILE_FORMAT = FileFormat_CSV_Quotes;
  
PUT file://E:\BI\Scheduled_ETL_SF\GradLoad\FilesForImport\OKC*.csv @CSV_Stage;


COPY INTO "GradLoad_OKC"
  FROM @CSV_Stage
  FILE_FORMAT = (format_name = FileFormat_CSV_Quotes)
  PATTERN = '.*[.]csv[.]gz'
  ON_ERROR = 'skip_file';
  