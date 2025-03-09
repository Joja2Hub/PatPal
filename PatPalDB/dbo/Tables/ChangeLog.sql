CREATE TABLE [dbo].[ChangeLog] (
    [LogId]      INT            IDENTITY (1, 1) NOT NULL,
    [EntityName] NVARCHAR (100) NOT NULL,
    [Action]     NVARCHAR (50)  NOT NULL,
    [ChangedBy]  INT            NOT NULL,
    [ChangeDate] DATETIME       DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([LogId] ASC),
    CHECK ([Action]='Delete' OR [Action]='Update' OR [Action]='Create')
);


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
