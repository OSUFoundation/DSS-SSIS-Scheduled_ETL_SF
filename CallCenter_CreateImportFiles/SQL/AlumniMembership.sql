USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "OSUADV_PROD"."BI"."DNRCNCT_AlumniMembership"
    (
        prospectID INT
        ,value varchar(100)

    )
;

INSERT INTO "OSUADV_PROD"."BI"."DNRCNCT_AlumniMembership"

SELECT
    c.ConstituentID AS prospectID
    ,CONCAT(t.ProgramName, '-',CASE WHEN t.Type != 'Dropped' THEN 'Active' ELSE 'Lapsed' END, '-', COALESCE(CAST(t.ExpiresOn AS varchar(20)), '')) AS value  
    --,ROW_NUMBER() OVER(PARTITION BY t.ConstituentSystemID ORDER BY CASE WHEN t.PROGRAMNAME = 'Life Membership Plus' THEN 1 ELSE 2 END, t.ActivityDate DESC) AS Seq

FROM
    "OSUADV_PROD"."RE"."MEMBERSHIP_DTL_MEMBERSHIPTRANSACTIONS" t
        INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" c ON t.ConstituentSystemID = c.ConstituentSystemID
        --INNER JOIN "DNRCNCT_InclLst_minus_ExclLst" ime ON c.ConstituentSystemID = ime.ConstituentSystemID
WHERE
    t.PROGRAMNAME LIKE 'Life Membership%'
    
QUALIFY   
    ROW_NUMBER() OVER(PARTITION BY t.ConstituentSystemID ORDER BY CASE WHEN t.PROGRAMNAME = 'Life Membership Plus' THEN 1 ELSE 2 END, t.ActivityDate DESC) = 1