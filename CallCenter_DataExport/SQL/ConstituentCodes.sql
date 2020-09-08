USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_ConstituentCodes"
    (
        ProspectID varchar(20)
        ,value varchar(1000)
    )
 ;

INSERT INTO "DNRCNCT_ConstituentCodes"
SELECT 
    c.ConstituentID AS ProspectID
    ,LISTAGG(cc.ConstituentCode,',') WITHIN GROUP (ORDER BY cc.Sequence, cc.ConstituentCode) AS value

FROM
   "OSUADV_PROD"."RE"."CONSTITUENT" c
        INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT_DTL_CONSTITUENTCODES" cc ON c.ConstituentSystemID = cc.ConstituentSystemID
        INNER JOIN "DNRCNCT_InclLst_minus_ExclLst" ime ON cc.ConstituentSystemID = ime.ConstituentSystemID

GROUP BY 
    c.ConstituentID

