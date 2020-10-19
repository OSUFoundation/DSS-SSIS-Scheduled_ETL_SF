USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_GradYear"
    (
        ProspectID varchar(20)
        ,degree varchar(100)
        ,gradyear INT
    )
 ;

INSERT INTO "DNRCNCT_GradYear"
SELECT
    CONSTITUENTID prospectid
    ,CONCAT(LEFT(DEGREE,CHARINDEX('-', DEGREE) - 2),'-',COALESCE(MAJOR,''), '-', COALESCE(SCHOOLTYPE,'')) degree
    ,YEAR(DATEGRADUATED) gradyear
FROM 
    "OSUADV_PROD"."BI"."DNRCNCT_EDUCATION" E
        INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" C ON C.CONSTITUENTSYSTEMID = E.CONSTITUENTSYSTEMID
        INNER JOIN"OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" IME ON C.CONSTITUENTSYSTEMID = IME.CONSTITUENTSYSTEMID
WHERE 
    DEGREE IS NOT NULL 
    AND DEGREE != 'ATD - ATTENDED/NO DEGREE'
ORDER BY
    CONSTITUENTID
    ,E.Seq

;