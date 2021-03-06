USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_LoyaltyGiving"
    (
        prospectID varchar(20)
        ,value varchar(1000)
    )
 ;

INSERT INTO "DNRCNCT_LoyaltyGiving"
SELECT
  C.CONSTITUENTID prospectID
  ,CONCAT(CA.ATTRIBUTECATEGORY, ':', ' ', CA.ATTRIBUTEDESCRIPTION) AS value

FROM 
    "OSUADV_PROD"."RE"."CONSTITUENT_DTL_ATTRIBUTES" CA
    INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" C ON C.CONSTITUENTSYSTEMID = CA.CONSTITUENTSYSTEMID
    INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" IME ON IME.CONSTITUENTSYSTEMID = C.CONSTITUENTSYSTEMID

WHERE 
    CA.ATTRIBUTECATEGORY = 'Loyalty Giving'
    AND CA.ATTRIBUTECOMMENTS = 'OSU Foundation'
