/*Code for analysis to see who is not segmenting (NULL) for Kathy's review*/
SELECT
  IL.CONSTITUENTSYSTEMID
, S.SegmentName
, C.ConstituentID
, PCC.ConstituentCode
, C.FullName
, COALESCE(OSULG.Value, 0)                                                          AS LifetimeGivingtoOSU
, CASE WHEN AGGift.CONSTITUENTSYSTEMID IS NOT NULL THEN True ELSE False END         AS HasAnnualGift
, CASE WHEN LastAGGiftFY.FiscalYear IS NOT NULL THEN LastAGGiftFY.FiscalYear ELSE NULL END AS LastAGGiftFiscalYr
, CASE WHEN LastAGGiftFY.FiscalYear IS NOT NULL THEN LastAGGiftFY.FiscalYear ELSE NULL END AS LastAGGiftFiscalYr
, CASE WHEN AGDonorTypeCurrentFY.DPAGDonorTypeBucket IS NOT NULL THEN AGDonorTypeCurrentFY.DPAGDonorTypeBucket ELSE NULL END AS FY21AGDonorType
, CASE WHEN AGDonorTypePreviousFY.DPAGDonorTypeBucket IS NOT NULL THEN AGDonorTypePreviousFY.DPAGDonorTypeBucket ELSE NULL END AS FY20AGDonorType
, CASE WHEN GCS.College IS NOT NULL THEN GCS.College ELSE NULL END AS HighestGivingCollege
, CASE WHEN Edu.SchoolType IS NOT NULL THEN Edu.SchoolType ELSE NULL END AS PrimaryEducationCollege
, CASE WHEN Edu.Degree IS NOT NULL THEN Edu.Degree ELSE NULL END AS PrimaryEducationDegree

FROM
  "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL	

										--INNER JOIN #PrimaryID AS P ON IL.CONSTITUENTSYSTEMID = P.CONSTITUENTSYSTEMID
										INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" C ON IL.CONSTITUENTSYSTEMID = C.CONSTITUENTSYSTEMID
										INNER JOIN "OSUADV_PROD"."RE"."OSUF_PRIMARYCONSTITUENTCODE" PCC ON C.CONSTITUENTSYSTEMID = PCC.CONSTITUENTSYSTEMID
                                        
										LEFT OUTER JOIN tmp_Segment AS S ON IL.CONSTITUENTSYSTEMID = S.CONSTITUENTSYSTEMID
										
										--Lifetime Comprehensive giving to OSU
										LEFT OUTER JOIN
													(
														SELECT DISTINCT CONSTITUENTSYSTEMID, VALUE
														FROM "OSUADV_PROD"."RE"."CONSTITUENT_DTL_FINANCIALINFORMATION"
														WHERE INFORMATIONSOURCE = 'OSU Foundation'      					
													)   AS OSULG ON C.CONSTITUENTSYSTEMID = OSULG.CONSTITUENTSYSTEMID	
										
										LEFT OUTER JOIN tmp_AGDonorTypeCurrentFY AGDonorTypeCurrentFY ON IL.CONSTITUENTSYSTEMID = AGDonorTypeCurrentFY.CONSTITUENTSYSTEMID
										LEFT OUTER JOIN tmp_AGDonorTypePreviousFY AGDonorTypePreviousFY ON IL.CONSTITUENTSYSTEMID = AGDonorTypePreviousFY.CONSTITUENTSYSTEMID
										LEFT OUTER JOIN 
													(
														SELECT DISTINCT
															CONSTITUENTSYSTEMID

														FROM
															tmp_ProductionGift

														WHERE (ISAGGIFT = 'Yes' OR ISPHILANTHROPIC = 'Yes')--included because AGDT Bucket includes consideration for AGGift or Philanthropic gift
															
													) AGGift ON IL.CONSTITUENTSYSTEMID = AGGift.CONSTITUENTSYSTEMID

										LEFT OUTER JOIN tmp_GivingCollegeScore GCS ON C.CONSTITUENTSYSTEMID = GCS.CONSTITUENTSYSTEMID

										LEFT OUTER JOIN 
                                                    (
                                                      SELECT DISTINCT
                                                        CONSTITUENTSYSTEMID, SchoolType, Degree
                                                      
                                                      FROM
                                                        tmp_Education 
                                                      
                                                      WHERE ISPRIMARY = 'Yes'
                                                      
                                                     ) Edu ON C.CONSTITUENTSYSTEMID = Edu.CONSTITUENTSYSTEMID 

										LEFT OUTER JOIN tmp_LastAGGiftFY LastAGGiftFY ON C.CONSTITUENTSYSTEMID = LastAGGiftFY.CONSTITUENTSYSTEMID

WHERE 
    S.SegmentName IS NULL;

