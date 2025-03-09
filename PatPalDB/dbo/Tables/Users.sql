CREATE TABLE [dbo].[Users] (
    [UserId]       INT            IDENTITY (1, 1) NOT NULL,
    [Username]     NVARCHAR (255) NOT NULL,
    [Email]        NVARCHAR (255) NOT NULL,
    [PasswordHash] NVARCHAR (255) NOT NULL,
    [Role]         NVARCHAR (50)  NOT NULL,
    PRIMARY KEY CLUSTERED ([UserId] ASC),
    CHECK ([Role]='Admin' OR [Role]='VetClinic' OR [Role]='Owner'),
    UNIQUE NONCLUSTERED ([Email] ASC)
);

