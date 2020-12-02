USE OSUADV_PROD.BI;

CREATE OR REPLACE STAGE CSV_Stage1
  FILE_FORMAT = CSV_DBLQT

;

COPY INTO @CSV_Stage1/Gifts_
	FROM 
		(
			SELECT 
				PROSPECTID 					                    AS "prospectID"			
				,GIFTDATE					                    AS "giftdate"					
				,CAST(GIFTAMOUNT AS varchar(50))				AS "giftamount"				
				,DESIGNATION				                    AS "designation"	
				,PAIDWITHCREDITCARDYN		                    AS "paidwithcreditcardYN"		
				,SOURCE						                    AS "source"				
			FROM	
				"DNRCNCT_Gifts"
			WHERE
				GIFTAMOUNT <> 0	
		)
	FILE_FORMAT = (format_name = CSV_DBLQT COMPRESSION = None)
	HEADER = TRUE
	SINGLE = FALSE
	MAX_FILE_SIZE = 8000000
  ;  
  
GET @CSV_Stage1 file://E:\BI\Scheduled_ETL_SF\CallCenter_CreateImportFiles\Files;  






