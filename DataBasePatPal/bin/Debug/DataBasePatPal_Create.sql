/*
Скрипт развертывания для PatPalDB

Этот код был создан программным средством.
Изменения, внесенные в этот файл, могут привести к неверному выполнению кода и будут потеряны
в случае его повторного формирования.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "PatPalDB"
:setvar DefaultFilePrefix "PatPalDB"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Проверьте режим SQLCMD и отключите выполнение скрипта, если режим SQLCMD не поддерживается.
Чтобы повторно включить скрипт после включения режима SQLCMD выполните следующую инструкцию:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Для успешного выполнения этого скрипта должен быть включен режим SQLCMD.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Идет создание базы данных $(DatabaseName)…'
GO
CREATE DATABASE [$(DatabaseName)] COLLATE Cyrillic_General_CI_AS
GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Параметры базы данных изменить нельзя. Применить эти параметры может только пользователь SysAdmin.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Параметры базы данных изменить нельзя. Применить эти параметры может только пользователь SysAdmin.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Идет создание Таблица [dbo].[PetPhotos]…';


GO
CREATE TABLE [dbo].[PetPhotos] (
    [PhotoId]    INT            IDENTITY (1, 1) NOT NULL,
    [PetId]      INT            NOT NULL,
    [PhotoUrl]   NVARCHAR (MAX) NOT NULL,
    [UploadDate] DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([PhotoId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[PetDocuments]…';


GO
CREATE TABLE [dbo].[PetDocuments] (
    [DocumentId]   INT            IDENTITY (1, 1) NOT NULL,
    [PetId]        INT            NOT NULL,
    [DocumentType] NVARCHAR (100) NOT NULL,
    [IssueDate]    DATE           NOT NULL,
    [ExpiryDate]   DATE           NULL,
    [FileUrl]      NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([DocumentId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[LabTests]…';


GO
CREATE TABLE [dbo].[LabTests] (
    [TestId]    INT            IDENTITY (1, 1) NOT NULL,
    [HistoryId] INT            NOT NULL,
    [TestType]  NVARCHAR (100) NOT NULL,
    [Result]    NVARCHAR (MAX) NULL,
    [TestDate]  DATETIME       NOT NULL,
    PRIMARY KEY CLUSTERED ([TestId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[DoctorOpinions]…';


GO
CREATE TABLE [dbo].[DoctorOpinions] (
    [OpinionId]   INT            IDENTITY (1, 1) NOT NULL,
    [HistoryId]   INT            NOT NULL,
    [DoctorName]  NVARCHAR (255) NOT NULL,
    [OpinionText] NVARCHAR (MAX) NOT NULL,
    [DateIssued]  DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([OpinionId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[MedicalHistory]…';


GO
CREATE TABLE [dbo].[MedicalHistory] (
    [HistoryId]   INT            IDENTITY (1, 1) NOT NULL,
    [PetId]       INT            NOT NULL,
    [Diagnosis]   NVARCHAR (MAX) NULL,
    [Treatment]   NVARCHAR (MAX) NULL,
    [DateOfVisit] DATETIME       NOT NULL,
    [VetClinicId] INT            NULL,
    PRIMARY KEY CLUSTERED ([HistoryId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[VetClinics]…';


GO
CREATE TABLE [dbo].[VetClinics] (
    [ClinicId]   INT            IDENTITY (1, 1) NOT NULL,
    [ClinicName] NVARCHAR (255) NOT NULL,
    [Address]    NVARCHAR (MAX) NOT NULL,
    [Phone]      NVARCHAR (20)  NULL,
    [Rating]     DECIMAL (3, 2) NULL,
    [Reviews]    NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([ClinicId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Users]…';


GO
CREATE TABLE [dbo].[Users] (
    [UserId]       INT            IDENTITY (1, 1) NOT NULL,
    [Username]     NVARCHAR (255) NOT NULL,
    [Email]        NVARCHAR (255) NOT NULL,
    [PasswordHash] NVARCHAR (255) NOT NULL,
    [Role]         NVARCHAR (50)  NOT NULL,
    PRIMARY KEY CLUSTERED ([UserId] ASC),
    UNIQUE NONCLUSTERED ([Email] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[ChangeLog]…';


GO
CREATE TABLE [dbo].[ChangeLog] (
    [LogId]      INT            IDENTITY (1, 1) NOT NULL,
    [EntityName] NVARCHAR (100) NOT NULL,
    [Action]     NVARCHAR (50)  NOT NULL,
    [ChangedBy]  INT            NOT NULL,
    [ChangeDate] DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([LogId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[CareProcedures]…';


GO
CREATE TABLE [dbo].[CareProcedures] (
    [ProcedureId]       INT            IDENTITY (1, 1) NOT NULL,
    [PetId]             INT            NOT NULL,
    [ProcedureType]     NVARCHAR (100) NOT NULL,
    [Schedule]          NVARCHAR (255) NULL,
    [LastPerformedDate] DATETIME       NULL,
    [NextScheduledDate] DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([ProcedureId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Appointments]…';


GO
CREATE TABLE [dbo].[Appointments] (
    [AppointmentId]   INT           IDENTITY (1, 1) NOT NULL,
    [PetId]           INT           NOT NULL,
    [ClinicId]        INT           NOT NULL,
    [AppointmentDate] DATETIME      NOT NULL,
    [Status]          NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([AppointmentId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[pets]…';


GO
CREATE TABLE [dbo].[pets] (
    [petid]       INT            IDENTITY (1, 1) NOT NULL,
    [ownerid]     INT            NOT NULL,
    [name]        NVARCHAR (100) NOT NULL,
    [species]     NVARCHAR (100) NOT NULL,
    [breed]       NVARCHAR (100) NULL,
    [dateofbirth] DATE           NOT NULL,
    [gender]      NVARCHAR (10)  NOT NULL,
    [photourl]    NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([petid] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[ClinicSchedule]…';


GO
CREATE TABLE [dbo].[ClinicSchedule] (
    [ScheduleId] INT           IDENTITY (1, 1) NOT NULL,
    [ClinicId]   INT           NOT NULL,
    [DayOfWeek]  NVARCHAR (10) NOT NULL,
    [StartTime]  TIME (7)      NOT NULL,
    [EndTime]    TIME (7)      NOT NULL,
    PRIMARY KEY CLUSTERED ([ScheduleId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Notifications]…';


GO
CREATE TABLE [dbo].[Notifications] (
    [NotificationId] INT            IDENTITY (1, 1) NOT NULL,
    [UserId]         INT            NOT NULL,
    [Message]        NVARCHAR (MAX) NOT NULL,
    [IsRead]         BIT            NULL,
    [CreatedDate]    DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([NotificationId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Reminders]…';


GO
CREATE TABLE [dbo].[Reminders] (
    [ReminderId]   INT            IDENTITY (1, 1) NOT NULL,
    [PetId]        INT            NOT NULL,
    [ReminderType] NVARCHAR (100) NOT NULL,
    [DueDate]      DATETIME       NOT NULL,
    [IsCompleted]  BIT            NULL,
    [CreatedDate]  DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([ReminderId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[PetProfiles]…';


GO
CREATE TABLE [dbo].[PetProfiles] (
    [ProfileId]        INT            IDENTITY (1, 1) NOT NULL,
    [PetId]            INT            NOT NULL,
    [Description]      NVARCHAR (MAX) NULL,
    [RegistrationDate] DATETIME       NULL,
    [LastUpdatedDate]  DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([ProfileId] ASC)
);


GO
PRINT N'Идет создание Ограничение по умолчанию ограничение без названия для [dbo].[PetPhotos]…';


GO
ALTER TABLE [dbo].[PetPhotos]
    ADD DEFAULT (getdate()) FOR [UploadDate];


GO
PRINT N'Идет создание Ограничение по умолчанию ограничение без названия для [dbo].[DoctorOpinions]…';


GO
ALTER TABLE [dbo].[DoctorOpinions]
    ADD DEFAULT (getdate()) FOR [DateIssued];


GO
PRINT N'Идет создание Ограничение по умолчанию ограничение без названия для [dbo].[ChangeLog]…';


GO
ALTER TABLE [dbo].[ChangeLog]
    ADD DEFAULT (getdate()) FOR [ChangeDate];


GO
PRINT N'Идет создание Ограничение по умолчанию ограничение без названия для [dbo].[Notifications]…';


GO
ALTER TABLE [dbo].[Notifications]
    ADD DEFAULT ((0)) FOR [IsRead];


GO
PRINT N'Идет создание Ограничение по умолчанию ограничение без названия для [dbo].[Notifications]…';


GO
ALTER TABLE [dbo].[Notifications]
    ADD DEFAULT (getdate()) FOR [CreatedDate];


GO
PRINT N'Идет создание Ограничение по умолчанию ограничение без названия для [dbo].[Reminders]…';


GO
ALTER TABLE [dbo].[Reminders]
    ADD DEFAULT ((0)) FOR [IsCompleted];


GO
PRINT N'Идет создание Ограничение по умолчанию ограничение без названия для [dbo].[Reminders]…';


GO
ALTER TABLE [dbo].[Reminders]
    ADD DEFAULT (getdate()) FOR [CreatedDate];


GO
PRINT N'Идет создание Ограничение по умолчанию ограничение без названия для [dbo].[PetProfiles]…';


GO
ALTER TABLE [dbo].[PetProfiles]
    ADD DEFAULT (getdate()) FOR [RegistrationDate];


GO
PRINT N'Идет создание Ограничение по умолчанию ограничение без названия для [dbo].[PetProfiles]…';


GO
ALTER TABLE [dbo].[PetProfiles]
    ADD DEFAULT (getdate()) FOR [LastUpdatedDate];


GO
PRINT N'Идет создание Проверочное ограничение ограничение без названия для [dbo].[VetClinics]…';


GO
ALTER TABLE [dbo].[VetClinics]
    ADD CHECK ([Rating]>=(0) AND [Rating]<=(5));


GO
PRINT N'Идет создание Проверочное ограничение ограничение без названия для [dbo].[Users]…';


GO
ALTER TABLE [dbo].[Users]
    ADD CHECK ([Role]='Admin' OR [Role]='VetClinic' OR [Role]='Owner');


GO
PRINT N'Идет создание Проверочное ограничение ограничение без названия для [dbo].[ChangeLog]…';


GO
ALTER TABLE [dbo].[ChangeLog]
    ADD CHECK ([Action]='Delete' OR [Action]='Update' OR [Action]='Create');


GO
PRINT N'Идет создание Проверочное ограничение ограничение без названия для [dbo].[Appointments]…';


GO
ALTER TABLE [dbo].[Appointments]
    ADD CHECK ([Status]='Completed' OR [Status]='Cancelled' OR [Status]='Confirmed' OR [Status]='Pending');


GO
PRINT N'Идет создание Проверочное ограничение ограничение без названия для [dbo].[pets]…';


GO
ALTER TABLE [dbo].[pets]
    ADD CHECK ([gender]='Female' OR [gender]='Male');


GO
PRINT N'Идет создание Проверочное ограничение ограничение без названия для [dbo].[ClinicSchedule]…';


GO
ALTER TABLE [dbo].[ClinicSchedule]
    ADD CHECK ([DayOfWeek]='Sunday' OR [DayOfWeek]='Saturday' OR [DayOfWeek]='Friday' OR [DayOfWeek]='Thursday' OR [DayOfWeek]='Wednesday' OR [DayOfWeek]='Tuesday' OR [DayOfWeek]='Monday');


GO
PRINT N'Идет создание Триггер [dbo].[trg_Changelog_LogChanges]…';


GO
CREATE TRIGGER trg_Changelog_LogChanges
ON dbo.Changelog
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO dbo.ChangeLog (EntityName, Action, ChangedBy, ChangeDate)
    SELECT EntityName, Action, ChangedBy, ChangeDate
    FROM dbo.LogTableChanges();
END;
GO
PRINT N'Идет создание Триггер [dbo].[trg_CareProcedures_LogChanges]…';


GO
CREATE TRIGGER trg_CareProcedures_LogChanges
ON dbo.CareProcedures
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO dbo.ChangeLog (EntityName, Action, ChangedBy, ChangeDate)
    SELECT EntityName, Action, ChangedBy, ChangeDate
    FROM dbo.LogTableChanges();
END;
GO
PRINT N'Идет создание Триггер [dbo].[trg_Appointments_LogChanges]…';


GO
CREATE TRIGGER trg_Appointments_LogChanges
ON dbo.Appointments
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO dbo.ChangeLog (EntityName, Action, ChangedBy, ChangeDate)
    SELECT EntityName, Action, ChangedBy, ChangeDate
    FROM dbo.LogTableChanges();
END;
GO
PRINT N'Идет создание Триггер [dbo].[trg_Pets_LogChanges]…';


GO
-- Создаем триггер для таблицы dbo.Pets
CREATE TRIGGER trg_Pets_LogChanges
ON dbo.Pets
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    EXEC dbo.LogTableChanges;
END;
GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET MULTI_USER 
    WITH ROLLBACK IMMEDIATE;


GO
PRINT N'Обновление завершено.';


GO
