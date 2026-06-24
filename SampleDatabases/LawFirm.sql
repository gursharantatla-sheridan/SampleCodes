-- Create LawFirm Database
IF DB_ID('LawFirm') IS NULL
CREATE DATABASE LawFirm;
GO

USE LawFirm;
GO


-- Attorneys Table
CREATE TABLE Attorneys
(
    AttorneyID INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Telephone NVARCHAR(50)
);
GO


-- Clients Table
CREATE TABLE Clients
(
    ClientID INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    StreetAddress NVARCHAR(100),
    City NVARCHAR(50),
    Province NVARCHAR(50),
    PostalCode NVARCHAR(20),
    Telephone NVARCHAR(50)
);
GO


-- Categories Table
CREATE TABLE Categories
(
    CategoryID NVARCHAR(10) PRIMARY KEY,
    CategoryName NVARCHAR(50)
);
GO


-- Rates Table
CREATE TABLE Rates
(
    RateID INT IDENTITY PRIMARY KEY,
    HourlyRate MONEY
);
GO


-- Billing Table
CREATE TABLE Billing
(
    BillingID INT IDENTITY PRIMARY KEY,
    ClientID INT,
    BillingDate DATE,
    CategoryID NVARCHAR(10),
    Hours DECIMAL(5,2),
    RateID INT,
    AttorneyID INT,


    CONSTRAINT FK_Billing_Client
    FOREIGN KEY(ClientID)
    REFERENCES Clients(ClientID)
    ON DELETE CASCADE,


    CONSTRAINT FK_Billing_Attorney
    FOREIGN KEY(AttorneyID)
    REFERENCES Attorneys(AttorneyID)
    ON DELETE CASCADE,


    CONSTRAINT FK_Billing_Category
    FOREIGN KEY(CategoryID)
    REFERENCES Categories(CategoryID)
    ON DELETE CASCADE,


    CONSTRAINT FK_Billing_Rate
    FOREIGN KEY(RateID)
    REFERENCES Rates(RateID)
    ON DELETE CASCADE
);
GO


-- Add data to Attorneys table
INSERT INTO Attorneys VALUES
('Thomas','Zieger','253-555-9632'),
('Marjorie','Shaw','253-555-9612'),
('Kathleen','Jordan','253-555-9679'),
('Daniel','McKay','253-555-9682');


-- Add data to Categories table
INSERT INTO Categories VALUES
('A','Adoption'),
('CC','Child Custody'),
('CV','Child Visitation'),
('D','Divorce'),
('G','Guardianship'),
('IN','Incorporation'),
('P','Paternity'),
('SE','Support Enforcement');


-- Add data to Rates table
INSERT INTO Rates VALUES
(200),
(250),
(300),
(325),
(350);


-- Add data to Clients table
INSERT INTO Clients (FirstName, LastName, StreetAddress, City, Province, PostalCode, Telephone) 
VALUES ('Margaret','Kasper','402 King Street','Toronto','Ontario','M5V2T6','416-555-9003'),
('Haley','Brown','321 Queen Street','Ottawa','Ontario','K1P1J1','613-555-3948'),
('Kevin','Stein','120 Main Street','Vancouver','British Columbia','V6B1A1','604-555-2980'),
('Doris','Sturtevant','55 Lake Road','Calgary','Alberta','T2P2M5','403-555-3120'),
('Maddie','Singh','450 Maple Avenue','Mississauga','Ontario','L5B3Y4','905-555-6673');


-- Add data to Billing table
INSERT INTO Billing
(ClientID,BillingDate,CategoryID,Hours,RateID,AttorneyID)
VALUES
(1,'2025-06-01','D',2,3,2),
(2,'2025-06-01','CC',1.5,4,3),
(3,'2025-06-02','IN',3,2,4),
(4,'2025-06-03','G',1,3,1),
(5,'2025-06-04','SE',2.5,1,2);
