CREATE TABLE [dbo].[DoctorOpinions] (
    [OpinionId]   INT            IDENTITY (1, 1) NOT NULL,
    [HistoryId]   INT            NOT NULL,
    [DoctorName]  NVARCHAR (255) NOT NULL,
    [OpinionText] NVARCHAR (MAX) NOT NULL,
    [DateIssued]  DATETIME       DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([OpinionId] ASC)
);

