CREATE TABLE [dbo].[PetProfiles] (
    [ProfileId]        INT            IDENTITY (1, 1) NOT NULL,
    [PetId]            INT            NOT NULL,
    [Description]      NVARCHAR (MAX) NULL,
    [RegistrationDate] DATETIME       DEFAULT (getdate()) NULL,
    [LastUpdatedDate]  DATETIME       DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([ProfileId] ASC)
);

