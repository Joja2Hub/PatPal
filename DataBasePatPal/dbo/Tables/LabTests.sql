CREATE TABLE [dbo].[LabTests] (
    [TestId]    INT            IDENTITY (1, 1) NOT NULL,
    [HistoryId] INT            NOT NULL,
    [TestType]  NVARCHAR (100) NOT NULL,
    [Result]    NVARCHAR (MAX) NULL,
    [TestDate]  DATETIME       NOT NULL,
    PRIMARY KEY CLUSTERED ([TestId] ASC)
);

