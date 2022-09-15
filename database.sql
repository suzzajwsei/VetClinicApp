USE MASTER
GO
DROP DATABASE IF EXISTS [VETCLINICDB]
GO
CREATE DATABASE [VETCLINICDB]
GO
USE [VETCLINICDB]
GO

DROP TABLE IF EXISTS [Clients]
GO

CREATE TABLE [Clients]
(
[ClientID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL
,[Name] VARCHAR(20) NOT NULL
,[Surname] VARCHAR (30) NOT NULL
,[Pesel] NCHAR(11) UNIQUE NOT NULL
,[PhoneNr] NCHAR(9) NOT NULL
)
GO

DROP TABLE IF EXISTS [ClientAddresses]
GO

CREATE TABLE [ClientAddresses]
(
[ClientID] INT NOT NULL
,[ZipCode] CHAR(6) NOT NULL CHECK([ZipCode] like '[0-9][0-9][-][0-9][0-9][0-9]')
,[City] VARCHAR(30) NOT NULL
,[Street] VARCHAR(30) NOT NULL
,CONSTRAINT [ClientAddID] FOREIGN KEY (ClientID) REFERENCES [Clients](ClientID)
)
GO

DROP TABLE IF EXISTS [Animals]
GO

CREATE TABLE [Animals]
(
[ClientID] INT NOT NULL
,[AnimalID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL
,[Species] VARCHAR(20)
,[Name] VARCHAR(20) NOT NULL
,CONSTRAINT [AnimalsClientID] FOREIGN KEY(ClientID) REFERENCES [Clients](ClientID)
)
GO

DROP TABLE IF EXISTS [Chip]
GO

CREATE TABLE [Chip]
(
[AnimalID] INT NOT NULL
,[ClientID] INT NOT NULL
,[AddInfo] VARCHAR(100)
,[ChipNumber] INT IDENTITY(1,1) PRIMARY KEY NOT NULL
,CONSTRAINT [ChipClientID] FOREIGN KEY (ClientID) REFERENCES [Clients](ClientID)
,CONSTRAINT [ChipAnimalID] FOREIGN KEY (AnimalID) REFERENCES [Animals](AnimalID)
)
GO

DROP TABLE IF EXISTS [RabiesVaccinations]
GO

CREATE TABLE [RabiesVaccinations]
(
[ChipNumber] INT NOT NULL
,[Vaccinated] CHAR(3) NOT NULL
,CONSTRAINT [RVacChip] FOREIGN KEY(ChipNumber) REFERENCES [Chip](ChipNumber)
)
GO

DROP TABLE IF EXISTS [MedProceduresList]
GO

CREATE TABLE [MedProceduresList]
(
[MedProcNumber] INT IDENTITY(1,1) PRIMARY KEY
,[MedProcName] NVARCHAR(100) NOT NULL
,[Price] SMALLMONEY NOT NULL
)
GO

DROP TABLE IF EXISTS [MedicalProcedures]
GO

CREATE TABLE [MedicalProcedures]
(
[MedProcNumber] INT NOT NULL
,[AnimalID] INT
,[Date] DATETIME NOT NULL
,[Room] CHAR(7) NOT NULL
,CONSTRAINT [MedProcL] FOREIGN KEY (MedProcNumber) REFERENCES [MedProceduresList](MedProcNumber)
,CONSTRAINT [MedProcAnimal] FOREIGN KEY (AnimalID) REFERENCES [Animals](AnimalID)
)
GO


INSERT INTO MedProceduresList VALUES ('Spay', 250)
INSERT INTO MedProceduresList VALUES ('Vaccination', 60)
INSERT INTO MedProceduresList VALUES ('Vaccination full set', 190)
INSERT INTO MedProceduresList VALUES ('USG', 100)
INSERT INTO MedProceduresList VALUES ('Morfology basic set', 180)
INSERT INTO MedProceduresList VALUES ('Morfology full set', 300)
INSERT INTO MedProceduresList VALUES ('Dental extractions', 40)
