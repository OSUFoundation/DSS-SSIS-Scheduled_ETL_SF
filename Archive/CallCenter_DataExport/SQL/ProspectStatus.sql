USE OSUADV_PROD.BI;

INSERT INTO "DNRCNCT_ProspectStatus"
    SELECT
        p.PROSPECTID
        ,'Add'
        ,current_date
        ,NULL
    FROM
        "DNRCNCT_Prospects" p
            LEFT OUTER JOIN "DNRCNCT_ProspectStatus" ps ON p.ProspectID = ps.ProspectID    
    WHERE
        ps.PROSPECTID IS NULL   
;
 
INSERT INTO "DNRCNCT_ProspectStatus"
    SELECT
        ps.PROSPECTID
        ,'Delete'
        ,current_date
        ,NULL
    FROM
        "DNRCNCT_ProspectStatus" ps
            LEFT OUTER JOIN "DNRCNCT_Prospects" p ON ps.ProspectID = p.ProspectID    
    WHERE
        p.ProspectID IS NULL
        AND ps.STATUS IN('Add','Reactivate')
        AND ps.EndDate IS NULL  
;

UPDATE "DNRCNCT_ProspectStatus"
    SET
        EndDate = current_date - 1
    WHERE
        PROSPECTID NOT IN(SELECT ProspectID FROM "DNRCNCT_Prospects")
        AND STATUS IN('Add','Reactivate')
        AND EndDate IS NULL
;  

INSERT INTO "DNRCNCT_ProspectStatus"
    SELECT
        p.PROSPECTID
        ,'Reactivate'
        ,current_date
        ,NULL
    FROM
        "DNRCNCT_ProspectStatus" ps
            INNER JOIN "DNRCNCT_Prospects" p ON ps.ProspectID = p.ProspectID      
    WHERE
        ps.STATUS = 'Delete'
        AND ps.EndDate IS NULL
;

UPDATE "DNRCNCT_ProspectStatus"
    SET
        EndDate = current_date - 1 
    WHERE  
        PROSPECTID IN(SELECT ProspectID FROM "DNRCNCT_Prospects")
        AND Status = 'Delete'
        AND EndDate IS NULL
;


    