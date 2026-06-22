-- Create database
IF DB_ID('Northwind') IS NULL
CREATE DATABASE Northwind;
GO

USE Northwind;
GO

-- Drop tables if they exist
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Suppliers;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Shippers;
GO


-- Customers
CREATE TABLE Customers
(
    CustomerID INT IDENTITY PRIMARY KEY,
    CompanyName NVARCHAR(100),
    ContactName NVARCHAR(100),
    City NVARCHAR(50),
    Province NVARCHAR(50)
);
GO


-- Employees
CREATE TABLE Employees
(
    EmployeeID INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    City NVARCHAR(50),
    Country NVARCHAR(50)
);
GO


-- Shippers
CREATE TABLE Shippers
(
    ShipperID INT IDENTITY PRIMARY KEY,
    CompanyName NVARCHAR(100)
);
GO


-- Categories
CREATE TABLE Categories
(
    CategoryID INT IDENTITY PRIMARY KEY,
    CategoryName NVARCHAR(100)
);
GO


-- Suppliers
CREATE TABLE Suppliers
(
    SupplierID INT IDENTITY PRIMARY KEY,
    CompanyName NVARCHAR(100),
    City NVARCHAR(50),
    Province NVARCHAR(50)
);
GO


-- Products
CREATE TABLE Products
(
    ProductID INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(100),
    SupplierID INT,
    CategoryID INT,
    UnitPrice DECIMAL(10,2),
    UnitsInStock INT,

    CONSTRAINT FK_Product_Supplier
    FOREIGN KEY (SupplierID)
    REFERENCES Suppliers(SupplierID)
    ON DELETE CASCADE,

    CONSTRAINT FK_Product_Category
    FOREIGN KEY (CategoryID)
    REFERENCES Categories(CategoryID)
    ON DELETE CASCADE
);
GO


-- Orders
CREATE TABLE Orders
(
    OrderID INT IDENTITY PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE,
    ShipVia INT,

    CONSTRAINT FK_Order_Customer
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
    ON DELETE CASCADE,

    CONSTRAINT FK_Order_Employee
    FOREIGN KEY (EmployeeID)
    REFERENCES Employees(EmployeeID)
    ON DELETE CASCADE,

    CONSTRAINT FK_Order_Shipper
    FOREIGN KEY (ShipVia)
    REFERENCES Shippers(ShipperID)
    ON DELETE CASCADE
);
GO


-- Order Details (Many-to-many: Orders ↔ Products)
CREATE TABLE OrderDetails
(
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),

    PRIMARY KEY (OrderID, ProductID),

    CONSTRAINT FK_OrderDetails_Order
    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID)
    ON DELETE CASCADE,

    CONSTRAINT FK_OrderDetails_Product
    FOREIGN KEY (ProductID)
    REFERENCES Products(ProductID)
    ON DELETE CASCADE
);
GO


-- Customers
INSERT INTO Customers (CompanyName, ContactName, City, Province) VALUES
('Maple Foods','John Smith','Toronto','Ontario'),
('Pacific Imports','Alice Brown','Vancouver','British Columbia'),
('Prairie Market','David Lee','Calgary','Alberta'),
('Atlantic Grocers','Sarah White','Halifax','Nova Scotia'),
('Northern Traders','Robert Green','Winnipeg','Manitoba'),
('Capital Grocers','Emily Clark','Ottawa','Ontario'),
('Rocky Mountain Foods','Daniel Hall','Banff','Alberta'),
('West Coast Market','Sophia Turner','Victoria','British Columbia'),
('Lakeside Grocers','Michael Adams','Hamilton','Ontario'),
('Maritime Foods','Olivia Scott','Charlottetown','Prince Edward Island');
GO


-- Employees
INSERT INTO Employees (FirstName, LastName, City, Country) VALUES
('Nancy','Davolio','Seattle','USA'),
('Andrew','Fuller','Tacoma','USA'),
('Janet','Leverling','Toronto','Canada'),
('Margaret','Peacock','Vancouver','Canada'),
('Steven','Buchanan','London','UK'),
('Michael','Suyama','Manchester','UK'),
('Robert','King','Edinburgh','UK'),
('Laura','Callahan','Montreal','Canada'),
('Anne','Dodsworth','Calgary','Canada'),
('Peter','Hall','Seattle','USA');
GO


-- Shippers
INSERT INTO Shippers (CompanyName) VALUES
('Canada Post'),
('Purolator'),
('FedEx Canada'),
('UPS Canada'),
('DHL Canada'),
('Canpar Express'),
('Loomis Express'),
('Day & Ross'),
('ICS Courier'),
('Nationex');
GO


-- Categories
INSERT INTO Categories (CategoryName) VALUES
('Beverages'),
('Dairy'),
('Produce'),
('Snacks'),
('Frozen Foods'),
('Bakery'),
('Seafood'),
('Meat'),
('Condiments'),
('Grains');
GO


-- Suppliers
INSERT INTO Suppliers (CompanyName, City, Province) VALUES
('Ontario Farms','London','Ontario'),
('BC Fresh','Kelowna','British Columbia'),
('Alberta Dairy','Edmonton','Alberta'),
('Prairie Produce','Regina','Saskatchewan'),
('Atlantic Seafood','Halifax','Nova Scotia'),
('Maple Leaf Foods','Toronto','Ontario'),
('Golden Bakery','Montreal','Quebec'),
('Pacific Fisheries','Vancouver','British Columbia'),
('Northern Grains','Winnipeg','Manitoba'),
('Capital Condiments','Ottawa','Ontario');
GO


-- Products
INSERT INTO Products (ProductName, SupplierID, CategoryID, UnitPrice, UnitsInStock) VALUES
('Apples',2,3,4.20,150),
('Bananas',2,3,2.80,170),
('Maple Syrup',1,9,12.50,120),
('Cheddar Cheese',3,2,8.75,80),
('Milk 1L',3,2,3.20,200),
('Potato Chips',1,4,3.50,140),
('Frozen Pizza',6,5,9.99,90),
('Butter Croissant',7,6,2.40,110),
('Salmon Fillet',8,7,14.50,60),
('Beef Steak',6,8,18.75,50),
('Ketchup',10,9,3.10,130),
('Mustard',10,9,2.95,120),
('Whole Wheat Bread',7,6,3.60,100),
('Frozen Peas',4,5,4.10,95),
('Orange Juice',2,1,4.75,140),
('Coffee Beans',1,1,11.25,70),
('Yogurt',3,2,5.50,160),
('Rice 1kg',9,10,6.40,180),
('Pasta',9,10,3.95,175),
('Crackers',1,4,3.30,150);
GO


-- Orders
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, ShipVia) VALUES
(1,1,'2025-01-10',1),
(2,2,'2025-02-05',2),
(3,3,'2025-03-01',3),
(4,4,'2025-03-12',4),
(5,5,'2025-03-20',5),
(6,6,'2025-04-02',1),
(7,7,'2025-04-15',2),
(8,8,'2025-05-01',3),
(9,9,'2025-05-12',4),
(10,10,'2025-05-20',5);
GO


-- OrderDetails
INSERT INTO OrderDetails VALUES
(1,1,5,12.50),
(1,2,2,8.75),
(2,3,10,3.20),
(2,4,8,4.20),
(3,6,6,3.50),
(3,7,3,9.99),
(4,10,2,18.75),
(5,8,10,2.40),
(6,15,4,4.75),
(7,18,5,6.40),
(8,19,7,3.95),
(9,20,8,3.30),
(10,5,12,2.80);
GO
