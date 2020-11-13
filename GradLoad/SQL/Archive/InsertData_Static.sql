USE OSUF_INTERFACES.FACULTY_STAFF;

create or replace file format mycsvformat
  type = 'CSV'
  skip_header = 1
  field_delimiter = ','
  FIELD_OPTIONALLY_ENCLOSED_BY = '"';
  
  create or replace stage my_csv_stage
  file_format = mycsvformat;
  
put file://c:\temp\load\OKM*.csv @my_csv_stage auto_compress=true;

list @my_csv_stage;

copy into "GradLoad_OKM"
  from @my_csv_stage
  file_format = (format_name = mycsvformat)
  pattern = '.*[.]csv[.]gz'
  on_error = 'skip_file';
  