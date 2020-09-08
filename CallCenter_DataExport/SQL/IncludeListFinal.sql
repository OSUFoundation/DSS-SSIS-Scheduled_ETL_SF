USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_InclLst_minus_ExclLst"
(
    CONSTITUENTSYSTEMID INT
)
;
INSERT INTO "DNRCNCT_InclLst_minus_ExclLst"
SELECT 
    C.CONSTITUENTSYSTEMID
        
FROM
    "OSUADV_PROD"."RE"."CONSTITUENT" C
                                        /*Include Criteria*/
                                        INNER JOIN 
                                                (
                                                    SELECT
                                                        CONSTITUENTSYSTEMID

                                                    FROM
                                                        "OSUADV_PROD"."BI"."DNRCNCT_IncludeList"
                                                  
                                                    UNION
                                                  
                                                    SELECT
                                                        SPC.CONSTITUENTSYSTEMID

                                                    FROM
                                                        "OSUADV_PROD"."BI"."DNRCNCT_IncludeList" E  INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" C ON E.CONSTITUENTSYSTEMID = C.CONSTITUENTSYSTEMID
                                                                                                    INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" SPC ON C.SPOUSECONSTITUENTSYSTEMID = SPC.CONSTITUENTSYSTEMID

                                                    WHERE
                                                        SPC.CONSTITUENTID IS NOT NULL   
            
                                                ) AS IL ON C.CONSTITUENTSYSTEMID = IL.CONSTITUENTSYSTEMID
      
                                        /*Exclude Criteria*/
                                        LEFT OUTER JOIN
                                                (

                                                    SELECT
                                                        CONSTITUENTSYSTEMID

                                                    FROM
                                                        "OSUADV_PROD"."BI"."DNRCNCT_ExcludeList"

                                                    WHERE
                                                        EXCLUSIONGROUP = 'Individuals'

                                                    UNION

                                                    SELECT
                                                        CONSTITUENTSYSTEMID

                                                    FROM
                                                        "OSUADV_PROD"."BI"."DNRCNCT_ExcludeList" 

                                                    WHERE
                                                        EXCLUSIONGROUP = 'Households' 

                                                    UNION

                                                    SELECT
                                                        SPC.CONSTITUENTSYSTEMID

                                                    FROM
                                                        "OSUADV_PROD"."BI"."DNRCNCT_ExcludeList" E  INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" C ON E.CONSTITUENTSYSTEMID = C.CONSTITUENTSYSTEMID
                                                                                                    INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" SPC ON C.SPOUSECONSTITUENTSYSTEMID = SPC.CONSTITUENTSYSTEMID

                                                    WHERE
                                                        E.EXCLUSIONGROUP = 'Households'
                                                    AND SPC.CONSTITUENTID IS NOT NULL
                                                  
                                                  )  EL ON C.CONSTITUENTSYSTEMID = EL.CONSTITUENTSYSTEMID
      
WHERE
    C.CONSTITUENTSYSTEMID <> -1
AND C.CONSTITUENTID IS NOT NULL
AND EL.CONSTITUENTSYSTEMID IS NULL;