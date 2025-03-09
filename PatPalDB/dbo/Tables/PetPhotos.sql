CREATE TABLE [dbo].[PetPhotos] (
    [PhotoId]    INT            IDENTITY (1, 1) NOT NULL,
    [PetId]      INT            NOT NULL,
    [PhotoUrl]   NVARCHAR (MAX) NOT NULL,
    [UploadDate] DATETIME       DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([PhotoId] ASC)
);

