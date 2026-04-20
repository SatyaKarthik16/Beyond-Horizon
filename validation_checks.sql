-- Beyond Horizon Inc. - Data Validation Checks
-- Run after schema.sql and seed_data.sql

SET NOCOUNT ON;

PRINT '=== 1) Table Availability Check ===';
SELECT t.name AS table_name
FROM sys.tables t
WHERE t.name IN (
    'Employees','Payroll','Operations_Managers','Service_Associate','Ground_Staff','Crew',
    'Traveler','Review','Package','Spacecraft','Booking','Insurance_Type','Insurance',
    'Medical_Metrics','Trainings','Voyage_Info','Payments','Certifications'
)
ORDER BY t.name;

PRINT '=== 2) Row Count Snapshot ===';
SELECT 'Employees' AS table_name, COUNT(*) AS row_count FROM Employees
UNION ALL SELECT 'Payroll', COUNT(*) FROM Payroll
UNION ALL SELECT 'Operations_Managers', COUNT(*) FROM Operations_Managers
UNION ALL SELECT 'Service_Associate', COUNT(*) FROM Service_Associate
UNION ALL SELECT 'Ground_Staff', COUNT(*) FROM Ground_Staff
UNION ALL SELECT 'Crew', COUNT(*) FROM Crew
UNION ALL SELECT 'Traveler', COUNT(*) FROM Traveler
UNION ALL SELECT 'Review', COUNT(*) FROM Review
UNION ALL SELECT 'Package', COUNT(*) FROM Package
UNION ALL SELECT 'Spacecraft', COUNT(*) FROM Spacecraft
UNION ALL SELECT 'Booking', COUNT(*) FROM Booking
UNION ALL SELECT 'Insurance_Type', COUNT(*) FROM Insurance_Type
UNION ALL SELECT 'Insurance', COUNT(*) FROM Insurance
UNION ALL SELECT 'Medical_Metrics', COUNT(*) FROM Medical_Metrics
UNION ALL SELECT 'Trainings', COUNT(*) FROM Trainings
UNION ALL SELECT 'Voyage_Info', COUNT(*) FROM Voyage_Info
UNION ALL SELECT 'Payments', COUNT(*) FROM Payments
UNION ALL SELECT 'Certifications', COUNT(*) FROM Certifications;

PRINT '=== 3) Referential Integrity Sanity Checks (Orphans) ===';

SELECT 'Booking->Traveler' AS relationship, COUNT(*) AS orphan_count
FROM Booking b
LEFT JOIN Traveler t ON t.Traveler_id = b.Traveler_id
WHERE t.Traveler_id IS NULL
UNION ALL
SELECT 'Booking->Package', COUNT(*)
FROM Booking b
LEFT JOIN Package p ON p.Package_id = b.Package_id
WHERE p.Package_id IS NULL
UNION ALL
SELECT 'Payments->Booking', COUNT(*)
FROM Payments p
LEFT JOIN Booking b ON b.Booking_id = p.Booking_id
WHERE b.Booking_id IS NULL
UNION ALL
SELECT 'Insurance->Booking', COUNT(*)
FROM Insurance i
LEFT JOIN Booking b ON b.Booking_id = i.Booking_id
WHERE b.Booking_id IS NULL
UNION ALL
SELECT 'Crew->Employees', COUNT(*)
FROM Crew c
LEFT JOIN Employees e ON e.Employee_id = c.Employee_id
WHERE e.Employee_id IS NULL
UNION ALL
SELECT 'Review->Traveler', COUNT(*)
FROM Review r
LEFT JOIN Traveler t ON t.Traveler_id = r.Traveller_Id
WHERE t.Traveler_id IS NULL;

PRINT '=== 4) Domain and Data Quality Checks ===';

SELECT 'Invalid review ratings (expected 1-5)' AS check_name, COUNT(*) AS issue_count
FROM Review
WHERE Rating NOT BETWEEN 1 AND 5
UNION ALL
SELECT 'Negative package prices', COUNT(*)
FROM Package
WHERE Price < 0
UNION ALL
SELECT 'Negative payment amount', COUNT(*)
FROM Payments
WHERE Amount < 0
UNION ALL
SELECT 'Invalid booking insurance flag', COUNT(*)
FROM Booking
WHERE Insurance_opted NOT IN ('Yes', 'No')
UNION ALL
SELECT 'Invalid insurance coverage date range', COUNT(*)
FROM Insurance
WHERE Coverage_start_date IS NOT NULL
  AND Coverage_end_date IS NOT NULL
  AND Coverage_end_date < Coverage_start_date
UNION ALL
SELECT 'Invalid voyage time range', COUNT(*)
FROM Voyage_Info
WHERE Return_time < Departure_time;

PRINT '=== Validation checks completed ===';
