USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_Emails"
    (
        prospectID 	varchar(20)
        ,email 		varchar(1000)
    )
 ;

INSERT INTO "DNRCNCT_Emails"
SELECT
    ConstituentID 		as prospectID
    ,PC.EMAILADDRESS 	as email
FROM "OSUADV_PROD"."RE"."CONSTITUENT" C
        INNER JOIN "OSUADV_PROD"."RE"."PREFERREDCONTACT" PC ON C.CONSTITUENTSYSTEMID = PC.CONSTITUENTSYSTEMID
        INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" IL ON C.CONSTITUENTSYSTEMID = IL.CONSTITUENTSYSTEMID