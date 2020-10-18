create table Customers(
     CustNo varchar(30) primary key,
     CustFirstName varchar(15) NOT NULL,
     CustLastName varchar(15) NOT NULL,
     CustCity varchar(15),
     CustState varchar(15),
     CustZip varchar(15),
     CustBal varchar(256)
);


create table Employee(
    EmpNo varchar(30) primary key,
    EmpFirstName varchar(15) NOT NULL,
    EmpLastName varchar(15) NOT NULL,
    EmpPhone varchar(30),
    EmpEmail varchar(30) NOT NULL,
    CONSTRAINT CNSEmpEmail UNIQUE (EmpEmail)
);

create table OrderTbl(
    OrdNo varchar(30) primary key,
    OrdDate date NOT NULL,
    CustNo varchar(30) NOT NULL,
    EmpNo varchar(30) DEFAULT '',
    FOREIGN KEY (CustNo) references Customers(CustNo),
    FOREIGN KEY (EmpNo) references Employee(EmpNo)
);
