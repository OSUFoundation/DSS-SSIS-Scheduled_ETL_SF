USE "OSUF_INTERFACES"."FACULTY_STAFF";

CREATE OR REPLACE TABLE "OSUF_INTERFACES"."FACULTY_STAFF"."SF_AcademicOrgObject" 
(
    End_Date nvarchar(50),
    Id nvarchar(18),
    IsDeleted nvarchar(18),
    Is_Degree_granting_Unit nvarchar(18),
    LastReferencedDate nvarchar(50),
    LastViewedDate nvarchar(50),
    Location nvarchar(255),
    Main_Campus nvarchar(18),
    Name nvarchar(80),
    OwnerId nvarchar(18),
    ucinn_ascendv2__Code nvarchar(50),
    ucinn_ascendv2__Description_Long nvarchar(255),
    ucinn_ascendv2__Description_Short nvarchar(50),
    ucinn_ascendv2__Effective_Date nvarchar(18),
    ucinn_ascendv2__External_System_ID nvarchar(255),
    ucinn_ascendv2__Is_Fundraiser_Unit nvarchar(18),
    ucinn_ascendv2__Parent_Academic_Organization nvarchar(50),
    ucinn_ascendv2__Type nvarchar(255)
)
