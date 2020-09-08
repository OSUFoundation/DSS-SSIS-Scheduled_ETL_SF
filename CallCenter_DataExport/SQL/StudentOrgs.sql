USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_StudentOrgs"
    (
        prospectID varchar(20)
        ,value varchar(1000)
        ,FileNumber INT
    )
 ;

INSERT INTO "DNRCNCT_StudentOrgs"
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
              WHEN RollingCharCount <= 600 THEN 6
              WHEN RollingCharCount <= 700 THEN 7
              WHEN RollingCharCount <= 800 THEN 8
              WHEN RollingCharCount <= 900 THEN 9
              WHEN RollingCharCount <= 1000 THEN 10
              WHEN RollingCharCount <= 1100 THEN 11
              ELSE 0 END FileNumber
      FROM 
        (
          SELECT
              ProspectID
              ,CONSTITUENTSYSTEMID
              ,AttributeDescription
              ,CASE WHEN NumberofCharactersSubsuquentRow IS NULL THEN NumberofCharacters ELSE NumberofCharacters + 1 END CharacterCount
              ,SUM(CASE WHEN NumberofCharactersSubsuquentRow IS NULL THEN NumberofCharacters ELSE NumberofCharacters + 1 END) OVER(PARTITION BY ProspectID ORDER BY ProspectID, AttributeDescription) RollingCharCount
          FROM
            (
              SELECT
                ProspectID
                ,CONSTITUENTSYSTEMID
                ,ATTRIBUTEDESCRIPTION
                ,NumberofCharacters
                ,LEAD(LEN(ATTRIBUTEDESCRIPTION)) OVER(PARTITION BY ProspectID ORDER BY ProspectID, ATTRIBUTEDESCRIPTION) NumberofCharactersSubsuquentRow
                ,SUM(LEN(ATTRIBUTEDESCRIPTION)) OVER(PARTITION BY ProspectID ORDER BY ProspectID, ATTRIBUTEDESCRIPTION) RollingTotal
              FROM
                (
                  SELECT DISTINCT
                  C.CONSTITUENTID ProspectID
                  ,C.CONSTITUENTSYSTEMID
                  ,ATTRIBUTEDESCRIPTION
                  ,LEN(ATTRIBUTEDESCRIPTION) NumberofCharacters

                  FROM 
                    "OSUADV_PROD"."RE"."REL_DTL_EDUCATIONATTRIBUTES" EA
                    INNER JOIN "OSUADV_PROD"."RE"."REL_EDUCATION" E ON E.EDUCATIONSYSTEMID = EA.EDUCATIONSYSTEMID
                    INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" C ON C.CONSTITUENTSYSTEMID = E.CONSTITUENTSYSTEMID
                  WHERE 
                    ATTRIBUTECATEGORY = 'Student Organization'
                    AND ATTRIBUTEDESCRIPTION IS NOT NULL
                    AND ATTRIBUTEDESCRIPTION <> ''
                ) A
            ) SO
        ) SOF
    ) SOFC
    INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" IME ON IME.CONSTITUENTSYSTEMID = SOFC.CONSTITUENTSYSTEMID
GROUP BY ProspectID, FileNumber