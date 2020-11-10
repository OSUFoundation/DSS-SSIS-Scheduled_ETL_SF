USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_AgeName"
    (
        prospectID varchar(20)
        ,value varchar(1000)
    )
 ;

INSERT INTO "DNRCNCT_AgeName"
    SELECT 
        C.ConstituentID AS prospectID
        ,CONCAT(COALESCE(C.AGE,0), ', ', C.FULLNAME) AS value
        
    FROM "OSUADV_PROD"."RE"."CONSTITUENT" C
            INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" IME ON IME.CONSTITUENTSYSTEMID = C.CONSTITUENTSYSTEMID

    WHERE 
        C.KEYINDICATOR = 'I' 
        AND C.CONSTITUENTID IS NOT NULL
;