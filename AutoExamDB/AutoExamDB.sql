USE [master]
GO
/****** Object:  Database [AutoExamDB]    Script Date: 2021/5/12 8:51:18 ******/
CREATE DATABASE [AutoExamDB]
GO
ALTER DATABASE [AutoExamDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AutoExamDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AutoExamDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AutoExamDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AutoExamDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AutoExamDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AutoExamDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [AutoExamDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AutoExamDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AutoExamDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AutoExamDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AutoExamDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AutoExamDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AutoExamDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AutoExamDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AutoExamDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AutoExamDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [AutoExamDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AutoExamDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AutoExamDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AutoExamDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AutoExamDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AutoExamDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AutoExamDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AutoExamDB] SET RECOVERY FULL 
GO
ALTER DATABASE [AutoExamDB] SET  MULTI_USER 
GO
ALTER DATABASE [AutoExamDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AutoExamDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AutoExamDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AutoExamDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AutoExamDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AutoExamDB] SET QUERY_STORE = OFF
GO
USE [AutoExamDB]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[AccountID] [int] IDENTITY(1,1) NOT NULL,
	[LoginName] [nvarchar](50) NOT NULL,
	[LoginPWD] [nvarchar](40) NOT NULL,
	[AccountType] [int] NOT NULL,
	[Remark] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Remark] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountRoles]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountRoles](
	[UserRolesID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserRolesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menus]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menus](
	[MenuID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Url] [nvarchar](50) NOT NULL,
	[Pid] [int] NOT NULL,
	[IsMenu] [bit] NOT NULL,
	[Remark] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleMenus]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleMenus](
	[RoleMenusID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NOT NULL,
	[MenuID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleMenusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AccountMenus]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[AccountMenus]
as
SELECT   t2.AccountID, t2.LoginName, t1.RoleID, t1.RoleName, t1.MenuID,t1.MenuPid, t1.MenuName, t1.MenuUrl
FROM      
(SELECT m.Pid as MenuPid , m.MenuID, m.Name AS MenuName, m.Url AS MenuUrl, r.Name AS RoleName, r.RoleID
                 FROM      dbo.RoleMenus AS rm INNER JOIN
                                 dbo.Menus AS m ON rm.MenuID = m.MenuID INNER JOIN
                                 dbo.Roles AS r ON rm.RoleID = r.RoleID) AS t1 INNER JOIN
                    (SELECT   a.AccountID, a.LoginName, r.Name AS RoleName, r.RoleID
                     FROM      dbo.AccountRoles AS ar INNER JOIN
                                     dbo.Account AS a ON ar.AccountID = a.AccountID INNER JOIN
                                     dbo.Roles AS r ON ar.RoleID = r.RoleID) AS t2 ON t1.RoleID = t2.RoleID
GO
/****** Object:  Table [dbo].[ClassInfo]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClassInfo](
	[ClassInfoID] [int] IDENTITY(1,1) NOT NULL,
	[Class] [nvarchar](30) NOT NULL,
	[Grade] [nvarchar](30) NOT NULL,
	[Major] [nvarchar](30) NOT NULL,
	[Remark] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ClassInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseInfo]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseInfo](
	[CourseID] [int] IDENTITY(1,1) NOT NULL,
	[CourseName] [nvarchar](50) NOT NULL,
	[CourseChapter] [nvarchar](50) NOT NULL,
	[CourseCategory] [nvarchar](50) NULL,
	[Remark] [nvarchar](50) NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EduType]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EduType](
	[EduTypeID] [int] IDENTITY(1,1) NOT NULL,
	[EduTypeName] [nvarchar](50) NULL,
	[Remark] [nvarchar](50) NULL,
 CONSTRAINT [PK_EduType] PRIMARY KEY CLUSTERED 
(
	[EduTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[ExamID] [int] IDENTITY(1,1) NOT NULL,
	[PaperID] [int] NOT NULL,
	[StuInfoID] [int] NOT NULL,
	[TeaInfoID] [int] NULL,
	[ExamScore] [int] NULL,
	[ExamTime] [datetime] NULL,
	[SubmitTime] [datetime] NULL,
	[BatchTime] [datetime] NULL,
	[ExamState] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ExamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExamInfo]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExamInfo](
	[ExamInfoID] [int] IDENTITY(1,1) NOT NULL,
	[ExamID] [int] NOT NULL,
	[TopicID] [int] NOT NULL,
	[StuAnswer] [nvarchar](max) NULL,
	[IsResult] [bit] NULL,
 CONSTRAINT [PK__ExamInfo__1F23ED1D4D519E24] PRIMARY KEY CLUSTERED 
(
	[ExamInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InClassRecord]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InClassRecord](
	[InClassRecordID] [int] IDENTITY(1,1) NOT NULL,
	[TopicID] [int] NULL,
	[StuNo] [nvarchar](20) NULL,
	[Answer] [nvarchar](max) NULL,
	[AnswerTime] [datetime] NULL,
	[IsResult] [bit] NULL,
	[State] [int] NULL,
	[RecordTime] [datetime] NOT NULL,
 CONSTRAINT [PK_InClassRecord] PRIMARY KEY CLUSTERED 
(
	[InClassRecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginRecord]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginRecord](
	[LoginRecordID] [int] IDENTITY(1,1) NOT NULL,
	[LoginTime] [datetime] NOT NULL,
	[AccountID] [int] NULL,
	[LoginHASH] [nvarchar](20) NULL,
	[Remark] [nvarchar](50) NULL,
 CONSTRAINT [PK_LoginRecord] PRIMARY KEY CLUSTERED 
(
	[LoginRecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Paper]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paper](
	[PaperID] [int] IDENTITY(1,1) NOT NULL,
	[PaperName] [nvarchar](20) NOT NULL,
	[PaperExplain] [nvarchar](100) NOT NULL,
	[PaperTime] [int] NOT NULL,
	[PaperScore] [int] NOT NULL,
	[PaperType] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[PaperID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaperInfo]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaperInfo](
	[PaperInfoID] [int] IDENTITY(1,1) NOT NULL,
	[PaperID] [int] NOT NULL,
	[TopicID] [int] NOT NULL,
	[TopicScore] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PaperInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StuInfo]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StuInfo](
	[StuInfoID] [int] IDENTITY(1,1) NOT NULL,
	[StuNo] [nvarchar](20) NOT NULL,
	[StuName] [nvarchar](30) NOT NULL,
	[StuDuty] [nvarchar](30) NOT NULL,
	[StuSex] [bit] NOT NULL,
	[StuPhoto] [nvarchar](100) NOT NULL,
	[StuAdd] [nvarchar](50) NOT NULL,
	[Remark] [nvarchar](50) NULL,
	[ClassInfoID] [int] NOT NULL,
	[AccountID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StuInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeaInfo]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeaInfo](
	[TeaInfoID] [int] IDENTITY(1,1) NOT NULL,
	[TeaNo] [nvarchar](20) NOT NULL,
	[TeaName] [nvarchar](30) NOT NULL,
	[TeaDuty] [nvarchar](30) NOT NULL,
	[TeaSex] [bit] NOT NULL,
	[TeaPhoto] [nvarchar](100) NOT NULL,
	[TeaAdd] [nvarchar](50) NOT NULL,
	[Remark] [nvarchar](50) NULL,
	[ClassInfoID] [int] NULL,
	[AccountID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TeaInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Topic]    Script Date: 2021/5/12 8:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Topic](
	[TopicID] [int] IDENTITY(1,1) NOT NULL,
	[TopicExplain] [nvarchar](max) NOT NULL,
	[TopicType] [int] NOT NULL,
	[TopicA] [nvarchar](max) NULL,
	[TopicB] [nvarchar](100) NULL,
	[TopicC] [nvarchar](100) NULL,
	[TopicD] [nvarchar](100) NULL,
	[TopicSort] [int] NOT NULL,
	[TopicAnswer] [nvarchar](max) NULL,
	[CourseID] [int] NULL,
	[EduTypeID] [int] NULL,
 CONSTRAINT [PK__Topic__022E0F7D6D355914] PRIMARY KEY CLUSTERED 
(
	[TopicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (1, N'admin', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 2, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (2, N'root', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 2, NULL)
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (8, N'student', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (9, N'201817380702', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (10, N'201817380703', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (11, N'201817380704', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (12, N'201817380705', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (13, N'201817380706', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (14, N'201817380707', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (15, N'201817380708', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (16, N'201817380709', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (17, N'201817380710', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (18, N'201817380711', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (19, N'201817380712', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (20, N'201817380713', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (21, N'201817380714', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (22, N'201817380715', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (23, N'201817380716', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (24, N'201817380717', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (25, N'201817380718', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (26, N'201817380719', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (27, N'201817380720', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (28, N'201817380721', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (29, N'201817380722', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (30, N'201817380723', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (31, N'201817380724', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (32, N'201817380725', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (33, N'201817380726', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (34, N'201817380727', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (35, N'201817380728', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (36, N'201817380729', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (37, N'201817380730', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (38, N'201817380731', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (39, N'201817380732', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (40, N'201817380733', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (41, N'201817380734', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (42, N'201817380735', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (43, N'201817380736', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (44, N'201817380737', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (45, N'201817380738', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (46, N'201817380739', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (47, N'201817380740', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (48, N'201817380701', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (49, N'201817380702', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (50, N'201817380703', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (51, N'201817380704', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (52, N'201817380705', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (53, N'201817380706', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (54, N'201817380707', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (55, N'201817380708', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (56, N'201817380709', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (57, N'201817380710', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (58, N'201817380711', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (59, N'201817380712', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (60, N'201817380713', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (61, N'201817380714', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (62, N'201817380715', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (63, N'201817380716', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (64, N'201817380717', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (65, N'201817380718', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (66, N'201817380719', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (67, N'201817380720', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (68, N'201817380721', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (69, N'201817380722', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (70, N'201817380723', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (71, N'201817380724', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (72, N'201817380725', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (73, N'201817380726', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (74, N'201817380727', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (75, N'201817380728', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (76, N'201817380729', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (77, N'201817380730', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (78, N'201817380731', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (79, N'201817380732', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (80, N'201817380733', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (81, N'201817380734', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (82, N'201817380735', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (83, N'201817380736', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (84, N'201817380737', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (85, N'201817380738', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (86, N'201817380739', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (87, N'201817380740', N'6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 0, N'111')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (88, N'201917380101', N'8aefb06c426e07a0a671a1e2488b4858d694a730', 0, N'')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (89, N'201817380741', N'8aefb06c426e07a0a671a1e2488b4858d694a730', 0, N'')
INSERT [dbo].[Account] ([AccountID], [LoginName], [LoginPWD], [AccountType], [Remark]) VALUES (90, N'201817380742', N'8aefb06c426e07a0a671a1e2488b4858d694a730', 0, N'')
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[AccountRoles] ON 

INSERT [dbo].[AccountRoles] ([UserRolesID], [AccountID], [RoleID]) VALUES (1024, 89, 3)
INSERT [dbo].[AccountRoles] ([UserRolesID], [AccountID], [RoleID]) VALUES (1025, 90, 3)
INSERT [dbo].[AccountRoles] ([UserRolesID], [AccountID], [RoleID]) VALUES (1028, 9, 3)
SET IDENTITY_INSERT [dbo].[AccountRoles] OFF
GO
SET IDENTITY_INSERT [dbo].[ClassInfo] ON 

INSERT [dbo].[ClassInfo] ([ClassInfoID], [Class], [Grade], [Major], [Remark]) VALUES (6, N'2018173807', N'2018', N'高软C#方向', NULL)
INSERT [dbo].[ClassInfo] ([ClassInfoID], [Class], [Grade], [Major], [Remark]) VALUES (1002, N'2018173808', N'2018', N'高软C#方向', NULL)
INSERT [dbo].[ClassInfo] ([ClassInfoID], [Class], [Grade], [Major], [Remark]) VALUES (1003, N'2018173807', N'2018', N'高软C#方向', NULL)
SET IDENTITY_INSERT [dbo].[ClassInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[CourseInfo] ON 

INSERT [dbo].[CourseInfo] ([CourseID], [CourseName], [CourseChapter], [CourseCategory], [Remark]) VALUES (1, N'HTML静态网页设计', N'第一章', N'紫牛系列', NULL)
INSERT [dbo].[CourseInfo] ([CourseID], [CourseName], [CourseChapter], [CourseCategory], [Remark]) VALUES (2, N'HTML静态网页设计', N'第二章', N'紫牛系列', NULL)
SET IDENTITY_INSERT [dbo].[CourseInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[EduType] ON 

INSERT [dbo].[EduType] ([EduTypeID], [EduTypeName], [Remark]) VALUES (1, N'课前预习', NULL)
INSERT [dbo].[EduType] ([EduTypeID], [EduTypeName], [Remark]) VALUES (2, N'随堂提问', NULL)
INSERT [dbo].[EduType] ([EduTypeID], [EduTypeName], [Remark]) VALUES (3, N'课程知识点', NULL)
SET IDENTITY_INSERT [dbo].[EduType] OFF
GO
SET IDENTITY_INSERT [dbo].[InClassRecord] ON 

INSERT [dbo].[InClassRecord] ([InClassRecordID], [TopicID], [StuNo], [Answer], [AnswerTime], [IsResult], [State], [RecordTime]) VALUES (1, 1, N'201817380702', NULL, NULL, NULL, -1, CAST(N'2020-10-23T14:56:30.687' AS DateTime))
INSERT [dbo].[InClassRecord] ([InClassRecordID], [TopicID], [StuNo], [Answer], [AnswerTime], [IsResult], [State], [RecordTime]) VALUES (2, 7, N'201817380711', NULL, NULL, NULL, -1, CAST(N'2020-10-10T16:34:55.367' AS DateTime))
INSERT [dbo].[InClassRecord] ([InClassRecordID], [TopicID], [StuNo], [Answer], [AnswerTime], [IsResult], [State], [RecordTime]) VALUES (3, 1, NULL, NULL, NULL, 1, 100, CAST(N'2020-12-30T11:32:37.530' AS DateTime))
INSERT [dbo].[InClassRecord] ([InClassRecordID], [TopicID], [StuNo], [Answer], [AnswerTime], [IsResult], [State], [RecordTime]) VALUES (4, 1, N'201817380710', NULL, NULL, 0, 0, CAST(N'2020-12-30T11:33:06.823' AS DateTime))
INSERT [dbo].[InClassRecord] ([InClassRecordID], [TopicID], [StuNo], [Answer], [AnswerTime], [IsResult], [State], [RecordTime]) VALUES (5, 1, N'201817380719', NULL, NULL, 1, 100, CAST(N'2020-12-30T11:33:58.620' AS DateTime))
INSERT [dbo].[InClassRecord] ([InClassRecordID], [TopicID], [StuNo], [Answer], [AnswerTime], [IsResult], [State], [RecordTime]) VALUES (6, 1, N'201817380709', NULL, NULL, NULL, -1, CAST(N'2020-12-30T11:34:11.943' AS DateTime))
SET IDENTITY_INSERT [dbo].[InClassRecord] OFF
GO
SET IDENTITY_INSERT [dbo].[LoginRecord] ON 

INSERT [dbo].[LoginRecord] ([LoginRecordID], [LoginTime], [AccountID], [LoginHASH], [Remark]) VALUES (3, CAST(N'2020-10-04T14:44:59.150' AS DateTime), 1, N'2b75afc5', N'')
INSERT [dbo].[LoginRecord] ([LoginRecordID], [LoginTime], [AccountID], [LoginHASH], [Remark]) VALUES (4, CAST(N'2020-10-04T14:45:32.213' AS DateTime), 1, N'2b75afc5', N'')
INSERT [dbo].[LoginRecord] ([LoginRecordID], [LoginTime], [AccountID], [LoginHASH], [Remark]) VALUES (5, CAST(N'2020-10-04T17:04:44.447' AS DateTime), 90, N'a0519533', N'')
INSERT [dbo].[LoginRecord] ([LoginRecordID], [LoginTime], [AccountID], [LoginHASH], [Remark]) VALUES (6, CAST(N'2020-10-05T07:55:12.863' AS DateTime), 1, N'2b75afc5', N'')
INSERT [dbo].[LoginRecord] ([LoginRecordID], [LoginTime], [AccountID], [LoginHASH], [Remark]) VALUES (7, CAST(N'2020-10-05T07:55:31.353' AS DateTime), 90, N'1026c1f5', N'')
INSERT [dbo].[LoginRecord] ([LoginRecordID], [LoginTime], [AccountID], [LoginHASH], [Remark]) VALUES (8, CAST(N'2020-10-05T07:59:18.340' AS DateTime), 89, N'1026c1f5', N'')
INSERT [dbo].[LoginRecord] ([LoginRecordID], [LoginTime], [AccountID], [LoginHASH], [Remark]) VALUES (9, CAST(N'2020-10-10T22:53:10.663' AS DateTime), 9, N'1026c1f5', N'')
INSERT [dbo].[LoginRecord] ([LoginRecordID], [LoginTime], [AccountID], [LoginHASH], [Remark]) VALUES (10, CAST(N'2020-10-11T09:30:47.530' AS DateTime), 9, N'1026c1f5', N'')
SET IDENTITY_INSERT [dbo].[LoginRecord] OFF
GO
SET IDENTITY_INSERT [dbo].[Menus] ON 

INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (4, N'网站首页', N'/Home/Index', 0, 1, N'一级菜单')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (5, N'课堂管理', N'/Home/Index', 0, 1, N'一级菜单')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (6, N'系统管理', N'/System/Index', 0, 1, N'一级菜单')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (7, N'菜单管理', N'/Menu/Index', 6, 1, N'二级菜单')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (8, N'新增菜单', N'/Menu/Add', 7, 0, N'操作')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (9, N'删除菜单', N'/Menu/Dele', 7, 0, N'操作')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (10, N'修改菜单', N'/Menu/Edit', 7, 0, N'操作')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (11, N'角色管理', N'/Role/Index', 6, 1, N'二级菜单')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (12, N'新增角色', N'/Role/Add', 11, 0, N'操作')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (13, N'删除角色', N'/Role/Dele', 11, 0, N'操作')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (14, N'修改角色', N'/Role/Edit', 11, 0, N'操作')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (15, N'人员管理', N'/Person/Index', 0, 1, N'一级菜单')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (16, N'教务管理', N'/Edu/Index', 0, 1, N' 一级菜单')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (17, N'个人中心', N'/MyCenter/Index', 0, 1, N'一级菜单')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (18, N'首页', N'/Home/Index', 4, 1, N'二级菜单')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (19, N'关于我们', N'/Home/About', 0, 1, N'一级菜单')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (20, N'授权管理', N'/Accredit/Index', 6, 1, N'二级菜单')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (21, N'账户-角色授权', N'/AccountRole/Index', 20, 0, N'操作')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (22, N'角色-菜单授权', N'/RoleMenu/Index', 20, 0, N'操作')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (23, N'班级管理', N'/ClassInfo/Index', 15, 1, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (24, N'新增班级', N'/ClassInfo/Add', 23, 0, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (25, N'修改班级', N'/ClassInfo/Edit', 23, 0, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (26, N'教师管理', N'/TeaInfo/Index', 15, 1, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (27, N'学生管理', N'/StuInfoes/Index', 15, 1, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (30, N'新增教师', N'/TeaInfo/Add', 26, 0, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (31, N'修改教师', N'/TeaInfo/Edit', 26, 0, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (32, N'删除教师', N'/TeaInfo/Dele', 26, 0, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (33, N'新增学生', N'/StuInfo/Add', 27, 0, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (34, N'修改学生', N'/StuInfo/Edit', 27, 0, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (35, N'删除学生', N'/StuInfo/Dele', 27, 0, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (36, N'题库管理', N'/Topics/Index', 16, 1, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (37, N'试卷管理', N'/Paper/Index', 16, 1, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (38, N'审卷', N'/Check/Index', 16, 1, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (39, N'新增题库', N'/Topics/Create', 36, 0, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (40, N'修改题库', N'/Topics/Edit', 36, 0, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (41, N'删除题库', N'/Topics/Delete', 36, 0, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (42, N'新增试卷', N'/Paper/Add', 37, 0, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (43, N'删除试卷', N'/Paper/Dele', 37, 0, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (44, N'批改试卷', N'/Check/Correct', 38, 0, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (45, N'我的考试', N'/Exam/Index', 17, 1, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (46, N'参加考试', N'/Exam/Proceed', 45, 0, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (47, N'查看结果', N'/Exam/Info', 45, 0, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (48, N'账户权限查询', N'/Accredit/Find', 20, 0, NULL)
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (49, N'课前预习', N'/InClass/Preview', 5, 1, N'二级菜单')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (50, N'课堂提问', N'/InClass/Question', 5, 1, N'二级菜单')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (51, N'课堂练习', N'/InClass/Exercise', 5, 1, N'二级菜单')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (52, N'课程管理', N'/CourseInfoes/Index', 16, 1, N'二级菜单')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (53, N'题库类型管理', N'/EduTypes/Index', 16, 1, N'二级菜单')
INSERT [dbo].[Menus] ([MenuID], [Name], [Url], [Pid], [IsMenu], [Remark]) VALUES (54, N'我的课堂', N'/InClass/MyLearn', 17, 1, N'二级菜单')
SET IDENTITY_INSERT [dbo].[Menus] OFF
GO
SET IDENTITY_INSERT [dbo].[RoleMenus] ON 

INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1342, 4, 16)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1343, 4, 36)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1344, 4, 39)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1345, 4, 40)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1346, 4, 41)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1347, 4, 37)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1348, 4, 42)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1349, 4, 43)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1350, 4, 38)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1351, 4, 44)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1352, 4, 17)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1353, 4, 45)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1354, 4, 46)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1355, 4, 47)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1356, 4, 18)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1357, 4, 19)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1644, 2, 4)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1645, 2, 18)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1646, 2, 5)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1647, 2, 49)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1648, 2, 50)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1649, 2, 51)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1650, 2, 16)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1651, 2, 36)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1652, 2, 39)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1653, 2, 40)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1654, 2, 41)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1655, 2, 37)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1656, 2, 42)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1657, 2, 43)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1658, 2, 38)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1659, 2, 44)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1660, 2, 17)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1661, 2, 45)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1662, 2, 46)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1663, 2, 47)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1664, 2, 19)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1707, 1, 4)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1708, 1, 18)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1709, 1, 5)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1710, 1, 49)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1711, 1, 50)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1712, 1, 51)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1713, 1, 6)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1714, 1, 7)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1715, 1, 8)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1716, 1, 9)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1717, 1, 10)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1718, 1, 11)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1719, 1, 12)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1720, 1, 13)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1721, 1, 14)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1722, 1, 20)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1723, 1, 21)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1724, 1, 22)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1725, 1, 48)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1726, 1, 15)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1727, 1, 23)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1728, 1, 24)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1729, 1, 25)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1730, 1, 26)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1731, 1, 30)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1732, 1, 31)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1733, 1, 32)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1734, 1, 27)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1735, 1, 33)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1736, 1, 34)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1737, 1, 35)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1738, 1, 16)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1739, 1, 36)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1740, 1, 39)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1741, 1, 40)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1742, 1, 41)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1743, 1, 37)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1744, 1, 42)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1745, 1, 43)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1746, 1, 38)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1747, 1, 44)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1748, 1, 17)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1749, 1, 45)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1750, 1, 46)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1751, 1, 47)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1752, 1, 19)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1761, 3, 4)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1762, 3, 18)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1763, 3, 16)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1764, 3, 36)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1765, 3, 39)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1766, 3, 40)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1767, 3, 41)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1768, 3, 37)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1769, 3, 42)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1770, 3, 43)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1771, 3, 38)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1772, 3, 44)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1773, 3, 52)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1774, 3, 53)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1775, 3, 17)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1776, 3, 45)
GO
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1777, 3, 46)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1778, 3, 47)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1779, 3, 54)
INSERT [dbo].[RoleMenus] ([RoleMenusID], [RoleID], [MenuID]) VALUES (1780, 3, 19)
SET IDENTITY_INSERT [dbo].[RoleMenus] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [Name], [Remark]) VALUES (1, N'管理员', N'系统设置')
INSERT [dbo].[Roles] ([RoleID], [Name], [Remark]) VALUES (2, N'老师', N'学生管理；试卷；出题；阅卷')
INSERT [dbo].[Roles] ([RoleID], [Name], [Remark]) VALUES (3, N'学生', N'可进行考试')
INSERT [dbo].[Roles] ([RoleID], [Name], [Remark]) VALUES (4, N'教务', N'安排考试')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[StuInfo] ON 

INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (1, N'201817380701', N'潘寻文', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 8)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (120, N'201817380702', N'徐夏春', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 9)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (121, N'201817380703', N'苏哲洁', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 10)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (122, N'201817380704', N'王梦旋', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 11)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (123, N'201817380705', N'余儿濮', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 12)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (124, N'201817380706', N'曾旋柔', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 13)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (125, N'201817380707', N'马夏晴', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 14)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (126, N'201817380708', N'徐枫恨', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 15)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (127, N'201817380709', N'韦渊山', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 16)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (128, N'201817380710', N'任修冬', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 17)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (129, N'201817380711', N'魏寒孤', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 18)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (130, N'201817380712', N'杨浦旋', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 19)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (131, N'201817380713', N'廖沛智', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 20)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (132, N'201817380714', N'钟修兰', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 21)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (133, N'201817380715', N'金晗晴', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 22)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (134, N'201817380716', N'姜弘彭', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 23)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (135, N'201817380717', N'姜恨开', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 24)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (136, N'201817380718', N'程修浦', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 25)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (137, N'201817380719', N'夏元义', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 26)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (138, N'201817380720', N'余如海', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 27)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (139, N'201817380721', N'蔡书彬', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 28)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (140, N'201817380722', N'田沛季', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 29)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (141, N'201817380723', N'丁俊俊', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 30)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (142, N'201817380724', N'崔润俊', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 31)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (143, N'201817380725', N'孙忆坚', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 32)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (144, N'201817380726', N'谭同慕', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 33)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (145, N'201817380727', N'程冰槐', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 34)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (146, N'201817380728', N'周易楷', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 35)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (147, N'201817380729', N'萧瑜兰', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 36)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (148, N'201817380730', N'蔡柔灿', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 37)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (149, N'201817380731', N'王和博', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 38)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (150, N'201817380732', N'马奇炎', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 39)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (151, N'201817380733', N'金旋涛', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 40)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (152, N'201817380734', N'程珊宸', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 41)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (153, N'201817380735', N'马溥开', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 42)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (154, N'201817380736', N'赵修俊', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 43)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (155, N'201817380737', N'周义曼', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 44)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (156, N'201817380738', N'苏涵彬', N'学生', 0, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 45)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (157, N'201817380739', N'廖平琪', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 46)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (158, N'201817380740', N'王理丹', N'学生', 1, N'/imgs/photo.jpg', N'湖南长沙', N'学生', 6, 47)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (159, N'201917380101', N'张三', N'学生', 1, N'/imgs/2019173801/201917380101.jpg', N'湖南长沙', NULL, 6, 88)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (160, N'201817380741', N'张三', N'学生', 0, N'/imgs/2018173807/201817380741.jpg', N'湖南长沙', NULL, 6, 89)
INSERT [dbo].[StuInfo] ([StuInfoID], [StuNo], [StuName], [StuDuty], [StuSex], [StuPhoto], [StuAdd], [Remark], [ClassInfoID], [AccountID]) VALUES (161, N'201817380742', N'李四', N'学生', 0, N'/imgs/2018173807/201817380742.jpg', N'湖南长沙', NULL, 6, 90)
SET IDENTITY_INSERT [dbo].[StuInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[Topic] ON 

INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [CourseID], [EduTypeID]) VALUES (1, N'测试1', 0, N'描述A', N'描述B', N'描述C', N'描述D', 10, N'D', 1, 1)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [CourseID], [EduTypeID]) VALUES (2, N'单选题', 0, N'描述A', N'描述B', N'描述C', N'描述D', 10, N'A', 2, 1)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [CourseID], [EduTypeID]) VALUES (3, N'多选题', 1, N'描述A', N'描述B', N'描述C', N'描述D', 10, N'A', 2, 1)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [CourseID], [EduTypeID]) VALUES (4, N'判断题', 2, N'描述A', N'描述B', N'描述C', N'描述D', 10, N'A', 2, 1)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [CourseID], [EduTypeID]) VALUES (5, N'填空题', 3, N'描述A', N'描述B', N'描述C', N'描述D', 10, N'A', 2, 1)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [CourseID], [EduTypeID]) VALUES (6, N'问答题', 4, N'描述A', N'描述B', N'描述C', N'描述D', 10, N'A', 2, 1)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [CourseID], [EduTypeID]) VALUES (7, N'长标题长标题长标题长标题长标题长标题长标题长长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题长标题标题', 1, N'描述A', N'描述B', N'描述C', N'描述D', 10, N'A', 2, 1)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [CourseID], [EduTypeID]) VALUES (8, N'测试2', 1, N'描述A', N'描述B', N'描述C', N'描述D', 10, N'A', 2, 1)
SET IDENTITY_INSERT [dbo].[Topic] OFF
GO
/****** Object:  Index [UQ__StuInfo__349DA587F352368F]    Script Date: 2021/5/12 8:51:20 ******/
ALTER TABLE [dbo].[StuInfo] ADD UNIQUE NONCLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__StuInfo__6CDFC020A0431713]    Script Date: 2021/5/12 8:51:20 ******/
ALTER TABLE [dbo].[StuInfo] ADD UNIQUE NONCLUSTERED 
(
	[StuNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__TeaInfo__349DA587C3AAB089]    Script Date: 2021/5/12 8:51:20 ******/
ALTER TABLE [dbo].[TeaInfo] ADD UNIQUE NONCLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__TeaInfo__571EEB0BCCFDDA1D]    Script Date: 2021/5/12 8:51:20 ******/
ALTER TABLE [dbo].[TeaInfo] ADD UNIQUE NONCLUSTERED 
(
	[TeaNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AccountRoles]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[AccountRoles]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD FOREIGN KEY([PaperID])
REFERENCES [dbo].[Paper] ([PaperID])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD FOREIGN KEY([StuInfoID])
REFERENCES [dbo].[StuInfo] ([StuInfoID])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD FOREIGN KEY([TeaInfoID])
REFERENCES [dbo].[TeaInfo] ([TeaInfoID])
GO
ALTER TABLE [dbo].[ExamInfo]  WITH CHECK ADD  CONSTRAINT [FK__ExamInfo__ExamID__48CFD27E] FOREIGN KEY([ExamID])
REFERENCES [dbo].[Exam] ([ExamID])
GO
ALTER TABLE [dbo].[ExamInfo] CHECK CONSTRAINT [FK__ExamInfo__ExamID__48CFD27E]
GO
ALTER TABLE [dbo].[ExamInfo]  WITH CHECK ADD  CONSTRAINT [FK__ExamInfo__TopicI__49C3F6B7] FOREIGN KEY([TopicID])
REFERENCES [dbo].[Topic] ([TopicID])
GO
ALTER TABLE [dbo].[ExamInfo] CHECK CONSTRAINT [FK__ExamInfo__TopicI__49C3F6B7]
GO
ALTER TABLE [dbo].[InClassRecord]  WITH CHECK ADD  CONSTRAINT [FK_InClassRecord_StuInfo1] FOREIGN KEY([StuNo])
REFERENCES [dbo].[StuInfo] ([StuNo])
GO
ALTER TABLE [dbo].[InClassRecord] CHECK CONSTRAINT [FK_InClassRecord_StuInfo1]
GO
ALTER TABLE [dbo].[InClassRecord]  WITH CHECK ADD  CONSTRAINT [FK_InClassRecord_Topic] FOREIGN KEY([TopicID])
REFERENCES [dbo].[Topic] ([TopicID])
GO
ALTER TABLE [dbo].[InClassRecord] CHECK CONSTRAINT [FK_InClassRecord_Topic]
GO
ALTER TABLE [dbo].[LoginRecord]  WITH CHECK ADD  CONSTRAINT [FK_LoginRecord_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[LoginRecord] CHECK CONSTRAINT [FK_LoginRecord_Account]
GO
ALTER TABLE [dbo].[PaperInfo]  WITH CHECK ADD FOREIGN KEY([PaperID])
REFERENCES [dbo].[Paper] ([PaperID])
GO
ALTER TABLE [dbo].[PaperInfo]  WITH CHECK ADD  CONSTRAINT [FK__PaperInfo__Topic__4CA06362] FOREIGN KEY([TopicID])
REFERENCES [dbo].[Topic] ([TopicID])
GO
ALTER TABLE [dbo].[PaperInfo] CHECK CONSTRAINT [FK__PaperInfo__Topic__4CA06362]
GO
ALTER TABLE [dbo].[RoleMenus]  WITH CHECK ADD FOREIGN KEY([MenuID])
REFERENCES [dbo].[Menus] ([MenuID])
GO
ALTER TABLE [dbo].[RoleMenus]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[StuInfo]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[StuInfo]  WITH CHECK ADD FOREIGN KEY([ClassInfoID])
REFERENCES [dbo].[ClassInfo] ([ClassInfoID])
GO
ALTER TABLE [dbo].[TeaInfo]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[TeaInfo]  WITH CHECK ADD FOREIGN KEY([ClassInfoID])
REFERENCES [dbo].[ClassInfo] ([ClassInfoID])
GO
ALTER TABLE [dbo].[Topic]  WITH CHECK ADD  CONSTRAINT [FK_Topic_Course] FOREIGN KEY([CourseID])
REFERENCES [dbo].[CourseInfo] ([CourseID])
GO
ALTER TABLE [dbo].[Topic] CHECK CONSTRAINT [FK_Topic_Course]
GO
ALTER TABLE [dbo].[Topic]  WITH CHECK ADD  CONSTRAINT [FK_Topic_EduType] FOREIGN KEY([EduTypeID])
REFERENCES [dbo].[EduType] ([EduTypeID])
GO
ALTER TABLE [dbo].[Topic] CHECK CONSTRAINT [FK_Topic_EduType]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD CHECK  (([AccountType]=(2) OR [AccountType]=(1) OR [AccountType]=(0)))
GO
USE [master]
GO
ALTER DATABASE [AutoExamDB] SET  READ_WRITE 
GO
