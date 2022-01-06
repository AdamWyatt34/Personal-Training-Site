CREATE TABLE [dbo].[Clients]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [FirstName] NVARCHAR(25) NOT NULL, 
    [LastName] NVARCHAR(25) NOT NULL, 
    [EmailAddress] NVARCHAR(75) NOT NULL, 
    [PhoneNumber] NVARCHAR(21) NOT NULL, 
    [DateOfBirth] DATETIME2 NOT NULL, 
    [DateCreated] DATETIME2 NOT NULL DEFAULT GetDate()
)
