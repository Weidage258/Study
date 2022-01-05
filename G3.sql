USE [master]
GO
/****** Object:  Database [Wagemanagement]    Script Date: 2021/6/6 19:59:56 ******/
CREATE DATABASE [Wagemanagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Wagemanagement', FILENAME = N'E:\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Wagemanagement.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Wagemanagement_log', FILENAME = N'E:\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Wagemanagement_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Wagemanagement] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Wagemanagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Wagemanagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Wagemanagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Wagemanagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Wagemanagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Wagemanagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [Wagemanagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Wagemanagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Wagemanagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Wagemanagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Wagemanagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Wagemanagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Wagemanagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Wagemanagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Wagemanagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Wagemanagement] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Wagemanagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Wagemanagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Wagemanagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Wagemanagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Wagemanagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Wagemanagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Wagemanagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Wagemanagement] SET RECOVERY FULL 
GO
ALTER DATABASE [Wagemanagement] SET  MULTI_USER 
GO
ALTER DATABASE [Wagemanagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Wagemanagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Wagemanagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Wagemanagement] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Wagemanagement] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Wagemanagement', N'ON'
GO
ALTER DATABASE [Wagemanagement] SET QUERY_STORE = OFF
GO
USE [Wagemanagement]
GO
/****** Object:  Table [dbo].[Bonus]    Script Date: 2021/6/6 19:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bonus](
	[Bonus_Id] [int] IDENTITY(1,1) NOT NULL,
	[BonusName] [nvarchar](50) NOT NULL,
	[Bonus_pirce] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_Bonus] PRIMARY KEY CLUSTERED 
(
	[Bonus_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bonus_Records]    Script Date: 2021/6/6 19:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bonus_Records](
	[BR_id] [int] IDENTITY(1,1) NOT NULL,
	[Staff_id] [int] NOT NULL,
	[Bonus_Id] [int] NOT NULL,
	[CR_date] [date] NOT NULL,
 CONSTRAINT [PK_Bonus_Records] PRIMARY KEY CLUSTERED 
(
	[BR_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 2021/6/6 19:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[Staff_id] [int] NOT NULL,
	[Staff_Pwd] [nvarchar](20) NOT NULL,
	[Staff_Name] [nvarchar](50) NOT NULL,
	[Sraff_State] [nvarchar](50) NOT NULL,
	[Role_id] [int] NOT NULL,
	[Grade_Id] [int] NOT NULL,
	[Department_Id] [int] NOT NULL,
	[Staff_Sex] [int] NOT NULL,
	[Staff_Address] [nvarchar](50) NOT NULL,
	[Staff_Phone] [nvarchar](50) NOT NULL,
	[Store_Id] [int] NOT NULL,
	[Staff_Email] [nvarchar](50) NOT NULL,
	[Staff_Remark] [nvarchar](50) NULL,
 CONSTRAINT [PK_Staff_1] PRIMARY KEY CLUSTERED 
(
	[Staff_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Bonus_Rd_View]    Script Date: 2021/6/6 19:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Bonus_Rd_View]
AS
SELECT  dbo.Bonus_Records.BR_id, dbo.Bonus_Records.Staff_id, dbo.Bonus.BonusName, dbo.Staff.Staff_Name, 
                   dbo.Bonus_Records.CR_date
FROM      dbo.Bonus_Records INNER JOIN
                   dbo.Bonus ON dbo.Bonus_Records.Bonus_Id = dbo.Bonus.Bonus_Id INNER JOIN
                   dbo.Staff ON dbo.Bonus_Records.Staff_id = dbo.Staff.Staff_id
GO
/****** Object:  Table [dbo].[Cwa]    Script Date: 2021/6/6 19:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cwa](
	[Cwa_id] [int] IDENTITY(1,1) NOT NULL,
	[Cwa_Name] [nvarchar](50) NOT NULL,
	[Cwa_pirce] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_Cwa] PRIMARY KEY CLUSTERED 
(
	[Cwa_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cwa_Records]    Script Date: 2021/6/6 19:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cwa_Records](
	[CR_id] [int] IDENTITY(1,1) NOT NULL,
	[Staff_id] [int] NOT NULL,
	[Cwa_id] [int] NOT NULL,
	[CR_Frequency] [decimal](18, 0) NOT NULL,
	[CR_date] [date] NOT NULL,
 CONSTRAINT [PK_Cwa_Records] PRIMARY KEY CLUSTERED 
(
	[CR_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 2021/6/6 19:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[Department_Id] [int] NOT NULL,
	[Bonus _Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[Department_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grade]    Script Date: 2021/6/6 19:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grade](
	[Grade_Id] [int] NOT NULL,
	[Grade _Name] [nvarchar](50) NOT NULL,
	[Grade_price] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_Grade] PRIMARY KEY CLUSTERED 
(
	[Grade_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 2021/6/6 19:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Role_id] [int] IDENTITY(1,1) NOT NULL,
	[Role_Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Store]    Script Date: 2021/6/6 19:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store](
	[Store_Id] [int] NOT NULL,
	[Store_Name] [nvarchar](50) NOT NULL,
	[Store_Address] [nvarchar](50) NOT NULL,
	[Store_ Leader] [nvarchar](50) NOT NULL,
	[Store_state] [nvarchar](50) NOT NULL,
	[Store_Remarks] [nvarchar](50) NULL,
 CONSTRAINT [PK_Store)] PRIMARY KEY CLUSTERED 
(
	[Store_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subsidy]    Script Date: 2021/6/6 19:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subsidy](
	[Subsidy_id] [int] NOT NULL,
	[Subsidy_Name] [nvarchar](50) NOT NULL,
	[Subsidy_pirce] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_Subsidy] PRIMARY KEY CLUSTERED 
(
	[Subsidy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subsidy_Records]    Script Date: 2021/6/6 19:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subsidy_Records](
	[SR_Id] [int] IDENTITY(1,1) NOT NULL,
	[Staff_id] [int] NOT NULL,
	[Subsidy_id] [int] NOT NULL,
	[SR_date] [date] NOT NULL,
 CONSTRAINT [PK_Subsidy_Records] PRIMARY KEY CLUSTERED 
(
	[SR_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wages_Records]    Script Date: 2021/6/6 19:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wages_Records](
	[WR_id] [int] IDENTITY(1,1) NOT NULL,
	[Staff_id] [int] NOT NULL,
	[Deduction] [decimal](18, 0) NOT NULL,
	[SubsidyAmount] [decimal](18, 0) NOT NULL,
	[WR_Pay] [decimal](18, 0) NOT NULL,
	[WR_remarks] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_Wages_Records] PRIMARY KEY CLUSTERED 
(
	[WR_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bonus] ON 
GO
INSERT [dbo].[Bonus] ([Bonus_Id], [BonusName], [Bonus_pirce]) VALUES (1, N'最具发展力奖', CAST(500 AS Decimal(18, 0)))
GO
INSERT [dbo].[Bonus] ([Bonus_Id], [BonusName], [Bonus_pirce]) VALUES (7, N'年度最佳员工1', CAST(1000 AS Decimal(18, 0)))
GO
SET IDENTITY_INSERT [dbo].[Bonus] OFF
GO
SET IDENTITY_INSERT [dbo].[Bonus_Records] ON 
GO
INSERT [dbo].[Bonus_Records] ([BR_id], [Staff_id], [Bonus_Id], [CR_date]) VALUES (4, 202105200, 1, CAST(N'2021-06-06' AS Date))
GO
INSERT [dbo].[Bonus_Records] ([BR_id], [Staff_id], [Bonus_Id], [CR_date]) VALUES (10, 202105252, 7, CAST(N'2021-06-02' AS Date))
GO
INSERT [dbo].[Bonus_Records] ([BR_id], [Staff_id], [Bonus_Id], [CR_date]) VALUES (12, 202105201, 1, CAST(N'2021-06-06' AS Date))
GO
INSERT [dbo].[Bonus_Records] ([BR_id], [Staff_id], [Bonus_Id], [CR_date]) VALUES (13, 202105251, 7, CAST(N'2021-06-06' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Bonus_Records] OFF
GO
SET IDENTITY_INSERT [dbo].[Cwa] ON 
GO
INSERT [dbo].[Cwa] ([Cwa_id], [Cwa_Name], [Cwa_pirce]) VALUES (1, N'迟到', CAST(60 AS Decimal(18, 0)))
GO
INSERT [dbo].[Cwa] ([Cwa_id], [Cwa_Name], [Cwa_pirce]) VALUES (2, N'早退', CAST(60 AS Decimal(18, 0)))
GO
INSERT [dbo].[Cwa] ([Cwa_id], [Cwa_Name], [Cwa_pirce]) VALUES (3, N'旷工', CAST(15 AS Decimal(18, 0)))
GO
SET IDENTITY_INSERT [dbo].[Cwa] OFF
GO
INSERT [dbo].[Department] ([Department_Id], [Bonus _Name]) VALUES (1, N'门店部')
GO
INSERT [dbo].[Department] ([Department_Id], [Bonus _Name]) VALUES (2, N'营销部')
GO
INSERT [dbo].[Department] ([Department_Id], [Bonus _Name]) VALUES (3, N'产品策划部')
GO
INSERT [dbo].[Department] ([Department_Id], [Bonus _Name]) VALUES (4, N'技术指导部')
GO
INSERT [dbo].[Department] ([Department_Id], [Bonus _Name]) VALUES (5, N'人事部')
GO
INSERT [dbo].[Department] ([Department_Id], [Bonus _Name]) VALUES (6, N'财务部')
GO
INSERT [dbo].[Grade] ([Grade_Id], [Grade _Name], [Grade_price]) VALUES (1, N'店长', CAST(7000 AS Decimal(18, 0)))
GO
INSERT [dbo].[Grade] ([Grade_Id], [Grade _Name], [Grade_price]) VALUES (2, N'员工', CAST(3500 AS Decimal(18, 0)))
GO
INSERT [dbo].[Grade] ([Grade_Id], [Grade _Name], [Grade_price]) VALUES (3, N'实习生', CAST(2500 AS Decimal(18, 0)))
GO
INSERT [dbo].[Grade] ([Grade_Id], [Grade _Name], [Grade_price]) VALUES (4, N'部长', CAST(6500 AS Decimal(18, 0)))
GO
SET IDENTITY_INSERT [dbo].[Role] ON 
GO
INSERT [dbo].[Role] ([Role_id], [Role_Name]) VALUES (1, N'管理员')
GO
INSERT [dbo].[Role] ([Role_id], [Role_Name]) VALUES (2, N'店长')
GO
INSERT [dbo].[Role] ([Role_id], [Role_Name]) VALUES (3, N'普通员工')
GO
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
INSERT [dbo].[Staff] ([Staff_id], [Staff_Pwd], [Staff_Name], [Sraff_State], [Role_id], [Grade_Id], [Department_Id], [Staff_Sex], [Staff_Address], [Staff_Phone], [Store_Id], [Staff_Email], [Staff_Remark]) VALUES (202105200, N'1234', N'枫若', N'在职', 1, 4, 6, 1, N'湖南长沙', N'15696358467', 3, N'5698465@qq.com', NULL)
GO
INSERT [dbo].[Staff] ([Staff_id], [Staff_Pwd], [Staff_Name], [Sraff_State], [Role_id], [Grade_Id], [Department_Id], [Staff_Sex], [Staff_Address], [Staff_Phone], [Store_Id], [Staff_Email], [Staff_Remark]) VALUES (202105251, N'123456', N'熊少坤', N'在职', 2, 1, 1, 0, N'湖南邵阳', N'13698564273', 1, N'45678955@qq.com', NULL)
GO
INSERT [dbo].[Staff] ([Staff_id], [Staff_Pwd], [Staff_Name], [Sraff_State], [Role_id], [Grade_Id], [Department_Id], [Staff_Sex], [Staff_Address], [Staff_Phone], [Store_Id], [Staff_Email], [Staff_Remark]) VALUES (202105252, N'123456', N'刘戴式', N'在职', 3, 2, 1, 0, N'湖南长沙', N'15698355648', 1, N'45896544@qq.com', NULL)
GO
INSERT [dbo].[Store] ([Store_Id], [Store_Name], [Store_Address], [Store_ Leader], [Store_state], [Store_Remarks]) VALUES (1, N'煮仙丹(万家丽广场店)', N'万家丽广场店', N'熊少坤', N'营业', N'')
GO
INSERT [dbo].[Store] ([Store_Id], [Store_Name], [Store_Address], [Store_ Leader], [Store_state], [Store_Remarks]) VALUES (3, N'主仙丹(总部)', N'长沙ifs国际中心', N'屈宾', N'营业', N'煮仙丹总部')
GO
INSERT [dbo].[Subsidy] ([Subsidy_id], [Subsidy_Name], [Subsidy_pirce]) VALUES (1, N'交通补贴', CAST(150 AS Decimal(18, 0)))
GO
ALTER TABLE [dbo].[Bonus]  WITH CHECK ADD  CONSTRAINT [FK_Bonus_Bonus] FOREIGN KEY([Bonus_Id])
REFERENCES [dbo].[Bonus] ([Bonus_Id])
GO
ALTER TABLE [dbo].[Bonus] CHECK CONSTRAINT [FK_Bonus_Bonus]
GO
ALTER TABLE [dbo].[Bonus_Records]  WITH CHECK ADD  CONSTRAINT [FK_Bonus_Records_Staff] FOREIGN KEY([Bonus_Id])
REFERENCES [dbo].[Bonus] ([Bonus_Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Bonus_Records] CHECK CONSTRAINT [FK_Bonus_Records_Staff]
GO
ALTER TABLE [dbo].[Cwa_Records]  WITH CHECK ADD  CONSTRAINT [FK_Cwa_Records_Staff] FOREIGN KEY([Cwa_id])
REFERENCES [dbo].[Cwa] ([Cwa_id])
GO
ALTER TABLE [dbo].[Cwa_Records] CHECK CONSTRAINT [FK_Cwa_Records_Staff]
GO
ALTER TABLE [dbo].[Cwa_Records]  WITH CHECK ADD  CONSTRAINT [FK_Cwa_Records_Staff1] FOREIGN KEY([Staff_id])
REFERENCES [dbo].[Staff] ([Staff_id])
GO
ALTER TABLE [dbo].[Cwa_Records] CHECK CONSTRAINT [FK_Cwa_Records_Staff1]
GO
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_Role] FOREIGN KEY([Role_id])
REFERENCES [dbo].[Role] ([Role_id])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK_Role_Role]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Department] FOREIGN KEY([Department_Id])
REFERENCES [dbo].[Department] ([Department_Id])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_Staff_Department]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Grade] FOREIGN KEY([Grade_Id])
REFERENCES [dbo].[Grade] ([Grade_Id])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_Staff_Grade]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Role] FOREIGN KEY([Role_id])
REFERENCES [dbo].[Role] ([Role_id])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_Staff_Role]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Store] FOREIGN KEY([Store_Id])
REFERENCES [dbo].[Store] ([Store_Id])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_Staff_Store]
GO
ALTER TABLE [dbo].[Subsidy_Records]  WITH CHECK ADD  CONSTRAINT [FK_Subsidy_Records_Staff] FOREIGN KEY([Subsidy_id])
REFERENCES [dbo].[Subsidy] ([Subsidy_id])
GO
ALTER TABLE [dbo].[Subsidy_Records] CHECK CONSTRAINT [FK_Subsidy_Records_Staff]
GO
ALTER TABLE [dbo].[Subsidy_Records]  WITH CHECK ADD  CONSTRAINT [FK_Subsidy_Records_Staff1] FOREIGN KEY([Staff_id])
REFERENCES [dbo].[Staff] ([Staff_id])
GO
ALTER TABLE [dbo].[Subsidy_Records] CHECK CONSTRAINT [FK_Subsidy_Records_Staff1]
GO
ALTER TABLE [dbo].[Wages_Records]  WITH CHECK ADD  CONSTRAINT [FK_Wages_Records_Staff] FOREIGN KEY([Staff_id])
REFERENCES [dbo].[Staff] ([Staff_id])
GO
ALTER TABLE [dbo].[Wages_Records] CHECK CONSTRAINT [FK_Wages_Records_Staff]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Bonus_Records"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Bonus"
            Begin Extent = 
               Top = 7
               Left = 257
               Bottom = 148
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Staff"
            Begin Extent = 
               Top = 7
               Left = 488
               Bottom = 170
               Right = 692
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Bonus_Rd_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Bonus_Rd_View'
GO
USE [master]
GO
ALTER DATABASE [Wagemanagement] SET  READ_WRITE 
GO
