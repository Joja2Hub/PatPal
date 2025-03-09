CREATE TABLE [dbo].[VetClinics] (
    [ClinicId]   INT            IDENTITY (1, 1) NOT NULL,
    [ClinicName] NVARCHAR (255) NOT NULL,
    [Address]    NVARCHAR (MAX) NOT NULL,
    [Phone]      NVARCHAR (20)  NULL,
    [Rating]     DECIMAL (3, 2) NULL,
    [Reviews]    NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([ClinicId] ASC),
    CHECK ([Rating]>=(0) AND [Rating]<=(5))
);

