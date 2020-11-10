USE OSUADV_PROD.BI;

CREATE OR REPLACE TEMPORARY TABLE tmp_Life
    (
        ConstituentSystemID INT
        ,MembershipTransactionSystemID INT
        ,MaxDate Date
    )
;
INSERT INTO tmp_Life
SELECT 
    
    ConstituentSystemID
    ,MembershipTransactionSystemID
    ,MAX(ActivityDate) AS MaxDate

FROM
    "OSUADV_PROD"."RE"."MEMBERSHIP_DTL_MEMBERSHIPTRANSACTIONS"
        
WHERE
    PROGRAMNAME = 'Life Membership'

GROUP BY
    ConstituentSystemID
    ,MembershipTransactionSystemID   
;

CREATE OR REPLACE TEMPORARY TABLE tmp_LifePlus
    (
        ConstituentSystemID INT
        ,MembershipTransactionSystemID INT
        ,MaxDate Date
    )
;


INSERT INTO tmp_LifePlus

SELECT 
    ConstituentSystemID
    ,MembershipTransactionSystemID
    ,MAX(ActivityDate)

FROM
    "OSUADV_PROD"."RE"."MEMBERSHIP_DTL_MEMBERSHIPTRANSACTIONS"
        
WHERE
    PROGRAMNAME = 'Life Membership Plus'

GROUP BY
    ConstituentSystemID
    ,MembershipTransactionSystemID
;

CREATE OR REPLACE TEMPORARY TABLE tmp_All
    (
        MembershipTransactionSystemID INT
    )
;
INSERT INTO tmp_All
SELECT
    MembershipTransactionSystemID    

FROM
    tmp_LifePlus
;
INSERT INTO tmp_All
SELECT
    l.MembershipTransactionSystemID    

FROM
    tmp_Life l
        LEFT OUTER JOIN tmp_All a ON l.MembershipTransactionSystemID = a.MembershipTransactionSystemID
WHERE
    a.MembershipTransactionSystemID IS NULL
;    

CREATE OR REPLACE TABLE "OSUADV_PROD"."BI"."DNRCNCT_AlumniMembership"
    (
        prospectID INT
        ,value varchar(100)
    )
;
INSERT INTO "OSUADV_PROD"."BI"."DNRCNCT_AlumniMembership"
SELECT *
FROM
(
    SELECT DISTINCT
        c.ConstituentID AS prospectID
        ,CONCAT(t.ProgramName, '-',CASE WHEN t.Type != 'Dropped' THEN 'Active' ELSE 'Lapsed' END, '-', t.EXPIRESON) AS value

    FROM 
        tmp_All a
            INNER JOIN "OSUADV_PROD"."RE"."MEMBERSHIP_DTL_MEMBERSHIPTRANSACTIONS" t ON a.MembershipTransactionSystemID = t.MembershipTransactionSystemID
            INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" c ON t.ConstituentSystemID = c.ConstituentSystemID
            INNER JOIN "DNRCNCT_InclLst_minus_ExclLst" ime ON c.ConstituentSystemID = ime.ConstituentSystemID
)
WHERE Value IS NOT NULL
        


        
