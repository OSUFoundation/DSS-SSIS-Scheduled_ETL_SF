USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_Emails"
    (
        prospectID varchar(20)
        ,value varchar(1000)
    )
 ;

INSERT INTO "DNRCNCT_Emails"
SELECT
    ConstituentID prospectID
    ,email
FROM "OSUADV_PROD"."RE"."CONSTITUENT" C
        INNER JOIN (
                      SELECT 
                        ConstituentSystemID
                        ,PhoneNumber email
                      FROM 
                        "OSUADV_PROD"."RE"."CONSTITUENT_DTL_PHONES"
                      WHERE 
                        PHONETYPESUMMARY = 'Email Address'
                        AND PHONETYPE = 'Email List - Primary'
                        AND PHONENUMBER LIKE '%@%'
                   ) E ON C.ConstituentSystemID = E.ConstituentSystemID
        INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" IME ON IME.CONSTITUENTSYSTEMID = C.CONSTITUENTSYSTEMID
           
WHERE IsAConstituent = 'Yes'