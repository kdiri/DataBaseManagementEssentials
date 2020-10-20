-- ------------------ Student --------------------------------

CREATE TABLE Student (
stdNo char(11) not null,
stdFirstName varchar(30) not null,
stdLastName varchar(30) not null,
stdCity varchar(30) not null,
stdState char(2) not null,
stdZip char(10) not null,
stdMajor char(6),
stdClass char(2),
stdGPA decimal(3,2),
CONSTRAINT StudentPk PRIMARY KEY (StdNo) );


-- ------------------ Course --------------------------------

CREATE TABLE Course(
CourseNo	char(6) not null,
crsDesc		varchar(50) not null,
CrsUnits	integer,
CONSTRAINT CoursePK PRIMARY KEY (CourseNo) );


-- ------------------ Faculty --------------------------------

CREATE TABLE Faculty(
FacNo			char(11) not null,
FacFirstName	varchar(30) not null,
FacLastName		varchar(30) not null,
FacCity			varchar(30) not null,
FacState		char(2) not null,
FacZipCode		char(10) not null,
FacRank			char(4),
FacHireDate		date,
FacSalary		decimal(10,2),
FacSupervisor	char(11),
FacDept			char(6),
CONSTRAINT FacultyPK PRIMARY KEY (FacNo) );


-- ------------------ Offering --------------------------------

CREATE TABLE Offering(
OfferNo INTEGER not null,
CourseNo char(6) not null,
OffTerm char(6) not null,
OffYear INTEGER not null,
OffLocation varchar(30),
OffTime varchar(10),
FacNo char(11),
OffDays char(4),
CONSTRAINT OfferingPK PRIMARY KEY (OfferNo),
CONSTRAINT CourseFK FOREIGN KEY (CourseNo) REFERENCES Course (CourseNo),
CONSTRAINT FacultyFK FOREIGN KEY (FacNo) REFERENCES Faculty (FacNo) );


-- ------------------ Enrollment --------------------------------

CREATE TABLE Enrollment (
OfferNo		INTEGER not null,
StdNo		char(11) not null,
EnrGrade	decimal(3,2),
CONSTRAINT EnrollmentPK PRIMARY KEY (OfferNo, StdNo),
CONSTRAINT OfferingFK FOREIGN KEY (OfferNo) REFERENCES Offering (OfferNo)
ON DELETE CASCADE,
CONSTRAINT StudentFK FOREIGN KEY (StdNo) REFERENCES Student (StdNo) ON DELETE CASCADE );
