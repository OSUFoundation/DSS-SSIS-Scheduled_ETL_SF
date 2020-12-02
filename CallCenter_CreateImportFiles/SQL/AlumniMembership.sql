USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "OSUADV_PROD"."BI"."DNRCNCT_AlumniMembership"
    (
        prospectID INT
        ,value varchar(100)

    )
;

INSERT INTO "OSUADV_PROD"."BI"."DNRCNCT_AlumniMembership"

SELECT
    c.ConstituentID AS prospectID
    ,CONCAT(t.ProgramName, '-'
                    ,CASE  
                        WHEN ExpiresOn < CURRENT_DATE() THEN 'Lapsed'
                        ELSE 'Active' END
                    , '-', COALESCE(CAST(t.ExpiresOn AS varchar(20)), ''), '-' , 'Balance: ', COALESCE(A.Balance, 0)) AS value 

FROM
    "OSUADV_PROD"."RE"."MEMBERSHIP_DTL_MEMBERSHIPTRANSACTIONS" t
        INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" c ON t.ConstituentSystemID = c.ConstituentSystemID
        INNER JOIN "DNRCNCT_InclLst_minus_ExclLst" ime ON c.ConstituentSystemID = ime.ConstituentSystemID
        
        LEFT OUTER JOIN 
                    (
                        SELECT DISTINCT
                            MEMBERSHIPSYSTEMID, ATTRIBUTEDESCRIPTION AS Balance
                      
                        FROM
                            "OSUADV_PROD"."RE"."MEMBERSHIP_DTL_ATTRIBUTES" 
                      
                        WHERE 
                            ATTRIBUTECATEGORY = 'Life Membership Dues Balance'
                            AND ATTRIBUTEDESCRIPTION > 0
                      
                     ) A ON t.MEMBERSHIPSYSTEMID = A.MEMBERSHIPSYSTEMID
WHERE
    t.PROGRAMNAME LIKE 'Life Membership%'
	AND t.Type != 'Dropped'
    
QUALIFY   
    ROW_NUMBER() OVER(PARTITION BY t.ConstituentSystemID ORDER BY CASE WHEN t.PROGRAMNAME = 'Life Membership Plus' THEN 1 ELSE 2 END, t.ActivityDate DESC) = 1