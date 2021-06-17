CREATE OR REPLACE TABLE "FENXT_DW"."BB"."DIM_ProjectNote"
(
	ProjectNoteDimID  NUMBER(38,0)
	,ProjectDimID  NUMBER(38,0)
	,NotesID  NUMBER(38,0)
	,NotePadType  VARCHAR(256)
	,Description  VARCHAR(300)
	,Title  VARCHAR(256)
	,Author  VARCHAR(256)
	,ActualNotes  STRING
	,NoteDate  TIMESTAMP_NTZ(9)
	,Sequence  NUMBER(38,0)
	,LastChangedBy  VARCHAR(256)
	,LastChangedByID  NUMBER(38,0)
	,DateChanged  TIMESTAMP_NTZ(9)
	,ImportID  VARCHAR(256)
);                                              



COPY INTO "FENXT_DW"."BB"."DIM_ProjectNote" FROM '@BB_DELTA_STAGE/DIM_ProjectNoteAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

