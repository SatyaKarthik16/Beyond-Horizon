# Data Dictionary

This dictionary summarizes the core entities, purpose, and key columns in the Beyond Horizon schema.

## Employees
- Purpose: Master table for all employees.
- Primary key: Employee_id
- Key columns: Employee_Name, Age, Gender, Contact_info, Position, Hire_date

## Payroll
- Purpose: Compensation records for employees.
- Primary key: Payroll_id
- Foreign keys: Employee_id -> Employees.Employee_id
- Key columns: Salary, Bonus, Deduction, Pay_date

## Operations_Managers
- Purpose: Manager-specific operational metadata.
- Primary key: Managers_ID
- Foreign keys: Employee_id -> Employees.Employee_id
- Key columns: Experience, Team_size

## Service_Associate
- Purpose: Service team members supporting travelers.
- Primary key: Associate_ID
- Foreign keys:
  - Employee_id -> Employees.Employee_id
  - Operation_Manager_ID -> Operations_Managers.Managers_ID
- Key columns: Specialized_area, Experience

## Ground_Staff
- Purpose: Ground operations and support roles.
- Primary key: GStaff_ID
- Foreign keys: Employee_id -> Employees.Employee_id
- Key columns: Staff_Role, Experience

## Crew
- Purpose: Flight crew assignments mapped to spacecraft and support.
- Primary key: Crew_ID
- Foreign keys:
  - Employee_id -> Employees.Employee_id
  - Spacecraft_id -> Spacecraft.Spacecraft_id
  - GStaff_ID -> Ground_Staff.GStaff_ID
- Key columns: Crew_Role

## Traveler
- Purpose: Customer profiles and service association.
- Primary key: Traveler_id
- Foreign keys: Associate_ID -> Service_Associate.Associate_ID
- Key columns: Traveler_Name, Age, Gender, Email, Nationality

## Review
- Purpose: Traveler feedback and ratings.
- Primary key: Review_Id
- Foreign keys: Traveller_Id -> Traveler.Traveler_id
- Key columns: Date_of_Review, Comments, Rating

## Package
- Purpose: Travel product catalog.
- Primary key: Package_id
- Key columns: Description, Price

## Spacecraft
- Purpose: Fleet inventory and package mapping.
- Primary key: Spacecraft_id
- Foreign keys: Package_id -> Package.Package_id
- Key columns: Spacecraft_name, Spacecraft_type, Capacity, Status

## Booking
- Purpose: Customer booking transactions.
- Primary key: Booking_id
- Foreign keys:
  - Traveler_id -> Traveler.Traveler_id
  - Package_id -> Package.Package_id
- Key columns: Booking_date, Booking_Status, Insurance_opted

## Insurance_Type
- Purpose: Insurance plan reference data.
- Primary key: Type_of_insurance
- Key columns: Premium_amount

## Insurance
- Purpose: Insurance selected for bookings.
- Primary key: Insurance_id
- Foreign keys:
  - Booking_id -> Booking.Booking_id
  - Type_of_insurance -> Insurance_Type.Type_of_insurance
- Key columns: Coverage_start_date, Coverage_end_date

## Medical_Metrics
- Purpose: Health and safety metrics for voyage readiness.
- Primary key: Metric_id
- Key columns: Heart_rate, Blood_pressure, SpO2, Temperature_of_body

## Trainings
- Purpose: Crew training programs.
- Primary key: Training_id
- Key columns: Training_name, Duration, Description

## Voyage_Info
- Purpose: Voyage schedule and mission details.
- Primary key: Voyage_id
- Foreign keys:
  - Spacecraft_ID -> Spacecraft.Spacecraft_id
  - Metric_id -> Medical_Metrics.Metric_id
- Key columns: Departure_time, Return_time, Destination_details

## Payments
- Purpose: Financial transactions for bookings.
- Primary key: Payment_id
- Foreign keys:
  - Booking_id -> Booking.Booking_id
  - Voyage_id -> Voyage_Info.Voyage_id
- Key columns: Amount, Payment_date, Payment_method, Payment_status

## Certifications
- Purpose: Certification outcomes linked to training and voyages.
- Primary key: Certification_id
- Foreign keys:
  - Training_id -> Trainings.Training_id
  - Voyage_id -> Voyage_Info.Voyage_id
- Key columns: Certificate_name, Completion_date
