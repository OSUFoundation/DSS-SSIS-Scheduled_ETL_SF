USE OSUADV_PROD.BI;

/*============================================================================================
--
--Description: Sement Code translation from Segment Name
--
============================================================================================*/

CREATE OR REPLACE TABLE DNRCNCT_STATIC_SegmentCode 
    (
         segmentName     varchar(100)
        ,segmentCode     varchar(100)
    );

INSERT INTO DNRCNCT_STATIC_SegmentCode

select 'Academic Affairs 1 Yr Lapsed'segmentName            			,'ACAF_1YR' segmentCode
union select 'Academic Affairs 2-3 Yr Lapsed'segmentName    			,'ACAF_2-3YR' segmentCode
union select 'Academic Affairs 4+ 10-20'segmentName						,'ACAF_4YR_10-20' segmentCode
union select 'Academic Affairs 4+ Under 10'segmentName					,'ACAF_4YR_U10' segmentCode
union select 'Academic Affairs Nons'segmentName							,'ACAF_NONS' segmentCode
union select 'Alumni Association 1 Yr Lapsed'segmentName				,'AA_1YR' segmentCode
union select 'Alumni Association 2-3 Yr Lapsed'segmentName				,'AA_2-3YR' segmentCode
union select 'Alumni Association 4+ 10-20'segmentName					,'AA_4YR_10-20' segmentCode
union select 'Alumni Association 4+ Under 10'segmentName				,'AA_4YR_U10' segmentCode
union select 'Alumni Association Nons'segmentName						,'AA_NONS' segmentCode
union select 'Athletics 1 Yr Lapsed'segmentName							,'ATH_1YR' segmentCode
union select 'Athletics 2-3 Yr Lapsed'segmentName						,'ATH_2-3YR' segmentCode
union select 'Athletics 4+ 10-20'segmentName							,'ATH_4YR_10-20' segmentCode
union select 'Athletics 4+ Under 10'segmentName							,'ATH_4YR_U10' segmentCode
union select 'Athletics Nons'segmentName								,'ATH_NONS' segmentCode
union select 'Call Center 1 Yr Lapsed New and Reactivated'segmentName	,'CC_Donor' segmentCode
union select 'CAS 1 Yr Lapsed'segmentName								,'CAS_1YR' segmentCode
union select 'CAS 1 Yr Lapsed New and Reactivated'segmentName			,'CAS_1YR_NR' segmentCode
union select 'CAS 2-3 Yr Lapsed'segmentName								,'CAS_2-3YR' segmentCode
union select 'CAS 2-3 Yr Lapsed New and Reactivated'segmentName			,'CAS_2-3YR_NR' segmentCode
union select 'CAS 4+ 10-20'segmentName									,'CAS_4YR_10-20' segmentCode
union select 'CAS 4+ Under 10'segmentName								,'CAS_4YR_U10' segmentCode
union select 'CAS Nons'segmentName										,'CAS_NONS' segmentCode
union select 'CAS Nons 11+'segmentName									,'CAS_NONS_11+' segmentCode
union select 'CAS Nons 80-10'segmentName								,'CAS_NONS_80-10' segmentCode
union select 'CAS Nons Pre 80'segmentName								,'CAS_NONS_P80' segmentCode
union select 'CEAT 1 Yr Lapsed'segmentName								,'CEAT_1YR' segmentCode
union select 'CEAT 1 Yr Lapsed New and Reactivated'segmentName			,'CEAT_1YR_NR' segmentCode
union select 'CEAT 2-3 Yr Lapsed'segmentName							,'CEAT_2-3YR' segmentCode
union select 'CEAT 2-3 Yr Lapsed New and Reactivated'segmentName		,'CEAT_2-3YR_NR' segmentCode
union select 'CEAT 4+ 10-20 Yr'segmentName								,'CEAT_4YR_10-20' segmentCode
union select 'CEAT 4+ Under 10'segmentName								,'CEAT_4YR_U10' segmentCode
union select 'CEAT Nons'segmentName										,'CEAT_NONS' segmentCode
union select 'CEAT Nons 11+'segmentName									,'CEAT_NONS_11+' segmentCode
union select 'CEAT Nons 80-10'segmentName								,'CEAT_NONS_80-10' segmentCode
union select 'CEAT Nons Pre 80'segmentName								,'CEAT_NONS_P80' segmentCode
union select 'CEHS 1 Yr Lapsed'segmentName								,'CEHS_1YR' segmentCode
union select 'CEHS 1 Yr Lapsed New and Reactivated'segmentName			,'CEHS_YR_NR' segmentCode
union select 'CEHS 2-3 Yr Lapsed'segmentName							,'CEHS_2-3YR' segmentCode
union select 'CEHS 2-3 Yr Lapsed New and Reactivated'segmentName		,'CEHS_2-3YR_NR' segmentCode
union select 'CEHS 4+ 10-20'segmentName									,'CEHS_4YR_10-20' segmentCode
union select 'CEHS 4+ Under 10'segmentName								,'CEHS_4YR_U10' segmentCode
union select 'CEHS Nons'segmentName										,'CEHS_NONS' segmentCode
union select 'CEHS Nons 11+'segmentName									,'CEHS_NONS_11+' segmentCode
union select 'CEHS Nons 80-10'segmentName								,'CEHS_NONS_80-10' segmentCode
union select 'CEHS Nons Pre 80'segmentName								,'CEHS_NONS_P80' segmentCode
union select 'CVM 1 Yr Lapsed'segmentName								,'CVM_1YR' segmentCode
union select 'CVM 1 Yr Lapsed New and Reactivated'segmentName			,'CVM_1YR_NR' segmentCode
union select 'CVM 2-3 Yr Lapsed'segmentName								,'CVM_2-3YR' segmentCode
union select 'CVM 2-3 Yr Lapsed New and Reactivated'segmentName			,'CVM_2-3YR_NR' segmentCode
union select 'CVM 4+ 10-20'segmentName									,'CVM_4YR_10-20' segmentCode
union select 'CVM 4+ Under 10'segmentName								,'CVM_4YR_U10' segmentCode
union select 'CVM Nons'segmentName										,'CVM_NONS' segmentCode
union select 'CVM Nons 11+'segmentName									,'CVM_NONS_11+' segmentCode
union select 'CVM Nons 80-10'segmentName								,'CVM_NONS_80-10' segmentCode
union select 'CVM Nons Pre 80'segmentName								,'CVM_NONS_P80' segmentCode
union select 'DASNR 1 Yr Lapsed'segmentName								,'DASNR_1YR' segmentCode
union select 'DASNR 1 Yr Lapsed New and Reactivated'segmentName			,'DASNR_1YR_NR' segmentCode
union select 'DASNR 2-3 Yr Lapsed'segmentName							,'DASNR_2-3YR' segmentCode
union select 'DASNR 2-3 Yr Lapsed New and Reactivated'segmentName		,'DASNR_2-3YR_NR' segmentCode
union select 'DASNR 4+ 10-20 Yr'segmentName								,'DASNR_4YR_10-20' segmentCode
union select 'DASNR 4+ Under 10'segmentName								,'DASNR_4YR_U10' segmentCode
union select 'DASNR Nons'segmentName									,'DASNR_NONS' segmentCode
union select 'DASNR Nons 11+'segmentName								,'DASNR_NONS_11+' segmentCode
union select 'DASNR Nons 80-10'segmentName								,'DASNR_NONS_80-10' segmentCode
union select 'DASNR Nons Pre 80'segmentName								,'DASNR_NONS_P80' segmentCode
union select 'General University 1 Yr Lapsed'segmentName				,'GU_1YR' segmentCode
union select 'General University 1 Yr Lapsed New and Reactivated'segmentName,'GU_1YR_NR' segmentCode
union select 'General University 2-3 Yr Lapsed'segmentName				,'GU_2-3YR' segmentCode
union select 'General University 2-3 Yr Lapsed New and Reactivated'segmentName,'GU_2-3YR_NR' segmentCode
union select 'General University 4+ 10-20'segmentName					,'GU_4YR_10-20' segmentCode
union select 'General University 4+ Under 10'segmentName				,'GU_4YR_U10' segmentCode
union select 'General University Nons'segmentName						,'GU_NONS' segmentCode
union select 'KOSU 1-3 Yr Lapsed'segmentName							,'KOSU_1-3YR' segmentCode
union select 'KOSU 4+ Yr Lapsed'segmentName								,'KOSU_4YR' segmentCode
union select 'OSU-CHS 4+ 10-20'segmentName								,'OSU-CHS_4YR_10-20' segmentCode
union select 'OSU-CHS 4+ Under 10'segmentName							,'OSU-CHS_4YR_U10' segmentCode
union select 'OSU-CHS Nons'segmentName									,'OSU-CHS_NONS' segmentCode
union select 'OSU-CHS Nons 11+'segmentName								,'OSU-CHS_NONS_11+' segmentCode
union select 'OSU-CHS Nons 80-10'segmentName							,'OSU-CHS_NONS_80-10' segmentCode
union select 'OSU-CHS Nons Pre 80'segmentName							,'OSU-CHS_NONS_P80' segmentCode
union select 'OSU-CHS Recent Donors'segmentName							,'OSU-CHS_1-3YR' segmentCode
union select 'OSU-IT 4+ 10-20'segmentName								,'OSU-IT_4YR_10-20' segmentCode
union select 'OSU-IT 4+ Under 10'segmentName							,'OSU-IT_4YR_U10' segmentCode
union select 'OSU-IT Nons'segmentName									,'OSU-IT_NONS' segmentCode
union select 'OSU-IT Nons 11+'segmentName								,'OSU-IT_NONS_11+' segmentCode
union select 'OSU-IT Nons 80-10'segmentName								,'OSU-IT_NONS_80-10' segmentCode
union select 'OSU-IT Nons Pre 80'segmentName							,'OSU-IT_NONS_P80' segmentCode
union select 'OSU-IT Recent Donors'segmentName							,'OSU-IT_1-3YR' segmentCode
union select 'OSU-OKC 4+ 10-20'segmentName								,'OSU-OKC_4YR_10-20' segmentCode
union select 'OSU-OKC 4+ Under 10'segmentName							,'OSU-OKC_4YR_U10' segmentCode
union select 'OSU-OKC Nons'segmentName									,'OSU-OKC_NONS' segmentCode
union select 'OSU-OKC Nons 11+'segmentName								,'OSU-OKC_NONS_11+' segmentCode
union select 'OSU-OKC Nons 80-10'segmentName							,'OSU-OKC_NONS_80-10' segmentCode
union select 'OSU-OKC Nons Pre 80'segmentName							,'OSU-OKC_NONS_P80' segmentCode
union select 'OSU-OKC Recent Donors'segmentName							,'OSU-OKC_1-3YR' segmentCode
union select 'OSU-Tulsa 4+ 10-20'segmentName							,'OSU-TUL_4YR_10-20' segmentCode
union select 'OSU-Tulsa 4+ Under 10'segmentName							,'OSU-TUL_4YR_U10' segmentCode
union select 'OSU-Tulsa Nons'segmentName								,'OSU-TUL_NONS' segmentCode
union select 'OSU-Tulsa Nons 11+'segmentName							,'OSU-TUL_NONS_11+' segmentCode
union select 'OSU-Tulsa Nons 80-10'segmentName							,'OSU-TUL_N0NS_80-10' segmentCode
union select 'OSU-Tulsa Recent Donors'segmentName						,'OSU-TUL_1-3YR' segmentCode
union select 'Parents'segmentName										,'PARENT' segmentCode
union select 'SSB 1 Yr Lapsed'segmentName								,'SSB_1YR' segmentCode
union select 'SSB 1 Yr Lapsed New and Reactivated'segmentName			,'SSB_1YR_NR' segmentCode
union select 'SSB 2-3 Yr Lapsed Donor'segmentName						,'SSB_2-3YR' segmentCode
union select 'SSB 2-3 Yr Lapsed New and Reactivated'segmentName			,'SSB_2-3YR_NR' segmentCode
union select 'SSB 4+ 10-20'segmentName									,'SSB_4YR_10-20' segmentCode
union select 'SSB 4+ Under 10'segmentName								,'SSB_4YR_U10' segmentCode
union select 'SSB Nons'segmentName										,'SSB_NONS' segmentCode
union select 'SSB Nons 11+'segmentName									,'SSB_NONS_11+' segmentCode
union select 'SSB Nons 80-10'segmentName								,'SSB_NONS_80-10' segmentCode
union select 'SSB Nons Pre 80'segmentName								,'SSB_NONS_P80' segmentCode
union select 'Student Affairs 1 Yr Lapsed'segmentName					,'STUAF_1YR' segmentCode
union select 'Student Affairs 1 Yr Lapsed New and Reactivated'segmentName,'STUAF_1YR_NR' segmentCode
union select 'Student Affairs 2-3 Yr Lapsed'segmentName					,'STUAF_2-3YR' segmentCode
union select 'Student Affairs 4+ 10-20'segmentName						,'STUAF_4YR_10-20' segmentCode
union select 'Student Affairs 4+ Under 10'segmentName					,'STUAF_4YR_U10' segmentCode
union select 'Student Affairs Nons'segmentName							,'STUAF_NONS' segmentCode
union select '2+ No Pledge'segmentName									,'No_Pledge' segmentCode
union select 'Cowboy Caller Managed'segmentName							,'CC_Managed' segmentCode
union select 'LAG $500+'segmentName										,'LAG' segmentCode
union select 'Managed'segmentName										,'Managed' segmentCode
union select 'New Grads'segmentName										,'NEW_GRADS' segmentCode
union select 'Non-Donors'segmentName									,'NONS' segmentCode
;