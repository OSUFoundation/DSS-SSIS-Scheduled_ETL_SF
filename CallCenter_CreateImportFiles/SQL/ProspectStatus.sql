USE OSUADV_PROD.BI;


INSERT INTO "OSUADV_PROD"."BI"."DNRCNCT_ProspectStatus"
SELECT
    c.ConstituentID
    ,'Active'
    ,CURRENT_DATE

FROM
    "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" i
        INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" c ON i.CONSTITUENTSYSTEMID = c.CONSTITUENTSYSTEMID
        LEFT OUTER JOIN "OSUADV_PROD"."BI"."DNRCNCT_ProspectStatus" p ON c.ConstituentID = p.ProspectID
        
WHERE
    p.ProspectID IS NULL
        
;       

UPDATE "OSUADV_PROD"."BI"."DNRCNCT_ProspectStatus"

SET 
    Status        = 'Delete'
    ,DateUpdate   = CURRENT_DATE

WHERE
    ProspectID IN
        (
            SELECT 
                p.ProspectID
            FROM
                "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" i
                    INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" c ON i.CONSTITUENTSYSTEMID = c.CONSTITUENTSYSTEMID
                    RIGHT OUTER JOIN "OSUADV_PROD"."BI"."DNRCNCT_ProspectStatus" p ON c.ConstituentID = p.ProspectID
            WHERE
            c.ConstituentID IS NULL       
        )

;

UPDATE "OSUADV_PROD"."BI"."DNRCNCT_ProspectStatus"

SET Status        = 'Active'
    ,DateUpdate   = CURRENT_DATE

WHERE
    ProspectID IN
        (
            SELECT
                p.ProspectID
            FROM
                "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" i
                    INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" c ON i.CONSTITUENTSYSTEMID = c.CONSTITUENTSYSTEMID
                    INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_ProspectStatus" p ON c.ConstituentID = p.ProspectID       
            WHERE
                p.Status = 'Delete'       
        )

