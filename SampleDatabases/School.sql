-- Create School Database
IF DB_ID('School') IS NULL
CREATE DATABASE School;
GO

USE School;
GO

-- Drop tables if they exist
DROP TABLE IF EXISTS StudentCourse;
DROP TABLE IF EXISTS StudentAddress;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Teacher;
DROP TABLE IF EXISTS Standard;
GO

-- Table: Standard
CREATE TABLE Standard (
    StandardId INT IDENTITY(1,1) PRIMARY KEY,
    StandardName NVARCHAR(50),
    Description NVARCHAR(50)
);
GO

-- Table: Teacher
CREATE TABLE Teacher (
    TeacherId INT IDENTITY(1,1) PRIMARY KEY,
    TeacherName NVARCHAR(50),
    StandardId INT
);
GO

-- Table: Course
CREATE TABLE Course (
    CourseId INT IDENTITY(1,1) PRIMARY KEY,
    CourseName NVARCHAR(50),
    TeacherId INT
);
GO

-- Table: Student
CREATE TABLE Student (
    StudentId INT IDENTITY(1,1) PRIMARY KEY,
    StudentName NVARCHAR(50),
    StandardId INT
);
GO

-- Table: StudentAddress
CREATE TABLE StudentAddress (
    StudentId INT PRIMARY KEY,
    Address1 NVARCHAR(50),
    Address2 NVARCHAR(50),
    City NVARCHAR(50),
    Province NVARCHAR(50)
);
GO

-- Table: StudentCourse
CREATE TABLE StudentCourse (
    StudentId INT,
    CourseId INT,
    PRIMARY KEY (StudentId, CourseId)
);
GO

-- Insert data into Standard
SET IDENTITY_INSERT Standard ON;

INSERT INTO Standard (StandardId, StandardName, Description) VALUES
(1, 'Standard 1', 'Grade 1'),
(2, 'Standard 2', 'Grade 2'),
(3, 'Standard 3', 'Grade 3'),
(4, 'Standard 4', 'Grade 4'),
(5, 'Standard 5', 'Grade 5'),
(6, 'Standard 6', 'Grade 6'),
(7, 'Standard 7', 'Grade 7'),
(8, 'Standard 8', 'Grade 8'),
(9, 'Standard 9', 'Grade 9');

SET IDENTITY_INSERT Standard OFF;
GO

-- Insert data into Teacher
SET IDENTITY_INSERT Teacher ON;

INSERT INTO Teacher (TeacherId, TeacherName, StandardId) VALUES
(1, 'Newton', 9),
(2, 'Kalidas', 8),
(3, 'John', 7),
(4, 'James', 3),
(5, 'Ravi', 4),
(6, 'Amir', 5),
(7, 'Bjarne', 6),
(8, 'Tomy', 1),
(9, 'Chris', 2),
(10, 'Brian', 2);

SET IDENTITY_INSERT Teacher OFF;
GO

-- Insert data into Course
SET IDENTITY_INSERT Course ON;

INSERT INTO Course (CourseId, CourseName, TeacherId) VALUES
(1, 'Maths', 1),
(2, 'Science', 2),
(3, 'History', 3),
(4, 'English', 4),
(5, 'Spanish', 5),
(6, 'Computer Science', 6);

SET IDENTITY_INSERT Course OFF;
GO

-- Insert data into Student
SET IDENTITY_INSERT Student ON;

INSERT INTO Student (StudentId, StudentName, StandardId) VALUES
(1, 'Bill', 2),
(2, 'Steve', 2),
(3, 'James', 4),
(4, 'Tim', 1),
(5, 'Rama', 3),
(6, 'Mohan', 5),
(7, 'Merry', 6),
(8, 'Kapil', 7),
(9, 'Imran', 8),
(10, 'Don', 9);

SET IDENTITY_INSERT Student OFF;
GO

-- Insert student addresses
INSERT INTO StudentAddress (StudentId, Address1, Address2, City, Province) VALUES
(1, '25 King St W', NULL, 'Toronto', 'Ontario'),
(4, '1200 Robson St', 'Apt 405', 'Vancouver', 'British Columbia');
GO

-- Foreign key relationships
ALTER TABLE Course 
ADD CONSTRAINT FK_Course_Teacher 
FOREIGN KEY (TeacherId) REFERENCES Teacher (TeacherId) ON DELETE CASCADE;

ALTER TABLE Student 
ADD CONSTRAINT FK_Student_Standard 
FOREIGN KEY (StandardId) REFERENCES Standard (StandardId) ON DELETE CASCADE;

ALTER TABLE StudentAddress 
ADD CONSTRAINT FK_StudentAddress_Student 
FOREIGN KEY (StudentId) REFERENCES Student (StudentId) ON DELETE CASCADE;

ALTER TABLE StudentCourse 
ADD CONSTRAINT FK_StudentCourse_Course 
FOREIGN KEY (CourseId) REFERENCES Course (CourseId);

ALTER TABLE StudentCourse 
ADD CONSTRAINT FK_StudentCourse_Student 
FOREIGN KEY (StudentId) REFERENCES Student (StudentId) ON DELETE CASCADE;

ALTER TABLE Teacher 
ADD CONSTRAINT FK_Teacher_Standard 
FOREIGN KEY (StandardId) REFERENCES Standard (StandardId) ON DELETE CASCADE;
GO
