CREATE OR REPLACE TABLE "FENXT_DW"."BB_DELTA"."DIM_ProjectNote" 
(
     ProjectNoteDimID       number(38,0)
    ,ProjectDimID           number(38,0)
    ,NotesID                number(38,0)
    ,NotePadType            varchar(256)
    ,Description            varchar(256)
    ,Title                  varchar(256)
    ,Author                 varchar(256)
    ,ActualNotes            STRING
    ,NoteDate               TIMESTAMP_NTZ(9)
    ,Sequence               number(38,0)
    ,LastChangedBy          varchar(256)
    ,LastChangedByID        number(38,0)
    ,DateChanged            TIMESTAMP_NTZ(9)
    ,ImportID               varchar(256)
    ,UpdatedStatus          varchar(256)

);                                              



COPY INTO "FENXT_DW"."BB_DELTA"."DIM_ProjectNote" FROM '@BB_DELTA_STAGE/DIM_ProjectNoteDelta.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

