USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_StudentOrgs_Files"
    (
        FileNumber INT
    )
 ;

INSERT INTO "DNRCNCT_StudentOrgs_Files"
SELECT DISTINCT FileNumber 
FROM "DNRCNCT_StudentOrgs";