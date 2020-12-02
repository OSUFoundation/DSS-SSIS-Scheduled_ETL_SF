USE OSUADV_PROD.BI;

CREATE OR REPLACE FILE FORMAT CSV_QuoteRN
  type = csv
  field_delimiter = ','
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  RECORD_DELIMITER = '\r\n'
  ESCAPE = NONE
  ESCAPE_UNENCLOSED_FIELD = NONE
;

CREATE OR REPLACE STAGE CSV_Stage1
  FILE_FORMAT = CSV_QuoteRN;

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
	FILE_FORMAT = (format_name = CSV_QuoteRN COMPRESSION = None)
	OVERWRITE = TRUE
	HEADER = TRUE
	SINGLE = FALSE
	MAX_FILE_SIZE = 8000000
	
  ;  
  
GET @CSV_Stage1 file://E:\BI\Scheduled_ETL_SF\CallCenter_CreateImportFiles\Files;  






