USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_Children"
    (
        prospectID varchar(20)
        ,value varchar(1000)
    )
 ;

INSERT INTO "DNRCNCT_Children"
SELECT
  C.CONSTITUENTID ProspectID
  ,CONCAT(CC.FIRSTNAME, ' ', CC.SURNAME) FULLNAME
FROM 
  "OSUADV_PROD"."RE"."CONSTITUENT" C
	  INNER JOIN "OSUADV_PROD"."RE"."REL_CONSTITUENT" RC ON C.CONSTITUENTSYSTEMID = RC.CONSTITUENTSYSTEMID AND RC.RELATIONSHIP = 'Child' AND RC.RECIPROCAL = 'Parent'
	  INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" CC ON CC.CONSTITUENTSYSTEMID = RC.RELATEDCONSTITUENTSYSTEMID
	  INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" IME ON IME.CONSTITUENTSYSTEMID = C.CONSTITUENTSYSTEMID
	  
	 
	  
	 