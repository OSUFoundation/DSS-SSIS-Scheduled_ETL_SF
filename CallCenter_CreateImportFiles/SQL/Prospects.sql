USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_Prospects"
    (
         prospectID varchar(20)
        ,firstname varchar(100)
        ,lastname varchar(100)
        ,preferredname varchar(100)
        ,title varchar(100) 
    )
 ;

INSERT INTO "DNRCNCT_Prospects"
SELECT
     C.CONSTITUENTID 	AS prospectID
    ,C.FIRSTNAME 		AS firstname
    ,C.SURNAME 			AS lastname
    ,S.SALUTATION 		AS preferredname
    ,C.TITLE 			AS title
FROM
    "OSUADV_PROD"."RE"."CONSTITUENT" C
        INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" IL ON C.CONSTITUENTSYSTEMID = IL.CONSTITUENTSYSTEMID
        LEFT OUTER JOIN 
            (
                SELECT
                    CONSTITUENTSYSTEMID
                    ,SALUTATION
                FROM
                    "OSUADV_PROD"."RE"."CONSTITUENT_DTL_SALUTATIONS"
                WHERE
                    SALUTATIONTYPE = 'Primary Salutation - Single'                
            ) S ON C.CONSTITUENTSYSTEMID = S.CONSTITUENTSYSTEMID
;    
 