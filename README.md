Beyond Horizon Inc. – An End-to-End SQL Database Project

1 🚀 Welcome to Beyond Horizon Inc.
Exploring the Cosmos with Data

Imagine Beyond Horizon Inc. as a futuristic space tourism company operating in the year 2080, where space travel is no longer science fiction.
You’re about to book your first interplanetary journey.

Hold on—do we even have a database to make this booking?
This project takes you on a technical SQL database journey before you lift off into space.

2 🌌 Company Overview
Staff of 300+ space enthusiasts
Offers customizable space travel packages
Prioritizes safety, sustainability, and personalized service
Database tracks everything: customers, spacecraft, crew, bookings, insurance, and more
3 🧠 Project Vision
Goal:
Design and implement an end-to-end relational database system from scratch to support the futuristic operations of a space tourism company.

What We Did: - Built everything from the ground up: - Created conceptual database diagrams - Designed Entity-Relationship Diagrams (ERDs) reflecting real-world assumptions - Developed and normalized 20+ SQL tables - Populated with sample data for simulation and analysis - Ensured full data integrity, modularity, and query efficiency

4 🧱 Database Architecture
4.1 🧮 Conceptual DB Diagram
Database Layout
![image](https://github.com/user-attachments/assets/8a750856-e52b-456d-8549-6ab69dc76340)

Database Layout
Tables Created: - traveller, booking, package, insurance, medical_metrics
- crew, certifications, voyage, spacecraft
- payments, payroll, operations_manager, service_associate and more.

4.2 🔗 Final ERD Diagram
Entity Relationship Diagram
![image](https://github.com/user-attachments/assets/b445bcb4-f2e7-4b0f-bdfa-22ca8ac20609)

Entity Relationship Diagram
🎯 Each table is linked via primary and foreign keys to ensure referential integrity, eliminate redundancy, and support efficient query performance.

4.3 🧾 Sample Table
Employee Table
![image](https://github.com/user-attachments/assets/668b6a67-07ec-434a-8a05-0aee7b477026)

Employee Table
5 🧠 Time for some querying
5.1 1. Travelers who booked above-average priced packages
SELECT T.traveler_id, T.name, B.price
FROM traveler T
JOIN booking B ON T.traveler_id = B.traveler_id
WHERE B.price > (SELECT AVG(price) FROM booking);

5.2 2. Average heart rate for insured travelers
SELECT AVG(M.heart_rate) AS avg_heart_rate
FROM medical_metrics M
JOIN insurance I ON M.traveler_id = I.traveler_id;

5.3 3. Spacecraft with highest avg traveler age
SELECT S.spacecraft_model, AVG(T.age) AS avg_age
FROM traveler T
JOIN booking B ON T.traveler_id = B.traveler_id
JOIN spacecraft S ON B.spacecraft_id = S.spacecraft_id
GROUP BY S.spacecraft_model
ORDER BY avg_age DESC
LIMIT 1;

5.4 4. Travelers with service ratings above 4
SELECT T.traveler_id, T.name, R.rating
FROM traveler T
JOIN review R ON T.traveler_id = R.traveler_id
WHERE R.rating > 4;

5.5 5. Credit Card Users
SELECT DISTINCT T.traveler_id, T.name
FROM traveler T
JOIN payments P ON T.traveler_id = P.traveler_id
WHERE P.payment_method = 'Credit Card';

and many more…I will leave it to your creativity with what kind of scenarios you can come up with.


6 🛠️ Tools & Technologies Used
SQL (DDL, DML)

ER Diagram Design Tools (e.g., Lucid chart, draw.io)

Google Slides

7 🧠 Skills Applied
SQL Queries (Joins, Aggregates, Sub queries)

Data Modeling & Normalization

Entity-Relationship Design

Data Integrity & Testing

Report Generation & Storytelling with Data

8 🙌 Thanks for Visiting

