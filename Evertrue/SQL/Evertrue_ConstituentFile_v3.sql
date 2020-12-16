SELECT
    c.UCINN_ASCENDV2__DONOR_ID                                      AS PersonID
    ,c.Salutation                                                   AS PersonPrefix
    ,c.FIRSTNAME                                                    AS PersonFirstName
    ,c.Nickname                                                     AS PersonNickName
    ,c.MiddleName                                                   AS PersonMiddleName
    ,c.LASTNAME                                                     AS PersonLastName
    ,c.Maiden_Name                                                  AS PersonPrevLastName
    ,c.Suffix                                                       AS PersonSuffix
    ,'Year Graduated'                                               AS PersonYear               //NEED
    ,c.ucinn_ascendv2__Gender                                       AS Gender
    ,c.ucinn_ascendv2__Ethnicity                                    AS Ethnicity
    ,CASE
        WHEN c.ucinn_ascendv2__Is_Deceased = 'True' THEN 'Yes'
        ELSE                                             'No'
        END                                                         AS PersonIsDeceased
    ,''                                                             AS PersonIsDeleted
    ,'Alumni;KOSU Donor;McKnight Center for the Performing Arts'    AS ConstituentCodeList      //NEED
    ,'2 Cultivation'                                                AS ProspectStatus           //NEED
    ,'Football;Indoor Track'                                        AS Sports                   //NEED
    ,'CAS Student Council;Mortar Board'                             AS Activities               //NEED
    ,'GPF - No OSUF Gift Planning;MA - No OSUAA Postal Mail'        AS SolicitCodes             //NEED
    
    ,COALESCE(emailpref.Email, '')                                  AS Email1Email              //???
    ,COALESCE(emailpref.Type, '')                                   AS Email1Type               //???
    ,COALESCE(emailpref.IsPrimary, '')                              AS Email1IsPrimary          //???
    ,COALESCE(emailpersonal.Email, '')                              AS Email2Email              //???
    ,COALESCE(emailpersonal.Type, '')                               AS Email2Type               //???
    ,COALESCE(emailpersonal.IsPrimary, '')                          AS Email2IsPrimary          //???
    ,COALESCE(emailbus.Email, '')                                   AS Email3Email              //???
    ,COALESCE(emailbus.Type, '')                                    AS Email3Type               //???
    ,COALESCE(emailbus.IsPrimary, '')                               AS Email3IsPrimary          //???    
    ,COALESCE(emailother.Email, '')                                 AS Email4Email              //???
    ,COALESCE(emailother.Type, '')                                  AS Email4Type               //???
    ,COALESCE(emailother.IsPrimary, '')                             AS Email4IsPrimary          //???
    ,''                                                             AS Email5Email              //???
    ,''                                                             AS Email5Type               //???
    ,''                                                             AS Email5IsPrimary          //???
    
    
    ,COALESCE(phonehome.Phone, '')                                  AS Phone1Phone
    ,COALESCE(phonehome.Type, '')                                   AS Phone1Type
    ,COALESCE(phonehome.IsPrimary, '')                              AS Phone1IsPrimary
    ,COALESCE(mobilehome.Phone, '')                                 AS Phone2Phone
    ,COALESCE(mobilehome.Type, '')                                  AS Phone2Type
    ,COALESCE(mobilehome.IsPrimary, '')                             AS Phone2IsPrimary
    ,COALESCE(phonebus.Phone, '')                                   AS Phone3Phone
    ,COALESCE(phonebus.Type, '')                                    AS Phone3Type
    ,COALESCE(phonebus.IsPrimary, '')                               AS Phone3IsPrimary
    ,COALESCE(mobilebus.Phone, '')                                  AS Phone4Phone
    ,COALESCE(mobilebus.Type, '')                                   AS Phone4Type
    ,COALESCE(mobilebus.IsPrimary, '')                              AS Phone4IsPrimary
    
    ,COALESCE(AddressHome.Type, '')                                 AS Address1Type
    ,COALESCE(AddressHome.Line1, '')                                AS Address1Line1
    ,COALESCE(AddressHome.Line2, '')                                AS Address1Line2
    ,COALESCE(AddressHome.Line3, '')                                AS Address1Line3
    ,COALESCE(AddressHome.City, '')                                 AS Address1City
    ,COALESCE(AddressHome.State, '')                                AS Address1State
    ,COALESCE(AddressHome.County, '')                               AS Address1County
    ,COALESCE(AddressHome.Country, '')                              AS Address1Country
    ,COALESCE(AddressHome.Zip, '')                                  AS Address1Zip
    ,COALESCE(AddressHome.IsPrimary, '')                            AS Address1IsPrimary
    ,COALESCE(AddressBus.Type, '')                                  AS Address2Type
    ,COALESCE(AddressBus.Line1, '')                                 AS Address2Line1
    ,COALESCE(AddressBus.Line2, '')                                 AS Address2Line2
    ,COALESCE(AddressBus.Line3, '')                                 AS Address2Line3
    ,COALESCE(AddressBus.City, '')                                  AS Address2City
    ,COALESCE(AddressBus.State, '')                                 AS Address2State
    ,COALESCE(AddressBus.County, '')                                AS Address2County
    ,COALESCE(AddressBus.Country, '')                               AS Address2Country
    ,COALESCE(AddressBus.Zip, '')                                   AS Address2Zip
    ,COALESCE(AddressBus.IsPrimary, '')                             AS Address2IsPrimary
    ,''                                                AS Address3Type
    ,''                                                AS Address3Line1
    ,''                                                AS Address3Line2
    ,''                                                AS Address3Line3
    ,''                                                AS Address3City
    ,''                                                AS Address3State
    ,''                                                AS Address3Country
    ,''                                                AS Address3Zip
    ,''                                                AS Address3IsPrimary

    
FROM
    "OSUF_INTERFACES"."FACULTY_STAFF"."SF_ContactObject" c
        
// Email // 
       
        LEFT JOIN
            (    
                SELECT
                    UCINN_ASCENDV2__CONTACT
                    ,UCINN_ASCENDV2__EMAIL_ADDRESS                                   AS Email
                    ,UCINN_ASCENDV2__TYPE                                            AS Type
                    ,CASE
                        WHEN UCINN_ASCENDV2__IS_PREFERRED = 'True'  THEN 'Yes'
                        ELSE                                             'No'
                        END                                                         AS IsPrimary                      
                    ,ROW_NUMBER () 
                        OVER(PARTITION BY 
                                UCINN_ASCENDV2__CONTACT
                                ,UCINN_ASCENDV2__TYPE 
                             ORDER BY 
                                NAME DESC)                                          AS EmailRank  
                FROM 
                    "OSUF_INTERFACES"."FACULTY_STAFF"."SF_EmailObject"
                WHERE
                    UCINN_ASCENDV2__IS_PREFERRED = 'True'
                    AND UCINN_ASCENDV2__STATUS = 'Current'
                QUALIFY
                    EmailRank = 1    
            ) emailpref ON c.ID = emailpref.UCINN_ASCENDV2__CONTACT
        LEFT JOIN
            (    
                SELECT
                    UCINN_ASCENDV2__CONTACT
                    ,UCINN_ASCENDV2__EMAIL_ADDRESS                                   AS Email
                    ,UCINN_ASCENDV2__TYPE                                            AS Type
                    ,CASE
                        WHEN UCINN_ASCENDV2__IS_PREFERRED = 'True'  THEN 'Yes'
                        ELSE                                             'No'
                        END                                                         AS IsPrimary                      
                    ,ROW_NUMBER () 
                        OVER(PARTITION BY 
                                UCINN_ASCENDV2__CONTACT
                                ,UCINN_ASCENDV2__TYPE 
                             ORDER BY 
                                NAME DESC)                                          AS EmailRank  
                FROM 
                    "OSUF_INTERFACES"."FACULTY_STAFF"."SF_EmailObject"
                WHERE
                    UCINN_ASCENDV2__IS_PREFERRED = 'False'
                    AND UCINN_ASCENDV2__TYPE = 'Personal'
                    AND UCINN_ASCENDV2__STATUS = 'Current'
                QUALIFY
                    EmailRank = 1    
            ) emailpersonal ON c.ID = emailpersonal.UCINN_ASCENDV2__CONTACT
        LEFT JOIN
            (    
                SELECT
                    UCINN_ASCENDV2__CONTACT
                    ,UCINN_ASCENDV2__EMAIL_ADDRESS                                   AS Email
                    ,UCINN_ASCENDV2__TYPE                                            AS Type
                    ,CASE
                        WHEN UCINN_ASCENDV2__IS_PREFERRED = 'True'  THEN 'Yes'
                        ELSE                                             'No'
                        END                                                         AS IsPrimary                      
                    ,ROW_NUMBER () 
                        OVER(PARTITION BY 
                                UCINN_ASCENDV2__CONTACT
                                ,UCINN_ASCENDV2__TYPE 
                             ORDER BY 
                                NAME DESC)                                          AS EmailRank  
                FROM 
                    "OSUF_INTERFACES"."FACULTY_STAFF"."SF_EmailObject"
                WHERE
                    UCINN_ASCENDV2__IS_PREFERRED = 'False'
                    AND UCINN_ASCENDV2__TYPE = 'Business'
                    AND UCINN_ASCENDV2__STATUS = 'Current'
                QUALIFY
                    EmailRank = 1    
            ) emailbus ON c.ID = emailbus.UCINN_ASCENDV2__CONTACT
        LEFT JOIN
            (    
                SELECT
                    UCINN_ASCENDV2__CONTACT
                    ,UCINN_ASCENDV2__EMAIL_ADDRESS                                   AS Email
                    ,UCINN_ASCENDV2__TYPE                                            AS Type
                    ,CASE
                        WHEN UCINN_ASCENDV2__IS_PREFERRED = 'True'  THEN 'Yes'
                        ELSE                                             'No'
                        END                                                         AS IsPrimary                      
                    ,ROW_NUMBER () 
                        OVER(PARTITION BY 
                                UCINN_ASCENDV2__CONTACT
                                ,UCINN_ASCENDV2__TYPE 
                             ORDER BY 
                                NAME DESC)                                          AS EmailRank  
                FROM 
                    "OSUF_INTERFACES"."FACULTY_STAFF"."SF_EmailObject"
                WHERE
                    UCINN_ASCENDV2__IS_PREFERRED = 'False'
                    AND UCINN_ASCENDV2__TYPE = 'Other'
                QUALIFY
                    EmailRank = 1    
            ) emailother ON c.ID = emailother.UCINN_ASCENDV2__CONTACT
            
// Phone//     
            
        LEFT JOIN
            (
                SELECT
                    UCINN_ASCENDV2__CONTACT
                    ,UCINN_ASCENDV2__PHONE_NUMBER                                   AS Phone
                    ,'Home'                                                         AS Type
                    ,CASE
                        WHEN UCINN_ASCENDV2__IS_PREFERRED = 'True'  THEN 'Yes'
                        ELSE                                             'No'
                        END                                                         AS IsPrimary                      
                    ,ROW_NUMBER () 
                        OVER(PARTITION BY 
                                UCINN_ASCENDV2__CONTACT
                                ,UCINN_ASCENDV2__TYPE 
                             ORDER BY 
                                NAME DESC)                                          AS PhoneRank  
                FROM 
                    "OSUF_INTERFACES"."FACULTY_STAFF"."SF_PhoneObject"
                WHERE
                    UCINN_ASCENDV2__TYPE = 'Home'
                    AND UCINN_ASCENDV2__STATUS = 'Current'
                QUALIFY
                    PhoneRank = 1
            ) phonehome ON c.ID = phonehome.UCINN_ASCENDV2__CONTACT
        LEFT JOIN
            (
                SELECT
                    UCINN_ASCENDV2__CONTACT
                    ,UCINN_ASCENDV2__PHONE_NUMBER                                   AS Phone
                    ,'Home Mobile'                                                  AS Type
                    ,CASE
                        WHEN UCINN_ASCENDV2__IS_PREFERRED = 'True'  THEN 'Yes'
                        ELSE                                             'No'
                        END                                                         AS IsPrimary                      
                    ,ROW_NUMBER () 
                        OVER(PARTITION BY 
                                UCINN_ASCENDV2__CONTACT
                                ,UCINN_ASCENDV2__TYPE 
                             ORDER BY 
                                NAME DESC)                                          AS PhoneRank  
                FROM 
                    "OSUF_INTERFACES"."FACULTY_STAFF"."SF_PhoneObject"
                WHERE
                    UCINN_ASCENDV2__TYPE = 'Mobile'
                    AND UCINN_ASCENDV2__STATUS = 'Current'
                QUALIFY
                    PhoneRank = 1
            ) mobilehome ON c.ID = mobilehome.UCINN_ASCENDV2__CONTACT
        LEFT JOIN
            (
                SELECT
                    UCINN_ASCENDV2__CONTACT
                    ,UCINN_ASCENDV2__PHONE_NUMBER                                   AS Phone
                    ,'Business'                                                     AS Type
                    ,CASE
                        WHEN UCINN_ASCENDV2__IS_PREFERRED = 'True'  THEN 'Yes'
                        ELSE                                             'No'
                        END                                                         AS IsPrimary                      
                    ,ROW_NUMBER () 
                        OVER(PARTITION BY 
                                UCINN_ASCENDV2__CONTACT
                                ,UCINN_ASCENDV2__TYPE 
                             ORDER BY 
                                NAME DESC)                                          AS PhoneRank  
                FROM 
                    "OSUF_INTERFACES"."FACULTY_STAFF"."SF_PhoneObject"
                WHERE
                    UCINN_ASCENDV2__TYPE = 'Business'
                    AND UCINN_ASCENDV2__STATUS = 'Current'
                QUALIFY
                    PhoneRank = 1
            ) phonebus ON c.ID = phonebus.UCINN_ASCENDV2__CONTACT
        LEFT JOIN
            (
                SELECT
                    UCINN_ASCENDV2__CONTACT
                    ,UCINN_ASCENDV2__PHONE_NUMBER                                   AS Phone
                    ,'Business Mobile'                                              AS Type
                    ,CASE
                        WHEN UCINN_ASCENDV2__IS_PREFERRED = 'True'  THEN 'Yes'
                        ELSE                                             'No'
                        END                                                         AS IsPrimary                      
                    ,ROW_NUMBER () 
                        OVER(PARTITION BY 
                                UCINN_ASCENDV2__CONTACT
                                ,UCINN_ASCENDV2__TYPE 
                             ORDER BY 
                                NAME DESC)                                          AS PhoneRank  
                FROM 
                    "OSUF_INTERFACES"."FACULTY_STAFF"."SF_PhoneObject"
                WHERE
                    UCINN_ASCENDV2__TYPE = 'Business Cell Phone'
                    AND UCINN_ASCENDV2__STATUS = 'Current'
                QUALIFY
                    PhoneRank = 1
            ) mobilebus ON c.ID = mobilebus.UCINN_ASCENDV2__CONTACT
            
// Address

        LEFT JOIN
            (
                SELECT
                    ar.UCINN_ASCENDV2__CONTACT                                                          
                    ,ar.UCINN_ASCENDV2__TYPE                                                            AS Type
                    ,a.UCINN_ASCENDV2__ADDRESS_LINE_1                                                   AS Line1
                    ,a.UCINN_ASCENDV2__ADDRESS_LINE_2                                                   AS Line2
                    ,CONCAT(a.UCINN_ASCENDV2__ADDRESS_LINE_3, ' ', a.UCINN_ASCENDV2__ADDRESS_LINE_4)    AS Line3
                    ,a.UCINN_ASCENDV2__CITY                                                             AS City
                    ,a.UCINN_ASCENDV2__STATE                                                            AS State
                    ,a.UCINN_ASCENDV2__COUNTY                                                           AS County
                    ,a.UCINN_ASCENDV2__COUNTRY                                                          AS Country
                    ,a.UCINN_ASCENDV2__POSTAL_CODE                                                      AS Zip
                    ,ar.UCINN_ASCENDV2__IS_PREFERRED                                                    AS IsPrimary
                    ,ROW_NUMBER() OVER  (PARTITION BY a.ID ORDER BY
                                            CASE 
                                                WHEN ar.UCINN_ASCENDV2__TYPE = 'Home' AND ar.UCINN_ASCENDV2__IS_PREFERRED = 'True'              THEN 1  
                                                WHEN ar.UCINN_ASCENDV2__TYPE = 'Home' AND ar.UCINN_ASCENDV2__IS_PREFERRED = 'False'             THEN 2
                                                WHEN ar.UCINN_ASCENDV2__TYPE LIKE 'GradLoad%' AND ar.UCINN_ASCENDV2__IS_PREFERRED = 'True'      THEN 10
                                                WHEN ar.UCINN_ASCENDV2__TYPE ='GradLoad Permanent'                                              THEN 11
                                                WHEN ar.UCINN_ASCENDV2__TYPE ='GradLoad Local'                                                  THEN 11
                                                WHEN ar.UCINN_ASCENDV2__TYPE ='GradLoad Next of Kin'                                            THEN 12
                                                ELSE 99
                                                END
                                            ,RE_DATE_MODIFIED DESC
                                        ) AS RankAddress
                FROM 
                    "OSUF_INTERFACES"."FACULTY_STAFF"."SF_AddressObject" a
                        INNER JOIN "OSUF_INTERFACES"."FACULTY_STAFF"."SF_AddressRelationObject" ar ON a.ID = ar.UCINN_ASCENDV2__ADDRESS
                WHERE
                    UCINN_ASCENDV2__STATUS = 'Current'
                    AND (UCINN_ASCENDV2__TYPE = 'Home'OR UCINN_ASCENDV2__TYPE LIKE 'GradLoad%')
                QUALIFY
                    RankAddress = 1
            ) AddressHome ON c.ID = AddressHome.UCINN_ASCENDV2__CONTACT
        LEFT JOIN
            (
                SELECT
                    ar.UCINN_ASCENDV2__CONTACT                                                          
                    ,ar.UCINN_ASCENDV2__TYPE                                                            AS Type
                    ,a.UCINN_ASCENDV2__ADDRESS_LINE_1                                                   AS Line1
                    ,a.UCINN_ASCENDV2__ADDRESS_LINE_2                                                   AS Line2
                    ,CONCAT(a.UCINN_ASCENDV2__ADDRESS_LINE_3, ' ', a.UCINN_ASCENDV2__ADDRESS_LINE_4)    AS Line3
                    ,a.UCINN_ASCENDV2__CITY                                                             AS City
                    ,a.UCINN_ASCENDV2__STATE                                                            AS State
                    ,a.UCINN_ASCENDV2__COUNTY                                                           AS County
                    ,a.UCINN_ASCENDV2__COUNTRY                                                          AS Country
                    ,a.UCINN_ASCENDV2__POSTAL_CODE                                                      AS Zip
                    ,ar.UCINN_ASCENDV2__IS_PREFERRED                                                    AS IsPrimary
                    ,ROW_NUMBER() OVER  (PARTITION BY a.ID ORDER BY
                                            CASE 
                                                WHEN ar.UCINN_ASCENDV2__TYPE = 'Business' AND ar.UCINN_ASCENDV2__IS_PREFERRED = 'True'          THEN 1
                                                WHEN ar.UCINN_ASCENDV2__TYPE = 'Business' AND ar.UCINN_ASCENDV2__IS_PREFERRED = 'False'         THEN 2  
                                                ELSE 99
                                                END
                                            ,RE_DATE_MODIFIED DESC
                                        ) AS RankAddress
                FROM 
                    "OSUF_INTERFACES"."FACULTY_STAFF"."SF_AddressObject" a
                        INNER JOIN "OSUF_INTERFACES"."FACULTY_STAFF"."SF_AddressRelationObject" ar ON a.ID = ar.UCINN_ASCENDV2__ADDRESS
                WHERE
                    UCINN_ASCENDV2__STATUS = 'Current'
                    AND UCINN_ASCENDV2__TYPE = 'Business'
                QUALIFY
                    RankAddress = 1
            ) AddressBus ON c.ID = AddressBus.UCINN_ASCENDV2__CONTACT