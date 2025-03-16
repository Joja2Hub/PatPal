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
CREATE TRIGGER trg_CareProcedures_LogChanges
ON dbo.CareProcedures
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO dbo.ChangeLog (EntityName, Action, ChangedBy, ChangeDate)
    SELECT EntityName, Action, ChangedBy, ChangeDate
    FROM dbo.LogTableChanges();
END;
