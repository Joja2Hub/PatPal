CREATE TABLE [dbo].[Notifications] (
    [NotificationId] INT            IDENTITY (1, 1) NOT NULL,
    [UserId]         INT            NOT NULL,
    [Message]        NVARCHAR (MAX) NOT NULL,
    [IsRead]         BIT            DEFAULT ((0)) NULL,
    [CreatedDate]    DATETIME       DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([NotificationId] ASC)
);

