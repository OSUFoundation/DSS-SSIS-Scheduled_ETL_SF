USE OSUADV_PROD.BI;

SET CurrentFY = (SELECT FISCALYEAR FROM "STATIC_DATA"."STATIC"."DATE" WHERE ACTUALDATE = CAST(GETDATE() AS DATE));
--SELECT $CurrentFY

/*============================================================================================
--Description: Temp table to hold Education data from view, allows code to run quicker
============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_Education
						                        (
                                                      CONSTITUENTSYSTEMID	NUMBER(38,0)
                                                    , DEGREE	            VARCHAR(100)
                                                    , DEPARTMENT	        VARCHAR(255)
                                                    , MAJOR	                VARCHAR(255)
                                                    , SCHOOLTYPE	        VARCHAR(100)
                                                    , DEGREETYPE	        VARCHAR(18)
                                                    , DATEGRADUATED	        DATE
                                                    , ISPRIMARY	            VARCHAR(3)
                                                    , DEGREEINFORMATION	    VARCHAR(462)
                                                    , SEQ	                NUMBER(18,0)   
						                        );
                        
INSERT INTO tmp_Education
SELECT *
FROM "OSUADV_PROD"."BI"."DNRCNCT_EDUCATION"
;

/*============================================================================================
--Description: Temp table to hold ProductionGift data from view, allows code to run quicker
============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_ProductionGift
						                        (
													  CONSTITUENTSYSTEMID	NUMBER(38,0)
													, GIFTTYPE	            VARCHAR(100)
													, FUNDID	            VARCHAR(20)
													, AMOUNT	            NUMBER(18,2)
													, COLLEGE	            VARCHAR(255)
													, DEPARTMENT	        VARCHAR(255)
													, GIFTDATE	            DATE
													, FISCALYEAR	        NUMBER(38,0)
													, ISMATCHINGGIFT	    VARCHAR(3)
													, ISAGGIFT	            VARCHAR(3)
													, ISPHILANTHROPIC	    VARCHAR(3)   
						                        );
                        
INSERT INTO tmp_ProductionGift
SELECT *
FROM "OSUADV_PROD"."BI"."DNRCNCT_PRODUCTIONGIFTS"
;


/*============================================================================================
--Description: Temp table to hold ReceiptedGift data from view, allows code to run quicker
============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_ReceiptedGift
						                        (
													CONSTITUENTSYSTEMID	NUMBER(38,0)
													, GIFTTYPE	VARCHAR(100)
													, FUNDID	VARCHAR(20)
													, AMOUNT	NUMBER(18,2)
													, COLLEGE	VARCHAR(255)
													, DEPARTMENT	VARCHAR(255)
													, GIFTDATE	DATE
													, FISCALYEAR	NUMBER(38,0)
													, ISMATCHINGGIFT	VARCHAR(3)
													, ISAGGIFT	VARCHAR(3)
													, ISPHILANTHROPIC	VARCHAR(3) 
						                        );
                        
INSERT INTO tmp_ReceiptedGift
SELECT *
FROM "OSUADV_PROD"."BI"."DNRCNCT_RECEIPTEDGIFTS"
;


/*============================================================================================
--Description: Most recent Education Year
============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_EducationMaxYear
						(
						     CONSTITUENTSYSTEMID           INT          NOT NULL
						   , SCHOOLTYPE                    VARCHAR(100) NOT NULL 
                           , DATEGRADUATED                 DATE	   
						);
                        
INSERT INTO tmp_EducationMaxYear

SELECT
  CONSTITUENTSYSTEMID
, SCHOOLTYPE
, DATEGRADUATED

FROM

	(
		SELECT 
		  CONSTITUENTSYSTEMID
		, SCHOOLTYPE
		, DATEGRADUATED

		FROM
			(
				SELECT 
				  CONSTITUENTSYSTEMID
				, SCHOOLTYPE
				, DATEGRADUATED AS DATEGRADUATED
				, ROW_NUMBER() OVER( PARTITION BY CONSTITUENTSYSTEMID ORDER BY DATEGRADUATED DESC) AS Seq

				FROM 				  
				  tmp_Education

				WHERE
					DEGREETYPE IN ('UnderGrad', 'Grad')

			) AS Q

		WHERE 
			Seq = 1
	) Q
;



/*============================================================================================
--Description: Most recent Grad Education Year
============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_EducationMaxGradYear
						(
						     CONSTITUENTSYSTEMID           INT          NOT NULL
						   , SCHOOLTYPE                    VARCHAR(100) NOT NULL 
                           , DATEGRADUATED                 DATE	
						);
                        
INSERT INTO tmp_EducationMaxGradYear

SELECT
  CONSTITUENTSYSTEMID
, SCHOOLTYPE
, DATEGRADUATED

FROM

	(
		SELECT 
		  CONSTITUENTSYSTEMID
		, SCHOOLTYPE
		, DATEGRADUATED

		FROM
			(
				SELECT 
				  CONSTITUENTSYSTEMID
				, SCHOOLTYPE
				, DATEGRADUATED
				, ROW_NUMBER() OVER( PARTITION BY CONSTITUENTSYSTEMID ORDER BY DATEGRADUATED DESC) AS Seq

				FROM 
				  tmp_Education

				WHERE 
					DEGREETYPE = 'Grad'

			) AS Q

		WHERE 
			Seq = 1
	) Q
;



/*============================================================================================
--Description: Most recent Undergrad Education Year
============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_EducationMaxUnderGradYear
						(
						     CONSTITUENTSYSTEMID           INT          NOT NULL
						   , SCHOOLTYPE                    VARCHAR(100) NOT NULL 
                           , DATEGRADUATED                 DATE		   
						);
                        
INSERT INTO tmp_EducationMaxUnderGradYear

SELECT
  CONSTITUENTSYSTEMID
, SCHOOLTYPE
, DATEGRADUATED

FROM

	(
		SELECT 
		  CONSTITUENTSYSTEMID
		, SCHOOLTYPE
		, DATEGRADUATED

		FROM
			(
				SELECT 
				  CONSTITUENTSYSTEMID
				, SCHOOLTYPE
				, DATEGRADUATED
				, ROW_NUMBER() OVER( PARTITION BY CONSTITUENTSYSTEMID ORDER BY DATEGRADUATED DESC) AS Seq

				FROM 
				   tmp_Education

				WHERE 
					DEGREETYPE = 'UnderGrad'

			) AS Q

		WHERE 
			Seq = 1
	) Q
;



/*============================================================================================
--
--Description: The last fiscal year someone made an annual giving gift or philanthropic gift
--
============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_LastAGGiftFY
										(										  
										    CONSTITUENTSYSTEMID INT          NOT NULL
										  , FISCALYEAR          INT          NOT NULL
										  , SUMAmount	        NUMBER       NOT NULL
                                          , AVGAmount	        NUMBER       NOT NULL
										);

INSERT INTO tmp_LastAGGiftFY

SELECT 
  CONSTITUENTSYSTEMID
, FISCALYEAR
, SUMAmount
, AVGAmount

FROM
	(
		SELECT 
		  CONSTITUENTSYSTEMID
		, FISCALYEAR
		, SUMAmount
		, AVGAmount
		, ROW_NUMBER() OVER( PARTITION BY CONSTITUENTSYSTEMID ORDER BY FISCALYEAR DESC ) AS Seq

		FROM
			(
				SELECT 
				  CONSTITUENTSYSTEMID
				, FISCALYEAR
				, SUM(AMOUNT) AS SUMAmount
				, AVG(AMOUNT) AS AVGAmount

				FROM 
				  tmp_ProductionGift

				WHERE 
				    (ISAGGIFT = 'Yes' OR ISPHILANTHROPIC = 'Yes')--included because AGDT Bucket includes consideration for AGGift or Philanthropic gift
                AND ISMATCHINGGIFT = 'No'

				GROUP BY 
				  CONSTITUENTSYSTEMID
				, FISCALYEAR
			) AS QL1
	) AS QL2

WHERE
    Seq = 1
;


/*============================================================================================
--
--Description: College given to most by various types - Annual Giving Production, last 10 fiscal yrs
--                    
==============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_CollegeGiventoMost_AGProd10
												(
													  CONSTITUENTSYSTEMID INT          NOT NULL
													, COLLEGE			  VARCHAR(255) NOT NULL
													, theGiftDate         DATETIME     NOT NULL
													, theAmount           NUMBER       NOT NULL
													, theLoyalityCount    NUMBER       NOT NULL
													, SeqRecently         NUMBER       NOT NULL
													, SeqAmount			  NUMBER       NOT NULL
													, SeqLoyality		  NUMBER       NOT NULL
												);

INSERT INTO tmp_CollegeGiventoMost_AGProd10
SELECT
  QL1.CONSTITUENTSYSTEMID
, QL1.COLLEGE
, QL1.theGiftDate
, QL1.theAmount
, QL1.theLoyalityCount
, ROW_NUMBER() OVER (PARTITION BY QL1.CONSTITUENTSYSTEMID ORDER BY QL1.theGiftDate DESC     , QL1.COLLEGE) AS SeqRecently
, ROW_NUMBER() OVER (PARTITION BY QL1.CONSTITUENTSYSTEMID ORDER BY QL1.theAmount DESC       , QL1.COLLEGE) AS SeqAmount
, ROW_NUMBER() OVER (PARTITION BY QL1.CONSTITUENTSYSTEMID ORDER BY QL1.theLoyalityCount DESC, QL1.COLLEGE) AS SeqLoyality

FROM
	(
		SELECT
		  CONSTITUENTSYSTEMID
		, COLLEGE
		, MAX(GIFTDATE)              AS theGiftDate
		, SUM(AMOUNT)                AS theAmount
		, COUNT(DISTINCT FISCALYEAR) AS theLoyalityCount

		FROM
		  tmp_ProductionGift

		WHERE --criteria declared
		    ISMATCHINGGIFT = 'No'
		AND (ISAGGIFT = 'Yes' OR ISPHILANTHROPIC = 'Yes')--included because AGDT Bucket includes consideration for AGGift or Philanthropic gift
		AND FISCALYEAR >= $CurrentFY-9 --Past 10 fiscal years

		GROUP BY
		  CONSTITUENTSYSTEMID
		, COLLEGE
	) AS QL1

ORDER BY 
  QL1.CONSTITUENTSYSTEMID
, QL1.COLLEGE
;



/*============================================================================================
--
--Description: College given to most by various types - Overall Production, last 10 yrs
--                    
==============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_CollegeGiventoMost_Prod10
												(
													  CONSTITUENTSYSTEMID INT          NOT NULL
													, COLLEGE			  VARCHAR(255) NOT NULL
													, theGiftDate         DATETIME     NOT NULL
													, theAmount           NUMBER       NOT NULL
													, theLoyalityCount    NUMBER       NOT NULL
													, SeqRecently         NUMBER       NOT NULL
													, SeqAmount			  NUMBER       NOT NULL
													, SeqLoyality		  NUMBER       NOT NULL
												);
                                                
INSERT INTO tmp_CollegeGiventoMost_Prod10
SELECT
  QL1.CONSTITUENTSYSTEMID
, QL1.COLLEGE
, QL1.theGiftDate
, QL1.theAmount
, QL1.theLoyalityCount
, ROW_NUMBER() OVER (PARTITION BY QL1.CONSTITUENTSYSTEMID ORDER BY QL1.theGiftDate DESC     , QL1.COLLEGE) AS SeqRecently
, ROW_NUMBER() OVER (PARTITION BY QL1.CONSTITUENTSYSTEMID ORDER BY QL1.theAmount DESC       , QL1.COLLEGE) AS SeqAmount
, ROW_NUMBER() OVER (PARTITION BY QL1.CONSTITUENTSYSTEMID ORDER BY QL1.theLoyalityCount DESC, QL1.COLLEGE) AS SeqLoyality

FROM
	(
		SELECT
		  CONSTITUENTSYSTEMID
		, COLLEGE
		, MAX(GIFTDATE)              AS theGiftDate
		, SUM(AMOUNT)                AS theAmount
		, COUNT(DISTINCT FISCALYEAR) AS theLoyalityCount

		FROM
		  tmp_ProductionGift

		WHERE --criteria declared
		    ISMATCHINGGIFT = 'No'
		AND FISCALYEAR >= $CurrentFY-9 --Past 10 fiscal years

		GROUP BY
		  CONSTITUENTSYSTEMID
		, COLLEGE
	) AS QL1

ORDER BY 
  QL1.CONSTITUENTSYSTEMID
, QL1.COLLEGE
;



/*============================================================================================
--
--Description: College given to most by various types
--                    
==============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_CollegeGiventoMost_AGProdLifetime
											(
													  CONSTITUENTSYSTEMID INT          NOT NULL
													, COLLEGE			  VARCHAR(255) NOT NULL
													, theGiftDate         DATETIME     NOT NULL
													, theAmount           NUMBER       NOT NULL
													, theLoyalityCount    NUMBER       NOT NULL
													, SeqRecently         NUMBER       NOT NULL
													, SeqAmount			  NUMBER       NOT NULL
													, SeqLoyality		  NUMBER       NOT NULL
												);

INSERT INTO tmp_CollegeGiventoMost_AGProdLifetime
SELECT
  QL1.CONSTITUENTSYSTEMID
, QL1.COLLEGE
, QL1.theGiftDate
, QL1.theAmount
, QL1.theLoyalityCount
, ROW_NUMBER() OVER (PARTITION BY QL1.CONSTITUENTSYSTEMID ORDER BY QL1.theGiftDate DESC     , QL1.COLLEGE) AS SeqRecently
, ROW_NUMBER() OVER (PARTITION BY QL1.CONSTITUENTSYSTEMID ORDER BY QL1.theAmount DESC       , QL1.COLLEGE) AS SeqAmount
, ROW_NUMBER() OVER (PARTITION BY QL1.CONSTITUENTSYSTEMID ORDER BY QL1.theLoyalityCount DESC, QL1.COLLEGE) AS SeqLoyality

FROM
	(
		SELECT
		  CONSTITUENTSYSTEMID
		, COLLEGE
		, MAX(GIFTDATE)              AS theGiftDate
		, SUM(AMOUNT)                AS theAmount
		, COUNT(DISTINCT FISCALYEAR) AS theLoyalityCount

		FROM
		  tmp_ProductionGift

		WHERE
		    ISMATCHINGGIFT = 'No'
			AND (ISAGGIFT = 'Yes' OR ISPHILANTHROPIC = 'Yes')--included because AGDT Bucket includes consideration for AGGift or Philanthropic gift

		GROUP BY
		  CONSTITUENTSYSTEMID
		, COLLEGE
	) AS QL1

ORDER BY 
  QL1.CONSTITUENTSYSTEMID
, QL1.COLLEGE
;


/*============================================================================================
--
--Description: College given to most by various types
--                    
==============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_CollegeGiventoMost_ProdLifetime
											(
													  CONSTITUENTSYSTEMID INT          NOT NULL
													, COLLEGE			  VARCHAR(255) NOT NULL
													, theGiftDate         DATETIME     NOT NULL
													, theAmount           NUMBER       NOT NULL
													, theLoyalityCount    NUMBER       NOT NULL
													, SeqRecently         NUMBER       NOT NULL
													, SeqAmount			  NUMBER       NOT NULL
													, SeqLoyality		  NUMBER       NOT NULL
												);

INSERT INTO tmp_CollegeGiventoMost_ProdLifetime
SELECT
  QL1.CONSTITUENTSYSTEMID
, QL1.College
, QL1.theGiftDate
, QL1.theAmount
, QL1.theLoyalityCount
, ROW_NUMBER() OVER (PARTITION BY QL1.CONSTITUENTSYSTEMID ORDER BY QL1.theGiftDate DESC     , QL1.College) AS SeqRecently
, ROW_NUMBER() OVER (PARTITION BY QL1.CONSTITUENTSYSTEMID ORDER BY QL1.theAmount DESC       , QL1.College) AS SeqAmount
, ROW_NUMBER() OVER (PARTITION BY QL1.CONSTITUENTSYSTEMID ORDER BY QL1.theLoyalityCount DESC, QL1.College) AS SeqLoyality

FROM
	(
		SELECT
		  CONSTITUENTSYSTEMID
		, COLLEGE
		, MAX(GIFTDATE)              AS theGiftDate
		, SUM(AMOUNT)                AS theAmount
		, COUNT(DISTINCT FISCALYEAR) AS theLoyalityCount

		FROM
		  tmp_ProductionGift

		WHERE
		    ISMATCHINGGIFT = 'No'

		GROUP BY
		  CONSTITUENTSYSTEMID
		, COLLEGE
	) AS QL1

ORDER BY 
  QL1.CONSTITUENTSYSTEMID
, QL1.COLLEGE
;



/*============================================================================================
--
--Description: College Points Education
--                    
==============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_CollegePoints_Education
												(
													  CONSTITUENTSYSTEMID   INT          NOT NULL
													, GivingCollegeTrans VARCHAR(255) NOT NULL
													, CollegePoints	     INT          NOT NULL
												);

INSERT INTO tmp_CollegePoints_Education
SELECT 
  CONSTITUENTSYSTEMID
, GivingCollegeTrans
, CASE 
		WHEN GivingCollegeTrans = 'OSU-CHS'                      THEN 30
		WHEN GivingCollegeTrans = 'CEAT'                         THEN 29
		WHEN GivingCollegeTrans = 'SSB'							 THEN 28
		WHEN GivingCollegeTrans = 'DASNR'						 THEN 27
		WHEN GivingCollegeTrans = 'CAS'							 THEN 26
		WHEN GivingCollegeTrans IN ('CVHS', 'CVM')				 THEN 25
		WHEN GivingCollegeTrans IN ('COHS', 'EHA', 'EHS','CEHS') THEN 24
		WHEN GivingCollegeTrans = 'GEN UNIV - Academic Affairs'	 THEN 22
		WHEN GivingCollegeTrans = 'Student Affairs'				 THEN 21
		WHEN GivingCollegeTrans = 'OSUIT'						 THEN 20
		WHEN GivingCollegeTrans = 'OSU-OKC'						 THEN 19
		WHEN GivingCollegeTrans = 'OSU-Tulsa'					 THEN 18
		WHEN GivingCollegeTrans = 'GEN UNIV - Alumni Association' THEN 17
		WHEN GivingCollegeTrans = 'Athletics'					 THEN 16
		WHEN GivingCollegeTrans = 'General University'	     	 THEN 15 --not on FY21 document? EH
		ELSE -100
  END AS CollegePoints

FROM
	(
		SELECT DISTINCT
		  CONSTITUENTSYSTEMID
		, SCHOOLTYPE AS GivingCollegeTrans

		FROM
		  tmp_Education

		WHERE 
		    IsPrimary = 'Yes'
	) AS Z
;


/*============================================================================================
--
--Description: College Points Recent
--                    
==============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_CollegePoints_AGProd10
											(
												  CONSTITUENTSYSTEMID INT       NOT NULL
												, COLLEGE		   VARCHAR(255) NOT NULL
												, TotalPoints	   INT          NOT NULL
												, NumberOfColleges INT          NOT NULL
											);

INSERT INTO tmp_CollegePoints_AGProd10
SELECT 
  Z.CONSTITUENTSYSTEMID
, Z.COLLEGE
, Z.TotalPoints
, COUNT(1) OVER (PARTITION BY Z.CONSTITUENTSYSTEMID) AS NumberOfColleges

FROM 
	(
		SELECT
		  QL3.CONSTITUENTSYSTEMID	
		, QL3.COLLEGE
		, QL3.TotalPoints
		, RANK() OVER (PARTITION BY QL3.CONSTITUENTSYSTEMID ORDER BY QL3.TotalPoints DESC) AS Seq

		FROM
			(
				SELECT
				  QL2.CONSTITUENTSYSTEMID
				, QL2.COLLEGE
				, QL2.TotalPoints

				FROM
					(
						SELECT
						  QL1.CONSTITUENTSYSTEMID
						, QL1.COLLEGE
						, SUM(QL1.Points) AS TotalPoints

						FROM
							(					
								--Begin: Dollars Given
								SELECT
								  CONSTITUENTSYSTEMID
								, COLLEGE
								, 31-SeqAmount AS Points

								FROM 
								  tmp_CollegeGiventoMost_AGProd10

								WHERE
									SeqAmount <= 31
								--End: Most Dollars Given


								--Begin: Recently
								UNION ALL
								SELECT
								  CONSTITUENTSYSTEMID
								, COLLEGE
								, 31-SeqRecently AS Points

								FROM 
								  tmp_CollegeGiventoMost_AGProd10

								WHERE
									SeqRecently <= 31
								--End: Most Recently


								--Begin: Loyality
								UNION ALL
								SELECT
								  CONSTITUENTSYSTEMID
								, COLLEGE
								, 31-SeqLoyality AS Points

								FROM 
								  tmp_CollegeGiventoMost_AGProd10

								WHERE
									SeqLoyality <= 31
								--End: Most Loyality


								--Begin: Dummy College Data
								UNION ALL
								SELECT DISTINCT
								  A.CONSTITUENTSYSTEMID
								, A.COLLEGE
								, 0 AS Points

								FROM 
								 tmp_ProductionGift AS A
								--End: Dummy College Data


								--Begin: Dummy Education Data																
								UNION ALL
								SELECT DISTINCT
								  A.CONSTITUENTSYSTEMID
								, A.GivingCollegeTrans AS College
								, 0 AS Points

								FROM 
								  tmp_CollegePoints_Education AS A
								--End: Dummy Education Data

							) AS QL1

						GROUP BY
						  QL1.CONSTITUENTSYSTEMID
						, QL1.COLLEGE
				) AS QL2
			) AS QL3 
	) AS Z

WHERE 
    Seq = 1

ORDER BY 
  Z.CONSTITUENTSYSTEMID
, Z.TotalPoints
, Z.COLLEGE
;

/*============================================================================================
--
--Description: College Points Recent
--                    
==============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_CollegePoints_Prod10
											(
												  CONSTITUENTSYSTEMID INT       NOT NULL
												, COLLEGE		   VARCHAR(255) NOT NULL
												, TotalPoints	   INT          NOT NULL
											);

INSERT INTO tmp_CollegePoints_Prod10

SELECT
  QL3.CONSTITUENTSYSTEMID	
, QL3.COLLEGE
, QL3.TotalPoints

FROM
	(
		SELECT
		  QL2.CONSTITUENTSYSTEMID
		, QL2.COLLEGE
		, QL2.TotalPoints

		FROM
			(
				SELECT
				  QL1.CONSTITUENTSYSTEMID
				, QL1.COLLEGE
				, SUM(QL1.Points) AS TotalPoints

				FROM
					(					
						--Begin: Dollars Given
						SELECT
						  CONSTITUENTSYSTEMID
						, COLLEGE
						, 31-SeqAmount AS Points

						FROM 
						  tmp_CollegeGiventoMost_Prod10

						WHERE
							SeqAmount <= 31
						--End: Most Dollars Given


						--Begin: Recently
						UNION ALL
						SELECT
						  CONSTITUENTSYSTEMID
						, COLLEGE
						, 31-SeqRecently AS Points

						FROM 
						  tmp_CollegeGiventoMost_Prod10

						WHERE
							SeqRecently <= 31
						--End: Most Recently


						--Begin: Loyality
						UNION ALL
						SELECT
						  CONSTITUENTSYSTEMID
						, COLLEGE
						, 31-SeqLoyality AS Points

						FROM 
						  tmp_CollegeGiventoMost_Prod10

						WHERE
							SeqLoyality <= 31
						--End: Most Loyality


						--Begin: Dummy College Data
						UNION ALL
						SELECT DISTINCT
						  A.CONSTITUENTSYSTEMID
						, A.COLLEGE
						, 0 AS Points

						FROM 
							tmp_ProductionGift AS A
						--End: Dummy College Data


						--Begin: Dummy Education Data																
						UNION ALL
						SELECT DISTINCT
						  A.CONSTITUENTSYSTEMID
						, A.GivingCollegeTrans AS College
						, 0 AS Points

						FROM 
							tmp_CollegePoints_Education AS A
						--End: Dummy Education Data
					) AS QL1

				GROUP BY
				  QL1.CONSTITUENTSYSTEMID
				, QL1.COLLEGE
		) AS QL2
	) AS QL3 

ORDER BY 
  QL3.CONSTITUENTSYSTEMID
, QL3.TotalPoints
, QL3.COLLEGE
;


/*============================================================================================
--
--Description: College Points Lifetime
--                    
==============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_CollegePoints_AGProdLifetime
												(
													  CONSTITUENTSYSTEMID INT          NOT NULL
													, COLLEGE		   VARCHAR(255) NOT NULL
													, TotalPoints	   INT          NOT NULL
												);

INSERT INTO tmp_CollegePoints_AGProdLifetime
SELECT
  QL3.CONSTITUENTSYSTEMID	
, QL3.COLLEGE
, QL3.TotalPoints

FROM
	(
		SELECT
		  QL2.CONSTITUENTSYSTEMID
		, QL2.COLLEGE
		, QL2.TotalPoints

		FROM
			(
				SELECT
				  QL1.CONSTITUENTSYSTEMID
				, QL1.COLLEGE
				, SUM(QL1.Points) AS TotalPoints

				FROM
					(					
						--Begin: Dollars Given
						SELECT
						  CONSTITUENTSYSTEMID
						, COLLEGE
						, 31-SeqAmount AS Points

						FROM 
						  tmp_CollegeGiventoMost_AGProdLifetime

						WHERE
							SeqAmount <= 31
						--End: Dollars Given


						--Begin: Recently
						UNION ALL
						SELECT
						  CONSTITUENTSYSTEMID
						, COLLEGE
						, 31-SeqRecently AS Points

						FROM 
						  tmp_CollegeGiventoMost_AGProdLifetime

						WHERE
							SeqRecently <= 31
						--End: Recently


						--Begin: Loyality
						UNION ALL
						SELECT
						  CONSTITUENTSYSTEMID
						, COLLEGE
						, 31-SeqLoyality AS Points

						FROM 
						  tmp_CollegeGiventoMost_AGProdLifetime

						WHERE
							SeqLoyality <= 31
						--End: Loyality


						--Begin: Dummy College Data
						UNION ALL
						SELECT DISTINCT
						  A.CONSTITUENTSYSTEMID
						, A.COLLEGE
						, 0 AS Points

						FROM 
							tmp_ProductionGift AS A
						--End: Dummy College Data


						--Begin: Dummy Education Data																
						UNION ALL
						SELECT DISTINCT
						  A.CONSTITUENTSYSTEMID
						, A.GivingCollegeTrans AS College
						, 0 AS Points

						FROM 
							tmp_CollegePoints_Education AS A
						--End: Dummy Education Data
					) AS QL1

				GROUP BY
				  QL1.CONSTITUENTSYSTEMID
				, QL1.COLLEGE
		) AS QL2
	) AS QL3 

ORDER BY 
  QL3.CONSTITUENTSYSTEMID
, QL3.TotalPoints
, QL3.COLLEGE
;



/*============================================================================================
--
--Description: College Points Lifetime
--                    
==============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_CollegePoints_ProdLifetime
												(
													  CONSTITUENTSYSTEMID INT          NOT NULL
													, COLLEGE		   VARCHAR(255) NOT NULL
													, TotalPoints	   INT          NOT NULL
												);

INSERT INTO tmp_CollegePoints_ProdLifetime
SELECT
  QL3.CONSTITUENTSYSTEMID	
, QL3.COLLEGE
, QL3.TotalPoints

FROM
	(
		SELECT
		  QL2.CONSTITUENTSYSTEMID
		, QL2.COLLEGE
		, QL2.TotalPoints

		FROM
			(
				SELECT
				  QL1.CONSTITUENTSYSTEMID
				, QL1.COLLEGE
				, SUM(QL1.Points) AS TotalPoints

				FROM
					(					
						--Begin: Dollars Given
						SELECT
						  CONSTITUENTSYSTEMID
						, COLLEGE
						, 31-SeqAmount AS Points

						FROM
						  tmp_CollegeGiventoMost_ProdLifetime

						WHERE
							SeqAmount <= 31
						--End: Dollars Given


						--Begin: Recently
						UNION ALL
						SELECT
						  CONSTITUENTSYSTEMID
						, COLLEGE
						, 31-SeqRecently AS Points

						FROM 
						  tmp_CollegeGiventoMost_ProdLifetime

						WHERE
							SeqRecently <= 31
						--End: Recently


						--Begin: Loyality
						UNION ALL
						SELECT
						  CONSTITUENTSYSTEMID
						, COLLEGE
						, 31-SeqLoyality AS Points

						FROM 
						  tmp_CollegeGiventoMost_ProdLifetime

						WHERE
							SeqLoyality <= 31
						--End: Loyality


						--Begin: Dummy College Data for people who have no reciepted giving.
						UNION ALL
						SELECT DISTINCT
						  A.CONSTITUENTSYSTEMID
						, A.COLLEGE
						, 1 AS Points

						FROM 
							tmp_ReceiptedGift AS A
						--End: Dummy College Data

						--Begin: Dummy College Data
						UNION ALL
						SELECT DISTINCT
						  A.CONSTITUENTSYSTEMID
						, A.COLLEGE
						, 0 AS Points

						FROM 
							tmp_ProductionGift AS A
						--End: Dummy College Data


						--Begin: Dummy Education Data																
						UNION ALL
						SELECT DISTINCT
						  A.CONSTITUENTSYSTEMID
						, A.GivingCollegeTrans AS College
						, 0 AS Points

						FROM 
							tmp_CollegePoints_Education AS A
						--End: Dummy Education Data
					) AS QL1

				GROUP BY
				  QL1.CONSTITUENTSYSTEMID
				, QL1.COLLEGE
		) AS QL2
	) AS QL3 


ORDER BY 
  QL3.CONSTITUENTSYSTEMID
, QL3.TotalPoints
, QL3.COLLEGE
;



/*============================================================================================
--
--Description: Store the first round of tie breaking into a #temp table
--                    
==============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_CollegePoints_tiebreaker0
												(
													  CONSTITUENTSYSTEMID INT          NOT NULL
													, COLLEGE		   VARCHAR(255) NOT NULL
													, TotalPoints	   INT          NOT NULL
													, NumberOfColleges INT          NOT NULL
												);

INSERT INTO tmp_CollegePoints_tiebreaker0
SELECT
  CONSTITUENTSYSTEMID	
, COLLEGE
, TotalPoints
, NumberOfColleges

FROM 
	tmp_CollegePoints_AGProd10

;


/*============================================================================================
--
--Description: Giving COLLEGE Score
--                    
==============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_GivingCollegeScore
										(
											  CONSTITUENTSYSTEMID INT       NOT NULL
											, COLLEGE		   VARCHAR(255) NOT NULL
										);

INSERT INTO tmp_GivingCollegeScore
--------------------------Initial Load of Records that do not need a tie breaker
SELECT 
  CONSTITUENTSYSTEMID
, COLLEGE

FROM
  tmp_CollegePoints_tiebreaker0

WHERE 
    NumberOfColleges = 1
AND TotalPoints > 0
;

--Remove records that do not need additional tie breaker code.
DELETE 

FROM
  tmp_CollegePoints_tiebreaker0

WHERE 
    CONSTITUENTSYSTEMID IN (SELECT CONSTITUENTSYSTEMID FROM tmp_GivingCollegeScore)

;




/*============================================================================================
--
--Description: Store the first round of tie breaking into a #temp table
--                    
==============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_CollegePoints_tiebreaker1
												(
													  CONSTITUENTSYSTEMID INT          NOT NULL
													, COLLEGE		   VARCHAR(255) NOT NULL
													, TotalPoints	   INT          NOT NULL
													, NumberOfColleges INT          NOT NULL
												);

INSERT INTO tmp_CollegePoints_tiebreaker1
SELECT 
  CONSTITUENTSYSTEMID
, COLLEGE
, TotalPoints
, COUNT(1) OVER (PARTITION BY Z.CONSTITUENTSYSTEMID) AS NumberOfColleges

FROM
	(
		SELECT 
		  AGProd10.CONSTITUENTSYSTEMID
		, AGProd10.COLLEGE
		, AGProd10.TotalPoints + Prod10.TotalPoints AS TotalPoints
		, RANK() OVER (PARTITION BY AGProd10.CONSTITUENTSYSTEMID ORDER BY AGProd10.TotalPoints + Prod10.TotalPoints DESC) AS Seq

		FROM
		  tmp_CollegePoints_tiebreaker0 AS AGProd10 
												LEFT OUTER JOIN tmp_CollegePoints_Prod10 AS Prod10 ON AGProd10.CONSTITUENTSYSTEMID = Prod10.CONSTITUENTSYSTEMID AND AGProd10.COLLEGE = Prod10.COLLEGE
	) AS Z

WHERE 
    Z.Seq = 1

ORDER BY 
  Z.CONSTITUENTSYSTEMID
, Z.COLLEGE
;





/*============================================================================================
--
--Description: Giving COLLEGE Score
--                    
==============================================================================================*/

INSERT INTO tmp_GivingCollegeScore
--------------------------2nd Load of Records that do not need a tie breaker
SELECT 
  CONSTITUENTSYSTEMID
, COLLEGE

FROM
  tmp_CollegePoints_tiebreaker1

WHERE 
    NumberOfColleges = 1
AND TotalPoints > 0
;
--Remove records that do not need additional tie breaker code.
DELETE 

FROM
  tmp_CollegePoints_tiebreaker1

WHERE 
    CONSTITUENTSYSTEMID IN (SELECT CONSTITUENTSYSTEMID FROM tmp_GivingCollegeScore)
;




/*============================================================================================
--
--Description: Store the 2nd round of tie breaking into a #temp table
--                    
==============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_CollegePoints_tiebreaker2
												(
													  CONSTITUENTSYSTEMID INT          NOT NULL
													, COLLEGE		   VARCHAR(255) NOT NULL
													, TotalPoints	   INT          NOT NULL
													, NumberOfColleges INT          NOT NULL
												);

INSERT INTO tmp_CollegePoints_tiebreaker2
SELECT 
  CONSTITUENTSYSTEMID
, COLLEGE
, TotalPoints
, COUNT(1) OVER (PARTITION BY Z.CONSTITUENTSYSTEMID) AS NumberOfColleges

FROM
	(
		SELECT 
		  T.CONSTITUENTSYSTEMID
		, T.COLLEGE
		, T.TotalPoints + AGProdLifetime.TotalPoints AS TotalPoints
		, RANK() OVER (PARTITION BY T.CONSTITUENTSYSTEMID ORDER BY T.TotalPoints + AGProdLifetime.TotalPoints DESC) AS Seq

		FROM
		  tmp_CollegePoints_tiebreaker1 AS T 
												LEFT OUTER JOIN tmp_CollegePoints_AGProdLifetime AS AGProdLifetime ON T.CONSTITUENTSYSTEMID = AGProdLifetime.CONSTITUENTSYSTEMID AND T.COLLEGE = AGProdLifetime.COLLEGE
	) AS Z

WHERE 
    Z.Seq = 1

ORDER BY 
  Z.CONSTITUENTSYSTEMID
, Z.COLLEGE
;



/*============================================================================================
--
--Description: Giving COLLEGE Score
--                    
==============================================================================================*/

INSERT INTO tmp_GivingCollegeScore
--------------------------2nd Load of Records that do not need a tie breaker
SELECT 
  CONSTITUENTSYSTEMID
, COLLEGE

FROM
  tmp_CollegePoints_tiebreaker2

WHERE 
    NumberOfColleges = 1
AND TotalPoints > 0
;
--Remove records that do not need additional tie breaker code.
DELETE 

FROM
  tmp_CollegePoints_tiebreaker2

WHERE 
    CONSTITUENTSYSTEMID IN (SELECT CONSTITUENTSYSTEMID FROM tmp_GivingCollegeScore)
;




/*============================================================================================
--
--Description: Store the 3rd round of tie breaking into a #temp table
--                    
==============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_CollegePoints_tiebreaker3
												(
													  CONSTITUENTSYSTEMID INT          NOT NULL
													, COLLEGE		   VARCHAR(255) NOT NULL
													, TotalPoints	   INT          NOT NULL
													, NumberOfColleges INT          NOT NULL
												);

INSERT INTO tmp_CollegePoints_tiebreaker3
SELECT 
  CONSTITUENTSYSTEMID
, COLLEGE
, TotalPoints
, COUNT(1) OVER (PARTITION BY Z.CONSTITUENTSYSTEMID) AS NumberOfColleges

FROM
	(
		SELECT 
		  T.CONSTITUENTSYSTEMID
		, T.COLLEGE
		, T.TotalPoints + ProdLifetime.TotalPoints AS TotalPoints
		, RANK() OVER (PARTITION BY T.CONSTITUENTSYSTEMID ORDER BY T.TotalPoints + ProdLifetime.TotalPoints DESC) AS Seq

		FROM
		  tmp_CollegePoints_tiebreaker2 AS T 
												LEFT OUTER JOIN tmp_CollegePoints_ProdLifetime AS ProdLifetime ON T.CONSTITUENTSYSTEMID = ProdLifetime.CONSTITUENTSYSTEMID AND T.COLLEGE = ProdLifetime.COLLEGE
	) AS Z

WHERE 
    Z.Seq = 1

ORDER BY 
  Z.CONSTITUENTSYSTEMID
, Z.COLLEGE
;


/*============================================================================================
--
--Description: Giving COLLEGE Score
--                    
==============================================================================================*/

INSERT INTO tmp_GivingCollegeScore
--------------------------3rd Load of Records that do not need a tie breaker
SELECT 
  CONSTITUENTSYSTEMID
, COLLEGE

FROM
  tmp_CollegePoints_tiebreaker3

WHERE 
    NumberOfColleges = 1
AND TotalPoints > 0
;
--Remove records that do not need additional tie breaker code.
DELETE 

FROM
  tmp_CollegePoints_tiebreaker3

WHERE 
    CONSTITUENTSYSTEMID IN (SELECT CONSTITUENTSYSTEMID FROM tmp_GivingCollegeScore)
;


/*============================================================================================
--
--Description: Store the 4th round of tie breaking into a #temp table
--                    
==============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_CollegePoints_tiebreaker4
												(
													  CONSTITUENTSYSTEMID INT          NOT NULL
													, COLLEGE		   VARCHAR(255) NOT NULL
													, TotalPoints	   INT          NOT NULL
													, NumberOfColleges INT          NOT NULL
												);

INSERT INTO tmp_CollegePoints_tiebreaker4
SELECT 
  CONSTITUENTSYSTEMID
, COLLEGE
, TotalPoints
, COUNT(1) OVER (PARTITION BY Z.CONSTITUENTSYSTEMID) AS NumberOfColleges

FROM
	(
		SELECT 
		  T.CONSTITUENTSYSTEMID
		, T.COLLEGE
		, T.TotalPoints + COALESCE(Edu.CollegePoints, 0) AS TotalPoints
		, RANK() OVER (PARTITION BY T.CONSTITUENTSYSTEMID ORDER BY T.TotalPoints + COALESCE(Edu.CollegePoints, 0) DESC) AS Seq

		FROM
		  tmp_CollegePoints_tiebreaker3 AS T 
												LEFT OUTER JOIN tmp_CollegePoints_Education AS Edu ON T.CONSTITUENTSYSTEMID = Edu.CONSTITUENTSYSTEMID AND T.COLLEGE = Edu.GivingCollegeTrans
	) AS Z

WHERE 
    Z.Seq = 1

ORDER BY 
  Z.CONSTITUENTSYSTEMID
, Z.COLLEGE
;



/*============================================================================================
--
--Description: Giving COLLEGE Score
--                    
==============================================================================================*/

INSERT INTO tmp_GivingCollegeScore
--------------------------4th Load of Records that do not need a tie breaker
SELECT 
  CONSTITUENTSYSTEMID
, COLLEGE

FROM
  tmp_CollegePoints_tiebreaker4

WHERE 
    NumberOfColleges = 1
AND TotalPoints > 0
;
--Remove records that do not need additional tie breaker code.
DELETE 

FROM
  tmp_CollegePoints_tiebreaker4

WHERE 
    CONSTITUENTSYSTEMID IN (SELECT CONSTITUENTSYSTEMID FROM tmp_GivingCollegeScore)
;



/*============================================================================================
--
--Description: Giving COLLEGE Score
--                    
==============================================================================================*/
INSERT INTO tmp_GivingCollegeScore
--------------------------5th Load of Records
SELECT 
  CONSTITUENTSYSTEMID
, COLLEGE

FROM
	(
		SELECT 
		  CONSTITUENTSYSTEMID
		, COLLEGE
		, TotalPoints
		, ROW_NUMBER() OVER( PARTITION BY CONSTITUENTSYSTEMID ORDER BY TotalPoints DESC, COLLEGE) AS Seq

		FROM
		  tmp_CollegePoints_tiebreaker4

		WHERE 
			TotalPoints > 0
	) AS Z

WHERE 
    Seq = 1
;




/*======================================================================================================================
--
--Description: DPAG AG DonorType (Current FY)
--                    
========================================================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_AGDonorTypeCurrentFY
							(
								  CONSTITUENTSYSTEMID    INT          NOT NULL
								, DPAGDONORTYPEBUCKET VARCHAR(100) NOT NULL 
							);

INSERT INTO tmp_AGDonorTypeCurrentFY
SELECT
  DT.CONSTITUENTSYSTEMID
, DT.DPAGDONORTYPEBUCKET

FROM 
	"OSUADV_PROD"."BI"."OSUF_DONORTYPEBUCKET" AS DT 

								--IncludeList
								INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL ON DT.CONSTITUENTSYSTEMID = IL.CONSTITUENTSYSTEMID
                                

WHERE 
    DT.FiscalYear = $CurrentFY
;

/*======================================================================================================================
--
--Description: DPAG AG DonorType (Previous FY)
--                    
========================================================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_AGDonorTypePreviousFY
							(
								  CONSTITUENTSYSTEMID    INT          NOT NULL
								, DPAGDonorTypeBucket VARCHAR(100) NOT NULL 
							);

INSERT INTO tmp_AGDonorTypePreviousFY
SELECT 
  DT.CONSTITUENTSYSTEMID
, DT.DPAGDonorTypeBucket

FROM 
	"OSUADV_PROD"."BI"."OSUF_DONORTYPEBUCKET" AS DT 
    
								--IncludeList
								INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL ON DT.CONSTITUENTSYSTEMID = IL.CONSTITUENTSYSTEMID

WHERE 
    DT.FiscalYear = $CurrentFY-1
;


/*============================================================================================
--
--Description: Call Center Action Status
--
============================================================================================*/
CREATE OR REPLACE TEMPORARY TABLE tmp_CallCenterActionStatus
											(
												  CONSTITUENTSYSTEMID INT       NOT NULL
												, ActionStatus     VARCHAR(255) NOT NULL
												, FISCALYEAR	   SMALLINT		NOT NULL
											);

INSERT INTO tmp_CallCenterActionStatus
SELECT 
  Q.CONSTITUENTSYSTEMID
, Q.ACTIONSTATUS
, Q.FISCALYEAR

FROM
	(
		SELECT
		  A.CONSTITUENTSYSTEMID
		, A.ACTIONSTATUS
		, D.FISCALYEAR AS FISCALYEAR

		FROM
		    "OSUADV_PROD"."RE"."ACTION" A INNER JOIN "STATIC_DATA"."STATIC"."DATE" D ON A.ACTIONDATEDIMID = D.DATEDIMID

		WHERE 
            A.ACTIONTYPE = 'Phonathon Connect Result'
            AND A.ACTIONSTATUS IS NOT NULL

	) AS Q
;


/*======================================================================================================================
--
--Description: Determine the segment that a constituent falls into
--                    
========================================================================================================================*/
CREATE OR REPLACE TABLE "DNRCNCT_Segments" 
						(
						     prospectID          VARCHAR(20)
						   , segmentName         VARCHAR(100)
						   , segmentCode		 VARCHAR(75)
						);
INSERT INTO "DNRCNCT_Segments" 
SELECT
  C.CONSTITUENTID  AS prospectID
, SegmentData.SegmentName	AS segmentName
, SegmentData.SegmentCode	AS segemntCode
, '2020 - Fall'

FROM
    "OSUADV_PROD"."RE"."CONSTITUENT" AS C
        INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_Household" AS PrimID ON C.CONSTITUENTID = PrimID.PRIMARYPROSPECTID					
							--Segmentation criteria
							INNER JOIN
										(
											SELECT
											  QL2.CONSTITUENTSYSTEMID
											, QL2.SegmentPriority
											, QL2.SegmentName

											FROM
												(
													SELECT
													  QL1.CONSTITUENTSYSTEMID
													, QL1.SegmentPriority
													, QL1.SegmentName
													, ROW_NUMBER() OVER (PARTITION BY QL1.CONSTITUENTSYSTEMID ORDER BY QL1.SegmentPriority ASC ) AS Seq

													FROM
														(
															--Household is Managed Prospect															
														  SELECT 
															  IL.CONSTITUENTSYSTEMID
															, 10 AS SegmentPriority
															, 'Managed' SegmentName	
													
														   FROM
															  "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL
																								INNER JOIN
																											(
																												SELECT 
																													C.CONSTITUENTSYSTEMID

																												FROM "OSUADV_PROD"."RE"."CONSTITUENT" C INNER JOIN 
                                                                                                                                                        (                                                                                                                                                        
                                                                                                                                                            SELECT 
                                                                                                                                                              C.CONSTITUENTID
                                                                                                                                                            , C.CONSTITUENTSYSTEMID
                                                                                                                                                            , RAS.SOLICITORTYPE
                                                                                                                                                            , CASE WHEN SC.CONSTITUENTID = '344954' THEN 'Lauren Kidd' ELSE SC.FULLNAME END AS MANAGERNAME
                                                                                                                                                            , SC.CONSTITUENTID MANAGERCONSTITUENTID
                                                                                                                                                            , CASE 
                                                                                                                                                            	    WHEN SC.FULLNAME = 'Leadership Gift Manager' THEN 1 
                                                                                                                                                            	    ELSE 2 
                                                                                                                                                              END AS RANK
                                                                                                                                                            
                                                                                                                                                            FROM "OSUADV_PROD"."RE"."REL_ASSIGNEDSOLICITORS" RAS
                                                                                                                                                                                                                INNER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" C ON C.CONSTITUENTSYSTEMID = RAS.CONSTITUENTSYSTEMID
                                                                                                                                                                                                                LEFT OUTER JOIN "OSUADV_PROD"."RE"."CONSTITUENT" SC ON SC.CONSTITUENTSYSTEMID = RAS.SOLICITORCONSTITUENTSYSTEMID
                                                                                                                                                            
                                                                                                                                                            WHERE SOLICITORTYPE IN ('Manager 1', 'Manager 2', 'Manager 3', 'Manager 4')
                                                                                                                                                        
                                                                                                                                                        ) AS MN ON C.CONSTITUENTSYSTEMID = MN.CONSTITUENTSYSTEMID
													  
																												WHERE 
																													C.ConstituentID IS NOT NULL
																												AND C.KeyIndicator = 'I'
																												AND MN.CONSTITUENTSYSTEMID IS NOT NULL

																											) Managed ON IL.CONSTITUENTSYSTEMID = Managed.CONSTITUENTSYSTEMID

															UNION ALL
															--Household is Cowboy Caller Managed
															SELECT 
															  IL.CONSTITUENTSYSTEMID
															, 20 AS SegmentPriority
															, 'Cowboy Caller Managed' SegmentName	

															FROM
																"OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL 
																							INNER JOIN
																										(
																											SELECT
																												CONSTITUENTSYSTEMID

																											FROM 
																												"OSUADV_PROD"."RE"."REL_ASSIGNEDSOLICITORS"

																											WHERE 
																												SOLICITORTYPE = 'Cowboy Caller Solicitor'
																												
																											) CowboyCaller ON IL.CONSTITUENTSYSTEMID = CowboyCaller.CONSTITUENTSYSTEMID
                                                           UNION ALL
														   --KOSU 1-3 Yr Lapsed
														   SELECT
															  IL.CONSTITUENTSYSTEMID
															, 30 AS SegmentPriority
															, 'KOSU 1-3 Yr Lapsed' SegmentName										

															FROM
															  "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL
                                                                                                INNER JOIN tmp_AGDonorTypeCurrentFY AS DT ON IL.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID
                                                          
                                                                                                LEFT OUTER JOIN tmp_GivingCollegeScore AS GCS ON IL.CONSTITUENTSYSTEMID = GCS.CONSTITUENTSYSTEMID
																						      
															                                    LEFT OUTER JOIN 
																													(
																														SELECT
																															CONSTITUENTSYSTEMID
																															
																														FROM
																															"OSUADV_PROD"."RE"."OSUF_PRIMARYCONSTITUENTCODE" 

																														WHERE
																															ConstituentCode = 'KOSU Donor'


																													) AS PCC ON IL.CONSTITUENTSYSTEMID = PCC.CONSTITUENTSYSTEMID                                                          
																						
															WHERE
																DT.DPAGDonorTypeBucket IN ('1 Year Lapsed','2 Year Lapsed','3 Year Lapsed')
                                                            AND (PCC.CONSTITUENTSYSTEMID IS NOT NULL OR GCS.College = 'GEN UNIV - KOSU')
															
														   UNION ALL	
														   --KOSU 4+ Yr Lapsed
														   SELECT
															  IL.CONSTITUENTSYSTEMID
															, 40 AS SegmentPriority
															, 'KOSU 4+ Yr Lapsed' SegmentName															

															FROM
															  "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL
                                                                                                INNER JOIN tmp_AGDonorTypeCurrentFY AS DT ON IL.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID
                                                                                            
                                                                                                LEFT OUTER JOIN tmp_GivingCollegeScore AS GCS ON IL.CONSTITUENTSYSTEMID = GCS.CONSTITUENTSYSTEMID
																						
															                                    LEFT OUTER JOIN 
																													(
																														SELECT
																															CONSTITUENTSYSTEMID
																															
																														FROM
																															"OSUADV_PROD"."RE"."OSUF_PRIMARYCONSTITUENTCODE" 

																														WHERE
																															ConstituentCode = 'KOSU Donor'


																													) AS PCC ON IL.CONSTITUENTSYSTEMID = PCC.CONSTITUENTSYSTEMID 
																						

															WHERE
                                                                DT.DPAGDonorTypeBucket IN ('4+ Year Lapsed', 'Non-Donor')
                                                            AND (PCC.CONSTITUENTSYSTEMID OR GCS.College = 'GEN UNIV - KOSU')														    																                                                          

														   UNION ALL
														   --LAG $500+
														   SELECT
														      IL.CONSTITUENTSYSTEMID
															, 50 AS SegmentPriority
															, 'LAG $500+' SegmentName

														   FROM
														      "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL 
																							 INNER JOIN tmp_AGDonorTypeCurrentFY DT ON IL.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID																						 
																							 INNER JOIN 
																									   (
																											SELECT 
																											  CONSTITUENTSYSTEMID

																											FROM
																											  tmp_ProductionGift

																											WHERE
																											   (ISAGGIFT = 'Yes' OR ISPHILANTHROPIC = 'Yes')--included because AGDT Bucket includes consideration for AGGift or Philanthropic gift
																											AND FISCALYEAR IN (2018, 2019, 2020)--last 3 fiscal years, not counting current

																											GROUP BY
																											  CONSTITUENTSYSTEMID
																											, FISCALYEAR

																											HAVING
																											   SUM(AMOUNT) >= 500
																									   ) AS AGift ON IL.CONSTITUENTSYSTEMID = AGift.CONSTITUENTSYSTEMID
														   WHERE
														      DT.DPAGDonorTypeBucket IN ('1 Year Lapsed','2 Year Lapsed','3 Year Lapsed')												  													  															

														   UNION ALL
														   --2+ No Pledge
														   SELECT
														      IL.CONSTITUENTSYSTEMID
															, 60 AS SegmentPriority
															, '2+ No Pledge' SegmentName

														   FROM
														      "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL 															                                 
																								INNER JOIN 
																										(
																											SELECT 
																											  Q.CONSTITUENTSYSTEMID

																											FROM
																												(
																													SELECT DISTINCT
																													  CONSTITUENTSYSTEMID
																													, FiscalYear

																													FROM
																													  tmp_CallCenterActionStatus
																												
																													WHERE 
																														ActionStatus = 'No Pledge'
																													AND FiscalYear BETWEEN 2019 AND 2020
																												) AS Q

																											GROUP BY 
																											  Q.CONSTITUENTSYSTEMID

																											HAVING 
																												COUNT(1) = 2
																										) AS NoPledge2Year ON IL.CONSTITUENTSYSTEMID = NoPledge2Year.CONSTITUENTSYSTEMID


														   UNION ALL
														   --Call Center 1 Yr Lapsed New and Reactivated
														   SELECT
														      IL.CONSTITUENTSYSTEMID
															, 70 AS SegmentPriority
															, 'Call Center 1 Yr Lapsed New and Reactivated' SegmentName

														   FROM
														      "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL 
															                                 INNER JOIN tmp_AGDonorTypePreviousFY DT ON IL.CONSTITUENTSYSTEMID=DT.CONSTITUENTSYSTEMID
																							 INNER JOIN 
																										(
																											SELECT 
																												CONSTITUENTSYSTEMID

																											FROM
																												tmp_CallCenterActionStatus--spouse already joined in temp table
																												
																											WHERE 
																												ActionStatus = 'Spec Pldg'
																												AND FiscalYear = $CurrentFY-1

																										) CallCenter ON IL.CONSTITUENTSYSTEMID = CallCenter.CONSTITUENTSYSTEMID
														   WHERE
														      DT.DPAGDonorTypeBucket IN ('New Donor', '4+ Year Lapsed Reactivated Donor')

															--[College Name] 1 Yr Lapsed New and Reactivated
															UNION ALL															
															
															SELECT 
															  GCS.CONSTITUENTSYSTEMID

															, CASE 
																	WHEN GCS.College =  'CAS'					 THEN 80
																	WHEN GCS.College =  'CEAT'                   THEN 180
																	WHEN GCS.College IN ('COHS', 'EHA', 'CEHS')	 THEN 220
																	WHEN GCS.College IN ('CVHS', 'CVM')			 THEN 260
																	WHEN GCS.College =  'DASNR'				     THEN 300
																	WHEN GCS.College =  'General University'     THEN 340
																	WHEN GCS.College =  'SSB'				     THEN 420
                                                                    WHEN GCS.College =  'Student Affairs'        THEN 460
																END AS SegmentPriority

															, CONCAT(CASE 
																	WHEN GCS.College =  'CAS'			         THEN 'CAS'
																	WHEN GCS.College =  'CEAT'                   THEN 'CEAT'
																	WHEN GCS.College IN ('COHS', 'EHA', 'CEHS')	 THEN 'CEHS'
																	WHEN GCS.College IN ('CVHS', 'CVM')			 THEN 'CVM'
																	WHEN GCS.College =  'DASNR'				     THEN 'DASNR'
																	WHEN GCS.College =  'General University'     THEN 'General University'
																	WHEN GCS.College =  'SSB'				     THEN 'SSB'
																	WHEN GCS.College =  'Student Affairs'        THEN 'Student Affairs'
																END , ' 1 Yr Lapsed New and Reactivated') AS SegmentName

															FROM
															  tmp_GivingCollegeScore AS GCS
																						INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL ON GCS.CONSTITUENTSYSTEMID = IL.CONSTITUENTSYSTEMID
																						INNER JOIN tmp_AGDonorTypePreviousFY AS DT ON GCS.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID

															WHERE
																GCS.College IN 
																				(
																					  'CAS'
																					, 'CEAT' 
																					, 'COHS', 'EHA', 'CEHS'	
																					, 'CVHS', 'CVM'
																					, 'DASNR'
																					, 'General University'
																					, 'SSB'	
                                                                                    , 'Student Affairs'
																				)
															AND DT.DPAGDonorTypeBucket IN ('New Donor','4+ Year Lapsed Reactivated Donor')

															--[College Name] 1 Yr Lapsed
															UNION ALL															
															
															SELECT 
															  GCS.CONSTITUENTSYSTEMID

															, CASE 
                                                                    WHEN GCS.College =  'CAS'					 THEN 90
																	WHEN GCS.College =  'GEN UNIV - Academic Affairs' THEN 120
																	WHEN GCS.College =  'GEN UNIV - Alumni Assn' THEN 140
																	WHEN GCS.College =  'Athletics'			     THEN 160
                                                                    WHEN GCS.College =  'CEAT'                   THEN 190
                                                                    WHEN GCS.College IN ('COHS', 'EHA', 'CEHS')	 THEN 230
                                                                    WHEN GCS.College IN ('CVHS', 'CVM')			 THEN 270
																	WHEN GCS.College =  'DASNR'				     THEN 310
																	WHEN GCS.College =  'General University'     THEN 350
																	WHEN GCS.College =  'SSB'				     THEN 430                                                          
																	WHEN GCS.College =  'Student Affairs'		 THEN 470
																END AS SegmentPriority

															, CONCAT(CASE 
                                                                    WHEN GCS.College =  'CAS'			         THEN 'CAS'
																	WHEN GCS.College =  'GEN UNIV - Academic Affairs' THEN 'Academic Affairs'
																	WHEN GCS.College =  'GEN UNIV - Alumni Assn' THEN 'Alumni Association'
																	WHEN GCS.College =  'Athletics'			     THEN 'Athletics'  
																	WHEN GCS.College =  'CEAT'                   THEN 'CEAT'
																	WHEN GCS.College IN ('COHS', 'EHA', 'CEHS')	 THEN 'CEHS'
																	WHEN GCS.College IN ('CVHS', 'CVM')			 THEN 'CVM'
																	WHEN GCS.College =  'DASNR'				     THEN 'DASNR'
																	WHEN GCS.College =  'General University'     THEN 'General University'
																	WHEN GCS.College =  'SSB'				     THEN 'SSB'
																	WHEN GCS.College =  'Student Affairs'        THEN 'Student Affairs'
																END , ' 1 Yr Lapsed') AS SegmentName

															FROM
															  tmp_GivingCollegeScore AS GCS
																						INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL ON GCS.CONSTITUENTSYSTEMID = IL.CONSTITUENTSYSTEMID
																						INNER JOIN tmp_AGDonorTypeCurrentFY AS DT ON GCS.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID

															WHERE
																GCS.College IN 
																				(
                                                                                      'CAS'
																					, 'GEN UNIV - Academic Affairs'
																					, 'GEN UNIV - Alumni Assn'
																					, 'Athletics'
                                                                                    , 'CEAT' 
																					, 'COHS', 'EHA', 'CEHS'	
																					, 'CVHS', 'CVM'
																					, 'DASNR'
																					, 'General University'
																					, 'SSB'	
																					, 'Student Affairs'
																				)
															AND DT.DPAGDonorTypeBucket = '1 Year Lapsed'

														    --[College Name] 2-3 Yr Lapsed New and Reactivated
															UNION ALL															
															
															SELECT 
															  GCS.CONSTITUENTSYSTEMID

															, CASE 
																	WHEN GCS.College =  'CAS'					 THEN 100
																	WHEN GCS.College =  'CEAT'                   THEN 200
																	WHEN GCS.College IN ('COHS', 'EHA', 'CEHS')	 THEN 240
																	WHEN GCS.College IN ('CVHS', 'CVM')			 THEN 280
																	WHEN GCS.College =  'DASNR'				     THEN 320
																	WHEN GCS.College =  'General University'     THEN 360
																	WHEN GCS.College =  'SSB'				     THEN 440
																END AS SegmentPriority

															, CONCAT(CASE 
																	WHEN GCS.College =  'CAS'				     THEN 'CAS'
																	WHEN GCS.College =  'CEAT'                   THEN 'CEAT'
																	WHEN GCS.College IN ('COHS', 'EHA', 'CEHS')	 THEN 'CEHS'
																	WHEN GCS.College IN ('CVHS', 'CVM')			 THEN 'CVM'
																	WHEN GCS.College =  'DASNR'				     THEN 'DASNR'
																	WHEN GCS.College =  'General University'     THEN 'General University'
																	WHEN GCS.College =  'SSB'				     THEN 'SSB' 
																END , ' 2-3 Yr Lapsed New and Reactivated') AS SegmentName

															FROM
															  tmp_GivingCollegeScore AS GCS
																						INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL ON GCS.CONSTITUENTSYSTEMID = IL.CONSTITUENTSYSTEMID
																						INNER JOIN tmp_AGDonorTypeCurrentFY AS DT ON GCS.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID
																						--The last fiscal year someone made an annual giving gift.
																						LEFT OUTER JOIN 
																									(
																										SELECT DISTINCT
																											LastAGGiftFY.CONSTITUENTSYSTEMID

																										FROM
																											tmp_LastAGGiftFY AS LastAGGiftFY	
																																				--The last fiscal year someone had either donor type bucket
																																				LEFT OUTER JOIN
																																						(
																																							SELECT DISTINCT
																																							  CONSTITUENTSYSTEMID 
																																							  , MAX(FiscalYear) AS FiscalYear
																																										
																																							FROM 
																																							  "OSUADV_PROD"."BI"."OSUF_DONORTYPEBUCKET"

																																							WHERE 
																																								DPAGDonorTypeBucket IN ('New Donor', '4+ Year Lapsed Reactivated Donor')

																																							GROUP BY 
																																							  CONSTITUENTSYSTEMID
																																						) AS AGDonorType ON LastAGGiftFY.CONSTITUENTSYSTEMID = AGDonorType.CONSTITUENTSYSTEMID
																													
																										WHERE 
																											LastAGGiftFY.FiscalYear = AGDonorType.FiscalYear

																									) AS LastAGGiftFY ON IL.CONSTITUENTSYSTEMID = LastAGGiftFY.CONSTITUENTSYSTEMID
															WHERE
																GCS.College IN 
																				(
																					  'CAS'
																					, 'CEAT' 
																					, 'COHS', 'EHA', 'CEHS'	
																					, 'CVHS', 'CVM'
																					, 'DASNR'
																					, 'General University'
																					, 'SSB'
																				)
															  AND DT.DPAGDonorTypeBucket IN ('2 Year Lapsed', '3 Year Lapsed') 
															  AND LastAGGiftFY.CONSTITUENTSYSTEMID IS NOT NULL
                                                          
															--[College Name] 2-3 Yr Lapsed 
															UNION ALL															
															
															SELECT 
															  GCS.CONSTITUENTSYSTEMID

															, CASE 
																	WHEN GCS.College =  'CAS'					 THEN 110
																	WHEN GCS.College =  'GEN UNIV - Academic Affairs' THEN 130
																	WHEN GCS.College =  'GEN UNIV - Alumni Assn' THEN 150
																	WHEN GCS.College =  'Athletics'			     THEN 170
																	WHEN GCS.College =  'CEAT'                   THEN 210
																	WHEN GCS.College IN ('COHS', 'EHA', 'CEHS')	 THEN 250
																	WHEN GCS.College IN ('CVHS', 'CVM')			 THEN 290
																	WHEN GCS.College =  'DASNR'				     THEN 330
																	WHEN GCS.College =  'General University'     THEN 370
																	WHEN GCS.College =  'SSB'				     THEN 450
																	WHEN GCS.College =  'Student Affairs'		 THEN 480

																END AS SegmentPriority

															, CONCAT(CASE 
																	WHEN GCS.College =  'CAS'				     THEN 'CAS'
																	WHEN GCS.College =  'GEN UNIV - Academic Affairs' THEN 'Academic Affairs'
																	WHEN GCS.College =  'GEN UNIV - Alumni Assn' THEN 'Alumni Association'
																	WHEN GCS.College =  'Athletics'			     THEN 'Athletics'
																	WHEN GCS.College =  'CEAT'                   THEN 'CEAT'
																	WHEN GCS.College IN ('COHS', 'EHA', 'CEHS')	 THEN 'CEHS'
																	WHEN GCS.College IN ('CVHS', 'CVM')			 THEN 'CVM'
																	WHEN GCS.College =  'DASNR'				     THEN 'DASNR'
																	WHEN GCS.College =  'General University'     THEN 'General University'
																	WHEN GCS.College =  'SSB'				     THEN 'SSB'
																	WHEN GCS.College =  'Student Affairs'		 THEN 'Student Affairs'
																END , ' 2-3 Yr Lapsed') AS SegmentName

															FROM
															  tmp_GivingCollegeScore AS GCS
																						INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL ON GCS.CONSTITUENTSYSTEMID = IL.CONSTITUENTSYSTEMID
																						INNER JOIN tmp_AGDonorTypeCurrentFY AS DT ON GCS.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID

															WHERE
																GCS.College IN 
																				(
																					  'CAS'
																					, 'GEN UNIV - Academic Affairs'
																					, 'GEN UNIV - Alumni Assn'
																					, 'Athletics'
																					, 'CEAT' 
																					, 'COHS', 'EHA', 'CEHS'	
																					, 'CVHS', 'CVM'
																					, 'DASNR'
																					, 'General University'
																					, 'SSB'
																					, 'Student Affairs'
																				)
															AND DT.DPAGDonorTypeBucket IN ('2 Year Lapsed', '3 Year Lapsed')
															

															--[College Name] Recent Donors
															UNION ALL															
															
															SELECT 
															  GCS.CONSTITUENTSYSTEMID

															, CASE 
																	WHEN GCS.College =  'OSU-CHS'			     THEN 380
																	WHEN GCS.College =  'OSUIT'				     THEN 390
																	WHEN GCS.College =  'OSU-OKC'			     THEN 400
																	WHEN GCS.College =  'OSU-Tulsa'			     THEN 410
																END AS SegmentPriority

															, CONCAT(CASE 
																	WHEN GCS.College =  'OSU-CHS'			     THEN 'OSU-CHS'
																	WHEN GCS.College =  'OSUIT'				     THEN 'OSU-IT'
																	WHEN GCS.College =  'OSU-OKC'			     THEN 'OSU-OKC'
																	WHEN GCS.College =  'OSU-Tulsa'			     THEN 'OSU-Tulsa'
																END , ' Recent Donors') AS SegmentName

															FROM
															  tmp_GivingCollegeScore AS GCS
																						INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL ON GCS.CONSTITUENTSYSTEMID = IL.CONSTITUENTSYSTEMID
																						INNER JOIN tmp_AGDonorTypeCurrentFY AS DT ON GCS.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID

															WHERE
																GCS.College IN 
																				(
																					  'OSU-CHS'
																					, 'OSUIT'
																					, 'OSU-OKC'
																					, 'OSU-Tulsa'
																				)
															AND DT.DPAGDonorTypeBucket IN ('1 Year Lapsed', '2 Year Lapsed', '3 Year Lapsed')	

															UNION ALL
														   --Parents
														   SELECT 
															  IL.CONSTITUENTSYSTEMID
															, 490 AS SegmentPriority
															, 'Parents' SegmentName	
													
														   FROM
															"OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst"IL 
																							 LEFT OUTER JOIN
																										(
																											SELECT DISTINCT
																												CONSTITUENTSYSTEMID

																											FROM																		
																												"OSUADV_PROD"."RE"."CONSTITUENT_DTL_CONSTITUENTCODES"

																										   WHERE 
																											  ConstituentCode = 'Parent'

																										) Parent ON IL.CONSTITUENTSYSTEMID = Parent.CONSTITUENTSYSTEMID

															WHERE 
																Parent.CONSTITUENTSYSTEMID IS NOT NULL 

															--[College Name] 4+ Under 10 
															UNION ALL															
															
															SELECT 
															  GCS.CONSTITUENTSYSTEMID

															, CASE 
																	WHEN GCS.College =  'GEN UNIV - Academic Affairs' THEN 500
																	WHEN GCS.College =  'CAS'					 THEN 520
																	WHEN GCS.College =  'CEAT'                   THEN 540
																	WHEN GCS.College =  'DASNR'				     THEN 560
																	WHEN GCS.College =  'SSB'				     THEN 580
																	WHEN GCS.College IN ('COHS', 'EHA', 'CEHS')	 THEN 600
																	WHEN GCS.College IN ('CVHS', 'CVM')			 THEN 620
																	WHEN GCS.College =  'OSU-CHS'			     THEN 640
																	WHEN GCS.College =  'OSU-Tulsa'			     THEN 660
																	WHEN GCS.College =  'OSUIT'				     THEN 680
																	WHEN GCS.College =  'OSU-OKC'			     THEN 700
																	WHEN GCS.College =  'Student Affairs'		 THEN 720
																	WHEN GCS.College =  'GEN UNIV - Alumni Assn' THEN 740
																	WHEN GCS.College =  'Athletics'			     THEN 760
																	WHEN GCS.College =  'General University'     THEN 780
																END AS SegmentPriority

															, CONCAT(CASE 
																	WHEN GCS.College =  'GEN UNIV - Academic Affairs' THEN 'Academic Affairs'
																	WHEN GCS.College =  'CAS'				     THEN 'CAS'
																	WHEN GCS.College =  'CEAT'                   THEN 'CEAT'
																	WHEN GCS.College =  'DASNR'				     THEN 'DASNR'
																	WHEN GCS.College =  'SSB'				     THEN 'SSB'
																	WHEN GCS.College IN ('COHS', 'EHA', 'CEHS')	 THEN 'CEHS'
																	WHEN GCS.College IN ('CVHS', 'CVM')			 THEN 'CVM'
																	WHEN GCS.College =  'OSU-CHS'				 THEN 'OSU-CHS'
																	WHEN GCS.College =  'OSU-Tulsa'			     THEN 'OSU-Tulsa'
																	WHEN GCS.College =  'OSUIT'				     THEN 'OSU-IT'
																	WHEN GCS.College =  'OSU-OKC'			     THEN 'OSU-OKC'
																	WHEN GCS.College =  'Student Affairs'		 THEN 'Student Affairs'
																	WHEN GCS.College =  'GEN UNIV - Alumni Assn' THEN 'Alumni Association'
																	WHEN GCS.College =  'Athletics'			     THEN 'Athletics'
																	WHEN GCS.College =  'General University'     THEN 'General University'	
																END , ' 4+ Under 10') AS SegmentName

															FROM
															  tmp_GivingCollegeScore AS GCS
																						INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst"AS IL ON GCS.CONSTITUENTSYSTEMID = IL.CONSTITUENTSYSTEMID
																						INNER JOIN tmp_AGDonorTypeCurrentFY AS DT ON GCS.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID
																						--AG defined gift in last 9 years
																						LEFT OUTER JOIN
																											(
																												SELECT DISTINCT
																												   CONSTITUENTSYSTEMID, FiscalYear

																												FROM 
																												  tmp_ProductionGift

																												WHERE
																												     (IsAGGift = 'Yes' OR IsPhilanthropic = 'Yes')--included because AGDT Bucket includes consideration for AGGift or Philanthropic gift
																												AND FiscalYear BETWEEN $CurrentFY-9 AND $CurrentFY-1--last 9 years, not counting current FY

																											)  AS AGGift ON IL.CONSTITUENTSYSTEMID = AGGift.CONSTITUENTSYSTEMID

															WHERE
																GCS.College IN 
																				(
																					  'CAS'
																					, 'GEN UNIV - Academic Affairs'
																					, 'GEN UNIV - Alumni Assn'
																					, 'Athletics'
																					, 'CEAT' 
																					, 'COHS', 'EHA', 'CEHS'	
																					, 'CVHS', 'CVM'
																					, 'DASNR'
																					, 'General University' 																																		
																					, 'OSU-CHS'
																					, 'OSUIT'
																					, 'OSU-OKC'
																					, 'OSU-Tulsa'
																					, 'SSB'
																					, 'Student Affairs'
																				)
															AND DT.DPAGDonorTypeBucket = '4+ Year Lapsed'
															AND AGGift.CONSTITUENTSYSTEMID IS NOT NULL 

															--[College Name] 4+ 10-20
															UNION ALL															
															
															SELECT 
															  GCS.CONSTITUENTSYSTEMID

															, CASE 
																	WHEN GCS.College =  'GEN UNIV - Academic Affairs' THEN 510
																	WHEN GCS.College =  'CAS'					 THEN 530
																	WHEN GCS.College =  'CEAT'                   THEN 550
																	WHEN GCS.College =  'DASNR'				     THEN 570
																	WHEN GCS.College =  'SSB'				     THEN 590
																	WHEN GCS.College IN ('COHS', 'EHA', 'CEHS')	 THEN 610
																	WHEN GCS.College IN ('CVHS', 'CVM')			 THEN 630
																	WHEN GCS.College =  'OSU-CHS'			     THEN 650
																	WHEN GCS.College =  'OSU-Tulsa'			     THEN 670
																	WHEN GCS.College =  'OSUIT'				     THEN 690
																	WHEN GCS.College =  'OSU-OKC'			     THEN 710
																	WHEN GCS.College =  'Student Affairs'		 THEN 730
																	WHEN GCS.College =  'GEN UNIV - Alumni Assn' THEN 750
																	WHEN GCS.College =  'Athletics'			     THEN 770
																	WHEN GCS.College =  'General University'     THEN 790																	
																END AS SegmentPriority

															, CONCAT(CASE 
																	WHEN GCS.College =  'GEN UNIV - Academic Affairs' THEN 'Academic Affairs'
																	WHEN GCS.College =  'CAS'				     THEN 'CAS'
																	WHEN GCS.College =  'CEAT'                   THEN 'CEAT'
																	WHEN GCS.College =  'DASNR'				     THEN 'DASNR'
																	WHEN GCS.College =  'SSB'				     THEN 'SSB'
																	WHEN GCS.College IN ('COHS', 'EHA', 'CEHS')	 THEN 'CEHS'
																	WHEN GCS.College IN ('CVHS', 'CVM')			 THEN 'CVM'
																	WHEN GCS.College =  'OSU-Tulsa'			     THEN 'OSU-Tulsa'
																	WHEN GCS.College =  'OSUIT'				     THEN 'OSU-IT'
																	WHEN GCS.College =  'OSU-OKC'			     THEN 'OSU-OKC'
																	WHEN GCS.College =  'Student Affairs'		 THEN 'Student Affairs'
																	WHEN GCS.College =  'GEN UNIV - Alumni Assn' THEN 'Alumni Association'
																	WHEN GCS.College =  'Athletics'			     THEN 'Athletics'
																	WHEN GCS.College =  'General University'     THEN 'General University'																																		
																	WHEN GCS.College =  'OSU-CHS'			     THEN 'OSU-CHS'
																END , ' 4+ 10-20') AS SegmentName

															FROM
															  tmp_GivingCollegeScore AS GCS
																						INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL ON GCS.CONSTITUENTSYSTEMID = IL.CONSTITUENTSYSTEMID
																						INNER JOIN tmp_AGDonorTypeCurrentFY AS DT ON GCS.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID
																						--AG defined gift in last 9 years
																						LEFT OUTER JOIN
																											(
																												SELECT DISTINCT
																												   CONSTITUENTSYSTEMID

																												FROM 
																												  tmp_ProductionGift

																												WHERE
																												     (IsAGGift = 'Yes' OR IsPhilanthropic = 'Yes')--included because AGDT Bucket includes consideration for AGGift or Philanthropic gift
																												AND FiscalYear BETWEEN $CurrentFY-9 AND $CurrentFY-1--last 9 years, not counting current FY

																											)  AS AGGift2 ON IL.CONSTITUENTSYSTEMID = AGGift2.CONSTITUENTSYSTEMID

																						--AG defined gift in last 19 years
																						LEFT OUTER JOIN
																											(
																												SELECT DISTINCT
																												   CONSTITUENTSYSTEMID

																												FROM 
																												  tmp_ProductionGift

																												WHERE
																												     (IsAGGift = 'Yes' OR IsPhilanthropic = 'Yes')--included because AGDT Bucket includes consideration for AGGift or Philanthropic gift
																												AND FiscalYear BETWEEN $CurrentFY-19 AND $CurrentFY-1 --last 19 years, not counting current FY

																											)  AS AGGift3 ON IL.CONSTITUENTSYSTEMID = AGGift3.CONSTITUENTSYSTEMID

															WHERE
																GCS.College IN 
																				(
																					  'CAS'
																					, 'GEN UNIV - Academic Affairs'
																					, 'GEN UNIV - Alumni Assn'
																					, 'Athletics'
																					, 'CEAT' 
																					, 'COHS', 'EHA', 'CEHS'	 
																					, 'CVHS', 'CVM'
																					, 'DASNR'
																					, 'General University' 																																		
																					, 'OSU-CHS'
																					, 'OSUIT'
																					, 'OSU-OKC'
																					, 'OSU-Tulsa'
																					, 'SSB'
																					, 'Student Affairs'
																				)
															AND DT.DPAGDonorTypeBucket = '4+ Year Lapsed'
															AND AGGift3.CONSTITUENTSYSTEMID IS NOT NULL --Do have AG in last 19 yrs
															AND AGGift2.CONSTITUENTSYSTEMID IS NULL --No AG in last 9 years


                                                           UNION ALL
														   --New Grads
														   SELECT
															  IL.CONSTITUENTSYSTEMID
															, 800 AS SegmentPriority
															, 'New Grads' SegmentName

														   FROM 
														      "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL

																							INNER JOIN
																									(
																										SELECT	
																											CONSTITUENTSYSTEMID
																												
																										FROM 
																											tmp_EducationMaxUnderGradYear 

																										WHERE
																											YEAR(DateGraduated) >= 2019
																											
																									) AS UnderGradEducation ON IL.CONSTITUENTSYSTEMID = UnderGradEducation.CONSTITUENTSYSTEMID

															--[College Name] Nons 11+ FIRST ROUND for undergrad degrees
															UNION ALL															
															
															SELECT 
															  IL.CONSTITUENTSYSTEMID

															, CASE 
																	WHEN Edu.SchoolType =  'OSU-CHS'				 THEN 810																	
																	WHEN Edu.SchoolType =  'OSU-Tulsa'				 THEN 820
																	WHEN Edu.SchoolType =  'CAS'					 THEN 830
																	WHEN Edu.SchoolType =  'CEAT'					 THEN 840
																	WHEN Edu.SchoolType IN ('COHS', 'EHA', 'CEHS')	 THEN 850
																	WHEN Edu.SchoolType IN ('CVHS', 'CVM')			 THEN 860
																	WHEN Edu.SchoolType =  'DASNR'					 THEN 870
																	WHEN Edu.SchoolType =  'OSUIT'					 THEN 880
																	WHEN Edu.SchoolType =  'OSU-OKC'			     THEN 890
																	WHEN Edu.SchoolType =  'SSB'				     THEN 900
																END AS SegmentPriority

															, CONCAT(CASE 
																	WHEN Edu.SchoolType =  'OSU-CHS'				 THEN 'OSU-CHS'																	
																	WHEN Edu.SchoolType =  'OSU-Tulsa'				 THEN 'OSU-Tulsa'
																	WHEN Edu.SchoolType =  'CAS'					 THEN 'CAS'
																	WHEN Edu.SchoolType =  'CEAT'					 THEN 'CEAT'
																	WHEN Edu.SchoolType IN ('COHS', 'EHA', 'CEHS')	 THEN 'CEHS'
																	WHEN Edu.SchoolType IN ('CVHS', 'CVM')			 THEN 'CVM'
																	WHEN Edu.SchoolType =  'DASNR'					 THEN 'DASNR'
																	WHEN Edu.SchoolType =  'OSUIT'					 THEN 'OSU-IT'																	
																	WHEN Edu.SchoolType =  'OSU-OKC'			     THEN 'OSU-OKC'																	
																	WHEN Edu.SchoolType =  'SSB'				     THEN 'SSB'
																END , ' Nons 11+') AS SegmentName

															FROM
															  	"OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL 

																						INNER JOIN tmp_AGDonorTypeCurrentFY AS DT ON IL.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID

																						--LAST (most recent) Degree Year for OSU-CHS, CVHS, OSUIT, OSU-OKC
																						--LAST (most recent) Undergrad Degree Year for specified college																						
																						LEFT OUTER JOIN 
																									(																						
																										SELECT
																											  CONSTITUENTSYSTEMID
																											, SchoolType

																										FROM 
																											tmp_EducationMaxYear
																																					
																																			
																										WHERE 
																											YEAR(DateGraduated) >= 2011	
																											AND SchoolType IN ('OSU-CHS', 'CVHS', 'CVM', 'OSUIT', 'OSU-OKC')
																																		
																										UNION
																										
																										SELECT
																											  CONSTITUENTSYSTEMID
																											, SchoolType

																										FROM 
																											tmp_EducationMaxUnderGradYear
																																					
																																			
																										WHERE 
																											YEAR(DateGraduated) >= 2011	
																											AND SchoolType IN 
																																		(
																																			  'CAS'
																																			, 'CEAT' 
																																			, 'COHS', 'EHA', 'CEHS'
																																			, 'DASNR'
																																			, 'SSB'
																																			, 'OSU-Tulsa'
																																		)	
																										
																									) Edu ON IL.CONSTITUENTSYSTEMID = Edu.CONSTITUENTSYSTEMID
																									 

															WHERE
																Edu.SchoolType IN 
																				(
																					'OSU-CHS'
																					, 'OSU-Tulsa'
																					, 'CAS'
																					, 'CEAT' 
																					, 'COHS', 'EHA', 'CEHS'
																					, 'CVHS', 'CVM'
																					, 'DASNR'
																					, 'OSU-OKC'
																					, 'OSUIT'																					
																					, 'SSB'																					
																				)
																AND DT.DPAGDonorTypeBucket = 'Non-Donor'
																AND Edu.CONSTITUENTSYSTEMID IS NOT NULL

															--[College Name] Nons 11+ SECOND ROUND for graduate degrees
															UNION ALL															
															
															SELECT 
															  IL.CONSTITUENTSYSTEMID

															, CASE 																																		
																	WHEN Edu.SchoolType =  'OSU-Tulsa'				 THEN 910
																	WHEN Edu.SchoolType =  'CAS'					 THEN 920
																	WHEN Edu.SchoolType =  'CEAT'					 THEN 930
																	WHEN Edu.SchoolType IN ('COHS', 'EHA', 'CEHS')	 THEN 940
																	WHEN Edu.SchoolType =  'DASNR'					 THEN 950
																	WHEN Edu.SchoolType =  'SSB'				     THEN 960
																END AS SegmentPriority

															, CONCAT(CASE 
																	WHEN Edu.SchoolType =  'OSU-Tulsa'				 THEN 'OSU-Tulsa'
																	WHEN Edu.SchoolType =  'CAS'					 THEN 'CAS'
																	WHEN Edu.SchoolType =  'CEAT'					 THEN 'CEAT'
																	WHEN Edu.SchoolType IN ('COHS', 'EHA', 'CEHS')	 THEN 'CEHS'
																	WHEN Edu.SchoolType =  'DASNR'					 THEN 'DASNR'
																	WHEN Edu.SchoolType =  'SSB'				     THEN 'SSB'
																END , ' Nons 11+') AS SegmentName

															FROM
															  	"OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL 

																						INNER JOIN tmp_AGDonorTypeCurrentFY AS DT ON IL.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID
																																												
																						--LAST (most recent) Graduate Degree Year for specified college																						
																						LEFT OUTER JOIN 
																									(																						
																										SELECT
																											  CONSTITUENTSYSTEMID
																											, SchoolType

																										FROM 
																											tmp_EducationMaxGradYear
																																					
																																			
																										WHERE 
																											YEAR(DateGraduated) >= 2011	
																											AND SchoolType IN 
																																		(
																																			  'OSU-Tulsa'
																																			, 'CAS'
																																			, 'CEAT' 
																																			, 'COHS', 'EHA', 'CEHS'	
																																			, 'DASNR'
																																			, 'SSB'
																																			
																																		)	
																										
																									) Edu ON IL.CONSTITUENTSYSTEMID = Edu.CONSTITUENTSYSTEMID
																									 

															WHERE
																Edu.SchoolType IN 
																				(
																					  'OSU-Tulsa'
																					, 'CAS'
																					, 'CEAT' 
																					, 'COHS', 'EHA', 'CEHS'
																					, 'DASNR'
																					, 'SSB'
																					
																				)
																AND DT.DPAGDonorTypeBucket = 'Non-Donor'
																AND Edu.CONSTITUENTSYSTEMID IS NOT NULL


															--[College Name] Nons 80-10 FIRST ROUND for undergrad degrees
															UNION ALL															
															
															SELECT 
															  IL.CONSTITUENTSYSTEMID

															, CASE 
																	WHEN Edu.SchoolType =  'OSU-CHS'				 THEN 970																	
																	WHEN Edu.SchoolType =  'OSU-Tulsa'				 THEN 980
																	WHEN Edu.SchoolType =  'CAS'					 THEN 990
																	WHEN Edu.SchoolType =  'CEAT'					 THEN 1000
																	WHEN Edu.SchoolType IN ('COHS', 'EHA', 'CEHS')	 THEN 1010
																	WHEN Edu.SchoolType IN ('CVHS', 'CVM')			 THEN 1020
																	WHEN Edu.SchoolType =  'DASNR'					 THEN 1030																	
																	WHEN Edu.SchoolType =  'OSU-OKC'			     THEN 1040
																	WHEN Edu.SchoolType =  'OSUIT'					 THEN 1050
																	WHEN Edu.SchoolType =  'SSB'				     THEN 1060
																END AS SegmentPriority

															, CONCAT(CASE 
																	WHEN Edu.SchoolType =  'OSU-CHS'				 THEN 'OSU-CHS'																	
																	WHEN Edu.SchoolType =  'OSU-Tulsa'				 THEN 'OSU-Tulsa'
																	WHEN Edu.SchoolType =  'CAS'					 THEN 'CAS'
																	WHEN Edu.SchoolType =  'CEAT'					 THEN 'CEAT'
																	WHEN Edu.SchoolType IN ('COHS', 'EHA', 'CEHS')	 THEN 'CEHS'
																	WHEN Edu.SchoolType IN ('CVHS', 'CVM')			 THEN 'CVM'
																	WHEN Edu.SchoolType =  'DASNR'					 THEN 'DASNR'																	
																	WHEN Edu.SchoolType =  'OSU-OKC'			     THEN 'OSU-OKC'
																	WHEN Edu.SchoolType =  'OSUIT'					 THEN 'OSU-IT'
																	WHEN Edu.SchoolType =  'SSB'				     THEN 'SSB'
																END , ' Nons 80-10') AS SegmentName

															FROM
															  	"OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL 

																						INNER JOIN tmp_AGDonorTypeCurrentFY AS DT ON IL.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID

																						--LAST (most recent) Degree Year for OSU-CHS, CVHS, OSUIT, OSU-OKC
																						--LAST (most recent) Undergrad Degree Year for specified college
																						LEFT OUTER JOIN 
																									(																						
																										SELECT
																											  CONSTITUENTSYSTEMID
																											, SchoolType

																										FROM 
																											tmp_EducationMaxYear
																																					
																																			
																										WHERE 
																											YEAR(DateGraduated) BETWEEN 1980 AND 2010	
																											AND SchoolType IN ('OSU-CHS', 'CVHS', 'CVM', 'OSUIT', 'OSU-OKC')
																																																																					
																										UNION
																										
																										SELECT
																											  CONSTITUENTSYSTEMID
																											, SchoolType

																										FROM 
																											tmp_EducationMaxUnderGradYear
																																					
																																			
																										WHERE 
																											YEAR(DateGraduated) BETWEEN 1980 AND 2010	
																											AND SchoolType IN 
																																		(
																																			  'CAS'
																																			, 'CEAT' 
																																			, 'COHS', 'EHA', 'CEHS'	
																																			, 'DASNR'																																			
																																			, 'SSB'
																																			, 'OSU-Tulsa'
																																		)	
																										
																									) Edu ON IL.CONSTITUENTSYSTEMID = Edu.CONSTITUENTSYSTEMID
																						

															WHERE
																Edu.SchoolType IN 
																				(
																					  'OSU-CHS'																					
																					, 'OSU-Tulsa'
																					, 'CAS'
																					, 'CEAT' 
																					, 'COHS', 'EHA', 'CEHS'
																					, 'CVHS', 'CVM'
																					, 'DASNR'
																					, 'OSU-OKC'
																					, 'OSUIT'																					
																					, 'SSB'
																				)
																AND DT.DPAGDonorTypeBucket = 'Non-Donor'
																AND Edu.CONSTITUENTSYSTEMID IS NOT NULL

															--[College Name] Nons 80-10 SECOND ROUND for Graduate Degrees
															UNION ALL															
															
															SELECT 
															  IL.CONSTITUENTSYSTEMID

															, CASE 
																	WHEN Edu.SchoolType =  'OSU-Tulsa'				 THEN 1070
																	WHEN Edu.SchoolType =  'CAS'					 THEN 1080
																	WHEN Edu.SchoolType =  'CEAT'					 THEN 1090
																	WHEN Edu.SchoolType IN ('COHS', 'EHA', 'CEHS')	 THEN 1100
																	WHEN Edu.SchoolType =  'DASNR'					 THEN 1110
																	WHEN Edu.SchoolType =  'SSB'				     THEN 1120
																END AS SegmentPriority

															, CONCAT(CASE 
																	WHEN Edu.SchoolType =  'OSU-Tulsa'				 THEN 'OSU-Tulsa'
																	WHEN Edu.SchoolType =  'CAS'					 THEN 'CAS'
																	WHEN Edu.SchoolType =  'CEAT'					 THEN 'CEAT'
																	WHEN Edu.SchoolType IN ('COHS', 'EHA', 'CEHS')	 THEN 'CEHS'
																	WHEN Edu.SchoolType =  'DASNR'					 THEN 'DASNR'
																	WHEN Edu.SchoolType =  'SSB'				     THEN 'SSB'
																END , ' Nons 80-10') AS SegmentName

															FROM
															  	"OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL 

																						INNER JOIN tmp_AGDonorTypeCurrentFY AS DT ON IL.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID
																																												
																						--LAST (most recent) Graduate Degree Year for specified college
																						LEFT OUTER JOIN 
																									(																						
																										SELECT
																											  CONSTITUENTSYSTEMID
																											, SchoolType

																										FROM 
																											tmp_EducationMaxGradYear
																																					
																																			
																										WHERE 
																											YEAR(DateGraduated) BETWEEN 1980 AND 2010	
																											AND SchoolType IN 
																																		(
																																			  'CAS'
																																			, 'CEAT' 
																																			, 'COHS', 'EHA', 'CEHS'	
																																			, 'DASNR'																																			
																																			, 'SSB'
																																			, 'OSU-Tulsa'
																																		)
																										
																									) Edu ON IL.CONSTITUENTSYSTEMID = Edu.CONSTITUENTSYSTEMID
																						

															WHERE
																Edu.SchoolType IN 
																				(
																					  'OSU-Tulsa'
																					, 'CAS'
																					, 'CEAT' 
																					, 'COHS', 'EHA', 'CEHS'	
																					, 'DASNR'
																					, 'SSB'
																				)
																AND DT.DPAGDonorTypeBucket = 'Non-Donor'
																AND Edu.CONSTITUENTSYSTEMID IS NOT NULL


															--[College Name] Nons Pre 80 FIRST ROUND for undergrad degrees
															UNION ALL															
															
															SELECT 
															  IL.CONSTITUENTSYSTEMID

															, CASE 
																	WHEN Edu.SchoolType = 'OSU-CHS'					 THEN 1130
																	WHEN Edu.SchoolType =  'CAS'					 THEN 1140
																	WHEN Edu.SchoolType =  'CEAT'					 THEN 1150
																	WHEN Edu.SchoolType IN ('COHS', 'EHA', 'CEHS')	 THEN 1160
																	WHEN Edu.SchoolType IN ('CVHS', 'CVM')			 THEN 1170
																	WHEN Edu.SchoolType =  'DASNR'					 THEN 1180	
																	WHEN Edu.SchoolType =  'OSUIT'					 THEN 1190																
																	WHEN Edu.SchoolType =  'OSU-OKC'			     THEN 1200																	
																	WHEN Edu.SchoolType =  'SSB'				     THEN 1210
																END AS SegmentPriority

															, CONCAT(CASE 
																	WHEN Edu.SchoolType = 'OSU-CHS'					 THEN 'OSU-CHS'
																	WHEN Edu.SchoolType =  'CAS'					 THEN 'CAS'
																	WHEN Edu.SchoolType =  'CEAT'					 THEN 'CEAT'
																	WHEN Edu.SchoolType IN ('COHS', 'EHA', 'CEHS')	 THEN 'CEHS'
																	WHEN Edu.SchoolType IN ('CVHS', 'CVM')			 THEN 'CVM'
																	WHEN Edu.SchoolType =  'DASNR'					 THEN 'DASNR'
																	WHEN Edu.SchoolType =  'OSUIT'					 THEN 'OSU-IT'																	
																	WHEN Edu.SchoolType =  'OSU-OKC'			     THEN 'OSU-OKC'																	
																	WHEN Edu.SchoolType =  'SSB'				     THEN 'SSB'
																END , ' Nons Pre 80') AS SegmentName

															FROM
															  	"OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL 

																						INNER JOIN tmp_AGDonorTypeCurrentFY AS DT ON IL.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID
																						
																						--LAST (most recent) Degree Year for OSU-CHS, CVHS, OSUIT, OSU-OKC
																						--OR LAST (most recent) Undergrad Degree Year for specified college
																						LEFT OUTER JOIN 
																									(																					
																										--marker
																										SELECT
																											  CONSTITUENTSYSTEMID
																											, SchoolType

																										FROM 																										
																											tmp_EducationMaxYear																																					
																																			
																										WHERE 
																											YEAR(DateGraduated) < 1980
																											AND SchoolType IN ('OSU-CHS', 'CVHS', 'CVM', 'OSUIT', 'OSU-OKC')

																																		
																										UNION																										
																										SELECT
																											  CONSTITUENTSYSTEMID
																											, SchoolType

																										FROM 
																											tmp_EducationMaxUnderGradYear
																																					
																																			
																										WHERE 
																											YEAR(DateGraduated) < 1980	
																											AND SchoolType IN 
																																		(
																																			  'CAS'
																																			, 'CEAT' 
																																			, 'COHS', 'EHA', 'CEHS'		
																																			, 'DASNR'
																																			, 'SSB'
																																		)																																															
																										
																									) Edu ON IL.CONSTITUENTSYSTEMID = Edu.CONSTITUENTSYSTEMID
																						

															WHERE
																Edu.SchoolType IN 
																				(
																					'OSU-CHS'
																					, 'CAS'
																					, 'CEAT' 
																					, 'COHS', 'EHA', 'CEHS'	
																					, 'CVHS', 'CVM'
																					, 'DASNR'
																					, 'OSUIT'
																					, 'OSU-OKC'
																					, 'SSB'
																				)
																AND DT.DPAGDonorTypeBucket = 'Non-Donor'
																AND Edu.CONSTITUENTSYSTEMID IS NOT NULL	


															--[College Name] Nons Pre 80 SECOND ROUND for Graduate Degrees
															UNION ALL															
															
															SELECT 
															  IL.CONSTITUENTSYSTEMID

															, CASE 
																	WHEN Edu.SchoolType =  'CAS'					 THEN 1220
																	WHEN Edu.SchoolType =  'CEAT'					 THEN 1230
																	WHEN Edu.SchoolType IN ('COHS', 'EHA', 'CEHS')	 THEN 1240
																	WHEN Edu.SchoolType =  'DASNR'					 THEN 1250
																	WHEN Edu.SchoolType =  'SSB'				     THEN 1260
																END AS SegmentPriority

															, CONCAT(CASE 
																	WHEN Edu.SchoolType =  'CAS'					 THEN 'CAS'
																	WHEN Edu.SchoolType =  'CEAT'					 THEN 'CEAT'
																	WHEN Edu.SchoolType IN ('COHS', 'EHA', 'CEHS')	 THEN 'CEHS'
																	WHEN Edu.SchoolType =  'DASNR'					 THEN 'DASNR'
																	WHEN Edu.SchoolType =  'SSB'				     THEN 'SSB'
																END , ' Nons Pre 80') AS SegmentName

															FROM
															  	"OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL 

																						INNER JOIN tmp_AGDonorTypeCurrentFY AS DT ON IL.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID
																						
																						--LAST (most recent) Graduate Degree Year for specified college
																						LEFT OUTER JOIN 
																									(																					
																										SELECT
																											  CONSTITUENTSYSTEMID
																											, SchoolType

																										FROM 
																											tmp_EducationMaxGradYear
																																					
																																			
																										WHERE 
																											YEAR(DateGraduated) < 1980	
																											AND SchoolType IN 
																																		(
																																			  'CAS'
																																			, 'CEAT' 
																																			, 'COHS', 'EHA', 'CEHS'	
																																			, 'DASNR'
																																			, 'SSB'
																																		)																																															
																										
																									) Edu ON IL.CONSTITUENTSYSTEMID = Edu.CONSTITUENTSYSTEMID
																						

															WHERE
																Edu.SchoolType IN 
																				(
																					
																					  'CAS'
																					, 'CEAT' 
																					, 'COHS', 'EHA', 'CEHS'	
																					, 'DASNR'
																					, 'SSB'
																				)
																AND DT.DPAGDonorTypeBucket = 'Non-Donor'
																AND Edu.CONSTITUENTSYSTEMID IS NOT NULL	


															--[College Name] Nons
															--Highest College Fund Attribute Score, 4+ Year Lapsed, no AG giving in last 19 yrs
															UNION ALL															
															
															SELECT 
															  GCS.CONSTITUENTSYSTEMID

															, CASE 
																	WHEN GCS.College =  'OSU-CHS'			     THEN 1270
																	WHEN GCS.College =  'OSU-Tulsa'			     THEN 1300
																	WHEN GCS.College =  'GEN UNIV - Academic Affairs' THEN 1310
																	WHEN GCS.College =  'Student Affairs'		 THEN 1320
																	WHEN GCS.College =  'CAS'					 THEN 1340
																	WHEN GCS.College =  'CEAT'                   THEN 1350																	
																	WHEN GCS.College IN ('COHS', 'EHA', 'CEHS')	 THEN 1360
																	WHEN GCS.College IN ('CVHS', 'CVM')			 THEN 1370
																	WHEN GCS.College =  'DASNR'				     THEN 1380
																	WHEN GCS.College =  'OSUIT'				     THEN 1390
																	WHEN GCS.College =  'OSU-OKC'			     THEN 1400																	
																	WHEN GCS.College =  'General University'     THEN 1410														
																	WHEN GCS.College =  'SSB'				     THEN 1420
																	WHEN GCS.College =  'GEN UNIV - Alumni Assn' THEN 1430
																	WHEN GCS.College =  'Athletics'			     THEN 1440
																END AS SegmentPriority

															, CONCAT(CASE 
																	WHEN GCS.College =  'OSU-CHS'			     THEN 'OSU-CHS'																	
																	WHEN GCS.College =  'OSU-Tulsa'			     THEN 'OSU-Tulsa'																	
																	WHEN GCS.College =  'GEN UNIV - Academic Affairs' THEN 'Academic Affairs'
																	WHEN GCS.College =  'Student Affairs'		 THEN 'Student Affairs'
																	WHEN GCS.College =	'CAS'				     THEN 'CAS'
																	WHEN GCS.College =  'CEAT'                   THEN 'CEAT'
																	WHEN GCS.College IN ('COHS', 'EHA', 'CEHS')	 THEN 'CEHS'
																	WHEN GCS.College IN ('CVHS', 'CVM')			 THEN 'CVM'
																	WHEN GCS.College =  'DASNR'				     THEN 'DASNR'
																	WHEN GCS.College =  'OSUIT'				     THEN 'OSU-IT'
																	WHEN GCS.College =  'OSU-OKC'			     THEN 'OSU-OKC'
																	WHEN GCS.College =  'General University'     THEN 'General University'																	
																	WHEN GCS.College =  'SSB'				     THEN 'SSB'		
																	WHEN GCS.College =  'GEN UNIV - Alumni Assn' THEN 'Alumni Association'
																	WHEN GCS.College =  'Athletics'			     THEN 'Athletics'																																																	
																END , ' Nons') AS SegmentName															

															FROM
															  tmp_GivingCollegeScore AS GCS
																						INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL ON GCS.CONSTITUENTSYSTEMID = IL.CONSTITUENTSYSTEMID
																						INNER JOIN tmp_AGDonorTypeCurrentFY AS DT ON GCS.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID
																				
																						--AG defined gift in last 19 years
																						LEFT OUTER JOIN
																											(
																												SELECT DISTINCT
																												   CONSTITUENTSYSTEMID

																												FROM 
																												  tmp_ProductionGift

																												WHERE
																												     (IsAGGift = 'Yes' OR IsPhilanthropic = 'Yes')--included because AGDT Bucket includes consideration for AGGift or Philanthropic gift
																												AND FiscalYear BETWEEN $CurrentFY-19 AND $CurrentFY-1 --last 19 years, not counting current FY

																											)  AS AGGift2 ON IL.CONSTITUENTSYSTEMID = AGGift2.CONSTITUENTSYSTEMID

															WHERE
																	GCS.College IN 
																				(
																					  'CAS'
																					, 'CEAT' 
																					, 'COHS', 'EHA', 'CEHS'	
																					, 'CVHS', 'CVM'
																					, 'DASNR'
																					, 'General University' 																																		
																					, 'OSU-CHS'
																					, 'OSUIT'
																					, 'OSU-OKC'
																					, 'OSU-Tulsa'
																					, 'SSB'																																										  
																					, 'GEN UNIV - Academic Affairs'
																					, 'GEN UNIV - Alumni Assn'
																					, 'Athletics'
																					, 'Student Affairs'
																				)
																AND DT.DPAGDonorTypeBucket = '4+ Year Lapsed'
																AND AGGift2.CONSTITUENTSYSTEMID IS NULL --excludes those with AG gift in last 19 years


															--[College Name] Nons
															--Highest College Fund Attribute Score, Non-Donor
															UNION ALL															
															
															SELECT 
															  GCS.CONSTITUENTSYSTEMID

															, CASE 
																	WHEN GCS.College =  'OSU-CHS'			     THEN 1270
																	WHEN GCS.College =  'OSU-Tulsa'			     THEN 1300
																	WHEN GCS.College =  'CAS'					 THEN 1340
																	WHEN GCS.College =  'CEAT'                   THEN 1350																	
																	WHEN GCS.College IN ('COHS', 'EHA', 'CEHS')	 THEN 1360
																	WHEN GCS.College IN ('CVHS', 'CVM')			 THEN 1370
																	WHEN GCS.College =  'DASNR'				     THEN 1380
																	WHEN GCS.College =  'OSUIT'				     THEN 1390
																	WHEN GCS.College =  'OSU-OKC'			     THEN 1400																	
																	WHEN GCS.College =  'General University'     THEN 1410														
																	WHEN GCS.College =  'SSB'				     THEN 1420
																END AS SegmentPriority

															, CONCAT(CASE 
																	WHEN GCS.College =  'OSU-CHS'			     THEN 'OSU-CHS'																	
																	WHEN GCS.College =  'OSU-Tulsa'			     THEN 'OSU-Tulsa'		
																	WHEN GCS.College =	'CAS'				     THEN 'CAS'
																	WHEN GCS.College =  'CEAT'                   THEN 'CEAT'
																	WHEN GCS.College IN ('COHS', 'EHA', 'CEHS')	 THEN 'CEHS'
																	WHEN GCS.College IN ('CVHS', 'CVM')			 THEN 'CVM'
																	WHEN GCS.College =  'DASNR'				     THEN 'DASNR'
																	WHEN GCS.College =  'OSUIT'				     THEN 'OSU-IT'
																	WHEN GCS.College =  'OSU-OKC'			     THEN 'OSU-OKC'
																	WHEN GCS.College =  'General University'     THEN 'General University'																	
																	WHEN GCS.College =  'SSB'				     THEN 'SSB'																																																		
																END , ' Nons') AS SegmentName

															FROM
															  tmp_GivingCollegeScore AS GCS
																						INNER JOIN "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL ON GCS.CONSTITUENTSYSTEMID = IL.CONSTITUENTSYSTEMID
																						INNER JOIN tmp_AGDonorTypeCurrentFY AS DT ON GCS.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID


															WHERE
																	GCS.College IN 
																				(
																					  'CAS'
																					, 'CEAT' 
																					, 'COHS', 'EHA', 'CEHS' 	
																					, 'CVHS', 'CVM'
																					, 'DASNR'
																					, 'General University' 																																		
																					, 'OSU-CHS'
																					, 'OSUIT'
																					, 'OSU-OKC'
																					, 'OSU-Tulsa'
																					, 'SSB'	
																				)
																AND DT.DPAGDonorTypeBucket = 'Non-Donor'

														  UNION
														  --Academic Affairs Nons, Giving History to Fund w/College Attribute of 'GEN UNIV - Academic Affairs'
														  SELECT
														      IL.CONSTITUENTSYSTEMID
															, 1310 AS SegmentPriority
															, 'Academic Affairs Nons' SegmentName

														   FROM
														      "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL 	

															                                INNER JOIN tmp_AGDonorTypeCurrentFY DT ON IL.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID

																							--Giving History to Fund w/College Attribute of 'GEN UNIV - Academic Affairs'
																							INNER JOIN
																												(
																													SELECT DISTINCT
																													   CONSTITUENTSYSTEMID

																													FROM 
																													  "OSUADV_PROD"."BI"."OSUF_COMPREHENSIVE_PRODUCTION_AND_RECEIPTS"

																													WHERE 
																														(
																															  (DATASOURCE = 'Development' AND MEASURE = 'Production')
																															OR DATASOURCE IN ('OSUAA Membership Dues', 'Recognition Credit')
																														)
																														 AND COLLEGE = 'GEN UNIV - Academic Affairs'
																														 AND CGPRAMOUNT > 0
																														 
																														 GROUP BY CONSTITUENTSYSTEMID

																												)  AS OSUAA ON IL.CONSTITUENTSYSTEMID = OSUAA.CONSTITUENTSYSTEMID

															WHERE
														      DT.DPAGDonorTypeBucket = 'Non-Donor'

														  UNION
														  --Academic Affairs Nons, most recent college of Graduate College
														  SELECT
														      IL.CONSTITUENTSYSTEMID
															, 1310 AS SegmentPriority
															, 'Academic Affairs Nons' SegmentName

														   FROM
														      "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL 	

															                                INNER JOIN tmp_AGDonorTypeCurrentFY DT ON IL.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID

																							--LAST (most recent) Degree College of Graduate College
																							INNER JOIN
																												(
																													SELECT DISTINCT
																													   CONSTITUENTSYSTEMID

																													FROM 
																													  tmp_EducationMaxYear

																													WHERE
																														SchoolType = 'Graduate College'

																												)  AS GradCol ON IL.CONSTITUENTSYSTEMID = GradCol.CONSTITUENTSYSTEMID

															WHERE
														      DT.DPAGDonorTypeBucket = 'Non-Donor'
                                                          
														  UNION ALL
														  --Student Affairs Nons
														  SELECT
														      IL.CONSTITUENTSYSTEMID
															, 1320 AS SegmentPriority
															, 'Student Affairs Nons' SegmentName

														  FROM
														      "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL 

																									INNER JOIN tmp_AGDonorTypeCurrentFY DT ON IL.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID

																									--Giving History to any fund w/College Attribute of 'Student Affairs'
																									INNER JOIN
																												(
																													SELECT DISTINCT
																													   CONSTITUENTSYSTEMID

																													FROM 
																													  "OSUADV_PROD"."BI"."OSUF_COMPREHENSIVE_PRODUCTION_AND_RECEIPTS" 

																													WHERE
																													    (
																															  (DATASOURCE = 'Development' AND MEASURE = 'Production')
																															OR DATASOURCE IN ('OSUAA Membership Dues', 'Recognition Credit')
																														)
																														 AND COLLEGE = 'Student Affairs'
																														 AND CGPRAMOUNT > 0

																														 GROUP BY CONSTITUENTSYSTEMID

																												 )  AS Athletics ON IL.CONSTITUENTSYSTEMID = Athletics.CONSTITUENTSYSTEMID

														   WHERE
														      DT.DPAGDonorTypeBucket = 'Non-Donor' 
															   
														  UNION ALL
														  --Athletics Nons
														  SELECT
														      IL.CONSTITUENTSYSTEMID
															, 1400 AS SegmentPriority
															, 'Athletics Nons' SegmentName

														  FROM
														      "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL 

														                                            INNER JOIN tmp_AGDonorTypeCurrentFY DT ON IL.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID

																								    --Giving History to any fund w/College Attribute of 'Athletics'
																									INNER JOIN
																												(
																													SELECT DISTINCT
																													   CONSTITUENTSYSTEMID

																													FROM 
																													  "OSUADV_PROD"."BI"."OSUF_COMPREHENSIVE_PRODUCTION_AND_RECEIPTS" 

																													WHERE
																													    (
																															  (DATASOURCE = 'Development' AND MEASURE = 'Production')
																															OR DATASOURCE IN ('OSUAA Membership Dues', 'Recognition Credit')
																														)
																														 AND COLLEGE = 'Athletics'
																														 AND CGPRAMOUNT > 0

																														 GROUP BY CONSTITUENTSYSTEMID

																												 )  AS Athletics ON IL.CONSTITUENTSYSTEMID = Athletics.CONSTITUENTSYSTEMID

														   WHERE
														      DT.DPAGDonorTypeBucket = 'Non-Donor'
                                                          
                                                          UNION ALL
														  --Alumni Association Nons
														  SELECT
														      IL.CONSTITUENTSYSTEMID
															, 1430 AS SegmentPriority
															, 'Alumni Association Nons' SegmentName

														   FROM
														      "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst"AS IL 	

															                                INNER JOIN tmp_AGDonorTypeCurrentFY DT ON IL.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID

																							--Giving History to Fund w/College Attribute of 'GEN UNIV - Alumni Assn', 'Lifetime Dues', or 'Annual Dues'
																							INNER JOIN
																												(
																													SELECT DISTINCT
																													   CONSTITUENTSYSTEMID

																													FROM 
																													  "OSUADV_PROD"."BI"."OSUF_COMPREHENSIVE_PRODUCTION_AND_RECEIPTS" 

																													WHERE 
																														(
																															  (DATASOURCE = 'Development' AND MEASURE = 'Production')
																															OR DATASOURCE IN ('OSUAA Membership Dues', 'Recognition Credit')
																														)
																														 AND COLLEGE IN ('GEN UNIV - Alumni Assn','Annual Dues', 'Lifetime Dues')
																														 AND CGPRAMOUNT > 0
																														 
																														 GROUP BY CONSTITUENTSYSTEMID
																												)  AS OSUAA ON IL.CONSTITUENTSYSTEMID = OSUAA.CONSTITUENTSYSTEMID

															WHERE
														      DT.DPAGDonorTypeBucket = 'Non-Donor'

														   UNION ALL	
															
															SELECT
															  IL.CONSTITUENTSYSTEMID
															, 1450 AS SegmentPriority
															, 'Non-Donors'
															
															FROM
															  "OSUADV_PROD"."BI"."DNRCNCT_InclLst_minus_ExclLst" AS IL

																						INNER JOIN tmp_AGDonorTypeCurrentFY AS DT ON IL.CONSTITUENTSYSTEMID = DT.CONSTITUENTSYSTEMID
															WHERE
															  DT.DPAGDonorTypeBucket = 'Non-Donor'																		 																																													 
																
													
													) AS QL1--End of QL1

												) AS QL2-- End of QL2

										 WHERE
										    QL2.Seq=1
															 
										) AS SegmentData ON IL.CONSTITUENTSYSTEMID = SegmentData.CONSTITUENTSYSTEMID

