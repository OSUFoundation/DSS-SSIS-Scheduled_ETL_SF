਍ഀ
/****** Object:  Table [dbo].[CTL_IndexHistory]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[CTL_IndexHistory](਍ഀ
	[TableSystemID] [int] NULL,਍ഀ
	[IndexSystemID] [int] NULL,਍ഀ
	[ColumnSystemID] [int] NULL,਍ഀ
	[IndexColumnPosition] [smallint] NULL,਍ഀ
	[IndexType] [varchar](15) NULL,਍ഀ
	[TableName] [varchar](50) NULL,਍ഀ
	[IndexName] [varchar](100) NULL,਍ഀ
	[ColumnName] [varchar](50) NULL,਍ഀ
	[IncludeColumns] [varchar](500) NULL,਍ഀ
	[IndexInclude] [smallint] NULL,਍ഀ
	[NoColumns] [smallint] NULL਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[CTL_LoadHistory]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[CTL_LoadHistory](਍ഀ
	[LoadHistoryID] [int] IDENTITY(1,1) NOT NULL,਍ഀ
	[Process] [varchar](100) NULL,਍ഀ
	[ObjectName] [varchar](100) NULL,਍ഀ
	[ProcessStartTime] [datetime] NULL,਍ഀ
	[ProcessEndTime] [datetime] NULL,਍ഀ
	[ElapsedTime] [int] NULL,਍ഀ
	[ObjectCount] [int] NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
	[WarehouseID] [int] NULL,਍ഀ
 CONSTRAINT [PK_CTL_LoadHistory] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[LoadHistoryID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[CTL_LoadStatus]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[CTL_LoadStatus](਍ഀ
	[SourceLoadID] [int] NOT NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
	[LoadStatusID] [int] IDENTITY(1,1) NOT NULL,਍ഀ
	[LoadIsComplete] [int] NULL,਍ഀ
	[ETLStartTime] [datetime] NULL,਍ഀ
	[ETLFinishTime] [datetime] NULL,਍ഀ
	[DataWindowOpen] [datetime] NULL,਍ഀ
	[DataWindowClose] [datetime] NULL,਍ഀ
	[TruncateTables] [bit] NULL,਍ഀ
 CONSTRAINT [PK_CTL_LoadStatus_1] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[LoadStatusID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[CTL_WHTableStats]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[CTL_WHTableStats](਍ഀ
	[ObjectName] [varchar](50) NULL,਍ഀ
	[ObjectType] [varchar](50) NULL,਍ഀ
	[StatsType] [varchar](50) NULL,਍ഀ
	[Value] [int] NULL,਍ഀ
	[Date] [datetime] NULL,਍ഀ
	[ID] [int] IDENTITY(1,1) NOT NULL,਍ഀ
 CONSTRAINT [PK_CTL_WHTableStats] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[ID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[DIM_Account]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[DIM_Account](਍ഀ
	[AccountDimID] [int] NOT NULL,਍ഀ
	[AccountSystemID] [int] NOT NULL,਍ഀ
	[AccountCode] [varchar](30) NULL,਍ഀ
	[AccountNumber] [varchar](30) NULL,਍ഀ
	[AccountDescription] [varchar](60) NULL,਍ഀ
	[AccountCategoryID] [smallint] NULL,਍ഀ
	[AccountCategoryDescription] [varchar](9) NULL,਍ഀ
	[ClassDimID] [int] NULL,਍ഀ
	[ClassSystemID] [int] NULL,਍ഀ
	[ClassDescription] [varchar](60) NULL,਍ഀ
	[WorkingCapitalID] [int] NULL,਍ഀ
	[WorkingCapital] [varchar](60) NULL,਍ഀ
	[CashFlowID] [int] NULL,਍ഀ
	[CashFlow] [varchar](60) NULL,਍ഀ
	[AccountStatusID] [smallint] NULL,਍ഀ
	[AccountStatusDescription] [varchar](30) NULL,਍ഀ
	[FundSystemID] [int] NULL,਍ഀ
	[AccountCodeID] [int] NULL,਍ഀ
	[PreventPostDate] [datetime] NULL,਍ഀ
	[GeneralInfoID] [int] NULL,਍ഀ
	[DateAdded] [datetime] NULL,਍ഀ
	[DateChanged] [datetime] NULL,਍ഀ
	[ContraAccount] [varchar](1) NULL,਍ഀ
	[ControlAccount] [varchar](1) NULL,਍ഀ
	[CashAccount] [varchar](1) NULL,਍ഀ
	[AnnotationText] [text] NULL,਍ഀ
	[FundID] [varchar](10) NULL,਍ഀ
	[FundDescription] [varchar](60) NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
 CONSTRAINT [PK_DIM_Account] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[AccountDimID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[DIM_AccountAttribute]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[DIM_AccountAttribute](਍ഀ
	[AccountAttributeDimID] [int] NOT NULL,਍ഀ
	[AccountAttributesID] [int] IDENTITY(1,1) NOT NULL,਍ഀ
	[AccountDimID] [int] NULL,਍ഀ
	[AccountSystemID] [int] NULL,਍ഀ
	[AttributeSystemID] [int] NULL,਍ഀ
	[AttributeCategory] [varchar](50) NULL,਍ഀ
	[AttributeDescription] [varchar](255) NULL,਍ഀ
	[Sequence] [smallint] NULL,਍ഀ
	[Comments] [varchar](255) NULL,਍ഀ
	[AttributeDate] [datetime] NULL,਍ഀ
	[TypeOfData] [varchar](11) NULL,਍ഀ
	[Required] [varchar](3) NULL,਍ഀ
	[MustBeUnique] [varchar](3) NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NOT NULL,਍ഀ
 CONSTRAINT [PK_DIM_AccountAttribute] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[AccountAttributeDimID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[DIM_Class]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[DIM_Class](਍ഀ
	[ClassDimID] [int] NOT NULL,਍ഀ
	[ClassSystemID] [int] NULL,਍ഀ
	[ClassCode] [int] NULL,਍ഀ
	[ClassName] [varchar](60) NULL,਍ഀ
	[ClassType] [varchar](60) NULL,਍ഀ
	[Sequence] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
 CONSTRAINT [PK_DIM_Class] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[ClassDimID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[DIM_Date]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[DIM_Date](਍ഀ
	[DateDimID] [int] NOT NULL,਍ഀ
	[CalendarYear] [smallint] NULL,਍ഀ
	[CalendarHalf] [smallint] NULL,਍ഀ
	[CalendarHalfName] [char](2) NULL,਍ഀ
	[CalendarQuarter] [smallint] NULL,਍ഀ
	[CalendarQuarterName] [char](2) NULL,਍ഀ
	[CalendarMonth] [smallint] NULL,਍ഀ
	[CalendarMonthName] [varchar](12) NULL,਍ഀ
	[CalendarWeek] [smallint] NULL,਍ഀ
	[CalendarDayofYear] [smallint] NULL,਍ഀ
	[FiscalYear] [smallint] NULL,਍ഀ
	[FiscalHalf] [smallint] NULL,਍ഀ
	[FiscalHalfName] [char](2) NULL,਍ഀ
	[FiscalQuarter] [smallint] NULL,਍ഀ
	[FiscalQuarterName] [char](2) NULL,਍ഀ
	[FiscalMonth] [smallint] NULL,਍ഀ
	[FiscalMonthName] [varchar](12) NULL,਍ഀ
	[FiscalWeek] [smallint] NULL,਍ഀ
	[FiscalDayofYear] [smallint] NULL,਍ഀ
	[DayofMonth] [smallint] NULL,਍ഀ
	[DayofWeek] [smallint] NULL,਍ഀ
	[DayName] [varchar](12) NULL,਍ഀ
	[IsWeekend] [bit] NULL,਍ഀ
	[IsHoliday] [bit] NULL,਍ഀ
	[IsLeapYear] [bit] NULL,਍ഀ
	[HolidayName] [varchar](100) NULL,਍ഀ
	[ActualDate] [datetime] NULL,਍ഀ
	[FiscalYearStart] [datetime] NULL,਍ഀ
	[FiscalYearEnd] [datetime] NULL,਍ഀ
	[FiscalQuarterStart] [datetime] NULL,਍ഀ
	[FiscalQuarterEnd] [datetime] NULL,਍ഀ
	[CalendarQuarterStart] [datetime] NULL,਍ഀ
	[CalendarQuarterEnd] [datetime] NULL,਍ഀ
	[PeriodStart] [datetime] NULL,਍ഀ
	[PeriodEnd] [datetime] NULL,਍ഀ
	[FE_FiscalYear] [varchar](12) NULL,਍ഀ
	[FE_FiscalYearSequence] [int] NULL,਍ഀ
	[FE_FiscalPeriodStartDate] [datetime] NULL,਍ഀ
	[FE_FiscalPeriodEndDate] [datetime] NULL,਍ഀ
	[FE_FiscalPeriodIsClosed] [varchar](10) NULL,਍ഀ
	[FE_FiscalPeriodSequence] [smallint] NULL,਍ഀ
	[Sequence] [int] IDENTITY(1,1) NOT NULL,਍ഀ
 CONSTRAINT [PK_DIM_Date] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[DateDimID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[DIM_GLSourceType]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[DIM_GLSourceType](਍ഀ
	[SourceTypeDimID] [int] IDENTITY(1,1) NOT NULL,਍ഀ
	[SourceTypeCode] [int] NOT NULL,਍ഀ
	[SourceType] [varchar](50) NOT NULL,਍ഀ
	[SourceTypeGroup] [varchar](25) NULL,਍ഀ
 CONSTRAINT [PK_DIM_GLSourceType] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[SourceTypeDimID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[DIM_InvoiceAttribute]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[DIM_InvoiceAttribute](਍ഀ
	[InvoiceAttributeDimID] [int] NOT NULL,਍ഀ
	[InvoiceAttributesID] [int] IDENTITY(1,1) NOT NULL,਍ഀ
	[InvoiceSystemID] [int] NULL,਍ഀ
	[InvoiceFactID] [int] NULL,਍ഀ
	[AttributeSystemID] [int] NULL,਍ഀ
	[AttributeCategory] [varchar](50) NULL,਍ഀ
	[AttributeDescription] [varchar](255) NULL,਍ഀ
	[Sequence] [smallint] NULL,਍ഀ
	[Comments] [varchar](255) NULL,਍ഀ
	[AttributeDate] [datetime] NULL,਍ഀ
	[TypeOfData] [varchar](11) NULL,਍ഀ
	[Required] [varchar](3) NULL,਍ഀ
	[MustBeUnique] [varchar](3) NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NOT NULL,਍ഀ
 CONSTRAINT [PK_DIM_InvoiceAttribute] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[InvoiceAttributeDimID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[DIM_Journal]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[DIM_Journal](਍ഀ
	[JournalDimID] [int] NOT NULL,਍ഀ
	[JournalLabel] [varchar](255) NULL,਍ഀ
	[JournalCode] [int] NULL,਍ഀ
	[JournalName] [varchar](60) NULL,਍ഀ
	[JournalShortName] [varchar](10) NULL,਍ഀ
	[TableSequence] [int] NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
 CONSTRAINT [PK_DIM_Journal] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[JournalDimID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[DIM_PostStatus]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[DIM_PostStatus](਍ഀ
	[PostStatusDimID] [smallint] NOT NULL,਍ഀ
	[PostStatusCode] [int] NOT NULL,਍ഀ
	[PostStatus] [varchar](50) NULL,਍ഀ
 CONSTRAINT [PK_DIM_PostStatus] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[PostStatusDimID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[DIM_Project]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[DIM_Project](਍ഀ
	[ProjectDimID] [int] NOT NULL,਍ഀ
	[ProjectSystemID] [int] NOT NULL,਍ഀ
	[ProjectID] [varchar](12) NULL,਍ഀ
	[ProjectDescription] [varchar](60) NULL,਍ഀ
	[ProjectStatusID] [int] NULL,਍ഀ
	[ProjectStatusDescription] [varchar](60) NULL,਍ഀ
	[ProjectTypeID] [int] NULL,਍ഀ
	[ProjectTypeDescription] [varchar](60) NULL,਍ഀ
	[ProjectStartDate] [datetime] NULL,਍ഀ
	[ProjectEndDate] [datetime] NULL,਍ഀ
	[ProjectActive] [varchar](50) NULL,਍ഀ
	[PreventPostDate] [datetime] NULL,਍ഀ
	[DateAdded] [datetime] NULL,਍ഀ
	[DateChanged] [datetime] NULL,਍ഀ
	[AnnotationText] [varchar](255) NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
	[ParentProjectSystemID] [int] NULL,਍ഀ
	[ParentProjectDimID] [int] NULL,਍ഀ
 CONSTRAINT [PK_DIM_Projects] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[ProjectDimID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[DIM_ProjectAttribute]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[DIM_ProjectAttribute](਍ഀ
	[ProjectAttributeDimID] [int] NOT NULL,਍ഀ
	[ProjectAttributesID] [int] IDENTITY(1,1) NOT NULL,਍ഀ
	[ProjectDimID] [int] NULL,਍ഀ
	[ProjectSystemID] [int] NULL,਍ഀ
	[AttributeSystemID] [int] NULL,਍ഀ
	[AttributeCategory] [varchar](50) NULL,਍ഀ
	[AttributeDescription] [varchar](255) NULL,਍ഀ
	[Sequence] [smallint] NULL,਍ഀ
	[Comments] [varchar](255) NULL,਍ഀ
	[AttributeDate] [datetime] NULL,਍ഀ
	[TypeOfData] [varchar](11) NULL,਍ഀ
	[Required] [varchar](3) NULL,਍ഀ
	[MustBeUnique] [varchar](3) NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NOT NULL,਍ഀ
 CONSTRAINT [PK_DIM_ProjectAttribute] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[ProjectAttributeDimID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[DIM_Scenario]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[DIM_Scenario](਍ഀ
	[ScenarioDimID] [int] NOT NULL,਍ഀ
	[ScenarioSystemID] [int] NULL,਍ഀ
	[ScenarioID] [int] NULL,਍ഀ
	[ScenarioName] [varchar](60) NULL,਍ഀ
	[Status] [varchar](8) NULL,਍ഀ
	[IsLocked] [varchar](1) NULL,਍ഀ
	[FiscalYearDescription] [varchar](60) NULL,਍ഀ
	[NoFiscalPeriods] [smallint] NULL,਍ഀ
	[DateAdded] [datetime] NULL,਍ഀ
	[DateChanged] [datetime] NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
 CONSTRAINT [PK_DIM_Scenario] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[ScenarioDimID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[DIM_Source]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[DIM_Source](਍ഀ
	[SourceDimID] [int] NOT NULL,਍ഀ
	[CurrentDateDimID] [int] NULL,਍ഀ
	[OrganizationName] [varchar](100) NULL,਍ഀ
	[FirstFiscalEndDate] [datetime] NULL,਍ഀ
	[LastFiscalEndDate] [datetime] NULL,਍ഀ
	[FiscalYearStart] [varchar](10) NULL,਍ഀ
	[FiscalYearEnd] [varchar](10) NULL,਍ഀ
	[FiscalMonthStart] [tinyint] NULL,਍ഀ
	[RefreshDate] [datetime] NULL,਍ഀ
	[LastQtrStartDate] [datetime] NULL,਍ഀ
	[LastQtrEndDate] [datetime] NULL,਍ഀ
	[LastPeriodStartDate] [datetime] NULL,਍ഀ
	[LastPeriodEndDate] [datetime] NULL,਍ഀ
	[CurrentFiscalStartDate] [datetime] NULL,਍ഀ
	[CurrentFiscalEndDate] [datetime] NULL,਍ഀ
	[FirstPostDate] [datetime] NULL,਍ഀ
	[LastPostDate] [datetime] NULL,਍ഀ
	[ClosedYearEndDate] [datetime] NULL,਍ഀ
	[OpenYearStartDate] [datetime] NULL,਍ഀ
	[OpenYearFirstPeriodEndDate] [datetime] NULL,਍ഀ
	[NoSPPeriods] [smallint] NULL,਍ഀ
	[SPBalanceStartDate] [datetime] NULL,਍ഀ
	[SPBalanceEndDate] [datetime] NULL,਍ഀ
 CONSTRAINT [PK_DIM_source] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[SourceDimID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[DIM_TransactionCode]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[DIM_TransactionCode](਍ഀ
	[TransactionCodeDimID] [int] NOT NULL,਍ഀ
	[TransactionCodeSystemID] [int] NULL,਍ഀ
	[TransactionCode] [varchar](60) NULL,਍ഀ
	[TableSequence] [int] NULL,਍ഀ
	[TransactionCodeName] [varchar](100) NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
 CONSTRAINT [PK_DIM_TransactionCode] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[TransactionCodeDimID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[DIM_TransactionType]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[DIM_TransactionType](਍ഀ
	[TransactionTypeDimID] [smallint] NOT NULL,਍ഀ
	[TransactionTypeCode] [int] NULL,਍ഀ
	[TransactionType] [varchar](10) NULL,਍ഀ
 CONSTRAINT [PK_DIM_TransactionType] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[TransactionTypeDimID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[DIM_VCO]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[DIM_VCO](਍ഀ
	[VCODimID] [int] NOT NULL,਍ഀ
	[ChartTemplateSystemID] [int] NULL,਍ഀ
	[TemplateDetailsID] [int] NULL,਍ഀ
	[RecordType] [smallint] NULL,਍ഀ
	[Level] [smallint] NULL,਍ഀ
	[Sequence] [int] NULL,਍ഀ
	[Caption] [varchar](91) NULL,਍ഀ
	[AccountCode] [varchar](30) NOT NULL,਍ഀ
	[TotalCaption] [varchar](60) NULL,਍ഀ
	[AccountCategory] [varchar](9) NULL,਍ഀ
	[ParentKey] [varchar](20) NULL,਍ഀ
	[ParentVCODimID] [int] NULL,਍ഀ
	[TemplateStatus] [varchar](8) NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
 CONSTRAINT [PK_DIM_VCO] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[VCODimID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[DIM_Vendor]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[DIM_Vendor](਍ഀ
	[VendorDimID] [int] NOT NULL,਍ഀ
	[VendorSystemID] [int] NULL,਍ഀ
	[UserDefinedID] [varchar](20) NULL,਍ഀ
	[TaxIDNumber] [varchar](20) NULL,਍ഀ
	[FEImportID] [varchar](50) NULL,਍ഀ
	[VendorName] [varchar](60) NULL,਍ഀ
	[VendorSearchName] [varchar](60) NULL,਍ഀ
	[VendorDisplayName] [varchar](60) NULL,਍ഀ
	[CustomerNumber] [varchar](20) NULL,਍ഀ
	[PaymentOption] [smallint] NULL,਍ഀ
	[Status] [varchar](8) NULL,਍ഀ
	[HasCreditLimit] [varchar](1) NULL,਍ഀ
	[CreditLimitAmount] [numeric](19, 4) NULL,਍ഀ
	[DefaultPaymentMethod] [varchar](10) NULL,਍ഀ
	[DateAdded] [datetime] NULL,਍ഀ
	[DateChanged] [datetime] NULL,਍ഀ
	[VendorBalance] [numeric](19, 4) NULL,਍ഀ
	[HighestBalance] [numeric](19, 4) NULL,਍ഀ
	[CheckNotes] [varchar](95) NULL,਍ഀ
	[DistributedDiscount] [varchar](1) NULL,਍ഀ
	[IsVendor1099] [varchar](1) NULL,਍ഀ
	[TotalPurgedInvoicesAmount] [numeric](19, 4) NULL,਍ഀ
	[TotalPurgedCreditMemosAmount] [numeric](19, 4) NULL,਍ഀ
	[TotalPurgedPOAmount] [numeric](19, 4) NULL,਍ഀ
	[BankName] [varchar](60) NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
 CONSTRAINT [PK_DIM_Vendor] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[VendorDimID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[FACT_AccountBudget]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[FACT_AccountBudget](਍ഀ
	[AccountBudgetFactID] [int] NOT NULL,਍ഀ
	[AccountBudgetSystemID] [int] NOT NULL,਍ഀ
	[AccountDimID] [int] NULL,਍ഀ
	[AccountSystemID] [int] NULL,਍ഀ
	[ScenarioDimID] [int] NULL,਍ഀ
	[ScenarioSystemID] [int] NULL,਍ഀ
	[ScenarioID] [int] NULL,਍ഀ
	[ScenarioDescription] [varchar](60) NULL,਍ഀ
	[ScenarioSequence] [smallint] NULL,਍ഀ
	[PeriodStartDate] [datetime] NULL,਍ഀ
	[PeriodStartDateDimID] [int] NULL,਍ഀ
	[PeriodEndDate] [datetime] NULL,਍ഀ
	[PeriodEndDateDimID] [int] NULL,਍ഀ
	[Closed] [smallint] NULL,਍ഀ
	[PeriodSequence] [smallint] NULL,਍ഀ
	[FiscalYearDesc] [varchar](60) NULL,਍ഀ
	[YearID] [varchar](12) NULL,਍ഀ
	[FiscalYearSequence] [int] NULL,਍ഀ
	[FiscalPeriods] [smallint] NULL,਍ഀ
	[FiscalYearStatus] [smallint] NULL,਍ഀ
	[DateAdded] [datetime] NULL,਍ഀ
	[DateChanged] [datetime] NULL,਍ഀ
	[Amount] [decimal](19, 4) NULL,਍ഀ
	[Percent] [decimal](20, 4) NULL,਍ഀ
	[Notes] [varchar](255) NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
 CONSTRAINT [PK_FACT_AccountBudget] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[AccountBudgetFactID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[FACT_APCreditMemo]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[FACT_APCreditMemo](਍ഀ
	[APCreditMemoFactID] [int] NULL,਍ഀ
	[CreditMemoSystemID] [int] NULL,਍ഀ
	[CreditMemoNumber] [varchar](20) NULL,਍ഀ
	[CreditMemoDate] [varchar](10) NULL,਍ഀ
	[CreditMemoDescription] [varchar](60) NULL,਍ഀ
	[CreditMemoStatus] [varchar](17) NULL,਍ഀ
	[PostDate] [datetime] NULL,਍ഀ
	[PostStatus] [varchar](20) NULL,਍ഀ
	[ReversePostStatus] [varchar](14) NULL,਍ഀ
	[ReverseDate] [varchar](10) NULL,਍ഀ
	[IsDeleted] [varchar](1) NULL,਍ഀ
	[Amount] [numeric](19, 4) NULL,਍ഀ
	[InvoiceNumber] [varchar](20) NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[FACT_APTransactionDistribution]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[FACT_APTransactionDistribution](਍ഀ
	[TransactionDistributionFactID] [int] NOT NULL,਍ഀ
	[APTransDistributionSystemID] [int] NULL,਍ഀ
	[APDistributionID] [int] NULL,਍ഀ
	[InvoiceFactID] [int] NULL,਍ഀ
	[InvoiceNumber] [varchar](20) NULL,਍ഀ
	[InvoiceDate] [datetime] NULL,਍ഀ
	[InvoiceDateDimID] [int] NULL,਍ഀ
	[VendorSystemID] [int] NULL,਍ഀ
	[VendorDimID] [int] NULL,਍ഀ
	[AccountDimID] [int] NULL,਍ഀ
	[AccountSystemID] [int] NULL,਍ഀ
	[AccountCode] [varchar](30) NULL,਍ഀ
	[AccountNumber] [varchar](30) NULL,਍ഀ
	[AccountDescription] [varchar](60) NULL,਍ഀ
	[ProjectDimID] [int] NULL,਍ഀ
	[ProjectSystemID] [int] NULL,਍ഀ
	[ProjectID] [varchar](20) NULL,਍ഀ
	[ProjectDescription] [varchar](60) NULL,਍ഀ
	[GLTransactionSystemID] [int] NULL,਍ഀ
	[TransactionType] [varchar](6) NULL,਍ഀ
	[TransactionTypeDimID] [int] NULL,਍ഀ
	[DistributionType] [varchar](18) NULL,਍ഀ
	[Percent] [decimal](20, 4) NULL,਍ഀ
	[LinkKey] [int] NULL,਍ഀ
	[ParentObjectType] [int] NULL,਍ഀ
	[RowNumber] [int] NULL,਍ഀ
	[Interfund] [smallint] NULL,਍ഀ
	[MiscEntry] [smallint] NULL,਍ഀ
	[TaxEntityID] [int] NULL,਍ഀ
	[TransactionCode1DimID] [int] NULL,਍ഀ
	[TransactionCode2DimID] [int] NULL,਍ഀ
	[TransactionCode3DimID] [int] NULL,਍ഀ
	[TransactionCode4DimID] [int] NULL,਍ഀ
	[TransactionCode5DimID] [int] NULL,਍ഀ
	[Class] [int] NULL,਍ഀ
	[Sequence] [int] NULL,਍ഀ
	[Amount] [money] NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
 CONSTRAINT [PK_FACT_APTransactionDistribution] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[TransactionDistributionFactID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
਍ഀ
਍ഀ
/****** Object:  Table [dbo].[FACT_InvoicePayment]    Script Date: 06/27/2007 19:36:30 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[FACT_InvoicePayment](਍ഀ
	[InvoicePaymentFactID] [int] NOT NULL,਍ഀ
	[PaymentSystemID] [int] NULL,਍ഀ
	[PostDate] [datetime] NULL,਍ഀ
	[Amount] [numeric](19, 4) NULL,਍ഀ
	[InvoiceNumber] [varchar](20) NULL,਍ഀ
	[InvoiceSystemID] [int] NULL,਍ഀ
	[VendorDimID] [int] NULL,਍ഀ
	[VendorSystemID] [int] NULL,਍ഀ
	[CheckDate] [datetime] NULL,਍ഀ
	[CheckType] [varchar](14) NULL,਍ഀ
	[CheckNumber] [int] NULL,਍ഀ
	[CheckNotes] [varchar](95) NULL,਍ഀ
	[PayeeName] [varchar](100) NULL,਍ഀ
	[ContactName] [varchar](60) NULL,਍ഀ
	[PostStatusSystemID] [smallint] NULL,਍ഀ
	[IsCleared] [varchar](1) NULL,਍ഀ
	[ClearedDate] [datetime] NULL,਍ഀ
	[IsVoided] [varchar](1) NULL,਍ഀ
	[VoidedDate] [datetime] NULL,਍ഀ
	[IsReconciled] [varchar](1) NULL,਍ഀ
	[ReconciledDate] [datetime] NULL,਍ഀ
	[BankSystemID] [int] NULL,਍ഀ
	[AccountNumber] [varchar](19) NULL,਍ഀ
	[BankName] [varchar](70) NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
 CONSTRAINT [PK_FACT_InvoicePayment] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[InvoicePaymentFactID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
਍ഀ
਍ഀ
/****** Object:  Table [dbo].[FACT_CRDeposit]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[FACT_CRDeposit](਍ഀ
	[CRDepositFactID] [int] NOT NULL,਍ഀ
	[DepositID] [varchar](12) NULL,਍ഀ
	[DepositDate] [datetime] NULL,਍ഀ
	[DepositNumber] [int] NULL,਍ഀ
	[CreditDescription] [varchar](60) NULL,਍ഀ
	[Status] [varchar](15) NULL,਍ഀ
	[EntryDate] [datetime] NULL,਍ഀ
	[Bank] [varchar](20) NULL,਍ഀ
	[PostDate] [datetime] NULL,਍ഀ
	[PostStatus] [varchar](19) NULL,਍ഀ
	[IsDepositCleared] [varchar](1) NULL,਍ഀ
	[DepositClearedDate] [varchar](10) NULL,਍ഀ
	[IsDepositReconciled] [varchar](1) NULL,਍ഀ
	[DepositReconciledDate] [varchar](10) NULL,਍ഀ
	[ActualTotalAmount] [numeric](19, 4) NULL,਍ഀ
	[ProjectedTotalAmount] [numeric](19, 4) NULL,਍ഀ
	[ActualNoReceipts] [int] NULL,਍ഀ
	[ProjectedNoReceipts] [int] NULL,਍ഀ
	[IsVoided] [varchar](1) NULL,਍ഀ
	[VoidedDate] [varchar](10) NULL,਍ഀ
	[CRDepositSystemID] [int] NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
 CONSTRAINT [PK_FACT_CRDeposit] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[CRDepositFactID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[FACT_GLTransactionDistribution]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[FACT_GLTransactionDistribution](਍ഀ
	[TransactionDistributionFactID] [int] NOT NULL,਍ഀ
	[AccountDimID] [int] NULL,਍ഀ
	[AccountSystemID] [int] NULL,਍ഀ
	[AccountCode] [varchar](30) NULL,਍ഀ
	[AccountNumber] [varchar](30) NULL,਍ഀ
	[AccountDescription] [varchar](60) NULL,਍ഀ
	[AccountCategoryID] [int] NULL,਍ഀ
	[AccountCategory] [varchar](20) NULL,਍ഀ
	[ProjectDimID] [int] NULL,਍ഀ
	[ProjectSystemID] [int] NULL,਍ഀ
	[ProjectID] [varchar](12) NULL,਍ഀ
	[ProjectDescription] [varchar](60) NULL,਍ഀ
	[FundID] [varchar](50) NULL,਍ഀ
	[FundDescription] [varchar](60) NULL,਍ഀ
	[PostDateDimID] [int] NULL,਍ഀ
	[PostDate] [datetime] NULL,਍ഀ
	[PostStatusDimID] [smallint] NULL,਍ഀ
	[TransactionTypeDimID] [smallint] NULL,਍ഀ
	[TransactionType] [varchar](7) NULL,਍ഀ
	[TransactionCode1DimID] [int] NULL,਍ഀ
	[TransactionCode2DimID] [int] NULL,਍ഀ
	[TransactionCode3DimID] [int] NULL,਍ഀ
	[TransactionCode4DimID] [int] NULL,਍ഀ
	[TransactionCode5DimID] [int] NULL,਍ഀ
	[Amount] [money] NULL,਍ഀ
	[NaturalAmount] [money] NULL,਍ഀ
	[TransactionNumber] [varchar](18) NULL,਍ഀ
	[TransactionSystemID] [int] NULL,਍ഀ
	[FiscalPeriodsSystemID] [int] NULL,਍ഀ
	[PostStatus] [varchar](20) NULL,਍ഀ
	[JournalDimID] [int] NULL,਍ഀ
	[Journal] [varchar](60) NULL,਍ഀ
	[JournalReference] [varchar](100) NULL,਍ഀ
	[BatchNumber] [varchar](50) NULL,਍ഀ
	[BatchDescription] [varchar](100) NULL,਍ഀ
	[BatchStatus] [varchar](20) NULL,਍ഀ
	[SourceRecordsID] [int] NULL,਍ഀ
	[GLSourceTypeDimID] [int] NULL,਍ഀ
	[SourceNumber] [varchar](20) NULL,਍ഀ
	[SourceType] [int] NULL,਍ഀ
	[SourceTypeName] [varchar](50) NULL,਍ഀ
	[SourceTypeGroup] [varchar](50) NULL,਍ഀ
	[TransactionDateAdded] [datetime] NULL,਍ഀ
	[TransactionDateChanged] [datetime] NULL,਍ഀ
	[ProjectPeriodSequence] [int] NULL,਍ഀ
	[ClassDimID] [int] NULL,਍ഀ
	[ClassSystemID] [int] NULL,਍ഀ
	[ClassDescription] [varchar](60) NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
 CONSTRAINT [PK_FACT_GLTransactionDistribution] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[TransactionDistributionFactID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[FACT_Invoice]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[FACT_Invoice](਍ഀ
	[InvoiceFactID] [int] NOT NULL,਍ഀ
	[InvoiceSystemID] [int] NULL,਍ഀ
	[InvoiceNumber] [varchar](20) NULL,਍ഀ
	[PONumber] [varchar](20) NULL,਍ഀ
	[InvoiceDescription] [varchar](60) NULL,਍ഀ
	[InvoiceDate] [datetime] NULL,਍ഀ
	[InvoiceDateDimID] [int] NULL,਍ഀ
	[DueDate] [datetime] NULL,਍ഀ
	[DueDateDimID] [int] NULL,਍ഀ
	[PostDate] [datetime] NULL,਍ഀ
	[PostDateDimID] [int] NULL,਍ഀ
	[PostStatus] [varchar](19) NULL,਍ഀ
	[Status] [varchar](14) NULL,਍ഀ
	[VendorDimID] [int] NULL,਍ഀ
	[VendorSystemID] [int] NULL,਍ഀ
	[VendorName] [varchar](60) NULL,਍ഀ
	[ReversePostStatus] [varchar](14) NULL,਍ഀ
	[ReversePostDate] [datetime] NULL,਍ഀ
	[ReversePostDateDimID] [int] NULL,਍ഀ
	[PostStatusDimID] [smallint] NULL,਍ഀ
	[ReversePostStatusDimID] [smallint] NULL,਍ഀ
	[InvoiceAmount] [numeric](19, 4) NULL,਍ഀ
	[InvoiceBalance] [numeric](19, 4) NULL,਍ഀ
	[TaxAmount] [numeric](19, 4) NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
 CONSTRAINT [PK_FACT_Invoice] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[InvoiceFactID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[FACT_ProjectAccountBalance]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[FACT_ProjectAccountBalance](਍ഀ
	[ProjectAccountBalanceFactID] [int] NOT NULL,਍ഀ
	[ProjectDimID] [int] NULL,਍ഀ
	[AccountDimID] [int] NULL,਍ഀ
	[TransactionCodeDimID] [int] NULL,਍ഀ
	[BalanceDate] [datetime] NULL,਍ഀ
	[BalanceDateDimID] [int] NULL,਍ഀ
	[Balance] [money] NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
 CONSTRAINT [PK_FACT_ProjectAccountBalance] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[ProjectAccountBalanceFactID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[FACT_ProjectBalance]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[FACT_ProjectBalance](਍ഀ
	[ProjectBalanceFactID] [int] NOT NULL,਍ഀ
	[ProjectDimID] [int] NULL,਍ഀ
	[ProjectSystemID] [int] NULL,਍ഀ
	[ProjectID] [varchar](20) NULL,਍ഀ
	[AccountCategory] [int] NULL,਍ഀ
	[TransactionCodeDimID] [int] NULL,਍ഀ
	[BalanceDate] [datetime] NULL,਍ഀ
	[BalanceDateDimID] [int] NULL,਍ഀ
	[Balance] [money] NULL,਍ഀ
	[BalanceSubType] [varchar](50) NULL,਍ഀ
	[BalanceType] [varchar](1) NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
 CONSTRAINT [PK_FACT_ProjectBalance] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[ProjectBalanceFactID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[FACT_ProjectBudget]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[FACT_ProjectBudget](਍ഀ
	[ProjectBudgetFactID] [int] NOT NULL,਍ഀ
	[ProjectBudgetDetailSystemID] [int] NOT NULL,਍ഀ
	[ProjectBudgetSystemID] [int] NULL,਍ഀ
	[ScenarioDimID] [int] NULL,਍ഀ
	[ScenarioSystemID] [int] NULL,਍ഀ
	[ScenarioID] [int] NULL,਍ഀ
	[ScenarioDescription] [varchar](60) NULL,਍ഀ
	[ScenarioSequence] [smallint] NULL,਍ഀ
	[AccountBudgetID] [int] NULL,਍ഀ
	[AccountDimID] [int] NULL,਍ഀ
	[AccountSystemID] [int] NULL,਍ഀ
	[ProjectDimID] [int] NULL,਍ഀ
	[ProjectSystemID] [int] NULL,਍ഀ
	[FiscalPeriodSystemID] [int] NULL,਍ഀ
	[Amount] [decimal](19, 4) NULL,਍ഀ
	[Percent] [decimal](19, 4) NULL,਍ഀ
	[PeriodStartDate] [datetime] NULL,਍ഀ
	[PeriodStartDateDimID] [int] NULL,਍ഀ
	[PeriodEndDate] [datetime] NULL,਍ഀ
	[PeriodEndDateDimID] [int] NULL,਍ഀ
	[IsFiscalYearClosed] [varchar](1) NULL,਍ഀ
	[PeriodSequence] [smallint] NULL,਍ഀ
	[FiscalYearDesc] [varchar](60) NULL,਍ഀ
	[FiscalYearSequence] [int] NULL,਍ഀ
	[FiscalPeriods] [smallint] NULL,਍ഀ
	[FiscalYearStatus] [smallint] NULL,਍ഀ
	[DateAdded] [datetime] NULL,਍ഀ
	[DateChanged] [datetime] NULL,਍ഀ
	[ETLControlID] [int] NULL,਍ഀ
	[SourceID] [int] NULL,਍ഀ
 CONSTRAINT [PK_FACT_ProjectBudget] PRIMARY KEY CLUSTERED ਍ഀ
(਍ഀ
	[ProjectBudgetFactID] ASC਍ഀ
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[TEMP_Allocations]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[TEMP_Allocations](਍ഀ
	[ProjectAllocationFactID] [int] NULL,਍ഀ
	[ProjectDimID] [int] NULL,਍ഀ
	[PoolDimID] [int] NULL,਍ഀ
	[AllocationDate] [datetime] NULL,਍ഀ
	[AllocationDateDimID] [int] NULL,਍ഀ
	[AllocationValue] [numeric](25, 12) NULL,਍ഀ
	[TotalValue] [numeric](25, 12) NULL,਍ഀ
	[Sequence] [int] NULL਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[TEMP_BeginningBalances]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[TEMP_BeginningBalances](਍ഀ
	[ProjectDimID] [int] NULL,਍ഀ
	[AccountDimID] [int] NULL,਍ഀ
	[BalanceDate] [datetime] NULL,਍ഀ
	[TransactionCode1DimID] [int] NULL,਍ഀ
	[TransactionCode2DimID] [int] NULL,਍ഀ
	[TransactionCode3DimID] [int] NULL,਍ഀ
	[TransactionCode4DimID] [int] NULL,਍ഀ
	[TransactionCode5DimID] [int] NULL,਍ഀ
	[TransactionTypeID] [int] NULL,਍ഀ
	[TransactionType] [varchar](6) NULL,਍ഀ
	[Balance] [numeric](38, 4) NULL਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[TEMP_CodeTables]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[TEMP_CodeTables](਍ഀ
	[TableEntrySystemID] [int] NULL,਍ഀ
	[CodeTableSystemID] [int] NULL,਍ഀ
	[CodeTableName] [varchar](30) NULL,਍ഀ
	[Sequence] [smallint] NULL,਍ഀ
	[EntrySystemID] [varchar](6) NULL,਍ഀ
	[TableEntryName] [varchar](60) NULL,਍ഀ
	[NumericValue] [numeric](15, 3) NULL,਍ഀ
	[ParentSystemID] [int] NULL,਍ഀ
	[SystemEntry] [smallint] NULL,਍ഀ
	[ShortUpperCaseTranslation] [varchar](55) NULL,਍ഀ
	[LongUpperCaseTranslation] [varchar](255) NULL,਍ഀ
	[Active] [smallint] NULL,਍ഀ
	[ShortProperCaseTranslation] [varchar](55) NULL,਍ഀ
	[LongProperCaseTranslation] [varchar](255) NULL,਍ഀ
	[TableSequence] [int] NULL਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[TEMP_GLSourceTypes]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[TEMP_GLSourceTypes](਍ഀ
	[SourceTypeCode] [int] NOT NULL,਍ഀ
	[SourceTypeName] [varchar](60) NULL,਍ഀ
	[BatchType] [varchar](60) NULL਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF਍ഀ
GO਍ഀ
/****** Object:  Table [dbo].[TEMP_GLSummary]    Script Date: 06/27/2007 19:03:50 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
SET ANSI_PADDING ON਍ഀ
GO਍ഀ
CREATE TABLE [dbo].[TEMP_GLSummary](਍ഀ
	[Status] [varchar](10) NULL,਍ഀ
	[GL7SummaryID] [int] NULL,਍ഀ
	[ProjectDimID] [int] NULL,਍ഀ
	[ProjectSystemID] [int] NULL,਍ഀ
	[ProjectID] [varchar](12) NULL,਍ഀ
	[AccountDimID] [int] NULL,਍ഀ
	[AccountSystemID] [int] NULL,਍ഀ
	[AccountNumber] [varchar](30) NULL,਍ഀ
	[AccountCategoryCode] [smallint] NULL,਍ഀ
	[BeginningBalance] [numeric](19, 4) NULL,਍ഀ
	[Credit] [numeric](19, 4) NULL,਍ഀ
	[Debit] [numeric](19, 4) NULL,਍ഀ
	[TransactionCode1DimID] [int] NULL,਍ഀ
	[TransactionCode2DimID] [int] NULL,਍ഀ
	[TransactionCode3DimID] [int] NULL,਍ഀ
	[TransactionCode4DimID] [int] NULL,਍ഀ
	[TransactionCode5DimID] [int] NULL,਍ഀ
	[Class] [int] NULL,਍ഀ
	[YearID] [varchar](12) NULL,਍ഀ
	[YearDescription] [varchar](60) NULL,਍ഀ
	[FiscalCloseStatus] [varchar](11) NULL,਍ഀ
	[FiscalSummarized] [smallint] NULL,਍ഀ
	[FiscalPeriods] [smallint] NULL,਍ഀ
	[FiscalYearSequence] [int] NULL,਍ഀ
	[FiscalPeriodSequence] [smallint] NULL,਍ഀ
	[FiscalPeriodClosed] [int] NULL,਍ഀ
	[StartDate] [datetime] NULL,਍ഀ
	[EndDate] [datetime] NULL,਍ഀ
	[StartDateDimID] [int] NULL਍ഀ
) ON [PRIMARY]਍ഀ
਍ഀ
GO਍ഀ
SET ANSI_PADDING OFF