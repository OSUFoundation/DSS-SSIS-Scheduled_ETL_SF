USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_Address"
    (
         prospectID 		varchar(20)
        ,address1 		varchar(200)
        ,address2 		varchar(200)
        ,address3 		varchar(200)
        ,city 			varchar(100)
        ,state 			varchar(2)
        ,zip 			varchar(20) 
    )
 ;

INSERT INTO "DNRCNCT_Address"
SELECT
    C.CONSTITUENTID 			AS prospectID
    ,COALESCE(PC.ADDRESS1, '') 	AS address1
    ,COALESCE(PC.ADDRESS2, '') 	AS address2
    ,COALESCE(PC.ADDRESS3, '') 	AS address3
    ,COALESCE(PC.CITY, '') 		AS city
    ,COALESCE(PC.STATE, '') 	AS state
    ,COALESCE(PC.POSTCODE, '') 	AS zip
FROM
    "OSUADV_PROD"."RE"."CONSTITUENT" C 
		INNER JOIN "OSUADV_PROD"."RE"."PREFERREDCONTACT" PC ON C.CONSTITUENTSYSTEMID = PC.CONSTITUENTSYSTEMID
        INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" IL ON C.CONSTITUENTSYSTEMID = IL.CONSTITUENTSYSTEMID
