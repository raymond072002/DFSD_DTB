USE NP40Intern;
GO

-- T-SQL MOCK DATA INJECTION SQL -- 
--              !!!  ALERT  !!!     -- 
--  ONLY FOR client requirement, exec after DDL execution.
--  For Prod, use manage.py => inspectdb => confirm models.py => makemigrations => migrate --fake-init => populate.py 

PRINT '====================================================================';
PRINT '🚀 虚假资料婴童程序开启...';
PRINT '====================================================================';

-- ----------------------------------------------------------------------------
-- PHASE 1: GENERATE MASTER USER ACCOUNTS (SUPERTYPE)
-- ----------------------------------------------------------------------------
PRINT '↳ Injecting Core Identity & Security Layer ([User] Accounts)...';

SET IDENTITY_INSERT [User] ON;

-- Inject Student Users (IDs 1 to 25) -- pwd = bcrypt('IloveMum520')
INSERT INTO [User] (UserID, Username, HashedPassword, Email, UserType) VALUES
(1, 'student_1', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_1@connect.np.edu.sg', 'Student'),
(2, 'student_2', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_2@connect.np.edu.sg', 'Student'),
(3, 'student_3', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_3@connect.np.edu.sg', 'Student'),
(4, 'student_4', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_4@connect.np.edu.sg', 'Student'),
(5, 'student_5', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_5@connect.np.edu.sg', 'Student'),
(6, 'student_6', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_6@connect.np.edu.sg', 'Student'),
(7, 'student_7', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_7@connect.np.edu.sg', 'Student'),
(8, 'student_8', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_8@connect.np.edu.sg', 'Student'),
(9, 'student_9', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_9@connect.np.edu.sg', 'Student'),
(10, 'student_10', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_10@connect.np.edu.sg', 'Student'),
(11, 'student_11', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_11@connect.np.edu.sg', 'Student'),
(12, 'student_12', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_12@connect.np.edu.sg', 'Student'),
(13, 'student_13', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_13@connect.np.edu.sg', 'Student'),
(14, 'student_14', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_14@connect.np.edu.sg', 'Student'),
(15, 'student_15', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_15@connect.np.edu.sg', 'Student'),
(16, 'student_16', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_16@connect.np.edu.sg', 'Student'),
(17, 'student_17', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_17@connect.np.edu.sg', 'Student'),
(18, 'student_18', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_18@connect.np.edu.sg', 'Student'),
(19, 'student_19', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_19@connect.np.edu.sg', 'Student'),
(20, 'student_20', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_20@connect.np.edu.sg', 'Student'),
(21, 'student_21', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_21@connect.np.edu.sg', 'Student'),
(22, 'student_22', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_22@connect.np.edu.sg', 'Student'),
(23, 'student_23', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_23@connect.np.edu.sg', 'Student'),
(24, 'student_24', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_24@connect.np.edu.sg', 'Student'),
(25, 'student_25', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'student_25@connect.np.edu.sg', 'Student');

-- Inject Staff Users (IDs 26 to 30)
INSERT INTO [User] (UserID, Username, HashedPassword, Email, UserType) VALUES
(26, 'staff_1', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'staff_1@np.edu.sg', 'Staff'),
(27, 'staff_2', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'staff_2@np.edu.sg', 'Staff'),
(28, 'staff_3', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'staff_3@np.edu.sg', 'Staff'),
(29, 'staff_4', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'staff_4@np.edu.sg', 'Staff'),
(30, 'staff_5', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'staff_5@np.edu.sg', 'Staff');

-- Inject Company Users (IDs 31 to 36)
INSERT INTO [User] (UserID, Username, HashedPassword, Email, UserType) VALUES
(31, 'company_1', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'hr@company_1.com', 'Company'),
(32, 'company_2', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'hr@company_2.com', 'Company'),
(33, 'company_3', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'hr@company_3.com', 'Company'),
(34, 'company_4', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'hr@company_4.com', 'Company'),
(35, 'company_5', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'hr@company_5.com', 'Company'),
(36, 'company_6', '0x9E7D46F5A0C2B4E1F3D5C6A7B8E9F0D1C2B3A4F5E6D7C8B9A0F1E2D3C4B5A6F7', 'hr@company_6.com', 'Company');

SET IDENTITY_INSERT [User] OFF;
GO

-- ----------------------------------------------------------------------------
-- PHASE 2: SUBTYPE PROFILE RECORDS
-- ----------------------------------------------------------------------------
PRINT '↳ Injecting Extended Subtype Columns (Student, Staff, Company profiles)...';

-- Student Segment (Explicitly Mapped Courses & GPA Outliers)
INSERT INTO Student (StudentID, StudentName, Diploma, Dept, GPA) VALUES
(1, N'Aaron Tan', N'Diploma in Information Technology', N'ICT', 3.82),
(2, N'Beatrice Lim', N'Diploma in Cybersecurity & Digital Forensics', N'ICT', 2.95),
(3, N'Charlie Teo', N'Diploma in Accountancy', N'BA', 3.41),
(4, N'Daniel Goh', N'Diploma in Banking & Finance', N'BA', 3.12),
(5, N'Emma Wong', N'Diploma in Design & Environment', N'DE', 3.67),
(6, N'Fiona Cheong', N'Diploma in Real Estate Business', N'DE', 2.54),
(7, N'Gabriel Ng', N'Diploma in Nursing', N'HS', 3.89),
(8, N'Hannah Koh', N'Diploma in Mass Communication', N'FMS', 3.21),
(9, N'Ian Chia', N'Diploma in Film, Sound & Video', N'FMS', 2.78),
(10, N'Jessica Low', N'Diploma in Information Technology', N'ICT', 3.55),
(11, N'Kevin Heng', N'Diploma in Cybersecurity & Digital Forensics', N'ICT', 3.91),
(12, N'Leonie Chan', N'Diploma in Accountancy', N'BA', 2.62),
(13, N'Marcus Seow', N'Diploma in Banking & Finance', N'BA', 3.34),
(14, N'Nadia Jamil', N'Diploma in Design & Environment', N'DE', 3.72),
(15, N'Owen Tan', N'Diploma in Real Estate Business', N'DE', 2.88),
(16, N'Priscilla Phua', N'Diploma in Nursing', N'HS', 3.05),
(17, N'Quentin Quek', N'Diploma in Mass Communication', N'FMS', 3.49),
(18, N'Rachel Sim', N'Diploma in Film, Sound & Video', N'FMS', 3.61),
(19, N'Samuel Tay', N'Diploma in Information Technology', N'ICT', 2.45),
(20, N'Tiffany Wee', N'Diploma in Cybersecurity & Digital Forensics', N'ICT', 3.18),
(21, N'Ulysses Ho', N'Diploma in Accountancy', N'BA', 3.80),
(22, N'Valerie Kwek', N'Diploma in Banking & Finance', N'BA', 2.99),
(23, N'William Yong', N'Diploma in Design & Environment', N'DE', 3.25),
(24, N'Xavier Neo', N'Diploma in Real Estate Business', N'DE', 3.58),
(25, N'Yvonne Radiah', N'Diploma in Nursing', N'HS', 2.71);

-- Staff Segment
INSERT INTO Staff (StaffID, StaffName, ContactNumber) VALUES
(26, N'Dr. Lara Croft', '+65 64608000'),
(27, N'Mrs. Brenda Song', '+65 64608001'),
(28, N'Mr. Colin Pascoe', '+65 64608002'),
(29, N'Ms. Diana Prince', '+65 64608003'),
(30, N'Dr. Evan Rogers', '+65 64608004');

-- Company Segment (UEN Standardized Check Rules Validation)
INSERT INTO Company (CompanyID, UEN, CompanyName, IndustrySector) VALUES
(31, '201612345K', N'GulfTech Singapore', N'Public Sector Tech'),
(32, '196800306E', N'BDS Bank Ltd', N'Banking & Finance'),
(33, '198103923M', N'MCS Group', N'IT Consulting & Services'),
(34, '201504820D', N'Chopee Singapore Pte Ltd', N'E-Commerce & Internet'),
(35, '199201029D', N'Zingtel', N'Telecommunications'),
(36, '201828821W', N'Frab Holdings', N'Tech & Logistics');
GO

-- ----------------------------------------------------------------------------
-- PHASE 3: GENERATE JOB POSTINGS (TRANSACTION LAYER BEGINS)
-- ----------------------------------------------------------------------------
PRINT '↳ Injecting Corporate Internship Job Advertisements...';

SET IDENTITY_INSERT InternshipPosting ON;

INSERT INTO InternshipPosting (PostingID, CompanyID, Title, Description, Vacancy, DatePosted) VALUES
(1, 31, N'Software Engineering Intern', N'Assist in developing secure public-facing components using Python and cloud containers.', 3, DATEADD(day, -20, CAST(GETDATE() AS DATE))),
(2, 32, N'Audit & Assurance Intern', N'Assist corporate audit engagement teams with financial validation checks and transaction sampling schedules.', 2, DATEADD(day, -20, CAST(GETDATE() AS DATE))),
(3, 33, N'Architectural Design Assistant', N'Develop structural 3D CAD schematic profiles for local public housing infrastructure blueprints.', 4, DATEADD(day, -20, CAST(GETDATE() AS DATE))),
(4, 34, N'Clinical Nursing Intern', N'Assist inpatient ward senior nursing staff with patient monitoring, basic checks, and medical charts.', 2, DATEADD(day, -20, CAST(GETDATE() AS DATE))),
(5, 35, N'Production & Journalism Assistant', N'Participate in broadcast media script editing, camera equipment staging, and live sound monitoring.', 3, DATEADD(day, -20, CAST(GETDATE() AS DATE))),
(6, 36, N'Financial Portfolio Analyst Assistant', N'Perform competitive enterprise stock yield research summaries using market terminal interfaces.', 3, DATEADD(day, -20, CAST(GETDATE() AS DATE)));

SET IDENTITY_INSERT InternshipPosting OFF;
GO

-- ----------------------------------------------------------------------------
-- PHASE 4: TRANSACTION WORKFLOW (APPLICATIONS, INTERVIEWS, PLACEMENTS)
-- ----------------------------------------------------------------------------
PRINT '↳ Activating Business Lifecycles (Applications & Interview Panels)...';

SET IDENTITY_INSERT Application ON;

-- CASE A: Hired Group (Submitting to their contextually matching industry tracks)
INSERT INTO Application (ApplicationID, StudentID, PostingID, ApplicationDate, ApplicationStatus) VALUES
(1, 1, 1, DATEADD(day, -15, CAST(GETDATE() AS DATE)), 'Offered'), -- ICT -> GovTech
(2, 2, 1, DATEADD(day, -15, CAST(GETDATE() AS DATE)), 'Offered'), -- ICT -> GovTech
(3, 3, 2, DATEADD(day, -15, CAST(GETDATE() AS DATE)), 'Offered'), -- BA -> Audit
(4, 4, 6, DATEADD(day, -15, CAST(GETDATE() AS DATE)), 'Offered'), -- Banking Student Variance -> DBS Bank
(5, 5, 3, DATEADD(day, -15, CAST(GETDATE() AS DATE)), 'Offered'), -- DE -> Design
(6, 6, 3, DATEADD(day, -15, CAST(GETDATE() AS DATE)), 'Offered'), -- DE -> Design
(7, 7, 4, DATEADD(day, -15, CAST(GETDATE() AS DATE)), 'Offered'), -- HS -> Nursing
(8, 8, 5, DATEADD(day, -15, CAST(GETDATE() AS DATE)), 'Offered'), -- FMS -> Production
(9, 9, 5, DATEADD(day, -15, CAST(GETDATE() AS DATE)), 'Offered'), -- FMS -> Production
(10, 10, 1, DATEADD(day, -15, CAST(GETDATE() AS DATE)), 'Offered'), -- ICT -> GovTech
(11, 11, 1, DATEADD(day, -15, CAST(GETDATE() AS DATE)), 'Offered'), -- ICT -> GovTech
(12, 12, 2, DATEADD(day, -15, CAST(GETDATE() AS DATE)), 'Offered'), -- BA -> Audit
(13, 13, 6, DATEADD(day, -15, CAST(GETDATE() AS DATE)), 'Offered'), -- Banking Student Variance -> DBS Bank
(14, 14, 3, DATEADD(day, -15, CAST(GETDATE() AS DATE)), 'Offered'), -- DE -> Design
(15, 15, 3, DATEADD(day, -15, CAST(GETDATE() AS DATE)), 'Offered'); -- DE -> Design

-- CASE B: Outliers Group (Applied but stuck in processing/pending queues for analytics testing)
INSERT INTO Application (ApplicationID, StudentID, PostingID, ApplicationDate, ApplicationStatus) VALUES
(16, 16, 4, DATEADD(day, -10, CAST(GETDATE() AS DATE)), 'Applied'),
(17, 17, 5, DATEADD(day, -10, CAST(GETDATE() AS DATE)), 'Applied'),
(18, 18, 5, DATEADD(day, -10, CAST(GETDATE() AS DATE)), 'Applied'),
(19, 19, 1, DATEADD(day, -10, CAST(GETDATE() AS DATE)), 'Applied'),
(20, 20, 1, DATEADD(day, -10, CAST(GETDATE() AS DATE)), 'Applied'),
(21, 21, 2, DATEADD(day, -10, CAST(GETDATE() AS DATE)), 'Applied'),
(22, 22, 6, DATEADD(day, -10, CAST(GETDATE() AS DATE)), 'Applied'),
(23, 23, 3, DATEADD(day, -10, CAST(GETDATE() AS DATE)), 'Applied'),
(24, 24, 3, DATEADD(day, -10, CAST(GETDATE() AS DATE)), 'Applied'),
(25, 25, 4, DATEADD(day, -10, CAST(GETDATE() AS DATE)), 'Applied');

SET IDENTITY_INSERT Application OFF;
GO

PRINT '↳ Injecting Historical Interview Panel Evaluations (Passed Tracks)...';

SET IDENTITY_INSERT Interview ON;

-- Inject Interview logs matching Hired Applications (Coordinated randomly across staff IDs 26 to 30)
INSERT INTO Interview (InterviewID, ApplicationID, StaffID, InterviewDate, InterviewType, Outcome) VALUES
(1,  1,  26, DATEADD(day, -8, GETDATE()), 'Technical/Panel Fit', 'Passed'),
(2,  2,  27, DATEADD(day, -8, GETDATE()), 'Technical/Panel Fit', 'Passed'),
(3,  3,  28, DATEADD(day, -8, GETDATE()), 'Technical/Panel Fit', 'Passed'),
(4,  4,  29, DATEADD(day, -8, GETDATE()), 'Technical/Panel Fit', 'Passed'),
(5,  5,  30, DATEADD(day, -8, GETDATE()), 'Technical/Panel Fit', 'Passed'),
(6,  6,  26, DATEADD(day, -8, GETDATE()), 'Technical/Panel Fit', 'Passed'),
(7,  7,  27, DATEADD(day, -8, GETDATE()), 'Technical/Panel Fit', 'Passed'),
(8,  8,  28, DATEADD(day, -8, GETDATE()), 'Technical/Panel Fit', 'Passed'),
(9,  9,  29, DATEADD(day, -8, GETDATE()), 'Technical/Panel Fit', 'Passed'),
(10, 10, 30, DATEADD(day, -8, GETDATE()), 'Technical/Panel Fit', 'Passed'),
(11, 11, 26, DATEADD(day, -8, GETDATE()), 'Technical/Panel Fit', 'Passed'),
(12, 12, 27, DATEADD(day, -8, GETDATE()), 'Technical/Panel Fit', 'Passed'),
(13, 13, 28, DATEADD(day, -8, GETDATE()), 'Technical/Panel Fit', 'Passed'),
(14, 14, 29, DATEADD(day, -8, GETDATE()), 'Technical/Panel Fit', 'Passed'),
(15, 15, 30, DATEADD(day, -8, GETDATE()), 'Technical/Panel Fit', 'Passed');

SET IDENTITY_INSERT Interview OFF;
GO

PRINT '↳ finalising Contract Fulfillment Layer (Active Placement Allocations)...';

SET IDENTITY_INSERT Placement ON;

-- Inject confirmed, 1:1 active placement folders matching applications 1 to 15
INSERT INTO Placement (PlacementID, ApplicationID, StaffID, StartDate, EndDate, MonthlyAllowance, CompanySupervisorName, PerformanceRating, ReviewNotes) VALUES
(1,  1,  28, DATEADD(day, 15, CAST(GETDATE() AS DATE)), DATEADD(day, 180, CAST(GETDATE() AS DATE)), 1200.00, 'Supervisor 1', NULL, NULL),
(2,  2,  30, DATEADD(day, 15, CAST(GETDATE() AS DATE)), DATEADD(day, 180, CAST(GETDATE() AS DATE)), 1400.00, 'Supervisor 2', NULL, NULL),
(3,  3,  26, DATEADD(day, 15, CAST(GETDATE() AS DATE)), DATEADD(day, 180, CAST(GETDATE() AS DATE)), 1000.00, 'Supervisor 3', NULL, NULL),
(4,  4,  29, DATEADD(day, 15, CAST(GETDATE() AS DATE)), DATEADD(day, 180, CAST(GETDATE() AS DATE)), 1200.00, 'Supervisor 4', NULL, NULL),
(5,  5,  27, DATEADD(day, 15, CAST(GETDATE() AS DATE)), DATEADD(day, 180, CAST(GETDATE() AS DATE)), 1400.00, 'Supervisor 5', NULL, NULL),
(6,  6,  26, DATEADD(day, 15, CAST(GETDATE() AS DATE)), DATEADD(day, 180, CAST(GETDATE() AS DATE)), 1000.00, 'Supervisor 6', NULL, NULL),
(7,  7,  29, DATEADD(day, 15, CAST(GETDATE() AS DATE)), DATEADD(day, 180, CAST(GETDATE() AS DATE)), 1200.00, 'Supervisor 7', NULL, NULL),
(8,  8,  28, DATEADD(day, 15, CAST(GETDATE() AS DATE)), DATEADD(day, 180, CAST(GETDATE() AS DATE)), 1000.00, 'Supervisor 8', NULL, NULL),
(9,  9,  30, DATEADD(day, 15, CAST(GETDATE() AS DATE)), DATEADD(day, 180, CAST(GETDATE() AS DATE)), 1400.00, 'Supervisor 9', NULL, NULL),
(10, 10, 27, DATEADD(day, 15, CAST(GETDATE() AS DATE)), DATEADD(day, 180, CAST(GETDATE() AS DATE)), 1200.00, 'Supervisor 10', NULL, NULL),
(11, 11, 26, DATEADD(day, 15, CAST(GETDATE() AS DATE)), DATEADD(day, 180, CAST(GETDATE() AS DATE)), 1400.00, 'Supervisor 11', NULL, NULL),
(12, 12, 28, DATEADD(day, 15, CAST(GETDATE() AS DATE)), DATEADD(day, 180, CAST(GETDATE() AS DATE)), 1000.00, 'Supervisor 12', NULL, NULL),
(13, 13, 29, DATEADD(day, 15, CAST(GETDATE() AS DATE)), DATEADD(day, 180, CAST(GETDATE() AS DATE)), 1200.00, 'Supervisor 13', NULL, NULL),
(14, 14, 30, DATEADD(day, 15, CAST(GETDATE() AS DATE)), DATEADD(day, 180, CAST(GETDATE() AS DATE)), 1400.00, 'Supervisor 14', NULL, NULL),
(15, 15, 27, DATEADD(day, 15, CAST(GETDATE() AS DATE)), DATEADD(day, 180, CAST(GETDATE() AS DATE)), 1000.00, 'Supervisor 15', NULL, NULL);

SET IDENTITY_INSERT Placement OFF;
GO

PRINT '====================================================================';
PRINT '✅ DATA POPULATION SUCCESSFULLY INJECTED WITHOUT TRANS-SQL CONFLICTS!';
PRINT '✅ 虚假资料成功输入完毕!';
PRINT '====================================================================';