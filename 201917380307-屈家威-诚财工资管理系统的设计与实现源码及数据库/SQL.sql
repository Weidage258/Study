USE [master]
GO
/****** Object:  Database [Wage]    Script Date: 2021/8/3 19:53:16 ******/
CREATE DATABASE [Wage]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Wage', FILENAME = N'E:\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Wage.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Wage_log', FILENAME = N'E:\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Wage_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Wage] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Wage].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Wage] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Wage] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Wage] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Wage] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Wage] SET ARITHABORT OFF 
GO
ALTER DATABASE [Wage] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Wage] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Wage] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Wage] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Wage] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Wage] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Wage] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Wage] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Wage] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Wage] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Wage] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Wage] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Wage] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Wage] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Wage] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Wage] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Wage] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Wage] SET RECOVERY FULL 
GO
ALTER DATABASE [Wage] SET  MULTI_USER 
GO
ALTER DATABASE [Wage] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Wage] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Wage] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Wage] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Wage] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Wage', N'ON'
GO
ALTER DATABASE [Wage] SET QUERY_STORE = OFF
GO
USE [Wage]
GO
/****** Object:  Table [dbo].[Bonus]    Script Date: 2021/8/3 19:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bonus](
	[Bonus_Id] [int] NOT NULL,
	[BonusName] [nvarchar](50) NOT NULL,
	[Bonus_pirce] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_Bonus] PRIMARY KEY CLUSTERED 
(
	[Bonus_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cwa]    Script Date: 2021/8/3 19:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cwa](
	[Cwa_id] [int] NOT NULL,
	[Cwa_Name] [nvarchar](50) NOT NULL,
	[Cwa_pirce] [decimal](18, 1) NOT NULL,
 CONSTRAINT [PK_Cwa] PRIMARY KEY CLUSTERED 
(
	[Cwa_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 2021/8/3 19:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[Department_Id] [int] NOT NULL,
	[Dt_Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[Department_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grade]    Script Date: 2021/8/3 19:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grade](
	[Grade_Id] [int] NOT NULL,
	[GradeName] [nvarchar](50) NOT NULL,
	[Grade_price] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Grade] PRIMARY KEY CLUSTERED 
(
	[Grade_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 2021/8/3 19:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[Staff_id] [int] NOT NULL,
	[Staff_Name] [nvarchar](50) NOT NULL,
	[Bonus_id] [int] NOT NULL,
	[Grade_Id] [int] NOT NULL,
	[Department_Id] [int] NOT NULL,
	[Staff_Sex] [int] NOT NULL,
	[Store_Id] [int] NOT NULL,
	[Cwa_id] [int] NULL,
 CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED 
(
	[Staff_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Store]    Script Date: 2021/8/3 19:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store](
	[Store_Id] [int] NOT NULL,
	[Store_Name] [nvarchar](50) NOT NULL,
	[Store_Address] [nvarchar](50) NOT NULL,
	[StoreLeader] [nvarchar](50) NOT NULL,
	[Store_state] [nvarchar](50) NOT NULL,
	[Store_Remarks] [nvarchar](50) NULL,
 CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED 
(
	[Store_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Bonus] ([Bonus_Id], [BonusName], [Bonus_pirce]) VALUES (1, N'年度最佳员工', CAST(2000 AS Decimal(18, 0)))
GO
INSERT [dbo].[Bonus] ([Bonus_Id], [BonusName], [Bonus_pirce]) VALUES (7, N'年度模范奖', CAST(3000 AS Decimal(18, 0)))
GO
INSERT [dbo].[Bonus] ([Bonus_Id], [BonusName], [Bonus_pirce]) VALUES (15, N'勤奋奖', CAST(500 AS Decimal(18, 0)))
GO
INSERT [dbo].[Bonus] ([Bonus_Id], [BonusName], [Bonus_pirce]) VALUES (16, N'年终奖', CAST(10000 AS Decimal(18, 0)))
GO
INSERT [dbo].[Bonus] ([Bonus_Id], [BonusName], [Bonus_pirce]) VALUES (17, N'最佳店长奖', CAST(300 AS Decimal(18, 0)))
GO
INSERT [dbo].[Cwa] ([Cwa_id], [Cwa_Name], [Cwa_pirce]) VALUES (1, N'迟到', CAST(1.0 AS Decimal(18, 1)))
GO
INSERT [dbo].[Cwa] ([Cwa_id], [Cwa_Name], [Cwa_pirce]) VALUES (2, N'早退', CAST(1.5 AS Decimal(18, 1)))
GO
INSERT [dbo].[Cwa] ([Cwa_id], [Cwa_Name], [Cwa_pirce]) VALUES (3, N'旷工', CAST(2.0 AS Decimal(18, 1)))
GO
INSERT [dbo].[Cwa] ([Cwa_id], [Cwa_Name], [Cwa_pirce]) VALUES (5, N'请假', CAST(1.0 AS Decimal(18, 1)))
GO
INSERT [dbo].[Department] ([Department_Id], [Dt_Name]) VALUES (1, N'门店部')
GO
INSERT [dbo].[Department] ([Department_Id], [Dt_Name]) VALUES (2, N'营销部')
GO
INSERT [dbo].[Department] ([Department_Id], [Dt_Name]) VALUES (3, N'产品策划部')
GO
INSERT [dbo].[Department] ([Department_Id], [Dt_Name]) VALUES (4, N'技术指导部')
GO
INSERT [dbo].[Department] ([Department_Id], [Dt_Name]) VALUES (5, N'人事部')
GO
INSERT [dbo].[Department] ([Department_Id], [Dt_Name]) VALUES (6, N'财务部')
GO
INSERT [dbo].[Grade] ([Grade_Id], [GradeName], [Grade_price]) VALUES (1, N'店长', CAST(7000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Grade] ([Grade_Id], [GradeName], [Grade_price]) VALUES (2, N'店员', CAST(3500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Grade] ([Grade_Id], [GradeName], [Grade_price]) VALUES (3, N'实习生', CAST(2500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Grade] ([Grade_Id], [GradeName], [Grade_price]) VALUES (4, N'部长', CAST(6510.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Grade] ([Grade_Id], [GradeName], [Grade_price]) VALUES (8, N'员工', CAST(3510.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Staff] ([Staff_id], [Staff_Name], [Bonus_id], [Grade_Id], [Department_Id], [Staff_Sex], [Store_Id], [Cwa_id]) VALUES (1, N'布莱克', 1, 1, 1, 1, 1, 1)
GO
INSERT [dbo].[Store] ([Store_Id], [Store_Name], [Store_Address], [StoreLeader], [Store_state], [Store_Remarks]) VALUES (1, N'财城', N'湖南岳阳', N'屈家威', N'营业', N'主店铺')
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Cwa] FOREIGN KEY([Cwa_id])
REFERENCES [dbo].[Cwa] ([Cwa_id])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_Staff_Cwa]
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
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Staff] FOREIGN KEY([Bonus_id])
REFERENCES [dbo].[Bonus] ([Bonus_Id])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_Staff_Staff]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Store] FOREIGN KEY([Store_Id])
REFERENCES [dbo].[Store] ([Store_Id])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_Staff_Store]
GO
USE [master]
GO
ALTER DATABASE [Wage] SET  READ_WRITE 
GO
