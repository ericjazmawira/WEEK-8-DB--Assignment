-- Create and use the database
CREATE DATABASE timetable_ke;
USE timetable_ke;

-- Classes Table
CREATE TABLE Classes (
    ClassID INT PRIMARY KEY AUTO_INCREMENT,
    ClassName VARCHAR(50) NOT NULL UNIQUE,
    Stream VARCHAR(20)
);

-- Students Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    AdmissionNumber VARCHAR(20) UNIQUE NOT NULL,
    Gender ENUM('Male', 'Female') NOT NULL,
    DateOfBirth DATE,
    ClassID INT,
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

-- Teachers Table
CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    TSCNumber VARCHAR(20) UNIQUE NOT NULL,
    Gender ENUM('Male', 'Female') NOT NULL,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100)
);

-- Classrooms Table (e.g., Lab 1, Room A1)
CREATE TABLE Classrooms (
    RoomID INT PRIMARY KEY AUTO_INCREMENT,
    RoomName VARCHAR(50) NOT NULL UNIQUE,
    Capacity INT NOT NULL
);

-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

-- Subjects Table 
CREATE TABLE Subjects (
    SubjectID INT PRIMARY KEY AUTO_INCREMENT,
    SubjectName VARCHAR(100) NOT NULL UNIQUE,
    DepartmentID INT NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- TeacherAssignments Table
CREATE TABLE TeacherAssignments (
    AssignmentID INT PRIMARY KEY AUTO_INCREMENT,
    SubjectID INT NOT NULL,
    TeacherID INT NOT NULL,
    ClassID INT NOT NULL,
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID),
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID),
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

-- Timetable Table
CREATE TABLE Timetable (
    SlotID INT PRIMARY KEY AUTO_INCREMENT,
    AssignmentID INT NOT NULL,
    RoomID INT NOT NULL,
    DayOfWeek ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'),
    StartTime TIME,
    EndTime TIME,
    FOREIGN KEY (AssignmentID) REFERENCES TeacherAssignments(AssignmentID),
    FOREIGN KEY (RoomID) REFERENCES Classrooms(RoomID)
);

-- Enrollments Table
CREATE TABLE Enrollments (
    StudentID INT NOT NULL,
    SubjectID INT NOT NULL,
    PRIMARY KEY (StudentID, SubjectID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

-- Insert data into Departments table
INSERT INTO Departments (DepartmentName) 
VALUES ('Languages'), ('Sciences'), ('Technicals');

INSERT INTO Classes (ClassName, Stream) 
VALUES 
('Form 1', 'Science'),
('Form 2', 'Commerce'),
('Form 3', 'Technical'),
('Form 4', 'Humanities');

-- Insert data into Teachers table
INSERT INTO Teachers (FullName, TSCNumber, Gender, PhoneNumber, Email)
VALUES 
('Jane Wambui', 'TSC123456', 'Female', '0712345678', 'jane.wambui@example.com'),
('John Mwangi', 'TSC789101', 'Male', '0723456789', 'john.mwangi@example.com'),
('Maria Njeri', 'TSC112233', 'Female', '0734567890', 'maria.njeri@example.com'),
('Peter Otieno', 'TSC445566', 'Male', '0745678901', 'peter.otieno@example.com');

-- Insert into Classrooms table
INSERT INTO Classrooms (RoomName, Capacity) 
VALUES 
('Lab 1', 30),
('Room A1', 40),
('Room B2', 35),
('Library', 50);

-- Insert data into Subjects table
INSERT INTO Subjects (SubjectName, DepartmentID) 
VALUES 
('Mathematics', 2),
('English', 1),
('Physics', 2),
('Geography', 1),
('Chemistry', 2),
('History', 1),
('Business Studies', 3),
('Agriculture', 3);

-- Insert into TeacherAssignments table
INSERT INTO TeacherAssignments (SubjectID, TeacherID, ClassID) 
VALUES 
(1, 1, 1),  -- Mathematics, Jane Wambui, Form 1
(2, 2, 2),  -- English, John Mwangi, Form 2
(3, 3, 3),  -- Physics, Maria Njeri, Form 3
(4, 4, 4),  -- Geography, Peter Otieno, Form 4
(5, 1, 1),  -- Chemistry, Jane Wambui, Form 1
(6, 2, 2),  -- History, John Mwangi, Form 2
(7, 3, 3),  -- Business Studies, Maria Njeri, Form 3
(8, 4, 4);  -- Agriculture, Peter Otieno, Form 4

-- Insert into Timetable table
INSERT INTO Timetable (AssignmentID, RoomID, DayOfWeek, StartTime, EndTime) 
VALUES 
(1, 1, 'Monday', '08:00:00', '09:00:00'),  -- Math with Jane Wambui in Lab 1 on Monday
(2, 2, 'Tuesday', '09:00:00', '10:00:00'),  -- English with John Mwangi in Room A1 on Tuesday
(3, 3, 'Wednesday', '10:00:00', '11:00:00'),  -- Physics with Maria Njeri in Room B2 on Wednesday
(4, 4, 'Thursday', '11:00:00', '12:00:00'),  -- Geography with Peter Otieno in Library on Thursday
(5, 1, 'Friday', '08:00:00', '09:00:00'),  -- Chemistry with Jane Wambui in Lab 1 on Friday
(6, 2, 'Monday', '09:00:00', '10:00:00'),  -- History with John Mwangi in Room A1 on Monday
(7, 3, 'Tuesday', '10:00:00', '11:00:00'),  -- Business Studies with Maria Njeri in Room B2 on Tuesday
(8, 4, 'Wednesday', '11:00:00', '12:00:00');  -- Agriculture with Peter Otieno in Library on Wednesday

-- Insert into Students table
INSERT INTO Students (FullName, AdmissionNumber, Gender, DateOfBirth, ClassID) 
VALUES 
('Peter Kamau', 'STU001', 'Male', '2006-05-12', 1),
('Mary Njeri', 'STU002', 'Female', '2006-07-23', 2),
('Samuel Mwangi', 'STU003', 'Male', '2006-09-18', 3),
('Grace Wambui', 'STU004', 'Female', '2006-03-30', 4);

-- Insert into Enrollments table
INSERT INTO Enrollments (StudentID, SubjectID) 
VALUES 
(1, 1),  -- Peter Kamau, Mathematics
(1, 5),  -- Peter Kamau, Chemistry
(2, 2),  -- Mary Njeri, English
(2, 6),  -- Mary Njeri, History
(3, 3),  -- Samuel Mwangi, Physics
(3, 7),  -- Samuel Mwangi, Business Studies
(4, 4),  -- Grace Wambui, Geography
(4, 8);  -- Grace Wambui, Agriculture

