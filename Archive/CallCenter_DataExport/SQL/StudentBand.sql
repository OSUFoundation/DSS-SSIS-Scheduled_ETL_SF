USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_StudentBand"
    (
        prospectID varchar(20)
        ,value varchar(1000)
    )
 ;

INSERT INTO "DNRCNCT_StudentBand"
SELECT
    C.CONSTITUENTID ProspectID
    ,AttributeDescription value
FROM 
    "OSUADV_PROD"."RE"."REL_DTL_EDUCATIONATTRIBUTES" EA
        INNER JOIN "OSUADV_PROD"."RE"."REL_EDUCATION" E ON E.EDUCATIONSYSTEMID = EA.EDUCATIONSYSTEMID
        INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" C ON C.CONSTITUENTSYSTEMID = E.CONSTITUENTSYSTEMID
        INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" IME ON IME.CONSTITUENTSYSTEMID = C.CONSTITUENTSYSTEMID
WHERE 
    ATTRIBUTECATEGORY = 'Student Band'
GROUP BY 
    C.CONSTITUENTID