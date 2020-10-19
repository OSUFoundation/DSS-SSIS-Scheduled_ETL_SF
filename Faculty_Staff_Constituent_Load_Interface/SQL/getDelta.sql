/*Dedupe New Data from OSU by keeping only the most recent Updates */
            CREATE OR REPLACE TEMPORARY TABLE "OSUF_INTERFACES"."FACULTY_STAFF"."tmpNewData"
            (
              "CWID"                         varchar(10)
            , "Preferred_FName"              varchar(150)
            , "FirstName"                    varchar(150)
            , "MiddleName"                   varchar(150)
            , "LastName"                     varchar(150)
            , "Suffix"                       varchar(10)
            , "Gender"                       varchar(25)
            , "PrimaryBusinessPosition"      varchar(150)
            , "Campus"                       varchar(150)
            , "PrimaryBusinessOrgName"       varchar(150)
            , "PrimaryBusinessAddress"       varchar(150)
            , "HIRING_LOCATION"              varchar(150)
            , "HIRING_LOCATION_DESC"         varchar(150)
            , "PrimaryBusinessCity"          varchar(150)
            , "PrimaryBusinessZip"           varchar(10)
            , "EMAIL_PREFERRED_ADDRESS"      varchar(150)
            , "StudentEmployee?"             varchar(3)
            , "EmployeeStatus"               varchar(25)
            , "Job Type"                     varchar(25)
            , "OSU Grad Self Rpt"            varchar(3)
            , "Retiree"                      varchar(3)
            , "Separated"                    date 
            , "LastUpdateDate"               date
			, "FileDate"                     date
            );
            INSERT INTO "OSUF_INTERFACES"."FACULTY_STAFF"."tmpNewData"
            SELECT * 
            FROM "OSUF_INTERFACES"."FACULTY_STAFF"."01_NewData"
            QUALIFY ROW_NUMBER() OVER(PARTITION BY "CWID" ORDER BY "LastUpdateDate" DESC)=1;
			
			
/* Dedupt Historical Data from OSU by keeping only the most recent Updates*/			
            CREATE OR REPLACE TEMPORARY TABLE "OSUF_INTERFACES"."FACULTY_STAFF"."tmpHistData"
            (
              "CWID"                         varchar(10)
            , "Preferred_FName"              varchar(150)
            , "FirstName"                    varchar(150)
            , "MiddleName"                   varchar(150)
            , "LastName"                     varchar(150)
            , "Suffix"                       varchar(10)
            , "Gender"                       varchar(25)
            , "PrimaryBusinessPosition"      varchar(150)
            , "Campus"                       varchar(150)
            , "PrimaryBusinessOrgName"       varchar(150)
            , "PrimaryBusinessAddress"       varchar(150)
            , "HIRING_LOCATION"              varchar(150)
            , "HIRING_LOCATION_DESC"         varchar(150)
            , "PrimaryBusinessCity"          varchar(150)
            , "PrimaryBusinessZip"           varchar(10)
            , "EMAIL_PREFERRED_ADDRESS"      varchar(150)
            , "StudentEmployee?"             varchar(3)
            , "EmployeeStatus"               varchar(25)
            , "Job Type"                     varchar(25)
            , "OSU Grad Self Rpt"            varchar(3)
            , "Retiree"                      varchar(3)
            , "Separated"                    date 
            , "LastUpdateDate"               date
            , "UpdateDate"                   date
            );
            INSERT INTO "OSUF_INTERFACES"."FACULTY_STAFF"."tmpHistData"
            SELECT * 
            FROM "OSUF_INTERFACES"."FACULTY_STAFF"."02_HistData"
            WHERE 1=1
              AND "UpdateDate" In(SELECT Max("UpdateDate")
                                  FROM  "OSUF_INTERFACES"."FACULTY_STAFF"."02_HistData"
                                 )
            QUALIFY ROW_NUMBER() OVER(PARTITION BY "CWID" ORDER BY "LastUpdateDate" Desc)=1;


/* Save Changes since the last FacultyStaff data file from OSU to the Delta Table */
CREATE OR REPLACE TABLE "OSUF_INTERFACES"."FACULTY_STAFF"."FS_Delta" (   "CWID"                         varchar(10)
                                                                       , "Preferred_FName"              varchar(150)
                                                                       , "FirstName"                    varchar(150)
                                                                       , "MiddleName"                   varchar(150)
                                                                       , "LastName"                     varchar(150)
                                                                       , "Suffix"                       varchar(10)
                                                                       , "Gender"                       varchar(25)
																	   , "OrganizationName"             varchar(150)
																	   , "PrimaryBusinessAddressType"   varchar(150)
																	   , "AddressLine1"                 varchar(150)
																	   , "AddressLine2"                 varchar(150)
																	   , "AddressLine3"                 varchar(150)
																	   , "AddressLine4"                 varchar(150)
																	   , "Timesheet_Organization"       varchar(150)
																	   , "PrimaryBusinessCity"          varchar(150)
																	   , "PrimaryBusinessSttate"        varchar(150)
																	   , "PrimaryBusinessZip"           varchar(150)
																	   , "PrimaryBusinessPosition"      varchar(150)
																	   , "PrimaryBusinessEmailType1"    varchar(150)
																	   , "PrimaryBusinessEmailAddress1" varchar(150)
																	   , "StudentEmployee?"             varchar(3)
																	   , "EmployeeStatus"               varchar(150)
																	   , "Job Type"                     varchar(50)
																	   , "OSU Grad Self Rpt"            varchar(3)
																	   , "Retiree"                      varchar(3)
																	   , "Separated"                    DATE
																	   , "Organization Role"            varchar(150)
																	   , "AffiliationStatus"            varchar(150)
																	   , "FileDate"                     date
																	  );
                                                                        
INSERT INTO "OSUF_INTERFACES"."FACULTY_STAFF"."FS_Delta"
SELECT
 *
FROM (
       SELECT Distinct
         N."CWID"
       , N."Preferred_FName" AS "Preferred Name"
       , N."FirstName"
       , N."MiddleName"
       , N."LastName"
       , N."Suffix"
       , N."Gender"
       , CASE N."Campus"
                   WHEN 'OKLAHOMA CITY' THEN 'Oklahoma State University - Oklahoma City'
                   WHEN 'OSU INSTITUTE OF TECHNOLOGY' THEN 'Oklahoma State University - Institute of Technology'
                   WHEN 'CENTER FOR HEALTH SCIENCES' THEN 'Oklahoma State University - Center for Health Sciences'
                   ELSE 'Oklahoma State University'
              END AS "OrganizationName"
	   , 'Business' AS "PrimaryBusinessAddressType"
       , N."Campus" AS "AddressLine1"
       , N."PrimaryBusinessOrgName" AS "AddressLine2"
       , CASE WHEN Extension."CWID" Is Not Null THEN Extension."ADDRESSLINE1"
              //WHEN SortBinID."CWID" Is Not Null THEN SortBinID."Board Coordinate" 
              ELSE N."PrimaryBusinessAddress"
         END AS "AddressLine3"
        
       , CASE WHEN Extension."CWID" Is Not Null THEN Extension."ADDRESSLINE2"
         ELSE Null
         END AS "AddressLine4"  
       , Left(N."PrimaryBusinessOrgName", 6) AS "Timesheet_Organization"
       , N."PrimaryBusinessCity"
       , 'OK' AS "PrimaryBusinessState"
       , N."PrimaryBusinessZip"
       , N."PrimaryBusinessPosition"        
       , 'Business' AS "PrimaryBusinessEmailType1"
       , N."EMAIL_PREFERRED_ADDRESS" AS "PrimaryBusinessEmailAddress1"
       , N."StudentEmployee?"
       , CASE WHEN N."Separated" Is Not Null                            THEN 'Separated'        ELSE N."EmployeeStatus" END AS "EmployeeStatus"
       , N."Job Type"
       , N."OSU Grad Self Rpt"
       , N."Retiree"
       , N."Separated"
       , CASE WHEN N."Separated" Is Not Null AND N."Job Type"='Retiree' THEN 'Retiree Employer' ELSE 'Employer'         END AS "Organization Role"
       , CASE WHEN N."Separated" Is Not NULL OR  N."Job Type"='Retiree' THEN 'Former'           ELSE 'Current'          END AS "AffiliationStatus"
	   , N."FileDate"
             
       FROM "OSUF_INTERFACES"."FACULTY_STAFF"."tmpNewData" N 
            
            /*
                                                              LEFT JOIN (
                                                                          SELECT Distinct
                                                                          FS."CWID"
                                                                          , SB."Board Coordinate"
                                                                          FROM "OSUF_INTERFACES"."FACULTY_STAFF"."tmpNewData" FS LEFT JOIN "OSUF_INTERFACES"."FACULTY_STAFF"."SORTBINASSIGNMENTS" SB ON Left(FS."PrimaryBusinessOrgName", 6)=SB."Timesheet_Organization"
                                                                          WHERE SB."Board Coordinate" Is Not Null
                                                                            AND Coalesce(SB."OSUF_Usage",'')<>'Unused to prevent dupe recs'
                                                                        ) SortBinID ON N."CWID"=SortBinID."CWID"
       
             */
       
                                                              LEFT JOIN (
                                                                          SELECT Distinct
                                                                            FS."CWID"
                                                                          , EX."ADDRESSLINE1" 
                                                                          , EX."ADDRESSLINE2" 
                                                                          , EX."CITY" 
                                                                          , EX."STATE"
                                                                          , EX."ZIPCODE"
                                                                          FROM "OSUF_INTERFACES"."FACULTY_STAFF"."tmpNewData" FS LEFT JOIN "OSUF_INTERFACES"."FACULTY_STAFF"."CountyExtensionOfficeAddresses" EX ON LTrim(RTrim(Right(FS."PrimaryBusinessOrgName", Len(FS."PrimaryBusinessOrgName")-6)))=LTrim(RTrim(EX."FULLNAME"))
                                                                          Where EX."FULLNAME"  Is Not Null
                                                                        ) Extension ON N."CWID"=Extension."CWID"
       
       
       
       
                                                              LEFT OUTER JOIN ( /*compare to most recently historied data set */
                                                                                SELECT *
       																		 FROM "OSUF_INTERFACES"."FACULTY_STAFF"."tmpHistData"
                                                                                WHERE 1=1
                                                                                  AND "UpdateDate" In(SELECT Max("UpdateDate")
                                                                                                      FROM  "OSUF_INTERFACES"."FACULTY_STAFF"."tmpHistData"
                                                                                                     )
                                                                                QUALIFY ROW_NUMBER() OVER(PARTITION BY "CWID" ORDER BY "LastUpdateDate" Desc)=1
                                                                              ) H ON N.CWID=H.CWID
       WHERE  1=1    
         AND (
               H.CWID IS NULL
            OR Coalesce(N."Preferred_FName", '')             <> Coalesce(H."Preferred_FName", '')
            OR Coalesce(N."FirstName", '')                   <> Coalesce(H."FirstName", '')
            OR Coalesce(N."MiddleName", '')                  <> Coalesce(H."MiddleName", '')
            OR Coalesce(N."LastName", '')                    <> Coalesce(H."LastName", '')
            OR Coalesce(N."Suffix", '')                      <> Coalesce(H."Suffix", '')
            OR Coalesce(N."Gender", '')                      <> Coalesce(H."Gender", '')
            OR Coalesce(N."PrimaryBusinessPosition", '')     <> Coalesce(H."PrimaryBusinessPosition", '')
            OR Coalesce(N."Campus", '')                      <> Coalesce(H."Campus", '')
            OR Coalesce(N."PrimaryBusinessOrgName", '')      <> Coalesce(H."PrimaryBusinessOrgName", '')
            OR Coalesce(N."PrimaryBusinessAddress", '')      <> Coalesce(H."PrimaryBusinessAddress", '')
            OR Coalesce(N."HIRING_LOCATION", '')             <> Coalesce(H."HIRING_LOCATION", '')
            OR Coalesce(N."HIRING_LOCATION_DESC", '')        <> Coalesce(H."HIRING_LOCATION_DESC", '')
            OR Coalesce(N."PrimaryBusinessCity", '')         <> Coalesce(H."PrimaryBusinessCity", '')
            OR Coalesce(N."PrimaryBusinessZip", '')          <> Coalesce(H."PrimaryBusinessZip", '')
            OR Coalesce(N."EMAIL_PREFERRED_ADDRESS", '')     <> Coalesce(H."EMAIL_PREFERRED_ADDRESS", '')
            OR Coalesce(N."StudentEmployee?", '')            <> Coalesce(H."StudentEmployee?", '')
            OR Coalesce(N."EmployeeStatus", '')              <> Coalesce(H."EmployeeStatus", '')
            OR Coalesce(N."Job Type", '')                    <> Coalesce(H."Job Type", '')
            OR Coalesce(N."OSU Grad Self Rpt", '')           <> Coalesce(H."OSU Grad Self Rpt", '')
            OR Coalesce(N."Retiree", '')                     <> Coalesce(H."Retiree", '')
            OR Coalesce(N."Separated", '1/1/1901')           <> Coalesce(H."Separated", '1/1/1901')
            OR Coalesce(N."LastUpdateDate", '1/1/1901')      <> Coalesce(H."LastUpdateDate", '1/1/1901')
           )
       
       /* Records coded as OSU Employee, but not in FS data file */
       /* Need to continue thinking about this.  And probably ask Charlie P, what he'd need in the data.*/
 /*      
       UNION
       
       SELECT
         H."CWID"
       , '' AS "Preferred Name"
       , '' AS "FirstName"
       , '' AS "MiddleName"
       , '' AS "LastName"
       , '' AS "Suffix"
       , '' AS "Gender"
       , CASE A.FullName
                   WHEN 'OSU/OKC' THEN 'Oklahoma State University - Oklahoma City'
                   WHEN 'OSU/IT' THEN 'Oklahoma State University - Institute of Technology'
                   WHEN 'OSU/CHS' THEN 'Oklahoma State University - Center for Health Sciences'
                   ELSE 'Oklahoma State University'
              END AS "OrganizationName"
       , '' AS "PrimaryBusinessAddressType"
       , '' AS "AddressLine1"
	   , ''
       , ''
       , ''
       , ''
       , ''
       , ''
       , ''
       , ''
       , ''
       , ''
       , ''
       , 'Separated' AS "EmployeeStatus"
       , ''
       , ''
       , ''
       , Cast(GetDate() AS Date) AS "Separated"
       , '' AS "Organization Role"
       , 'Former' AS "AffiliationStatus"
	   , Null AS "FileDate"
	   
       FROM  "OSUF_INTERFACES"."FACULTY_STAFF"."tmpHistData" H LEFT OUTER JOIN "OSUF_INTERFACES"."FACULTY_STAFF"."tmpNewData" N ON H.CWID=N.CWID
                                                               INNER JOIN ( //Currently coded as OSU employee in database
                                                                            SELECT Distinct
                                                                              CA.Alias AS "CWID"
																			 ,E.FullName
                                                                            FROM "OSUADV_PROD"."RE"."CONSTITUENT" C INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT_DTL_CONSTITUENTCODES" CC ON C.ConstituentSystemID=CC.ConstituentSystemID
                                                                                                                    INNER JOIN "OSUADV_PROD"."RE"."REL_CONSTITUENT" CR ON C.ConstituentSystemID=CR.ConstituentSystemID
                                                                                                                    INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" E ON CR.RelatedConstituentSystemID=E.ConstituentSystemID
                                                                                                                    INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT_DTL_ALIAS" CA ON C.ConstituentSystemID=CA.ConstituentSystemID
                                                                            WHERE CC.ConstituentCode='Faculty/Staff'
                                                                              AND CA.Type='CWID'
                                                                              AND CR.Relationship='Employer'
                                                                              AND CR.Reciprocal='Employee'
                                                                              AND E.FullName In( 'Oklahoma State University'
                                                                                                //,'OSU Alumni Association'
                                                                                                //,'OSU Foundation'
                                                                                                ,'OSU/A&S'
                                                                                                ,'OSU/CASNR'
                                                                                                ,'OSU/CEAT'
                                                                                                ,'OSU/COE'
                                                                                                ,'OSU/COHS'
                                                                                                ,'OSU/SSB'
                                                                                                ,'OSU/CVHS'
                                                                                                ,'OSU/Athletics'
                                                                                                ,'OSU/Graduate College'
                                                                                                ,'OSU/Honors College'
                                                                                                ,'OSU/Library'
                                                                                                ,'OSU/CHS'
                                                                                                ,'OSU/IT'
                                                                                                ,'OSU/OKC'
                                                                                                ,'OSU/Tulsa'
                                                                                             )
       		                                                           ) A ON H.CWID=A.CWID
       WHERE N.CWID Is NULL
	   
*/
     );
               
/*
Insert Into "OSUF_INTERFACES"."FACULTY_STAFF"."02_HistData"
Select
  *
, Cast(GetDate() AS Date) AS "UpdateDate"
From "OSUF_INTERFACES"."FACULTY_STAFF"."01_NewData";
*/

               
DROP TABLE "OSUF_INTERFACES"."FACULTY_STAFF"."tmpNewData";
DROP TABLE "OSUF_INTERFACES"."FACULTY_STAFF"."tmpHistData";
