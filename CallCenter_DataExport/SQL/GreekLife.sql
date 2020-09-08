USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_GreekLife"
    (
        prospectID varchar(20)
        ,value varchar(1000)
        ,FileNumber INT
    )
 ;

INSERT INTO "DNRCNCT_GreekLife"
SELECT
  ProspectID
  ,LISTAGG(AttributeDescription,',') WITHIN GROUP (ORDER BY AttributeDescription) value
  ,FileNumber
FROM 
    (
      SELECT
        ProspectID
        ,CONSTITUENTSYSTEMID
        ,AttributeDescription
      ,CASE WHEN RollingCharCount <= 100 THEN 1
            WHEN RollingCharCount <= 200 THEN 2
            WHEN RollingCharCount <= 300 THEN 3
            WHEN RollingCharCount <= 400 THEN 4
            WHEN RollingCharCount <= 500 THEN 5
            ELSE 0 END FileNumber
      FROM (
            SELECT
              ProspectID
              ,CONSTITUENTSYSTEMID
              ,AttributeDescription
              ,CASE WHEN NumberofCharactersSubsuquentRow IS NULL THEN NumberofCharacters ELSE NumberofCharacters + 1 END CharacterCount
              ,SUM(CASE WHEN NumberofCharactersSubsuquentRow IS NULL THEN NumberofCharacters ELSE NumberofCharacters + 1 END) OVER(PARTITION BY ProspectID ORDER BY ProspectID, AttributeDescription) RollingCharCount
            FROM(
                  SELECT
                    ProspectID
                    ,CONSTITUENTSYSTEMID
                    ,ATTRIBUTEDESCRIPTION
                    ,NumberofCharacters
                    ,LEAD(LEN(ATTRIBUTEDESCRIPTION)) OVER(PARTITION BY ProspectID ORDER BY ProspectID, ATTRIBUTEDESCRIPTION) NumberofCharactersSubsuquentRow
                    ,SUM(LEN(ATTRIBUTEDESCRIPTION)) OVER(PARTITION BY ProspectID ORDER BY ProspectID, ATTRIBUTEDESCRIPTION) RollingTotal
                  FROM (
                          SELECT
                              C.CONSTITUENTID ProspectID
                              ,C.CONSTITUENTSYSTEMID
                              ,ATTRIBUTEDESCRIPTION
                              ,LEN(ATTRIBUTEDESCRIPTION) NumberofCharacters

                          FROM 
                            "OSUADV_PROD"."RE"."REL_DTL_EDUCATIONATTRIBUTES" EA
                            INNER JOIN "OSUADV_PROD"."RE"."REL_EDUCATION" E ON E.EDUCATIONSYSTEMID = EA.EDUCATIONSYSTEMID
                            INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" C ON C.CONSTITUENTSYSTEMID = E.CONSTITUENTSYSTEMID
                          WHERE ATTRIBUTECATEGORY = 'Student Greek Life'
                        ) GL
                ) RGL
            ) FRGL
    ) FGL
    INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" IME ON IME.CONSTITUENTSYSTEMID = FGL.CONSTITUENTSYSTEMID
GROUP BY ProspectID, FileNumber