CREATE TABLE Employees (
    Employee_id INT PRIMARY KEY NOT NULL,
    Employee_Name VARCHAR(255) NOT NULL,
    Age INT,
    Gender VARCHAR(10),
    Contact_info VARCHAR(255),
    Address_info VARCHAR(255),
    Email VARCHAR(255),
    Nationality VARCHAR(50),
    Hire_date DATE,
    Position VARCHAR(100),
);
 
-- Create Payroll table
CREATE TABLE Payroll (
    Payroll_id INT PRIMARY KEY NOT NULL,
    Employee_id INT,
    Salary DECIMAL(10, 2),
    Bonus DECIMAL(8, 2),
    Deduction DECIMAL(8, 2),
    Pay_date DATE,
    FOREIGN KEY (Employee_id) REFERENCES Employees(Employee_id)
);
 
-- Create Operations Managers table
CREATE TABLE Operations_Managers (
    Managers_ID INT PRIMARY KEY NOT NULL,
    Employee_id INT,
    Experience INT,
    Team_size INT,
    FOREIGN KEY (Employee_id) REFERENCES Employees(Employee_id)
);
 
-- Create Service Associate table
CREATE TABLE Service_Associate (
    Associate_ID INT PRIMARY KEY NOT NULL,
    Employee_id INT,
    Specialized_area VARCHAR(100),
    Experience INT,
    Operation_Manager_ID INT,
    FOREIGN KEY (Employee_id) REFERENCES Employees(Employee_id),
    FOREIGN KEY (Operation_Manager_ID) REFERENCES Operations_Managers(Managers_ID)
);
 
-- Create Traveler table
CREATE TABLE Traveler (
    Traveler_id INT PRIMARY KEY NOT NULL,
    Traveler_Name VARCHAR(255),
    Age INT,
    Gender VARCHAR(10),
    Contact_info VARCHAR(255),
    Address_Info VARCHAR(255),
    Email VARCHAR(255),
    Nationality VARCHAR(50),
    Associate_ID INT,
    FOREIGN KEY (Associate_ID) REFERENCES Service_Associate(Associate_ID)
);
 
-- Create Review table
CREATE TABLE Review (
    Review_Id INT PRIMARY KEY NOT NULL,
    Traveller_Id INT,
    Date_of_Review DATE,
    Comments TEXT,
    Rating INT,
    FOREIGN KEY (Traveller_Id) REFERENCES Traveler(Traveler_id)
);
 
 
-- Create Ground Staff table
CREATE TABLE Ground_Staff (
    GStaff_ID INT PRIMARY KEY NOT NULL,
    Employee_id INT,
    Staff_Role VARCHAR(100),
    Experience INT,
    FOREIGN KEY (Employee_id) REFERENCES Employees(Employee_id)
);
 
-- Create Package table
CREATE TABLE Package (
    Package_id INT PRIMARY KEY NOT NULL,
    Description VARCHAR(255),
    Price DECIMAL(10, 2)
);
 
-- Create Spacecraft table
CREATE TABLE Spacecraft (
    Spacecraft_id INT PRIMARY KEY NOT NULL,
    Spacecraft_name VARCHAR(255),
    Spacecraft_type VARCHAR(100),
    Capacity INT,
    Status VARCHAR(50),
    Package_id INT,
    FOREIGN KEY (Package_id) REFERENCES Package(Package_id)
);
 
 
-- Create Crew table
CREATE TABLE Crew (
    Crew_ID INT PRIMARY KEY NOT NULL,
    Employee_id INT,
    Spacecraft_id INT,
    Crew_Role VARCHAR(100),
    GStaff_ID INT,
    FOREIGN KEY (Employee_id) REFERENCES Employees(Employee_id),
    FOREIGN KEY (Spacecraft_id) REFERENCES Spacecraft(Spacecraft_id),
    FOREIGN KEY (GStaff_ID) REFERENCES Ground_Staff(GStaff_ID)
);
 
 
-- Create Booking table
CREATE TABLE Booking (
    Booking_id INT PRIMARY KEY NOT NULL,
    Traveler_id INT,
    Package_id INT,
    Booking_date DATE,
    Booking_Status VARCHAR(50),
    Insurance_opted VARCHAR(10),
    FOREIGN KEY (Traveler_id) REFERENCES Traveler(Traveler_id),
    FOREIGN KEY (Package_id) REFERENCES Package(Package_id)
);
 
-- Create Insurance type table
CREATE TABLE Insurance_Type (
    Premium_amount DECIMAL(8, 2),
    Type_of_insurance VARCHAR(100) PRIMARY KEY NOT NULL,
);
 
-- Create Insurance table
CREATE TABLE Insurance (
    Insurance_id INT PRIMARY KEY NOT NULL,
    Booking_id INT,
    Type_of_insurance VARCHAR(100),
    Coverage_start_date DATE,
    Coverage_end_date DATE,
    FOREIGN KEY (Booking_id) REFERENCES Booking(Booking_id),
	FOREIGN KEY (Type_of_insurance) REFERENCES Insurance_Type(Type_of_insurance)
);
 
 
 
-- Create Medical Metrics table
CREATE TABLE Medical_Metrics (
    Metric_id INT PRIMARY KEY NOT NULL,
    Heart_rate INT,
    Blood_pressure VARCHAR(20),
    SpO2 INT,
    Temperature_of_body DECIMAL(4, 2)
);
 
-- Create Trainings table
CREATE TABLE Trainings (
    Training_id INT PRIMARY KEY NOT NULL,
    Training_name VARCHAR(255),
    Duration INT,
    Description TEXT
);
 
-- Create Voyage Info table
CREATE TABLE Voyage_Info (
    Voyage_id INT PRIMARY KEY NOT NULL,
    Spacecraft_ID INT,
    Departure_time DATETIME,
    Return_time DATETIME,
    Destination_details VARCHAR(255),
    Metric_id INT,
    FOREIGN KEY (Spacecraft_ID) REFERENCES Spacecraft(Spacecraft_id),
    FOREIGN KEY (Metric_id) REFERENCES Medical_Metrics(Metric_id),
);
 
-- Create Payments table
CREATE TABLE Payments (
    Payment_id INT PRIMARY KEY NOT NULL,
    Booking_id INT,
    Amount DECIMAL(10, 2),
    Payment_date DATE,
    Payment_method VARCHAR(50),
    Payment_status VARCHAR(50),
    Voyage_id INT,
    FOREIGN KEY (Booking_id) REFERENCES Booking(Booking_id),
	FOREIGN KEY (Voyage_id) REFERENCES Voyage_Info(Voyage_id)
);
-- Create Certifications table
CREATE TABLE Certifications (
    Certification_id INT PRIMARY KEY NOT NULL,
    Certificate_name VARCHAR(255),
    Training_id INT,
    Completion_date DATE,
    Voyage_id INT,
    FOREIGN KEY (Training_id) REFERENCES Trainings(Training_id),
    FOREIGN KEY (Voyage_id) REFERENCES Voyage_Info(Voyage_id)
);