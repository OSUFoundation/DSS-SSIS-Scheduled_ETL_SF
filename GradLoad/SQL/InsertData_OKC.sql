USE OSUF_INTERFACES.GRADLOAD;


CREATE OR REPLACE STAGE CSV_Stage
  FILE_FORMAT = CSV_DBLQT;
  
PUT file://E:\BI\Scheduled_ETL_SF\GradLoad\FilesForImport\OSU_OKC\OKC*.csv @CSV_Stage;


COPY INTO "GradLoad_OKC"
  FROM @CSV_Stage
  FILE_FORMAT = (format_name = CSV_DBLQT)
  PATTERN = '.*[.]csv[.]gz'
  ON_ERROR = 'skip_file';
  