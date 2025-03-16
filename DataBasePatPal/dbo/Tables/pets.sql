CREATE TABLE [dbo].[pets] (
    [petid]       INT            IDENTITY (1, 1) NOT NULL,
    [ownerid]     INT            NOT NULL,
    [name]        NVARCHAR (100) NOT NULL,
    [species]     NVARCHAR (100) NOT NULL,
    [breed]       NVARCHAR (100) NULL,
    [dateofbirth] DATE           NOT NULL,
    [gender]      NVARCHAR (10)  NOT NULL,
    [photourl]    NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([petid] ASC),
    CHECK ([gender]='Female' OR [gender]='Male')
);


GO
-- Создаем триггер для таблицы dbo.Pets
CREATE TRIGGER trg_Pets_LogChanges
ON dbo.Pets
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    EXEC dbo.LogTableChanges;
END;
