-- Beyond Horizon Inc. - Performance Index Recommendations
-- Safe to run multiple times. Uses IF NOT EXISTS guards for SQL Server.

SET NOCOUNT ON;

-- Booking access paths
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Booking_TravelerId' AND object_id = OBJECT_ID('Booking'))
    CREATE INDEX IX_Booking_TravelerId ON Booking(Traveler_id);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Booking_PackageId' AND object_id = OBJECT_ID('Booking'))
    CREATE INDEX IX_Booking_PackageId ON Booking(Package_id);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Booking_BookingDate' AND object_id = OBJECT_ID('Booking'))
    CREATE INDEX IX_Booking_BookingDate ON Booking(Booking_date);

-- Payments reporting paths
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Payments_BookingId' AND object_id = OBJECT_ID('Payments'))
    CREATE INDEX IX_Payments_BookingId ON Payments(Booking_id);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Payments_VoyageId' AND object_id = OBJECT_ID('Payments'))
    CREATE INDEX IX_Payments_VoyageId ON Payments(Voyage_id);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Payments_PaymentDate' AND object_id = OBJECT_ID('Payments'))
    CREATE INDEX IX_Payments_PaymentDate ON Payments(Payment_date) INCLUDE (Amount, Payment_status, Payment_method);

-- Traveler reviews and service analytics
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Review_TravellerId' AND object_id = OBJECT_ID('Review'))
    CREATE INDEX IX_Review_TravellerId ON Review(Traveller_Id);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Service_Associate_ManagerId' AND object_id = OBJECT_ID('Service_Associate'))
    CREATE INDEX IX_Service_Associate_ManagerId ON Service_Associate(Operation_Manager_ID);

-- Voyage and spacecraft joins
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Voyage_Info_SpacecraftId' AND object_id = OBJECT_ID('Voyage_Info'))
    CREATE INDEX IX_Voyage_Info_SpacecraftId ON Voyage_Info(Spacecraft_ID);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Spacecraft_PackageId' AND object_id = OBJECT_ID('Spacecraft'))
    CREATE INDEX IX_Spacecraft_PackageId ON Spacecraft(Package_id);

-- Insurance and certification lookups
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Insurance_BookingId' AND object_id = OBJECT_ID('Insurance'))
    CREATE INDEX IX_Insurance_BookingId ON Insurance(Booking_id);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Certifications_VoyageId' AND object_id = OBJECT_ID('Certifications'))
    CREATE INDEX IX_Certifications_VoyageId ON Certifications(Voyage_id);

PRINT 'Index deployment complete.';
