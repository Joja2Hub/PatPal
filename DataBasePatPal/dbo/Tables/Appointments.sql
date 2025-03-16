CREATE TABLE [dbo].[Appointments] (
    [AppointmentId]   INT           IDENTITY (1, 1) NOT NULL,
    [PetId]           INT           NOT NULL,
    [ClinicId]        INT           NOT NULL,
    [AppointmentDate] DATETIME      NOT NULL,
    [Status]          NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([AppointmentId] ASC),
    CHECK ([Status]='Completed' OR [Status]='Cancelled' OR [Status]='Confirmed' OR [Status]='Pending')
);


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
