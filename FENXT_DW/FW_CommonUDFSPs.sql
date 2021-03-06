਍ഀ
/****** Object:  UserDefinedFunction [dbo].[BBBI_CalcFiscalPeriod]    Script Date: 06/27/2007 09:06:27 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀ
CREATE FUNCTION [dbo].[BBBI_CalcFiscalPeriod] (@FiscalYearStart Varchar(5), @FiscalYearEnd Varchar(5) = '', @CurrentDate DateTime, @PeriodRequired Int = 0)  ਍刀䔀吀唀刀一匀 䐀愀琀攀吀椀洀攀 䄀匀  ഀ
BEGIN ਍ⴀⴀ 䄀爀最甀洀攀渀琀猀 䀀倀攀爀椀漀搀刀攀焀甀椀爀攀搀 㴀 　 䌀甀爀爀攀渀琀 䘀椀猀挀愀氀 夀攀愀爀 匀琀愀爀琀Ⰰ ㄀ 䌀甀爀爀攀渀琀 䘀椀猀挀愀氀 夀攀愀爀 䔀渀搀ഀ
-- Arguments @PeriodRequired = 2 Next Fiscal Year Start, 3 Next Fiscal Year End਍ⴀⴀ 䄀爀最甀洀攀渀琀猀 䀀倀攀爀椀漀搀刀攀焀甀椀爀攀搀 㴀 㐀 倀爀攀瘀 䘀椀猀挀愀氀 夀攀愀爀 匀琀愀爀琀Ⰰ 㔀 倀爀攀瘀 䘀椀猀挀愀氀 夀攀愀爀 䔀渀搀ഀ
DECLARE @FiscalMonthStart Int਍䐀䔀䌀䰀䄀刀䔀 䀀䌀甀爀爀攀渀琀夀攀愀爀 䤀渀琀ഀ
DECLARE @CurrentMonth Int਍䐀䔀䌀䰀䄀刀䔀 䀀䌀甀爀爀攀渀琀䘀椀猀挀愀氀夀攀愀爀 䤀渀琀ഀ
DECLARE @FiscalPeriod DateTime਍䐀䔀䌀䰀䄀刀䔀 䀀夀攀愀爀䔀渀搀䐀愀琀攀 䐀愀琀攀吀椀洀攀ഀ
DECLARE @YearEnd Varchar(5)਍䐀䔀䌀䰀䄀刀䔀 䀀匀琀愀爀琀䐀愀琀攀 䐀愀琀攀吀椀洀攀ഀ
DECLARE @EndDate DateTime਍匀䔀吀 䀀䌀甀爀爀攀渀琀夀攀愀爀 㴀 夀攀愀爀⠀䀀䌀甀爀爀攀渀琀䐀愀琀攀⤀ഀ
SET @CurrentMonth = Month(@CurrentDate)਍匀䔀吀 䀀䘀椀猀挀愀氀䴀漀渀琀栀匀琀愀爀琀 㴀 ഀ
(SELECT਍䌀䄀匀䔀 ഀ
WHEN LEN(@FiscalYearStart) = 1 THEN Convert(Int, Left(@FiscalYearStart,1))਍䔀䰀匀䔀 䌀漀渀瘀攀爀琀⠀䤀渀琀Ⰰ 䰀攀昀琀⠀䀀䘀椀猀挀愀氀夀攀愀爀匀琀愀爀琀Ⰰ㈀⤀⤀ഀ
END)਍ഀ
SET @CurrentFiscalYear = ਍⠀匀䔀䰀䔀䌀吀ഀ
CASE ਍圀䠀䔀一 䀀䘀椀猀挀愀氀䴀漀渀琀栀匀琀愀爀琀 㴀 ㄀ 吀䠀䔀一 䀀䌀甀爀爀攀渀琀夀攀愀爀 ⬀ ㄀ഀ
WHEN @FiscalMonthStart > 1 AND @CurrentMonth >= @FiscalMonthStart THEN @CurrentYear + 1਍圀䠀䔀一 䀀䌀甀爀爀攀渀琀䴀漀渀琀栀 㰀 䀀䘀椀猀挀愀氀䴀漀渀琀栀匀琀愀爀琀 吀䠀䔀一 䀀䌀甀爀爀攀渀琀夀攀愀爀ഀ
END)਍ഀ
SET @YearEndDate =  ਍⠀匀䔀䰀䔀䌀吀 䌀䄀匀䔀 圀䠀䔀一 䀀䘀椀猀挀愀氀䴀漀渀琀栀匀琀愀爀琀 㴀 ㄀ 吀䠀䔀一ഀ
Convert(DateTime, @FiscalYearStart + '/'+Convert(Varchar(4),@CurrentFiscalYear - 1)) - 1਍䔀䰀匀䔀ഀ
Convert(DateTime, @FiscalYearStart + '/'+Convert(Varchar(4),@CurrentFiscalYear)) - 1਍䔀一䐀⤀ഀ
਍䤀䘀 䀀䘀椀猀挀愀氀夀攀愀爀䔀渀搀 㴀 ✀✀ഀ
	SET @YearEnd = Convert(Varchar(5), @YearEndDate,101)਍䔀䰀匀䔀ഀ
	SET @YearEnd = @FiscalYearEnd਍ഀ
SET @StartDate = Convert(DateTime, @FiscalYearStart+'/'+Convert(Varchar(4),@CurrentFiscalYear - 1)) ਍匀䔀吀 䀀䔀渀搀䐀愀琀攀 㴀 䌀漀渀瘀攀爀琀⠀䐀愀琀攀吀椀洀攀Ⰰ 䀀夀攀愀爀䔀渀搀⬀✀⼀✀⬀䌀漀渀瘀攀爀琀⠀嘀愀爀挀栀愀爀⠀㐀⤀Ⰰ䀀䌀甀爀爀攀渀琀䘀椀猀挀愀氀夀攀愀爀⤀⤀ഀ
਍䤀䘀 䀀䘀椀猀挀愀氀䴀漀渀琀栀匀琀愀爀琀 㴀 ㄀ ⴀⴀ 䄀搀樀甀猀琀洀攀渀琀 琀漀 夀攀愀爀 漀昀 䴀漀渀琀栀 猀琀愀爀琀猀 椀渀 䨀愀渀 ഀ
	SET @EndDate = DATEADD(yy, -1, @EndDate)਍䤀䘀 䀀倀攀爀椀漀搀刀攀焀甀椀爀攀搀 㴀 　    ⴀⴀ 䌀甀爀爀攀渀琀 䘀椀猀挀愀氀 匀琀愀爀琀 䐀愀琀攀 ഀ
	SET @FiscalPeriod = @StartDate਍䤀䘀 䀀倀攀爀椀漀搀刀攀焀甀椀爀攀搀 㴀 ㄀    ⴀⴀ 䌀甀爀爀攀渀琀 䘀椀猀挀愀氀 匀琀愀爀琀 䐀愀琀攀 ഀ
	SET @FiscalPeriod = @EndDate਍䤀䘀 䀀倀攀爀椀漀搀刀攀焀甀椀爀攀搀 㴀 ㈀  ⴀⴀ 一攀砀琀 䘀椀猀挀愀氀 匀琀愀爀琀 䐀愀琀攀 ഀ
	SET @FiscalPeriod = DATEADD(yy,1,@StartDate)਍䤀䘀 䀀倀攀爀椀漀搀刀攀焀甀椀爀攀搀 㴀 ㌀  ⴀⴀ 一攀砀琀 䘀椀猀挀愀氀 䔀渀搀 䐀愀琀攀 ഀ
	SET @FiscalPeriod = DATEADD(yy,1,@EndDate)਍䤀䘀 䀀倀攀爀椀漀搀刀攀焀甀椀爀攀搀 㴀 㐀  ⴀⴀ 倀爀攀瘀椀漀甀猀 䘀椀猀挀愀氀 匀琀愀爀琀 䐀愀琀攀 ഀ
	SET @FiscalPeriod = DATEADD(yy,-1,@StartDate)਍䤀䘀 䀀倀攀爀椀漀搀刀攀焀甀椀爀攀搀 㴀 㔀  ⴀⴀ 倀爀攀瘀椀漀甀猀 䘀椀猀挀愀氀 䔀渀搀 䐀愀琀攀 ഀ
	SET @FiscalPeriod = DATEADD(yy,-1,@EndDate)਍ഀ
RETURN (@FiscalPeriod)਍ഀ
END਍ഀ
਍ഀ
਍ഀ
GO਍ഀ
/****** Object:  UserDefinedFunction [dbo].[BBBI_CalcQuarter]    Script Date: 06/27/2007 09:06:28 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀ
CREATE FUNCTION [dbo].[BBBI_CalcQuarter] (@InputDate Varchar(20), @QuarterStartMonth Int, @QuarterOnly Int = 0)  ਍刀䔀吀唀刀一匀 嘀愀爀挀栀愀爀⠀㄀　⤀ 䄀匀  ഀ
BEGIN ਍ⴀⴀ 唀䐀䘀 眀栀椀挀栀 爀攀琀甀爀渀猀 琀栀攀 儀甀愀爀琀攀爀 一甀洀戀攀爀 愀渀搀 夀攀愀爀 戀愀猀攀搀 漀渀 戀攀椀渀最 瀀愀猀猀攀搀 愀 䐀愀琀愀 愀渀搀 䴀漀渀琀栀 眀栀攀渀 愀 昀椀猀挀愀氀 礀攀愀爀 猀琀愀爀琀猀ഀ
-- Arguments @QuartOnly = 0 for Qn-YYYY format for this Qtr, 1 for Qn only format, 2 for Qtr YYYY only format਍ⴀⴀ 䄀爀最甀洀攀渀琀猀 䀀儀甀愀爀琀伀渀氀礀 㴀 ㌀ 昀漀爀 儀渀ⴀ夀夀夀夀 昀漀爀洀愀琀 昀漀爀 一攀砀琀 儀琀爀Ⰰ 㐀 昀漀爀 一攀砀琀 儀渀 漀渀氀礀 昀漀爀洀愀琀Ⰰ 㔀 昀漀爀 一攀砀琀 儀琀爀 夀夀夀夀 漀渀氀礀 昀漀爀洀愀琀ഀ
-- Arguments @QuartOnly = 6 for Qn-YYYY format for Next Qtr, 7 for Next Qn only format, 8 for Next Qtr YYYY only format਍ഀ
DECLARE @FiscalMonth As Varchar(2)਍䐀䔀䌀䰀䄀刀䔀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀 䄀猀 嘀愀爀挀栀愀爀⠀㈀⤀ഀ
DECLARE @FiscalYear As Varchar(4)਍䐀䔀䌀䰀䄀刀䔀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀夀攀愀爀 䄀猀 嘀愀爀挀栀愀爀⠀㈀　⤀ഀ
DECLARE @FiscalNextQuarter As Varchar(2)਍䐀䔀䌀䰀䄀刀䔀 䀀䘀椀猀挀愀氀一攀砀琀夀攀愀爀 䄀猀 嘀愀爀挀栀愀爀⠀㐀⤀ഀ
DECLARE @FiscalNextQuarterYear As Varchar(20)਍䐀䔀䌀䰀䄀刀䔀 䀀䘀椀猀挀愀氀倀爀攀瘀儀甀愀爀琀攀爀 䄀猀 嘀愀爀挀栀愀爀⠀㈀⤀ഀ
DECLARE @FiscalPrevYear As Varchar(4)਍䐀䔀䌀䰀䄀刀䔀 䀀䘀椀猀挀愀氀倀爀攀瘀儀甀愀爀琀攀爀夀攀愀爀 䄀猀 嘀愀爀挀栀愀爀⠀㈀　⤀ഀ
DECLARE @ThisYear As Varchar(4)਍䐀䔀䌀䰀䄀刀䔀 䀀一攀砀琀夀攀愀爀 䄀猀 嘀愀爀挀栀愀爀⠀㐀⤀ഀ
DECLARE @PrevYear As Varchar(4)਍䐀䔀䌀䰀䄀刀䔀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 䄀猀 䤀渀琀ഀ
DECLARE @NextQuarterStartMonth As Int਍䐀䔀䌀䰀䄀刀䔀 䀀儀甀愀爀琀攀爀一甀洀 䄀匀 䤀渀琀ഀ
DECLARE @iPos AS Int਍䐀䔀䌀䰀䄀刀䔀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀䴀漀渀琀栀 䄀猀 䤀渀琀ഀ
਍匀䔀吀 䀀椀倀漀猀 㴀 倀䄀吀䤀一䐀䔀堀⠀✀─⼀─✀Ⰰ 䀀䤀渀瀀甀琀䐀愀琀攀⤀ഀ
SET @FiscalMonth = LEFT(@InputDate,@iPos - 1)਍匀䔀吀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 㴀 䌀漀渀瘀攀爀琀⠀䤀渀琀Ⰰ 䀀䘀椀猀挀愀氀䴀漀渀琀栀⤀ഀ
SET @NextQuarterStartMonth = @QuarterStartMonth਍匀䔀吀 䀀吀栀椀猀夀攀愀爀 㴀 刀䤀䜀䠀吀⠀䀀䤀渀瀀甀琀䐀愀琀攀Ⰰ 㐀⤀ഀ
SET @NextYear = Convert(Varchar(4), Convert(Int, RIGHT(@InputDate, 4)) + 1)਍匀䔀吀 䀀倀爀攀瘀夀攀愀爀 㴀 䌀漀渀瘀攀爀琀⠀嘀愀爀挀栀愀爀⠀㐀⤀Ⰰ 䌀漀渀瘀攀爀琀⠀䤀渀琀Ⰰ 刀䤀䜀䠀吀⠀䀀䤀渀瀀甀琀䐀愀琀攀Ⰰ 㐀⤀⤀ ⴀ ㄀⤀ഀ
਍ഀ
IF @QuarterStartMonth = 1਍䈀䔀䜀䤀一ഀ
	SET @QuarterNum = ((@FiscalMonthNum+2) / 3)਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀 㴀 ✀儀✀⬀䌀漀渀瘀攀爀琀⠀嘀愀爀挀栀愀爀⠀㄀⤀Ⰰ 䀀儀甀愀爀琀攀爀一甀洀⤀ഀ
	SET @FiscalYear = @ThisYear਍ऀഀ
	IF @QuarterNum < 4਍ऀ䈀䔀䜀䤀一ഀ
		SET @FiscalNextYear = @ThisYear਍ऀऀ匀䔀吀 䀀䘀椀猀挀愀氀一攀砀琀儀甀愀爀琀攀爀 㴀 ✀儀✀ ⬀ 䌀漀渀瘀攀爀琀⠀嘀愀爀挀栀愀爀⠀㄀⤀Ⰰ 䀀儀甀愀爀琀攀爀一甀洀 ⬀ ㄀⤀ഀ
	END਍ऀ䤀䘀 䀀儀甀愀爀琀攀爀一甀洀 㴀 㐀ഀ
	BEGIN਍ऀऀ匀䔀吀 䀀䘀椀猀挀愀氀一攀砀琀夀攀愀爀 㴀 䀀一攀砀琀夀攀愀爀ഀ
		SET @FiscalNextQuarter = 'Q1'਍ऀ䔀一䐀ഀ
	IF @QuarterNum = 1਍ऀ䈀䔀䜀䤀一ഀ
		SET @FiscalPrevYear = @PrevYear਍ऀऀ匀䔀吀 䀀䘀椀猀挀愀氀倀爀攀瘀儀甀愀爀琀攀爀 㴀 ✀儀㐀✀ഀ
	END਍ऀ䤀䘀 䀀儀甀愀爀琀攀爀一甀洀 㸀 ㄀ഀ
	BEGIN਍ऀऀ匀䔀吀 䀀䘀椀猀挀愀氀倀爀攀瘀夀攀愀爀 㴀 䀀吀栀椀猀夀攀愀爀ഀ
		SET @FiscalPrevQuarter = 'Q'+Convert(Varchar(1), @QuarterNum - 1)਍ऀ䔀一䐀ഀ
਍䔀一䐀ഀ
ELSE਍䈀䔀䜀䤀一ഀ
IF਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 ㄀ 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㄀Ⰰ ㈀Ⰰ ㌀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 2 AND @FiscalMonthNum in (2, 3, 4)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 ㌀ 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㌀Ⰰ 㐀Ⰰ 㔀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 4 AND @FiscalMonthNum in (4 ,5 ,6)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 㔀 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㔀 Ⰰ㘀 Ⰰ㜀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 6 AND @FiscalMonthNum in (6 ,7 ,8)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 㜀 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㜀 Ⰰ㠀 Ⰰ㤀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 8 AND @FiscalMonthNum in (8, 9 , 10)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 㤀 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㤀Ⰰ ㄀　 Ⰰ ㄀㄀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 10 AND @FiscalMonthNum in (10, 11 , 12)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 ㄀㄀ 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㄀㄀Ⰰ ㄀㈀ Ⰰ㄀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 12 AND @FiscalMonthNum in (12, 1 , 2))਍䈀䔀䜀䤀一 ഀ
	-------------------------------   Q1  ------------------------------------਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀倀爀攀瘀儀甀愀爀琀攀爀 㴀 ✀儀㐀✀ഀ
	SET @FiscalQuarter = 'Q1'਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀一攀砀琀儀甀愀爀琀攀爀 㴀 ✀儀㈀✀ഀ
਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀倀爀攀瘀夀攀愀爀 㴀 䀀吀栀椀猀夀攀愀爀ഀ
	SET @FiscalYear = @NextYear਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀一攀砀琀夀攀愀爀 㴀 䀀一攀砀琀夀攀愀爀ഀ
਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀䴀漀渀琀栀 㴀 䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀ഀ
END਍ഀ
IF ਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 ㄀ 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㐀Ⰰ㔀Ⰰ㘀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 2 AND @FiscalMonthNum in (5,6,7)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 ㌀ 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㘀Ⰰ㜀Ⰰ㠀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 4 AND @FiscalMonthNum in (7 ,8 ,9)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 㔀 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㠀 Ⰰ㤀 Ⰰ㄀　⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 6 AND @FiscalMonthNum in (9 ,10 ,11)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 㜀 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㄀　 Ⰰ㄀㄀ Ⰰ㄀㈀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 8 AND @FiscalMonthNum in ( 11,12 ,1)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 㤀 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀ ㄀㈀Ⰰ㄀ Ⰰ㈀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 10 AND @FiscalMonthNum in ( 1,2 ,3)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 ㄀㄀ 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀ ㈀Ⰰ㌀ Ⰰ㐀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 12 AND @FiscalMonthNum in ( 3,4 ,5))਍䈀䔀䜀䤀一 ഀ
	-------------------------------   Q2  ------------------------------------਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀倀爀攀瘀儀甀愀爀琀攀爀 㴀 ✀儀㄀✀ഀ
	SET @FiscalQuarter = 'Q2'਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀一攀砀琀儀甀愀爀琀攀爀 㴀 ✀儀㌀✀ഀ
਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀夀攀愀爀 㴀 䀀一攀砀琀夀攀愀爀ഀ
	SET @FiscalNextYear = @NextYear਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀倀爀攀瘀夀攀愀爀 㴀 䀀一攀砀琀夀攀愀爀ഀ
	SET @FiscalQuarterMonth = @QuarterStartMonth + 3਍䔀一䐀ഀ
਍䤀䘀 ഀ
(@QuarterStartMonth = 1 AND @FiscalMonthNum in (7, 8, 9)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 ㈀ 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㠀Ⰰ 㤀Ⰰ ㄀　⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 3 AND @FiscalMonthNum in (9, 10, 11)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 㐀 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㄀　 Ⰰ㄀㄀ Ⰰ㄀㈀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 5 AND @FiscalMonthNum in (11 ,12 ,1)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 㘀 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㄀㈀ Ⰰ㄀ Ⰰ㈀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 7 AND @FiscalMonthNum in (1 ,2 ,3)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 㠀 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㈀Ⰰ ㌀ Ⰰ㐀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 9 AND @FiscalMonthNum in (3,  4 , 5)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 ㄀　 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀ 㐀Ⰰ 㔀 Ⰰ 㘀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 11 AND @FiscalMonthNum in ( 5, 6 ,7)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 ㄀㈀ 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀ 㘀Ⰰ 㜀 Ⰰ 㠀⤀⤀ഀ
BEGIN ਍ऀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀ   儀㌀  ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀ
	SET @FiscalPrevQuarter = 'Q2'਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀 㴀 ✀儀㌀✀ഀ
	SET @FiscalNextQuarter = 'Q4'਍ഀ
	IF @QuarterStartMonth < 5਍ऀ䈀䔀䜀䤀一ഀ
		SET @FiscalPrevYear = @NextYear਍ऀऀ匀䔀吀 䀀䘀椀猀挀愀氀夀攀愀爀 㴀 䀀一攀砀琀夀攀愀爀ഀ
		SET @FiscalNextYear = @NextYear਍ऀ䔀一䐀ഀ
	IF @QuarterStartMonth > 4਍ऀ䈀䔀䜀䤀一ഀ
		SET @FiscalPrevYear = @ThisYear਍ऀऀ匀䔀吀 䀀䘀椀猀挀愀氀夀攀愀爀 㴀 䀀吀栀椀猀夀攀愀爀ഀ
		SET @FiscalNextYear = @ThisYear਍ऀ䔀一䐀ഀ
	SET @FiscalQuarterMonth = @QuarterStartMonth + 6਍䔀一䐀ഀ
IF਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 ㄀ 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㄀　Ⰰ ㄀㄀Ⰰ ㄀㈀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 2 AND @FiscalMonthNum in (11, 12, 1)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 ㌀ 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㄀㈀Ⰰ ㄀Ⰰ ㈀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 4 AND @FiscalMonthNum in (1, 2, 3)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 㔀 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㈀Ⰰ ㌀Ⰰ 㐀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 6 AND @FiscalMonthNum in (3, 4, 5)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 㜀 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㐀 Ⰰ㔀 Ⰰ㘀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 8 AND @FiscalMonthNum in (5 ,6 ,7)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 㤀 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㘀 Ⰰ㜀 Ⰰ㠀⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 10 AND @FiscalMonthNum in (7 ,8 ,9)) OR਍⠀䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀 㴀 ㄀㄀ 䄀一䐀 䀀䘀椀猀挀愀氀䴀漀渀琀栀一甀洀 椀渀 ⠀㠀Ⰰ 㤀 Ⰰ ㄀　⤀⤀ 伀刀ഀ
(@QuarterStartMonth = 12 AND @FiscalMonthNum in (9, 10 , 11))਍䈀䔀䜀䤀一 ഀ
	-------------------------------   Q4  ------------------------------------਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀倀爀攀瘀儀甀愀爀琀攀爀 㴀 ✀儀㌀✀ഀ
	SET @FiscalQuarter = 'Q4'਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀一攀砀琀儀甀愀爀琀攀爀 㴀 ✀儀㄀✀ഀ
਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀倀爀攀瘀夀攀愀爀 㴀 䀀吀栀椀猀夀攀愀爀ഀ
	SET @FiscalYear = @ThisYear਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀一攀砀琀夀攀愀爀 㴀 䀀一攀砀琀夀攀愀爀ഀ
	SET @FiscalQuarterMonth = @QuarterStartMonth + 9਍䔀一䐀ഀ
਍䔀一䐀ഀ
਍匀䔀吀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀夀攀愀爀 㴀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀 ⬀ ✀ⴀ✀ ⬀ 䀀䘀椀猀挀愀氀夀攀愀爀ഀ
SET @FiscalNextQuarterYear = @FiscalNextQuarter + '-' + @FiscalNextYear਍ഀ
IF @QuarterOnly = 1 ਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀夀攀愀爀 㴀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀ഀ
IF @QuarterOnly = 2 ਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀夀攀愀爀 㴀 䀀䘀椀猀挀愀氀夀攀愀爀ഀ
IF @QuarterOnly = 3 ਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀夀攀愀爀 㴀 䀀䘀椀猀挀愀氀一攀砀琀儀甀愀爀琀攀爀 ⬀ ✀ⴀ✀ ⬀ 䀀䘀椀猀挀愀氀一攀砀琀夀攀愀爀ഀ
IF @QuarterOnly = 4 ਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀夀攀愀爀 㴀 䀀䘀椀猀挀愀氀一攀砀琀儀甀愀爀琀攀爀ഀ
IF @QuarterOnly = 5 ਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀夀攀愀爀 㴀 䀀䘀椀猀挀愀氀一攀砀琀夀攀愀爀ഀ
IF @QuarterOnly = 6 ਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀夀攀愀爀 㴀 䀀䘀椀猀挀愀氀倀爀攀瘀儀甀愀爀琀攀爀 ⬀ ✀ⴀ✀ ⬀ 䀀䘀椀猀挀愀氀倀爀攀瘀夀攀愀爀ഀ
IF @QuarterOnly = 7 ਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀夀攀愀爀 㴀 䀀䘀椀猀挀愀氀倀爀攀瘀儀甀愀爀琀攀爀ഀ
IF @QuarterOnly = 8 ਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀夀攀愀爀 㴀 䀀䘀椀猀挀愀氀倀爀攀瘀夀攀愀爀ഀ
IF @QuarterOnly = 9਍䈀䔀䜀䤀一ഀ
	IF @FiscalQuarterMonth > 12਍ऀऀ匀䔀吀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀䴀漀渀琀栀 㴀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀䴀漀渀琀栀 ⴀ ㄀㈀ഀ
	SET @FiscalQuarterYear = Convert(Varchar(2), @FiscalQuarterMonth) +'/01/' + @ThisYear਍䔀一䐀ഀ
	਍䤀䘀 䀀儀甀愀爀琀攀爀伀渀氀礀 㴀 ㄀　 ഀ
	SET @FiscalQuarterYear = RIGHT(@FiscalQuarter, 1)਍ഀ
RETURN (@FiscalQuarterYear)਍ഀ
END਍ഀ
਍ഀ
਍ഀ
GO਍ഀ
/****** Object:  UserDefinedFunction [dbo].[BBBI_CalcQuarterDate]    Script Date: 06/27/2007 09:06:29 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀ
CREATE FUNCTION [dbo].[BBBI_CalcQuarterDate] (@InputDate AS DateTime, @QuarterStartMonth Int, @QuarterOnly Int = 0)  ਍刀䔀吀唀刀一匀 嘀愀爀挀栀愀爀⠀㈀　⤀ ഀ
AS  ਍䈀䔀䜀䤀一 ഀ
DECLARE @QuarterDate As Varchar(20)਍匀䔀吀 䀀儀甀愀爀琀攀爀䐀愀琀攀 㴀 䌀漀渀瘀攀爀琀⠀嘀愀爀挀栀愀爀⠀㈀　⤀Ⰰ 䀀䤀渀瀀甀琀䐀愀琀攀Ⰰ ㄀　㄀⤀ഀ
RETURN dbo.BBBI_CalcQuarter (@QuarterDate, @QuarterStartMonth, @QuarterOnly)  ਍䔀一䐀ഀ
਍ഀ
਍ഀ
਍䜀伀ഀ
਍⼀⨀⨀⨀⨀⨀⨀ 伀戀樀攀挀琀㨀  唀猀攀爀䐀攀昀椀渀攀搀䘀甀渀挀琀椀漀渀 嬀搀戀漀崀⸀嬀䈀䈀䈀䤀开䤀渀搀攀砀䌀爀攀愀琀攀䌀洀搀崀    匀挀爀椀瀀琀 䐀愀琀攀㨀 　㘀⼀㈀㜀⼀㈀　　㜀 　㤀㨀　㘀㨀㌀　 ⨀⨀⨀⨀⨀⨀⼀ഀ
਍匀䔀吀 䄀一匀䤀开一唀䰀䰀匀 伀一ഀ
਍䜀伀ഀ
਍匀䔀吀 儀唀伀吀䔀䐀开䤀䐀䔀一吀䤀䘀䤀䔀刀 伀一ഀ
਍䜀伀ഀ
਍䌀刀䔀䄀吀䔀 昀甀渀挀琀椀漀渀 嬀搀戀漀崀⸀嬀䈀䈀䈀䤀开䤀渀搀攀砀䌀爀攀愀琀攀䌀洀搀崀 ⠀䀀吀愀戀氀攀䤀䐀 椀渀琀Ⰰ 䀀䤀渀搀攀砀䤀䐀 椀渀琀Ⰰ 䀀䤀渀搀攀砀䌀漀氀甀洀渀倀漀猀椀琀椀漀渀 椀渀琀⤀ഀ
਍爀攀琀甀爀渀猀 瘀愀爀挀栀愀爀⠀㈀㔀㔀⤀ഀ
਍愀猀ഀ
਍戀攀最椀渀ഀ
਍ഀ
਍ऀ搀攀挀氀愀爀攀 䀀爀攀琀瘀愀氀 瘀愀爀挀栀愀爀⠀㈀㔀㔀⤀ഀ
਍ऀ搀攀挀氀愀爀攀 䀀猀攀瀀愀爀愀琀漀爀 瘀愀爀挀栀愀爀⠀㄀⤀ഀ
਍ഀ
਍ऀ猀攀琀 䀀爀攀琀瘀愀氀㴀✀✀ഀ
਍ऀ䤀䘀 䀀䤀渀搀攀砀䌀漀氀甀洀渀倀漀猀椀琀椀漀渀 㴀 ㄀ഀ
਍ऀ䈀䔀䜀䤀一ഀ
਍ऀ匀䔀䰀䔀䌀吀 䀀爀攀琀瘀愀氀 㴀 䀀爀攀琀瘀愀氀 ⬀ 䌀䄀匀䔀 圀䠀䔀一 䰀攀渀⠀䀀爀攀琀瘀愀氀⤀㴀　 吀䠀䔀一 ✀✀ ഀ
਍ऀऀऀऀ䔀䰀匀䔀 ✀Ⰰ✀ 攀渀搀 ⬀ 䌀漀氀甀洀渀一愀洀攀ഀ
਍ऀ䘀刀伀䴀 䌀吀䰀开䤀渀搀攀砀䠀椀猀琀漀爀礀 ഀ
਍ऀ圀䠀䔀刀䔀   吀愀戀氀攀匀礀猀琀攀洀䤀䐀 㴀 䀀吀愀戀氀攀䤀䐀 䄀一䐀 ഀ
਍ऀऀऀऀऀ䤀渀搀攀砀匀礀猀琀攀洀䤀䐀㴀䀀䤀渀搀攀砀䤀䐀 䄀一䐀 䤀渀搀攀砀䌀漀氀甀洀渀倀漀猀椀琀椀漀渀 㴀 　ഀ
਍ऀ伀刀䐀䔀刀 䈀夀 吀愀戀氀攀匀礀猀琀攀洀䤀䐀 䄀匀䌀Ⰰ 䤀渀搀攀砀匀礀猀琀攀洀䤀䐀 䄀匀䌀Ⰰ 䤀渀搀攀砀䌀漀氀甀洀渀倀漀猀椀琀椀漀渀 䐀䔀匀䌀ഀ
਍ऀ䔀一䐀ഀ
਍ऀ䔀䰀匀䔀ഀ
਍ऀ䈀䔀䜀䤀一ഀ
਍ऀ匀䔀䰀䔀䌀吀 䀀爀攀琀瘀愀氀 㴀 䌀漀氀甀洀渀一愀洀攀 ⬀ 䌀䄀匀䔀 圀䠀䔀一 䰀攀渀⠀䀀爀攀琀瘀愀氀⤀㴀　 吀䠀䔀一 ✀✀ ഀ
਍ऀऀऀऀ䔀䰀匀䔀 ✀Ⰰ✀ 攀渀搀 ⬀ 䀀爀攀琀瘀愀氀ഀ
਍ऀ䘀刀伀䴀 䌀吀䰀开䤀渀搀攀砀䠀椀猀琀漀爀礀 ഀ
਍ऀ圀䠀䔀刀䔀   吀愀戀氀攀匀礀猀琀攀洀䤀䐀 㴀 䀀吀愀戀氀攀䤀䐀 䄀一䐀 ഀ
਍ऀऀऀऀऀ䤀渀搀攀砀匀礀猀琀攀洀䤀䐀㴀䀀䤀渀搀攀砀䤀䐀 ⴀⴀ䄀一䐀 䤀渀搀攀砀䌀漀氀甀洀渀倀漀猀椀琀椀漀渀 㴀 　ഀ
਍ऀ伀刀䐀䔀刀 䈀夀 吀愀戀氀攀匀礀猀琀攀洀䤀䐀 䄀匀䌀Ⰰ 䤀渀搀攀砀匀礀猀琀攀洀䤀䐀 䄀匀䌀Ⰰ 䤀渀搀攀砀䌀漀氀甀洀渀倀漀猀椀琀椀漀渀 䐀䔀匀䌀ഀ
਍ഀ
਍ऀ䔀一䐀ഀ
਍ഀ
਍ऀ爀攀琀甀爀渀 䀀爀攀琀瘀愀氀ഀ
਍ഀ
਍攀渀搀ഀ
਍ഀ
਍ഀ
਍ഀ
਍䜀伀ഀ
਍⼀⨀⨀⨀⨀⨀⨀ 伀戀樀攀挀琀㨀  唀猀攀爀䐀攀昀椀渀攀搀䘀甀渀挀琀椀漀渀 嬀搀戀漀崀⸀嬀䈀䈀䈀䤀开䤀渀搀攀砀䘀椀渀搀䤀渀挀氀甀搀攀崀    匀挀爀椀瀀琀 䐀愀琀攀㨀 　㘀⼀㈀㜀⼀㈀　　㜀 　㤀㨀　㘀㨀㌀㄀ ⨀⨀⨀⨀⨀⨀⼀ഀ
਍匀䔀吀 䄀一匀䤀开一唀䰀䰀匀 伀一ഀ
਍䜀伀ഀ
਍匀䔀吀 儀唀伀吀䔀䐀开䤀䐀䔀一吀䤀䘀䤀䔀刀 伀一ഀ
਍䜀伀ഀ
਍䌀刀䔀䄀吀䔀 昀甀渀挀琀椀漀渀 嬀搀戀漀崀⸀嬀䈀䈀䈀䤀开䤀渀搀攀砀䘀椀渀搀䤀渀挀氀甀搀攀崀 ⠀䀀吀愀戀氀攀䤀䐀 椀渀琀Ⰰ 䀀䤀渀搀攀砀䤀䐀 椀渀琀⤀ഀ
਍爀攀琀甀爀渀猀 瘀愀爀挀栀愀爀⠀㈀㔀㔀⤀ഀ
਍愀猀ഀ
਍戀攀最椀渀ഀ
਍ഀ
਍ऀ搀攀挀氀愀爀攀 䀀爀攀琀瘀愀氀 瘀愀爀挀栀愀爀⠀㈀㔀㔀⤀ഀ
਍ऀ搀攀挀氀愀爀攀 䀀猀攀瀀愀爀愀琀漀爀 瘀愀爀挀栀愀爀⠀㄀⤀ഀ
਍ഀ
਍ऀ猀攀琀 䀀爀攀琀瘀愀氀㴀✀✀ഀ
਍ⴀⴀऀ匀䔀䰀䔀䌀吀 䀀爀攀琀瘀愀氀 㴀 䌀漀渀瘀攀爀琀⠀䤀渀琀Ⰰ 䀀爀攀琀瘀愀氀 ⬀ 䌀䄀匀䔀 圀䠀䔀一 䰀攀渀⠀䀀爀攀琀瘀愀氀⤀㴀　 吀䠀䔀一 ✀✀ ഀ
਍ⴀⴀऀऀऀऀ䔀䰀匀䔀 ✀✀ 攀渀搀 ⬀ 䌀漀渀瘀攀爀琀⠀嘀愀爀挀栀愀爀⠀㌀⤀Ⰰ 䤀渀搀攀砀䌀漀氀甀洀渀倀漀猀椀琀椀漀渀⤀⤀ഀ
਍ऀ匀䔀䰀䔀䌀吀 䀀爀攀琀瘀愀氀 㴀 ㄀ഀ
਍ऀ䘀刀伀䴀 䌀吀䰀开䤀渀搀攀砀䠀椀猀琀漀爀礀  ഀ
਍ऀ圀䠀䔀刀䔀   吀愀戀氀攀匀礀猀琀攀洀䤀䐀 㴀 䀀吀愀戀氀攀䤀䐀 䄀一䐀 ഀ
਍ऀऀऀऀऀ䤀渀搀攀砀匀礀猀琀攀洀䤀䐀㴀䀀䤀渀搀攀砀䤀䐀 䄀一䐀 䤀渀搀攀砀䌀漀氀甀洀渀倀漀猀椀琀椀漀渀 㴀 　ഀ
਍ऀ伀刀䐀䔀刀 䈀夀 吀愀戀氀攀匀礀猀琀攀洀䤀䐀 䄀匀䌀Ⰰ 䤀渀搀攀砀匀礀猀琀攀洀䤀䐀 䄀匀䌀Ⰰ 䤀渀搀攀砀䌀漀氀甀洀渀倀漀猀椀琀椀漀渀 䐀䔀匀䌀ഀ
਍ഀ
਍ऀ爀攀琀甀爀渀 䀀爀攀琀瘀愀氀ഀ
਍ഀ
਍攀渀搀ഀ
਍ഀ
਍ഀ
਍䜀伀ഀ
਍⼀⨀⨀⨀⨀⨀⨀ 伀戀樀攀挀琀㨀  唀猀攀爀䐀攀昀椀渀攀搀䘀甀渀挀琀椀漀渀 嬀搀戀漀崀⸀嬀䈀䈀䈀䤀开䴀漀渀琀栀䔀渀搀崀    匀挀爀椀瀀琀 䐀愀琀攀㨀 　㘀⼀㈀㜀⼀㈀　　㜀 　㤀㨀　㘀㨀㌀㄀ ⨀⨀⨀⨀⨀⨀⼀ഀ
਍匀䔀吀 䄀一匀䤀开一唀䰀䰀匀 伀一ഀ
਍䜀伀ഀ
਍匀䔀吀 儀唀伀吀䔀䐀开䤀䐀䔀一吀䤀䘀䤀䔀刀 伀一ഀ
਍䜀伀ഀ
਍ഀ
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 䘀唀一䌀吀䤀伀一 嬀搀戀漀崀⸀嬀䈀䈀䈀䤀开䴀漀渀琀栀䔀渀搀崀 ⠀䀀䌀甀爀爀攀渀琀䐀愀琀攀 䐀愀琀攀吀椀洀攀Ⰰ 䀀一漀倀攀爀椀漀搀猀 䤀渀琀 㴀 　⤀  ഀ
RETURNS DateTime AS  ਍䈀䔀䜀䤀一 ഀ
-- Arguments @PeriodRequired = 0 Current Fiscal Year Start, 1 Current Fiscal Year End਍ⴀⴀ 䄀爀最甀洀攀渀琀猀 䀀倀攀爀椀漀搀刀攀焀甀椀爀攀搀 㴀 ㈀ 一攀砀琀 䘀椀猀挀愀氀 夀攀愀爀 匀琀愀爀琀Ⰰ ㌀ 一攀砀琀 䘀椀猀挀愀氀 夀攀愀爀 䔀渀搀ഀ
-- Arguments @PeriodRequired = 4 Prev Fiscal Year Start, 5 Prev Fiscal Year End਍䐀䔀䌀䰀䄀刀䔀 䀀䌀甀爀爀攀渀琀䴀漀渀琀栀 䤀渀琀ഀ
DECLARE @CurrentYear VarChar(4)਍䐀䔀䌀䰀䄀刀䔀 䀀倀爀攀瘀䴀漀渀琀栀 䤀渀琀ഀ
DECLARE @LastMonthEnd DateTime਍匀䔀吀 䀀䌀甀爀爀攀渀琀夀攀愀爀 㴀 䌀漀渀瘀攀爀琀⠀嘀愀爀挀栀愀爀⠀㐀⤀Ⰰ 夀攀愀爀⠀䀀䌀甀爀爀攀渀琀䐀愀琀攀⤀⤀ഀ
SET @CurrentMonth = Month(@CurrentDate)਍匀䔀吀 䀀倀爀攀瘀䴀漀渀琀栀 㴀 䀀䌀甀爀爀攀渀琀䴀漀渀琀栀 ⴀ ㄀ഀ
SET @LastMonthEnd = DateAdd(m, @NoPeriods, Convert(DateTime, Convert(Varchar(2),@CurrentMonth)+'/01/'+@CurrentYear) - 1)਍刀䔀吀唀刀一 ⠀䀀䰀愀猀琀䴀漀渀琀栀䔀渀搀⤀ഀ
END਍ഀ
਍䜀伀ഀ
਍ഀ
਍䌀刀䔀䄀吀䔀 䘀唀一䌀吀䤀伀一 嬀搀戀漀崀⸀嬀䈀䈀䈀䤀开刀攀琀甀爀渀䘀椀猀挀愀氀夀攀愀爀崀 ⠀䀀䤀渀瀀甀琀䐀愀琀攀 䐀愀琀攀吀椀洀攀Ⰰ 䀀䘀椀猀挀愀氀䴀漀渀琀栀匀琀愀爀琀 䤀渀琀 㴀 ㄀⤀  ഀ
RETURNS Varchar(4) AS  ਍䈀䔀䜀䤀一 ഀ
-- UDF which returns the Fiscal year based on the input date and fiscal month start਍䐀䔀䌀䰀䄀刀䔀 䀀䌀甀爀爀攀渀琀夀攀愀爀 嘀愀爀挀栀愀爀⠀㐀⤀ഀ
DECLARE @NextYear Varchar(4)਍䐀䔀䌀䰀䄀刀䔀 䀀䌀甀爀爀攀渀琀䴀漀渀琀栀 䤀渀琀ഀ
DECLARE @FiscalYear Varchar(4)਍ഀ
SET @CurrentYear = Convert(Varchar(4), Year(@InputDate))਍匀䔀吀 䀀一攀砀琀夀攀愀爀 㴀 䌀漀渀瘀攀爀琀⠀嘀愀爀挀栀愀爀⠀㐀⤀Ⰰ 夀攀愀爀⠀䀀䤀渀瀀甀琀䐀愀琀攀⤀ ⬀ ㄀⤀ഀ
SET @CurrentMonth = Month(@InputDate)਍ഀ
IF @FiscalMonthStart = 1 ਍ऀ匀䔀吀 䀀䘀椀猀挀愀氀夀攀愀爀 㴀 䀀䌀甀爀爀攀渀琀夀攀愀爀ഀ
ELSE਍䈀䔀䜀䤀一ഀ
	IF @CurrentMonth < @FiscalMonthStart਍         ऀऀ匀䔀吀 䀀䘀椀猀挀愀氀夀攀愀爀 㴀 䀀䌀甀爀爀攀渀琀夀攀愀爀  ഀ
	ELSE਍         ऀऀ匀䔀吀 䀀䘀椀猀挀愀氀夀攀愀爀 㴀 䀀一攀砀琀夀攀愀爀             ഀ
END਍ഀ
RETURN (@FiscalYear)਍ഀ
END਍ഀ
਍ഀ
GO਍ഀ
-----------------------------------------------------------------------਍ഀ
-- Stored Procs਍ഀ
-----------------------------------------------------------------------਍ഀ
਍ഀ
਍ഀ
਍ഀ
CREATE PROCEDURE [dbo].[p_CTL_BeginLoad]਍ഀ
਍ഀ
AS਍ഀ
਍ഀ
SET NOCOUNT ON਍ഀ
਍ഀ
DECLARE @LoadStatusID INT਍ഀ
DECLARE @CurrentDataWindowOpen DATETIME਍ഀ
DECLARE @CurrentDataWindowClose DATETIME਍ഀ
਍ഀ
BEGIN TRANSACTION ਍ഀ
਍ഀ
DELETE FROM CTL_LoadStatus਍ഀ
 WHERE LoadIsComplete = 0਍ഀ
਍ഀ
-- Set load parameters - use the last load and the current datetime to determine load window਍ഀ
਍ഀ
INSERT INTO dbo.CTL_LoadStatus (਍ഀ
		SourceLoadID,਍ഀ
		SourceID,਍ഀ
		DataWindowOpen,਍ഀ
		DataWindowClose,਍ഀ
		LoadIsComplete,਍ഀ
		ETLStartTime)਍ഀ
SELECT ISNULL(MAX(SourceLoadID) + 1, 1) SourceLoadID,਍ഀ
		1 SourceID, -- hard coded for now, but will have to be genericized for multiple sources਍ഀ
		CAST(COALESCE(MAX(DataWindowClose), '1/1/1900') AS DATETIME) DataWindowOpen,਍ഀ
		GETDATE() DataWindowClose,਍ഀ
		0,਍ഀ
		GETDATE()਍ഀ
  FROM dbo.CTL_LoadStatus ls਍ഀ
 WHERE SourceID = 1	਍ഀ
਍ഀ
SET @LoadStatusID = @@IDENTITY਍ഀ
਍ഀ
SET @CurrentDataWindowOpen = (SELECT DataWindowOpen ਍ഀ
								FROM dbo.CTL_LoadStatus਍ഀ
							   WHERE LoadStatusID = @LoadStatusID )਍ഀ
SET @CurrentDataWindowClose = (SELECT DataWindowClose਍ഀ
								 FROM dbo.CTL_LoadStatus਍ഀ਍ऀऀऀऀऀऀऀऀ圀䠀䔀刀䔀 䰀漀愀搀匀琀愀琀甀猀䤀䐀 㴀 䀀䰀漀愀搀匀琀愀琀甀猀䤀䐀 ⤀ഀ
਍ഀ
਍ഀ
਍ഀ
਍䤀䘀 䀀䀀䔀刀刀伀刀 㸀 　ഀ
਍䈀䔀䜀䤀一ഀ
਍ऀ刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一匀䄀䌀吀䤀伀一 ഀ
਍ऀ刀䄀䤀匀䔀刀刀伀刀 ⠀✀吀栀攀爀攀 眀愀猀 愀渀 攀爀爀漀爀 椀渀 瀀爀漀挀攀搀甀爀攀 挀洀开匀攀琀䰀漀愀搀匀琀愀琀甀猀 眀栀椀氀攀 猀攀琀琀椀渀最 琀栀攀 氀漀愀搀 瀀愀爀愀洀攀琀攀爀猀⸀✀Ⰰ ㄀㘀Ⰰ ㄀⤀ഀ
਍䔀一䐀ഀ
਍䔀䰀匀䔀ഀ
਍䈀䔀䜀䤀一 ഀ
਍ऀ䌀伀䴀䴀䤀吀 吀刀䄀一匀䄀䌀吀䤀伀一ഀ
਍䔀一䐀ഀ
਍ഀ
਍ഀ
਍ഀ
਍ഀ
਍ഀ
਍䜀伀ഀ
਍⼀⨀⨀⨀⨀⨀⨀ 伀戀樀攀挀琀㨀  匀琀漀爀攀搀倀爀漀挀攀搀甀爀攀 嬀搀戀漀崀⸀嬀瀀开䌀吀䰀开䘀椀渀愀氀椀稀攀䰀漀愀搀崀    匀挀爀椀瀀琀 䐀愀琀攀㨀 　㘀⼀㈀㜀⼀㈀　　㜀 　㤀㨀　㜀㨀㔀㌀ ⨀⨀⨀⨀⨀⨀⼀ഀ
਍匀䔀吀 䄀一匀䤀开一唀䰀䰀匀 伀一ഀ
਍䜀伀ഀ
਍匀䔀吀 儀唀伀吀䔀䐀开䤀䐀䔀一吀䤀䘀䤀䔀刀 伀一ഀ
਍䜀伀ഀ
਍ഀ
਍䌀刀䔀䄀吀䔀 倀刀伀䌀䔀䐀唀刀䔀 嬀搀戀漀崀⸀嬀瀀开䌀吀䰀开䘀椀渀愀氀椀稀攀䰀漀愀搀崀ഀ
਍ऀ䀀䰀漀愀搀匀琀愀琀甀猀䤀䐀 䤀一吀ഀ
਍䄀匀ഀ
਍ഀ
਍匀䔀吀 一伀䌀伀唀一吀 伀一ഀ
਍ഀ
਍唀倀䐀䄀吀䔀 䌀吀䰀开䰀漀愀搀匀琀愀琀甀猀ഀ
਍   匀䔀吀 䰀漀愀搀䤀猀䌀漀洀瀀氀攀琀攀 㴀 ㄀Ⰰഀ
਍ऀऀ䔀吀䰀䘀椀渀椀猀栀吀椀洀攀 㴀 䜀䔀吀䐀䄀吀䔀⠀⤀ഀ
਍ 圀䠀䔀刀䔀 䰀漀愀搀匀琀愀琀甀猀䤀䐀 㴀 䀀䰀漀愀搀匀琀愀琀甀猀䤀䐀ഀ
਍ഀ
਍ഀ
਍ഀ
਍ഀ
਍⼀⨀⨀⨀⨀⨀⨀ 伀戀樀攀挀琀㨀  匀琀漀爀攀搀倀爀漀挀攀搀甀爀攀 嬀搀戀漀崀⸀嬀䈀䈀䈀䤀开䤀渀搀攀砀䠀椀猀琀漀爀礀崀    匀挀爀椀瀀琀 䐀愀琀攀㨀 　㘀⼀㈀㠀⼀㈀　　㜀 ㄀　㨀㄀㜀㨀㔀㌀ ⨀⨀⨀⨀⨀⨀⼀ഀ
਍匀䔀吀 䄀一匀䤀开一唀䰀䰀匀 伀一ഀ
਍䜀伀ഀ
਍匀䔀吀 儀唀伀吀䔀䐀开䤀䐀䔀一吀䤀䘀䤀䔀刀 伀一ഀ
਍䜀伀ഀ
਍䌀刀䔀䄀吀䔀 倀刀伀䌀䔀䐀唀刀䔀 嬀搀戀漀崀⸀嬀䈀䈀䈀䤀开䤀渀搀攀砀䠀椀猀琀漀爀礀崀ഀ
    	@TaskType Varchar(15) = 'HISTORY',਍ऀऀ䀀吀愀戀氀攀䘀椀氀琀攀爀 嘀愀爀挀栀愀爀⠀㔀　⤀ 㴀 ✀✀ഀ
AS਍䈀䔀䜀䤀一ഀ
-- @TaskType = 'DROP' To Drop all current NONCLUSTERED INDEXES਍ⴀⴀ 䀀吀愀猀欀吀礀瀀攀 㴀 ✀䄀䐀䐀✀ 吀漀 刀攀挀爀攀愀琀攀 愀氀氀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀䔀匀 昀爀漀洀 䠀椀猀琀漀爀礀 昀椀氀攀ഀ
-- @TaskType = 'NOW' to show Current Indexes in existance਍ⴀⴀ 䀀吀愀猀欀吀礀瀀攀 㴀 ✀䠀䤀匀吀伀刀夀✀ 琀漀 猀栀漀眀 椀渀搀攀砀攀猀 猀琀漀爀攀搀 椀渀 䠀椀猀琀漀爀礀 琀愀戀氀攀 昀漀爀 爀攀ⴀ挀爀攀愀琀椀漀渀ഀ
਍䐀䔀䌀䰀䄀刀䔀 䀀匀儀䰀 嘀愀爀挀栀愀爀⠀㈀　　　⤀ഀ
DECLARE @IndexName Varchar(100)਍䐀䔀䌀䰀䄀刀䔀 䀀吀愀戀氀攀一愀洀攀 嘀愀爀挀栀愀爀⠀㄀　　⤀ഀ
DECLARE @OutputField Varchar(50)਍䐀䔀䌀䰀䄀刀䔀 䀀䌀漀氀甀洀渀一愀洀攀 嘀愀爀挀栀愀爀⠀㔀　⤀ഀ
DECLARE @IncludeNames Varchar(1000)਍䐀䔀䌀䰀䄀刀䔀 䀀伀戀樀攀挀琀一愀洀攀 嘀愀爀挀栀愀爀⠀㄀　　⤀ഀ
DECLARE @i Int਍䐀䔀䌀䰀䄀刀䔀 䀀椀倀漀猀 䤀渀琀ഀ
DECLARE @Command Varchar(100)਍䐀䔀䌀䰀䄀刀䔀 䀀䤀渀搀攀砀䤀渀挀氀甀搀攀 匀洀愀氀氀䤀渀琀ഀ
DECLARE @NoColumns SmallInt਍ഀ
IF @TaskType <> 'ADD' AND @TaskType <> 'DROP' AND @TaskType <> 'NOW' AND @TaskType <> 'REFRESH'਍ऀ匀䔀吀 䀀吀愀猀欀吀礀瀀攀 㴀 ✀䠀䤀匀吀伀刀夀✀ഀ
਍椀昀 一伀吀 攀砀椀猀琀猀 ⠀猀攀氀攀挀琀 ⨀ 昀爀漀洀 搀戀漀⸀猀礀猀漀戀樀攀挀琀猀 眀栀攀爀攀 椀搀 㴀 漀戀樀攀挀琀开椀搀⠀一✀嬀搀戀漀崀⸀嬀䌀吀䰀开䤀渀搀攀砀䠀椀猀琀漀爀礀崀✀⤀ 愀渀搀 伀䈀䨀䔀䌀吀倀刀伀倀䔀刀吀夀⠀椀搀Ⰰ 一✀䤀猀唀猀攀爀吀愀戀氀攀✀⤀ 㴀 ㄀⤀ഀ
BEGIN਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 嬀搀戀漀崀⸀嬀䌀吀䰀开䤀渀搀攀砀䠀椀猀琀漀爀礀崀⠀ഀ
਍ऀ嬀吀愀戀氀攀匀礀猀琀攀洀䤀䐀崀 椀渀琀 一唀䰀䰀Ⰰഀ
਍ऀ嬀䤀渀搀攀砀匀礀猀琀攀洀䤀䐀崀 椀渀琀 一唀䰀䰀Ⰰഀ
਍ऀ嬀䌀漀氀甀洀渀匀礀猀琀攀洀䤀䐀崀 椀渀琀 一唀䰀䰀Ⰰഀ
਍ऀ嬀䤀渀搀攀砀䌀漀氀甀洀渀倀漀猀椀琀椀漀渀崀 猀洀愀氀氀椀渀琀 一唀䰀䰀Ⰰഀ
਍ऀ嬀䤀渀搀攀砀吀礀瀀攀崀 瘀愀爀挀栀愀爀⠀㄀㔀⤀ 䌀伀䰀䰀䄀吀䔀 匀儀䰀开䰀愀琀椀渀㄀开䜀攀渀攀爀愀氀开䌀倀㄀开䌀䤀开䄀匀 一唀䰀䰀Ⰰഀ
਍ऀ嬀吀愀戀氀攀一愀洀攀崀 瘀愀爀挀栀愀爀⠀㔀　⤀ 䌀伀䰀䰀䄀吀䔀 匀儀䰀开䰀愀琀椀渀㄀开䜀攀渀攀爀愀氀开䌀倀㄀开䌀䤀开䄀匀 一唀䰀䰀Ⰰഀ
਍ऀ嬀䤀渀搀攀砀一愀洀攀崀 瘀愀爀挀栀愀爀⠀㄀　　⤀ 䌀伀䰀䰀䄀吀䔀 匀儀䰀开䰀愀琀椀渀㄀开䜀攀渀攀爀愀氀开䌀倀㄀开䌀䤀开䄀匀 一唀䰀䰀Ⰰഀ
਍ऀ嬀䌀漀氀甀洀渀一愀洀攀崀 瘀愀爀挀栀愀爀⠀㔀　⤀ 䌀伀䰀䰀䄀吀䔀 匀儀䰀开䰀愀琀椀渀㄀开䜀攀渀攀爀愀氀开䌀倀㄀开䌀䤀开䄀匀 一唀䰀䰀Ⰰഀ
਍ऀ嬀䤀渀搀攀砀䤀渀挀氀甀搀攀崀 匀洀愀氀氀䤀渀琀 一唀䰀䰀Ⰰഀ
	[NoColumns] SmallInt NULL਍⤀ 伀一 嬀倀刀䤀䴀䄀刀夀崀ഀ
਍䔀一䐀ഀ
਍ഀ
IF @TaskType = 'DROP' OR @TaskType = 'REFRESH'਍䈀䔀䜀䤀一ഀ
	TRUNCATE TABLE [CTL_IndexHistory]਍ഀ
INSERT INTO [dbo].[CTL_IndexHistory]਍ഀ
(਍ഀ
			[TableSystemID]਍ഀ
           ,[IndexSystemID]਍ഀ
           ,[ColumnSystemID]਍ഀ
           ,[IndexColumnPosition]਍ഀ
           ,[IndexType]਍ഀ
           ,[TableName]਍ഀ
           ,[IndexName]਍ഀ
           ,[ColumnName]਍ऀऀ   ⴀⴀⰀ嬀䤀渀搀攀砀䤀渀挀氀甀搀攀崀ഀ
)਍匀䔀䰀䔀䌀吀     ഀ
਍伀⸀椀搀 䄀匀 吀愀戀氀攀匀礀猀琀攀洀䤀䐀Ⰰ ഀ
਍䤀⸀椀渀搀椀搀 䄀匀 䤀渀搀攀砀匀礀猀琀攀洀䤀䐀Ⰰ ഀ
਍䤀䬀⸀挀漀氀椀搀 䄀匀 䌀漀氀甀洀渀匀礀猀琀攀洀䤀䐀Ⰰ ഀ
਍䤀䬀⸀欀攀礀渀漀 䄀匀 䤀渀搀攀砀䌀漀氀甀洀渀倀漀猀椀琀椀漀渀Ⰰഀ
਍䌀䄀匀䔀 䤀⸀椀渀搀椀搀 圀䠀䔀一 　 吀䠀䔀一 ✀䠀攀愀瀀✀ 圀䠀䔀一 ㄀ 吀䠀䔀一 ✀䌀氀甀猀琀攀爀攀搀✀ 䔀䰀匀䔀 ✀一漀渀挀氀甀猀琀攀爀攀搀✀ 䔀一䐀 䄀匀 䤀渀搀攀砀吀礀瀀攀Ⰰഀ
਍伀⸀渀愀洀攀 䄀匀 吀愀戀氀攀一愀洀攀Ⰰ ഀ
਍䤀⸀渀愀洀攀 䄀匀 䤀渀搀攀砀一愀洀攀Ⰰഀ
਍吀䌀⸀渀愀洀攀 䄀匀 䌀漀氀甀洀渀一愀洀攀ഀ
਍䘀刀伀䴀         ഀ
਍猀礀猀挀漀氀甀洀渀猀 䄀匀 吀䌀 䤀一一䔀刀 䨀伀䤀一ഀ
਍猀礀猀漀戀樀攀挀琀猀 䄀匀 伀 䤀一一䔀刀 䨀伀䤀一ഀ
਍猀礀猀椀渀搀攀砀攀猀 䄀匀 䤀 伀一 伀⸀椀搀 㴀 䤀⸀椀搀 䤀一一䔀刀 䨀伀䤀一ഀ
਍猀礀猀椀渀搀攀砀欀攀礀猀 䄀匀 䤀䬀 伀一 䤀⸀椀渀搀椀搀 㴀 䤀䬀⸀椀渀搀椀搀 䄀一䐀 䤀⸀椀搀 㴀 䤀䬀⸀椀搀 伀一 吀䌀⸀挀漀氀椀搀 㴀 䤀䬀⸀挀漀氀椀搀 䄀一䐀 吀䌀⸀椀搀 㴀 䤀䬀⸀椀搀ഀ
਍圀䠀䔀刀䔀 ഀ
O.xtype = 'U' AND਍⠀伀⸀渀愀洀攀 䰀䤀䬀䔀 ✀䐀䤀䴀开─✀ 伀刀 伀⸀渀愀洀攀 䰀䤀䬀䔀 ✀䘀䄀䌀吀开─✀ 伀刀 伀⸀渀愀洀攀 䰀䤀䬀䔀 ✀吀䔀䴀倀开─✀⤀ഀ
ORDER BY O.id ASC, I.indid ASC, IK.keyno ASC਍ഀ
UPDATE [CTL_IndexHistory]਍匀䔀吀 䤀渀搀攀砀䤀渀挀氀甀搀攀 㴀  搀戀漀⸀䈀䈀䈀䤀开䤀渀搀攀砀䘀椀渀搀䤀渀挀氀甀搀攀⠀吀愀戀氀攀匀礀猀琀攀洀䤀䐀Ⰰ 䤀渀搀攀砀匀礀猀琀攀洀䤀䐀⤀  ഀ
਍唀倀䐀䄀吀䔀 嬀䌀吀䰀开䤀渀搀攀砀䠀椀猀琀漀爀礀崀ഀ
SET Includecolumns = dbo.BBBI_IndexCreateCmd(TableSystemID, IndexSystemID, IndexInclude) ਍ഀ
UPDATE [CTL_IndexHistory]਍ഀ
SET NoColumns = h.NoColumns਍ഀ
FROM ਍ഀ
(਍ഀ
SELECT TableSystemID, IndexSystemID, Count(*) NoColumns FROM CTL_IndexHistory GROUP BY TableSystemID, IndexSystemID਍ഀ
) h਍ഀ
WHERE CTL_IndexHistory.TableSystemID = h.TableSystemID AND CTL_IndexHistory.IndexSystemID = h.IndexSystemID਍ഀ
਍䔀一䐀 ⴀⴀ 䀀吀愀猀欀吀礀瀀攀 㴀 ✀䐀刀伀倀✀ഀ
਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀ
IF @TaskType = 'DROP'਍䈀䔀䜀䤀一ഀ
	DECLARE IndexCursor CURSOR FOR SELECT DISTINCT TableName, IndexName, IncludeColumns਍ഀ
	FROM CTL_IndexHistory WHERE IndexSystemID > 1 AND IndexColumnPosition = 1਍ഀ
	OPEN IndexCursor਍ഀ
	FETCH IndexCursor INTO @TableName, @IndexName, @IncludeNames਍ഀ
਍ഀ
	WHILE @@FETCH_STATUS = 0਍ഀ
	BEGIN਍ഀ
		SET @ObjectName = @TableName + '.' + @IndexName਍ഀ
		SET @SQL = 'IF Exists (select * from sysindexes where name = ''' + @IndexName + ''')' + ' DROP INDEX ' + @ObjectName਍ഀ
		EXEC(@SQL)਍ഀ
		PRINT 'Dropping Index ' + @ObjectName਍ഀ
		FETCH IndexCursor INTO @TableName, @IndexName, @IncludeNames਍ഀ
END਍ഀ
਍ഀ
CLOSE IndexCursor਍ഀ
DEALLOCATE IndexCursor਍ഀ
਍ഀ
END --@TaskType = 'DROP'਍ഀ
਍ഀ
---------------------------------------------------------------------------------------------------------------------------------------------------------------------਍ഀ
IF @TaskType = 'ADD'਍䈀䔀䜀䤀一ഀ
	DECLARE IndexCursor CURSOR FOR SELECT DISTINCT TableName, IndexName, IncludeColumns, ColumnName, IndexInclude, NoColumns ਍ഀ
	FROM CTL_IndexHistory WHERE IndexSystemID > 1 AND IndexColumnPosition = 1 AND TableName LIKE '%' + @TableFilter + '%'਍ഀ
	OPEN IndexCursor਍ഀ
	FETCH IndexCursor INTO @TableName, @IndexName, @IncludeNames, @ColumnName, @IndexInclude, @NoColumns਍ഀ
਍ഀ
	WHILE @@FETCH_STATUS = 0਍ഀ
	BEGIN਍ഀ
		SET @ObjectName = @TableName + '.' + @IndexName਍ഀ
		IF @NoColumns = 1਍ഀ
			SET @SQL = 'IF NOT Exists (select * from sysindexes where name = ''' + @IndexName + ''')' +਍ഀ
			'CREATE NONCLUSTERED INDEX ' + @IndexName + ' ON ' + @TableName + '(' + @ColumnName + ')'਍ഀ
		ELSE਍ഀ
		BEGIN਍ഀ
			IF @IndexInclude = 1਍ഀ
				SET @SQL = 'IF NOT Exists (select * from sysindexes where name = ''' + @IndexName + ''')' +਍ഀ
				'CREATE NONCLUSTERED INDEX ' + @IndexName + ' ON ' + @TableName + '(' + @ColumnName + ')  INCLUDE (' + @IncludeNames + ')'਍ഀ
			IF @IndexInclude <> 1਍ഀ
				SET @SQL = 'IF NOT Exists (select * from sysindexes where name = ''' + @IndexName + ''')' +਍ഀ
				'CREATE NONCLUSTERED INDEX ' + @IndexName + ' ON ' + @TableName + '(' + @IncludeNames + ')'਍ഀ
		END਍ഀ
		EXEC(@SQL)਍ഀ
		PRINT 'Adding Index ' + @IndexName + ' : ' + @SQL ਍ഀ
		--PRINT @SQL਍ഀ
   FETCH IndexCursor INTO @TableName, @IndexName, @IncludeNames, @ColumnName, @IndexInclude, @NoColumns਍ഀ
END਍ഀ
਍ഀ
CLOSE IndexCursor਍ഀ
DEALLOCATE IndexCursor਍ഀ
਍ഀ
END -- @TaskType = 'ADD'਍ഀ
਍ഀ
IF @TaskType = 'HISTORY'਍ऀ匀䔀䰀䔀䌀吀 ⨀ 䘀刀伀䴀 䌀吀䰀开䤀渀搀攀砀䠀椀猀琀漀爀礀ഀ
਍ഀ
਍䤀䘀 䀀吀愀猀欀吀礀瀀攀 㴀 ✀一伀圀✀ഀ
BEGIN਍匀䔀䰀䔀䌀吀     ഀ
਍伀⸀椀搀 䄀匀 吀愀戀氀攀匀礀猀琀攀洀䤀䐀Ⰰ ഀ
਍䤀⸀椀渀搀椀搀 䄀匀 䤀渀搀攀砀匀礀猀琀攀洀䤀䐀Ⰰ ഀ
਍䤀䬀⸀挀漀氀椀搀 䄀匀 䌀漀氀甀洀渀匀礀猀琀攀洀䤀䐀Ⰰ ഀ
਍䤀䬀⸀欀攀礀渀漀 䄀匀 䤀渀搀攀砀䌀漀氀甀洀渀倀漀猀椀琀椀漀渀Ⰰഀ
਍䌀䄀匀䔀 䤀⸀椀渀搀椀搀 圀䠀䔀一 　 吀䠀䔀一 ✀䠀攀愀瀀✀ 圀䠀䔀一 ㄀ 吀䠀䔀一 ✀䌀氀甀猀琀攀爀攀搀✀ 䔀䰀匀䔀 ✀一漀渀挀氀甀猀琀攀爀攀搀✀ 䔀一䐀 䄀匀 䤀渀搀攀砀吀礀瀀攀Ⰰഀ
਍伀⸀渀愀洀攀 䄀匀 吀愀戀氀攀一愀洀攀Ⰰ ഀ
਍䤀⸀渀愀洀攀 䄀匀 䤀渀搀攀砀一愀洀攀Ⰰഀ
਍吀䌀⸀渀愀洀攀 䄀匀 䌀漀氀甀洀渀一愀洀攀ഀ
਍䘀刀伀䴀         ഀ
਍猀礀猀挀漀氀甀洀渀猀 䄀匀 吀䌀 䤀一一䔀刀 䨀伀䤀一ഀ
਍猀礀猀漀戀樀攀挀琀猀 䄀匀 伀 䤀一一䔀刀 䨀伀䤀一ഀ
਍猀礀猀椀渀搀攀砀攀猀 䄀匀 䤀 伀一 伀⸀椀搀 㴀 䤀⸀椀搀 䤀一一䔀刀 䨀伀䤀一ഀ
਍猀礀猀椀渀搀攀砀欀攀礀猀 䄀匀 䤀䬀 伀一 䤀⸀椀渀搀椀搀 㴀 䤀䬀⸀椀渀搀椀搀 䄀一䐀 䤀⸀椀搀 㴀 䤀䬀⸀椀搀 伀一 吀䌀⸀挀漀氀椀搀 㴀 䤀䬀⸀挀漀氀椀搀 䄀一䐀 吀䌀⸀椀搀 㴀 䤀䬀⸀椀搀ഀ
਍圀䠀䔀刀䔀 ഀ
O.xtype = 'U' AND਍⠀伀⸀渀愀洀攀 䰀䤀䬀䔀 ✀䐀䤀䴀开─✀ 伀刀 伀⸀渀愀洀攀 䰀䤀䬀䔀 ✀䘀䄀䌀吀开─✀ 伀刀 伀⸀渀愀洀攀 䰀䤀䬀䔀 ✀吀䔀䴀倀开─✀ 伀刀 伀⸀渀愀洀攀 䰀䤀䬀䔀 ✀匀唀䴀䴀䄀刀夀开─✀⤀ഀ
ORDER BY O.id ASC, I.indid ASC, IK.keyno ASC਍䔀一䐀 ⴀⴀ 䀀吀愀猀欀吀礀瀀攀 㴀 ✀一伀圀✀ഀ
਍䔀一䐀ഀ
਍䜀伀ഀ
਍ഀ
਍ഀ
਍䌀刀䔀䄀吀䔀 倀刀伀䌀䔀䐀唀刀䔀 嬀搀戀漀崀⸀嬀䈀䈀䈀䤀开倀漀瀀甀氀愀琀攀䐀愀琀攀䐀椀洀崀 ഀ
	@StartDate DateTime,਍ऀ䀀䔀渀搀䐀愀琀攀 䐀愀琀攀吀椀洀攀Ⰰഀ
	@QuarterStartMonth Int਍䄀匀ഀ
BEGIN਍ⴀⴀ搀攀挀氀愀爀攀 瘀愀爀椀愀戀氀攀猀ഀ
DECLARE @DT DATETIME਍ഀ
DECLARE @i INT਍䐀䔀䌀䰀䄀刀䔀 䀀䐀愀琀攀䬀攀礀 䤀一吀ഀ
DECLARE @CalendarYear SMALLINT਍䐀䔀䌀䰀䄀刀䔀 䀀䌀愀氀攀渀搀愀爀䠀愀氀昀 吀䤀一夀䤀一吀ഀ
DECLARE @CalendarHalfName CHAR(2)਍䐀䔀䌀䰀䄀刀䔀 䀀䌀愀氀攀渀搀愀爀儀甀愀爀琀攀爀 吀䤀一夀䤀一吀ഀ
DECLARE @CalendarQuarterName CHAR(2)਍䐀䔀䌀䰀䄀刀䔀 䀀䌀愀氀攀渀搀愀爀䴀漀渀琀栀  吀䤀一夀䤀一吀ഀ
DECLARE @CalendarMonthName CHAR(10)਍䐀䔀䌀䰀䄀刀䔀 䀀䌀愀氀攀渀搀愀爀圀攀攀欀  吀䤀一夀䤀一吀ഀ
DECLARE @CalendarDayofYear SMALLINT਍ഀ
DECLARE @FiscalYear SMALLINT਍䐀䔀䌀䰀䄀刀䔀 䀀䘀椀猀挀愀氀䠀愀氀昀 吀䤀一夀䤀一吀ഀ
DECLARE @FiscalHalfName CHAR(2)਍䐀䔀䌀䰀䄀刀䔀 䀀䘀椀猀挀愀氀儀甀愀爀琀攀爀 吀䤀一夀䤀一吀ഀ
DECLARE @FiscalQuarterName CHAR(2)਍䐀䔀䌀䰀䄀刀䔀 䀀䘀椀猀挀愀氀䴀漀渀琀栀  吀䤀一夀䤀一吀ഀ
DECLARE @FiscalMonthName CHAR(10)਍䐀䔀䌀䰀䄀刀䔀 䀀䘀椀猀挀愀氀圀攀攀欀  吀䤀一夀䤀一吀ഀ
DECLARE @FiscalDayofYear SMALLINT਍ഀ
DECLARE @DayofMonth INT਍䐀䔀䌀䰀䄀刀䔀 䀀䐀愀礀漀昀圀攀攀欀 䤀一吀ഀ
DECLARE @DayName VARCHAR(12)਍ഀ
DECLARE @IsWeekend BIT਍䐀䔀䌀䰀䄀刀䔀 䀀䤀猀䠀漀氀椀搀愀礀 䈀䤀吀ഀ
DECLARE @HolidayName VARCHAR(50)਍䐀䔀䌀䰀䄀刀䔀 䀀䴀漀渀琀栀一愀洀攀 嘀䄀刀䌀䠀䄀刀⠀㈀　⤀ഀ
DECLARE @IsLeapYear BIT਍ഀ
--initialize variables਍匀䔀䰀䔀䌀吀 䀀䤀猀䠀漀氀椀搀愀礀 ऀ㴀 　ഀ
SELECT @IsWeekend 	= 0਍匀䔀䰀䔀䌀吀 䀀䘀椀猀挀愀氀圀攀攀欀 ऀ㴀 ㄀ഀ
SELECT @CalendarWeek 	= 1਍匀䔀䰀䔀䌀吀 䀀䤀猀䰀攀愀瀀夀攀愀爀 ऀ㴀 　ഀ
਍ⴀⴀ琀栀攀 猀琀愀爀琀椀渀最 搀愀琀攀 昀漀爀 琀栀攀 搀愀琀攀 搀椀洀攀渀猀椀漀渀ഀ
SELECT @DT = @StartDate਍ഀ
SET @i = 1਍ⴀⴀ猀琀愀爀琀 氀漀漀瀀椀渀最Ⰰ 猀琀漀瀀 愀琀 攀渀搀椀渀最 搀愀琀攀ഀ
WHILE (@DT <= @EndDate)਍䈀䔀䜀䤀一ഀ
--get information about the data਍ऀ匀䔀䰀䔀䌀吀 䀀䤀猀圀攀攀欀攀渀搀  ऀऀ㴀 　ഀ
	SELECT @CalendarYear 		= DATEPART (yyyy , @DT)਍ऀ匀䔀䰀䔀䌀吀 䀀䌀愀氀攀渀搀愀爀䠀愀氀昀ऀऀ㴀 䌀䄀匀䔀 䐀䄀吀䔀倀䄀刀吀⠀焀 Ⰰ 䀀䐀吀⤀ഀ
						WHEN 1 THEN 1਍ऀऀऀऀऀऀ圀䠀䔀一 ㈀ 吀䠀䔀一 ㄀ഀ
						WHEN 3 THEN 2਍ऀऀऀऀऀऀ圀䠀䔀一 㐀 吀䠀䔀一 ㈀ഀ
					  END ਍ऀ匀䔀䰀䔀䌀吀 䀀䌀愀氀攀渀搀愀爀䠀愀氀昀一愀洀攀ऀ㴀 ✀䠀✀ ⬀ 䌀䄀匀吀⠀䀀䌀愀氀攀渀搀愀爀䠀愀氀昀 䄀匀 䌀䠀䄀刀⤀ഀ
	SELECT @CalendarQuarter 	= DATEPART (q , @DT)਍ऀ匀䔀䰀䔀䌀吀 䀀䌀愀氀攀渀搀愀爀儀甀愀爀琀攀爀一愀洀攀ऀ㴀 ✀儀✀ ⬀ 䌀䄀匀吀⠀䀀䌀愀氀攀渀搀愀爀儀甀愀爀琀攀爀 䄀匀 䌀䠀䄀刀⤀ഀ
	SELECT @CalendarMonth		= DATEPART (MONTH , @DT)਍ऀ匀䔀䰀䔀䌀吀 䀀䌀愀氀攀渀搀愀爀䴀漀渀琀栀一愀洀攀ऀ㴀 䐀䄀吀䔀一䄀䴀䔀 ⠀洀洀 Ⰰ 䀀䐀吀⤀ഀ
	SELECT @CalendarWeek		= DATEPART (ww , @DT)਍ऀ匀䔀䰀䔀䌀吀 䀀䌀愀氀攀渀搀愀爀䐀愀礀漀昀夀攀愀爀ऀ㴀 䐀䄀吀䔀倀䄀刀吀 ⠀搀礀 Ⰰ 䀀䐀吀⤀ഀ
	SELECT @DayofMonth		= DATEPART (dd , @DT)਍ऀ匀䔀䰀䔀䌀吀 䀀䐀愀礀漀昀圀攀攀欀ऀऀ㴀 䐀䄀吀䔀倀䄀刀吀 ⠀搀眀 Ⰰ 䀀䐀吀⤀ഀ
	SELECT @DayName			= DATENAME (dw , @DT)਍ഀ
--SELECT DATEPART(DW, '8/24/2005')਍ⴀⴀ匀䔀䰀䔀䌀吀 䐀䄀吀䔀一䄀䴀䔀⠀䐀圀Ⰰ ✀㠀⼀㈀㐀⼀㈀　　㔀✀⤀ഀ
਍ⴀⴀ渀漀琀攀 椀昀 眀攀攀欀渀搀 漀爀 渀漀琀ഀ
IF ( @DayofWeek = 1 OR  @DayofWeek = 7 )  ਍䈀䔀䜀䤀一ഀ
	SELECT @IsWeekend	= 1਍䔀一䐀ഀ
਍ⴀⴀ愀搀搀 戀甀猀椀渀攀猀猀 爀甀氀攀 ⠀渀攀攀搀 琀漀 欀渀漀眀 挀漀洀瀀氀攀琀攀 眀攀攀欀猀 椀渀 愀 礀攀愀爀Ⰰ 猀漀 愀 瀀愀爀琀椀愀氀 眀攀攀欀 椀渀 渀攀眀 礀攀愀爀 猀攀琀 琀漀 　⤀ഀ
IF ( @DayofWeek != 1 AND @FiscalDayofYear = 1)਍䈀䔀䜀䤀一ഀ
	SELECT @FiscalWeek 	= 0਍䔀一䐀ഀ
਍ഀ
IF ( @DayofWeek = 1)਍䈀䔀䜀䤀一ഀ
	SELECT @FiscalWeek 	= @FiscalWeek + 1਍䔀一䐀ഀ
਍ⴀⴀ愀搀搀 戀甀猀椀渀攀猀猀 爀甀氀攀 ⠀猀琀愀爀琀 挀漀甀渀琀椀渀最 戀甀猀椀渀攀猀猀 眀攀攀欀猀 眀椀琀栀 昀椀爀猀琀 挀漀洀瀀氀攀琀攀 眀攀攀欀⤀ഀ
IF (@FiscalWeek = 53)਍䈀䔀䜀䤀一ഀ
	SELECT @FiscalWeek	= 1਍䔀一䐀ഀ
਍ⴀⴀ挀栀攀挀欀 昀漀爀 氀攀愀瀀 礀攀愀爀ഀ
IF ((@CalendarYear % 4 = 0)  AND (@CalendarYear % 100 != 0 OR @CalendarYear % 400 = 0))਍ऀ匀䔀䰀䔀䌀吀 䀀䤀猀䰀攀愀瀀夀攀愀爀ऀ㴀 ㄀ഀ
	ELSE SELECT @IsLeapYear 	= 0਍ഀ
--insert values into Date Dimension table਍ഀ
INSERT DIM_Date (਍ऀ䐀愀琀攀䐀椀洀䤀䐀Ⰰഀ
	--DateKey,਍ऀ䌀愀氀攀渀搀愀爀夀攀愀爀Ⰰഀ
	CalendarHalf,਍ऀ䌀愀氀攀渀搀愀爀䠀愀氀昀一愀洀攀Ⰰഀ
	CalendarQuarter,਍ऀ䌀愀氀攀渀搀愀爀儀甀愀爀琀攀爀一愀洀攀Ⰰഀ
	CalendarMonth,਍ऀ䌀愀氀攀渀搀愀爀䴀漀渀琀栀一愀洀攀Ⰰഀ
	CalendarWeek,਍ऀ䌀愀氀攀渀搀愀爀䐀愀礀漀昀夀攀愀爀Ⰰഀ
਍ऀ䘀椀猀挀愀氀夀攀愀爀Ⰰഀ
	FiscalHalf,਍ऀ䘀椀猀挀愀氀䠀愀氀昀一愀洀攀Ⰰഀ
	FiscalQuarter,਍ऀ䘀椀猀挀愀氀儀甀愀爀琀攀爀一愀洀攀Ⰰഀ
	FiscalMonth ,਍ऀ䘀椀猀挀愀氀䴀漀渀琀栀一愀洀攀Ⰰഀ
	FiscalWeek,਍ऀ䘀椀猀挀愀氀䐀愀礀漀昀夀攀愀爀Ⰰഀ
਍ऀ䐀愀礀漀昀䴀漀渀琀栀Ⰰഀ
	DayofWeek,਍ऀ䐀愀礀一愀洀攀Ⰰഀ
	IsWeekend,਍ऀ䤀猀䠀漀氀椀搀愀礀Ⰰഀ
	IsLeapYear,਍ऀ䠀漀氀椀搀愀礀一愀洀攀Ⰰഀ
	ActualDate )਍嘀䄀䰀唀䔀匀 ⠀ⴀⴀ䀀椀Ⰰഀ
	(@CalendarYear * 10000) + (@CalendarMonth * 100) + @DayofMonth,਍ऀ䀀䌀愀氀攀渀搀愀爀夀攀愀爀Ⰰ ഀ
	@CalendarHalf, ਍ऀ䀀䌀愀氀攀渀搀愀爀䠀愀氀昀一愀洀攀Ⰰ ഀ
	@CalendarQuarter, ਍ऀ䀀䌀愀氀攀渀搀愀爀儀甀愀爀琀攀爀一愀洀攀Ⰰ ഀ
	@CalendarMonth, ਍ऀ䀀䌀愀氀攀渀搀愀爀䴀漀渀琀栀一愀洀攀Ⰰ ഀ
	@CalendarWeek, ਍ऀ䀀䌀愀氀攀渀搀愀爀䐀愀礀漀昀夀攀愀爀Ⰰ ഀ
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,਍ऀ䀀䐀愀礀漀昀䴀漀渀琀栀Ⰰഀ
	@DayofWeek,਍ऀ䀀䐀愀礀一愀洀攀Ⰰഀ
	@IsWeekend,਍ऀ䀀䤀猀䠀漀氀椀搀愀礀Ⰰഀ
	@IsLeapYear,਍ऀ一唀䰀䰀Ⰰ ⴀⴀ 䠀漀氀椀搀愀礀 渀愀洀攀 ⠀漀渀氀礀 漀渀攀 瀀攀爀 搀愀琀攀⤀ഀ
	CONVERT(DATETIME, CAST(@CalendarMonth AS VARCHAR) + '/' + CAST(@DayofMonth AS VARCHAR) + '/' + CAST(@CalendarYear AS VARCHAR), 101) )਍ऀഀ
--increment the date one day਍匀䔀䰀䔀䌀吀 䀀䐀吀  㴀 䐀䄀吀䔀䄀䐀䐀⠀䐀䄀夀Ⰰ ㄀Ⰰ 䀀䐀吀⤀ഀ
਍ऀ匀䔀吀 䀀椀 㴀 䀀椀 ⬀ ㄀ഀ
਍䔀一䐀ഀ
਍ⴀⴀ䤀一匀䔀刀吀 䐀䤀䴀开䐀愀琀攀 ⠀䐀愀琀攀䐀椀洀䤀䐀Ⰰ 䐀愀琀攀䬀攀礀⤀ 嘀䄀䰀唀䔀匀 ⠀䀀椀 ⬀ ㄀Ⰰ 　⤀ഀ
਍ⴀⴀ⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀  䘀椀猀挀愀氀 匀琀甀昀昀  ⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀⨀ഀ
਍唀倀䐀䄀吀䔀 䐀䤀䴀开䐀愀琀攀ഀ
SET FiscalQuarter = Convert(Int, dbo.BBBI_CalcQuarterDate (ActualDate, @QuarterStartMonth, 10)),਍䘀椀猀挀愀氀儀甀愀爀琀攀爀一愀洀攀 㴀 搀戀漀⸀䈀䈀䈀䤀开䌀愀氀挀儀甀愀爀琀攀爀䐀愀琀攀 ⠀䄀挀琀甀愀氀䐀愀琀攀Ⰰ 䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀Ⰰ ㄀⤀Ⰰഀ
FiscalYear = dbo.BBBI_ReturnFiscalYear (ActualDate, @QuarterStartMonth) ਍ ഀ
UPDATE DIM_Date਍匀䔀吀 䘀椀猀挀愀氀䠀愀氀昀 㴀 䌀䄀匀䔀 圀䠀䔀一 䘀椀猀挀愀氀儀甀愀爀琀攀爀 䤀一 ⠀㄀Ⰰ㈀⤀ 吀䠀䔀一 ㄀ 䔀䰀匀䔀 ㈀ 䔀一䐀Ⰰഀ
FiscalHalfName = CASE WHEN FiscalQuarter IN (1,2) THEN 'H1' ELSE 'H2' END਍ⴀⴀⰀ䄀挀琀甀愀氀䘀椀猀挀愀氀䐀愀琀攀 㴀 䌀漀渀瘀攀爀琀⠀䐀愀琀攀吀椀洀攀Ⰰ 䌀漀渀瘀攀爀琀⠀嘀愀爀挀栀愀爀⠀㐀⤀Ⰰ 䘀椀猀挀愀氀夀攀愀爀⤀ ⬀ ✀⼀✀⬀䌀漀渀瘀攀爀琀⠀嘀愀爀挀栀愀爀⠀㈀⤀Ⰰ 䌀愀氀攀渀搀愀爀䴀漀渀琀栀⤀ ⬀ ✀⼀✀⬀ 䌀漀渀瘀攀爀琀⠀嘀愀爀挀栀愀爀⠀㈀⤀Ⰰ 䐀愀礀漀昀䴀漀渀琀栀⤀Ⰰ㄀　㄀⤀ഀ
਍唀倀䐀䄀吀䔀 䐀䤀䴀开䐀愀琀攀ഀ
SET FiscalYearStart = Convert(DateTime, Convert(Varchar(4), dbo.BBBI_ReturnFiscalYear(ActualDate, @QuarterStartMonth) -1) + '/'+਍䌀漀渀瘀攀爀琀⠀嘀愀爀挀栀愀爀⠀㈀⤀Ⰰ 䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀⤀⬀ ✀⼀　㄀✀Ⰰ㄀　㄀⤀Ⰰഀ
FiscalYearEnd = Convert(DateTime, Convert(Varchar(4), dbo.BBBI_ReturnFiscalYear(ActualDate, @QuarterStartMonth)) + '/'+਍䌀漀渀瘀攀爀琀⠀嘀愀爀挀栀愀爀⠀㈀⤀Ⰰ 䀀儀甀愀爀琀攀爀匀琀愀爀琀䴀漀渀琀栀⤀⬀ ✀⼀　㄀✀Ⰰ㄀　㄀⤀ ⴀ㄀ഀ
਍唀倀䐀䄀吀䔀 䐀䤀䴀开䐀愀琀攀ഀ
SET FiscalDayofYear = DATEDIFF([Day], FiscalYearStart, ActualDate) + 1,਍䘀椀猀挀愀氀圀攀攀欀 㴀 䐀䄀吀䔀䐀䤀䘀䘀⠀嬀圀攀攀欀崀Ⰰ 䘀椀猀挀愀氀夀攀愀爀匀琀愀爀琀Ⰰ 䄀挀琀甀愀氀䐀愀琀攀⤀ ⬀ ㄀Ⰰഀ
FiscalMonth = DATEDIFF([Month], FiscalYearStart, ActualDate) + 1,਍䘀椀猀挀愀氀䴀漀渀琀栀一愀洀攀 㴀 䐀䄀吀䔀一䄀䴀䔀 ⠀洀洀 Ⰰ 䄀挀琀甀愀氀䐀愀琀攀⤀ഀ
਍ⴀⴀ 倀攀爀椀漀搀 匀琀愀爀琀 ☀ 䔀渀搀ഀ
਍唀倀䐀䄀吀䔀 ഀ
਍䐀䤀䴀开䐀愀琀攀ഀ
਍匀䔀吀ഀ
਍倀攀爀椀漀搀匀琀愀爀琀 㴀 䌀漀渀瘀攀爀琀⠀䐀愀琀攀吀椀洀攀Ⰰ 䌀漀渀瘀攀爀琀⠀嘀愀爀挀栀愀爀⠀㐀⤀Ⰰ 䌀愀氀攀渀搀愀爀夀攀愀爀⤀ ⬀ ✀ⴀ✀ ⬀ 䌀漀渀瘀攀爀琀⠀嘀愀爀挀栀愀爀⠀㈀⤀Ⰰ 䌀愀氀攀渀搀愀爀䴀漀渀琀栀⤀ ⬀ ✀ⴀ㄀✀Ⰰ ㄀　㄀⤀Ⰰഀ
਍倀攀爀椀漀搀䔀渀搀 㴀 䐀愀琀攀䄀搀搀⠀洀洀Ⰰ ㄀Ⰰ 䌀漀渀瘀攀爀琀⠀䐀愀琀攀吀椀洀攀Ⰰ 䌀漀渀瘀攀爀琀⠀嘀愀爀挀栀愀爀⠀㐀⤀Ⰰ 䌀愀氀攀渀搀愀爀夀攀愀爀⤀ ⬀ ✀ⴀ✀ ⬀ 䌀漀渀瘀攀爀琀⠀嘀愀爀挀栀愀爀⠀㈀⤀Ⰰ 䌀愀氀攀渀搀愀爀䴀漀渀琀栀⤀ ⬀ ✀ⴀ㄀✀Ⰰ ㄀　㄀⤀⤀ ⴀ ㄀ഀ
਍ഀ
਍ⴀⴀ 䘀椀猀挀愀氀 儀甀愀爀琀攀爀 匀琀愀爀琀 ☀ 䔀渀搀ഀ
਍唀倀䐀䄀吀䔀 ഀ
਍䐀䤀䴀开䐀愀琀攀ഀ
਍匀䔀吀ഀ
਍䘀椀猀挀愀氀儀甀愀爀琀攀爀匀琀愀爀琀 㴀 琀⸀儀甀愀爀琀攀爀匀琀愀爀琀Ⰰഀ
਍䘀椀猀挀愀氀儀甀愀爀琀攀爀䔀渀搀 㴀 琀⸀儀甀愀爀琀攀爀䔀渀搀ഀ
਍䘀刀伀䴀ഀ
਍⠀ഀ
਍匀䔀䰀䔀䌀吀ഀ
਍䘀椀猀挀愀氀夀攀愀爀Ⰰ 䘀椀猀挀愀氀儀甀愀爀琀攀爀Ⰰഀ
਍䴀椀渀⠀䄀挀琀甀愀氀䐀愀琀攀⤀ 䄀匀 儀甀愀爀琀攀爀匀琀愀爀琀Ⰰ 䴀愀砀⠀䄀挀琀甀愀氀䐀愀琀攀⤀ 䄀匀 儀甀愀爀琀攀爀䔀渀搀ഀ
਍䘀刀伀䴀ഀ
਍䐀䤀䴀开䐀愀琀攀ഀ
਍䜀刀伀唀倀 䈀夀ഀ
਍䘀椀猀挀愀氀夀攀愀爀Ⰰ 䘀椀猀挀愀氀儀甀愀爀琀攀爀ഀ
਍⤀ 琀ഀ
਍圀䠀䔀刀䔀ഀ
਍琀⸀䘀椀猀挀愀氀夀攀愀爀 㴀 䐀䤀䴀开䐀愀琀攀⸀䘀椀猀挀愀氀夀攀愀爀 䄀一䐀ഀ
਍琀⸀䘀椀猀挀愀氀儀甀愀爀琀攀爀 㴀 䐀䤀䴀开䐀愀琀攀⸀䘀椀猀挀愀氀儀甀愀爀琀攀爀ഀ
਍ഀ
਍ⴀⴀ 䌀愀氀攀渀搀愀爀 儀甀愀爀琀攀爀 匀琀愀爀琀 ☀ 䔀渀搀ഀ
਍唀倀䐀䄀吀䔀 ഀ
਍䐀䤀䴀开䐀愀琀攀ഀ
਍匀䔀吀ഀ
਍䌀愀氀攀渀搀愀爀儀甀愀爀琀攀爀匀琀愀爀琀 㴀 琀⸀儀甀愀爀琀攀爀匀琀愀爀琀Ⰰഀ
਍䌀愀氀攀渀搀愀爀儀甀愀爀琀攀爀䔀渀搀 㴀 琀⸀儀甀愀爀琀攀爀䔀渀搀ഀ
਍䘀刀伀䴀ഀ
਍⠀ഀ
਍匀䔀䰀䔀䌀吀ഀ
਍䌀愀氀攀渀搀愀爀夀攀愀爀Ⰰ 䌀愀氀攀渀搀愀爀儀甀愀爀琀攀爀Ⰰഀ
਍䴀椀渀⠀䄀挀琀甀愀氀䐀愀琀攀⤀ 䄀匀 儀甀愀爀琀攀爀匀琀愀爀琀Ⰰ 䴀愀砀⠀䄀挀琀甀愀氀䐀愀琀攀⤀ 䄀匀 儀甀愀爀琀攀爀䔀渀搀ഀ
਍䘀刀伀䴀ഀ
਍䐀䤀䴀开䐀愀琀攀ഀ
਍䜀刀伀唀倀 䈀夀ഀ
਍䌀愀氀攀渀搀愀爀夀攀愀爀Ⰰ 䌀愀氀攀渀搀愀爀儀甀愀爀琀攀爀ഀ
਍⤀ 琀ഀ
਍圀䠀䔀刀䔀ഀ
਍琀⸀䌀愀氀攀渀搀愀爀夀攀愀爀 㴀 䐀䤀䴀开䐀愀琀攀⸀䌀愀氀攀渀搀愀爀夀攀愀爀 䄀一䐀ഀ
਍琀⸀䌀愀氀攀渀搀愀爀儀甀愀爀琀攀爀 㴀 䐀䤀䴀开䐀愀琀攀⸀䌀愀氀攀渀搀愀爀儀甀愀爀琀攀爀ഀ
਍ഀ
਍ⴀⴀ 䌀愀氀攀渀搀愀爀 儀甀愀爀琀攀爀 匀琀愀爀琀 ☀ 䔀渀搀ഀ
਍唀倀䐀䄀吀䔀 ഀ
਍䐀䤀䴀开䐀愀琀攀ഀ
਍匀䔀吀ഀ
਍䌀愀氀攀渀搀愀爀儀甀愀爀琀攀爀匀琀愀爀琀 㴀 琀⸀儀甀愀爀琀攀爀匀琀愀爀琀Ⰰഀ
਍䌀愀氀攀渀搀愀爀儀甀愀爀琀攀爀䔀渀搀 㴀 琀⸀儀甀愀爀琀攀爀䔀渀搀ഀ
਍䘀刀伀䴀ഀ
਍⠀ഀ
਍匀䔀䰀䔀䌀吀ഀ
਍䌀愀氀攀渀搀愀爀夀攀愀爀Ⰰ 䌀愀氀攀渀搀愀爀儀甀愀爀琀攀爀Ⰰഀ
਍䴀椀渀⠀䄀挀琀甀愀氀䐀愀琀攀⤀ 䄀匀 儀甀愀爀琀攀爀匀琀愀爀琀Ⰰ 䴀愀砀⠀䄀挀琀甀愀氀䐀愀琀攀⤀ 䄀匀 儀甀愀爀琀攀爀䔀渀搀ഀ
਍䘀刀伀䴀ഀ
਍䐀䤀䴀开䐀愀琀攀ഀ
਍䜀刀伀唀倀 䈀夀ഀ
਍䌀愀氀攀渀搀愀爀夀攀愀爀Ⰰ 䌀愀氀攀渀搀愀爀儀甀愀爀琀攀爀ഀ
਍⤀ 琀ഀ
਍圀䠀䔀刀䔀ഀ
਍琀⸀䌀愀氀攀渀搀愀爀夀攀愀爀 㴀 䐀䤀䴀开䐀愀琀攀⸀䌀愀氀攀渀搀愀爀夀攀愀爀 䄀一䐀ഀ
਍琀⸀䌀愀氀攀渀搀愀爀儀甀愀爀琀攀爀 㴀 䐀䤀䴀开䐀愀琀攀⸀䌀愀氀攀渀搀愀爀儀甀愀爀琀攀爀ഀ
਍ഀ
਍䔀一䐀ഀ
਍ഀ
਍䜀伀ഀ
਍ഀ
਍ഀ
਍�