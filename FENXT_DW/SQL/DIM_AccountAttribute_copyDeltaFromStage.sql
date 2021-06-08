CREATE OR REPLACE TABLE "DIM_AccountAttribute"
(
AccountDimID numeric(38,0),
AccountSystemID numeric(38,0),
AccountAttributeDimID numeric(38,0),
AccountAttributeSystemID numeric(38,0),
AttributeCategory varchar(256),
AttributeDescription varchar(256),
AttributeDescriptionShort varchar(256),
Sequence numeric(38,0),
Comments varchar(256),
AttributeDate TIMESTAMP_NTZ(9),
TypeOfData varchar(256),
Required varchar(256),
MustBeUnique varchar(256),
UpdatedStatus varchar(256)
);                                              



COPY INTO "DIM_AccountAttribute" FROM '@BB_DELTA_STAGE/DIM_AccountAttributeDelta.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

