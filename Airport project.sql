 CREATE DATABASE AIRPORT1;
Use AIRPORT1;
  
CREATE TABLE AIRLINES (
    AIRLINEID INT PRIMARY KEY AUTO_INCREMENT,
    AIRLINENAME VARCHAR(255) NOT NULL,
    CONTACTNUMBER VARCHAR(11) NOT NULL,
    CONTACTEMAIL VARCHAR(255) NOT NULL
);
 
CREATE TABLE FLIGHTS (
    FLIGHTID INT PRIMARY KEY AUTO_INCREMENT,
    FLIGHTNUMBER VARCHAR(10) NOT NULL,
    AIRLINEID INT,
    DEPARTUREAIRPORT VARCHAR(255),
    DEPARTURETERMINAL VARCHAR(10),
    DEPARTUREGATE VARCHAR(10),
    DEPARTURETIME DATETIME,
    ARRIVALAIRPORT VARCHAR(255),
    ARRIVALTERMINAL VARCHAR(10),
    ARRIVALGATE VARCHAR(10),
    ARRIVALTIME DATETIME,
    FLIGHTSTATUS VARCHAR(20),
    FOREIGN KEY (AIRLINEID) REFERENCES AIRLINES(AIRLINEID)
);

 

CREATE TABLE PASSENGERS (
    PASSENGERID INT PRIMARY KEY,
    FIRSTNAME VARCHAR(255) NOT NULL,
    LASTNAME VARCHAR(255) NOT NULL,
    GENDER VARCHAR(10) NOT NULL,
    DATEOFBIRTH DATE NOT NULL,
    NATIONALITY VARCHAR(255) NOT NULL,
    CONTACTNUMBER VARCHAR(20) NOT NULL,
    EMAILADDRESS VARCHAR(255) NOT NULL,
    PASSPORTORIDNUMBER VARCHAR(20) NOT NULL,
    FLIGHTID INT NOT NULL,
    FOREIGN KEY (FLIGHTID) REFERENCES FLIGHTS(FLIGHTID)
);

CREATE TABLE BAGGAGE (
    BAGGAGEID INT PRIMARY KEY,
    PASSENGERID INT NOT NULL,
    FLIGHTID INT NOT NULL,
    BAGGAGETAGNUMBER VARCHAR(20) NOT NULL,
    BAGGAGEWEIGHT DECIMAL(10, 2) NOT NULL,
    BAGGAGESTATUS VARCHAR(20) NOT NULL,
    BAGGAGELOCATION VARCHAR(255) NOT NULL,
    FOREIGN KEY (PASSENGERID) REFERENCES PASSENGERS(PASSENGERID),
    FOREIGN KEY (FLIGHTID) REFERENCES FLIGHTS(FLIGHTID)
);

CREATE TABLE SECURITYCHECKPOINTS (
    CHECKPOINTID INT PRIMARY KEY,
    CHECKPOINTNAME VARCHAR(255) NOT NULL,
    CHECKPOINTLOCATION VARCHAR(255) NOT NULL
);

CREATE TABLE SECURITYSCREENING (
    SCREENINGID INT PRIMARY KEY,
    CHECKPOINTID INT NOT NULL,
    PASSENGERID INT NOT NULL,
    FLIGHTID INT NOT NULL,
    SCREENINGTIME DATETIME NOT NULL,
    SCREENINGRESULT VARCHAR(20) NOT NULL,
    FOREIGN KEY (CHECKPOINTID) REFERENCES SECURITYCHECKPOINTS(CHECKPOINTID),
    FOREIGN KEY (PASSENGERID) REFERENCES PASSENGERS(PASSENGERID),
    FOREIGN KEY (FLIGHTID) REFERENCES FLIGHTS(FLIGHTID)
);

CREATE TABLE SEATINFORMATION (
    SEATID INT PRIMARY KEY,
    SEATNUMBER VARCHAR(10) NOT NULL,
    SEATCLASS VARCHAR(50) NOT NULL,
    AVAILABILITYSTATUS VARCHAR(20) NOT NULL,
    FLIGHTID INT NOT NULL,
    FOREIGN KEY (FLIGHTID) REFERENCES FLIGHTS(FLIGHTID)
);
 

CREATE TABLE BOARDINGPASS (
    BOARDINGPASSID INT PRIMARY KEY,
    PASSENGERID INT NOT NULL,
    SCREENINGID INT NOT NULL,
    FLIGHTID INT NOT NULL,
    CHECKPOINTID INT NOT NULL,
    SEATID INT NOT NULL,
    FOREIGN KEY (PASSENGERID) REFERENCES PASSENGERS(PASSENGERID),
    FOREIGN KEY (SCREENINGID) REFERENCES SECURITYSCREENING(SCREENINGID),
    FOREIGN KEY (FLIGHTID) REFERENCES FLIGHTS(FLIGHTID),
    FOREIGN KEY (CHECKPOINTID) REFERENCES SECURITYCHECKPOINTS(CHECKPOINTID),
    FOREIGN KEY (SEATID) REFERENCES SEATINFORMATION(SEATID)
);

CREATE TABLE GATES (
    GATEID INT PRIMARY KEY,
    GATENUMBER VARCHAR(10) NOT NULL,
    LOCATION VARCHAR(255) NOT NULL,
    AVAILABILITYSTATUS VARCHAR(20) NOT NULL
);

CREATE TABLE FLIGHTCATERING (
    CATERINGID INT PRIMARY KEY,
    CATERINGNAME VARCHAR(255) NOT NULL,
    LOCATION VARCHAR(255) NOT NULL
);

CREATE TABLE FUELING (
    FUELINGID INT PRIMARY KEY,
    FUELINGPROVIDER VARCHAR(255) NOT NULL,
    FUELTYPE VARCHAR(50) NOT NULL,
    FUELAMOUNT INT NOT NULL,
    UNITOFMEASURE VARCHAR(20) NOT NULL,
    FUELINGDATETIME DATETIME NOT NULL,
    FLIGHTID INT NOT NULL,
    FOREIGN KEY (FLIGHTID) REFERENCES FLIGHTS(FLIGHTID)
);

CREATE TABLE CONTROLTOWER (
    TOWERID INT PRIMARY KEY,
    TOWERNAME VARCHAR(255) NOT NULL,
    LOCATION VARCHAR(255) NOT NULL,
    CONTACTNUMBER VARCHAR(20) NOT NULL
);

CREATE TABLE FLIGHTCREW (
    CREWID INT PRIMARY KEY,
    FIRSTNAME VARCHAR(255) NOT NULL,
    LASTNAME VARCHAR(255) NOT NULL,
    GENDER VARCHAR(10) NOT NULL,
    DATEOFBIRTH DATE NOT NULL,
    NATIONALITY VARCHAR(255) NOT NULL,
    CONTACTNUMBER VARCHAR(20) NOT NULL,
    EMAILADDRESS VARCHAR(255) NOT NULL,
    POSITION VARCHAR(255) NOT NULL,
    FLIGHTID INT NOT NULL,
    FOREIGN KEY (FLIGHTID) REFERENCES FLIGHTS(FLIGHTID)
);

CREATE TABLE TERMINAL (
    TERMINALID INT PRIMARY KEY,
    TERMINALNAME VARCHAR(255) NOT NULL,
    LOCATION VARCHAR(255) NOT NULL,
    CAPACITY INT NOT NULL,
    CONTACTNUMBER VARCHAR(20) NOT NULL
);

CREATE TABLE AIRCRAFT (
    AIRCRAFTID INT PRIMARY KEY,
    FLIGHTID INT NOT NULL,
    GATEID INT NOT NULL,
    BOARDINGPASSID INT NOT NULL,
    CATERINGID INT NOT NULL,
    FUELINGID INT NOT NULL,
    TOWERID INT NOT NULL,
    SEATID INT NOT NULL,
    CREWID INT NOT NULL,
    TERMINALID INT NOT NULL, 
    FOREIGN KEY (FLIGHTID) REFERENCES FLIGHTS(FLIGHTID),
    FOREIGN KEY (GATEID) REFERENCES GATES(GATEID),
    FOREIGN KEY (BOARDINGPASSID) REFERENCES BOARDINGPASS(BOARDINGPASSID),
    FOREIGN KEY (CATERINGID) REFERENCES FLIGHTCATERING(CATERINGID),
    FOREIGN KEY (FUELINGID) REFERENCES FUELING(FUELINGID),
    FOREIGN KEY (TOWERID) REFERENCES CONTROLTOWER(TOWERID),
    FOREIGN KEY (SEATID) REFERENCES SEATINFORMATION(SEATID),
    FOREIGN KEY (CREWID) REFERENCES FLIGHTCREW(CREWID),
    FOREIGN KEY (TERMINALID) REFERENCES TERMINAL(TERMINALID)
);
CREATE TABLE EmployeeRoles (
    RoleID INT PRIMARY KEY,
    RoleName VARCHAR(255) NOT NULL
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Nationality VARCHAR(255) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    EmailAddress VARCHAR(255) NOT NULL,
    RoleID INT NOT NULL,
    FOREIGN KEY (RoleID) REFERENCES EmployeeRoles(RoleID)
);

CREATE INDEX idx_flights_airlineid ON FLIGHTS (AIRLINEID);
CREATE INDEX idx_passengers_flightid ON PASSENGERS (FLIGHTID);
CREATE INDEX idx_boardingpass_flightid ON BOARDINGPASS (FLIGHTID);
CREATE INDEX idx_boardingpass_passengerid ON BOARDINGPASS (PASSENGERID);
CREATE INDEX idx_baggage_passengerid ON BAGGAGE (PASSENGERID);
CREATE INDEX idx_baggage_flightid ON BAGGAGE (FLIGHTID);
CREATE INDEX idx_flightcrew_flightid ON FLIGHTCREW (FLIGHTID);
CREATE INDEX idx_securityscreening_flightid ON SECURITYSCREENING (FLIGHTID);

 
 -- Inserting values into the AIRLINES table
INSERT INTO AIRLINES (AIRLINEID, AIRLINENAME, CONTACTNUMBER, CONTACTEMAIL) VALUES
(1, 'Emirates', '1234567890', 'contact@emirates.com'),
(2, 'British Airways', '9876543210', 'contact@britishairways.com'),
(3, 'Singapore Airlines', '4561237890', 'contact@singaporeairlines.com'),
(4, 'American Airlines', '7890123456', 'contact@aa.com'),
(5, 'Lufthansa', '2109876543', 'contact@lufthansa.com'),
(6, 'Qatar Airways', '6543210987', 'contact@qatarairways.com'),
(7, 'Air France', '3210987654', 'contact@airfrance.com'),
(8, 'Cathay Pacific', '8765432109', 'contact@cathaypacific.com'),
(9, 'Etihad Airways', '9876543210', 'contact@etihad.com'),
(10, 'Delta Air Lines', '5432109876', 'contact@delta.com');

-- Inserting values into the FLIGHTS table
INSERT INTO FLIGHTS (FLIGHTID, FLIGHTNUMBER, AIRLINEID, DEPARTUREAIRPORT, DEPARTURETERMINAL, DEPARTUREGATE, DEPARTURETIME, ARRIVALAIRPORT, ARRIVALTERMINAL, ARRIVALGATE, ARRIVALTIME, FLIGHTSTATUS) VALUES
(1, 'EK001', 1, 'Dubai International Airport', 'Terminal 3', 'Gate A1', '2024-05-20 10:00:00', 'Heathrow Airport', 'Terminal 5', 'Gate B3', '2024-05-20 15:30:00', 'On Time'),
(2, 'BA002', 2, 'Heathrow Airport', 'Terminal 5', 'Gate C2', '2024-05-21 09:30:00', 'John F. Kennedy International Airport', 'Terminal 4', 'Gate D4', '2024-05-21 16:45:00', 'Delayed'),
(3, 'SQ003', 3, 'Changi Airport', 'Terminal 2', 'Gate E1', '2024-05-22 08:00:00', 'Los Angeles International Airport', 'Terminal 7', 'Gate F5', '2024-05-22 18:00:00', 'On Time'),
(4, 'AA004', 4, 'Dallas/Fort Worth International Airport', 'Terminal A', 'Gate G1', '2024-05-23 09:15:00', 'Heathrow Airport', 'Terminal 5', 'Gate B5', '2024-05-23 16:30:00', 'On Time'),
(5, 'LH005', 5, 'Frankfurt Airport', 'Terminal 1', 'Gate H3', '2024-05-24 11:00:00', 'Changi Airport', 'Terminal 3', 'Gate I2', '2024-05-24 20:45:00', 'On Time'),
(6, 'QR006', 6, 'Hamad International Airport', 'Terminal 2', 'Gate J2', '2024-05-25 10:30:00', 'Dubai International Airport', 'Terminal 3', 'Gate A2', '2024-05-25 16:15:00', 'On Time'),
(7, 'AF007', 7, 'Charles de Gaulle Airport', 'Terminal 3', 'Gate K1', '2024-05-26 08:45:00', 'Heathrow Airport', 'Terminal 5', 'Gate B4', '2024-05-26 14:00:00', 'On Time'),
(8, 'CX008', 8, 'Hong Kong International Airport', 'Terminal 1', 'Gate L2', '2024-05-27 09:00:00', 'Changi Airport', 'Terminal 4', 'Gate J3', '2024-05-27 17:30:00', 'On Time'),
(9, 'EY009', 9, 'Abu Dhabi International Airport', 'Terminal 3', 'Gate M3', '2024-05-28 07:30:00', 'Heathrow Airport', 'Terminal 5', 'Gate B2', '2024-05-28 13:45:00', 'On Time'),
(10, 'DL010', 10, 'Hartsfield-Jackson Atlanta International Airport', 'Terminal N', 'Gate O1', '2024-05-29 10:15:00', 'Changi Airport', 'Terminal 2', 'Gate K4', '2024-05-29 18:30:00', 'On Time');

-- Inserting values into the PASSENGERS table
INSERT INTO PASSENGERS (PASSENGERID, FIRSTNAME, LASTNAME, GENDER, DATEOFBIRTH, NATIONALITY, CONTACTNUMBER, EMAILADDRESS, PASSPORTORIDNUMBER, FLIGHTID) VALUES
(1, 'John', 'Doe', 'Male', '1990-02-15', 'US', '1234567890', 'john.doe@example.com', 'AB123456', 1),
(2, 'Alice', 'Smith', 'Female', '1985-06-20', 'UK', '9876543210', 'alice.smith@example.com', 'CD987654', 2),
(3, 'Mohammed', 'Ali', 'Male', '1978-09-10', 'UAE', '4561237890', 'mohammed.ali@example.com', 'EF456789', 3),
(4, 'Fatima', 'Ahmed', 'Female', '1995-04-25', 'Qatar', '7890123456', 'fatima.ahmed@example.com', 'GH012345', 4),
(5, 'Michael', 'Brown', 'Male', '1982-11-30', 'Germany', '2109876543', 'michael.brown@example.com', 'IJ345678', 5),
(6, 'Sara', 'Garcia', 'Female', '1991-08-12', 'Spain', '6543210987', 'sara.garcia@example.com', 'KL456789', 6),
(7, 'Ali', 'Khan', 'Male', '1989-03-18', 'Pakistan', '3210987654', 'ali.khan@example.com', 'MN567890', 7),
(8, 'Emily', 'Davis', 'Female', '1993-07-05', 'Canada', '8765432109', 'emily.davis@example.com', 'OP678901', 8),
(9, 'Ahmed', 'Mohamed', 'Male', '1987-01-22', 'Egypt', '9876543210', 'ahmed.mohamed@example.com', 'QR789012', 9),
(10, 'Sophia', 'Kim', 'Female', '1984-05-15', 'South Korea', '5432109876', 'sophia.kim@example.com', 'ST890123', 10),
(11, 'Youssef', 'Ibrahim', 'Male', '1983-09-28', 'Egypt', '1112223333', 'youssef.ibrahim@example.com', 'UV901234', 1),
(12, 'Aisha', 'Khan', 'Female', '1986-12-03', 'Pakistan', '4445556666', 'aisha.khan@example.com', 'WX012345', 2),
(13, 'Mohamed', 'Gaber', 'Male', '1992-04-16', 'Egypt', '7778889999', 'mohamed.gaber@example.com', 'YZ123456', 3),
(14, 'Nour', 'Salem', 'Female', '1990-08-22', 'Lebanon', '1011121314', 'nour.salem@example.com', 'AB234567', 4),
(15, 'Laila', 'Ismail', 'Female', '1988-11-07', 'Egypt', '1516171819', 'laila.ismail@example.com', 'CD345678', 5),
(16, 'Ahmed', 'Rashid', 'Male', '1980-06-14', 'UAE', '2021222324', 'ahmed.rashid@example.com', 'EF456789', 6),
(17, 'Yara', 'Nasser', 'Female', '1987-01-30', 'Lebanon', '2526272829', 'yara.nasser@example.com', 'GH567890', 7),
(18, 'Mehdi', 'Said', 'Male', '1984-03-25', 'Morocco', '3031323334', 'mehdi.said@example.com', 'IJ678901', 8),
(19, 'Lina', 'Abdel Rahman', 'Female', '1994-10-19', 'Jordan', '3536373839', 'lina.abdelrahman@example.com', 'KL789012', 9),
(20, 'Omar', 'Ali', 'Male', '1989-05-08', 'Syria', '4041424344', 'omar.ali@example.com', 'MN890123', 10);

-- Inserting values into the BAGGAGE table
INSERT INTO BAGGAGE (BAGGAGEID, PASSENGERID, FLIGHTID, BAGGAGETAGNUMBER, BAGGAGEWEIGHT, BAGGAGESTATUS, BAGGAGELOCATION) VALUES
(1, 1, 1, 'ABCD1234', 25.5, 'Checked-In', 'Dubai'),
(2, 2, 2, 'EFGH5678', 20.2, 'Checked-In', 'London'),
(3, 3, 3, 'IJKL91011', 15.8, 'Checked-In', 'Singapore'),
(4, 4, 4, 'MNOP121314', 18.6, 'Checked-In', 'Dallas'),
(5, 5, 5, 'QRST151617', 22.0, 'Checked-In', 'Frankfurt'),
(6, 6, 6, 'UVWX181920', 19.7, 'Checked-In', 'Doha'),
(7, 7, 7, 'YZAB212223', 21.3, 'Checked-In', 'Paris'),
(8, 8, 8, 'CDEF242526', 23.9, 'Checked-In', 'Hong Kong'),
(9, 9, 9, 'GHIJ272829', 24.1, 'Checked-In', 'Abu Dhabi'),
(10, 10, 10, 'KLMN303132', 17.4, 'Checked-In', 'Atlanta');

-- Inserting values into the SECURITYCHECKPOINTS table
INSERT INTO SECURITYCHECKPOINTS (CHECKPOINTID, CHECKPOINTNAME, CHECKPOINTLOCATION) VALUES
(1, 'Checkpoint A', 'Terminal 1'),
(2, 'Checkpoint B', 'Terminal 2'),
(3, 'Checkpoint C', 'Terminal 3');

-- Inserting values into the SECURITYSCREENING table
INSERT INTO SECURITYSCREENING (SCREENINGID, CHECKPOINTID, PASSENGERID, FLIGHTID, SCREENINGTIME, SCREENINGRESULT) VALUES
(1, 1, 1, 1, '2024-05-20 07:00:00', 'Passed'),
(2, 2, 2, 2, '2024-05-21 08:30:00', 'Passed'),
(3, 3, 3, 3, '2024-05-22 09:15:00', 'Passed'),
(4, 1, 4, 4, '2024-05-23 10:45:00', 'Passed'),
(5, 2, 5, 5, '2024-05-24 08:30:00', 'Passed'),
(6, 3, 6, 6, '2024-05-25 09:45:00', 'Passed'),
(7, 1, 7, 7, '2024-05-26 06:30:00', 'Passed'),
(8, 2, 8, 8, '2024-05-27 08:00:00', 'Passed'),
(9, 3, 9, 9, '2024-05-28 09:00:00', 'Passed'),
(10, 1, 10, 10, '2024-05-29 10:30:00', 'Passed'),
(11, 1, 11, 1, '2024-05-20 07:15:00', 'Passed'),
(12, 2, 12, 2, '2024-05-21 08:45:00', 'Passed'),
(13, 3, 13, 3, '2024-05-22 09:30:00', 'Passed'),
(14, 1, 14, 4, '2024-05-23 10:15:00', 'Passed'),
(15, 2, 15, 5, '2024-05-24 08:45:00', 'Passed'),
(16, 3, 16, 6, '2024-05-25 10:00:00', 'Passed'),
(17, 1, 17, 7, '2024-05-26 07:45:00', 'Passed'),
(18, 2, 18, 8, '2024-05-27 09:00:00', 'Passed'),
(19, 3, 19, 9, '2024-05-28 10:15:00', 'Passed'),
(20, 1, 20, 10, '2024-05-29 06:45:00', 'Passed');

-- Inserting values into the SEATINFORMATION table
INSERT INTO SEATINFORMATION (SEATID, SEATNUMBER, SEATCLASS, AVAILABILITYSTATUS, FLIGHTID) VALUES
(1, 'A001', 'First Class', 'Available', 1),
(2, 'B002', 'Business Class', 'Available', 2),
(3, 'C003', 'Economy Class', 'Available', 3),
(4, 'D004', 'First Class', 'Available', 4),
(5, 'E005', 'Business Class', 'Available', 5),
(6, 'F006', 'Economy Class', 'Available', 6),
(7, 'G007', 'First Class', 'Available', 7),
(8, 'H008', 'Business Class', 'Available', 8),
(9, 'I009', 'Economy Class', 'Available', 9),
(10, 'J010', 'First Class', 'Available', 10);

-- Inserting values into the BOARDINGPASS table
INSERT INTO BOARDINGPASS (BOARDINGPASSID, PASSENGERID, SCREENINGID, FLIGHTID, CHECKPOINTID, SEATID) VALUES
(1, 1, 1, 1, 1, 1),
(2, 2, 2, 2, 2, 2),
(3, 3, 3, 3, 3, 3),
(4, 4, 4, 4, 1, 4),
(5, 5, 5, 5, 2, 5),
(6, 6, 6, 6, 3, 6),
(7, 7, 7, 7, 1, 7),
(8, 8, 8, 8, 2, 8),
(9, 9, 9, 9, 3, 9),
(10, 10, 10, 10, 1, 10),
(11, 11, 11, 1, 1, 1),
(12, 12, 12, 2, 2, 2),
(13, 13, 13, 3, 3, 3),
(14, 14, 14, 4, 1, 4),
(15, 15, 15, 5, 2, 5),
(16, 16, 16, 6, 3, 6),
(17, 17, 17, 7, 1, 7),
(18, 18, 18, 8, 2, 8),
(19, 19, 19, 9, 3, 9),
(20, 20, 20, 10, 1, 10);

-- Inserting values into the GATES table
INSERT INTO GATES (GATEID, GATENUMBER, LOCATION, AVAILABILITYSTATUS) VALUES
(1, 'Gate A1', 'Terminal 1', 'Available'),
(2, 'Gate B2', 'Terminal 2', 'Available'),
(3, 'Gate C3', 'Terminal 3', 'Available'),
(4, 'Gate D4', 'Terminal 4', 'Available'),
(5, 'Gate E5', 'Terminal 5', 'Available'),
(6, 'Gate F6', 'Terminal 6', 'Available'),
(7, 'Gate G7', 'Terminal 7', 'Available'),
(8, 'Gate H8', 'Terminal 8', 'Available'),
(9, 'Gate I9', 'Terminal 9', 'Available'),
(10, 'Gate J10', 'Terminal 10', 'Available');

-- Inserting values into the FLIGHTCATERING table
INSERT INTO FLIGHTCATERING (CATERINGID, CATERINGNAME, LOCATION) VALUES
(1, 'Sky Catering Services', 'Terminal 1'),
(2, 'Global Inflight Services', 'Terminal 2'),
(3, 'Delicious Airline Catering', 'Terminal 3'),
(4, 'Elevate Catering Solutions', 'Terminal 4'),
(5, 'Air Gourmet', 'Terminal 5'),
(6, 'Flight Cuisine Catering', 'Terminal 6'),
(7, 'Above and Beyond Catering', 'Terminal 7'),
(8, 'Aero Kitchen', 'Terminal 8'),
(9, 'Culinary Concepts', 'Terminal 9'),
(10, 'Airline Catering Group', 'Terminal 10');

-- Inserting values into the FUELING table
INSERT INTO FUELING (FUELINGID, FUELINGPROVIDER, FUELTYPE, FUELAMOUNT, UNITOFMEASURE, FUELINGDATETIME, FLIGHTID) VALUES
(1, 'Jet Fuel Supply Co.', 'Jet A-1', 10000, 'Liters', '2024-05-20 06:30:00', 1),
(2, 'Aviation Fuel Services', 'Jet A', 12000, 'Liters', '2024-05-21 07:45:00', 2),
(3, 'Sky Petroleum', 'Avgas', 15000, 'Liters', '2024-05-22 08:15:00', 3),
(4, 'Global Fuel Solutions', 'Jet B', 8000, 'Liters', '2024-05-23 09:00:00', 4),
(5, 'Aero Energy', 'Jet A-1', 11000, 'Liters', '2024-05-24 10:30:00', 5),
(6, 'Air Fuel Systems', 'Jet A', 13000, 'Liters', '2024-05-25 11:15:00', 6),
(7, 'Fuel Express', 'Avgas', 14000, 'Liters', '2024-05-26 12:00:00', 7),
(8, 'Jetstream Fuels', 'Jet B', 9000, 'Liters', '2024-05-27 06:45:00', 8),
(9, 'AeroFuel', 'Jet A-1', 10000, 'Liters', '2024-05-28 07:30:00', 9),
(10, 'Global Aviation Services', 'Jet A', 12000, 'Liters', '2024-05-29 08:00:00', 10);

-- Inserting values into the CONTROLTOWER table
INSERT INTO CONTROLTOWER (TOWERID, TOWERNAME, LOCATION, CONTACTNUMBER) VALUES
(1, 'Tower A', 'Terminal 1', '1234567890'),
(2, 'Tower B', 'Terminal 2', '9876543210'),
(3, 'Tower C', 'Terminal 3', '4561237890'),
(4, 'Tower D', 'Terminal 4', '7890123456'),
(5, 'Tower E', 'Terminal 5', '2109876543'),
(6, 'Tower F', 'Terminal 6', '6543210987'),
(7, 'Tower G', 'Terminal 7', '3210987654'),
(8, 'Tower H', 'Terminal 8', '8765432109'),
(9, 'Tower I', 'Terminal 9', '9876543210'),
(10, 'Tower J', 'Terminal 10', '5432109876');

-- Inserting values into the FLIGHTCREW table
INSERT INTO FLIGHTCREW (CREWID, FIRSTNAME, LASTNAME, GENDER, DATEOFBIRTH, NATIONALITY, CONTACTNUMBER, EMAILADDRESS, POSITION, FLIGHTID) VALUES
(1, 'Michael', 'Johnson', 'Male', '1980-01-10', 'US', '1234567890', 'michael.johnson@example.com', 'Captain', 1),
(2, 'Emily', 'Brown', 'Female', '1985-03-20', 'UK', '9876543210', 'emily.brown@example.com', 'First Officer', 2),
(3, 'Ahmed', 'Ali', 'Male', '1982-06-15', 'UAE', '4561237890', 'ahmed.ali@example.com', 'Captain', 3),
(4, 'Fatima', 'Khan', 'Female', '1990-09-25', 'Qatar', '7890123456', 'fatima.khan@example.com', 'First Officer', 4),
(5, 'Thomas', 'Schmidt', 'Male', '1988-12-05', 'Germany', '2109876543', 'thomas.schmidt@example.com', 'Captain', 5),
(6, 'Sophie', 'Garcia', 'Female', '1984-04-12', 'Spain', '6543210987', 'sophie.garcia@example.com', 'First Officer', 6),
(7, 'Ali', 'Dubois', 'Male', '1989-07-18', 'France', '3210987654', 'ali.dubois@example.com', 'Captain', 7),
(8, 'Chun', 'Li', 'Male', '1983-10-30', 'China', '8765432109', 'chun.li@example.com', 'First Officer', 8),
(9, 'Omar', 'Ahmed', 'Male', '1987-02-22', 'Egypt', '9876543210', 'omar.ahmed@example.com', 'Captain', 9),
(10, 'Min', 'Park', 'Male', '1986-05-15', 'South Korea', '5432109876', 'min.park@example.com', 'First Officer', 10),
(11, 'Lara', 'Khalifa', 'Female', '1983-09-28', 'Lebanon', '1112223333', 'lara.khalifa@example.com', 'Captain', 1),
(12, 'Mohammed', 'Abdullah', 'Male', '1986-12-03', 'Pakistan', '4445556666', 'mohammed.abdullah@example.com', 'First Officer', 2),
(13, 'Yara', 'Said', 'Female', '1992-04-16', 'Lebanon', '7778889999', 'yara.said@example.com', 'Captain', 3),
(14, 'Nasser', 'Salem', 'Male', '1990-08-22', 'Lebanon', '1011121314', 'nasser.salem@example.com', 'First Officer', 4),
(15, 'Ibrahim', 'Ismail', 'Male', '1988-11-07', 'Egypt', '1516171819', 'ibrahim.ismail@example.com', 'Captain', 5),
(16, 'Rashid', 'Ali', 'Male', '1980-06-14', 'UAE', '2021222324', 'rashid.ali@example.com', 'First Officer', 6),
(17, 'Lina', 'Hassan', 'Female', '1987-01-30', 'Jordan', '2526272829', 'lina.hassan@example.com', 'Captain', 7),
(18, 'Mehdi', 'Saeed', 'Male', '1984-03-25', 'Morocco', '3031323334', 'mehdi.saeed@example.com', 'First Officer', 8),
(19, 'Abdel Rahman', 'Ahmed', 'Male', '1994-10-19', 'Sudan', '3536373839', 'abdelrahman.ahmed@example.com', 'Captain', 9),
(20, 'Amira', 'Said', 'Female', '1989-05-08', 'Syria', '4041424344', 'amira.said@example.com', 'First Officer', 10);

-- Inserting values into the TERMINAL table
INSERT INTO TERMINAL (TERMINALID, TERMINALNAME, LOCATION, CAPACITY, CONTACTNUMBER) VALUES
(1, 'Terminal 1', 'Dubai International Airport', 5000, '1234567890'),
(2, 'Terminal 2', 'Heathrow Airport', 5500, '9876543210'),
(3, 'Terminal 3', 'Changi Airport', 6000, '4561237890'),
(4, 'Terminal 4', 'Dallas/Fort Worth International Airport', 6500, '7890123456'),
(5, 'Terminal 5', 'Frankfurt Airport', 7000, '2109876543'),
(6, 'Terminal 6', 'Hamad International Airport', 7500, '6543210987'),
(7, 'Terminal 7', 'Charles de Gaulle Airport', 8000, '3210987654'),
(8, 'Terminal 8', 'Hong Kong International Airport', 8500, '8765432109'),
(9, 'Terminal 9', 'Cairo International Airport', 9000, '9876543210'),
(10, 'Terminal 10', 'Hartsfield-Jackson Atlanta International Airport', 9500, '5432109876');

-- Inserting values into the AIRCRAFT table
INSERT INTO AIRCRAFT (AIRCRAFTID, FLIGHTID, GATEID, BOARDINGPASSID, CATERINGID, FUELINGID, TOWERID, SEATID, CREWID, TERMINALID) VALUES
(1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(2, 2, 2, 2, 2, 2, 2, 2, 2, 2),
(3, 3, 3, 3, 3, 3, 3, 3, 3, 3),
(4, 4, 4, 4, 4, 4, 4, 4, 4, 4),
(5, 5, 5, 5, 5, 5, 5, 5, 5, 5),
(6, 6, 6, 6, 6, 6, 6, 6, 6, 6),
(7, 7, 7, 7, 7, 7, 7, 7, 7, 7),
(8, 8, 8, 8, 8, 8, 8, 8, 8, 8),
(9, 9, 9, 9, 9, 9, 9, 9, 9, 9),
(10, 10, 10, 10, 10, 10, 10, 10, 10, 10);

-- Inserting values into the EmployeeRoles table
INSERT INTO EmployeeRoles (RoleID, RoleName) VALUES
(1, 'Manager'),
(2, 'Supervisor'),
(3, 'Security Officer'),
(4, 'Flight Attendant'),
(5, 'Pilot'),
(6, 'Technician'),
(7, 'Customer Service Representative'),
(8, 'Cleaning Staff'),
(9, 'Catering Staff'),
(10, 'Ground Crew'),
(11, 'Air Traffic Controller'),
(12, 'Baggage Handler'),
(13, 'Check-in Agent'),
(14, 'Gate Agent'),
(15, 'Ramp Agent'),
(16, 'Aircraft Mechanic'),
(17, 'Dispatcher'),
(18, 'Safety Inspector'),
(19, 'Trainer'),
(20, 'Administrator'),
(21,'Cleaning staff');

-- Inserting values into the Employees table
INSERT INTO Employees (EmployeeID, FirstName, LastName, Gender, DateOfBirth, Nationality, ContactNumber, EmailAddress, RoleID) VALUES
(1, 'John', 'Doe', 'Male', '1980-05-15', 'USA', '1234567890', 'john.doe@example.com', 1),
(2, 'Jane', 'Smith', 'Female', '1985-09-20', 'UK', '9876543210', 'jane.smith@example.com', 2),
(3, 'Ahmed', 'Ali', 'Male', '1982-04-10', 'UAE', '4561237890', 'ahmed.ali@example.com', 3),
(4, 'Fatima', 'Khan', 'Female', '1990-07-25', 'Qatar', '7890123456', 'fatima.khan@example.com', 4),
(5, 'Michael', 'Johnson', 'Male', '1988-12-01', 'Canada', '2109876543', 'michael.johnson@example.com', 5),
(6, 'Sophie', 'Garcia', 'Female', '1984-06-12', 'France', '6543210987', 'sophie.garcia@example.com', 6),
(7, 'Ali', 'Dubois', 'Male', '1989-02-18', 'Belgium', '3210987654', 'ali.dubois@example.com', 7),
(8, 'Chun', 'Li', 'Male', '1983-10-30', 'China', '8765432109', 'chun.li@example.com', 8),
(9, 'Omar', 'Ahmed', 'Male', '1987-07-22', 'Egypt', '9876543210', 'omar.ahmed@example.com', 9),
(10, 'Min', 'Park', 'Male', '1986-05-15', 'South Korea', '5432109876', 'min.park@example.com', 10),
(11, 'Lara', 'Khalifa', 'Female', '1983-09-28', 'Lebanon', '1112223333', 'lara.khalifa@example.com', 11),
(12, 'Mohammed', 'Abdullah', 'Male', '1986-12-03', 'Pakistan', '4445556666', 'mohammed.abdullah@example.com', 12),
(13, 'Yara', 'Said', 'Female', '1992-04-16', 'Lebanon', '7778889999', 'yara.said@example.com', 13),
(14, 'Nasser', 'Salem', 'Male', '1990-08-22', 'Lebanon', '1011121314', 'nasser.salem@example.com', 14),
(15, 'Ibrahim', 'Ismail', 'Male', '1988-11-07', 'Egypt', '1516171819', 'ibrahim.ismail@example.com', 15),
(16, 'Rashid', 'Ali', 'Male', '1980-06-14', 'UAE', '2021222324', 'rashid.ali@example.com', 16),
(17, 'Lina', 'Hassan', 'Female', '1987-01-30', 'Jordan', '2526272829', 'lina.hassan@example.com', 17),
(18, 'Mehdi', 'Saeed', 'Male', '1984-03-25', 'Morocco', '3031323334', 'mehdi.saeed@example.com', 18),
(19, 'Abdel Rahman', 'Ahmed', 'Male', '1994-10-19', 'Sudan', '3536373839', 'abdelrahman.ahmed@example.com', 19),
(20, 'Amira', 'Said', 'Female', '1989-05-08', 'Syria', '4041424344', 'amira.said@example.com', 20),
(21, 'Mehru', 'Saeed', 'Female', '1994-03-25', 'Morocco', '3031923334', 'mehru.saeed@example.com', 21);


 SELECT F.FLIGHTNUMBER, A.AIRLINENAME
FROM FLIGHTS F
INNER JOIN AIRLINES A ON F.AIRLINEID = A.AIRLINEID;

SELECT F.FLIGHTNUMBER, BP.BOARDINGPASSID, BP.PASSENGERID, BP.SEATID
FROM FLIGHTS F
LEFT JOIN BOARDINGPASS BP ON F.FLIGHTID = BP.FLIGHTID;

SELECT P.PASSENGERID, P.FIRSTNAME, P.LASTNAME, F.FLIGHTNUMBER
FROM FLIGHTS F
RIGHT JOIN PASSENGERS P ON F.FLIGHTID = P.FLIGHTID;

SELECT F.FLIGHTNUMBER, FU.FUELINGID, FU.FUELTYPE, FU.FUELAMOUNT
FROM FLIGHTS F
LEFT JOIN FUELING FU ON F.FLIGHTID = FU.FLIGHTID
UNION
SELECT F.FLIGHTNUMBER, FU.FUELINGID, FU.FUELTYPE, FU.FUELAMOUNT
FROM FLIGHTS F
RIGHT JOIN FUELING FU ON F.FLIGHTID = FU.FLIGHTID;

SELECT F.FLIGHTNUMBER, FC.CATERINGNAME
FROM FLIGHTS F
CROSS JOIN FLIGHTCATERING FC;

SELECT P1.PASSENGERID AS Passenger1, P2.PASSENGERID AS Passenger2, P1.FLIGHTID
FROM PASSENGERS P1
INNER JOIN PASSENGERS P2 ON P1.FLIGHTID = P2.FLIGHTID
WHERE P1.PASSENGERID <> P2.PASSENGERID;

SELECT *
FROM PASSENGERS P
NATURAL JOIN BOARDINGPASS BP;

SELECT P.PASSENGERID, P.FIRSTNAME, P.LASTNAME, F.FLIGHTNUMBER, A.AIRLINENAME
FROM PASSENGERS P
INNER JOIN FLIGHTS F ON P.FLIGHTID = F.FLIGHTID
INNER JOIN AIRLINES A ON F.AIRLINEID = A.AIRLINEID;


SELECT P.PASSENGERID, P.FIRSTNAME, P.LASTNAME, F.FLIGHTNUMBER, F.DEPARTUREAIRPORT, F.ARRIVALAIRPORT
FROM PASSENGERS P
INNER JOIN FLIGHTS F ON P.FLIGHTID = F.FLIGHTID;

SELECT F.FLIGHTID, F.FLIGHTNUMBER, P.PASSENGERID, P.FIRSTNAME, P.LASTNAME
FROM FLIGHTS F
LEFT JOIN PASSENGERS P ON F.FLIGHTID = P.FLIGHTID;

SELECT P.PASSENGERID, P.FIRSTNAME, P.LASTNAME, F.FLIGHTID, F.FLIGHTNUMBER
FROM PASSENGERS P
RIGHT JOIN FLIGHTS F ON P.FLIGHTID = F.FLIGHTID;

SELECT F.FLIGHTID, F.FLIGHTNUMBER, P.PASSENGERID, P.FIRSTNAME, P.LASTNAME
FROM FLIGHTS F
LEFT JOIN PASSENGERS P ON F.FLIGHTID = P.FLIGHTID
UNION
SELECT F.FLIGHTID, F.FLIGHTNUMBER, P.PASSENGERID, P.FIRSTNAME, P.LASTNAME
FROM PASSENGERS P
LEFT JOIN FLIGHTS F ON P.FLIGHTID = F.FLIGHTID;

SELECT F1.FLIGHTNUMBER AS Flight1, F2.FLIGHTNUMBER AS Flight2, F1.DEPARTUREAIRPORT
FROM FLIGHTS F1
INNER JOIN FLIGHTS F2 ON F1.DEPARTUREAIRPORT = F2.DEPARTUREAIRPORT
WHERE F1.FLIGHTID <> F2.FLIGHTID;

SELECT P.PASSENGERID, P.FIRSTNAME, P.LASTNAME, F.FLIGHTID, F.FLIGHTNUMBER
FROM PASSENGERS P
CROSS JOIN FLIGHTS F;

SELECT *
FROM FLIGHTS NATURAL JOIN AIRLINES;

SELECT F.FLIGHTID, F.FLIGHTNUMBER, F.DEPARTUREAIRPORT, F.ARRIVALAIRPORT
FROM FLIGHTS F
INNER JOIN AIRLINES A ON F.AIRLINEID = A.AIRLINEID
WHERE A.AIRLINENAME = 'Emirates';

SELECT P.PASSENGERID, P.FIRSTNAME, P.LASTNAME, F.FLIGHTNUMBER, A.AIRLINENAME
FROM PASSENGERS P
INNER JOIN FLIGHTS F ON P.FLIGHTID = F.FLIGHTID
INNER JOIN AIRLINES A ON F.AIRLINEID = A.AIRLINEID;

SELECT F.FLIGHTID, F.FLIGHTNUMBER, COUNT(P.PASSENGERID) AS PassengerCount
FROM FLIGHTS F
LEFT JOIN PASSENGERS P ON F.FLIGHTID = P.FLIGHTID
GROUP BY F.FLIGHTID, F.FLIGHTNUMBER;
 
SELECT F.FLIGHTNUMBER, F.DEPARTUREAIRPORT, F.ARRIVALAIRPORT
FROM FLIGHTS F
JOIN PASSENGERS P ON F.FLIGHTID = P.FLIGHTID
WHERE P.LASTNAME = 'Smith';


 
SELECT P.PASSENGERID, P.FIRSTNAME, P.LASTNAME, F.FLIGHTNUMBER
FROM PASSENGERS P
JOIN FLIGHTS F ON P.FLIGHTID = F.FLIGHTID
ORDER BY F.FLIGHTNUMBER;

SELECT F.FLIGHTID, F.FLIGHTNUMBER, COUNT(P.PASSENGERID) AS PassengerCount
FROM FLIGHTS F
LEFT JOIN PASSENGERS P ON F.FLIGHTID = P.FLIGHTID
GROUP BY F.FLIGHTID, F.FLIGHTNUMBER
ORDER BY PassengerCount DESC
LIMIT 5;

SELECT P.PASSENGERID, P.FIRSTNAME, P.LASTNAME, F.FLIGHTNUMBER, F.DEPARTUREAIRPORT, F.ARRIVALAIRPORT
FROM PASSENGERS P
JOIN FLIGHTS F ON P.FLIGHTID = F.FLIGHTID
WHERE F.DEPARTUREAIRPORT = 'JFK' AND F.ARRIVALAIRPORT = 'LAX';

SELECT F1.FLIGHTNUMBER AS Flight1, F2.FLIGHTNUMBER AS Flight2, F1.DEPARTUREAIRPORT, F1.ARRIVALAIRPORT
FROM FLIGHTS F1
JOIN FLIGHTS F2 ON F1.DEPARTUREAIRPORT = F2.DEPARTUREAIRPORT AND F1.ARRIVALAIRPORT = F2.ARRIVALAIRPORT
WHERE F1.FLIGHTID <> F2.FLIGHTID;

SELECT A.AIRLINENAME, COUNT(F.FLIGHTID) AS NumberOfFlights
FROM AIRLINES A
JOIN FLIGHTS F ON A.AIRLINEID = F.AIRLINEID
GROUP BY A.AIRLINENAME
HAVING COUNT(F.FLIGHTID) > 5;

SELECT F.FLIGHTNUMBER, TIMESTAMPDIFF(HOUR, F.DEPARTURETIME, F.ARRIVALTIME) AS FlightDuration
FROM FLIGHTS F;

 
    
    SELECT 
    A.AIRLINENAME, 
    F.FLIGHTNUMBER, 
    P.FIRSTNAME, 
    P.LASTNAME
FROM 
    PASSENGERS P
JOIN 
    FLIGHTS F ON P.FLIGHTID = F.FLIGHTID
JOIN 
    AIRLINES A ON F.AIRLINEID = A.AIRLINEID
JOIN 
    (SELECT 
        F2.AIRLINEID, 
        F2.FLIGHTID, 
        COUNT(P2.PASSENGERID) AS PassengerCount
     FROM 
        PASSENGERS P2
     JOIN 
        FLIGHTS F2 ON P2.FLIGHTID = F2.FLIGHTID
     GROUP BY 
        F2.AIRLINEID, 
        F2.FLIGHTID
     ORDER BY 
        PassengerCount DESC
     LIMIT 1) AS Sub ON F.FLIGHTID = Sub.FLIGHTID;

 WITH FlightPassengerCounts AS (
    SELECT 
        F.FLIGHTID, 
        F.AIRLINEID, 
        COUNT(P.PASSENGERID) AS PassengerCount
    FROM 
        PASSENGERS P
    JOIN 
        FLIGHTS F ON P.FLIGHTID = F.FLIGHTID
    GROUP BY 
        F.FLIGHTID, 
        F.AIRLINEID
),
MaxPassengerFlights AS (
    SELECT 
        AIRLINEID, 
        MAX(PassengerCount) AS MaxPassengerCount
    FROM 
        FlightPassengerCounts
    GROUP BY 
        AIRLINEID
)
SELECT 
    A.AIRLINENAME, 
    F.FLIGHTNUMBER, 
    P.FIRSTNAME, 
    P.LASTNAME
FROM 
    PASSENGERS P
JOIN 
    FLIGHTS F ON P.FLIGHTID = F.FLIGHTID
JOIN 
    AIRLINES A ON F.AIRLINEID = A.AIRLINEID
JOIN 
    FlightPassengerCounts FPC ON F.FLIGHTID = FPC.FLIGHTID AND F.AIRLINEID = FPC.AIRLINEID
JOIN 
    MaxPassengerFlights MPF ON FPC.AIRLINEID = MPF.AIRLINEID AND FPC.PassengerCount = MPF.MaxPassengerCount;
    
    SELECT 
    BOARDINGPASS.BOARDINGPASSID,
    PASSENGERS.FIRSTNAME,
    PASSENGERS.LASTNAME,
    FLIGHTS.FLIGHTNUMBER,
    SEATINFORMATION.SEATNUMBER,
    SEATINFORMATION.SEATCLASS,
    BOARDINGPASS.SCREENINGID,
    BOARDINGPASS.CHECKPOINTID
FROM 
    BOARDINGPASS
JOIN 
    PASSENGERS ON BOARDINGPASS.PASSENGERID = PASSENGERS.PASSENGERID
JOIN 
    FLIGHTS ON BOARDINGPASS.FLIGHTID = FLIGHTS.FLIGHTID
JOIN 
    SEATINFORMATION ON BOARDINGPASS.SEATID = SEATINFORMATION.SEATID;
    
   
   SELECT 
    BAGGAGE.BAGGAGEID,
    BAGGAGE.BAGGAGETAGNUMBER,
    BAGGAGE.BAGGAGEWEIGHT,
    BAGGAGE.BAGGAGESTATUS,
    BAGGAGE.BAGGAGELOCATION,
    PASSENGERS.FIRSTNAME,
    PASSENGERS.LASTNAME,
    FLIGHTS.FLIGHTNUMBER
FROM 
    BAGGAGE
JOIN 
    PASSENGERS ON BAGGAGE.PASSENGERID = PASSENGERS.PASSENGERID
JOIN 
    FLIGHTS ON BAGGAGE.FLIGHTID = FLIGHTS.FLIGHTID;
    
    SELECT 
    FLIGHTS.FLIGHTID,
    FLIGHTS.FLIGHTNUMBER,
    AIRLINES.AIRLINENAME,
    FLIGHTS.DEPARTUREAIRPORT,
    FLIGHTS.DEPARTURETERMINAL,
    FLIGHTS.DEPARTUREGATE,
    FLIGHTS.DEPARTURETIME,
    FLIGHTS.ARRIVALAIRPORT,
    FLIGHTS.ARRIVALTERMINAL,
    FLIGHTS.ARRIVALGATE,
    FLIGHTS.ARRIVALTIME,
    FLIGHTS.FLIGHTSTATUS
FROM 
    FLIGHTS
JOIN 
    AIRLINES ON FLIGHTS.AIRLINEID = AIRLINES.AIRLINEID;

DELIMITER //

CREATE PROCEDURE GetFlightsByAirline(IN p_AirlineID INT)
BEGIN
    SELECT 
        FLIGHTS.FLIGHTID,
        FLIGHTS.FLIGHTNUMBER,
        FLIGHTS.DEPARTUREAIRPORT,
        FLIGHTS.DEPARTURETERMINAL,
        FLIGHTS.DEPARTUREGATE,
        FLIGHTS.DEPARTURETIME,
        FLIGHTS.ARRIVALAIRPORT,
        FLIGHTS.ARRIVALTERMINAL,
        FLIGHTS.ARRIVALGATE,
        FLIGHTS.ARRIVALTIME,
        FLIGHTS.FLIGHTSTATUS
    FROM 
        FLIGHTS
    WHERE 
        FLIGHTS.AIRLINEID = p_AirlineID;
END //

DELIMITER ;


DELIMITER //

DELIMITER //

CREATE PROCEDURE InsertPassenger (
    IN firstName VARCHAR(255),
    IN lastName VARCHAR(255),
    IN gender VARCHAR(10),
    IN dateOfBirth DATE,
    IN nationality VARCHAR(255),
    IN contactNumber VARCHAR(20),
    IN emailAddress VARCHAR(255),
    IN passportOrIDNumber VARCHAR(20),
    IN flightID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'An error occurred, insert operation rolled back.';
    END;
    
    START TRANSACTION;
    
    INSERT INTO PASSENGERS (FIRSTNAME, LASTNAME, GENDER, DATEOFBIRTH, NATIONALITY, CONTACTNUMBER, EMAILADDRESS, PASSPORTORIDNUMBER, FLIGHTID)
    VALUES (firstName, lastName, gender, dateOfBirth, nationality, contactNumber, emailAddress, passportOrIDNumber, flightID);
    
    COMMIT;
END //

 

DELIMITER ;


 

 
DELIMITER //

-- Create the stored procedure AssignCrewToFlight
CREATE PROCEDURE AssignCrewToFlight(
    IN p_FirstName VARCHAR(255),
    IN p_LastName VARCHAR(255),
    IN p_Gender VARCHAR(10),
    IN p_DateOfBirth DATE,
    IN p_Nationality VARCHAR(255),
    IN p_ContactNumber VARCHAR(20),
    IN p_EmailAddress VARCHAR(255),
    IN p_Position VARCHAR(255),
    IN p_FlightID INT
)
BEGIN
    INSERT INTO FLIGHTCREW (
        FIRSTNAME, 
        LASTNAME, 
        GENDER, 
        DATEOFBIRTH, 
        NATIONALITY, 
        CONTACTNUMBER, 
        EMAILADDRESS, 
        POSITION, 
        FLIGHTID
    ) VALUES (
        p_FirstName, 
        p_LastName, 
        p_Gender, 
        p_DateOfBirth, 
        p_Nationality, 
        p_ContactNumber, 
        p_EmailAddress, 
        p_Position, 
        p_FlightID
    );
END //

-- Reset the delimiter back to ';'
DELIMITER ;


DELIMITER //

CREATE PROCEDURE GetPassengerBaggage(
    IN p_PassengerID INT
)
BEGIN
    SELECT 
        BAGGAGE.BAGGAGEID,
        BAGGAGE.BAGGAGETAGNUMBER,
        BAGGAGE.BAGGAGEWEIGHT,
        BAGGAGE.BAGGAGESTATUS,
        BAGGAGE.BAGGAGELOCATION,
        FLIGHTS.FLIGHTNUMBER
    FROM 
        BAGGAGE
    JOIN 
        FLIGHTS ON BAGGAGE.FLIGHTID = FLIGHTS.FLIGHTID
    WHERE 
        BAGGAGE.PASSENGERID = p_PassengerID;
END //

DELIMITER ;

 DELIMITER //

 DELIMITER //

CREATE PROCEDURE InsertFlight(
    IN p_FlightNumber VARCHAR(10),
    IN p_AirlineID INT,
    IN p_DepartureAirport VARCHAR(255),
    IN p_DepartureTerminal VARCHAR(10),
    IN p_DepartureGate VARCHAR(10),
    IN p_DepartureTime DATETIME,
    IN p_ArrivalAirport VARCHAR(255),
    IN p_ArrivalTerminal VARCHAR(10),
    IN p_ArrivalGate VARCHAR(10),
    IN p_ArrivalTime DATETIME,
    IN p_FlightStatus VARCHAR(20)
)
BEGIN
    INSERT INTO FLIGHTS (
        FLIGHTNUMBER,
        AIRLINEID,
        DEPARTUREAIRPORT,
        DEPARTURETERMINAL,
        DEPARTUREGATE,
        DEPARTURETIME,
        ARRIVALAIRPORT,
        ARRIVALTERMINAL,
        ARRIVALGATE,
        ARRIVALTIME,
        FLIGHTSTATUS
    ) VALUES (
        p_FlightNumber,
        p_AirlineID,
        p_DepartureAirport,
        p_DepartureTerminal,
        p_DepartureGate,
        p_DepartureTime,
        p_ArrivalAirport,
        p_ArrivalTerminal,
        p_ArrivalGate,
        p_ArrivalTime,
        p_FlightStatus
    );
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE GetPassengersByFlight(
    IN p_FlightID INT
)
BEGIN
    SELECT 
        PASSENGERS.PASSENGERID,
        PASSENGERS.FIRSTNAME,
        PASSENGERS.LASTNAME,
        PASSENGERS.GENDER,
        PASSENGERS.DATEOFBIRTH,
        PASSENGERS.NATIONALITY,
        PASSENGERS.CONTACTNUMBER,
        PASSENGERS.EMAILADDRESS,
        PASSENGERS.PASSPORTORIDNUMBER
    FROM 
        PASSENGERS
    WHERE 
        PASSENGERS.FLIGHTID = p_FlightID;
END //

DELIMITER ;

DELIMITER //

 DELIMITER //

CREATE PROCEDURE GetSecurityScreeningByFlight(
    IN p_FlightID INT
)
BEGIN
    SELECT 
        SECURITYSCREENING.SCREENINGID,
        SECURITYSCREENING.CHECKPOINTID,
        SECURITYSCREENING.PASSENGERID,
        SECURITYSCREENING.SCREENINGTIME,
        SECURITYSCREENING.SCREENINGRESULT,
        SECURITYCHECKPOINTS.CHECKPOINTNAME,
        SECURITYCHECKPOINTS.CHECKPOINTLOCATION,
        PASSENGERS.FIRSTNAME,
        PASSENGERS.LASTNAME
    FROM 
        SECURITYSCREENING
    JOIN 
        SECURITYCHECKPOINTS ON SECURITYSCREENING.CHECKPOINTID = SECURITYCHECKPOINTS.CHECKPOINTID
    JOIN 
        PASSENGERS ON SECURITYSCREENING.PASSENGERID = PASSENGERS.PASSENGERID
    WHERE 
        SECURITYSCREENING.FLIGHTID = p_FlightID;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetEmployeesByRole(
    IN p_RoleID INT
)
BEGIN
    SELECT 
        EMPLOYEES.EmployeeID,
        EMPLOYEES.FirstName,
        EMPLOYEES.LastName,
        EMPLOYEES.Gender,
        EMPLOYEES.DateOfBirth,
        EMPLOYEES.Nationality,
        EMPLOYEES.ContactNumber,
        EMPLOYEES.EmailAddress,
        EMPLOYEEROLES.RoleName
    FROM 
        EMPLOYEES
    JOIN 
        EMPLOYEEROLES ON EMPLOYEES.RoleID = EMPLOYEEROLES.RoleID
    WHERE 
        EMPLOYEES.RoleID = p_RoleID;
END //

DELIMITER ;


-- First, create the FLIGHTSTATUS_LOG table
CREATE TABLE FLIGHTSTATUS_LOG (
    LOGID INT PRIMARY KEY AUTO_INCREMENT,
    FLIGHTID INT,
    OLD_STATUS VARCHAR(20),
    NEW_STATUS VARCHAR(20),
    CHANGED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (FLIGHTID) REFERENCES FLIGHTS(FLIGHTID)
);

-- Then create the trigger
DELIMITER //

CREATE TRIGGER LogFlightStatusChange
AFTER UPDATE ON FLIGHTS
FOR EACH ROW
BEGIN
    IF NEW.FLIGHTSTATUS != OLD.FLIGHTSTATUS THEN
        INSERT INTO FLIGHTSTATUS_LOG (FLIGHTID, OLD_STATUS, NEW_STATUS)
        VALUES (NEW.FLIGHTID, OLD.FLIGHTSTATUS, NEW.FLIGHTSTATUS);
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER UpdateSeatAvailability
AFTER INSERT ON BOARDINGPASS
FOR EACH ROW
BEGIN
    UPDATE SEATINFORMATION
    SET AVAILABILITYSTATUS = 'Booked'
    WHERE SEATID = NEW.SEATID;
END //

DELIMITER ;

-- First, create the EMPLOYEEROLE_LOG table
CREATE TABLE EMPLOYEEROLE_LOG (
    LOGID INT PRIMARY KEY AUTO_INCREMENT,
    EMPLOYEEID INT,
    OLD_ROLEID INT,
    NEW_ROLEID INT,
    CHANGED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (EMPLOYEEID) REFERENCES EMPLOYEES(EmployeeID),
    FOREIGN KEY (OLD_ROLEID) REFERENCES EMPLOYEEROLES(RoleID),
    FOREIGN KEY (NEW_ROLEID) REFERENCES EMPLOYEEROLES(RoleID)
);

-- Then create the trigger
DELIMITER //

CREATE TRIGGER LogEmployeeRoleChange
AFTER UPDATE ON EMPLOYEES
FOR EACH ROW
BEGIN
    IF NEW.RoleID != OLD.RoleID THEN
        INSERT INTO EMPLOYEEROLE_LOG (EMPLOYEEID, OLD_ROLEID, NEW_ROLEID)
        VALUES (NEW.EmployeeID, OLD.RoleID, NEW.RoleID);
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER EnsureUniqueFlightNumber
BEFORE INSERT ON FLIGHTS
FOR EACH ROW
BEGIN
    DECLARE duplicate_count INT;
    SELECT COUNT(*)
    INTO duplicate_count
    FROM FLIGHTS
    WHERE FLIGHTNUMBER = NEW.FLIGHTNUMBER AND AIRLINEID = NEW.AIRLINEID;

    IF duplicate_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Flight number must be unique for each airline';
    END IF;
END //

DELIMITER ;

DELIMITER //