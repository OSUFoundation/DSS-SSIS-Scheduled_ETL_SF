                
/*Code for analysis to see who is not segmenting (NULL) for Kathy's review; can only run in Snowflake if added to bottom of the Segmentation code*/
SELECT
  IL.CONSTITUENTSYSTEMID
, S.SegmentName
, C.ConstituentID
, PCC.ConstituentCode
, C.FullName
, CASE WHEN AGGift.CONSTITUENTSYSTEMID IS NOT NULL THEN True ELSE False END         AS HasAnnualGift

, COALESCE(OSULG.Value, 0)                                                          AS LifetimeGivingtoOSU

, CASE WHEN LastAGGiftFY.FiscalYear IS NOT NULL THEN LastAGGiftFY.FiscalYear ELSE NULL END AS LastAGGiftFiscalYr

, CASE WHEN AGDonorTypeCurrentFY.DPAGDonorTypeBucket IS NOT NULL THEN AGDonorTypeCurrentFY.DPAGDonorTypeBucket ELSE NULL END AS FY21AGDonorType
, CASE WHEN AGDonorTypePreviousFY.DPAGDonorTypeBucket IS NOT NULL THEN AGDonorTypePreviousFY.DPAGDonorTypeBucket ELSE NULL END AS FY20AGDonorType
, CASE WHEN GCS.College IS NOT NULL THEN GCS.College ELSE NULL END AS HighestGivingCollege

, CASE WHEN Edu.SchoolType IS NOT NULL THEN Edu.SchoolType ELSE NULL END AS PrimaryEducationCollege
, CASE WHEN Edu.Degree IS NOT NULL THEN Edu.Degree ELSE NULL END AS PrimaryEducationDegree
, CASE WHEN Edu.GRADYEAR IS NOT NULL THEN Edu.GRADYEAR ELSE NULL END AS PrimaryEducationGRADYEAR

FROM
  "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL	
										
										INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" C ON IL.CONSTITUENTSYSTEMID = C.CONSTITUENTSYSTEMID
										INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_Household" AS P ON C.CONSTITUENTID = P.PRIMARYPROSPECTID
                                        INNER JOIN "OSUADV_PROD"."RE"."OSUF_PRIMARYCONSTITUENTCODE" PCC ON C.CONSTITUENTSYSTEMID = PCC.CONSTITUENTSYSTEMID
                                        
										LEFT OUTER JOIN "OSUADV_PROD"."BI"."DNRCNCT_Segments" AS S ON C.CONSTITUENTID = S.PROSPECTID
                                        
										LEFT OUTER JOIN 
													(
														SELECT DISTINCT
															CONSTITUENTSYSTEMID

														FROM
															"OSUADV_PROD"."BI"."DNRCNCT_PRODUCTIONGIFTS"

														WHERE (ISAGGIFT = 'Yes' OR ISPHILANTHROPIC = 'Yes')--included because AGDT Bucket includes consideration for AGGift or Philanthropic gift
															
													) AGGift ON IL.CONSTITUENTSYSTEMID = AGGift.CONSTITUENTSYSTEMID                                        
										
										--Lifetime Comprehensive giving to OSU
										LEFT OUTER JOIN
													(
														SELECT DISTINCT CONSTITUENTSYSTEMID, VALUE
														FROM "OSUADV_PROD"."RE"."CONSTITUENT_DTL_FINANCIALINFORMATION"
														WHERE INFORMATIONSOURCE = 'OSU Foundation'      					
													)   AS OSULG ON C.CONSTITUENTSYSTEMID = OSULG.CONSTITUENTSYSTEMID	
										
										LEFT OUTER JOIN 
                                            (
                                              SELECT 
                                                CONSTITUENTSYSTEMID, DPAGDONORTYPEBUCKET
                                              
                                              FROM
                                                "OSUADV_PROD"."BI"."OSUF_DONORTYPEBUCKET" 
                                              
                                              WHERE FISCALYEAR = 2021
                                              
                                              ) AGDonorTypeCurrentFY ON IL.CONSTITUENTSYSTEMID = AGDonorTypeCurrentFY.CONSTITUENTSYSTEMID
										LEFT OUTER JOIN 
                                            (
                                            select CONSTITUENTSYSTEMID, DPAGDONORTYPEBUCKET
                                            FROM "OSUADV_PROD"."BI"."OSUF_DONORTYPEBUCKET" 
                                              
                                              WHERE FISCALYEAR = 2020
                                              
                                              ) AGDonorTypePreviousFY ON IL.CONSTITUENTSYSTEMID = AGDonorTypePreviousFY.CONSTITUENTSYSTEMID


										LEFT OUTER JOIN tmp_GivingCollegeScore GCS ON C.CONSTITUENTSYSTEMID = GCS.CONSTITUENTSYSTEMID

										LEFT OUTER JOIN 
                                                    (
                                                      SELECT DISTINCT
                                                        CONSTITUENTSYSTEMID, SchoolType, Degree, GRADYEAR
                                                      
                                                      FROM
                                                        "OSUADV_PROD"."BI"."DNRCNCT_EDUCATION"
                                                      
                                                      WHERE ISPRIMARY = 'Yes'
                                                      
                                                     ) Edu ON C.CONSTITUENTSYSTEMID = Edu.CONSTITUENTSYSTEMID 

										LEFT OUTER JOIN tmp_LastAGGiftFY LastAGGiftFY ON C.CONSTITUENTSYSTEMID = LastAGGiftFY.CONSTITUENTSYSTEMID

WHERE 
    S.SegmentName IS NULL;
              
