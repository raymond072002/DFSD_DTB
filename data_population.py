import pandas as pd
import bcrypt,os
import random
from datetime import datetime, timedelta
from sqlalchemy import create_engine, text
from dotenv import load_dotenv

# 1. Load configuration parameters from the local .env file
load_dotenv()

# 2. Fetch database keys safely from system context with fallback defaults
db_user = os.getenv("MSSQL_USER")
db_password = os.getenv("MSSQL_PASSWORD")
db_host = os.getenv("MSSQL_HOST")
db_port = os.getenv("MSSQL_PORT", "1433")  # Defaults to 1434 if not specified
db_name = os.getenv("MSSQL_DATABASE")

# 3. Construct the clean dynamic connection URI string
connection_string = f"mssql+pymssql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}"

engine = create_engine(connection_string)

print("⚡ 已连接数据库实例 微软SQL Server。资料生成启动...")

# 2. Pre-compute a secure bcrypt hash for testing (Universal Password)
plain_password = "IloveMum520".encode('utf-8')
hashed_password = bcrypt.hashpw(plain_password, bcrypt.gensalt()).decode('utf-8')

# Mock Settings
NUM_STUDENTS = 25
NUM_STAFF = 5
NUM_COMPANIES = 6

# --- Define Course Catalog ---
np_courses = [
    {"diploma": "Diploma in Information Technology", "dept": "ICT"},
    {"diploma": "Diploma in Cybersecurity & Digital Forensics", "dept": "ICT"},
    {"diploma": "Diploma in Accountancy", "dept": "BA"},
    {"diploma": "Diploma in Banking & Finance", "dept": "BA"},
    {"diploma": "Diploma in Design & Environment", "dept": "DE"},
    {"diploma": "Diploma in Real Estate Business", "dept": "DE"},
    {"diploma": "Diploma in Nursing", "dept": "HS"},
    {"diploma": "Diploma in Mass Communication", "dept": "FMS"},
    {"diploma": "Diploma in Film, Sound & Video", "dept": "FMS"}
]
# -- - Define a pool of student names for profile generation ---
student_names = [
    "Aaron Tan", "Beatrice Lim", "Charlie Teo", "Daniel Goh", "Emma Wong",
    "Fiona Cheong", "Gabriel Ng", "Hannah Koh", "Ian Chia", "Jessica Low",
    "Kevin Heng", "Leonie Chan", "Marcus Seow", "Nadia Jamil", "Owen Tan",
    "Priscilla Phua", "Quentin Quek", "Rachel Sim", "Samuel Tay", "Tiffany Wee",
    "Ulysses Ho", "Valerie Kwek", "William Yong", "Xavier Neo", "Yvonne Radiah"
]

# PHASE 1: GENERATE MASTER USER ACCOUNTS (SUPERTYPE)
user_records = []
user_id_counter = 1

# Generate Student Users
for i in range(1, NUM_STUDENTS + 1):
    user_records.append({
        'UserID': user_id_counter,
        'Username': f"student_{i}",
        'HashedPassword': hashed_password,
        'Email': f"student_{i}@connect.np.edu.sg",
        'UserType': 'Student'
    })
    user_id_counter += 1

# Generate Staff Users
for i in range(1, NUM_STAFF + 1):
    user_records.append({
        'UserID': user_id_counter,
        'Username': f"staff_{i}",
        'HashedPassword': hashed_password,
        'Email': f"staff_{i}@np.edu.sg",
        'UserType': 'Staff'
    })
    user_id_counter += 1

# Generate Company Users
for i in range(1, NUM_COMPANIES + 1):
    user_records.append({
        'UserID': user_id_counter,
        'Username': f"company_{i}",
        'HashedPassword': hashed_password,
        'Email': f"hr@company_{i}.com",
        'UserType': 'Company'
    })
    user_id_counter += 1

df_users = pd.DataFrame(user_records)

# Extract lists of user IDs to link our Subtypes accurately
student_uids = df_users[df_users['UserType'] == 'Student']['UserID'].tolist()
staff_uids = df_users[df_users['UserType'] == 'Staff']['UserID'].tolist()
company_uids = df_users[df_users['UserType'] == 'Company']['UserID'].tolist()

# PHASE 2: SUBTYPE PROFILE RECORDS
# 1. Student Profiles
student_records = []
for idx, uid in enumerate(student_uids):
    course = np_courses[idx % len(np_courses)]
    student_records.append({
        'StudentID': uid,
        'StudentName': student_names[idx % len(student_names)],
        'Diploma': course['diploma'],
        'Dept': course['dept'],
        'GPA': round(random.uniform(2.40, 4.00), 2)
    })
df_students = pd.DataFrame(student_records)

# 2. Staff Profiles
staff_names = ["Dr. Alan Croft", "Mrs. Brenda Song", "Mr. Colin Pascoe", "Ms. Diana Prince", "Dr. Evan Rogers"]
staff_records = []
for idx, uid in enumerate(staff_uids):
    staff_records.append({
        'StaffID': uid,
        'StaffName': staff_names[idx % len(staff_names)],
        'ContactNumber': f"+65 6460{8000 + idx}"
    })
df_staff = pd.DataFrame(staff_records)

# 3. Company Profiles
companies_pool = [
    ("GovTech Singapore", "201612345K", "Public Sector Tech"),
    ("DBS Bank Ltd", "196800306E", "Banking & Finance"),
    ("NCS Group", "198103923M", "IT Consulting & Services"),
    ("Shopee Singapore Pte Ltd", "201504820D", "E-Commerce & Internet"),
    ("Singtel", "199201029D", "Telecommunications"),
    ("Grab Holdings", "201828821W", "Tech & Logistics")
]
company_records = []
for idx, uid in enumerate(company_uids):
    c_name, c_uen, c_sector = companies_pool[idx % len(companies_pool)]
    company_records.append({
        'CompanyID': uid,
        'UEN': c_uen,
        'CompanyName': c_name,
        'IndustrySector': c_sector
    })
df_companies = pd.DataFrame(company_records)


# PHASE 3: GENERATE JOB POSTINGS (TRANSACTION LAYER BEGINS)
industry_jobs = [
    {"title": "Software Engineering Intern", "desc": "Assist in developing secure public-facing components using Python and cloud containers."},
    {"title": "Audit & Assurance Intern", "desc": "Assist corporate audit engagement teams with financial validation checks and transaction sampling schedules."},
    {"title": "Architectural Design Assistant", "desc": "Develop structural 3D CAD schematic profiles for local public housing infrastructure blueprints."},
    {"title": "Clinical Nursing Intern", "desc": "Assist inpatient ward senior nursing staff with patient monitoring, basic checks, and medical charts."},
    {"title": "Production & Journalism Assistant", "desc": "Participate in broadcast media script editing, camera equipment staging, and live sound monitoring."},
    {"title": "Financial Portfolio Analyst Assistant", "desc": "Perform competitive enterprise stock yield research summaries using market terminal interfaces."}
]

posting_records = []
for idx, uid in enumerate(company_uids):
    job = industry_jobs[idx % len(industry_jobs)]
    posting_records.append({
        'PostingID': idx + 1,
        'CompanyID': uid,
        'Title': job['title'],
        'Description': job['desc'],
        'Vacancy': random.randint(2, 4),
        'DatePosted': (datetime.now() - timedelta(days=20)).date()
    })
df_postings = pd.DataFrame(posting_records)


# PHASE 4: CONTEXT-AWARE APPLICATIONS, INTERVIEWS, AND PLACEMENTS
application_records = []
interview_records = []
placement_records = []

app_id_counter = 1
int_id_counter = 1
placement_id_counter = 1

for idx, stu_id in enumerate(student_uids):
    field_index = idx % len(np_courses)
    student_course = np_courses[field_index]
    
    if student_course['dept'] == 'ICT':       target_post = 1  
    elif student_course['dept'] == 'BA':     target_post = 2  
    elif student_course['dept'] == 'DE':     target_post = 3  
    elif student_course['dept'] == 'HS':     target_post = 4  
    elif student_course['dept'] == 'FMS':    target_post = 5  
    else:                                    target_post = 6  
    
    if student_course['diploma'] == "Diploma in Banking & Finance":
        target_post = 6

    # CASE A: Placed / Hired (First 15 students get jobs)
    if idx < 15:
        application_records.append({
            'ApplicationID': app_id_counter, 
            'StudentID': stu_id, 
            'PostingID': target_post,
            'ApplicationDate': (datetime.now() - timedelta(days=15)).date(), 
            'ApplicationStatus': 'Offered'
        })
        
        # --- Define Interview Records ---
        interview_records.append({
            'InterviewID': int_id_counter, 
            'ApplicationID': app_id_counter,
            'StaffID': random.choice(staff_uids), # Maps back to our Staff profile keys!
            'InterviewDate': datetime.now() - timedelta(days=8), 
            'InterviewType': 'Technical/Panel Fit', 
            'Outcome': 'Passed'
        })
        int_id_counter += 1
        
        placement_records.append({
            'PlacementID': placement_id_counter, 
            'ApplicationID': app_id_counter, 
            'StaffID': random.choice(staff_uids),
            'StartDate': (datetime.now() + timedelta(days=15)).date(), 
            'EndDate': (datetime.now() + timedelta(days=180)).date(),
            'MonthlyAllowance': float(random.choice([1000.00, 1200.00, 1400.00])),
            'CompanySupervisorName': f"Supervisor {idx + 1}", 
            'PerformanceRating': None, 
            'ReviewNotes': None
        })
        placement_id_counter += 1
        app_id_counter += 1

    # CASE B: Applied but Stuck / Pending (Next 10 students)
    else:
        application_records.append({
            'ApplicationID': app_id_counter, 
            'StudentID': stu_id, 
            'PostingID': target_post,
            'ApplicationDate': (datetime.now() - timedelta(days=10)).date(), 
            'ApplicationStatus': 'Applied'
        })
        app_id_counter += 1

df_applications = pd.DataFrame(application_records)
df_interviews = pd.DataFrame(interview_records)
df_placements = pd.DataFrame(placement_records)

# ============================================================================
# PHASE 5: TRANSACTIONAL SAFETY INJECTION MATRIX
# ============================================================================
print("🚀 Commencing SQL Server bulk ingestion pipelines...")

# --- Bulk Ingestion Pipeline disabling auto-increment for mock data bulk insert and enabling after execution ---
with engine.begin() as conn:
    conn.execute(text("SET IDENTITY_INSERT [User] ON;"))
    df_users.to_sql('User', con=conn, if_exists='append', index=False)
    conn.execute(text("SET IDENTITY_INSERT [User] OFF;"))
    
    df_students.to_sql('Student', con=conn, if_exists='append', index=False)
    df_staff.to_sql('Staff', con=conn, if_exists='append', index=False)
    df_companies.to_sql('Company', con=conn, if_exists='append', index=False)
    
    conn.execute(text("SET IDENTITY_INSERT InternshipPosting ON;"))
    df_postings.to_sql('InternshipPosting', con=conn, if_exists='append', index=False)
    conn.execute(text("SET IDENTITY_INSERT InternshipPosting OFF;"))
    
    conn.execute(text("SET IDENTITY_INSERT Application ON;"))
    df_applications.to_sql('Application', con=conn, if_exists='append', index=False)
    conn.execute(text("SET IDENTITY_INSERT Application OFF;"))
    
    conn.execute(text("SET IDENTITY_INSERT Interview ON;"))
    df_interviews.to_sql('Interview', con=conn, if_exists='append', index=False)
    conn.execute(text("SET IDENTITY_INSERT Interview OFF;"))
    
    conn.execute(text("SET IDENTITY_INSERT Placement ON;"))
    df_placements.to_sql('Placement', con=conn, if_exists='append', index=False)
    conn.execute(text("SET IDENTITY_INSERT Placement OFF;"))

print("✅ Data successfully populated into SQL Server without structural conflicts!")