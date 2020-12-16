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
    
    
    ,COALESCE(homephone.Phone, '')                                  AS Phone1Phone
    ,COALESCE(homephone.Type, '')                                   AS Phone1Type
    ,COALESCE(homephone.IsPrimary, '')                              AS Phone1IsPrimary
    ,COALESCE(homemobile.Phone, '')                                 AS Phone2Phone
    ,COALESCE(homemobile.Type, '')                                  AS Phone2Type
    ,COALESCE(homemobile.IsPrimary, '')                             AS Phone2IsPrimary
    ,COALESCE(busphone.Phone, '')                                   AS Phone3Phone
    ,COALESCE(busphone.Type, '')                                    AS Phone3Type
    ,COALESCE(busphone.IsPrimary, '')                               AS Phone3IsPrimary
    ,COALESCE(busmobile.Phone, '')                                  AS Phone4Phone
    ,COALESCE(busmobile.Type, '')                                   AS Phone4Type
    ,COALESCE(busmobile.IsPrimary, '')                              AS Phone4IsPrimary
FROM
    "OSUF_INTERFACES"."FACULTY_STAFF"."SF_ContactObject" c
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
            ) homephone ON c.ID = homephone.UCINN_ASCENDV2__CONTACT
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
            ) homemobile ON c.ID = homemobile.UCINN_ASCENDV2__CONTACT
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
            ) busphone ON c.ID = busphone.UCINN_ASCENDV2__CONTACT
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
            ) busmobile ON c.ID = busmobile.UCINN_ASCENDV2__CONTACT