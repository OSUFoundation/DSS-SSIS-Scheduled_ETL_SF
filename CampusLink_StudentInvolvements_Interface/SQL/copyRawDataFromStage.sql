CREATE OR REPLACE TABLE "01_NewData"
(
    "Organization ID" varchar(50),                
    "Organization Name" varchar(500),             
    "Organization Type" varchar(100),             
    "Organization Status" varchar(50),            
    "Position Name" varchar(500),                 
    "Position Template" varchar(50),              
    "Position Start Date" DATE,                   
    "Position End Date" DATE,                     
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
    "Date Of Birth" DATE,                         
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



COPY INTO "01_NewData" FROM '@STAGE/SnowflakeUploadFile_Involvements.csv.gz'
FORCE = TRUE
PURGE = TRUE
FILE_FORMAT = (FORMAT_NAME = 'CSV_DBLQT_SKIP3');


//Delete all files from STAGE
REMOVE '@STAGE';

