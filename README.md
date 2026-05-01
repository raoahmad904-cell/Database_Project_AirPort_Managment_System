# ✈️ Airport Management System
### Database Systems — Semester Project

<div align="center">

![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![DBMS](https://img.shields.io/badge/DBMS-Relational-blue?style=for-the-badge)
![Tables](https://img.shields.io/badge/Tables-18-green?style=for-the-badge)
![Triggers](https://img.shields.io/badge/Triggers-2-orange?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)

</div>

 

## 📋 Table of Contents

1. [Introduction](#introduction)
2. [System Architecture](#system-architecture)
3. [Relational Schema Diagram](#relational-schema-diagram)
4. [Database Schema](#database-schema)
5. [Key Functionalities](#key-functionalities)
6. [Triggers & Audit Logs](#triggers--audit-logs)
7. [Setup & Installation](#setup--installation)
8. [Conclusion](#conclusion)

---

## Introduction

The **Airport Management System** is a comprehensive relational database solution designed to streamline all critical operations within an airport or airline environment. It provides an integrated platform to manage:

- ✈️ Flights and airlines
- 👤 Passengers and boarding passes
- 🧳 Baggage tracking
- 🔒 Security screenings
- 👷 Employees and crew
- 🛫 Gates, terminals, and control towers
- ⛽ Fueling and catering services

Built on a fully normalized relational model using **MySQL**, the system ensures data integrity, eliminates redundancy, and enables efficient multi-table queries across all operational domains.

---

## System Architecture

The system follows a classic **three-tier architecture**:

```
┌────────────────────────────────────────────┐
│              User Interface                │
│   (Staff portal – flights, passengers,     │
│    baggage, crew, security management)     │
└─────────────────┬──────────────────────────┘
                  │
┌─────────────────▼──────────────────────────┐
│            Application Layer               │
│   (Business logic, validation, stored      │
│    procedures, role enforcement)           │
└─────────────────┬──────────────────────────┘
                  │
┌─────────────────▼──────────────────────────┐
│             Database Server                │
│   MySQL – 18 tables, indexes, triggers,    │
│   foreign key constraints, audit logs      │
└────────────────────────────────────────────┘
```

---

## Relational Schema Diagram

The diagram below shows all 18 tables and their foreign key relationships. Dashed lines represent FK references between tables.

 Diagram is given above in files download it form their.

---

## Database Schema

### Core Tables

#### `flights`
Stores all flight records. The central table of the schema.

| Column | Type | Notes |
|--------|------|-------|
| `FLIGHTID` | INT | Primary Key |
| `FLIGHTNUMBER` | VARCHAR(10) | |
| `AIRLINEID` | INT | FK → airlines |
| `DEPARTUREAIRPORT` | VARCHAR(255) | |
| `DEPARTURETERMINAL` | VARCHAR(10) | |
| `DEPARTUREGATE` | VARCHAR(10) | |
| `DEPARTURETIME` | DATETIME | |
| `ARRIVALAIRPORT` | VARCHAR(255) | |
| `ARRIVALTERMINAL` | VARCHAR(10) | |
| `ARRIVALGATE` | VARCHAR(10) | |
| `ARRIVALTIME` | DATETIME | |
| `FLIGHTSTATUS` | VARCHAR(20) | Triggers audit log on change |

---

#### `airlines`
Registered airline details.

| Column | Type | Notes |
|--------|------|-------|
| `AIRLINEID` | INT | Primary Key |
| `AIRLINENAME` | VARCHAR(255) | |
| `CONTACTNUMBER` | VARCHAR(11) | |
| `CONTACTEMAIL` | VARCHAR(255) | |

---

#### `passengers`
Passenger personal information and flight assignment.

| Column | Type | Notes |
|--------|------|-------|
| `PASSENGERID` | INT | Primary Key |
| `FIRSTNAME` | VARCHAR(255) | |
| `LASTNAME` | VARCHAR(255) | |
| `GENDER` | VARCHAR(10) | |
| `DATEOFBIRTH` | DATE | |
| `NATIONALITY` | VARCHAR(255) | |
| `CONTACTNUMBER` | VARCHAR(20) | |
| `EMAILADDRESS` | VARCHAR(255) | |
| `PASSPORTORIDNUMBER` | VARCHAR(20) | |
| `FLIGHTID` | INT | FK → flights |

---

#### `boardingpass`
Boarding passes linking passenger, seat, flight, and security clearance.

| Column | Type | Notes |
|--------|------|-------|
| `BOARDINGPASSID` | INT | Primary Key |
| `PASSENGERID` | INT | FK → passengers |
| `SCREENINGID` | INT | FK → securityscreening |
| `FLIGHTID` | INT | FK → flights |
| `CHECKPOINTID` | INT | FK → securitycheckpoints |
| `SEATID` | INT | FK → seatinformation |

---

#### `baggage`
Tracks each piece of baggage throughout the journey.

| Column | Type | Notes |
|--------|------|-------|
| `BAGGAGEID` | INT | Primary Key |
| `PASSENGERID` | INT | FK → passengers |
| `FLIGHTID` | INT | FK → flights |
| `BAGGAGETAGNUMBER` | VARCHAR(20) | Unique tag |
| `BAGGAGEWEIGHT` | DECIMAL(10,2) | In kg |
| `BAGGAGESTATUS` | VARCHAR(20) | e.g. Loaded, In Transit |
| `BAGGAGELOCATION` | VARCHAR(255) | |

---

#### `securityscreening`
Security screening events per passenger at each checkpoint.

| Column | Type | Notes |
|--------|------|-------|
| `SCREENINGID` | INT | Primary Key |
| `CHECKPOINTID` | INT | FK → securitycheckpoints |
| `PASSENGERID` | INT | FK → passengers |
| `FLIGHTID` | INT | FK → flights |
| `SCREENINGTIME` | DATETIME | |
| `SCREENINGRESULT` | VARCHAR(20) | PASS / FAIL |

---

#### `securitycheckpoints`
Physical security checkpoint definitions.

| Column | Type |
|--------|------|
| `CHECKPOINTID` | INT (PK) |
| `CHECKPOINTNAME` | VARCHAR(255) |
| `CHECKPOINTLOCATION` | VARCHAR(255) |

---

### Staff & Crew Tables

#### `employees`
Airport staff records with role assignments.

| Column | Type | Notes |
|--------|------|-------|
| `EmployeeID` | INT | Primary Key |
| `FirstName` | VARCHAR(255) | |
| `LastName` | VARCHAR(255) | |
| `Gender` | VARCHAR(10) | |
| `DateOfBirth` | DATE | |
| `Nationality` | VARCHAR(255) | |
| `ContactNumber` | VARCHAR(20) | |
| `EmailAddress` | VARCHAR(255) | |
| `RoleID` | INT | FK → employeeroles |

---

#### `employeeroles`
Role type definitions for all airport staff.

| Column | Type |
|--------|------|
| `RoleID` | INT (PK) |
| `RoleName` | VARCHAR(255) |

---

#### `flightcrew`
Crew members assigned to specific flights.

| Column | Type | Notes |
|--------|------|-------|
| `CREWID` | INT | Primary Key |
| `FIRSTNAME` | VARCHAR(255) | |
| `LASTNAME` | VARCHAR(255) | |
| `GENDER` | VARCHAR(10) | |
| `DATEOFBIRTH` | DATE | |
| `NATIONALITY` | VARCHAR(255) | |
| `CONTACTNUMBER` | VARCHAR(20) | |
| `EMAILADDRESS` | VARCHAR(255) | |
| `POSITION` | VARCHAR(255) | e.g. Pilot, Cabin Crew |
| `FLIGHTID` | INT | FK → flights |

---

### Infrastructure Tables

#### `aircraft`
Links each aircraft to its associated flight, gate, seat, crew, catering, and fueling records.

| Column | Type | Notes |
|--------|------|-------|
| `AIRCRAFTID` | INT | Primary Key |
| `FLIGHTID` | INT | FK → flights |
| `GATEID` | INT | FK → gates |
| `BOARDINGPASSID` | INT | FK → boardingpass |
| `CATERINGID` | INT | FK → flightcatering |
| `FUELINGID` | INT | FK → fueling |
| `TOWERID` | INT | FK → controltower |
| `SEATID` | INT | FK → seatinformation |
| `CREWID` | INT | FK → flightcrew |
| `TERMINALID` | INT | FK → terminal |

---

#### `seatinformation`
Seat inventory per flight with class and availability.

| Column | Type | Notes |
|--------|------|-------|
| `SEATID` | INT | Primary Key |
| `SEATNUMBER` | VARCHAR(10) | |
| `SEATCLASS` | VARCHAR(50) | Economy / Business / First |
| `AVAILABILITYSTATUS` | VARCHAR(20) | Available / Occupied |
| `FLIGHTID` | INT | FK → flights |

---

#### `gates`
Gate assignments with real-time availability status.

| Column | Type |
|--------|------|
| `GATEID` | INT (PK) |
| `GATENUMBER` | VARCHAR(10) |
| `LOCATION` | VARCHAR(255) |
| `AVAILABILITYSTATUS` | VARCHAR(20) |

---

#### `terminal`
Terminal information including capacity.

| Column | Type |
|--------|------|
| `TERMINALID` | INT (PK) |
| `TERMINALNAME` | VARCHAR(255) |
| `LOCATION` | VARCHAR(255) |
| `CAPACITY` | INT |
| `CONTACTNUMBER` | VARCHAR(20) |

---

#### `controltower`
Air traffic control tower registry.

| Column | Type |
|--------|------|
| `TOWERID` | INT (PK) |
| `TOWERNAME` | VARCHAR(255) |
| `LOCATION` | VARCHAR(255) |
| `CONTACTNUMBER` | VARCHAR(20) |

---

### Services Tables

#### `flightcatering`
Catering service providers.

| Column | Type |
|--------|------|
| `CATERINGID` | INT (PK) |
| `CATERINGNAME` | VARCHAR(255) |
| `LOCATION` | VARCHAR(255) |

---

#### `fueling`
Fueling records per flight.

| Column | Type | Notes |
|--------|------|-------|
| `FUELINGID` | INT | Primary Key |
| `FUELINGPROVIDER` | VARCHAR(255) | |
| `FUELTYPE` | VARCHAR(50) | e.g. Jet-A, Avgas |
| `FUELAMOUNT` | INT | |
| `UNITOFMEASURE` | VARCHAR(20) | e.g. Liters, Gallons |
| `FUELINGDATETIME` | DATETIME | |
| `FLIGHTID` | INT | FK → flights |

---

### Audit Log Tables

#### `flightstatus_log`
Auto-populated by trigger on `flights` UPDATE.

| Column | Type |
|--------|------|
| `LOGID` | INT (PK) |
| `FLIGHTID` | INT |
| `OLD_STATUS` | VARCHAR(20) |
| `NEW_STATUS` | VARCHAR(20) |
| `CHANGED_AT` | TIMESTAMP |

---

#### `employeerole_log`
Auto-populated by trigger on `employees` UPDATE.

| Column | Type |
|--------|------|
| `LOGID` | INT (PK) |
| `EMPLOYEEID` | INT |
| `OLD_ROLEID` | INT |
| `NEW_ROLEID` | INT |
| `CHANGED_AT` | TIMESTAMP |

---

## Key Functionalities

### ✈️ Flight Management
- Create, retrieve, and update full flight records (schedule, airline, status)
- Automatic status-change logging via the `flightstatus_log` trigger
- Link flights to gates, terminals, crew, and aircraft in a single query

### 👤 Passenger Management
- Register passengers with personal details and passport/ID numbers
- Assign passengers to flights, seats, and boarding passes
- Retrieve full passenger journey across security, boarding, and baggage records

### 🧳 Baggage Tracking
- Issue unique tag numbers for each piece of checked baggage
- Monitor weight, location, and status at every stage of the journey
- Cross-reference baggage with passenger and flight records

### 🔒 Security Screening
- Record screening events at named security checkpoints
- Store screening time, result (PASS / FAIL), and passenger identity
- Boarding pass issuance is gated by a valid `PASS` screening record

### 👷 Crew & Employee Management
- Assign flight crew (pilots, cabin crew) to specific flights via `flightcrew`
- Maintain employee roles through the `employeeroles` lookup table
- Audit all role changes automatically via the `employeerole_log` trigger

### 🏗️ Gate, Terminal & Infrastructure
- Track gate availability in real time via `AVAILABILITYSTATUS`
- Manage terminal capacity and contact information
- Link aircraft to specific gates, terminals, and control towers

### ⛽ Fueling & Catering
- Record fueling events per flight with provider, fuel type, and quantity
- Link catering service providers to aircraft and flights via `flightcatering`

---

## Triggers & Audit Logs

The system implements **2 database-level triggers** that automatically maintain a full audit trail without any application-level code.

### 1. `flightstatus_log` Trigger

**Fires on:** `UPDATE` to the `flights` table  
**Purpose:** Records every status transition of a flight.

```sql
-- Automatically inserts a row like this on every FLIGHTSTATUS change:
INSERT INTO flightstatus_log (FLIGHTID, OLD_STATUS, NEW_STATUS, CHANGED_AT)
VALUES (OLD.FLIGHTID, OLD.FLIGHTSTATUS, NEW.FLIGHTSTATUS, NOW());
```

**Example log entries:**

| LOGID | FLIGHTID | OLD_STATUS | NEW_STATUS | CHANGED_AT |
|-------|----------|------------|------------|----------------------|
| 1 | 101 | Scheduled | Boarding | 2024-05-21 08:30:00 |
| 2 | 101 | Boarding | Departed | 2024-05-21 09:00:00 |
| 3 | 101 | Departed | Landed | 2024-05-21 11:45:00 |

---

### 2. `employeerole_log` Trigger

**Fires on:** `UPDATE` to the `employees` table  
**Purpose:** Records every role change for any employee.

```sql
-- Automatically inserts a row like this on every RoleID change:
INSERT INTO employeerole_log (EMPLOYEEID, OLD_ROLEID, NEW_ROLEID, CHANGED_AT)
VALUES (OLD.EmployeeID, OLD.RoleID, NEW.RoleID, NOW());
```

---

## Setup & Installation

### Prerequisites

- MySQL Server **8.0** or higher
- MySQL Workbench *(recommended for schema visualization)*
- A MySQL user with `CREATE`, `INSERT`, `UPDATE`, `DELETE`, and `TRIGGER` privileges

### Steps

**1. Clone the repository**
```bash
git clone https://github.com/your-username/airport-management-system.git
cd airport-management-system
```

**2. Create the database**
```sql
CREATE DATABASE airport_management;
USE airport_management;
```

**3. Run the SQL schema script**
```bash
mysql -u root -p airport_management < airport_management.sql
```

**4. (Optional) Load sample data**
```bash
mysql -u root -p airport_management < seed_data.sql
```

**5. Verify the setup**
```sql
SHOW TABLES;
-- Should list all 18 tables
```

**6. Test triggers**
```sql
-- Update a flight status and verify the log
UPDATE flights SET FLIGHTSTATUS = 'Boarding' WHERE FLIGHTID = 1;
SELECT * FROM flightstatus_log;
```

---

## Conclusion

The **Airport Management System** delivers a robust, normalized relational database backend capable of supporting all critical operations of a modern airport. Its clearly defined schema, foreign key constraints, and automated audit triggers ensure data consistency, traceability, and maintainability.

The system can serve as the foundation for a full-stack airport operations application with minimal extension.

This project demonstrates proficiency in:
- Relational database design and normalization
- Multi-entity foreign key modeling
- Trigger-based audit automation in MySQL
- Complex schema design for real-world operational systems

---

<div align="center">

**Airport Management System** · DBMS Semester Project · Ahmad Rashid · 2024

</div>
