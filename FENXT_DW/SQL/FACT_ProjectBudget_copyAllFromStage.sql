CREATE OR REPLACE TABLE "FENXT_DW"."BB"."FACT_ProjectBudget"
(
	ProjectBudgetFactID  NUMBER(38,0)
	,ProjectBudgetDetailSystemID  NUMBER(38,0)
	,ProjectBudgetSystemID  NUMBER(38,0)
	,ScenarioDimID  NUMBER(38,0)
	,ScenarioSystemID  NUMBER(38,0)
	,ScenarioID  NUMBER(38,0)
	,ScenarioDescription  VARCHAR(256)
	,ScenarioSequence  NUMBER(38,0)
	,AccountBudgetID  NUMBER(38,0)
	,AccountDimID  NUMBER(38,0)
	,AccountSystemID  NUMBER(38,0)
	,ProjectDimID  NUMBER(38,0)
	,ProjectSystemID  NUMBER(38,0)
	,FiscalPeriodSystemID  NUMBER(38,0)
	,Amount  NUMBER(20,4)
	,Percent  NUMBER(20,4)
	,PeriodStartDate  TIMESTAMP_NTZ(9)
	,PeriodStartDateDimID  NUMBER(38,0)
	,PeriodEndDate  TIMESTAMP_NTZ(9)
	,PeriodEndDateDimID  NUMBER(38,0)
	,IsFiscalYearClosed  VARCHAR(256)
	,PeriodSequence  NUMBER(38,0)
	,FiscalYearDesc  VARCHAR(256)
	,FiscalYearSequence  NUMBER(38,0)
	,FiscalPeriods  NUMBER(38,0)
	,FiscalYearStatus  NUMBER(38,0)
	,DateAdded  TIMESTAMP_NTZ(9)
	,DateChanged  TIMESTAMP_NTZ(9)
	,ETLControlID  NUMBER(38,0)
	,SourceID  NUMBER(38,0)
	,DateUpdated  TIMESTAMP_NTZ(9)
);

COPY INTO "FENXT_DW"."BB"."FACT_ProjectBudget" FROM '@BB_DELTA_STAGE/FACT_ProjectBudgetAll.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT');


//Delete all files from STAGE
REMOVE '@BB_DELTA_STAGE';

