USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_Address"
    (
        ProspectID varchar(20)
        ,Address1 varchar(200)
        ,Address2 varchar(200)
        ,Address3 varchar(200)
        ,City varchar(100)
        ,State varchar(10)
        ,PostCode varchar(20) 
    )
 ;

INSERT INTO "DNRCNCT_Address"
SELECT
    c.ConstituentID AS ProspectID
    ,COALESCE(a.Address1, '') AS Address1
    ,COALESCE(a.Address2, '') AS Address2
    ,COALESCE(a.Address3, '') AS Address3
    ,COALESCE(a.City, '') AS City
    ,COALESCE(a.State, '') AS State
    ,COALESCE(a.PostCode, '') AS Zip
FROM
    "OSUADV_PROD"."RE"."CONSTITUENT" c
        INNER JOIN "OSUADV_PROD"."RE"."REL_CONSTITUENTADDRESS" ca ON c.ConstituentSystemID = ca.ConstituentSystemID
        INNER JOIN "OSUADV_PROD"."RE"."ADDRESS" a ON ca.AddressSystemID = a.AddressSystemID
        INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" iem ON c.ConstituentSystemID = iem.ConstituentSystemID
        
WHERE
    COALESCE(c.ConstituentID, '') <> ''
    AND ca.PREFERRED = 'Yes'