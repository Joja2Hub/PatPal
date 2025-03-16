CREATE TABLE [dbo].[MedicalHistory] (
    [HistoryId]   INT            IDENTITY (1, 1) NOT NULL,
    [PetId]       INT            NOT NULL,
    [Diagnosis]   NVARCHAR (MAX) NULL,
    [Treatment]   NVARCHAR (MAX) NULL,
    [DateOfVisit] DATETIME       NOT NULL,
    [VetClinicId] INT            NULL,
    PRIMARY KEY CLUSTERED ([HistoryId] ASC)
);

