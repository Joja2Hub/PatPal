CREATE TABLE [dbo].[Reminders] (
    [ReminderId]   INT            IDENTITY (1, 1) NOT NULL,
    [PetId]        INT            NOT NULL,
    [ReminderType] NVARCHAR (100) NOT NULL,
    [DueDate]      DATETIME       NOT NULL,
    [IsCompleted]  BIT            DEFAULT ((0)) NULL,
    [CreatedDate]  DATETIME       DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([ReminderId] ASC)
);

