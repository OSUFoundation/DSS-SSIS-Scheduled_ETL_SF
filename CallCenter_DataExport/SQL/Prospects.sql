USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_Prospects"
    (
        ProspectID varchar(20)
        ,FirstName varchar(100)
        ,LastName varchar(100)
        ,PreferredName varchar(100)
        ,Title varchar(100) 
    )
 ;

INSERT INTO "DNRCNCT_Prospects"
SELECT
    c.ConstituentID
    ,c.FIRSTNAME
    ,c.SURNAME
    ,s.Salutation
    ,c.Title
FROM
    "OSUADV_PROD"."RE"."CONSTITUENT" c
        INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" iem ON c.ConstituentSystemID = iem.ConstituentSystemID
        LEFT OUTER JOIN 
            (
                SELECT
                    ConstituentSystemID
                    ,Salutation
                FROM
                    "OSUADV_PROD"."RE"."CONSTITUENT_DTL_SALUTATIONS"
                WHERE
                    SalutationType = 'Primary Salutation - Single'
                --IsPrimarySalutation = 'Yes'
            ) s ON c.ConstituentSystemID = s.ConstituentSystemID
WHERE
    c.KEYINDICATOR = 'I'
    AND COALESCE(c.ConstituentID, '') <> ''

;    
 