
USE OSUADV_PROD.BI;

/*Create Temporary Table of Valid Phon"OSUADV_PROD"."RE"."ACTION"es */
CREATE OR REPLACE TABLE temp_DnrCnct_Constituent_Dtl_Phones (  ConstituentPhoneSystemID INT
                                                  , ConstituentSystemID INT
                                                  , ConstituentID varchar(20)
                                                  , PhoneType VARCHAR(50)
                                                  , PhoneTypeSummary VARCHAR(20)
                                                  , PhoneNumber VARCHAR(20)
                                                  , PhoneDateChangedDimID INT
                                                  , isSpousePhone INT
                                                 );
/*Add Constituent Phone Numbers to temp_DnrCnct_Constituent_Dtl_Phones */                                                 
Insert Into temp_DnrCnct_Constituent_Dtl_Phones
Select 
  P.ConstituentPhoneSystemID
, P.ConstituentSystemID
, C.ConstituentID
, P.PhoneType
, P.PhoneTypeSummary
, LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(IFF(RegExp_Instr(P.PhoneNumber, 'Ext')>0, Left(P.PhoneNumber, RegExp_Instr(P.PhoneNumber, 'Ext')-1), P.PhoneNumber), ' ', ''), '(', ''), ')', ''), '-', ''), '.', ''), '+', ''), CHAR(9), ''), CHAR(10), ''), CHAR(11), ''), CHAR(12), ''), CHAR(13), ''))) AS PhoneNumber
, P.PhoneDateChangedDimID
, 0 AS isSpousePhone
From OSUADV_PROD.RE.CONSTITUENT_DTL_PHONES p
        INNER JOIN OSUADV_PROD.RE.CONSTITUENT C ON p.ConstituentSystemID = C.ConstituentSystemID
Where P.IsInactive='No'
  And P.PhoneTypeSummary='Telephone Number'
  AND P.PhoneType NOT LIKE 'Business%'

  -- Unwanted Phone Numbers
  AND P.PhoneNumber NOT LIKE  '%@%'
  AND P.PhoneNumber NOT LIKE '%00000000%'
  AND P.PhoneNumber NOT LIKE '%Print%'
  AND P.PhoneNumber NOT LIKE '%www%'
  AND P.PhoneNumber NOT LIKE '%http%'
  AND P.PhoneNumber NOT LIKE '%.com%';
  
/*Add Constituent Spouse Phone Numbers to temp_DnrCnct_Constituent_Dtl_Phones */                                                 
Insert Into temp_DnrCnct_Constituent_Dtl_Phones
Select 
  P.ConstituentPhoneSystemID
, S.ConstituentSystemID
, S.ConstituentID
, P.PhoneType
, P.PhoneTypeSummary
, LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(IFF(RegExp_Instr(P.PhoneNumber, 'Ext')>0, Left(P.PhoneNumber, RegExp_Instr(P.PhoneNumber, 'Ext')-1), P.PhoneNumber), ' ', ''), '(', ''), ')', ''), '-', ''), '.', ''), '+', ''), CHAR(9), ''), CHAR(10), ''), CHAR(11), ''), CHAR(12), ''), CHAR(13), ''))) AS PhoneNumber
, P.PhoneDateChangedDimID
, 1 AS isSpousePhone
From OSUADV_PROD.RE.CONSTITUENT_DTL_PHONES P Inner Join OSUADV_PROD.RE.CONSTITUENT S ON P.ConstituentSystemID=S.SpouseConstituentSystemID
Where P.IsInactive='No'
  And P.PhoneTypeSummary='Telephone Number'
  AND P.PhoneType NOT LIKE 'Business%'

  -- Unwanted Phone Numbers
  AND P.PhoneNumber NOT LIKE  '%@%'
  AND P.PhoneNumber NOT LIKE '%00000000%'
  AND P.PhoneNumber NOT LIKE '%Print%'
  AND P.PhoneNumber NOT LIKE '%www%'
  AND P.PhoneNumber NOT LIKE '%http%'
  AND P.PhoneNumber NOT LIKE '%.com%'
  ;  



/*Create table for final list of Phones */
CREATE OR REPLACE TABLE "DNRCNCT_Phones" (  ConstituentID varchar(20)
                                                  , PhoneNumber varchar(20)
                                                  , PhoneType varchar(50)
                                                  , isCellularYN varchar(3)
                                                  , preferredYN varchar(3)
                                                 );
/*Get Home Phone */
CREATE OR REPLACE TEMPORARY TABLE tmpPriorityTypePhone (  ConstituentSystemID INT
                                                        , PhoneNumber Varchar(20)
                                                        , PhoneType VArchar(50)
                                                        , PhoneDateChangedDimID INT
                                                        , TypeSeq INT
                                                        , DateSeq INT
                                                       );
                                                       
Insert Into tmpPriorityTypePhone
Select
  ConstituentSystemID
, IFF(RegExp_Instr(PhoneNumber, 'Ext')>0, Left(PhoneNumber, RegExp_Instr(PhoneNumber, 'Ext')-1), PhoneNumber) AS PhoneNumber  //Remove Extension
, PhoneType
, PhoneDateChangedDimID
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by CASE PhoneType
                                                                                 WHEN 'Personal Landline Phone' THEN 10
                                                                                 WHEN 'AlumniFinder Landline Phone' THEN 20
                                                                                 WHEN 'AlumniFinder Phone' THEN 30
                                                                                 WHEN 'AlumniSync Phone' THEN 40
                                                                                 WHEN 'PhoneFinder Phone' THEN 50
                                                                                 WHEN 'GradLoad Phone' THEN 60
                                                                                 WHEN 'StudentLoad Phone' THEN 70
                                                                             END
                                                                             Asc) AS TypeSeq
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by   PhoneDateChangedDimID Desc
                                                                            , CASE PhoneType
                                                                                   WHEN 'Personal Landline Phone' THEN 10
                                                                                   WHEN 'AlumniFinder Landline Phone' THEN 20
                                                                                   WHEN 'AlumniFinder Phone' THEN 30
                                                                                   WHEN 'AlumniSync Phone' THEN 40
                                                                                   WHEN 'PhoneFinder Phone' THEN 50
                                                                                   WHEN 'GradLoad Phone' THEN 60
                                                                                   WHEN 'StudentLoad Phone' THEN 70
                                                                              END
                                                                              Asc) AS DateSeq
From (
       Select
         P.ConstituentSystemID
       , P.PhoneType
       , LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(P.PhoneNumber, ' ', ''), '(', ''), ')', ''), '-', ''), '.', ''), '+', ''), CHAR(9), ''), CHAR(10), ''), CHAR(11), ''), CHAR(12), ''), CHAR(13), '')))  AS PhoneNumber
       , P.PhoneDateChangedDimID
       From temp_DnrCnct_Constituent_Dtl_Phones P
       Where P.PhoneType In('Personal Landline Phone', 'AlumniFinder Landline Phone','AlumniFinder Phone', 'AlumniSync Phone', 'PhoneFinder Phone', 'GradLoad Phone', 'StudentLoad Phone')
         And isSpousePhone=0
     ) Q;
 

Insert Into "DNRCNCT_Phones"
Select 
  C.ConstituentID
, CASE WHEN Opt1.ConstituentSystemID Is Not Null THEN Opt1.PhoneNumber
       WHEN Opt2.ConstituentSystemID Is Not Null THEN Opt2.PhoneNumber
       WHEN Opt3.ConstituentSystemID Is Not Null THEN Opt3.PhoneNumber
       WHEN Opt4.ConstituentSystemID Is Not Null THEN Opt4.PhoneNumber
       WHEN Opt5.ConstituentSystemID Is Not Null THEN Opt5.PhoneNumber
       WHEN Opt6.ConstituentSystemID Is Not Null THEN Opt6.PhoneNumber
       ELSE NULL
  END AS PhoneNumber
, 'HomePhone' AS PhoneType    
, '' AS isCellularYN
, '' AS preferredYN
From tmpPriorityTypePhone Ph Inner Join OSUADV_PROD.RE.Constituent C ON Ph.ConstituentSystemID = C.ConstituentSystemID
                             
                             Left Outer Join OSUADV_PROD.BI.DnrCnct_PriorityAxnPhone Opt1 ON     Ph.ConstituentSystemID=Opt1.ConstituentSystemID
                                                                                             And Ph.PhoneNumber=Opt1.PhoneNumber
                                                                                             And Ph.TypeSeq=1
                             Left Outer Join tmpPriorityTypePhone Opt2 ON     Ph.ConstituentSystemID=Opt2.ConstituentSystemID
                                                                          And Ph.PhoneType=Opt2.PhoneType
                                                                          And Ph.PhoneType='Personal Landline Phone'
                             Left Outer Join tmpPriorityTypePhone Opt3 ON     Ph.ConstituentSystemID=Opt3.ConstituentSystemID
                                                                          And Ph.Phonetype=Opt3.PhoneType
                                                                          And Ph.Phonetype In('AlumniFinder Landline Phone','AlumniFinder Phone', 'AlumniSync Phone', 'PhoneFinder Phone')
                                                                          And Opt3.DateSeq=1
                             Left Outer Join tmpPriorityTypePhone Opt4 ON     Ph.ConstituentSystemID=Opt4.ConstituentSystemID
                                                                          And Ph.PhoneType=Opt4.PhoneType
                                                                          And Ph.PhoneType='GradLoad Phone'
                             Left Outer Join tmpPriorityTypePhone Opt5 ON     Ph.ConstituentSystemID=Opt5.ConstituentSystemID
                                                                          And Ph.PhoneType=Opt5.PhoneType
                                                                          And Ph.PhoneType='StudentLoad Phone'
                             Left Outer Join tmpPriorityTypePhone Opt6 ON     Ph.ConstituentSystemID=Opt6.ConstituentSystemID
                                                                          And Ph.PhoneType=Opt6.PhoneType
                                                                          And Ph.PhoneType='ParentLoad Phone'
Where (   Opt1.ConstituentSystemID Is Not Null
       OR Opt2.ConstituentSystemID Is Not Null 
       OR Opt3.ConstituentSystemID Is Not Null
       OR Opt4.ConstituentSystemID Is Not Null
       OR Opt5.ConstituentSystemID Is Not Null
       OR Opt6.ConstituentSystemID Is Not Null
      )
Qualify ROW_NUMBER() OVER(PARTITION BY Ph.ConstituentSystemID ORDER BY CASE WHEN Opt1.ConstituentSystemID Is Not Null THEN 1
                                                                            WHEN Opt2.ConstituentSystemID Is Not Null THEN 2
                                                                            WHEN Opt3.ConstituentSystemID Is Not Null THEN 3
                                                                            WHEN Opt4.ConstituentSystemID Is Not Null THEN 4
                                                                            WHEN Opt5.ConstituentSystemID Is Not Null THEN 5
                                                                            WHEN Opt6.ConstituentSystemID Is Not Null THEN 6
                                                                            ELSE 100
                                                                        END
                                                                        Asc) = 1;



/* Remove values in DNRCNCT_Phones from temp_DnrCnct_Constituent_Dtl_Phones to prevent duplicate values */
Delete 
From temp_DnrCnct_Constituent_Dtl_Phones DCPh 
Using "DNRCNCT_Phones" Final 
Where DCPh.ConstituentID=Final.ConstituentID
  And DCPh.PhoneNumber=Final.PhoneNumber
  /*And DCPh.isSpousePhone=0*/;




/*Get Cell Phone */
CREATE OR REPLACE TEMPORARY TABLE tmpPriorityTypePhone_Cell (  ConstituentSystemID INT
                                                             , PhoneNumber Varchar(20)
                                                             , PhoneType VArchar(50)
                                                             , PhoneDateChangedDimID INT
                                                             , TypeSeq INT
                                                             , DateSeq INT
                                                            );
                                                       
Insert Into tmpPriorityTypePhone_Cell
Select
  ConstituentSystemID
, IFF(RegExp_Instr(PhoneNumber, 'Ext')>0, Left(PhoneNumber, RegExp_Instr(PhoneNumber, 'Ext')-1), PhoneNumber) AS PhoneNumber  //Remove Extension
, PhoneType
, PhoneDateChangedDimID
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by CASE PhoneType
                                                                                 WHEN 'Personal Cell Phone' THEN 10
                                                                                 WHEN 'AlumniFinder Cell Phone' THEN 20
                                                                                 WHEN 'AlumniSync Cell Phone' THEN 30
                                                                                 WHEN 'StudentLoad Cell Phone' THEN 40
                                                                             END
                                                                             Asc) AS TypeSeq
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by   PhoneDateChangedDimID Desc
                                                                            , CASE PhoneType
                                                                                   WHEN 'Personal Cell Phone' THEN 10
                                                                                   WHEN 'AlumniFinder Cell Phone' THEN 20
                                                                                   WHEN 'AlumniSync Cell Phone' THEN 30
                                                                                   WHEN 'StudentLoad Cell Phone' THEN 40
                                                                               END
                                                                              Asc) AS DateSeq
From (
       Select
         P.ConstituentSystemID
       , P.PhoneType
       , LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(P.PhoneNumber, ' ', ''), '(', ''), ')', ''), '-', ''), '.', ''), '+', ''), CHAR(9), ''), CHAR(10), ''), CHAR(11), ''), CHAR(12), ''), CHAR(13), '')))  AS PhoneNumber
       , P.PhoneDateChangedDimID
       From temp_DnrCnct_Constituent_Dtl_Phones P
       Where P.PhoneType In('Personal Cell Phone', 'AlumniFinder Cell Phone','AlumniSync Cell Phone', 'StudentLoad Cell Phone')
         And isSpousePhone=0
     ) Q;
 
Insert Into "DNRCNCT_Phones"
Select 
  C.ConstituentID
, CASE WHEN Opt1.ConstituentSystemID Is Not Null THEN Opt1.PhoneNumber
       WHEN Opt2.ConstituentSystemID Is Not Null THEN Opt2.PhoneNumber
       WHEN Opt3.ConstituentSystemID Is Not Null THEN Opt3.PhoneNumber
       WHEN Opt5.ConstituentSystemID Is Not Null THEN Opt5.PhoneNumber
       WHEN Opt6.ConstituentSystemID Is Not Null THEN Opt6.PhoneNumber
       ELSE NULL
  END AS PhoneNumber
, 'CellPhone' AS PhoneType    
, '' AS isCellularYN
, '' AS preferredYN
From tmpPriorityTypePhone_Cell Ph Inner Join OSUADV_PROD.RE.Constituent C ON Ph.ConstituentSystemID = C.ConstituentSystemID
                                  
                                  Left Outer Join OSUADV_PROD.BI.DnrCnct_PriorityAxnPhone Opt1 ON     Ph.ConstituentSystemID=Opt1.ConstituentSystemID
                                                                                                  And Ph.PhoneNumber=Opt1.PhoneNumber
                                                                                                  And Ph.TypeSeq=1
                                  Left Outer Join tmpPriorityTypePhone_Cell Opt2 ON     Ph.ConstituentSystemID=Opt2.ConstituentSystemID
                                                                                    And Ph.PhoneType=Opt2.PhoneType
                                                                                    And Ph.PhoneType='Personal Cell Phone'
                                  Left Outer Join tmpPriorityTypePhone_Cell Opt3 ON     Ph.ConstituentSystemID=Opt3.ConstituentSystemID
                                                                                    And Ph.Phonetype=Opt3.PhoneType
                                                                                    And Ph.Phonetype In('AlumniFinder Cell Phone','AlumniSync Cell Phone')
                                                                                    And Opt3.DateSeq=1
                                  Left Outer Join tmpPriorityTypePhone_Cell Opt5 ON     Ph.ConstituentSystemID=Opt5.ConstituentSystemID
                                                                                    And Ph.PhoneType=Opt5.PhoneType
                                                                                    And Ph.PhoneType='StudentLoad Cell Phone'
                                  Left Outer Join tmpPriorityTypePhone_Cell Opt6 ON     Ph.ConstituentSystemID=Opt6.ConstituentSystemID
                                                                                    And Ph.PhoneType=Opt6.PhoneType
                                                                                    And Ph.PhoneType='ParentLoad Phone'
Where (   Opt1.ConstituentSystemID Is Not Null
       OR Opt2.ConstituentSystemID Is Not Null 
       OR Opt3.ConstituentSystemID Is Not Null
       OR Opt5.ConstituentSystemID Is Not Null
       OR Opt6.ConstituentSystemID Is Not Null
      )
Qualify ROW_NUMBER() OVER(PARTITION BY Ph.ConstituentSystemID ORDER BY CASE WHEN Opt1.ConstituentSystemID Is Not Null THEN 1
                                                                            WHEN Opt2.ConstituentSystemID Is Not Null THEN 2
                                                                            WHEN Opt3.ConstituentSystemID Is Not Null THEN 3
                                                                            WHEN Opt5.ConstituentSystemID Is Not Null THEN 5
                                                                            WHEN Opt6.ConstituentSystemID Is Not Null THEN 6
                                                                            ELSE 100
                                                                        END
                                                                        Asc) = 1;


/* Remove values in DNRCNCT_Phones from temp_DnrCnct_Constituent_Dtl_Phones to prevent duplicate values */
Delete 
From temp_DnrCnct_Constituent_Dtl_Phones DCPh 
Using "DNRCNCT_Phones" Final 
Where DCPh.ConstituentID=Final.ConstituentID
  And DCPh.PhoneNumber=Final.PhoneNumber
  /*And DCPh.isSpousePhone=0*/;





/*Get Spouse Phone */
CREATE OR REPLACE TEMPORARY TABLE tmpPriorityTypePhone_SpouseCell (  ConstituentSystemID INT
                                                                   , SpouseConstituentSystemID INT
                                                                   , PhoneNumber Varchar(20)
                                                                   , PhoneType VArchar(50)
                                                                   , PhoneDateChangedDimID INT
                                                                   , TypeSeq INT
                                                                   , DateSeq INT
                                                              );
                                                       
Insert Into tmpPriorityTypePhone_SpouseCell
Select
  ConstituentSystemID
, SpouseConstituentSystemID
, IFF(RegExp_Instr(PhoneNumber, 'Ext')>0, Left(PhoneNumber, RegExp_Instr(PhoneNumber, 'Ext')-1), PhoneNumber) AS PhoneNumber  //Remove Extension
, PhoneType
, PhoneDateChangedDimID
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by CASE PhoneType
                                                                                 WHEN 'Personal Cell Phone' THEN 10
                                                                                 WHEN 'AlumniFinder Cell Phone' THEN 20
                                                                                 WHEN 'AlumniSync Cell Phone' THEN 30
                                                                                 WHEN 'StudentLoad Cell Phone' THEN 40
                                                                             END
                                                                             Asc) AS TypeSeq
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by   PhoneDateChangedDimID Desc
                                                                            , CASE PhoneType
                                                                                   WHEN 'Personal Cell Phone' THEN 10
                                                                                   WHEN 'AlumniFinder Cell Phone' THEN 20
                                                                                   WHEN 'AlumniSync Cell Phone' THEN 30
                                                                                   WHEN 'StudentLoad Cell Phone' THEN 40
                                                                               END
                                                                              Asc) AS DateSeq
From (
       Select
         P.ConstituentSystemID
       , Sp.ConstituentSystemID AS SpouseConstituentSystemID
       , P.PhoneType
       , LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(P.PhoneNumber, ' ', ''), '(', ''), ')', ''), '-', ''), '.', ''), '+', ''), CHAR(9), ''), CHAR(10), ''), CHAR(11), ''), CHAR(12), ''), CHAR(13), '')))  AS PhoneNumber
       , P.PhoneDateChangedDimID
       From temp_DnrCnct_Constituent_Dtl_Phones P Inner Join OSUADV_PROD.RE.Constituent Sp ON P.ConstituentSystemID=Sp.SpouseConstituentSystemID
       Where P.PhoneType In('Personal Cell Phone', 'AlumniFinder Cell Phone','AlumniSync Cell Phone', 'StudentLoad Cell Phone')
         And P.isSpousePhone=1
     ) Q;
     
     
CREATE OR REPLACE TEMPORARY TABLE tmpPriorityTypePhone_SpouseHome (   ConstituentSystemID INT
                                                                    , SpouseConstituentSystemID INT
                                                                    , PhoneNumber Varchar(20)
                                                                    , PhoneType VArchar(50)
                                                                    , PhoneDateChangedDimID INT
                                                                    , TypeSeq INT
                                                                    , DateSeq INT
                                                                   );
                                                       
Insert Into tmpPriorityTypePhone_SpouseHome
Select
  ConstituentSystemID
, SpouseConstituentSystemID
, IFF(RegExp_Instr(PhoneNumber, 'Ext')>0, Left(PhoneNumber, RegExp_Instr(PhoneNumber, 'Ext')-1), PhoneNumber) AS PhoneNumber  //Remove Extension
, PhoneType
, PhoneDateChangedDimID
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by CASE PhoneType
                                                                                 WHEN 'Personal Landline Phone' THEN 10
                                                                                 WHEN 'AlumniFinder Landline Phone' THEN 20
                                                                                 WHEN 'AlumniFinder Phone' THEN 30
                                                                                 WHEN 'AlumniSync Phone' THEN 40
                                                                                 WHEN 'PhoneFinder Phone' THEN 50
                                                                                 WHEN 'GradLoad Phone' THEN 60
                                                                                 WHEN 'StudentLoad Phone' THEN 70
                                                                             END
                                                                             Asc) AS TypeSeq
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by   PhoneDateChangedDimID Desc
                                                                            , CASE PhoneType
                                                                                   WHEN 'Personal Landline Phone' THEN 10
                                                                                   WHEN 'AlumniFinder Landline Phone' THEN 20
                                                                                   WHEN 'AlumniFinder Phone' THEN 30
                                                                                   WHEN 'AlumniSync Phone' THEN 40
                                                                                   WHEN 'PhoneFinder Phone' THEN 50
                                                                                   WHEN 'GradLoad Phone' THEN 60
                                                                                   WHEN 'StudentLoad Phone' THEN 70
                                                                              END
                                                                              Asc) AS DateSeq
From (
       Select
         P.ConstituentSystemID
       , Sp.ConstituentSystemID AS SpouseConstituentSystemID
       , P.PhoneType
       , LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(P.PhoneNumber, ' ', ''), '(', ''), ')', ''), '-', ''), '.', ''), '+', ''), CHAR(9), ''), CHAR(10), ''), CHAR(11), ''), CHAR(12), ''), CHAR(13), '')))  AS PhoneNumber
       , P.PhoneDateChangedDimID
       From temp_DnrCnct_Constituent_Dtl_Phones P Inner Join OSUADV_PROD.RE.Constituent Sp ON P.ConstituentSystemID=Sp.SpouseConstituentSystemID
       Where P.PhoneType In('Personal Landline Phone', 'AlumniFinder Landline Phone','AlumniFinder Phone', 'AlumniSync Phone', 'PhoneFinder Phone', 'GradLoad Phone', 'StudentLoad Phone')
         And isSpousePhone=1
     ) Q;     
     
     
 
Insert Into "DNRCNCT_Phones"
Select 
  C.ConstituentID
, CASE WHEN Opt1.ConstituentSystemID Is Not Null THEN Opt1.PhoneNumber
       WHEN Opt2.ConstituentSystemID Is Not Null THEN Opt2.PhoneNumber
       WHEN Opt3.ConstituentSystemID Is Not Null THEN Opt3.PhoneNumber
       WHEN Opt5.ConstituentSystemID Is Not Null THEN Opt5.PhoneNumber
       WHEN Opt6.ConstituentSystemID Is Not Null THEN Opt6.PhoneNumber
       WHEN Opt7.ConstituentSystemID Is Not Null THEN Opt7.PhoneNumber
       WHEN Opt8.ConstituentSystemID Is Not Null THEN Opt8.PhoneNumber
       WHEN Opt9.ConstituentSystemID Is Not Null THEN Opt9.PhoneNumber
       WHEN Opt10.ConstituentSystemID Is Not Null THEN Opt10.PhoneNumber
       WHEN Opt11.ConstituentSystemID Is Not Null THEN Opt11.PhoneNumber
       WHEN Opt12.ConstituentSystemID Is Not Null THEN Opt12.PhoneNumber
       ELSE NULL
  END AS PhoneNumber
, 'SpousePhone' AS PhoneType    
, '' AS isCellularYN
, '' AS preferredYN
From OSUADV_PROD.RE.Constituent C Left Outer Join tmpPriorityTypePhone_SpouseCell CPh ON C.ConstituentSystemID=CPh.ConstituentSystemID
                                  Left Outer Join OSUADV_PROD.BI.DnrCnct_PriorityAxnPhone Opt1 ON     CPh.SpouseConstituentSystemID=Opt1.ConstituentSystemID
                                                                                                  And CPh.PhoneNumber=Opt1.PhoneNumber
                                                                                                  And CPh.TypeSeq=1
                                  Left Outer Join tmpPriorityTypePhone_SpouseCell Opt2 ON     CPh.ConstituentSystemID=Opt2.ConstituentSystemID
                                                                                    And CPh.PhoneType=Opt2.PhoneType
                                                                                    And CPh.PhoneType='Personal Cell Phone'
                                  Left Outer Join tmpPriorityTypePhone_SpouseCell Opt3 ON     CPh.ConstituentSystemID=Opt3.ConstituentSystemID
                                                                                    And CPh.Phonetype=Opt3.PhoneType
                                                                                    And CPh.Phonetype In('AlumniFinder Cell Phone','AlumniSync Cell Phone')
                                                                                    And Opt3.DateSeq=1
                                  Left Outer Join tmpPriorityTypePhone_SpouseCell Opt5 ON     CPh.ConstituentSystemID=Opt5.ConstituentSystemID
                                                                                    And CPh.PhoneType=Opt5.PhoneType
                                                                                    And CPh.PhoneType='StudentLoad Cell Phone'
                                  Left Outer Join tmpPriorityTypePhone_SpouseCell Opt6 ON     CPh.ConstituentSystemID=Opt6.ConstituentSystemID
                                                                                    And CPh.PhoneType=Opt6.PhoneType
                                                                                    And CPh.PhoneType='ParentLoad Phone'
                                                                                    
                                  Left Outer Join tmpPriorityTypePhone_SpouseHome HPh ON C.ConstituentSystemID=HPh.ConstituentSystemID
                                  Left Outer Join OSUADV_PROD.BI.DnrCnct_PriorityAxnPhone Opt7 ON     HPh.SpouseConstituentSystemID=Opt7.ConstituentSystemID
                                                                                                  And HPh.PhoneNumber=Opt7.PHoneNumber
                                                                                                  And HPh.TypeSeq=1
                                                                                                  
                                  Left Outer Join tmpPriorityTypePhone_SpouseHome Opt8 ON     HPh.ConstituentSystemID=Opt8.ConstituentSystemID
                                                                                          And HPh.PhoneType=Opt8.PhoneType
                                                                                          And HPh.PhoneType='Personal Landline Phone'
                                  Left Outer Join tmpPriorityTypePhone_SpouseHome Opt9 ON     HPh.ConstituentSystemID=Opt9.ConstituentSystemID
                                                                                           And HPh.Phonetype=Opt9.PhoneType
                                                                                           And HPh.Phonetype In('AlumniFinder Landline Phone','AlumniFinder Phone', 'AlumniSync Phone', 'PhoneFinder Phone')
                                                                                           And Opt9.DateSeq=1
                                   Left Outer Join tmpPriorityTypePhone_SpouseHome Opt10 ON     HPh.ConstituentSystemID=Opt10.ConstituentSystemID
                                                                                            And HPh.PhoneType=Opt10.PhoneType
                                                                                            And HPh.PhoneType='GradLoad Phone'
                                   Left Outer Join tmpPriorityTypePhone_SpouseHome Opt11 ON     HPh.ConstituentSystemID=Opt11.ConstituentSystemID
                                                                                            And HPh.PhoneType=Opt11.PhoneType
                                                                                            And HPh.PhoneType='StudentLoad Phone'
                                   Left Outer Join tmpPriorityTypePhone_SpouseHome Opt12 ON     HPh.ConstituentSystemID=Opt12.ConstituentSystemID
                                                                                            And HPh.PhoneType=Opt12.PhoneType
                                                                                            And HPh.PhoneType='ParentLoad Phone'
Where (   Opt1.ConstituentSystemID Is Not Null
       OR Opt2.ConstituentSystemID Is Not Null 
       OR Opt3.ConstituentSystemID Is Not Null
       OR Opt5.ConstituentSystemID Is Not Null
       OR Opt6.ConstituentSystemID Is Not Null
       OR Opt7.ConstituentSystemID Is Not Null
       OR Opt8.ConstituentSystemID Is Not Null
       OR Opt9.ConstituentSystemID Is Not Null
       OR Opt10.ConstituentSystemID Is Not Null
       OR Opt11.ConstituentSystemID Is Not Null
       OR Opt12.ConstituentSystemID Is Not Null
      )
Qualify ROW_NUMBER() OVER(PARTITION BY C.ConstituentSystemID ORDER BY CASE  WHEN Opt1.ConstituentSystemID Is Not Null THEN 1
                                                                            WHEN Opt2.ConstituentSystemID Is Not Null THEN 2
                                                                            WHEN Opt3.ConstituentSystemID Is Not Null THEN 3
                                                                            WHEN Opt5.ConstituentSystemID Is Not Null THEN 5
                                                                            WHEN Opt6.ConstituentSystemID Is Not Null THEN 6
                                                                            WHEN Opt7.ConstituentSystemID Is Not Null THEN 7
                                                                            WHEN Opt8.ConstituentSystemID Is Not Null THEN 8
                                                                            WHEN Opt9.ConstituentSystemID Is Not Null THEN 9
                                                                            WHEN Opt10.ConstituentSystemID Is Not Null THEN 10
                                                                            WHEN Opt11.ConstituentSystemID Is Not Null THEN 11                         
                                                                            WHEN Opt12.ConstituentSystemID Is Not Null THEN 12                       
                                                                            ELSE 100
                                                                        END
                                                                        Asc) = 1;


/* Remove values in DNRCNCT_Phones from temp_DnrCnct_Constituent_Dtl_Phones to prevent duplicate values */
Delete 
From temp_DnrCnct_Constituent_Dtl_Phones DCPh 
Using "DNRCNCT_Phones" Final 
Where DCPh.ConstituentID=Final.ConstituentID
  And DCPh.PhoneNumber=Final.PhoneNumber
  /*And DCPh.isSpousePhone=1*/;

/*Get Alt2 Phone */

CREATE OR REPLACE TEMPORARY TABLE tmpPriorityTypePhone_Alt2Phone1 (  ConstituentSystemID INT
                                                                   , SpouseConstituentSystemID INT
                                                                   , PhoneNumber Varchar(20)
                                                                   , PhoneType VArchar(50)
                                                                   , PhoneDateChangedDimID INT
                                                                   , TypeSeq INT
                                                                   , DateSeq INT
                                                              );
                                                       
Insert Into tmpPriorityTypePhone_Alt2Phone1
Select
  ConstituentSystemID
, SpouseConstituentSystemID
, IFF(RegExp_Instr(PhoneNumber, 'Ext')>0, Left(PhoneNumber, RegExp_Instr(PhoneNumber, 'Ext')-1), PhoneNumber) AS PhoneNumber  //Remove Extension
, PhoneType
, PhoneDateChangedDimID
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by CASE PhoneType
                                                                                 
                                                                                 WHEN 'AlumniFinder Cell Phone' THEN 10
                                                                                 WHEN 'AlumniSync Cell Phone' THEN 20
                                                                                 WHEN 'StudentLoad Cell Phone' THEN 30
                                                                                 WHEN 'AlumniFinder Phone' THEN 40
                                                                                 WHEN 'AlumniSync Phone' THEN 50       
                                                                                 WHEN 'PhoneFinder Phone' THEN 60
                                                                                 WHEN 'GradLoad Phone' THEN 70
                                                                                 WHEN 'StudentLoad Phone' THEN 80                     
                                                                             END
                                                                             Asc) AS TypeSeq
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by   PhoneDateChangedDimID Desc
                                                                            , CASE PhoneType
                                                                                 WHEN 'AlumniFinder Cell Phone' THEN 10
                                                                                 WHEN 'AlumniSync Cell Phone' THEN 20
                                                                                 WHEN 'StudentLoad Cell Phone' THEN 30
                                                                                 WHEN 'AlumniFinder Phone' THEN 40
                                                                                 WHEN 'AlumniSync Phone' THEN 50       
                                                                                 WHEN 'PhoneFinder Phone' THEN 60
                                                                                 WHEN 'GradLoad Phone' THEN 70
                                                                                 WHEN 'StudentLoad Phone' THEN 80                     
                                                                               END
                                                                              Asc) AS DateSeq
From (
       Select
         P.ConstituentSystemID
       , Sp.ConstituentSystemID AS SpouseConstituentSystemID
       , P.PhoneType
       , LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(P.PhoneNumber, ' ', ''), '(', ''), ')', ''), '-', ''), '.', ''), '+', ''), CHAR(9), ''), CHAR(10), ''), CHAR(11), ''), CHAR(12), ''), CHAR(13), '')))  AS PhoneNumber
       , P.PhoneDateChangedDimID
       From temp_DnrCnct_Constituent_Dtl_Phones P Inner Join OSUADV_PROD.RE.Constituent Sp ON P.ConstituentSystemID=Sp.SpouseConstituentSystemID
       Where P.PhoneType In('AlumniFinder Cell Phone', 'AlumniSync Cell Phone','StudentLoad Cell Phone', 'AlumniFinder Phone','AlumniSync Phone','PhoneFinder Phone','GradLoad Phone','StudentLoad Phone')
         And P.isSpousePhone=1
     ) Q;



CREATE OR REPLACE TEMPORARY TABLE tmpPriorityTypePhone_Alt2Phone2 (  ConstituentSystemID INT
                                                                   , SpouseConstituentSystemID INT
                                                                   , PhoneNumber Varchar(20)
                                                                   , PhoneType VArchar(50)
                                                                   , PhoneDateChangedDimID INT
                                                                   , TypeSeq INT
                                                                   , DateSeq INT
                                                              );
                                                       
Insert Into tmpPriorityTypePhone_Alt2Phone2
Select
  ConstituentSystemID
, SpouseConstituentSystemID
, IFF(RegExp_Instr(PhoneNumber, 'Ext')>0, Left(PhoneNumber, RegExp_Instr(PhoneNumber, 'Ext')-1), PhoneNumber) AS PhoneNumber  //Remove Extension
, PhoneType
, PhoneDateChangedDimID
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by CASE PhoneType
                                                                                 WHEN 'Personal Cell Phone' THEN 10
                                                                                 WHEN 'AlumniFinder Cell Phone' THEN 20
                                                                                 WHEN 'AlumniSync Cell Phone' THEN 30
                                                                                 WHEN 'Personal Landline Phone' THEN 40                     
                                                                                 WHEN 'AlumniFinder Phone' THEN 50
                                                                                 WHEN 'AlumniSync Phone' THEN 60   
                                                                                 WHEN 'PhoneFinder Phone' THEN 70                     
                                                                                 WHEN 'StudentLoad Cell Phone' THEN 80
                                                                                 WHEN 'GradLoad Phone' THEN 90 
                                                                                 WHEN 'StudentLoad Phone' THEN 100                     

                                                                             END
                                                                             Asc) AS TypeSeq
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by   PhoneDateChangedDimID Desc
                                                                            , CASE PhoneType
                                                                                 WHEN 'Personal Cell Phone' THEN 10
                                                                                 WHEN 'AlumniFinder Cell Phone' THEN 20
                                                                                 WHEN 'AlumniSync Cell Phone' THEN 30
                                                                                 WHEN 'Personal Landline Phone' THEN 40                     
                                                                                 WHEN 'AlumniFinder Phone' THEN 50
                                                                                 WHEN 'AlumniSync Phone' THEN 60   
                                                                                 WHEN 'PhoneFinder Phone' THEN 70                     
                                                                                 WHEN 'StudentLoad Cell Phone' THEN 80
                                                                                 WHEN 'GradLoad Phone' THEN 90 
                                                                                 WHEN 'StudentLoad Phone' THEN 100   
                                                                               END
                                                                              Asc) AS DateSeq
From (
       Select
         P.ConstituentSystemID
       , Sp.ConstituentSystemID AS SpouseConstituentSystemID
       , P.PhoneType
       , LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(P.PhoneNumber, ' ', ''), '(', ''), ')', ''), '-', ''), '.', ''), '+', ''), CHAR(9), ''), CHAR(10), ''), CHAR(11), ''), CHAR(12), ''), CHAR(13), '')))  AS PhoneNumber
       , P.PhoneDateChangedDimID
       From temp_DnrCnct_Constituent_Dtl_Phones P Inner Join OSUADV_PROD.RE.Constituent Sp ON P.ConstituentSystemID=Sp.SpouseConstituentSystemID
       Where P.PhoneType In('Personal Cell Phone', 'AlumniFinder Cell Phone', 'AlumniSync Cell Phone', 'Personal Landline Phone', 'AlumniFinder Phone', 'AlumniSync Phone', 'PhoneFinder Phone', 'StudentLoad Cell Phone', 'GradLoad Phone', 'StudentLoad Phone')
         And P.isSpousePhone=1
     ) Q;
     
 
 
 
CREATE OR REPLACE TEMPORARY TABLE tmpPriorityTypePhone_Alt2SpouseCell (   ConstituentSystemID INT
                                                                    , SpouseConstituentSystemID INT
                                                                    , PhoneNumber Varchar(20)
                                                                    , PhoneType VArchar(50)
                                                                    , PhoneDateChangedDimID INT
                                                                    , TypeSeq INT
                                                                    , DateSeq INT
                                                                   );
                                                       
Insert Into tmpPriorityTypePhone_Alt2SpouseCell
Select
  ConstituentSystemID
, SpouseConstituentSystemID
, IFF(RegExp_Instr(PhoneNumber, 'Ext')>0, Left(PhoneNumber, RegExp_Instr(PhoneNumber, 'Ext')-1), PhoneNumber) AS PhoneNumber  //Remove Extension
, PhoneType
, PhoneDateChangedDimID
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by CASE PhoneType
                                                                                 WHEN 'Personal Cell Phone' THEN 10
                                                                                 WHEN 'AlumniFinder Cell Phone' THEN 20
                                                                                 WHEN 'AlumniSync Cell Phone' THEN 30
                                                                                 WHEN 'StudentLoad Cell Phone' THEN 40
                                                                             END
                                                                             Asc) AS TypeSeq
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by   PhoneDateChangedDimID Desc
                                                                            , CASE PhoneType
                                                                                 WHEN 'Personal Cell Phone' THEN 10
                                                                                 WHEN 'AlumniFinder Cell Phone' THEN 20
                                                                                 WHEN 'AlumniSync Cell Phone' THEN 30
                                                                                 WHEN 'StudentLoad Cell Phone' THEN 40
                                                                              END
                                                                              Asc) AS DateSeq
From (
       Select
         P.ConstituentSystemID
       , Sp.ConstituentSystemID AS SpouseConstituentSystemID
       , P.PhoneType
       , LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(P.PhoneNumber, ' ', ''), '(', ''), ')', ''), '-', ''), '.', ''), '+', ''), CHAR(9), ''), CHAR(10), ''), CHAR(11), ''), CHAR(12), ''), CHAR(13), '')))  AS PhoneNumber
       , P.PhoneDateChangedDimID
       From temp_DnrCnct_Constituent_Dtl_Phones P Inner Join OSUADV_PROD.RE.Constituent Sp ON P.ConstituentSystemID=Sp.SpouseConstituentSystemID
       Where P.PhoneType In('Personal Cell Phone', 'AlumniFinder Cell Phone', 'AlumniSync Cell Phone', 'StudentLoad Cell Phone')
         And isSpousePhone=1
     ) Q;     
     
     
CREATE OR REPLACE TEMPORARY TABLE tmpPriorityTypePhone_Alt2SpouseHome (   ConstituentSystemID INT
                                                                    , SpouseConstituentSystemID INT
                                                                    , PhoneNumber Varchar(20)
                                                                    , PhoneType VArchar(50)
                                                                    , PhoneDateChangedDimID INT
                                                                    , TypeSeq INT
                                                                    , DateSeq INT
                                                                   );
                                                       
Insert Into tmpPriorityTypePhone_Alt2SpouseHome
Select
  ConstituentSystemID
, SpouseConstituentSystemID
, IFF(RegExp_Instr(PhoneNumber, 'Ext')>0, Left(PhoneNumber, RegExp_Instr(PhoneNumber, 'Ext')-1), PhoneNumber) AS PhoneNumber  //Remove Extension
, PhoneType
, PhoneDateChangedDimID
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by CASE PhoneType
                                                                                 WHEN 'Personal Landline Phone' THEN 10
                                                                                 WHEN 'AlumniFinder Phone' THEN 20
                                                                                 WHEN 'AlumniSync Phone' THEN 30       
                                                                                 WHEN 'PhoneFinder Phone' THEN 40
                                                                                 WHEN 'GradLoad Phone' THEN 50
                                                                                 WHEN 'StudentLoad Phone' THEN 60  
                                                                             END
                                                                             Asc) AS TypeSeq
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by   PhoneDateChangedDimID Desc
                                                                            , CASE PhoneType
                                                                                 WHEN 'Personal Landline Phone' THEN 10
                                                                                 WHEN 'AlumniFinder Phone' THEN 20
                                                                                 WHEN 'AlumniSync Phone' THEN 30       
                                                                                 WHEN 'PhoneFinder Phone' THEN 40
                                                                                 WHEN 'GradLoad Phone' THEN 50
                                                                                 WHEN 'StudentLoad Phone' THEN 60  
                                                                              END
                                                                              Asc) AS DateSeq
From (
       Select
         P.ConstituentSystemID
       , Sp.ConstituentSystemID AS SpouseConstituentSystemID
       , P.PhoneType
       , LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(P.PhoneNumber, ' ', ''), '(', ''), ')', ''), '-', ''), '.', ''), '+', ''), CHAR(9), ''), CHAR(10), ''), CHAR(11), ''), CHAR(12), ''), CHAR(13), '')))  AS PhoneNumber
       , P.PhoneDateChangedDimID
       From temp_DnrCnct_Constituent_Dtl_Phones P Inner Join OSUADV_PROD.RE.Constituent Sp ON P.ConstituentSystemID=Sp.SpouseConstituentSystemID
       Where P.PhoneType In('Personal Landline Phone', 'AlumniFinder Phone', 'AlumniSync Phone', 'PhoneFinder Phone', 'GradLoad Phone', 'StudentLoad Phone')
         And isSpousePhone=1
     ) Q;          
 
 
 
Insert Into "DNRCNCT_Phones"
Select 
  C.ConstituentID
, CASE WHEN Opt1.ConstituentSystemID Is Not Null THEN Opt1.PhoneNumber
       WHEN Opt2.ConstituentSystemID Is Not Null THEN Opt2.PhoneNumber
       WHEN Opt3.ConstituentSystemID Is Not Null THEN Opt3.PhoneNumber
       WHEN Opt4.ConstituentSystemID Is Not Null THEN Opt4.PhoneNumber
       WHEN Opt5.ConstituentSystemID Is Not Null THEN Opt5.PhoneNumber
       WHEN Opt6.ConstituentSystemID Is Not Null THEN Opt6.PhoneNumber
       WHEN Opt7.ConstituentSystemID Is Not Null THEN Opt7.PhoneNumber
       WHEN Opt8.ConstituentSystemID Is Not Null THEN Opt8.PhoneNumber
       WHEN Opt9.ConstituentSystemID Is Not Null THEN Opt9.PhoneNumber
       WHEN Opt10.ConstituentSystemID Is Not Null THEN Opt10.PhoneNumber
       WHEN Opt11.ConstituentSystemID Is Not Null THEN Opt11.PhoneNumber
       WHEN Opt12.ConstituentSystemID Is Not Null THEN Opt12.PhoneNumber
       WHEN Opt13.ConstituentSystemID Is Not Null THEN Opt13.PhoneNumber
       WHEN Opt14.ConstituentSystemID Is Not Null THEN Opt14.PhoneNumber
       WHEN Opt15.ConstituentSystemID Is Not Null THEN Opt15.PhoneNumber
       WHEN Opt16.ConstituentSystemID Is Not Null THEN Opt16.PhoneNumber
       WHEN Opt17.ConstituentSystemID Is Not Null THEN Opt17.PhoneNumber       
       ELSE NULL
  END AS PhoneNumber
, 'Alt Phone 2' AS PhoneType    
, '' AS isCellularYN
, '' AS preferredYN
From OSUADV_PROD.RE.Constituent C Left Outer Join tmpPriorityTypePhone_Alt2Phone1 ap1 ON C.ConstituentSystemID=ap1.ConstituentSystemID
                                  Left Outer Join OSUADV_PROD.BI.DnrCnct_PriorityAxnPhone Opt1 ON     ap1.SpouseConstituentSystemID=Opt1.ConstituentSystemID
                                                                                                  And ap1.PhoneNumber=Opt1.PhoneNumber
                                                                                                  And ap1.TypeSeq=1
                                  Left Outer Join tmpPriorityTypePhone_Alt2Phone2 ap2 ON     c.ConstituentSystemID=ap2.ConstituentSystemID
                                  Left Outer Join tmpPriorityTypePhone_Alt2Phone2 Opt2 ON ap2.ConstituentSystemID=Opt2.ConstituentSystemID
                                                                                    And ap2.PhoneType=Opt2.PhoneType
                                                                                    And ap2.PhoneType='Personal Cell Phone'                                                                                                  
                                                                                                                                                
                                  Left Outer Join tmpPriorityTypePhone_Alt2Phone2 Opt3 ON     ap2.ConstituentSystemID=Opt3.ConstituentSystemID
                                                                                    And ap2.Phonetype=Opt3.PhoneType
                                                                                    And ap2.Phonetype In('AlumniFinder Cell Phone','AlumniSync Cell Phone')
                                                                                    And Opt3.DateSeq=1
                                  Left Outer Join tmpPriorityTypePhone_Alt2Phone2 Opt4 ON ap2.ConstituentSystemID=Opt4.ConstituentSystemID
                                                                                    And ap2.PhoneType=Opt4.PhoneType
                                                                                    And ap2.PhoneType='Personal Landline Phone’'                                                                                     
                                  Left Outer Join tmpPriorityTypePhone_Alt2Phone2 Opt5 ON     ap2.ConstituentSystemID=Opt5.ConstituentSystemID
                                                                                    And ap2.Phonetype In('AlumniFinder Phone','AlumniSync Phone','PhoneFinder Phone')
                                                                                    And Opt5.DateSeq=1
                                  Left Outer Join tmpPriorityTypePhone_Alt2Phone2 Opt6 ON     ap2.ConstituentSystemID=Opt6.ConstituentSystemID
                                                                                    And ap2.PhoneType=Opt6.PhoneType
                                                                                    And ap2.PhoneType='StudentLoad Cell Phone'
                                  Left Outer Join tmpPriorityTypePhone_Alt2Phone2 Opt7 ON     ap2.ConstituentSystemID=Opt7.ConstituentSystemID
                                                                                    And ap2.PhoneType=Opt7.PhoneType
                                                                                    And ap2.PhoneType='GradLoad Phone'                                                                                    
                                  Left Outer Join tmpPriorityTypePhone_Alt2Phone2 Opt8 ON     ap2.ConstituentSystemID=Opt8.ConstituentSystemID
                                                                                    And ap2.PhoneType=Opt8.PhoneType
                                                                                    And ap2.PhoneType='StudentLoad Phone'                                                                                    
    
                                  Left Outer Join tmpPriorityTypePhone_Alt2SpouseCell spc ON C.ConstituentSystemID=spc.ConstituentSystemID
                                  Left Outer Join OSUADV_PROD.BI.DnrCnct_PriorityAxnPhone Opt9 ON     spc.SpouseConstituentSystemID=Opt9.ConstituentSystemID
                                                                                                  And spc.PhoneNumber=Opt9.PHoneNumber
                                                                                                  And spc.TypeSeq=1
                                                                                                  
                                  Left Outer Join tmpPriorityTypePhone_Alt2SpouseCell Opt10 ON     spc.ConstituentSystemID=Opt10.ConstituentSystemID
                                                                                          And spc.PhoneType=Opt10.PhoneType
                                                                                          And spc.PhoneType='Personal Cell Phone'
                                  Left Outer Join tmpPriorityTypePhone_Alt2SpouseCell Opt11 ON     spc.ConstituentSystemID=Opt11.ConstituentSystemID
                                                                                    And spc.Phonetype In('AlumniFinder Cell Phone','AlumniSync Cell Phone')
                                                                                    And Opt11.DateSeq=1                                                                       
                                  Left Outer Join tmpPriorityTypePhone_Alt2SpouseCell Opt12 ON     spc.ConstituentSystemID=Opt12.ConstituentSystemID
                                                                                          And spc.PhoneType=Opt12.PhoneType
                                                                                          And spc.PhoneType='StudentLoad Cell Phone'
                                  Left Outer Join tmpPriorityTypePhone_Alt2SpouseHome sph ON C.ConstituentSystemID=sph.ConstituentSystemID
                                  Left Outer Join OSUADV_PROD.BI.DnrCnct_PriorityAxnPhone Opt13 ON     sph.SpouseConstituentSystemID=Opt13.ConstituentSystemID
                                                                                                  And sph.PhoneNumber=Opt13.PHoneNumber
                                                                                                  And sph.TypeSeq=1                                                                                          
                                  Left Outer Join tmpPriorityTypePhone_Alt2SpouseHome Opt14 ON     sph.ConstituentSystemID=Opt14.ConstituentSystemID
                                                                                          And sph.PhoneType=Opt14.PhoneType
                                                                                          And sph.PhoneType='Personal Landline Phone'                                                                                          
                                  Left Outer Join tmpPriorityTypePhone_Alt2SpouseHome Opt15 ON     sph.ConstituentSystemID=Opt15.ConstituentSystemID
                                                                                    And sph.Phonetype In('AlumniFinder Phone','AlumniSync Phone','PhoneFinder Phone')
                                                                                    And Opt15.DateSeq=1   
                                   Left Outer Join tmpPriorityTypePhone_Alt2SpouseHome Opt16 ON     sph.ConstituentSystemID=Opt16.ConstituentSystemID
                                                                                    And sph.PhoneType=Opt16.PhoneType
                                                                                    And sph.PhoneType='GradLoad Phone'                                                                                    
                                  Left Outer Join tmpPriorityTypePhone_Alt2SpouseHome Opt17 ON     sph.ConstituentSystemID=Opt17.ConstituentSystemID
                                                                                    And sph.PhoneType=Opt17.PhoneType
                                                                                    And sph.PhoneType='StudentLoad Phone'  
                                                                                    
Where (   Opt1.ConstituentSystemID Is Not Null
       OR Opt2.ConstituentSystemID Is Not Null 
       OR Opt3.ConstituentSystemID Is Not Null
       OR Opt4.ConstituentSystemID Is Not Null
       OR Opt5.ConstituentSystemID Is Not Null
       OR Opt6.ConstituentSystemID Is Not Null
       OR Opt7.ConstituentSystemID Is Not Null
       OR Opt8.ConstituentSystemID Is Not Null
       OR Opt9.ConstituentSystemID Is Not Null
       OR Opt10.ConstituentSystemID Is Not Null
       OR Opt11.ConstituentSystemID Is Not Null
       OR Opt12.ConstituentSystemID Is Not Null
       OR Opt13.ConstituentSystemID Is Not Null
       OR Opt14.ConstituentSystemID Is Not Null
       OR Opt15.ConstituentSystemID Is Not Null
       OR Opt16.ConstituentSystemID Is Not Null
       OR Opt17.ConstituentSystemID Is Not Null       
      )
Qualify ROW_NUMBER() OVER(PARTITION BY C.ConstituentSystemID ORDER BY CASE  WHEN Opt1.ConstituentSystemID Is Not Null THEN 1
                                                                            WHEN Opt2.ConstituentSystemID Is Not Null THEN 2
                                                                            WHEN Opt3.ConstituentSystemID Is Not Null THEN 3
                                                                            WHEN Opt5.ConstituentSystemID Is Not Null THEN 5
                                                                            WHEN Opt6.ConstituentSystemID Is Not Null THEN 6
                                                                            WHEN Opt7.ConstituentSystemID Is Not Null THEN 7
                                                                            WHEN Opt8.ConstituentSystemID Is Not Null THEN 8
                                                                            WHEN Opt9.ConstituentSystemID Is Not Null THEN 9
                                                                            WHEN Opt10.ConstituentSystemID Is Not Null THEN 10
                                                                            WHEN Opt11.ConstituentSystemID Is Not Null THEN 11                         
                                                                            WHEN Opt12.ConstituentSystemID Is Not Null THEN 12 
                                                                            WHEN Opt13.ConstituentSystemID Is Not Null THEN 13                         
                                                                            WHEN Opt14.ConstituentSystemID Is Not Null THEN 14 
                                                                            WHEN Opt15.ConstituentSystemID Is Not Null THEN 15                         
                                                                            WHEN Opt16.ConstituentSystemID Is Not Null THEN 16 
                                                                            WHEN Opt17.ConstituentSystemID Is Not Null THEN 17                                                   
                                                                            ELSE 100
                                                                        END
                                                                        Asc) = 1;
 

/* Remove values in DNRCNCT_Phones from temp_DnrCnct_Constituent_Dtl_Phones to prevent duplicate values */
Delete 
From temp_DnrCnct_Constituent_Dtl_Phones DCPh 
Using "DNRCNCT_Phones" Final 
Where DCPh.ConstituentID=Final.ConstituentID
  And DCPh.PhoneNumber=Final.PhoneNumber
  /*And DCPh.isSpousePhone=1*/;
  
  
/*Get Alt3 Phone */

CREATE OR REPLACE TEMPORARY TABLE tmpPriorityTypePhone_Alt3Phone1 (  ConstituentSystemID INT
                                                                   , SpouseConstituentSystemID INT
                                                                   , PhoneNumber Varchar(20)
                                                                   , PhoneType VArchar(50)
                                                                   , PhoneDateChangedDimID INT
                                                                   , TypeSeq INT
                                                                   , DateSeq INT
                                                              );
                                                       
Insert Into tmpPriorityTypePhone_Alt3Phone1
Select
  ConstituentSystemID
, SpouseConstituentSystemID
, IFF(RegExp_Instr(PhoneNumber, 'Ext')>0, Left(PhoneNumber, RegExp_Instr(PhoneNumber, 'Ext')-1), PhoneNumber) AS PhoneNumber  //Remove Extension
, PhoneType
, PhoneDateChangedDimID
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by CASE PhoneType                                                                               
                                                                                 WHEN 'AlumniFinder Phone' THEN 10
                                                                                 WHEN 'AlumniSync Phone' THEN 20       
                                                                                 WHEN 'PhoneFinder Phone' THEN 30
                                                                                 WHEN 'GradLoad Phone' THEN 40
                                                                                 WHEN 'StudentLoad Phone' THEN 50                     
                                                                             END
                                                                             Asc) AS TypeSeq
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by   PhoneDateChangedDimID Desc
                                                                            , CASE PhoneType
                                                                                 WHEN 'AlumniFinder Phone' THEN 10
                                                                                 WHEN 'AlumniSync Phone' THEN 20       
                                                                                 WHEN 'PhoneFinder Phone' THEN 30
                                                                                 WHEN 'GradLoad Phone' THEN 40
                                                                                 WHEN 'StudentLoad Phone' THEN 50                    
                                                                               END
                                                                              Asc) AS DateSeq
From (
       Select
         P.ConstituentSystemID
       , Sp.ConstituentSystemID AS SpouseConstituentSystemID
       , P.PhoneType
       , LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(P.PhoneNumber, ' ', ''), '(', ''), ')', ''), '-', ''), '.', ''), '+', ''), CHAR(9), ''), CHAR(10), ''), CHAR(11), ''), CHAR(12), ''), CHAR(13), '')))  AS PhoneNumber
       , P.PhoneDateChangedDimID
       From temp_DnrCnct_Constituent_Dtl_Phones P Inner Join OSUADV_PROD.RE.Constituent Sp ON P.ConstituentSystemID=Sp.SpouseConstituentSystemID
       Where P.PhoneType In('AlumniFinder Phone','AlumniSync Phone','PhoneFinder Phone','GradLoad Phone','StudentLoad Phone')
         And P.isSpousePhone=1
     ) Q;



CREATE OR REPLACE TEMPORARY TABLE tmpPriorityTypePhone_Alt3Phone2 (  ConstituentSystemID INT
                                                                   , SpouseConstituentSystemID INT
                                                                   , PhoneNumber Varchar(20)
                                                                   , PhoneType VArchar(50)
                                                                   , PhoneDateChangedDimID INT
                                                                   , TypeSeq INT
                                                                   , DateSeq INT
                                                              );
                                                       
Insert Into tmpPriorityTypePhone_Alt3Phone2
Select
  ConstituentSystemID
, SpouseConstituentSystemID
, IFF(RegExp_Instr(PhoneNumber, 'Ext')>0, Left(PhoneNumber, RegExp_Instr(PhoneNumber, 'Ext')-1), PhoneNumber) AS PhoneNumber  //Remove Extension
, PhoneType
, PhoneDateChangedDimID
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by CASE PhoneType
                                                                                 WHEN 'Personal Cell Phone' THEN 10
                                                                                 WHEN 'AlumniFinder Cell Phone' THEN 20
                                                                                 WHEN 'AlumniSync Cell Phone' THEN 30
                                                                                 WHEN 'Personal Landline Phone' THEN 40                     
                                                                                 WHEN 'AlumniFinder Phone' THEN 50
                                                                                 WHEN 'AlumniSync Phone' THEN 60   
                                                                                 WHEN 'PhoneFinder Phone' THEN 70                     
                                                                                 WHEN 'StudentLoad Cell Phone' THEN 80
                                                                                 WHEN 'GradLoad Phone' THEN 90 
                                                                                 WHEN 'StudentLoad Phone' THEN 100                     

                                                                             END
                                                                             Asc) AS TypeSeq
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by   PhoneDateChangedDimID Desc
                                                                            , CASE PhoneType
                                                                                 WHEN 'Personal Cell Phone' THEN 10
                                                                                 WHEN 'AlumniFinder Cell Phone' THEN 20
                                                                                 WHEN 'AlumniSync Cell Phone' THEN 30
                                                                                 WHEN 'Personal Landline Phone' THEN 40                     
                                                                                 WHEN 'AlumniFinder Phone' THEN 50
                                                                                 WHEN 'AlumniSync Phone' THEN 60   
                                                                                 WHEN 'PhoneFinder Phone' THEN 70                     
                                                                                 WHEN 'StudentLoad Cell Phone' THEN 80
                                                                                 WHEN 'GradLoad Phone' THEN 90 
                                                                                 WHEN 'StudentLoad Phone' THEN 100   
                                                                               END
                                                                              Asc) AS DateSeq
From (
       Select
         P.ConstituentSystemID
       , Sp.ConstituentSystemID AS SpouseConstituentSystemID
       , P.PhoneType
       , LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(P.PhoneNumber, ' ', ''), '(', ''), ')', ''), '-', ''), '.', ''), '+', ''), CHAR(9), ''), CHAR(10), ''), CHAR(11), ''), CHAR(12), ''), CHAR(13), '')))  AS PhoneNumber
       , P.PhoneDateChangedDimID
       From temp_DnrCnct_Constituent_Dtl_Phones P Inner Join OSUADV_PROD.RE.Constituent Sp ON P.ConstituentSystemID=Sp.SpouseConstituentSystemID
       Where P.PhoneType In('Personal Cell Phone', 'AlumniFinder Cell Phone', 'AlumniSync Cell Phone', 'Personal Landline Phone', 'AlumniFinder Phone', 'AlumniSync Phone', 'PhoneFinder Phone', 'StudentLoad Cell Phone', 'GradLoad Phone', 'StudentLoad Phone')
         And P.isSpousePhone=1
     ) Q;
     
 
 
 
CREATE OR REPLACE TEMPORARY TABLE tmpPriorityTypePhone_Alt3SpouseCell (   ConstituentSystemID INT
                                                                    , SpouseConstituentSystemID INT
                                                                    , PhoneNumber Varchar(20)
                                                                    , PhoneType VArchar(50)
                                                                    , PhoneDateChangedDimID INT
                                                                    , TypeSeq INT
                                                                    , DateSeq INT
                                                                   );
                                                       
Insert Into tmpPriorityTypePhone_Alt3SpouseCell
Select
  ConstituentSystemID
, SpouseConstituentSystemID
, IFF(RegExp_Instr(PhoneNumber, 'Ext')>0, Left(PhoneNumber, RegExp_Instr(PhoneNumber, 'Ext')-1), PhoneNumber) AS PhoneNumber  //Remove Extension
, PhoneType
, PhoneDateChangedDimID
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by CASE PhoneType
                                                                                 WHEN 'Personal Cell Phone' THEN 10
                                                                                 WHEN 'AlumniFinder Cell Phone' THEN 20
                                                                                 WHEN 'AlumniSync Cell Phone' THEN 30
                                                                                 WHEN 'StudentLoad Cell Phone' THEN 40
                                                                             END
                                                                             Asc) AS TypeSeq
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by   PhoneDateChangedDimID Desc
                                                                            , CASE PhoneType
                                                                                 WHEN 'Personal Cell Phone' THEN 10
                                                                                 WHEN 'AlumniFinder Cell Phone' THEN 20
                                                                                 WHEN 'AlumniSync Cell Phone' THEN 30
                                                                                 WHEN 'StudentLoad Cell Phone' THEN 40
                                                                              END
                                                                              Asc) AS DateSeq
From (
       Select
         P.ConstituentSystemID
       , Sp.ConstituentSystemID AS SpouseConstituentSystemID
       , P.PhoneType
       , LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(P.PhoneNumber, ' ', ''), '(', ''), ')', ''), '-', ''), '.', ''), '+', ''), CHAR(9), ''), CHAR(10), ''), CHAR(11), ''), CHAR(12), ''), CHAR(13), '')))  AS PhoneNumber
       , P.PhoneDateChangedDimID
       From temp_DnrCnct_Constituent_Dtl_Phones P Inner Join OSUADV_PROD.RE.Constituent Sp ON P.ConstituentSystemID=Sp.SpouseConstituentSystemID
       Where P.PhoneType In('Personal Cell Phone', 'AlumniFinder Cell Phone', 'AlumniSync Cell Phone', 'StudentLoad Cell Phone')
         And isSpousePhone=1
     ) Q;     
     
     
CREATE OR REPLACE TEMPORARY TABLE tmpPriorityTypePhone_Alt3SpouseHome (   ConstituentSystemID INT
                                                                    , SpouseConstituentSystemID INT
                                                                    , PhoneNumber Varchar(20)
                                                                    , PhoneType VArchar(50)
                                                                    , PhoneDateChangedDimID INT
                                                                    , TypeSeq INT
                                                                    , DateSeq INT
                                                                   );
                                                       
Insert Into tmpPriorityTypePhone_Alt3SpouseHome
Select
  ConstituentSystemID
, SpouseConstituentSystemID
, IFF(RegExp_Instr(PhoneNumber, 'Ext')>0, Left(PhoneNumber, RegExp_Instr(PhoneNumber, 'Ext')-1), PhoneNumber) AS PhoneNumber  //Remove Extension
, PhoneType
, PhoneDateChangedDimID
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by CASE PhoneType
                                                                                 WHEN 'Personal Landline Phone' THEN 10
                                                                                 WHEN 'AlumniFinder Phone' THEN 20
                                                                                 WHEN 'AlumniSync Phone' THEN 30       
                                                                                 WHEN 'PhoneFinder Phone' THEN 40
                                                                                 WHEN 'GradLoad Phone' THEN 50
                                                                                 WHEN 'StudentLoad Phone' THEN 60  
                                                                             END
                                                                             Asc) AS TypeSeq
, ROW_NUMBER() OVER (PARTITION BY ConstituentSystemID, PhoneNumber Order by   PhoneDateChangedDimID Desc
                                                                            , CASE PhoneType
                                                                                 WHEN 'Personal Landline Phone' THEN 10
                                                                                 WHEN 'AlumniFinder Phone' THEN 20
                                                                                 WHEN 'AlumniSync Phone' THEN 30       
                                                                                 WHEN 'PhoneFinder Phone' THEN 40
                                                                                 WHEN 'GradLoad Phone' THEN 50
                                                                                 WHEN 'StudentLoad Phone' THEN 60  
                                                                              END
                                                                              Asc) AS DateSeq
From (
       Select
         P.ConstituentSystemID
       , Sp.ConstituentSystemID AS SpouseConstituentSystemID
       , P.PhoneType
       , LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(P.PhoneNumber, ' ', ''), '(', ''), ')', ''), '-', ''), '.', ''), '+', ''), CHAR(9), ''), CHAR(10), ''), CHAR(11), ''), CHAR(12), ''), CHAR(13), '')))  AS PhoneNumber
       , P.PhoneDateChangedDimID
       From temp_DnrCnct_Constituent_Dtl_Phones P Inner Join OSUADV_PROD.RE.Constituent Sp ON P.ConstituentSystemID=Sp.SpouseConstituentSystemID
       Where P.PhoneType In('Personal Landline Phone', 'AlumniFinder Phone', 'AlumniSync Phone', 'PhoneFinder Phone', 'GradLoad Phone', 'StudentLoad Phone')
         And isSpousePhone=1
     ) Q;          
 
 
 
Insert Into "DNRCNCT_Phones"
Select 
  C.ConstituentID
, CASE WHEN Opt1.ConstituentSystemID Is Not Null THEN Opt1.PhoneNumber
       WHEN Opt2.ConstituentSystemID Is Not Null THEN Opt2.PhoneNumber
       WHEN Opt3.ConstituentSystemID Is Not Null THEN Opt3.PhoneNumber
       WHEN Opt4.ConstituentSystemID Is Not Null THEN Opt4.PhoneNumber
       WHEN Opt5.ConstituentSystemID Is Not Null THEN Opt5.PhoneNumber
       WHEN Opt6.ConstituentSystemID Is Not Null THEN Opt6.PhoneNumber
       WHEN Opt7.ConstituentSystemID Is Not Null THEN Opt7.PhoneNumber
       WHEN Opt8.ConstituentSystemID Is Not Null THEN Opt8.PhoneNumber
       WHEN Opt9.ConstituentSystemID Is Not Null THEN Opt9.PhoneNumber
       WHEN Opt10.ConstituentSystemID Is Not Null THEN Opt10.PhoneNumber
       WHEN Opt11.ConstituentSystemID Is Not Null THEN Opt11.PhoneNumber
       WHEN Opt12.ConstituentSystemID Is Not Null THEN Opt12.PhoneNumber
       WHEN Opt13.ConstituentSystemID Is Not Null THEN Opt13.PhoneNumber
       WHEN Opt14.ConstituentSystemID Is Not Null THEN Opt14.PhoneNumber
       WHEN Opt15.ConstituentSystemID Is Not Null THEN Opt15.PhoneNumber
       WHEN Opt16.ConstituentSystemID Is Not Null THEN Opt16.PhoneNumber
       WHEN Opt17.ConstituentSystemID Is Not Null THEN Opt17.PhoneNumber       
       ELSE NULL
  END AS PhoneNumber
, 'Alt Phone 3' AS PhoneType    
, '' AS isCellularYN
, '' AS preferredYN
From OSUADV_PROD.RE.Constituent C 
                                  Left Outer Join tmpPriorityTypePhone_Alt3Phone1 ap1 ON C.ConstituentSystemID=ap1.ConstituentSystemID
                                  Left Outer Join OSUADV_PROD.BI.DnrCnct_PriorityAxnPhone Opt1 ON     ap1.SpouseConstituentSystemID=Opt1.ConstituentSystemID
                                                                                                  And ap1.PhoneNumber=Opt1.PhoneNumber
                                                                                                  And ap1.TypeSeq=1
                                  Left Outer Join tmpPriorityTypePhone_Alt3Phone2 ap2 ON     c.ConstituentSystemID=ap2.ConstituentSystemID
                                  Left Outer Join tmpPriorityTypePhone_Alt3Phone2 Opt2 ON ap2.ConstituentSystemID=Opt2.ConstituentSystemID
                                                                                    And ap2.PhoneType=Opt2.PhoneType
                                                                                    And ap2.PhoneType='Personal Cell Phone'                                                                                                  
                                                                                                                                                
                                  Left Outer Join tmpPriorityTypePhone_Alt3Phone2 Opt3 ON     ap2.ConstituentSystemID=Opt3.ConstituentSystemID
                                                                                    And ap2.Phonetype=Opt3.PhoneType
                                                                                    And ap2.Phonetype In('AlumniFinder Cell Phone','AlumniSync Cell Phone')
                                                                                    And Opt3.DateSeq=1
                                  Left Outer Join tmpPriorityTypePhone_Alt3Phone2 Opt4 ON ap2.ConstituentSystemID=Opt4.ConstituentSystemID
                                                                                    And ap2.PhoneType=Opt4.PhoneType
                                                                                    And ap2.PhoneType='Personal Landline Phone’'                                                                                     
                                  Left Outer Join tmpPriorityTypePhone_Alt3Phone2 Opt5 ON     ap2.ConstituentSystemID=Opt5.ConstituentSystemID
                                                                                    And ap2.Phonetype In('AlumniFinder Phone','AlumniSync Phone','PhoneFinder Phone')
                                                                                    And Opt5.DateSeq=1
                                  Left Outer Join tmpPriorityTypePhone_Alt3Phone2 Opt6 ON     ap2.ConstituentSystemID=Opt6.ConstituentSystemID
                                                                                    And ap2.PhoneType=Opt6.PhoneType
                                                                                    And ap2.PhoneType='StudentLoad Cell Phone'
                                  Left Outer Join tmpPriorityTypePhone_Alt3Phone2 Opt7 ON     ap2.ConstituentSystemID=Opt7.ConstituentSystemID
                                                                                    And ap2.PhoneType=Opt7.PhoneType
                                                                                    And ap2.PhoneType='GradLoad Phone'                                                                                    
                                  Left Outer Join tmpPriorityTypePhone_Alt3Phone2 Opt8 ON     ap2.ConstituentSystemID=Opt8.ConstituentSystemID
                                                                                    And ap2.PhoneType=Opt8.PhoneType
                                                                                    And ap2.PhoneType='StudentLoad Phone'                                                                                    
    
                                  Left Outer Join tmpPriorityTypePhone_Alt3SpouseCell spc ON C.ConstituentSystemID=spc.ConstituentSystemID
                                  Left Outer Join OSUADV_PROD.BI.DnrCnct_PriorityAxnPhone Opt9 ON     spc.SpouseConstituentSystemID=Opt9.ConstituentSystemID
                                                                                                  And spc.PhoneNumber=Opt9.PHoneNumber
                                                                                                  And spc.TypeSeq=1
                                                                                                  
                                  Left Outer Join tmpPriorityTypePhone_Alt3SpouseCell Opt10 ON     spc.ConstituentSystemID=Opt10.ConstituentSystemID
                                                                                          And spc.PhoneType=Opt10.PhoneType
                                                                                          And spc.PhoneType='Personal Cell Phone'
                                  Left Outer Join tmpPriorityTypePhone_Alt3SpouseCell Opt11 ON     spc.ConstituentSystemID=Opt11.ConstituentSystemID
                                                                                    And spc.Phonetype In('AlumniFinder Cell Phone','AlumniSync Cell Phone')
                                                                                    And Opt11.DateSeq=1                                                                       
                                  Left Outer Join tmpPriorityTypePhone_Alt3SpouseCell Opt12 ON     spc.ConstituentSystemID=Opt12.ConstituentSystemID
                                                                                          And spc.PhoneType=Opt12.PhoneType
                                                                                          And spc.PhoneType='StudentLoad Cell Phone'
                                  Left Outer Join tmpPriorityTypePhone_Alt3SpouseHome sph ON C.ConstituentSystemID=sph.ConstituentSystemID
                                  Left Outer Join OSUADV_PROD.BI.DnrCnct_PriorityAxnPhone Opt13 ON     sph.SpouseConstituentSystemID=Opt13.ConstituentSystemID
                                                                                                  And sph.PhoneNumber=Opt13.PHoneNumber
                                                                                                  And sph.TypeSeq=1                                                                                          
                                  Left Outer Join tmpPriorityTypePhone_Alt3SpouseHome Opt14 ON     sph.ConstituentSystemID=Opt14.ConstituentSystemID
                                                                                          And sph.PhoneType=Opt14.PhoneType
                                                                                          And sph.PhoneType='Personal Landline Phone'                                                                                          
                                  Left Outer Join tmpPriorityTypePhone_Alt3SpouseHome Opt15 ON     sph.ConstituentSystemID=Opt15.ConstituentSystemID
                                                                                    And sph.Phonetype In('AlumniFinder Phone','AlumniSync Phone','PhoneFinder Phone')
                                                                                    And Opt15.DateSeq=1   
                                   Left Outer Join tmpPriorityTypePhone_Alt3SpouseHome Opt16 ON     sph.ConstituentSystemID=Opt16.ConstituentSystemID
                                                                                    And sph.PhoneType=Opt16.PhoneType
                                                                                    And sph.PhoneType='GradLoad Phone'                                                                                    
                                  Left Outer Join tmpPriorityTypePhone_Alt3SpouseHome Opt17 ON     sph.ConstituentSystemID=Opt17.ConstituentSystemID
                                                                                    And sph.PhoneType=Opt17.PhoneType
                                                                                    And sph.PhoneType='StudentLoad Phone'  
                                                                                    
Where (   Opt1.ConstituentSystemID Is Not Null
       OR Opt2.ConstituentSystemID Is Not Null 
       OR Opt3.ConstituentSystemID Is Not Null
       OR Opt4.ConstituentSystemID Is Not Null
       OR Opt5.ConstituentSystemID Is Not Null
       OR Opt6.ConstituentSystemID Is Not Null
       OR Opt7.ConstituentSystemID Is Not Null
       OR Opt8.ConstituentSystemID Is Not Null
       OR Opt9.ConstituentSystemID Is Not Null
       OR Opt10.ConstituentSystemID Is Not Null
       OR Opt11.ConstituentSystemID Is Not Null
       OR Opt12.ConstituentSystemID Is Not Null
       OR Opt13.ConstituentSystemID Is Not Null
       OR Opt14.ConstituentSystemID Is Not Null
       OR Opt15.ConstituentSystemID Is Not Null
       OR Opt16.ConstituentSystemID Is Not Null
       OR Opt17.ConstituentSystemID Is Not Null       
      )
Qualify ROW_NUMBER() OVER(PARTITION BY C.ConstituentSystemID ORDER BY CASE  WHEN Opt1.ConstituentSystemID Is Not Null THEN 1
                                                                            WHEN Opt2.ConstituentSystemID Is Not Null THEN 2
                                                                            WHEN Opt3.ConstituentSystemID Is Not Null THEN 3
                                                                            WHEN Opt5.ConstituentSystemID Is Not Null THEN 5
                                                                            WHEN Opt6.ConstituentSystemID Is Not Null THEN 6
                                                                            WHEN Opt7.ConstituentSystemID Is Not Null THEN 7
                                                                            WHEN Opt8.ConstituentSystemID Is Not Null THEN 8
                                                                            WHEN Opt9.ConstituentSystemID Is Not Null THEN 9
                                                                            WHEN Opt10.ConstituentSystemID Is Not Null THEN 10
                                                                            WHEN Opt11.ConstituentSystemID Is Not Null THEN 11                         
                                                                            WHEN Opt12.ConstituentSystemID Is Not Null THEN 12 
                                                                            WHEN Opt13.ConstituentSystemID Is Not Null THEN 13                         
                                                                            WHEN Opt14.ConstituentSystemID Is Not Null THEN 14 
                                                                            WHEN Opt15.ConstituentSystemID Is Not Null THEN 15                         
                                                                            WHEN Opt16.ConstituentSystemID Is Not Null THEN 16 
                                                                            WHEN Opt17.ConstituentSystemID Is Not Null THEN 17                                                   
                                                                            ELSE 100
                                                                        END
                                                                        Asc) = 1;
 
DELETE
FROM "DNRCNCT_Phones"
WHERE 
    ConstituentID NOT IN (
                            SELECT C.ConstituentID
                            FROM OSUADV_PROD.RE.Constituent C
                                    INNER JOIN "DNRCNCT_InclLst_minus_ExclLst" IME ON C.CONSTITUENTSYSTEMID = IME.CONSTITUENTSYSTEMID
                            
                            );
                            
DELETE
FROM "DNRCNCT_Phones"
WHERE 
    ConstituentID IS NULL;

Drop Table If Exists temp_DnrCnct_Constituent_Dtl_Phones;


