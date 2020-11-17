USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_JobTitleEmployer"
    (
        prospectID varchar(20)
        ,jobtitle varchar(100)
        ,employer varchar(100)
    )
 ;

INSERT INTO "DNRCNCT_JobTitleEmployer"

SELECT 
   C.CONSTITUENTID  AS prospectID
  ,R.POSITION 		AS jobtitle
  ,RC.FULLNAME 		AS employer

FROM 
    "OSUADV_PROD"."RE"."REL_CONSTITUENT" R
    INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" RC ON RC.CONSTITUENTSYSTEMID = R.RELATEDCONSTITUENTSYSTEMID
    LEFT OUTER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" C ON C.CONSTITUENTSYSTEMID = R.CONSTITUENTSYSTEMID
    INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" IL ON C.CONSTITUENTSYSTEMID = IL.CONSTITUENTSYSTEMID

WHERE 
    R.RELATIONSHIP = 'Employer'
    AND R.RECIPROCAL = 'Employee'
    AND R.ISPRIMARY = 'Yes'
    AND C.FULLNAME <> 'Employer Unknown'