CREATE OR REPLACE TABLE "SI_Delta"
(
    "Organization ID" varchar(50),                
    "Organization Name" varchar(500),             
    "Organization Type" varchar(100),             
    "Organization Status" varchar(50),            
    "Position Name" varchar(500),                 
    "Position Template" varchar(50),              
    "Position Start Date" date,                   
    "Position End Date" date,                     
    "Username" varchar(50),                       
    "First Name" varchar(100),                    
	"Preferred First Name" varchar(100),
    "Middle Name Or Initial" varchar(100),        
    "Last Name" varchar(100),                     
    "Archived Username" varchar(100),             
    "Suffix" varchar(100),                        
    "Hometown" varchar(100),                      
    "Affiliation" varchar(100),                   
    "Campus Email" varchar(100),                  
    "Preferred Email" varchar(100),               
    "Card ID" varchar(100),                       
    "SIS ID" varchar(100),                        
    "Reflection" varchar(100),                    
    "Date Of Birth" date,                         
    "Sex" varchar(100),                           
    "Race" varchar(100),                          
    "Ethnicity" varchar(100),                     
    "Enrollment Status" varchar(500),             
    "Current Term Enrolled" varchar(500),         
    "Current Term GPA" varchar(500),              
    "Previous Term Enrolled" varchar(500),        
    "Previous Term GPA" varchar(500),             
    "Credit Hours Earned" varchar(500),           
    "Anticipated Date Of Graduation" varchar(500),
    "Career Level" varchar(500),                  
    "Class Standing" varchar(500),                
    "Primary School Of Enrollment" varchar(500),  
    "Degree Sought" varchar(500),                 
    "Major" varchar(500),                         
    "Minor" varchar(500),                         
    "Major Advisor" varchar(500),                 
    "Other Advisor" varchar(500)
);    

INSERT INTO "OSUF_INTERFACES"."STUDENT_INVOLVEMENTS"."SI_Delta"
SELECT
 N.*
FROM "OSUF_INTERFACES"."STUDENT_INVOLVEMENTS"."01_NewData" N LEFT JOIN (Select Distinct
                                                                          *
                                                                        From "OSUF_INTERFACES"."STUDENT_INVOLVEMENTS"."02_HistData"
                                                                        Where "UpdateDate" In(Select 
                                                                                                MAX("UpdateDate")
                                                                                              FROM "OSUF_INTERFACES"."STUDENT_INVOLVEMENTS"."02_HistData"
                                                                                             )
                                                                       ) H ON     COALESCE(N."Organization ID", '')=COALESCE(H."Organization ID", '')
                                                                              AND COALESCE(N."Organization Name", '')=COALESCE(H."Organization Name", '')
                                                                              AND COALESCE(N."Position Name", '')=COALESCE(H."Position Name", '')
                                                                              AND COALESCE(N."Position Start Date", '1/1/1901')=COALESCE(H."Position Start Date", '1/1/1901')
                                                                              AND COALESCE(N."SIS ID", '')=COALESCE(H."SIS ID", '')
WHERE H."Organization ID" IS NULL;


INSERT INTO "OSUF_INTERFACES"."STUDENT_INVOLVEMENTS"."02_HistData"
SELECT *, Cast(GetDate() AS Date) AS "UpdateDate"
FROM "OSUF_INTERFACES"."STUDENT_INVOLVEMENTS"."01_NewData";
