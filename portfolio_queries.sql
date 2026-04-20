-- Beyond Horizon Inc. - Portfolio Query Pack
-- These queries are written to align with the current table structure.

-- 1) Travelers who booked packages priced above the average package price
SELECT t.Traveler_id, t.Traveler_Name, p.Description AS Package_Description, p.Price
FROM Traveler t
JOIN Booking b ON b.Traveler_id = t.Traveler_id
JOIN Package p ON p.Package_id = b.Package_id
WHERE p.Price > (SELECT AVG(Price) FROM Package)
ORDER BY p.Price DESC;

-- 2) Revenue by package
SELECT p.Package_id, p.Description, SUM(pay.Amount) AS Total_Revenue
FROM Package p
JOIN Booking b ON b.Package_id = p.Package_id
JOIN Payments pay ON pay.Booking_id = b.Booking_id
GROUP BY p.Package_id, p.Description
ORDER BY Total_Revenue DESC;

-- 3) Insurance adoption percentage
SELECT
    COUNT(CASE WHEN Insurance_opted = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS Insurance_Adoption_Percent
FROM Booking;

-- 4) Average traveler rating
SELECT t.Traveler_id, t.Traveler_Name, AVG(CAST(r.Rating AS DECIMAL(10,2))) AS Avg_Rating
FROM Traveler t
JOIN Review r ON r.Traveller_Id = t.Traveler_id
GROUP BY t.Traveler_id, t.Traveler_Name
ORDER BY Avg_Rating DESC;

-- 5) Service associates under each operations manager
SELECT om.Managers_ID, e.Employee_Name AS Manager_Name, COUNT(sa.Associate_ID) AS Associate_Count
FROM Operations_Managers om
JOIN Employees e ON e.Employee_id = om.Employee_id
LEFT JOIN Service_Associate sa ON sa.Operation_Manager_ID = om.Managers_ID
GROUP BY om.Managers_ID, e.Employee_Name
ORDER BY Associate_Count DESC;

-- 6) Net payroll payout by employee
SELECT
    e.Employee_id,
    e.Employee_Name,
    p.Pay_date,
    (p.Salary + p.Bonus - p.Deduction) AS Net_Payout
FROM Payroll p
JOIN Employees e ON e.Employee_id = p.Employee_id
ORDER BY Net_Payout DESC;

-- 7) Spacecraft mapped to package demand
SELECT
    s.Spacecraft_id,
    s.Spacecraft_name,
    s.Status,
    COUNT(b.Booking_id) AS Booking_Count
FROM Spacecraft s
LEFT JOIN Booking b ON b.Package_id = s.Package_id
GROUP BY s.Spacecraft_id, s.Spacecraft_name, s.Status
ORDER BY Booking_Count DESC;

-- 8) Voyage payment summary
SELECT
    v.Voyage_id,
    v.Destination_details,
    COUNT(pay.Payment_id) AS Number_Of_Payments,
    SUM(pay.Amount) AS Total_Amount,
    AVG(CAST(pay.Amount AS DECIMAL(10,2))) AS Avg_Amount
FROM Voyage_Info v
LEFT JOIN Payments pay ON pay.Voyage_id = v.Voyage_id
GROUP BY v.Voyage_id, v.Destination_details
ORDER BY Total_Amount DESC;

-- 9) Crew allocation by spacecraft role
SELECT
    s.Spacecraft_name,
    c.Crew_Role,
    COUNT(c.Crew_ID) AS Crew_Count
FROM Crew c
JOIN Spacecraft s ON s.Spacecraft_id = c.Spacecraft_id
GROUP BY s.Spacecraft_name, c.Crew_Role
ORDER BY s.Spacecraft_name, Crew_Count DESC;

-- 10) Travelers with comprehensive insurance coverage
SELECT DISTINCT
    t.Traveler_id,
    t.Traveler_Name,
    i.Type_of_insurance
FROM Traveler t
JOIN Booking b ON b.Traveler_id = t.Traveler_id
JOIN Insurance i ON i.Booking_id = b.Booking_id
WHERE i.Type_of_insurance = 'Comprehensive Coverage'
ORDER BY t.Traveler_Name;
