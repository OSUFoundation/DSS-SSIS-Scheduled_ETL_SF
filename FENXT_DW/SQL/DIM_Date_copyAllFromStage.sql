CREATE OR REPLACE TABLE "FENXT_DW"."BB"."DIM_Date"
(
	DateDimID  NUMBER(38,0)
	,CalendarYear  NUMBER(38,0)
	,CalendarHalf  NUMBER(38,0)
	,CalendarHalfName  VARCHAR(256)
	,CalendarQuarter  NUMBER(38,0)
	,CalendarQuarterName  VARCHAR(256)
	,CalendarMonth  NUMBER(38,0)
	,CalendarMonthName  VARCHAR(256)
	,CalendarWeek  NUMBER(38,0)
	,CalendarDayofYear  NUMBER(38,0)
	,FiscalYear  NUMBER(38,0)
	,FiscalHalf  NUMBER(38,0)
	,FiscalHalfName  VARCHAR(256)
	,FiscalQuarter  NUMBER(38,0)
	,FiscalQuarterName  VARCHAR(256)
	,FiscalMonth  NUMBER(38,0)
	,FiscalMonthName  VARCHAR(256)
	,FiscalWeek  NUMBER(38,0)
	,FiscalDayofYear  NUMBER(38,0)
	,DayofMonth  NUMBER(38,0)
	,DayofWeek  NUMBER(38,0)
	,DayName  VARCHAR(256)
	,IsWeekend   VARCHAR(256)
	,IsWeekDay  VARCHAR(256)
	,IsHoliday  VARCHAR(256)
	,IsLeapYear  VARCHAR(256)
	,HolidayName  VARCHAR(256)
	,ActualDate  TIMESTAMP_NTZ(9)
	,FiscalYearStartDate  TIMESTAMP_NTZ(9)
	,FiscalYearEndDate  TIMESTAMP_NTZ(9)
	,FiscalQuarterStartDate  TIMESTAMP_NTZ(9)
	,FiscalQuarterEndDate  TIMESTAMP_NTZ(9)
	,CalendarQuarterStartDate  TIMESTAMP_NTZ(9)
	,CalendarQuarterEndDate  TIMESTAMP_NTZ(9)
	,PeriodStartDate  TIMESTAMP_NTZ(9)
	,PeriodEndDate  TIMESTAMP_NTZ(9)
	,FE_FiscalYear  VARCHAR(256)
	,FE_FiscalYearSequence  NUMBER(38,0)
	,FE_FiscalPeriodStartDate  TIMESTAMP_NTZ(9)
	,FE_FiscalPeriodEndDate  TIMESTAMP_NTZ(9)
	,FE_FiscalPeriodIsClosed  VARCHAR(256)
	,FE_FiscalPeriodSequence  NUMBER(38,0)
	,Sequence  NUMBER(38,0)
	,MonthEnd  VARCHAR(256)
	,QtrEnd  VARCHAR(256)
	,GL7FISCALPERIODSID  NUMBER(38,0)
	,AdjSeq  NUMBER(38,0)
	,YearID  VARCHAR(256)
);

COPY INTO "FENXT_DW"."BB"."DIM_Date" FROM '@BB_DELTA_STAGE/DIM_DateAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

