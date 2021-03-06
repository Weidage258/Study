USE [master]
GO
/****** Object:  Database [Movie ticketing]    Script Date: 2021/3/5 22:40:50 ******/
CREATE DATABASE [Movie ticketing]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Movie ticketing', FILENAME = N'D:\sql2019\sql2019\MSSQL15.MSSQLSERVER\MSSQL\DATA\Movie ticketing.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Movie ticketing_log', FILENAME = N'D:\sql2019\sql2019\MSSQL15.MSSQLSERVER\MSSQL\DATA\Movie ticketing_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Movie ticketing] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Movie ticketing].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Movie ticketing] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Movie ticketing] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Movie ticketing] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Movie ticketing] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Movie ticketing] SET ARITHABORT OFF 
GO
ALTER DATABASE [Movie ticketing] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Movie ticketing] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Movie ticketing] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Movie ticketing] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Movie ticketing] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Movie ticketing] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Movie ticketing] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Movie ticketing] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Movie ticketing] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Movie ticketing] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Movie ticketing] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Movie ticketing] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Movie ticketing] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Movie ticketing] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Movie ticketing] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Movie ticketing] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Movie ticketing] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Movie ticketing] SET RECOVERY FULL 
GO
ALTER DATABASE [Movie ticketing] SET  MULTI_USER 
GO
ALTER DATABASE [Movie ticketing] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Movie ticketing] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Movie ticketing] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Movie ticketing] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Movie ticketing] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Movie ticketing', N'ON'
GO
ALTER DATABASE [Movie ticketing] SET QUERY_STORE = OFF
GO
USE [Movie ticketing]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 2021/3/5 22:40:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[Contents] [nvarchar](200) NULL,
	[UserName] [nvarchar](11) NOT NULL,
	[CommentDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Erea]    Script Date: 2021/3/5 22:40:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Erea](
	[EreaID] [int] IDENTITY(1,1) NOT NULL,
	[EreaName] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Erea] PRIMARY KEY CLUSTERED 
(
	[EreaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Language]    Script Date: 2021/3/5 22:40:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Language](
	[LanguageID] [int] IDENTITY(1,1) NOT NULL,
	[LanguageName] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	[LanguageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movies]    Script Date: 2021/3/5 22:40:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movies](
	[MovieID] [int] IDENTITY(1,1) NOT NULL,
	[MovieName] [nvarchar](50) NOT NULL,
	[MoviePrice] [decimal](18, 2) NOT NULL,
	[MovieShowDate] [date] NOT NULL,
	[MovieDuration] [int] NOT NULL,
	[MovieImage] [nvarchar](50) NOT NULL,
	[EreaID] [int] NOT NULL,
	[CommentID] [int] NULL,
	[MovieTypeID] [int] NULL,
	[Score] [nvarchar](2) NULL,
	[BoxOffice] [int] NULL,
	[LanguageID] [int] NOT NULL,
 CONSTRAINT [PK_Movies] PRIMARY KEY CLUSTERED 
(
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovieTheater]    Script Date: 2021/3/5 22:40:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieTheater](
	[TheaterID] [int] IDENTITY(1,1) NOT NULL,
	[TheaterName] [nvarchar](20) NOT NULL,
	[Address] [nvarchar](100) NOT NULL,
	[MovieID] [int] NULL,
 CONSTRAINT [PK_MovieTheater] PRIMARY KEY CLUSTERED 
(
	[TheaterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovieTypes]    Script Date: 2021/3/5 22:40:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieTypes](
	[MovieTypeID] [int] IDENTITY(1,1) NOT NULL,
	[MovieTypeName] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_MovieTypes] PRIMARY KEY CLUSTERED 
(
	[MovieTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2021/3/5 22:40:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[MovieID] [int] NOT NULL,
	[UserName] [nvarchar](11) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Relation]    Script Date: 2021/3/5 22:40:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Relation](
	[RelationID] [int] IDENTITY(1,1) NOT NULL,
	[MovieTypeID] [int] NOT NULL,
	[MovieID] [int] NOT NULL,
 CONSTRAINT [PK_Relation] PRIMARY KEY CLUSTERED 
(
	[RelationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2021/3/5 22:40:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserName] [nvarchar](11) NOT NULL,
	[UserNickname] [nvarchar](20) NOT NULL,
	[UserPwd] [nvarchar](16) NOT NULL,
	[Birthday] [date] NULL,
	[Gender] [nvarchar](1) NOT NULL,
	[PersonalityStatement] [nvarchar](200) NULL,
	[UserAmount] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Users] ([UserName], [UserNickname], [UserPwd], [Birthday], [Gender], [PersonalityStatement], [UserAmount]) VALUES (N'1', N'1', N'1', CAST(N'2020-02-02' AS Date), N'男', NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([UserName], [UserNickname], [UserPwd], [Birthday], [Gender], [PersonalityStatement], [UserAmount]) VALUES (N'2', N'2', N'1', CAST(N'2020-02-02' AS Date), N'男', NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([UserName], [UserNickname], [UserPwd], [Birthday], [Gender], [PersonalityStatement], [UserAmount]) VALUES (N'3', N'3', N'1', CAST(N'2020-01-01' AS Date), N'男', NULL, CAST(0.00 AS Decimal(18, 2)))
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Language]    Script Date: 2021/3/5 22:40:50 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Language] ON [dbo].[Language]
(
	[LanguageName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Users]    Script Date: 2021/3/5 22:40:50 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Users] ON [dbo].[Users]
(
	[UserNickname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_Gender]  DEFAULT (N'男') FOR [Gender]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_UserAmount]  DEFAULT ((0)) FOR [UserAmount]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Users] FOREIGN KEY([UserName])
REFERENCES [dbo].[Users] ([UserName])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Users]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD  CONSTRAINT [FK_Movies_Comment] FOREIGN KEY([CommentID])
REFERENCES [dbo].[Comment] ([CommentID])
GO
ALTER TABLE [dbo].[Movies] CHECK CONSTRAINT [FK_Movies_Comment]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD  CONSTRAINT [FK_Movies_Erea] FOREIGN KEY([EreaID])
REFERENCES [dbo].[Erea] ([EreaID])
GO
ALTER TABLE [dbo].[Movies] CHECK CONSTRAINT [FK_Movies_Erea]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD  CONSTRAINT [FK_Movies_Language] FOREIGN KEY([LanguageID])
REFERENCES [dbo].[Language] ([LanguageID])
GO
ALTER TABLE [dbo].[Movies] CHECK CONSTRAINT [FK_Movies_Language]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD  CONSTRAINT [FK_Movies_MovieTypes] FOREIGN KEY([MovieTypeID])
REFERENCES [dbo].[MovieTypes] ([MovieTypeID])
GO
ALTER TABLE [dbo].[Movies] CHECK CONSTRAINT [FK_Movies_MovieTypes]
GO
ALTER TABLE [dbo].[MovieTheater]  WITH CHECK ADD  CONSTRAINT [FK_MovieTheater_Movies] FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[MovieTheater] CHECK CONSTRAINT [FK_MovieTheater_Movies]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Movies] FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Movies]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([UserName])
REFERENCES [dbo].[Users] ([UserName])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[Relation]  WITH CHECK ADD  CONSTRAINT [FK_Relation_Movies] FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[Relation] CHECK CONSTRAINT [FK_Relation_Movies]
GO
ALTER TABLE [dbo].[Relation]  WITH CHECK ADD  CONSTRAINT [FK_Relation_Relation] FOREIGN KEY([MovieTypeID])
REFERENCES [dbo].[MovieTypes] ([MovieTypeID])
GO
ALTER TABLE [dbo].[Relation] CHECK CONSTRAINT [FK_Relation_Relation]
GO
USE [master]
GO
ALTER DATABASE [Movie ticketing] SET  READ_WRITE 
GO
