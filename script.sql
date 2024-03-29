USE [master]
GO
/****** Object:  Database [MotoParts]    Script Date: 11/5/2019 12:40:05 PM ******/
CREATE DATABASE [MotoParts]
 CONTAINMENT = NONE
 ON  PRIMARY 
/* Edit the FILENAME in both paths below to match where you had installed Microsoft SQL Server. Your 'MSSQL14. SQLEXPRESS02' folder could be a different number */
( NAME = N'MotoParts', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS02\MSSQL\DATA\MotoParts.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MotoParts_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS02\MSSQL\DATA\MotoParts_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [MotoParts] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MotoParts].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MotoParts] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MotoParts] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MotoParts] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MotoParts] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MotoParts] SET ARITHABORT OFF 
GO
ALTER DATABASE [MotoParts] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MotoParts] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MotoParts] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MotoParts] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MotoParts] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MotoParts] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MotoParts] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MotoParts] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MotoParts] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MotoParts] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MotoParts] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MotoParts] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MotoParts] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MotoParts] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MotoParts] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MotoParts] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MotoParts] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MotoParts] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MotoParts] SET  MULTI_USER 
GO
ALTER DATABASE [MotoParts] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MotoParts] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MotoParts] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MotoParts] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MotoParts] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MotoParts] SET QUERY_STORE = OFF
GO
USE [MotoParts]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](100) NULL,
	[RoleDesrciption] [varchar](100) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(100,1) NOT NULL,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[UserName] [varchar](100) NULL,
	[UserPassword] [varchar](100) NULL,
	[Salt] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
	[RoleIDFK] [int] NULL,
	[SavedDirtbikeIDFK] [int] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_UserAndRole]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_UserAndRole] AS
SELECT Users.Username, Users.UserPassword, Roles.RoleName
FROM Users
INNER JOIN Roles ON Roles.RoleID=Users.RoleIDFK;
GO
/****** Object:  Table [dbo].[Brands]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brands](
	[BrandID] [int] IDENTITY(1,1) NOT NULL,
	[BrandName] [varchar](100) NULL,
 CONSTRAINT [PK_Brands] PRIMARY KEY CLUSTERED 
(
	[BrandID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[UserIDFK] [int] NULL,
	[PartIDFK] [int] NULL,
	[PartPrice] [decimal](18, 2) NULL,
	[PartName] [varchar](50) NULL,
	[PartBrand] [varchar](50) NULL,
	[Picture] [varchar](500) NULL,
	[Quantity] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DirtBikes]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirtBikes](
	[DirtBikeID] [int] IDENTITY(1,1) NOT NULL,
	[Make] [varchar](100) NULL,
	[MakeYear] [int] NULL,
	[Model] [varchar](100) NULL,
 CONSTRAINT [PK_DirtBikes] PRIMARY KEY CLUSTERED 
(
	[DirtBikeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Errors]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Errors](
	[ErrorID] [int] IDENTITY(1,1) NOT NULL,
	[ErrorDate] [date] NULL,
	[StackTrace] [varchar](1000) NULL,
	[ErrorMessage] [varchar](1000) NULL,
 CONSTRAINT [PK_Errors] PRIMARY KEY CLUSTERED 
(
	[ErrorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PartCategories]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartCategories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[PartCategory] [varchar](100) NULL,
 CONSTRAINT [PK_PartCategories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Parts]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parts](
	[PartID] [int] IDENTITY(1,1) NOT NULL,
	[DirtBikeIDFK] [int] NULL,
	[PartName] [varchar](100) NULL,
	[Picture] [varchar](500) NULL,
	[Price] [decimal](18, 2) NULL,
	[PartDescription] [varchar](500) NULL,
	[BrandIDFK] [int] NULL,
	[CategoryIDFK] [int] NULL,
 CONSTRAINT [PK_Parts] PRIMARY KEY CLUSTERED 
(
	[PartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Brands] ON 

INSERT [dbo].[Brands] ([BrandID], [BrandName]) VALUES (1, N'Pro Circuit')
INSERT [dbo].[Brands] ([BrandID], [BrandName]) VALUES (2, N'Hinson')
INSERT [dbo].[Brands] ([BrandID], [BrandName]) VALUES (3, N'PC Racing')
INSERT [dbo].[Brands] ([BrandID], [BrandName]) VALUES (4, N'Acerbis')
INSERT [dbo].[Brands] ([BrandID], [BrandName]) VALUES (5, N'Sunstar')
INSERT [dbo].[Brands] ([BrandID], [BrandName]) VALUES (6, N'Renthal')
INSERT [dbo].[Brands] ([BrandID], [BrandName]) VALUES (7, N'Ride Engineering')
INSERT [dbo].[Brands] ([BrandID], [BrandName]) VALUES (8, N'Twin Air')
INSERT [dbo].[Brands] ([BrandID], [BrandName]) VALUES (9, N'Works Connection')
INSERT [dbo].[Brands] ([BrandID], [BrandName]) VALUES (10, N'Dunlop')
INSERT [dbo].[Brands] ([BrandID], [BrandName]) VALUES (1008, N'Vertex')
SET IDENTITY_INSERT [dbo].[Brands] OFF
INSERT [dbo].[Cart] ([UserIDFK], [PartIDFK], [PartPrice], [PartName], [PartBrand], [Picture], [Quantity]) VALUES (1139, 3, CAST(29.99 AS Decimal(18, 2)), N'Flo Stainless Steel Oil Filter', N'PC Racing', N'../../Content\DataTables\images\PartImg\rmz_pc_oil_filter.jpg', 1)
INSERT [dbo].[Cart] ([UserIDFK], [PartIDFK], [PartPrice], [PartName], [PartBrand], [Picture], [Quantity]) VALUES (1143, 4, CAST(164.95 AS Decimal(18, 2)), N'Full Plastic Kit', N'Acerbis', N'../../Content\DataTables\images\PartImg\rmzFullplastic.jpg', 1)
SET IDENTITY_INSERT [dbo].[DirtBikes] ON 

INSERT [dbo].[DirtBikes] ([DirtBikeID], [Make], [MakeYear], [Model]) VALUES (1, N'Suzuki', 2016, N'rmz250')
INSERT [dbo].[DirtBikes] ([DirtBikeID], [Make], [MakeYear], [Model]) VALUES (2, N'Kawasaki', 2016, N'kx250')
SET IDENTITY_INSERT [dbo].[DirtBikes] OFF
SET IDENTITY_INSERT [dbo].[Errors] ON 

INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1, CAST(N'2019-10-15' AS Date), N'   at System.Data.SqlClient.SqlInternalConnectionTds..ctor(DbConnectionPoolIdentity identity, SqlConnectionString connectionOptions, SqlCredential credential, Object providerInfo, String newPassword, SecureString newSecurePassword, Boolean redirectedUserInstance, SqlConnectionString userConnectionOptions, SessionData reconnectSessionData, DbConnectionPool pool, String accessToken, Boolean applyTransientFaultHandling, SqlAuthenticationProviderManager sqlAuthProviderManager)
   at System.Data.SqlClient.SqlConnectionFactory.CreateConnection(DbConnectionOptions options, DbConnectionPoolKey poolKey, Object poolGroupProviderInfo, DbConnectionPool pool, DbConnection owningConnection, DbConnectionOptions userOptions)
   at System.Data.ProviderBase.DbConnectionFactory.CreatePooledConnection(DbConnectionPool pool, DbConnection owningObject, DbConnectionOptions options, DbConnectionPoolKey poolKey, DbConnectionOptions userOptions)
   at System.Data.ProviderBase.DbConnectionPool.CreateObject(Db', N'A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: SQL Network Interfaces, error: 26 - Error Locating Server/Instance Specified)')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (2, CAST(N'2019-10-15' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean asyn', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_UsersRole_Roles". The conflict occurred in database "MotoParts", table "dbo.Roles", column ''RoleID''.
The statement has been terminated.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (3, CAST(N'2019-10-15' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean asyn', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_UsersRole_Roles". The conflict occurred in database "MotoParts", table "dbo.Roles", column ''RoleID''.
The statement has been terminated.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (4, CAST(N'2019-10-15' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean asyn', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_UsersRole_Roles". The conflict occurred in database "MotoParts", table "dbo.Roles", column ''RoleID''.
The statement has been terminated.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (5, CAST(N'2019-10-15' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean asyn', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_UsersRole_Roles". The conflict occurred in database "MotoParts", table "dbo.Roles", column ''RoleID''.
The statement has been terminated.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (6, CAST(N'2019-10-15' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean asyn', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_UsersRole_Roles". The conflict occurred in database "MotoParts", table "dbo.Roles", column ''RoleID''.
The statement has been terminated.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1002, CAST(N'2019-10-16' AS Date), N'   at System.Data.ProviderBase.FieldNameLookup.GetOrdinal(String fieldName)
   at System.Data.SqlClient.SqlDataReader.GetOrdinal(String name)
   at System.Data.SqlClient.SqlDataReader.get_Item(String name)
   at MotoPartsDAL.PartDAL.SelectPart(Part iPart) in C:\Users\David.Krummen\Desktop\MotoParts\MotoPartsDAL\PartDAL.cs:line 43', N'BrandIDFK')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1003, CAST(N'2019-10-16' AS Date), N'   at System.Data.ProviderBase.FieldNameLookup.GetOrdinal(String fieldName)
   at System.Data.SqlClient.SqlDataReader.GetOrdinal(String name)
   at System.Data.SqlClient.SqlDataReader.get_Item(String name)
   at MotoPartsDAL.PartDAL.SelectPart(Part iPart) in C:\Users\David.Krummen\Desktop\MotoParts\MotoPartsDAL\PartDAL.cs:line 43', N'BrandIDFK')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1004, CAST(N'2019-10-16' AS Date), N'   at System.Data.ProviderBase.FieldNameLookup.GetOrdinal(String fieldName)
   at System.Data.SqlClient.SqlDataReader.GetOrdinal(String name)
   at System.Data.SqlClient.SqlDataReader.get_Item(String name)
   at MotoPartsDAL.PartDAL.SelectPart(Part iPart) in C:\Users\David.Krummen\Desktop\MotoParts\MotoPartsDAL\PartDAL.cs:line 43', N'BrandIDFK')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1005, CAST(N'2019-10-16' AS Date), N'   at System.Data.ProviderBase.FieldNameLookup.GetOrdinal(String fieldName)
   at System.Data.SqlClient.SqlDataReader.GetOrdinal(String name)
   at System.Data.SqlClient.SqlDataReader.get_Item(String name)
   at MotoPartsDAL.PartDAL.SelectPart(Part iPart) in C:\Users\David.Krummen\Desktop\MotoParts\MotoPartsDAL\PartDAL.cs:line 43', N'BrandIDFK')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1006, CAST(N'2019-10-16' AS Date), N'   at System.Data.ProviderBase.FieldNameLookup.GetOrdinal(String fieldName)
   at System.Data.SqlClient.SqlDataReader.GetOrdinal(String name)
   at System.Data.SqlClient.SqlDataReader.get_Item(String name)
   at MotoPartsDAL.PartDAL.SelectPart(Part iPart) in C:\Users\David.Krummen\Desktop\MotoParts\MotoPartsDAL\PartDAL.cs:line 43', N'BrandIDFK')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1007, CAST(N'2019-10-16' AS Date), N'   at System.Data.ProviderBase.FieldNameLookup.GetOrdinal(String fieldName)
   at System.Data.SqlClient.SqlDataReader.GetOrdinal(String name)
   at System.Data.SqlClient.SqlDataReader.get_Item(String name)
   at MotoPartsDAL.PartDAL.SelectPart(Part iPart) in C:\Users\David.Krummen\Desktop\MotoParts\MotoPartsDAL\PartDAL.cs:line 43', N'BrandIDFK')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1008, CAST(N'2019-10-16' AS Date), N'   at System.Data.ProviderBase.FieldNameLookup.GetOrdinal(String fieldName)
   at System.Data.SqlClient.SqlDataReader.GetOrdinal(String name)
   at System.Data.SqlClient.SqlDataReader.get_Item(String name)
   at MotoPartsDAL.PartDAL.SelectPart(Part iPart) in C:\Users\David.Krummen\Desktop\MotoParts\MotoPartsDAL\PartDAL.cs:line 43', N'BrandIDFK')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1009, CAST(N'2019-10-16' AS Date), N'   at System.Data.ProviderBase.FieldNameLookup.GetOrdinal(String fieldName)
   at System.Data.SqlClient.SqlDataReader.GetOrdinal(String name)
   at System.Data.SqlClient.SqlDataReader.get_Item(String name)
   at MotoPartsDAL.PartDAL.SelectPart(Part iPart) in C:\Users\David.Krummen\Desktop\MotoParts\MotoPartsDAL\PartDAL.cs:line 43', N'BrandIDFK')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1010, CAST(N'2019-10-16' AS Date), N'   at System.Data.ProviderBase.FieldNameLookup.GetOrdinal(String fieldName)
   at System.Data.SqlClient.SqlDataReader.GetOrdinal(String name)
   at System.Data.SqlClient.SqlDataReader.get_Item(String name)
   at MotoPartsDAL.PartDAL.SelectPart(Part iPart) in C:\Users\David.Krummen\Desktop\MotoParts\MotoPartsDAL\PartDAL.cs:line 43', N'BrandIDFK')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1011, CAST(N'2019-10-21' AS Date), N'   at System.Data.SqlClient.MetaType.GetMetaTypeFromValue(Type dataType, Object value, Boolean inferLen, Boolean streamAllowed)
   at System.Data.SqlClient.SqlParameter.GetMetaTypeOnly()
   at System.Data.SqlClient.SqlParameter.Validate(Int32 index, Boolean isCommandProc)
   at System.Data.SqlClient.SqlCommand.SetUpRPCParameters(_SqlRPC rpc, Int32 startCount, Boolean inSchema, SqlParameterCollection parameters)
   at System.Data.SqlClient.SqlCommand.BuildRPC(Boolean inSchema, SqlParameterCollection parameters, _SqlRPC& rpc)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 ', N'No mapping exists from object type MotoPartsCommon.User to a known managed provider native type.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1012, CAST(N'2019-10-22' AS Date), N'   at System.Data.SqlClient.MetaType.GetMetaTypeFromValue(Type dataType, Object value, Boolean inferLen, Boolean streamAllowed)
   at System.Data.SqlClient.SqlParameter.GetMetaTypeOnly()
   at System.Data.SqlClient.SqlParameter.Validate(Int32 index, Boolean isCommandProc)
   at System.Data.SqlClient.SqlCommand.SetUpRPCParameters(_SqlRPC rpc, Int32 startCount, Boolean inSchema, SqlParameterCollection parameters)
   at System.Data.SqlClient.SqlCommand.BuildRPC(Boolean inSchema, SqlParameterCollection parameters, _SqlRPC& rpc)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 ', N'No mapping exists from object type MotoPartsCommon.User to a known managed provider native type.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1013, CAST(N'2019-10-22' AS Date), N'   at System.Data.SqlClient.MetaType.GetMetaTypeFromValue(Type dataType, Object value, Boolean inferLen, Boolean streamAllowed)
   at System.Data.SqlClient.SqlParameter.GetMetaTypeOnly()
   at System.Data.SqlClient.SqlParameter.Validate(Int32 index, Boolean isCommandProc)
   at System.Data.SqlClient.SqlCommand.SetUpRPCParameters(_SqlRPC rpc, Int32 startCount, Boolean inSchema, SqlParameterCollection parameters)
   at System.Data.SqlClient.SqlCommand.BuildRPC(Boolean inSchema, SqlParameterCollection parameters, _SqlRPC& rpc)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 ', N'No mapping exists from object type MotoPartsCommon.User to a known managed provider native type.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1014, CAST(N'2019-10-22' AS Date), N'   at System.Data.SqlClient.MetaType.GetMetaTypeFromValue(Type dataType, Object value, Boolean inferLen, Boolean streamAllowed)
   at System.Data.SqlClient.SqlParameter.GetMetaTypeOnly()
   at System.Data.SqlClient.SqlParameter.Validate(Int32 index, Boolean isCommandProc)
   at System.Data.SqlClient.SqlCommand.SetUpRPCParameters(_SqlRPC rpc, Int32 startCount, Boolean inSchema, SqlParameterCollection parameters)
   at System.Data.SqlClient.SqlCommand.BuildRPC(Boolean inSchema, SqlParameterCollection parameters, _SqlRPC& rpc)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 ', N'No mapping exists from object type MotoPartsCommon.User to a known managed provider native type.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1015, CAST(N'2019-10-22' AS Date), N'   at System.Data.SqlClient.MetaType.GetMetaTypeFromValue(Type dataType, Object value, Boolean inferLen, Boolean streamAllowed)
   at System.Data.SqlClient.SqlParameter.GetMetaTypeOnly()
   at System.Data.SqlClient.SqlParameter.Validate(Int32 index, Boolean isCommandProc)
   at System.Data.SqlClient.SqlCommand.SetUpRPCParameters(_SqlRPC rpc, Int32 startCount, Boolean inSchema, SqlParameterCollection parameters)
   at System.Data.SqlClient.SqlCommand.BuildRPC(Boolean inSchema, SqlParameterCollection parameters, _SqlRPC& rpc)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 ', N'No mapping exists from object type MotoPartsCommon.User to a known managed provider native type.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1016, CAST(N'2019-10-24' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean asyn', N'Procedure or function ''SP_UPDATE_PART'' expects parameter ''@parmPartName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1017, CAST(N'2019-10-24' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean asyn', N'Procedure or function ''SP_UPDATE_PART'' expects parameter ''@parmPartName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1018, CAST(N'2019-10-24' AS Date), N'   at System.Data.ProviderBase.FieldNameLookup.GetOrdinal(String fieldName)
   at System.Data.SqlClient.SqlDataReader.GetOrdinal(String name)
   at System.Data.SqlClient.SqlDataReader.get_Item(String name)
   at MotoPartsDAL.ExceptionHandling.ViewAllErrors(Error er) in C:\Users\David.Krummen\Desktop\MotoParts\MotoPartsDAL\ExceptionHandling.cs:line 76', N'Message')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1019, CAST(N'2019-10-24' AS Date), N'   at System.Data.ProviderBase.FieldNameLookup.GetOrdinal(String fieldName)
   at System.Data.SqlClient.SqlDataReader.GetOrdinal(String name)
   at System.Data.SqlClient.SqlDataReader.get_Item(String name)
   at MotoPartsDAL.ExceptionHandling.ViewAllErrors(Error er) in C:\Users\David.Krummen\Desktop\MotoParts\MotoPartsDAL\ExceptionHandling.cs:line 76', N'Message')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1020, CAST(N'2019-10-25' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean asyn', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_PartsBrand_BrandsID". The conflict occurred in database "MotoParts", table "dbo.Brands", column ''BrandID''.
The statement has been terminated.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1021, CAST(N'2019-10-28' AS Date), N'   at System.Data.SqlClient.MetaType.GetMetaTypeFromValue(Type dataType, Object value, Boolean inferLen, Boolean streamAllowed)
   at System.Data.SqlClient.SqlParameter.GetMetaTypeOnly()
   at System.Data.SqlClient.SqlParameter.Validate(Int32 index, Boolean isCommandProc)
   at System.Data.SqlClient.SqlCommand.SetUpRPCParameters(_SqlRPC rpc, Int32 startCount, Boolean inSchema, SqlParameterCollection parameters)
   at System.Data.SqlClient.SqlCommand.BuildRPC(Boolean inSchema, SqlParameterCollection parameters, _SqlRPC& rpc)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 ', N'No mapping exists from object type System.Text.StringBuilder to a known managed provider native type.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1022, CAST(N'2019-10-28' AS Date), N'   at System.Data.SqlClient.MetaType.GetMetaTypeFromValue(Type dataType, Object value, Boolean inferLen, Boolean streamAllowed)
   at System.Data.SqlClient.SqlParameter.GetMetaTypeOnly()
   at System.Data.SqlClient.SqlParameter.Validate(Int32 index, Boolean isCommandProc)
   at System.Data.SqlClient.SqlCommand.SetUpRPCParameters(_SqlRPC rpc, Int32 startCount, Boolean inSchema, SqlParameterCollection parameters)
   at System.Data.SqlClient.SqlCommand.BuildRPC(Boolean inSchema, SqlParameterCollection parameters, _SqlRPC& rpc)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 ', N'No mapping exists from object type System.Text.StringBuilder to a known managed provider native type.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1023, CAST(N'2019-10-28' AS Date), N'   at System.Data.SqlClient.MetaType.GetMetaTypeFromValue(Type dataType, Object value, Boolean inferLen, Boolean streamAllowed)
   at System.Data.SqlClient.SqlParameter.GetMetaTypeOnly()
   at System.Data.SqlClient.SqlParameter.Validate(Int32 index, Boolean isCommandProc)
   at System.Data.SqlClient.SqlCommand.SetUpRPCParameters(_SqlRPC rpc, Int32 startCount, Boolean inSchema, SqlParameterCollection parameters)
   at System.Data.SqlClient.SqlCommand.BuildRPC(Boolean inSchema, SqlParameterCollection parameters, _SqlRPC& rpc)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 ', N'No mapping exists from object type System.Text.StringBuilder to a known managed provider native type.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1024, CAST(N'2019-10-28' AS Date), N'   at System.Data.SqlClient.MetaType.GetMetaTypeFromValue(Type dataType, Object value, Boolean inferLen, Boolean streamAllowed)
   at System.Data.SqlClient.SqlParameter.GetMetaTypeOnly()
   at System.Data.SqlClient.SqlParameter.Validate(Int32 index, Boolean isCommandProc)
   at System.Data.SqlClient.SqlCommand.SetUpRPCParameters(_SqlRPC rpc, Int32 startCount, Boolean inSchema, SqlParameterCollection parameters)
   at System.Data.SqlClient.SqlCommand.BuildRPC(Boolean inSchema, SqlParameterCollection parameters, _SqlRPC& rpc)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 ', N'No mapping exists from object type System.Text.StringBuilder to a known managed provider native type.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1025, CAST(N'2019-10-28' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1026, CAST(N'2019-10-28' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1027, CAST(N'2019-10-28' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1028, CAST(N'2019-10-28' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1029, CAST(N'2019-10-28' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1030, CAST(N'2019-10-28' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1031, CAST(N'2019-10-28' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1032, CAST(N'2019-10-28' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1033, CAST(N'2019-10-28' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1034, CAST(N'2019-10-31' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1035, CAST(N'2019-10-31' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean asyn', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_PartsBrand_BrandsID". The conflict occurred in database "MotoParts", table "dbo.Brands", column ''BrandID''.
The statement has been terminated.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1036, CAST(N'2019-10-31' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1037, CAST(N'2019-10-31' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1038, CAST(N'2019-11-03' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1039, CAST(N'2019-11-04' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1040, CAST(N'2019-11-04' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1041, CAST(N'2019-11-04' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1042, CAST(N'2019-11-04' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean asyn', N'Procedure or function ''SP_UPDATE_PART_INFO_IN_CART'' expects parameter ''@parmPartBrand'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1043, CAST(N'2019-11-04' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1044, CAST(N'2019-11-04' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1045, CAST(N'2019-11-04' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1046, CAST(N'2019-11-04' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean asyn', N'The DELETE statement conflicted with the REFERENCE constraint "FK_Cart_Parts". The conflict occurred in database "MotoParts", table "dbo.Cart", column ''PartIDFK''.
The statement has been terminated.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1047, CAST(N'2019-11-04' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1048, CAST(N'2019-11-04' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1049, CAST(N'2019-11-04' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1050, CAST(N'2019-11-04' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1051, CAST(N'2019-11-04' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1052, CAST(N'2019-11-04' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1053, CAST(N'2019-11-04' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1054, CAST(N'2019-11-04' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1055, CAST(N'2019-11-04' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1056, CAST(N'2019-11-05' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1057, CAST(N'2019-11-05' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1058, CAST(N'2019-11-05' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1059, CAST(N'2019-11-05' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1060, CAST(N'2019-11-05' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1061, CAST(N'2019-11-05' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1062, CAST(N'2019-11-05' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
INSERT [dbo].[Errors] ([ErrorID], [ErrorDate], [StackTrace], [ErrorMessage]) VALUES (1063, CAST(N'2019-11-05' AS Date), N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at System.Data.SqlClie', N'Procedure or function ''SP_SELECT_USERS_SALT'' expects parameter ''@parmUserName'', which was not supplied.')
SET IDENTITY_INSERT [dbo].[Errors] OFF
SET IDENTITY_INSERT [dbo].[PartCategories] ON 

INSERT [dbo].[PartCategories] ([CategoryID], [PartCategory]) VALUES (1, N'engine')
INSERT [dbo].[PartCategories] ([CategoryID], [PartCategory]) VALUES (2, N'body')
INSERT [dbo].[PartCategories] ([CategoryID], [PartCategory]) VALUES (3, N'exhaust')
INSERT [dbo].[PartCategories] ([CategoryID], [PartCategory]) VALUES (4, N'drive')
INSERT [dbo].[PartCategories] ([CategoryID], [PartCategory]) VALUES (5, N'controls')
INSERT [dbo].[PartCategories] ([CategoryID], [PartCategory]) VALUES (6, N'brakes')
INSERT [dbo].[PartCategories] ([CategoryID], [PartCategory]) VALUES (7, N'intake')
INSERT [dbo].[PartCategories] ([CategoryID], [PartCategory]) VALUES (8, N'suspension')
INSERT [dbo].[PartCategories] ([CategoryID], [PartCategory]) VALUES (9, N'tires')
SET IDENTITY_INSERT [dbo].[PartCategories] OFF
SET IDENTITY_INSERT [dbo].[Parts] ON 

INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (1, 1, N'High Compression Piston Kit', N'../../Content/DataTables\images\PartImg\rmz_ProC_HighCompressionPistonKit.jpg', CAST(417.98 AS Decimal(18, 2)), N'Pro Circuit developed their High Compression Piston with the intentions of satisfying the need of your motorcycles thirst for more power.
The Pro Circuit High Compression Piston is an exclusive motorcycle engine upgrade that has the ability to boost low-end torque without neglecting top-end power.', 1, 1)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (2, 1, N'Complete Clutch Kit', N'../../Content\DataTables\images\PartImg\rmz_Hinson_ClutchKit.jpg', CAST(1115.99 AS Decimal(18, 2)), N'The winningest clutch in the world, race proven by all the best teams worldwide including Team Muscle Milk Honda, Team Red Bull KTM, Team Monster Kawasaki, Team Yoshimura Suzuki and Team Rinaldi Yamaha.', 2, 1)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (3, 1, N'Flo Stainless Steel Oil Filter', N'../../Content\DataTables\images\PartImg\rmz_pc_oil_filter.jpg', CAST(29.99 AS Decimal(18, 2)), N'Made from laser-cut, medical-grade, 304 stainless steel micronic filter cloth, this filter provides 200% more filter area in many cases.
The stainless filter catches items down to 35 microns, which is about three times better than most good paper or brass filters', 3, 1)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (4, 1, N'Full Plastic Kit', N'../../Content\DataTables\images\PartImg\rmzFullplastic.jpg', CAST(164.95 AS Decimal(18, 2)), N'35 years of experience with the best off-road racers in the world has enriched Acerbis'' constant technical development, allowing them to become a premier company within the motorcycle industry. All plastics included in the Acerbis plastic kit have the original factory shape of the selected bike model.', 4, 2)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (5, 1, N'Ti-6 Pro Complete Exhaust', N'../../Content\DataTables\images\PartImg\rmzti6.jpg', CAST(1049.99 AS Decimal(18, 2)), N'Pro Circuit''s Ti-6 Pro Titanium Exhaust System was created for professional racers competing in a series such as AMA Supercross or AMA Motocross to ensure they pass AMA / FIM sound regulations. The Ti-6 Pro Titanium Exhaust System is constructed of titanium throughout the head pipe, mid pipe, and canister while the end-cap is constructed of carbon fiber. Riders will notice an increase in performance over the previous Ti-5 system.', 1, 3)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (6, 1, N'Chain & Aluminum Sprocket Combo', N'../../Content\DataTables\images\PartImg\rmzSunstarSprocketkit.jpg', CAST(106.68 AS Decimal(18, 2)), N'Sunstar is the largest O.E.M. supplier of sprockets and brake rotors in the world. In fact, your motorcycle probably came from the factory with a Sunstar sprocket. Need a reason to choose Sunstar? Every Sunstar product is imbued with superior quality, uses an exclusive heat-treatment and quenching process, is based on advanced research and design, and is sold at an added value price.', 5, 4)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (7, 1, N'Aramid Dual Comp Grips - Twist Throttle', N'../../Content\DataTables\images\PartImg\rmzrenthalgrip.jpg', CAST(20.99 AS Decimal(18, 2)), N'For use with twist throttle, includes left and right grip.
Base material is reinforced with millions of randomly aligned DuPont Kevlar fibers; continued use exposes more fibers increasing the percentage of DuPont Kevlar at the grip surface.
Three times the life of the regular compound allowing the use of a very supple matrix materi', 6, 5)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (8, 1, N'Twinwall Handlebars - Oversized 1-1/8', N'../../Content\DataTables\images\PartImg\rmzBar.jpg', CAST(110.69 AS Decimal(18, 2)), N'The safest and strongest handlebars in the world.
Twinwall construction - consists of two aluminum alloy tubes one within the other.
Outer tube is 7010 T73 aluminum, which has extreme resistance to mechanical damage and is anodized to prevent corrosion.
Inner tube is ultra high strength 7010 T6 aluminum and is hard anodized to resist wear from twist grip and controls.
Offers 50% more flex than steel handlebars.
Rubber seals cover the join to keep out water and cleaning fluids.', 6, 5)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (15, 1, N'Billet Front Brake Caliper', N'../../Content\DataTables\images\PartImg\rmz_rideEgineering_frontCaliper.jpg', CAST(399.95 AS Decimal(18, 2)), N'RIDE ENGINEERING''s newest product is all about improving the braking performance of modern day dirt bikes. It''s billet caliper achieves this with larger pistons, a solid, flex-free body and cooling fins that allow air to pass through it completely. Although braking power is a little less than an over-sized rotor kit (Ride Engineering estimates about 15% vs. 20% with a 270 mm rotor kit), its the feel and modulation on how it applies the pressure to the brake pads that''s really impressive here.', 7, 6)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (17, 1, N'Air Filter', N'../../Content\DataTables\images\PartImg\rmz_TwinAir_AirFilter.jpg', CAST(32.95 AS Decimal(18, 2)), N'The Twin Air Air Filter''s design, high-quality materials and superior construction deliver unbeatable performance and protection - and make Twin Air Filters the hands-down choice of more World and National Champions than all other filters combined.

Twin Air filters are designed to increase airflow while ensuring the highest level of protection from dirt / dust.
Coarse open-pore foam catches airborne dirt, grime and sand.', 8, 7)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (18, 1, N'Pro Launch Start Device', N'../../Content\DataTables\images\PartImg\rmz_WC_proHoleshotDevice.jpg', CAST(119.95 AS Decimal(18, 2)), N'Spring-less design delivers positive engagement and consistent release.
"Easy set by rider" start trigger.
CNC machined exclusively from aircraft-grade aluminum.
Lightweight, complete assembly weighs only 50 grams.
Custom drill guide template and countersinking tool included.
Detailed installation instructions include large step-by-step photos.
Laser-etched logo.
Engineered, manufactured and assembled in the U.S.A', 9, 8)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (20, 1, N'Geomax MX33 Tire Combo', N'../../Content\DataTables\images\PartImg\rmz_Dunlop_Mx33.jpg', CAST(158.80 AS Decimal(18, 2)), N'Developed with the help of top motocross pros, the all-new MX33 is the new industry standard for soft-to-intermediate terrain. Dunlop''s innovative new technologies offer superior grip, slide control, bump absorption and enhanced durability.

Altered Block-in-a-Block shape on the rear tire increases surface area of the interior block, while additional tread angles enhance grip, stability and slide control.', 10, 9)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (1016, 2, N'Complete Top & Bottom End Kit ', N'../../Content\DataTables\images\PartImg\kx_Vertex_topBottom.jpg', CAST(750.80 AS Decimal(18, 2)), N'This complete 4-Stroke Top and Bottom End Kit has everything you need, all the quality parts, including a Vertex 4-Stroke Piston, to rebuild your motor.

The kit includes: Hot Rods Crank, Vertex 4-Stroke Piston, Hot Rods Bearings and Seals, and a Complete Athena Gasket Kit.', 1008, 1)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (1017, 2, N'High Compression Piston', N'../../Content\DataTables\images\PartImg\kx_procircut_highCompPiston.jpg', CAST(379.99 AS Decimal(18, 2)), N'By using a Pro Circuit high-compression piston you will gain both low-end torque and top-end power. High-compression pistons work equally well on stock or modified motors with the same results, more power at every RPM.

Pro Circuit developed their High Compression Piston with the intentions of satisfying the need of your motorcycle''s thirst for more power.', 1, 1)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (1018, 2, N'Full Plastic Kit', N'../../Content\DataTables\images\PartImg\kx250_Acerbis_FullPlasticKit.jpg', CAST(164.95 AS Decimal(18, 2)), N'35 years of experience with the best off-road racers in the world has enriched Acerbis'' constant technical development, allowing them to become a premier company within the motorcycle industry. All plastics included in the Acerbis plastic kit have the original factory shape of the selected bike model.', 4, 2)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (1019, 2, N'Ti-6 Pro Complete Exhaust', N'../../Content\DataTables\images\PartImg\kx250_ProCircut_ti6Pro.jpg', CAST(1049.99 AS Decimal(18, 2)), N'Pro Circuit''s Ti-6 Pro Titanium Exhaust System was created for professional racers competing in a series such as AMA Supercross or AMA Motocross to ensure they pass AMA / FIM sound regulations. The Ti-6 Pro Titanium Exhaust System is constructed of titanium throughout the head pipe, mid pipe, and canister while the end-cap is constructed of carbon fiber. Riders will notice an increase in performance over the previous Ti-5 system.', 1, 3)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (1020, 2, N'Chain & Sprocket Kit', N'../../Content\DataTables\images\PartImg\kx250_Renthal_ChainSprocketKit.jpg', CAST(126.99 AS Decimal(18, 2)), N'Renthal Chain & Sprocket Kit includes ONE Steel Countershaft (Front) Sprocket, ONE Aluminum Rear Sprocket, and your choice of ONE Premium 520 Drive Chain, each with the following features: When looking to replace your sprockets, Renthal sprockets are an easy choice because of their strength and inexpensive price tag.', 6, 4)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (1021, 2, N'Bar Mounts', N'../../Content\DataTables\images\PartImg\kx250_Renthal_BarMounts.jpg', CAST(61.99 AS Decimal(18, 2)), N'Renthal bar mounts are 1-1/8" diameter and are designed to replace your O.E. 7/8" diameter bar mounts. This upgrade will allow you to fit a Renthal Fatbar or Twinwall to a motorcycle which has 7/8" handlebars fitted as original equipment.', 6, 5)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (1022, 2, N'Billet Front Brake Caliper', N'../../Content\DataTables\images\PartImg\kx250_RideEgineering_FrontBreakCaliper.jpg', CAST(399.99 AS Decimal(18, 2)), N'impressive ', 7, 6)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (1024, 2, N'Pre-Oiled Air Filter', N'../../Content\DataTables\images\PartImg\kx250_TwinAir_PreOiledFilter.jpg', CAST(35.95 AS Decimal(18, 2)), N'Twin Air Factory Pre-Oiled filters have been available only to top professional race teams and O.E.M. customers. The results have been so good that Twin Air now offers the same factory treatment to everybody. They start with an Original Dual-Stage Air Filter and completely submerge it in BIO Liquid Power Filter Oil. After the filter is massaged to ensure all pores are evenly coated with oil, it''s placed in a temperature-controlled room to allow the oil to completely cure.', 8, 7)
INSERT [dbo].[Parts] ([PartID], [DirtBikeIDFK], [PartName], [Picture], [Price], [PartDescription], [BrandIDFK], [CategoryIDFK]) VALUES (1025, 2, N'Linkage Arm', N'../../Content\DataTables\images\PartImg\kx250_ProCircut_LinkageArm.jpg', CAST(224.99 AS Decimal(18, 2)), N'Pro Circuit''s Linkage Arm is CNC-machined from billet aluminum and is designed to stiffen up the initial linkage curve and improve the geometry of the chassis, making the bike much more stable. Although having your suspension revalved by Pro Circuit would make a considerable improvement, the Linkage Arms alone provide a major improvement over the stock set-up', 1, 8)
SET IDENTITY_INSERT [dbo].[Parts] OFF
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleDesrciption]) VALUES (1, N'Admin', N'Access to customer info, reset passwords..')
INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleDesrciption]) VALUES (3, N'User', N'A user is an account holder who can log in/out, save bikes, delete account, reset password')
INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleDesrciption]) VALUES (4, N'Moderator', N'Able to access parts to update them')
SET IDENTITY_INSERT [dbo].[Roles] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [UserPassword], [Salt], [Email], [RoleIDFK], [SavedDirtbikeIDFK]) VALUES (1136, N'admin', N'admin', N'admin', N'80bf10968fa2bb128ea8e3f8587fdad7a4e02f71a7fbcb6596f447ea12c6e330', N'10/28/2019 1:24:01 PM', N'admin@motoparts.com', 1, NULL)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [UserPassword], [Salt], [Email], [RoleIDFK], [SavedDirtbikeIDFK]) VALUES (1137, N'moderator', N'moderator', N'moderator', N'99a3aeceaa9ba16a8e5320b57b2432a9935331ef9726a41b8cbfc0538563d858', N'10/28/2019 1:25:08 PM', N'moderator@motoparts.com', 4, NULL)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [UserPassword], [Salt], [Email], [RoleIDFK], [SavedDirtbikeIDFK]) VALUES (1138, N'Austin', N'Forkner', N'Forkner214', N'3582dd6231c36ae748958ec57ff0b827ea3478e826c60dd7c9166c3027c38f1d', N'10/28/2019 1:42:15 PM', N'aforkner@gmail.com', 3, NULL)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [UserPassword], [Salt], [Email], [RoleIDFK], [SavedDirtbikeIDFK]) VALUES (1139, N'Ryan', N'Villopoto', N'rv2', N'0bf88eb5532526733599e14e84f00ffeef20aa2194e75fd5ab19dab634c11eeb', N'10/28/2019 1:43:34 PM', N'rv2@gmail.com', 3, NULL)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [UserPassword], [Salt], [Email], [RoleIDFK], [SavedDirtbikeIDFK]) VALUES (1143, N'kamille', N'wright', N'kamillew', N'57443a070a8907e4d7e7cda5f87c1293198eb7182916066b1acad9a1123ff214', N'11/3/2019 9:39:22 PM', N'wrightkamille@icloud.com', 3, NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Parts] FOREIGN KEY([PartIDFK])
REFERENCES [dbo].[Parts] ([PartID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Parts]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Users] FOREIGN KEY([UserIDFK])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Users]
GO
ALTER TABLE [dbo].[Parts]  WITH CHECK ADD  CONSTRAINT [FK_PartsBrand_BrandsID] FOREIGN KEY([BrandIDFK])
REFERENCES [dbo].[Brands] ([BrandID])
GO
ALTER TABLE [dbo].[Parts] CHECK CONSTRAINT [FK_PartsBrand_BrandsID]
GO
ALTER TABLE [dbo].[Parts]  WITH CHECK ADD  CONSTRAINT [FK_PartsCategory_CategoryID] FOREIGN KEY([CategoryIDFK])
REFERENCES [dbo].[PartCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[Parts] CHECK CONSTRAINT [FK_PartsCategory_CategoryID]
GO
ALTER TABLE [dbo].[Parts]  WITH CHECK ADD  CONSTRAINT [FK_PartsDirtBike_DirtBikes] FOREIGN KEY([DirtBikeIDFK])
REFERENCES [dbo].[DirtBikes] ([DirtBikeID])
GO
ALTER TABLE [dbo].[Parts] CHECK CONSTRAINT [FK_PartsDirtBike_DirtBikes]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_UsersRole_Roles] FOREIGN KEY([RoleIDFK])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_UsersRole_Roles]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_UsersSavedDirtBike_DirtBikes] FOREIGN KEY([SavedDirtbikeIDFK])
REFERENCES [dbo].[DirtBikes] ([DirtBikeID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_UsersSavedDirtBike_DirtBikes]
GO
/****** Object:  StoredProcedure [dbo].[SP_CASCADE_DELETE_PARTS_DIRTBIKE]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <10/27/2019>
-- Description:	<Cascading delete: if dirtbike is being deleted then delete all parts to that dirtbike first>
-- =============================================
CREATE PROCEDURE [dbo].[SP_CASCADE_DELETE_PARTS_DIRTBIKE] 
	-- Add the parameters for the stored procedure here
	@parmBikeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Parts
	WHERE DirtBikeIDFK = @parmBikeID
	DELETE FROM DirtBikes
	WHERE DirtBikeID = @parmBikeID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_PART]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <10/23/2019>
-- Description:	<Delete Part from parts table>
-- =============================================
CREATE PROCEDURE  [dbo].[SP_DELETE_PART]
	-- Add the parameters for the stored procedure here
	@parmPartID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Parts
	WHERE	PartID = @parmPartID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_PART_FROM_CART]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <10/31/2019>
-- Description:	<Delete Part from Cart by PartID and UserID>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DELETE_PART_FROM_CART] 
	-- Add the parameters for the stored procedure here
	@parmUserID int,
	@parmPartID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Cart
	WHERE	UserIDFK = @parmUserID AND PartIDFK = @parmPartID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_USER]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <9/26/2019>
-- Description:	<Delete user from Users table>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DELETE_USER] 
	-- Add the parameters for the stored procedure here
	@parmUserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Users
	WHERE UserID = @parmUserID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_ERROR]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <10/15/2019>
-- Description:	<Insert exception errors into errors table>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_ERROR] 
	-- Add the parameters for the stored procedure here
	@parmErrorDate Date,
	@parmStackTrace VARCHAR(1000),
	@parmErrorMessage VARCHAR(1000)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Errors(ErrorDate, StackTrace, ErrorMessage)
	VALUES (@parmErrorDate, @parmStackTrace, @parmErrorMessage);
END
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_PART]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <10/24/2019>
-- Description:	<Add Part to Part Table>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_PART] 
	-- Add the parameters for the stored procedure here
	@parmDirtBikeIDFK int,
	@parmPartName varchar (100),
	@parmPicture varchar (500),
	@parmPrice decimal (18,2),
	@parmPartDescription varchar (500),
	@parmBrandIDFK int,
	@parmCategoryIDFK int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Parts(DirtBikeIDFK, PartName, Picture, Price, PartDescription, BrandIDFK, CategoryIDFK)
	VALUES(@parmDirtBikeIDFK, @parmPartName, @parmPicture, @parmPrice, @parmPartDescription, @parmBrandIDFK, @parmCategoryIDFK);
END
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_TO_CART]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <19/29/19>
-- Description:	<Insert to cart when user adds a part >
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_TO_CART] 
	-- Add the parameters for the stored procedure here
	@parmUserIDFK int,
	@parmPartIDFK int,
	@parmPartPrice decimal(18,2),
	@parmPartName varchar(50),
	@parmPartBrand varchar(50),
	@parmPicture varchar(500),
	@parmQuantity int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Cart (UserIDFK, PartIDFK, PartPrice, PartName, PartBrand, Picture, Quantity)
	VALUES (@parmUserIDFK, @parmPartIDFK, @parmPartPrice, @parmPartName, @parmPartBrand, @parmPicture, @parmQuantity)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_USER]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <9/26/2019>
-- Description:	<Add user to Users table>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_USER] 
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
	@parmFirstName VARCHAR(100),
	@parmLastName VARCHAR(100),
	@parmUserName VARCHAR(100),
	@parmUserPassword VARCHAR(100),
	@parmSalt VARCHAR(100),
	@parmEmail VARCHAR(100),
	@parmRoleIDFK INT,
	@parmSavedDirtBikeIDFK INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Users(FirstName, LastName, UserName, UserPassword, Salt, Email, RoleIDFK, SavedDirtbikeIDFK)
	VALUES (@parmFirstName, @parmLastName, @parmUserName, @parmUserPassword, @parmSalt, @parmEmail, @parmRoleIDFK, @parmSavedDirtBikeIDFK);
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_DIRTBIKE]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <10/10/2019>
-- Description:	<Read all Dirtbikes>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SELECT_DIRTBIKE] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DirtBikeID, Make, MakeYear, Model
	FROM DirtBikes;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_ERROR]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <10/24/2019>
-- Description:	<Select all errors so admin can view them in a table>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SELECT_ERROR] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ErrorID, ErrorDate, StackTrace, ErrorMessage
	FROM Errors
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_PART]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <10/14/19>
-- Description:	<Select all parts>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SELECT_PART] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT PartID, DirtBikeIDFK, PartName, Picture, Price, PartDescription, BrandIDFK, BrandName, CategoryIDFK
	FROM Parts
	INNER JOIN Brands
	ON BrandIDFK = BrandID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_PART_QUANTITY]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <11/03/2019>
-- Description:	<Select Users specific part id quantity>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SELECT_PART_QUANTITY] 
	-- Add the parameters for the stored procedure here
	@parmUserID int,
	@parmPartID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Quantity
	FROM Cart
	WHERE UserIDFK = @parmUserID AND PartIDFK = @parmPartID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_ROLE]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <10/21/2019>
-- Description:	<Select RoleID and RoleName from roles table>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SELECT_ROLE] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT RoleID, RoleName
	FROM Roles
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_USER]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <9/26/2019>
-- Description:	<Select user from Users table>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SELECT_USER] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT UserID, FirstName, LastName, UserName, UserPassword, Salt, Email, RoleIDFK, SavedDirtbikeIDFK
	FROM Users;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_USERNAMES_FOR_REGISTRATION]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <11/05/2019>
-- Description:	<Select all usernames from Users table for comaparing
--				 registering users inputed username to usernames in database>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SELECT_USERNAMES_FOR_REGISTRATION] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT UserName
	FROM Users
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_USERS_CART]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <10/30/2019>
-- Description:	<Use UserID as a parameter to match to parts in the cart table>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SELECT_USERS_CART] 
	-- Add the parameters for the stored procedure here
	@parmUserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT PartIDFK, PartPrice, PartName, PartBrand, Picture, Quantity
	FROM Cart
	WHERE UserIDFK = @parmUserID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_USERS_SALT]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <10/28/2019>
-- Description:	<Get salt by username>
-- =============================================
CREATE PROCEDURE [dbo].[SP_SELECT_USERS_SALT] 
	-- Add the parameters for the stored procedure here
	@parmUserName varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Salt
	FROM Users
	WHERE UserName = @parmUserName;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_PART]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <10/23/2019>
-- Description:	<Update part from Part table>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_PART] 
	-- Add the parameters for the stored procedure here
	@parmPartID int,
	@parmDirtBikeIDFK int,
	@parmPartName varchar (100),
	@parmPicture varchar (500),
	@parmPrice decimal (18,2),
	@parmPartDescription varchar (500),
	@parmBrandIDFK int,
	@parmCategoryIDFK int


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Parts
	SET DirtBikeIDFK = @parmDirtBikeIDFK, PartName = @parmPartName, Picture = @parmPicture, Price = @parmPrice, PartDescription = @parmPartDescription, BrandIDFK = @parmBrandIDFK, CategoryIDFK = @parmCategoryIDFK
	WHERE PartID = @parmPartID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_PART_INFO_IN_CART]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <11/04/2019>
-- Description:	<If part is updated also update in cart>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_PART_INFO_IN_CART]
	-- Add the parameters for the stored procedure here
	@parmPartPrice decimal(18,2),
	@parmPartName varchar (50),
	@parmPicture varchar (500),
	@parmPartID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Cart
	SET PartPrice = @parmPartPrice, 
	PartName = @parmPartName, 
	Picture = @parmPicture
	WHERE PartIDFK = @parmPartID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_PART_QUANTITY]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <11/03/2019>
-- Description:	<Update Cart PartID Quantity>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_PART_QUANTITY]
	-- Add the parameters for the stored procedure here
	@parmUserId INT,
	@parmPartId INT,
	@parmQuantity INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Cart
	SET Quantity = @parmQuantity
	WHERE PartIDFK = @parmPartId AND UserIDFK = @parmUserId;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_USER]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <9/26/2019>
-- Description:	<Update User in Users table>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_USER] 
	-- Add the parameters for the stored procedure here
	@parmUserId INT,
	@parmFirstName VARCHAR(100),
	@parmLastName VARCHAR(100),
	@parmUserName VARCHAR(100),
	@parmUserPassword VARCHAR(100),
	@parmSalt VARCHAR(100),
	@parmEmail VARCHAR(100),
	@parmRoleIDFK INT,
	@parmSavedDirtBikeIDFK INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Users
	SET FirstName = @parmFirstName, LastName = @parmLastName, UserName = @parmUserName, UserPassword = @parmUserPassword, Salt = @parmSalt, Email = @parmEmail, RoleIDFK = @parmRoleIDFK, SavedDirtBikeIDFK = @parmSavedDirtBikeIDFK
	WHERE UserID = @parmUserId;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_USER_ROLE]    Script Date: 11/5/2019 12:40:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<David Krummen>
-- Create date: <10/21/2019,>
-- Description:	<Used by admin to update a user role>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_USER_ROLE] 
	-- Add the parameters for the stored procedure here
	@parmUserId INT,
	@parmRoleIDFK INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Users
	SET RoleIDFK = @parmRoleIDFK
	WHERE UserID = @parmUserId;
END
GO
USE [master]
GO
ALTER DATABASE [MotoParts] SET  READ_WRITE 
GO
