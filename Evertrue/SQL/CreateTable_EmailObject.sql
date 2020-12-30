USE "OSUF_INTERFACES"."FACULTY_STAFF";

CREATE OR REPLACE TABLE "OSUF_INTERFACES"."FACULTY_STAFF"."SF_EmailObject"
(
    E_Receipt NVARCHAR(18),
    Employer_Affiliation nvarchar(18),
    Employer_Affiliation_Organization nvarchar(1300),
    Id nvarchar(18),
    IsDeleted NVARCHAR(18),
    Is_Exception NVARCHAR(18),
    LastReferencedDate NVARCHAR(50),
    LastViewedDate NVARCHAR(50),
    MCPA NVARCHAR(18),
    Name nvarchar(80),
    OwnerId nvarchar(18),
    RecordTypeId nvarchar(18),
    Vendor NVARCHAR(18),
    ucinn_ascendv2__Account nvarchar(18),
    ucinn_ascendv2__Contact nvarchar(18),
    ucinn_ascendv2__Data_Source nvarchar(255),
    ucinn_ascendv2__Email_Address nvarchar(80),
    ucinn_ascendv2__Email_Name_Auto_Number nvarchar(30),
    ucinn_ascendv2__End_Date NVARCHAR(50),
    ucinn_ascendv2__External_System_ID nvarchar(255),
    ucinn_ascendv2__Is_Preferred NVARCHAR(18),
    ucinn_ascendv2__Notes STRING,
    ucinn_ascendv2__Source nvarchar(255),
    ucinn_ascendv2__Start_Date NVARCHAR(50),
    ucinn_ascendv2__Status nvarchar(255),
    ucinn_ascendv2__Type nvarchar(255)
)
;