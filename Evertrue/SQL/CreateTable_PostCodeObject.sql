USE "OSUF_INTERFACES"."FACULTY_STAFF";

CREATE OR REPLACE TABLE "OSUF_INTERFACES"."FACULTY_STAFF"."SF_PostCodeObject" 
(
    Degree_Code nvarchar(50),
    Id nvarchar(50),
    IsDeleted nvarchar(18),
    LastReferencedDate NVARCHAR(50),
    LastViewedDate NVARCHAR(50),
    Name nvarchar(80),
    OwnerId nvarchar(50),
    ucinn_ascendv2__Degree nvarchar(255),
    ucinn_ascendv2__Degree_Description nvarchar(255),
    ucinn_ascendv2__Degree_Level_Code nvarchar(5),
    ucinn_ascendv2__Effective_Date NVARCHAR(50),
    ucinn_ascendv2__Expiration_Date NVARCHAR(50),
    ucinn_ascendv2__External_System_ID nvarchar(255),
    ucinn_ascendv2__Is_Active nvarchar(18),
    ucinn_ascendv2__Major_Specialty nvarchar(255),
    ucinn_ascendv2__Major_Specialty_Description nvarchar(255),
    ucinn_ascendv2__Post_Code_Description nvarchar(255),
    ucinn_ascendv2__School_1 NVARCHAR(50),
    ucinn_ascendv2__School_1_Name_Formula nvarchar(1300),
    ucinn_ascendv2__School_2 NVARCHAR(50),
    ucinn_ascendv2__School_2_Name_Formula nvarchar(1300),
    ucinn_ascendv2__School_of_Study nvarchar(255)
)
