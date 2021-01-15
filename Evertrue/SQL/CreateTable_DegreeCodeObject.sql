USE "OSUF_INTERFACES"."FACULTY_STAFF";

CREATE OR REPLACE TABLE "OSUF_INTERFACES"."FACULTY_STAFF"."SF_DegreeCodeObject"
(
    Id nvarchar(18),
    IsDeleted nvarchar(18),
    LastReferencedDate nvarchar(50),
    LastViewedDate nvarchar(50),
    Name nvarchar(80),
    OwnerId nvarchar(18),
    ucinn_ascendv2__Degree_Code nvarchar(40),
    ucinn_ascendv2__Degree_Level nvarchar(255),
    ucinn_ascendv2__Description nvarchar(255),
    ucinn_ascendv2__Is_Active nvarchar(18),
    ucinn_ascendv2__Notes nvarchar(500)

)
