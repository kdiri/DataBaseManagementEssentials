-- -****- --
-- NOTES  --
-- -****- --

-- Basic CREATE TABLE Statement Requirements
-- 1. For primary key fields (CustNo, LocNo, EventNo, PlanNo, EmpNo, ResNo, and FacNo),
--    use the VARCHAR (or VARCHAR2 in Oracle) data type with length 8.

-- 2. In MySQL use the DATE data type for columns with just date details
--    (date columns in the EventRequest and EventPlan tables) and DATETIME
--    for columns with date and time details (time columns in the EventPlanLine table).

-- 3. for the Customer.Internal column MySQL has the Boolean data type.

-- -****- --

-- Constraints
-- After writing the basic CREATE TABLE statements, you should modify the statements with constraints.
-- The CONSTRAINT clauses can be either inline in a column definition or separate after column
-- definitions except where noted. You should specify a meaningful name for each CONSTRAINT clause.

-- 1. For each primary key, you should specify a PRIMARY KEY constraint clause.
--    For single column primary keys (CustNo, LocNo, EventNo, PlanNo, EmpNo, ResNo, and FacNo),
--    the constraint clause can be inline or external. For multiple column primary keys
--    (combination of PlanNo and LineNo), the CONSTRAINT clause must be external.

-- 2. For each foreign key, you should specify a FOREIGN KEY constraint clause.
--    The constraint clauses can be inline or separate.

-- 3. Define NOT NULL constraints for all columns except
--    eventplan.empno, EventRequest.DateAuth, EventRequest.BudNo, and EventPlan.Notes.
--    Make sure that you define NOT NULL constraints for the PK of each table.
--    Because of MySQL syntax limitations for NOT NULL constraints
--    (inline with no constraint name and no CONSTRAINT keyword),
--    you should define inline NOT NULL constraints.

-- 4. Define a named CHECK constraint to restrict the eventrequest.status column
--    to have a value of “Pending”, “Denied”, or “Approved”. You can use the IN operator
--    in this constraint. In MySQL, the syntax does not allow the CONSTRAINT keyword and
--    a constraint name for CHECK constraints. You should use the CHECK keyword followed
--    the condition enclosed in parentheses.

-- 5. Define named CHECK constraints to ensure that the resource.rate and
--    eventrequest.estaudience are greater than 0. In MySQL, you cannot use a
--    constraint name and the CONSTRAINT keyword for CHECK constraints.
--    In MySQL, the syntax does not allow the CONSTRAINT keyword and a constraint
--    name for CHECK constraints. You should use the CHECK keyword followed the condition enclosed in parentheses.


-- 6. Define a named CHECK constraint involving EventPlanLine.TimeStart and
--    EventPlanLineTimeEnd. The start time should be smaller (chronologically before)
--    than the end time. This CHECK constraint must be external because it involves
--    two columns. In MySQL, the syntax does not allow the CONSTRAINT keyword and
--    a constraint name for CHECK constraints. You should use the CHECK keyword followed
--    the condition enclosed in parentheses.


create table Employee(
    EMPNO varchar(8) primary key,
    EMPNAME varchar(15) NOT NULL,
    DEPARTMENT varchar(15) NOT NULL,
    EMAIL varchar(15) NOT NULL,
    PHONE varchar(15) NOT NULL
);

create table Customer(
    CUSTNO VARCHAR(8) primary key,
    CUSTNAME VARCHAR(15) NOT NULL,
    ADDRESS VARCHAR(15) NOT NULL,
    INTERNAL VARCHAR(15) NOT NULL,
    CONTACT VARCHAR(15) NOT NULL,
    PHONE VARCHAR(15) NOT NULL,
    CITY VARCHAR(15) NOT NULL,
    STATE VARCHAR(15) NOT NULL,
    ZIP VARCHAR(15) NOT NULL
);

create table RESOURCETBL(
    RESNO VARCHAR(8) primary key ,
    RESNAME VARCHAR(8) NOT NULL,
    RATE INT NOT NULL CHECK (RATE > 0)
);


create table FACILITY(
     FACNO varchar(8) primary key,
     FACNAME varchar(30),
     CONSTRAINT CNSfacName UNIQUE (FACNAME)
);

create table LOCATION(
     LOCNO varchar(8) primary key,
     FACNO varchar(8) NOT NULL ,
     LOCNAME varchar(30) NOT NULL,
     FOREIGN KEY (FACNO) references FACILITY(FACNO)
);

create table EVENTREQUEST(
    EVENTNO VARCHAR(8) primary key,
    DATEHELD DATE NOT NULL,
    DATEREQ DATE NOT NULL,
    CUSTNO VARCHAR(8) NOT NULL,
    FACNO VARCHAR(8) NOT NULL,
    DATEAUTH DATE,
    STATUS VARCHAR(8) NOT NULL CHECK (STATUS in ('Approved', 'Denied', 'Pending')),
    ESTCOST DECIMAL(8,2) NOT NULL,
    ESTAUDIENCE INT NOT NULL CHECK (ESTAUDIENCE > 0),
    BUDNO VARCHAR(30),
    FOREIGN KEY (CUSTNO) references Customer(CUSTNO),
    FOREIGN KEY (FACNO) references FACILITY(FACNO)
);

create table EVENTPLAN(
    PLANNO VARCHAR(8) primary key,
    EVENTNO VARCHAR(8) NOT NULL,
    WORKDATE DATE NOT NULL,
    NOTES VARCHAR(30),
    ACTIVITY VARCHAR(8) NOT NULL,
    EMPNO VARCHAR(8),
    FOREIGN KEY (EMPNO) references Employee(EMPNO),
    FOREIGN KEY (EVENTNO) references EVENTREQUEST(EVENTNO)
);

CREATE TABLE EVENTPLANLINE(
    PLANNO VARCHAR(8) NOT NULL,
    LINENO VARCHAR(8) NOT NULL,
    TIMESTART DATETIME NOT NULL,
    TIMEEND DATETIME NOT NULL,
    NUMBERFLD INT NOT NULL,
    LOCNO VARCHAR(8) NOT NULL,
    RESNO VARCHAR(8) NOT NULL,
    CONSTRAINT PKPLANNOLINENO PRIMARY KEY (PLANNO, LINENO),
    FOREIGN KEY (PLANNO) references EVENTPLAN(PLANNO),
    FOREIGN KEY (LOCNO) references LOCATION(LOCNO),
    FOREIGN KEY (RESNO) references RESOURCETBL(RESNO),
    CONSTRAINT ucsTimeCheck CHECK (TIMESTART < TIMEEND)
);
