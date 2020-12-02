USE OSUF_INTERFACES.FACULTY_STAFF;

CREATE OR REPLACE TABLE "GradLoad_SF_AcademicOrgs" 
(
	End_Date STRING,
	Id STRING,
	IsDeleted STRING,
	Is_Degree_granting_Unit STRING,
	LastReferencedDate STRING,
	LastViewedDate STRING,
	Location STRING,
	Name STRING,
	OwnerId STRING,
	ucinn_ascendv2__Code STRING,
	ucinn_ascendv2__Description_Long STRING,
	ucinn_ascendv2__Description_Short STRING,
	ucinn_ascendv2__Effective_Date STRING,
	ucinn_ascendv2__External_System_ID STRING,
	ucinn_ascendv2__Is_Fundraiser_Unit STRING,
	ucinn_ascendv2__Parent_Academic_Organization STRING,
	ucinn_ascendv2__Type STRING
)