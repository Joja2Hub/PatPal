CREATE TABLE [dbo].[PetDocuments] (
    [DocumentId]   INT            IDENTITY (1, 1) NOT NULL,
    [PetId]        INT            NOT NULL,
    [DocumentType] NVARCHAR (100) NOT NULL,
    [IssueDate]    DATE           NOT NULL,
    [ExpiryDate]   DATE           NULL,
    [FileUrl]      NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([DocumentId] ASC)
);

