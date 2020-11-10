
SELECT
    '0128A000001QqNKQA0'                                                AS RecordTypeID --QA
    ,'Process'                                                          AS InterimStatus
	,S_LAST_NAME 														AS LastName
	,S_FIRST_NAME 														AS FirstName
	,COALESCE(S_MIDDLE_NAME, '')										AS MiddleName
	,COALESCE(S_SUFFIX, '')												AS Suffix
	--,CAST(CONCAT(LEFT(CAST(S_BIRTH_DATE AS CHAR(8)), 4), '-', RIGHT(LEFT(CAST(S_BIRTH_DATE AS CHAR(8)), 6), 2), '-', RIGHT(CAST(S_BIRTH_DATE AS CHAR(8)), 2)) AS VARCHAR(20))
	,CONCAT(LEFT(S_BIRTH_DATE,4), '-', RIGHT(LEFT(S_BIRTH_DATE,6), 2), '-', RIGHT(S_BIRTH_DATE,2)) 	AS BirthDate
    ,COALESCE(S_ID, '')													AS SSN
	,S_CWID 															AS CWID
	,COALESCE(S_SEX, '')												AS Sex
	,COALESCE(S_ETHNIC_ORIGIN, '')										AS EthnicOrigin
	,COALESCE(S_ETHNIC_ORIGIN_DESC, '')									AS EthnicOriginDesc
	,COALESCE(S_MARITAL_STAT, '')										AS MaritalStatus
    ,CASE
		WHEN RIGHT(S_FIRST_ENTRY_TERM, 1) = 2		THEN	CONCAT(LEFT(S_FIRST_ENTRY_TERM, 4), '-01-01')					
		WHEN RIGHT(S_FIRST_ENTRY_TERM, 1) = 4		THEN	CONCAT(LEFT(S_FIRST_ENTRY_TERM, 4), '-05-01')	
		WHEN RIGHT(S_FIRST_ENTRY_TERM, 1) = 6		THEN	CONCAT(LEFT(S_FIRST_ENTRY_TERM, 4), '-08-01')

		END																AS EnrollDate
    ,CASE
		WHEN RIGHT(S_FIRST_ENTRY_TERM, 1) = 2		THEN	CONCAT(LEFT(S_FIRST_ENTRY_TERM, 4), '-01-01')					
		WHEN RIGHT(S_FIRST_ENTRY_TERM, 1) = 4		THEN	CONCAT(LEFT(S_FIRST_ENTRY_TERM, 4), '-05-01')	
		WHEN RIGHT(S_FIRST_ENTRY_TERM, 1) = 6		THEN	CONCAT(LEFT(S_FIRST_ENTRY_TERM, 4), '-08-01')

		END																AS EnrollTerm
	,CASE
		WHEN RIGHT(S_GRAD_TERM, 1) = 2		THEN	CONCAT(LEFT(S_GRAD_TERM, 4), '-01-01')				
		WHEN RIGHT(S_GRAD_TERM, 1) = 4		THEN	CONCAT(LEFT(S_GRAD_TERM, 4), '-05-01')	
		WHEN RIGHT(S_GRAD_TERM, 1) = 6		THEN	CONCAT(LEFT(S_GRAD_TERM, 4), '-08-01')

		END																AS GradDate
	,CASE
		WHEN RIGHT(S_GRAD_TERM, 1) = 2		THEN	CONCAT(LEFT(S_GRAD_TERM, 4), '-01-01')				
		WHEN RIGHT(S_GRAD_TERM, 1) = 4		THEN	CONCAT(LEFT(S_GRAD_TERM, 4), '-05-01')	
		WHEN RIGHT(S_GRAD_TERM, 1) = 6		THEN	CONCAT(LEFT(S_GRAD_TERM, 4), '-08-01')

		END																AS GradTerm
	,'IT'																AS College
	,'OSU - Institute of Technology'									AS CollegeDesc

	--,S_COLLEGE															AS College
	--,S_COLLEGE_DESC														AS CollegeDesc

	,S_DEGREE															AS Degree
	,S_DEGREE_DESC														AS DegreeDesc
	,S_MAJOR_1															AS Major1
	,S_MAJOR_1_DESC														AS Major1Desc
	,COALESCE(S_MAJOR_CONC_1, '')										AS MajorConc1
	,COALESCE(REPLACE(S_MAJOR_CONC_1_DESC, 'NO OPTION', ''), '')		AS MajorConc1Desc
	,CASE
		WHEN S_COLLEGE_DESC = 'School of Arts, Sci & Health'	THEN 'ARTSCI'
		WHEN S_COLLEGE_DESC = 'School of Arts & Sciences'		THEN 'ARTSCI'
		WHEN S_COLLEGE_DESC = 'School of Automotive Tech'		THEN 'AUTO'
		WHEN S_COLLEGE_DESC = 'School of Construction Tech'		THEN 'CONSTECH'
		WHEN S_COLLEGE_DESC = 'Divn of Construction Tech'		THEN 'CONSTECH'
		WHEN S_COLLEGE_DESC = 'School of Culinary Arts'			THEN 'CULART'
		WHEN S_COLLEGE_DESC = 'School of Energy Technologies'	THEN 'ENERTECH'
		WHEN S_COLLEGE_DESC = 'School of Const & Engr Tech'		THEN 'CONSTECH'
		WHEN S_COLLEGE_DESC = 'School of Engineering Tech'		THEN 'ENGTECH'
		WHEN S_COLLEGE_DESC = 'Divn of Engineering Tech'		THEN 'ENGTECH'
		WHEN S_COLLEGE_DESC = 'Division of HEVi Technologies'	THEN 'HEVI'
		WHEN S_COLLEGE_DESC = 'School of Creative & Info Tech'	THEN 'IT'
		WHEN S_COLLEGE_DESC = 'School of Information Tech'		THEN 'IT'
		WHEN S_COLLEGE_DESC = 'School of Nursing & Health Sci'	THEN 'NURSE'
		WHEN S_COLLEGE_DESC = 'Sch of Visual Communications '	THEN 'VISCOMM'  
		END																AS MajorOrganization1
	,CASE
		WHEN S_COLLEGE_DESC = 'School of Arts, Sci & Health'	THEN '(IT) Arts & Science'
		WHEN S_COLLEGE_DESC = 'School of Arts & Sciences'		THEN '(IT) Arts & Science'
		WHEN S_COLLEGE_DESC = 'School of Automotive Tech'		THEN '(IT) Automotive'
		WHEN S_COLLEGE_DESC = 'School of Construction Tech'		THEN '(IT) Construction Technology'
		WHEN S_COLLEGE_DESC = 'Divn of Construction Tech'		THEN '(IT) Construction Technology'
		WHEN S_COLLEGE_DESC = 'School of Culinary Arts'			THEN '(IT) Culinary Arts'
		WHEN S_COLLEGE_DESC = 'School of Energy Technologies'	THEN '(IT) Energy Technologies'
		WHEN S_COLLEGE_DESC = 'School of Const & Engr Tech'		THEN '(IT) Construction Technology'
		WHEN S_COLLEGE_DESC = 'School of Engineering Tech'		THEN '(IT) Engineering Technology'
		WHEN S_COLLEGE_DESC = 'Divn of Engineering Tech'		THEN '(IT) Engineering Technology'
		WHEN S_COLLEGE_DESC = 'Division of HEVi Technologies'	THEN '(IT) HEVi'
		WHEN S_COLLEGE_DESC = 'School of Creative & Info Tech'	THEN '(IT) IT'
		WHEN S_COLLEGE_DESC = 'School of Information Tech'		THEN '(IT) IT'
		WHEN S_COLLEGE_DESC = 'School of Nursing & Health Sci'	THEN '(IT) Nursing & Health Science'
		WHEN S_COLLEGE_DESC = 'Sch of Visual Communications '	THEN '(IT) Visual Communications'
		END																AS MajorOrganization1Desc
        
	,COALESCE(S_MINOR_1, '')											AS Minor1
	,COALESCE(REPLACE(S_MINOR_1_DESC, 'UNSPECIFIED', ''), '')			AS Minor1Desc
	,COALESCE(S_MAJOR_2, '')											AS Major2
	,COALESCE(REPLACE(S_MAJOR_2_DESC, 'UNSPECIFIED', ''), '')			AS Major2Desc

	,COALESCE(S_MAJOR_CONC_2, '')										AS MajorConc2
	,COALESCE(REPLACE(S_MAJOR_CONC_2_DESC, 'NO OPTION', ''), '')		AS MajorConc2Desc

	,CASE
		WHEN S_COLLEGE_DESC = 'School of Arts, Sci & Health'	THEN 'ARTSCI'
		WHEN S_COLLEGE_DESC = 'School of Arts & Sciences'		THEN 'ARTSCI'
		WHEN S_COLLEGE_DESC = 'School of Automotive Tech'		THEN 'AUTO'
		WHEN S_COLLEGE_DESC = 'School of Construction Tech'		THEN 'CONSTECH'
		WHEN S_COLLEGE_DESC = 'Divn of Construction Tech'		THEN 'CONSTECH'
		WHEN S_COLLEGE_DESC = 'School of Culinary Arts'			THEN 'CULART'
		WHEN S_COLLEGE_DESC = 'School of Energy Technologies'	THEN 'ENERTECH'
		WHEN S_COLLEGE_DESC = 'School of Const & Engr Tech'		THEN 'CONSTECH'
		WHEN S_COLLEGE_DESC = 'School of Engineering Tech'		THEN 'ENGTECH'
		WHEN S_COLLEGE_DESC = 'Divn of Engineering Tech'		THEN 'ENGTECH'
		WHEN S_COLLEGE_DESC = 'Division of HEVi Technologies'	THEN 'HEVI'
		WHEN S_COLLEGE_DESC = 'School of Creative & Info Tech'	THEN 'IT'
		WHEN S_COLLEGE_DESC = 'School of Information Tech'		THEN 'IT'
		WHEN S_COLLEGE_DESC = 'School of Nursing & Health Sci'	THEN 'NURSE'
		WHEN S_COLLEGE_DESC = 'Sch of Visual Communications '	THEN 'VISCOMM'
		END																AS MajorOrganization2
	,CASE
		WHEN S_COLLEGE_DESC = 'School of Arts, Sci & Health'	THEN '(IT) Arts & Science'
		WHEN S_COLLEGE_DESC = 'School of Arts & Sciences'		THEN '(IT) Arts & Science'
		WHEN S_COLLEGE_DESC = 'School of Automotive Tech'		THEN '(IT) Automotive'
		WHEN S_COLLEGE_DESC = 'School of Construction Tech'		THEN '(IT) Construction Technology'
		WHEN S_COLLEGE_DESC = 'Divn of Construction Tech'		THEN '(IT) Construction Technology'
		WHEN S_COLLEGE_DESC = 'School of Culinary Arts'			THEN '(IT) Culinary Arts'
		WHEN S_COLLEGE_DESC = 'School of Energy Technologies'	THEN '(IT) Energy Technologies'
		WHEN S_COLLEGE_DESC = 'School of Const & Engr Tech'		THEN '(IT) Construction Technology'
		WHEN S_COLLEGE_DESC = 'School of Engineering Tech'		THEN '(IT) Engineering Technology'
		WHEN S_COLLEGE_DESC = 'Divn of Engineering Tech'		THEN '(IT) Engineering Technology'
		WHEN S_COLLEGE_DESC = 'Division of HEVi Technologies'	THEN '(IT) HEVi'
		WHEN S_COLLEGE_DESC = 'School of Creative & Info Tech'	THEN '(IT) IT'
		WHEN S_COLLEGE_DESC = 'School of Information Tech'		THEN '(IT) IT'
		WHEN S_COLLEGE_DESC = 'School of Nursing & Health Sci'	THEN '(IT) Nursing & Health Science'
		WHEN S_COLLEGE_DESC = 'Sch of Visual Communications '	THEN '(IT) Visual Communications'
		END																AS MajorOrganization2Desc

	,COALESCE(S_MINOR_2, '')											AS Minor2
	,REPLACE(S_MINOR_2_DESC, 'UNSPECIFIED', '')							AS Minor2Desc

	,COALESCE(S_HONORS_LIST, '')										AS HonorList
	,COALESCE(S_HONORS_LIST_DESC, '') 									AS HonorListDesc
	,COALESCE(S_DEGREE_HONORS, '') 										AS DegreeHonors
	,COALESCE(S_DEGREE_HONORS_DESC, '') 								AS DegreeHonorDesc
	,COALESCE(S_GRAD_SPCL_HONORS, '')									AS GradSpecialHonors
	,COALESCE(S_GRAD_SPCL_HONORS_DESC, '')								AS GradSpecialHonorsDesc
	,COALESCE(S_NOK_NAME, '')											AS NOKName
	,CASE	
		WHEN COALESCE(S_NOK_STREET1, '') = '' THEN ''
		ELSE 'Gradload Next of Kin'		
		END																AS NOKAddrestype
	,COALESCE(S_NOK_STREET1, '')										AS NOKStreet1
	,COALESCE(S_NOK_STREET2, '')										AS NOKStreet2
	,''																	AS NOKStreet3
	--,'' AS NOKStreet4
	,COALESCE(S_NOK_CITY, '')											AS NOKCity
	,COALESCE(S_NOK_STATE, '')											AS NOKState
	,COALESCE(S_NOK_ZIP5, '')											AS NOKZip5
	,COALESCE(S_NOK_ZIP4, '')											AS NOKZip4
	,''																	AS NOKCountry
	,CASE	
		WHEN COALESCE(S_NOK_PHONE, '') = '' THEN ''
		ELSE 'Personal Phone'	
		END																AS NOKPhoneType
	,COALESCE(S_NOK_PHONE, '')											AS NOKPhone
	,CASE 
		WHEN COALESCE(S_LOCAL_STREET_1, '') = '' THEN ''
		ELSE 'GradLoad Local'
		END																AS LocalAddresType
	,COALESCE(S_LOCAL_STREET_1, '')										AS LocalStreet1
	,COALESCE(S_LOCAL_STREET_2, '')										AS LocalStreet2
	,''																	AS LocalStreet3
	,''																	AS LocalStreet4
	--,'' AS LocalStreet5
	,COALESCE(S_LOCAL_CITY, '')											AS LocalCity
	,COALESCE(S_LOCAL_STATE, '')										AS LocalState
	,COALESCE(S_LOCAL_ZIP5, '')											AS LocalZip5
	,COALESCE(S_LOCAL_ZIP4, '')											AS LocalZip4
	,''																	AS LocalCountry
	,CASE
		WHEN COALESCE(S_LOCAL_PHONE, '') = '' THEN ''
		ELSE 'Personal Phone'
		END																AS LocalPhoneType
	,COALESCE(S_LOCAL_PHONE, '')										AS LocalPhone
	,CASE
		WHEN COALESCE(S_PERM_STREET_1, '') = '' THEN ''
		ELSE 'GradLoad Permanent'
		END																AS PermAddresType
	,COALESCE(S_PERM_STREET_1, '')										AS PermStreet1
	,COALESCE(S_PERM_STREET_2, '')										AS PermStreet2
	,''																	AS PermStreet3
	,''																	AS PermStreet4
	--,'' AS PermStreet5
	,COALESCE(S_PERM_CITY, '')											AS PermCity
	,COALESCE(S_PERM_STATE, '')											AS PermState
	,COALESCE(S_PERM_ZIP5, '')											AS PermZip5
	,COALESCE(S_PERM_ZIP4, '')											AS PermZip4
	,'' AS PermCountry
	,CASE
		WHEN COALESCE(S_PERM_PHONE, '') = '' THEN ''
		ELSE 'Personal Phone'
		END																AS PermPhoneType
	,COALESCE(S_PERM_PHONE, '')											AS PermPhone
	,CASE
		WHEN COALESCE(S_OSU_EMAIL, '') = '' THEN '' 
		ELSE 'Personal'
		END																AS OSUEmailType
	,COALESCE(S_OSU_EMAIL, '')											AS OSUEmail
	,COALESCE(S_ADV_NAME, '')											AS AdvName
	,CASE WHEN
		COALESCE(S_TULSA_FLAG, '') <> ''	THEN 1
		ELSE 0
		
		END																AS TulsaHours
	,'Oklahoma State University - Institute of Technology'				AS Campus

FROM
	"OSUF_INTERFACES"."FACULTY_STAFF"."GradLoad_OKM" t
    
where COALESCE(S_NOK_NAME, '') <> ''
