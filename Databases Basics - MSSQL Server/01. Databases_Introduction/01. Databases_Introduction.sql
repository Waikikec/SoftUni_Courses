--Problem 01. Create Database Minions
CREATE DATABASE Minions

USE Minions

--Problem 02. Create Tables Minions and Towns
CREATE TABLE Minions 
(
	Id INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	Age INT
)

--Problem 03. Alter Minions and Towns Table
CREATE TABLE Towns
(
	Id INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL
)

ALTER TABLE Minions
ADD TownId INT
FOREIGN KEY REFERENCES Towns(Id)

--Problem 04. Insert Records in Both Tables
INSERT INTO Towns (Id, [Name]) VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna')

INSERT INTO Minions (Id, [Name], Age, TownId) VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2)

--Problem 05. Truncate Table Minions
DELETE FROM Minions

--Problem 06. Drop All Tables
DROP TABLE Minions
DROP TABLE Towns

--Problem 07. Create Table People
CREATE TABLE People
(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Name] NVARCHAR(200) NOT NULL,
	Picture VARBINARY(MAX), CHECK(DATALENGTH(Picture) <= 2097152),
	Height DECIMAL (12, 2),
	[Weight] DECIMAL (12, 2),
	Gender VARCHAR NOT NULL, CHECK(Gender = 'm' OR Gender = 'f'),
	Birthdate DATE NOT NULL,
	Biography NVARCHAR(MAX)
)

INSERT INTO People([Name], Height, [Weight], Gender, Birthdate, Biography) VALUES
('Martin Yankov1', 1.81, 91, 'm', '1990-03-30', 'I''m an engineer1'),
('Martin Yankov2', 1.82, 92, 'm', '1990-03-30', 'I''m an engineer2'),
('Martin Yankov3', 1.83, 93, 'm', '1990-03-30', 'I''m an engineer3'),
('Martin Yankov4', 1.84, 94, 'm', '1990-03-30', 'I''m an engineer4'),
('Martin Yankov5', 1.85, 95, 'm', '1990-03-30', 'I''m an engineer5')

SELECT * FROM People

--Problem 08. Create Table Users
CREATE TABLE Users
(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	Username VARCHAR(30) NOT NULL,
	[Password] VARCHAR(30) NOT NULL,
	ProfilePicture VARBINARY(MAX), CHECK(DATALENGTH(ProfilePicture) <= 921600),
	LastLoginTime DATETIME2,
	IsDeleted BIT NOT NULL	   
)

INSERT INTO Users(Username, [Password], IsDeleted) VALUES
('Martin Yankov1', 'MAR1', 0),
('Martin Yankov2', 'MAR2', 1),
('Martin Yankov3', 'MAR3', 1),
('Martin Yankov4', 'MAR4', 0),
('Martin Yankov5', 'MAR5', 0)

--Problem 9-- Change primary key
ALTER TABLE Users
DROP CONSTRAINT PK__Users__3214EC07E4B7C349

ALTER TABLE Users
ADD CONSTRAINT PK_Composite_Id_Username
PRIMARY KEY(Id, Username)

--Problem 10. Add Check Constraint
ALTER TABLE Users
ADD CONSTRAINT CHK_LengthPass
CHECK(LEN([Password]) >= 5)

--Problem 11. Set Default Value of a Field
ALTER TABLE Users
ADD CONSTRAINT DF_LastLoginTime
DEFAULT GETDATE() FOR LastLoginTime

--Problem 12. Set Unique Field
ALTER TABLE Users
DROP CONSTRAINT PK_Composite_Id_Username

ALTER TABLE Users
ADD CONSTRAINT PK_Id
PRIMARY KEY(Id)

ALTER TABLE Users
ADD CONSTRAINT CHK_MinUserName
CHECK(LEN(Username) >= 3)

INSERT INTO Users(Username,[Password], IsDeleted) VALUES
('Marto', '1235678', 0)

--Problem 13. Movies Database
CREATE DATABASE Movies

USE Movies

CREATE TABLE Directors
(
	Id INT PRIMARY KEY IDENTITY,
	DirectorName VARCHAR(30) NOT NULL,
	Notes NVARCHAR(MAX)
)

CREATE TABLE Genres
(
	Id INT PRIMARY KEY IDENTITY,
	GenreName VARCHAR(30) NOT NULL,
	Notes NVARCHAR(MAX)
)

CREATE TABLE Categories
(
	Id INT PRIMARY KEY IDENTITY,
	CategoryName VARCHAR(30) NOT NULL,
	Notes NVARCHAR(MAX)
)

CREATE TABLE Movies
(
	Id INT PRIMARY KEY IDENTITY,
	Title VARCHAR(30) NOT NULL,
	DirectorId INT FOREIGN KEY REFERENCES Directors(Id),
	CopyrightYear VARCHAR(4) NOT NULL,
	[Length] INT,
	GenreId INT FOREIGN KEY REFERENCES Genres(Id),
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
	Rating DECIMAL (2,1) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO Directors(DirectorName, Notes) VALUES
('Pesho', 'Glaven Direktor'),
('Mitko', 'Pod Direktor'),
('Dancho','Direktor Komediq'),
('Gosho', 'Direktor Drama'),
('Dimcho','Direktor Satira')

INSERT INTO Genres(GenreName, Notes) VALUES
('Classic', 'Classic FM-Radio'),
('Rock', 'Rock Radio BG'),
('Gospel', 'Gospel Worship Radio'),
('Jazz', 'Jazz is EVERGREEN'),
('Retro', 'Retro Forever')

INSERT INTO Categories (CategoryName, Notes) VALUES
('Action', '---'),
('Horor', '---'),
('Drama', '---'),
('Fantasy', '---'),
('History', '---')

INSERT INTO Movies (Title, CopyrightYear, Rating, Notes) VALUES
('Avengers-1', 2009, 7.5, 'sredna rabota'),
('Avengers-2', 2010, 8.5, 'otlichen'),
('Avengers-3', 2011, 9.5, 'boza'),
('Avengers-4', 2012, 1.5, 'ekstra e'),
('Avengers-5', 2013, 2.5, 'biva')

SELECT * FROM Categories
SELECT * FROM Directors
SELECT * FROM Genres
SELECT * FROM Movies

--Problem 14. Car Rental Database
CREATE DATABASE CarRental

USE CarRental

CREATE TABLE Categories
(
	Id INT PRIMARY KEY IDENTITY,
	CategoryName VARCHAR(30) UNIQUE NOT NULL,
	DailyRate INT,
	WeeklyRate INT,
	MonthlyRate INT,
	WeekendRate INT
)

CREATE TABLE Cars 
(
	Id INT PRIMARY KEY IDENTITY,
	PlateNumber VARCHAR(30) NOT NULL,
	Manufacturer VARCHAR(30) NOT NULL,
	Model VARCHAR(50) NOT NULL, 
	CarYear VARCHAR(4) NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
	Doors INT NOT NULL,
	Picture VARBINARY(MAX),
	Condition VARCHAR(30),
	Available BIT
)

CREATE TABLE Employees 
(
	Id INT PRIMARY KEY IDENTITY, 
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	Title VARCHAR(30) NOT NULL,
	Notes NVARCHAR(MAX)
)

CREATE TABLE Customers
(
	Id INT PRIMARY KEY IDENTITY, 
	DriverLicenceNumber VARCHAR(30) NOT NULL, 
	FullName VARCHAR(50) NOT NULL,
	[Address] VARCHAR(50) NOT NULL,
	City VARCHAR(30) NOT NULL, 
	ZIPCode INT NOT NULL, 
	Notes NVARCHAR(MAX)
)

CREATE TABLE RentalOrders 
(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
	CustomerId INT FOREIGN KEY REFERENCES Customers(Id), 
	CarId INT FOREIGN KEY REFERENCES Cars(Id), 
	TankLevel INT NOT NULL, 
	KilometrageStart INT NOT NULL, 
	KilometrageEnd INT NOT NULL, 
	TotalKilometrage INT NOT NULL,
	StartDate DATETIME NOT NULL,
	EndDate DATETIME NOT NULL, 
	TotalDays INT NOT NULL,
	RateApplied DECIMAL(16,2) NOT NULL, 
	TaxRate DECIMAL(16,2) NOT NULL,
	OrderStatus VARCHAR(30) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO Categories(CategoryName) VALUES
('SUV'),
('Motors'),
('Jeep')

INSERT INTO Cars(PlateNumber, Manufacturer, Model, CarYear, Doors, Condition) VALUES
('CT 2965 KB-1', 'FORD-1', 'Mustang-1', 2009, 4, 'new'),
('CT 2965 KB-2', 'FORD-2', 'Mustang-2', 2010, 4, 'new'),
('CT 2965 KB-3', 'FORD-3', 'Mustang-3', 2011, 4, 'new')

INSERT INTO Employees(FirstName, LastName, Title) VALUES
('Martin', 'Yankov', 'Bus Driver'),
('Martincho', 'Yankovche', 'Car Driver'),
('Martineli', 'Yankoveli', 'Wave Driver')

INSERT INTO Customers(DriverLicenceNumber, FullName, City, [Address], ZIPCode) VALUES
('12345', 'Pesho Peshev1', 'Georgi Baidanov-1', 'Stara Zagora', 6000),
('1234567', 'Pesho Peshev2', 'Georgi Baidanov-2', 'Nova Zagora', 1220),
('123456789', 'Pesho Peshev3', 'Georgi Baidanov-3', 'Gabrovo', 1000)

INSERT INTO RentalOrders(TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage,
StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus) VALUES
(50, 10120, 151240, 12312313, '2019-01-05', '2019-01-10', 4, 22313.23, 212.631232, 'Proccessing'),
(5123, 123100, 151240, 12312313,  '2019-01-12', '2019-01-10', 3, 21.23, 123.4532, 'Done'),
(51234, 10124120, 1500, 12312313, '2019-01-18', '2019-01-10', 5,  21.23, 24.332, 'In Progress')

--Problem 15. Hotel Database
CREATE DATABASE Hotel

USE Hotel

CREATE TABLE Employees
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30) NOT NULL, 
	Title NVARCHAR(30) NOT NULL,
	Notes TEXT
)

INSERT INTO Employees(FirstName, LastName, Title) VALUES
('Martin', 'Yankov', '3D Artist'),
('Martin1', 'Yankov1', '3D Artist-1'),
('Martin2', 'Yankov2', '3D Artist-2')

CREATE TABLE Customers
(
	AccountNumber CHAR(4) PRIMARY KEY, 
	FirstName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
	PhoneNumber INT NOT NULL,
	EmergencyName NVARCHAR(30) NOT NULL,
	EmergencyNumber INT NOT NULL,
	Notes TEXT
)

INSERT INTO Customers(AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber) VALUES
('AN01', 'Reni1', 'Stambolova1', 0896188094, 'Radi1', 0888668724),
('AN02', 'Reni2', 'Stambolova2', 0896188095, 'Radi2', 0888668734),
('AN03', 'Reni3', 'Stambolova3', 0896188096, 'Radi3', 0888662224)

CREATE TABLE RoomStatus
(
	RoomStatus NVARCHAR(30) PRIMARY KEY, 
	Notes TEXT
)

INSERT INTO RoomStatus(RoomStatus) VALUES
('Free'),
('Hired'),
('Reserved')

CREATE TABLE RoomTypes
(
	RoomType NVARCHAR(30) PRIMARY KEY, 
	Notes TEXT
)

INSERT INTO RoomTypes(RoomType) VALUES
('Ordinary'),
('Luxury'),
('President')

CREATE TABLE BedTypes
(
	BedType NVARCHAR(30) PRIMARY KEY, 
	Notes TEXT
)

INSERT INTO BedTypes(BedType) VALUES
('One'),
('Two'),
('Bedroom')

CREATE TABLE Rooms
(
	RoomNumber VARCHAR(5) PRIMARY KEY, 
	RoomType NVARCHAR(30) FOREIGN KEY REFERENCES RoomTypes(RoomType), 
	BedType NVARCHAR(30) FOREIGN KEY REFERENCES BedTypes(BedType),
	Rate INT, 
	RoomStatus NVARCHAR(30) FOREIGN KEY REFERENCES RoomStatus(RoomStatus),
	Notes TEXT
)

INSERT INTO Rooms(RoomNumber, RoomType, BedType, RoomStatus) VALUES
('111-A', 'Ordinary', 'One', 'Free'),
('333-B', 'Luxury', 'Two', 'Hired'),
('777-C', 'President', 'Bedroom', 'Reserved')

CREATE TABLE Payments
(
	Id INT PRIMARY KEY IDENTITY, 
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL, 
	PaymentDate DATETIME2,
	AccountNumber CHAR(4) FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL,
	FirstDateOccupied DATETIME,
	LastDateOccupied DATETIME,
	TotalDays INT,
	AmountCharged DECIMAL(10,2),
	TaxRate DECIMAL(10,2),
	TaxAmount DECIMAL(10,2),
	PaymentTotal DECIMAL(10,2),
	Notes TEXT
)

INSERT INTO Payments(EmployeeId, AccountNumber) VALUES
(1, 'AN01'),
(2, 'AN02'),
(3, 'AN03')

CREATE TABLE Occupancies
(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id), 
	DateOccupied DATETIME2, 
	AccountNumber CHAR(4) FOREIGN KEY REFERENCES Customers(AccountNumber), 
	RoomNumber VARCHAR(5) FOREIGN KEY REFERENCES Rooms(RoomNumber), 
	RateApplied BIT, 
	PhoneCharge BIT,
	Notes TEXT
)

INSERT INTO Occupancies(EmployeeId, AccountNumber, RoomNumber) VALUES
(1, 'AN01', '111-A'),
(2, 'AN02', '333-B'),
(3, 'AN03', '777-C')

SELECT * FROM Employees
SELECT * FROM Customers
SELECT * FROM RoomStatus
SELECT * FROM RoomTypes
SELECT * FROM BedTypes
SELECT * FROM Rooms
SELECT * FROM Payments
SELECT * FROM Occupancies

--Problem 16. SoftUni Database
CREATE DATABASE SoftUni

USE SoftUni

CREATE TABLE Towns
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(30) NOT NULL
)

CREATE TABLE Addresses 
(
	Id INT PRIMARY KEY IDENTITY(1,1), 
	AddressText VARCHAR(50), 
	TownId INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL
)

CREATE TABLE Departments
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(30) NOT NULL
)

CREATE TABLE Employees 
(
	Id INT PRIMARY KEY IDENTITY(1,1), 
	FirstName NVARCHAR(30) NOT NULL,
	MiddleName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
	JobTitle NVARCHAR(30) NOT NULL, 
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id), 
	HireDate DATETIME2 NOT NULL, 
	Salary DECIMAL(12,2),
	AddressId INT FOREIGN KEY REFERENCES Addresses(Id)
)
--Problem 17.Backup Database
--https://support.microsoft.com/en-gb/help/2019698/how-to-schedule-and-automate-backups-of-sql-server-databases-in-sql-se

--Problem 18.Basic Insert
INSERT INTO Towns([Name]) VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas')

INSERT INTO Departments([Name]) VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance')

INSERT INTO Employees(FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary) VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88)

--Problem 19.Basic Select All Fields
SELECT * FROM Towns
SELECT * FROM Departments
SELECT * FROM Employees

--Problem 20.Basic Select All Fields and Order Them
SELECT * FROM Towns
ORDER BY [Name] ASC

SELECT * FROM Departments
ORDER BY [Name] ASC

SELECT * FROM Employees
ORDER BY Salary DESC

--Problem 21.Basic Select Some Fields
SELECT [Name] FROM Towns
ORDER BY [Name] ASC

SELECT [Name] FROM Departments
ORDER BY [Name] ASC

SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC

--Problem 22.Increase Employees Salary
UPDATE Employees
SET Salary *= 1.10

SELECT Salary FROM Employees

--Problem 23.Decrease Tax Rate
USE Hotel

UPDATE Payments
SET TaxRate -= 0.03

SELECT TaxRate FROM Payments

--Problem 24.Delete All Records
USE Hotel

TRUNCATE TABLE Occupancies