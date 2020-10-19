USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_ConstituentCodes"
    (
        prospectID varchar(20)
        ,value varchar(1000)
    )
 ;

INSERT INTO "DNRCNCT_ConstituentCodes"
SELECT 
    c.CONSTITUENTID AS prospectID
    ,LISTAGG(cc.CONSTITUENTCODE,',') WITHIN GROUP (ORDER BY cc.Sequence, cc.CONSTITUENTCODE) AS value

FROM
   "OSUADV_PROD"."RE"."CONSTITUENT" c
        INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT_DTL_CONSTITUENTCODES" cc ON c.CONSTITUENTSYSTEMID = cc.CONSTITUENTSYSTEMID
        INNER JOIN "DNRCNCT_InclLst_minus_ExclLst" IL ON cc.CONSTITUENTSYSTEMID = IL.CONSTITUENTSYSTEMID

GROUP BY 
    c.CONSTITUENTID

