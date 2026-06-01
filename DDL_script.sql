-- INITIALIZE FRESH DATABASE INFRASTRUCTURE
USE master;
GO

-- CREATE DB, DROP IF EXISTS
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'NP40Intern')
BEGIN
    ALTER DATABASE NP40Intern SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE NP40Intern;
END
GO
CREATE DATABASE NP40Intern;
GO

-- Point the SQL server engine context to our new database container
USE NP40Intern;
GO

-- PROJECT: NP INTERNSHIP MANAGEMENT SYSTEM
-- TARGET RDBMS: Microsoft SQL Server (T-SQL)
-- DATA MODELING COMPLIANCE: 3rd Normal Form (3NF)

-- CLEAR EXISTING TABLES TO ALLOW CLEAN RE-RUNS
DROP TABLE IF EXISTS Placement;
DROP TABLE IF EXISTS Interview;
DROP TABLE IF EXISTS Application;
DROP TABLE IF EXISTS InternshipPosting;
DROP TABLE IF EXISTS Company;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS [User];
GO


-- 1. CORE IDENTITY & SECURITY LAYER (SUPERTYPE CORE)

CREATE TABLE [User] (
    UserID          INT IDENTITY(1,1),
    Username        VARCHAR(50)  NOT NULL,
    HashedPassword  VARCHAR(255) NOT NULL,
    Email           VARCHAR(100) NOT NULL,
    UserType        VARCHAR(15)  NOT NULL,
    
    -- Constraints
    CONSTRAINT PK_User PRIMARY KEY (UserID),
    CONSTRAINT UQ_User_Username UNIQUE (Username),
    CONSTRAINT UQ_User_Email UNIQUE (Email),
    CONSTRAINT CK_User_Type CHECK (UserType IN ('Student', 'Staff', 'Company'))
);
GO


-- 2. SPECIALIZED USER CLASSES (SUBTYPE ENTITIES)

CREATE TABLE Student (
    StudentID      INT,
    StudentName    NVARCHAR(100)  NOT NULL, -- to accomodate to Unicode strings '周杰伦'
    Diploma        NVARCHAR(100)  NOT NULL,
    Dept           NVARCHAR(10)  NOT NULL,
    GPA            DECIMAL(3,2)  NOT NULL,
    
    -- Constraints
    CONSTRAINT PK_Student PRIMARY KEY (StudentID),
    CONSTRAINT FK_Student_User FOREIGN KEY (StudentID) REFERENCES [User](UserID) ON DELETE CASCADE,
    CONSTRAINT CK_Student_GPA CHECK (GPA BETWEEN 0.00 AND 4.00),
    CONSTRAINT CK_Student_Dept CHECK (Dept IN ('ICT', 'BA', 'DE', 'HS', 'FMS'))
);
GO

CREATE TABLE Staff (
    StaffID       INT,
    StaffName     VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(15)  NULL,
    
    -- Constraints
    CONSTRAINT PK_Staff PRIMARY KEY (StaffID),
    CONSTRAINT FK_Staff_User FOREIGN KEY (StaffID) REFERENCES [User](UserID) ON DELETE CASCADE
);
GO

CREATE TABLE Company (
    CompanyID      INT,
    UEN            VARCHAR(12)  NOT NULL,
    CompanyName    VARCHAR(150) NOT NULL,
    IndustrySector VARCHAR(100) NOT NULL,
    
    -- Constraints
    CONSTRAINT PK_Company PRIMARY KEY (CompanyID),
    CONSTRAINT FK_Company_User FOREIGN KEY (CompanyID) REFERENCES [User](UserID) ON DELETE CASCADE,
    CONSTRAINT UQ_Company_UEN UNIQUE (UEN)
);
GO


-- 3. CORPORATE ADVERTISING TIER

CREATE TABLE InternshipPosting (
    PostingID   INT IDENTITY(1,1),
    CompanyID   INT           NOT NULL,
    Title       VARCHAR(150)  NOT NULL,
    Description VARCHAR(MAX)  NOT NULL,
    Vacancy     INT           NOT NULL,
    DatePosted  DATE          NOT NULL DEFAULT GETDATE(), -- Cleaner Inline Default
    
    -- Constraints
    CONSTRAINT PK_InternshipPosting PRIMARY KEY (PostingID),
    CONSTRAINT FK_InternshipPosting_Company FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID),
    ON DELETE NO ACTION, -- Added circuit-breaker to prevent accidental cascade deletes of postings if a company is removed
    CONSTRAINT CK_InternshipPosting_Vacancy CHECK (Vacancy >= 0)
);
GO


-- 4. EVALUATION & TRANSACTION ROUTING TIER

CREATE TABLE Application (
    ApplicationID     INT IDENTITY(1,1),
    StudentID         INT         NOT NULL,
    PostingID         INT         NOT NULL,
    ApplicationDate   DATE        NOT NULL DEFAULT GETDATE(), -- Cleaner Inline Default
    ApplicationStatus VARCHAR(20) NOT NULL DEFAULT 'Applied', -- Cleaner Inline Default
    
    -- Constraints
    CONSTRAINT PK_Application PRIMARY KEY (ApplicationID),
    CONSTRAINT FK_Application_Student FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    ON DELETE NO ACTION, -- Added data preservation rule to prevent cascade deletes of applications if a student is removed
    CONSTRAINT FK_Application_Posting FOREIGN KEY (PostingID) REFERENCES InternshipPosting(PostingID),
    ON DELETE NO ACTION, -- Added data preservation rule to prevent cascade deletes of applications if a posting is removed
    CONSTRAINT CK_Application_Status CHECK (ApplicationStatus IN ('Applied', 'Shortlisted', 'Offered', 'Rejected'))
);
GO

CREATE TABLE Interview (
    InterviewID   INT IDENTITY(1,1),
    ApplicationID INT         NOT NULL,
    StaffID INT               NOT NULL,
    InterviewDate DATETIME2   NOT NULL,
    InterviewType VARCHAR(50) NOT NULL,
    Outcome       VARCHAR(20) NOT NULL DEFAULT 'Pending', -- Cleaner Inline Default
    
    -- Constraints
    CONSTRAINT PK_Interview PRIMARY KEY (InterviewID),
    CONSTRAINT FK_Interview_Application FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID) ON DELETE CASCADE,
    CONSTRAINT FK_Interview_Staff FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
    CONSTRAINT CK_Interview_Outcome CHECK (Outcome IN ('Pending', 'Passed', 'Failed'))
);
GO


-- 5. INSTITUTIONAL DEPLOYMENT & GRADING TIER (3NF COMPLIANT)

CREATE TABLE Placement (
    PlacementID            INT IDENTITY(1,1),
    ApplicationID          INT           NOT NULL,
    StaffID                INT           NOT NULL,
    StartDate              DATE          NOT NULL,
    EndDate                DATE          NOT NULL,
    MonthlyAllowance       DECIMAL(7,2)  NOT NULL,
    CompanySupervisorName  VARCHAR(100)  NULL,
    PerformanceRating      INT           NULL,
    ReviewNotes            VARCHAR(MAX)  NULL,
    
    -- Constraints
    CONSTRAINT PK_Placement PRIMARY KEY (PlacementID),
    CONSTRAINT FK_Placement_Application FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID),
    ON DELETE CASCADE, -- Cascade delete placements if the associated application is removed (e.g., if a student withdraws)
    CONSTRAINT FK_Placement_Staff FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
    ON DELETE NO ACTION, -- Added data preservation rule to prevent cascade deletes of placements if a staff member is removed
    CONSTRAINT UQ_Placement_Application UNIQUE (ApplicationID),
    CONSTRAINT CK_Placement_Dates CHECK (EndDate > StartDate),
    CONSTRAINT CK_Placement_Allowance CHECK (MonthlyAllowance >= 0.00),
    CONSTRAINT CK_Placement_Rating CHECK (PerformanceRating BETWEEN 1 AND 5)
);
GO


-- 6. REPORTING & ANALYTICAL VIEWS LAYER

-- View 1: Counts the number of applications for each internship posting
CREATE VIEW v_PostingApplicationCounts AS
SELECT 
    ip.PostingID,
    ip.Title AS PostingTitle,
    c.CompanyName,
    COUNT(a.ApplicationID) AS TotalApplications
FROM InternshipPosting ip
JOIN Company c ON ip.CompanyID = c.CompanyID
LEFT JOIN Application a ON ip.PostingID = a.PostingID
GROUP BY ip.PostingID, ip.Title, c.CompanyName;
GO -- Ends the batch cleanly

-- View 2: Handles the high-level placement rate math by diploma
CREATE VIEW v_DiplomaPlacementAnalytics AS
SELECT 
    s.Diploma,
    COUNT(DISTINCT s.StudentID) AS TotalStudents,
    COUNT(DISTINCT p.PlacementID) AS PlacedStudents,
    ROUND((CAST(COUNT(DISTINCT p.PlacementID) AS DECIMAL(5,2)) / 
           NULLIF(CAST(COUNT(DISTINCT s.StudentID) AS DECIMAL(5,2)), 0)) * 100, 2) AS PlacementRatePercentage
FROM Student s
LEFT JOIN Application a ON s.StudentID = a.StudentID
LEFT JOIN Placement p ON a.ApplicationID = p.ApplicationID
GROUP BY s.Diploma;
GO

-- Run this script in SSMS on your database (NP40Intern)

-- 1. View: Students who have applied but have not secured a placement
CREATE OR ALTER VIEW vw_StudentsSeekingPlacement AS
SELECT 
    s.StudentID AS studentid_id,
    s.StudentName AS studentname,
    s.Diploma AS diploma,
    s.Dept AS dept,
    s.GPA AS gpa
FROM Student s
WHERE s.StudentID IN (SELECT DISTINCT StudentID FROM Application)
  AND s.StudentID NOT IN (
      SELECT a.StudentID 
      FROM Application a
      INNER JOIN Placement p ON a.ApplicationID = p.ApplicationID
  );
GO

-- 2. View: Internship postings with application and placement outcomes
CREATE OR ALTER VIEW vw_PostingsAnalysis AS
SELECT 
    ip.PostingID AS posting_id,
    ip.Title AS title,
    COALESCE(c.CompanyName, 'N/A') AS company_name,
    ip.Vacancy AS vacancy,
    COUNT(DISTINCT a.ApplicationID) AS app_count,
    COUNT(DISTINCT p.PlacementID) AS placed_count
FROM InternshipPosting ip
LEFT JOIN Company c ON ip.CompanyID = c.CompanyID
LEFT JOIN Application a ON ip.PostingID = a.PostingID
LEFT JOIN Placement p ON a.ApplicationID = p.ApplicationID
GROUP BY ip.PostingID, ip.Title, c.CompanyName, ip.Vacancy;
GO

-- 3. View: Rank companies based on total successful placements
CREATE OR ALTER VIEW vw_CompanyRankings AS
SELECT 
    c.CompanyName AS companyname,
    c.UEN AS uen,
    c.IndustrySector AS industry,
    COUNT(p.PlacementID) AS placements_count,
    DENSE_RANK() OVER (ORDER BY COUNT(p.PlacementID) DESC) AS rank
FROM Company c
LEFT JOIN InternshipPosting ip ON c.CompanyID = ip.CompanyID
LEFT JOIN Application a ON ip.PostingID = a.PostingID
LEFT JOIN Placement p ON a.ApplicationID = p.ApplicationID
GROUP BY c.CompanyID, c.CompanyName, c.UEN, c.IndustrySector;
GO

PRINT ' view live';