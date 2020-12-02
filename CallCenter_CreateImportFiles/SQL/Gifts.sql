USE OSUADV_PROD.BI;

CREATE OR REPLACE TABLE "DNRCNCT_Gifts"
    (
         prospectID             VARCHAR(20)
        ,giftdate               DATE
        ,giftamount             NUMBER(20,2)
        ,designation            VARCHAR(1000)
        ,paidwithcreditcardYN   VARCHAR(5)
        ,source                 VARCHAR(50)
    );

INSERT INTO "DNRCNCT_Gifts"

SELECT DISTINCT
  C.CONSTITUENTID 	AS prospectID
, GIFTDATE			AS giftdate
, CASE 
    WHEN gi.InstallmentStatus = 'Write-off' AND CPR.CGPRAMOUNT = 0 THEN gi.InstallmentAmount 
    ELSE CPR.CGPRAMOUNT 
  END AS giftamount
--,CGPRAMOUNT        
, CASE 
    WHEN gi.InstallmentStatus = 'Write-off' AND CPR.CGPRAMOUNT = 0 AND  FC.FUNDID IS NULL THEN CONCAT('Pledge-Write-Off- ','DO NOT SOLICIT- ',CPR.FUNDDESCRIPTION)       
    WHEN gi.InstallmentStatus = 'Write-off' AND CPR.CGPRAMOUNT = 0 THEN CONCAT('Pledge-Write-Off- ',CPR.FUNDDESCRIPTION)
    WHEN FC.FUNDID IS NULL THEN CONCAT('DO NOT SOLICIT- ',CPR.FUNDDESCRIPTION)         
    ELSE CONCAT(FC.FUNDDESCRIPTION, '(',FC.FUNDID,')') 
  END AS designation
--,CONCAT(FC.FUNDDESCRIPTION, '(',FC.FUNDID,')')
, CASE WHEN CPR.ISNETCOMMUNITYGIFT = 'Yes' THEN 'Y' ELSE 'N' END paidwithcreditcardYN
, '' source
 

FROM 
    "OSUADV_PROD"."BI"."OSUF_COMPREHENSIVE_PRODUCTION_AND_RECEIPTS" CPR
																		INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" C ON C.CONSTITUENTSYSTEMID = CPR.CONSTITUENTSYSTEMID
																		INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_Household" h ON h.PRIMARYPROSPECTID = C.CONSTITUENTID
																		LEFT OUTER JOIN 
																						(
																							SELECT
																								  F.FUNDID
																								, F.FUNDDESCRIPTION
																								, FA.ATTRIBUTEDESCRIPTION COLLEGE

																							FROM 
																								"OSUADV_PROD"."RE"."FUND" F
																																INNER JOIN "OSUADV_PROD"."RE"."OSUF_ISAG_SOLICITABLEFUND" SF ON SF.FUNDSYSTEMID = F.FUNDSYSTEMID AND SF.ISAG_SOLICITABLEFUND = 'Yes'
																																LEFT OUTER JOIN "OSUADV_PROD"."RE"."FUND_DTL_ATTRIBUTES" FA ON FA.FUNDSYSTEMID = F.FUNDSYSTEMID AND FA.ATTRIBUTECATEGORY = 'College'
																						) FC ON FC.FUNDID = CPR.FUNDID
																					
																		 LEFT OUTER JOIN "OSUADV_PROD"."RE"."GIFT_DTL_INSTALLMENTS" gi ON CPR.GiftSystemID = gi.GiftSystemID
     
 WHERE
    CPR.DATASOURCE = 'Development'
AND CPR.MEASURE = 'Production'
