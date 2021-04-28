CREATE OR REPLACE TABLE "OSUADV_PROD"."ASCEND"."Contact"
(
	AccountId nvarchar(18) NULL,
	American_Indian_Tribal_Affiliation STRING NULL,
	American_Osteopathic_Association_ID nvarchar(50) NULL,
	AssistantName nvarchar(40) NULL,
	AssistantPhone nvarchar(40) NULL,
	Athletics_Ticketmaster_ID nvarchar(50) NULL,
	Athletics_Ticketmaster_ID2 nvarchar(50) NULL,
	AudienceView_Contact_ID nvarchar(50) NULL,
	AudienceView_Customer_Number nvarchar(50) NULL,
	Birthdate nvarchar(20) NULL,
	CVM_Client_ID nvarchar(50) NULL,
	CVM_Client_ID2 nvarchar(50) NULL,
	CWID nvarchar(230) NULL,
	Campus_ID nvarchar(50) NULL,
	Campus_ID_Former nvarchar(50) NULL,
	Case nvarchar(18) NULL,
	Chrome_River_Login_ID nvarchar(50) NULL,
	Date_of_Birth_Note STRING NULL,
	Department nvarchar(80) NULL,
	Description STRING NULL,
	DoNotCall nvarchar(10) NULL,
	Email nvarchar(80) NULL,
	EmailBouncedDate varchar(50) NULL,
	EmailBouncedReason nvarchar(255) NULL,
	Essenza_Membership_ID nvarchar(50) NULL,
	Essenza_Unique_ID nvarchar(50) NULL,
	Fax nvarchar(40) NULL,
	FirstName nvarchar(40) NULL,
	HasOptedOutOfEmail nvarchar(10) NULL,
	HasOptedOutOfFax nvarchar(10) NULL,
	Historic_Campus_ID nvarchar(50) NULL,
	HomePhone nvarchar(40) NULL,
	Id nvarchar(18) NULL,
	Inactive_Constituent nvarchar(10) NULL,
	Inactive_Reason nvarchar(255) NULL,
	IndividualId nvarchar(18) NULL,
	IsDeleted nvarchar(10) NULL,
	IsEmailBounced nvarchar(10) NULL,
	Jigsaw nvarchar(20) NULL,
	JigsawContactId nvarchar(20) NULL,
	KOSU_Allegiance_ID nvarchar(50) NULL,
	KOSU_Allegiance_ID2 nvarchar(50) NULL,
	LastActivityDate nvarchar(20) NULL,
	LastCURequestDate nvarchar(20) NULL,
	LastCUUpdateDate nvarchar(20) NULL,
	LastName nvarchar(80) NULL,
	LastReferencedDate nvarchar(20) NULL,
	LastViewedDate nvarchar(20) NULL,
	Latest_Briefing STRING NULL,
	LeadSource nvarchar(255) NULL,
	Legacy_Merged_From_ID nvarchar(255) NULL,
	LexID nvarchar(50) NULL,
	Lost_Constituent_Date nvarchar(20) NULL,
	Lost_Constituent_Notes STRING NULL,
	Maiden_Name nvarchar(255) NULL,
	MailingAddress STRING NULL,
	MailingCity nvarchar(40) NULL,
	MailingCountry nvarchar(80) NULL,
	MailingGeocodeAccuracy nvarchar(255) NULL,
	MailingLatitude nvarchar(40) NULL,
	MailingLongitude nvarchar(40) NULL,
	MailingPostalCode nvarchar(20) NULL,
	MailingState nvarchar(80) NULL,
	MailingStreet nvarchar(255) NULL,
	Matching_Key_Value_1 nvarchar(18) NULL,
	Matching_Key_Value_2 nvarchar(18) NULL,
	Matching_Key_Value_3 nvarchar(18) NULL,
	MiddleName nvarchar(40) NULL,
	MobilePhone nvarchar(40) NULL,
	NDA_Signed nvarchar(10) NULL,
	NDA_Signed_Date nvarchar(20) NULL,
	Name nvarchar(121) NULL,
	Nickname nvarchar(255) NULL,
	Number_of_External_IDs varchar(40) NULL,
	Obituary STRING NULL,
	Obituary_on_file nvarchar(10) NULL,
	OtherAddress STRING NULL,
	OtherCity nvarchar(40) NULL,
	OtherCountry nvarchar(80) NULL,
	OtherGeocodeAccuracy nvarchar(255) NULL,
	OtherLatitude varchar(40) NULL,
	OtherLongitude varchar(40) NULL,
	OtherPhone nvarchar(40) NULL,
	OtherPostalCode nvarchar(20) NULL,
	OtherState nvarchar(80) NULL,
	OtherStreet nvarchar(255) NULL,
	OwnerId nvarchar(18) NULL,
	Phone nvarchar(40) NULL,
	PhotoUrl nvarchar(255) NULL,
	Primary_Academic_Program nvarchar(18) NULL,
	Primary_Department nvarchar(18) NULL,
	Primary_Educational_Institution nvarchar(18) NULL,
	Primary_Sports_Organization nvarchar(18) NULL,
	Primary_Student_Organization nvarchar(18) NULL,
	RE_Added_By nvarchar(80) NULL,
	RE_Date_Modified nvarchar(20) NULL,
	RE_Last_Changed_By nvarchar(80) NULL,
	RecordTypeId nvarchar(18) NULL,
	ReportsToId nvarchar(18) NULL,
	Salutation nvarchar(255) NULL,
	Suffix nvarchar(40) NULL,
	Title nvarchar(128) NULL,
	Total_Active_Proposals nvarchar(40) NULL,
	Total_Active_Strategies nvarchar(40) NULL,
	iModules_Member_ID nvarchar(50) NULL,
	ucinn_ascendv2__Action_Center_News_Topics_Subscription STRING NULL,
	ucinn_ascendv2__Action_Center_Panel_Displayed STRING NULL,
	ucinn_ascendv2__Active_Directory_Username nvarchar(20) NULL,
	ucinn_ascendv2__Age_Formula nvarchar(40) NULL,
	ucinn_ascendv2__American_Medical_Association_ID nvarchar(255) NULL,
	ucinn_ascendv2__Amount_of_First_Gift nvarchar(40) NULL,
	ucinn_ascendv2__Amount_of_First_Pledge nvarchar(40) NULL,
	ucinn_ascendv2__Amount_of_First_Pledge_Payment nvarchar(40) NULL,
	ucinn_ascendv2__Amount_of_Largest_Gift nvarchar(40) NULL,
	ucinn_ascendv2__Amount_of_Largest_Pledge nvarchar(40) NULL,
	ucinn_ascendv2__Amount_of_Largest_Pledge_Payment varchar(40) NULL,
	ucinn_ascendv2__Amount_of_Most_Recent_Gift varchar(40) NULL,
	ucinn_ascendv2__Amount_of_Most_Recent_Pledge varchar(40) NULL,
	ucinn_ascendv2__Amount_of_Most_Recent_Pledge_Payment varchar(40) NULL,
	ucinn_ascendv2__Annual_Giving_Group_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Appeal_of_First_Gift nvarchar(18) NULL,
	ucinn_ascendv2__Appeal_of_First_Pledge nvarchar(18) NULL,
	ucinn_ascendv2__Appeal_of_First_Pledge_Payment nvarchar(18) NULL,
	ucinn_ascendv2__Appeal_of_Largest_Gift nvarchar(18) NULL,
	ucinn_ascendv2__Appeal_of_Largest_Pledge nvarchar(18) NULL,
	ucinn_ascendv2__Appeal_of_Largest_Pledge_Payment nvarchar(18) NULL,
	ucinn_ascendv2__Appeal_of_Most_Recent_Gift nvarchar(80) NULL,
	ucinn_ascendv2__Appeal_of_Most_Recent_Gift_Lookup nvarchar(18) NULL,
	ucinn_ascendv2__Appeal_of_Most_Recent_Pledge nvarchar(80) NULL,
	ucinn_ascendv2__Appeal_of_Most_Recent_Pledge_Lookup nvarchar(18) NULL,
	ucinn_ascendv2__Appeal_of_Most_Recent_Pledge_Payment nvarchar(80) NULL,
	ucinn_ascendv2__Appeal_of_Most_Recent_Pledge_Pymt_Lookup nvarchar(18) NULL,
	ucinn_ascendv2__BIO_Changed_Since_Date varchar(20) NULL,
	ucinn_ascendv2__Birth_Day nvarchar(255) NULL,
	ucinn_ascendv2__Birth_Month nvarchar(255) NULL,
	ucinn_ascendv2__Birth_Year nvarchar(255) NULL,
	ucinn_ascendv2__Business_Email nvarchar(80) NULL,
	ucinn_ascendv2__Business_Unit nvarchar(255) NULL,
	ucinn_ascendv2__Campaign_Total_Cash varchar(40) NULL,
	ucinn_ascendv2__Campus_Email nvarchar(80) NULL,
	ucinn_ascendv2__Cancer_Center_Physician_CMM_Code nvarchar(100) NULL,
	ucinn_ascendv2__Cancer_Center_Physician_CMM_Description nvarchar(255) NULL,
	ucinn_ascendv2__Constituent_Count_Formula varchar(40) NULL,
	ucinn_ascendv2__Contact_Type STRING NULL,
	ucinn_ascendv2__Data_Source nvarchar(255) NULL,
	ucinn_ascendv2__Date_Marked_Deceased varchar(20) NULL,
	ucinn_ascendv2__Date_Marked_Duplicate varchar(20) NULL,
	ucinn_ascendv2__Date_of_First_Gift varchar(20) NULL,
	ucinn_ascendv2__Date_of_First_Pledge varchar(20) NULL,
	ucinn_ascendv2__Date_of_First_Pledge_Payment varchar(20) NULL,
	ucinn_ascendv2__Date_of_Largest_Gift varchar(20) NULL,
	ucinn_ascendv2__Date_of_Largest_Pledge varchar(20) NULL,
	ucinn_ascendv2__Date_of_Largest_Pledge_Payment varchar(20) NULL,
	ucinn_ascendv2__Date_of_Most_Recent_Gift varchar(20) NULL,
	ucinn_ascendv2__Date_of_Most_Recent_Pledge varchar(20) NULL,
	ucinn_ascendv2__Date_of_Most_Recent_Pledge_Payment varchar(20) NULL,
	ucinn_ascendv2__Deceased_Date varchar(20) NULL,
	ucinn_ascendv2__Deceased_Day nvarchar(255) NULL,
	ucinn_ascendv2__Deceased_Month nvarchar(255) NULL,
	ucinn_ascendv2__Deceased_Source nvarchar(255) NULL,
	ucinn_ascendv2__Deceased_Year nvarchar(255) NULL,
	ucinn_ascendv2__Degree_Count_Roll_Up varchar(40) NULL,
	ucinn_ascendv2__Degree_Year_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Degree_Year_Roll_Up varchar(40) NULL,
	ucinn_ascendv2__Designation_of_First_Gift nvarchar(80) NULL,
	ucinn_ascendv2__Designation_of_First_Gift_Lookup nvarchar(18) NULL,
	ucinn_ascendv2__Designation_of_First_PP_Lookup nvarchar(18) NULL,
	ucinn_ascendv2__Designation_of_First_Pledge_Lookup nvarchar(18) NULL,
	ucinn_ascendv2__Designation_of_Largest_Gift nvarchar(80) NULL,
	ucinn_ascendv2__Designation_of_Largest_Gift_Lookup nvarchar(18) NULL,
	ucinn_ascendv2__Designation_of_Largest_PP_Lookup nvarchar(18) NULL,
	ucinn_ascendv2__Designation_of_Largest_Pledge nvarchar(80) NULL,
	ucinn_ascendv2__Designation_of_Largest_Pledge_Lookup nvarchar(18) NULL,
	ucinn_ascendv2__Designation_of_Largest_Pledge_Payment nvarchar(80) NULL,
	ucinn_ascendv2__Designation_of_Most_Recent_Gift nvarchar(80) NULL,
	ucinn_ascendv2__Designation_of_Most_Recent_Gift_Lookup nvarchar(18) NULL,
	ucinn_ascendv2__Designation_of_Most_Recent_PP_Lookup nvarchar(18) NULL,
	ucinn_ascendv2__Designation_of_Most_Recent_Pledge nvarchar(80) NULL,
	ucinn_ascendv2__Designation_of_Most_Recent_Pledge_Lookup nvarchar(18) NULL,
	ucinn_ascendv2__Designation_of_Most_Recent_Pledge_Paymt nvarchar(80) NULL,
	ucinn_ascendv2__Distance_From_Target varchar(40) NULL,
	ucinn_ascendv2__Do_Not_Automatically_Update nvarchar(10) NULL,
	ucinn_ascendv2__Do_Not_Call nvarchar(10) NULL,
	ucinn_ascendv2__Do_Not_Email nvarchar(10) NULL,
	ucinn_ascendv2__Do_Not_Mail nvarchar(10) NULL,
	ucinn_ascendv2__Do_Not_Solicit nvarchar(10) NULL,
	ucinn_ascendv2__Do_Receive_Action_Center_Notification nvarchar(10) NULL,
	ucinn_ascendv2__Do_Receive_Household_Soft_Credit nvarchar(10) NULL,
	ucinn_ascendv2__Donor_ID nvarchar(50) NULL,
	ucinn_ascendv2__Earliest_Grad_Degree_Info nvarchar(255) NULL,
	ucinn_ascendv2__Earliest_UG_Degree_Info nvarchar(255) NULL,
	ucinn_ascendv2__Email_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Enrollment_Status nvarchar(255) NULL,
	ucinn_ascendv2__Ethnicity STRING NULL,
	ucinn_ascendv2__Expanded_Name_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Expected_Donation_Amount varchar(40) NULL,
	ucinn_ascendv2__External_System_ID nvarchar(255) NULL,
	ucinn_ascendv2__First_Name_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__First_and_Last_Name_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Fiscal_Year_First_Gift_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Fiscal_Year_Last_Gift_Formula varchar(40) NULL,
	ucinn_ascendv2__Full_Name_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Full_Name_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Gender nvarchar(255) NULL,
	ucinn_ascendv2__Giving_Summary_Last_Updated varchar(20) NULL,
	ucinn_ascendv2__Home_City_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Home_Country_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Home_Phone_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Home_Postal_Code_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Home_State_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Home_Street_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Hospital_Physician_CMM_Group_Code nvarchar(100) NULL,
	ucinn_ascendv2__Hospital_Physician_CMM_Group_Description nvarchar(255) NULL,
	ucinn_ascendv2__In_Care_Of_Home nvarchar(255) NULL,
	ucinn_ascendv2__In_Care_Of_Mailing nvarchar(255) NULL,
	ucinn_ascendv2__In_Care_Of_Other nvarchar(255) NULL,
	ucinn_ascendv2__In_Care_Of_Preferred nvarchar(255) NULL,
	ucinn_ascendv2__Is_Actual_Birthday nvarchar(10) NULL,
	ucinn_ascendv2__Is_All_Services_Hold nvarchar(10) NULL,
	ucinn_ascendv2__Is_Business_Preferred nvarchar(10) NULL,
	ucinn_ascendv2__Is_Confidential nvarchar(10) NULL,
	ucinn_ascendv2__Is_Deceased nvarchar(10) NULL,
	ucinn_ascendv2__Is_First_Generation nvarchar(10) NULL,
	ucinn_ascendv2__Is_First_Time_Donor_Formula nvarchar(10) NULL,
	ucinn_ascendv2__Is_Home_Preferred nvarchar(10) NULL,
	ucinn_ascendv2__Is_Name_Overridden nvarchar(10) NULL,
	ucinn_ascendv2__Is_Online_Payment_Update_Required nvarchar(10) NULL,
	ucinn_ascendv2__Is_Possible_Duplicate_Checked nvarchar(10) NULL,
	ucinn_ascendv2__Is_Recognition_Name_Overridden nvarchar(10) NULL,
	ucinn_ascendv2__Is_Scholarship nvarchar(10) NULL,
	ucinn_ascendv2__Is_School_Employee_Formula nvarchar(10) NULL,
	ucinn_ascendv2__Is_School_of_Medicine_Friend nvarchar(10) NULL,
	ucinn_ascendv2__Is_Super_Confidential nvarchar(10) NULL,
	ucinn_ascendv2__Is_Trustee_Formula nvarchar(10) NULL,
	ucinn_ascendv2__Is_Trustee_With_Spouse_Formula nvarchar(10) NULL,
	ucinn_ascendv2__Jewish_Alumni_ID nvarchar(15) NULL,
	ucinn_ascendv2__Last_Name_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Level nvarchar(255) NULL,
	ucinn_ascendv2__Lifetime_Cash varchar(40) NULL,
	ucinn_ascendv2__Lifetime_Cash_No_Trustee_Formula varchar(40) NULL,
	ucinn_ascendv2__Lifetime_Fundraising varchar(40) NULL,
	ucinn_ascendv2__Lifetime_Fundraising_No_Trustee_Formula varchar(40) NULL,
	ucinn_ascendv2__Likelihood_To_Donate varchar(40) NULL,
	ucinn_ascendv2__Lost nvarchar(255) NULL,
	ucinn_ascendv2__Managers nvarchar(1000) NULL,
	ucinn_ascendv2__Marital_Status nvarchar(255) NULL,
	ucinn_ascendv2__Master_Contact nvarchar(18) NULL,
	ucinn_ascendv2__Middle_Name_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Number_of_Consecutive_Giving varchar(40) NULL,
	ucinn_ascendv2__Online_Payment_Customer_ID nvarchar(255) NULL,
	ucinn_ascendv2__Other_Email nvarchar(80) NULL,
	ucinn_ascendv2__PRM nvarchar(18) NULL,
	ucinn_ascendv2__PRM_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Patient_ID nvarchar(255) NULL,
	ucinn_ascendv2__Payroll_ID nvarchar(50) NULL,
	ucinn_ascendv2__Personal_Email nvarchar(80) NULL,
	ucinn_ascendv2__Phy_Echo_Board_Speciality_1 nvarchar(255) NULL,
	ucinn_ascendv2__Phy_Echo_Board_Speciality_2 nvarchar(255) NULL,
	ucinn_ascendv2__Phy_Echo_Board_Speciality_3 nvarchar(255) NULL,
	ucinn_ascendv2__Phy_Echo_Board_Speciality_4 nvarchar(255) NULL,
	ucinn_ascendv2__Phy_Echo_Department_1 nvarchar(255) NULL,
	ucinn_ascendv2__Phy_Echo_Department_2 nvarchar(255) NULL,
	ucinn_ascendv2__Phy_Echo_Department_3 nvarchar(255) NULL,
	ucinn_ascendv2__Phy_Echo_Speciality nvarchar(255) NULL,
	ucinn_ascendv2__Physician_Department nvarchar(100) NULL,
	ucinn_ascendv2__Physician_ID nvarchar(100) NULL,
	ucinn_ascendv2__Picture_Record_ID nvarchar(255) NULL,
	ucinn_ascendv2__Preferred_Address_City nvarchar(255) NULL,
	ucinn_ascendv2__Preferred_Address_Country nvarchar(80) NULL,
	ucinn_ascendv2__Preferred_Address_County nvarchar(255) NULL,
	ucinn_ascendv2__Preferred_Address_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Preferred_Address_Geolocation STRING NULL,
	ucinn_ascendv2__Preferred_Address_Geolocation__Latitude varchar(40) NULL,
	ucinn_ascendv2__Preferred_Address_Geolocation__Longitude varchar(40) NULL,
	ucinn_ascendv2__Preferred_Address_Line_1 nvarchar(255) NULL,
	ucinn_ascendv2__Preferred_Address_Line_2 nvarchar(255) NULL,
	ucinn_ascendv2__Preferred_Address_Line_3 nvarchar(255) NULL,
	ucinn_ascendv2__Preferred_Address_Line_4 nvarchar(255) NULL,
	ucinn_ascendv2__Preferred_Address_Postal_Code nvarchar(20) NULL,
	ucinn_ascendv2__Preferred_Address_State nvarchar(80) NULL,
	ucinn_ascendv2__Preferred_Address_Type nvarchar(255) NULL,
	ucinn_ascendv2__Preferred_Class_Year nvarchar(4) NULL,
	ucinn_ascendv2__Preferred_Class_Year_Integer_Formula varchar(40) NULL,
	ucinn_ascendv2__Preferred_Class_Year_Type nvarchar(25) NULL,
	ucinn_ascendv2__Preferred_Email_Type nvarchar(255) NULL,
	ucinn_ascendv2__Preferred_Gender nvarchar(255) NULL,
	ucinn_ascendv2__Preferred_Mailing_Address_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Preferred_Mailing_Type nvarchar(40) NULL,
	ucinn_ascendv2__Preferred_Phone_Type nvarchar(255) NULL,
	ucinn_ascendv2__Preferred_Pronouns nvarchar(255) NULL,
	ucinn_ascendv2__Preferred_Spouse nvarchar(18) NULL,
	ucinn_ascendv2__Presidential_Business_Address_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Presidential_Business_City nvarchar(255) NULL,
	ucinn_ascendv2__Presidential_Business_Country nvarchar(80) NULL,
	ucinn_ascendv2__Presidential_Business_Postal_Code nvarchar(20) NULL,
	ucinn_ascendv2__Presidential_Business_State nvarchar(80) NULL,
	ucinn_ascendv2__Presidential_Business_Street nvarchar(255) NULL,
	ucinn_ascendv2__Presidential_Home_Address_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Presidential_Home_City nvarchar(255) NULL,
	ucinn_ascendv2__Presidential_Home_Country nvarchar(80) NULL,
	ucinn_ascendv2__Presidential_Home_Postal_Code nvarchar(20) NULL,
	ucinn_ascendv2__Presidential_Home_State nvarchar(80) NULL,
	ucinn_ascendv2__Presidential_Home_Street nvarchar(255) NULL,
	ucinn_ascendv2__Presidential_Mailing_Address_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Presidential_Mailing_City nvarchar(255) NULL,
	ucinn_ascendv2__Presidential_Mailing_Country nvarchar(80) NULL,
	ucinn_ascendv2__Presidential_Mailing_Postal_Code nvarchar(20) NULL,
	ucinn_ascendv2__Presidential_Mailing_State nvarchar(80) NULL,
	ucinn_ascendv2__Presidential_Mailing_Street nvarchar(255) NULL,
	ucinn_ascendv2__Presidential_Mailing_Street_v1 nvarchar(255) NULL,
	ucinn_ascendv2__Presidential_Other_Address_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Presidential_Other_City nvarchar(255) NULL,
	ucinn_ascendv2__Presidential_Other_Country nvarchar(80) NULL,
	ucinn_ascendv2__Presidential_Other_Postal_Code nvarchar(20) NULL,
	ucinn_ascendv2__Presidential_Other_State nvarchar(80) NULL,
	ucinn_ascendv2__Presidential_Other_Street nvarchar(255) NULL,
	ucinn_ascendv2__Presidential_Other_Street_v1 nvarchar(255) NULL,
	ucinn_ascendv2__Presidential_Preferred_Address_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Presidential_Preferred_City nvarchar(255) NULL,
	ucinn_ascendv2__Presidential_Preferred_Country nvarchar(80) NULL,
	ucinn_ascendv2__Presidential_Preferred_Postal_Code nvarchar(20) NULL,
	ucinn_ascendv2__Presidential_Preferred_State nvarchar(80) NULL,
	ucinn_ascendv2__Presidential_Preferred_Street nvarchar(255) NULL,
	ucinn_ascendv2__Primary_Contact_Type nvarchar(255) NULL,
	ucinn_ascendv2__Primary_Contact_Type_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Professional_Designation STRING NULL,
	ucinn_ascendv2__Profile_Image STRING NULL,
	ucinn_ascendv2__Profile_Picture_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Recognition_Name nvarchar(255) NULL,
	ucinn_ascendv2__Religious_Preference nvarchar(255) NULL,
	ucinn_ascendv2__Salutation_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Salutation_Preference nvarchar(255) NULL,
	ucinn_ascendv2__School nvarchar(60) NULL,
	ucinn_ascendv2__School_Grateful_Patient_ID nvarchar(255) NULL,
	ucinn_ascendv2__School_ID nvarchar(15) NULL,
	ucinn_ascendv2__School_Radio_Station_ID nvarchar(50) NULL,
	ucinn_ascendv2__Source nvarchar(255) NULL,
	ucinn_ascendv2__Spouse_Donor_ID_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Spouse_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Stage_of_Readiness nvarchar(255) NULL,
	ucinn_ascendv2__Stage_of_Readiness_Last_Modified_By nvarchar(50) NULL,
	ucinn_ascendv2__Stage_of_Readiness_Last_Modified_Date varchar(20) NULL,
	ucinn_ascendv2__Student_Information_System_ID nvarchar(50) NULL,
	ucinn_ascendv2__Subscription_ID nvarchar(255) NULL,
	ucinn_ascendv2__Suffix_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Top_25_Prospect STRING NULL,
	ucinn_ascendv2__Total_Campaign_Fundraising varchar(40) NULL,
	ucinn_ascendv2__Undergrad_Grad_Degree_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Undergrad_Grad_Degree_No_Trustee_Formula nvarchar(1300) NULL,
	ucinn_ascendv2__Unit nvarchar(255) NULL,
	ucinn_ascendv2__Unit_of_First_Gift nvarchar(255) NULL,
	ucinn_ascendv2__Unit_of_First_Pledge nvarchar(255) NULL,
	ucinn_ascendv2__Unit_of_First_Pledge_Payment nvarchar(255) NULL,
	ucinn_ascendv2__Unit_of_Largest_Gift nvarchar(255) NULL,
	ucinn_ascendv2__Unit_of_Largest_Pledge nvarchar(255) NULL,
	ucinn_ascendv2__Unit_of_Largest_Pledge_Payment nvarchar(255) NULL,
	ucinn_ascendv2__Unit_of_Most_Recent_Gift nvarchar(255) NULL,
	ucinn_ascendv2__Unit_of_Most_Recent_Pledge nvarchar(255) NULL,
	ucinn_ascendv2__Unit_of_Most_Recent_Pledge_Payment nvarchar(255) NULL,
	ucinn_ascendv2__Wealth_Last_Rating_Date_Time varchar(20) NULL,
	ucinn_ascendv2__Wealth_Rating nvarchar(100) NULL,
	ucinn_ascendv2__Wealth_Rating_Days_Diff_Formula varchar(40) NULL,
	ucinn_ascendv2__Wealth_Rating_Formula nvarchar(1300) NULL
)




