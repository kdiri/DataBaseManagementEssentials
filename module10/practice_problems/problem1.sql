use athletic;


-- Employe manages employees
create table if not exists Employee2(
    EmpNo int not null auto_increment primary key,
    Manager int default null,
    FirstName varchar(45) not null,
    LastName varchar(45) not null,
    Phone varchar(45) not null,
    Email varchar(45) not null,
    DeptName varchar(45) not null,
    CommRate float not null,
    FOREIGN KEY (Manager) references Employee2(EmpNo)
);

-- Customer
create table if not exists Customer2(
    CustNo int not null auto_increment primary key,
    FirstName varchar(45) not null,
    LastName varchar(45) not null,
    City varchar(45) not null,
    State varchar(8) not null,
    Zip varchar(45) not null,
    Bal varchar(45) not null
);

-- Product
create table if not exists Product2(
    ProdNo int not null auto_increment primary key,
    Name varchar(45) not null,
    QOH varchar(45) not null,
    Price float not null,
    NextShipDate date not null
);

-- Employe takes orders
-- Customer places orders
create table if not exists Order2(
    OrdNo int not null auto_increment primary key,
    EmpNo int not null,
    CustNo int not null,
    OrdDate date not null,
    Name varchar(45) not null,
    City varchar(45) not null,
    State varchar(8) not null,
    Zip varchar(8) not null,
    CONSTRAINT FOREIGN KEY (EmpNo) references Employee2(EmpNo),
    CONSTRAINT FOREIGN KEY (CustNo) references Customer2(CustNo)
);

-- Orders have products and vice versa
create table if not exists OrdersProducts2(
    OrdNo int not null,
    ProdNo int not null,
    PRIMARY KEY (OrdNo, ProdNo),
    CONSTRAINT `Constr_OrdersProducts2_Orders_fk`
        FOREIGN KEY `Orders_fk` (OrdNo) REFERENCES Order2(OrdNo),
    CONSTRAINT `Constr_OrdersProducts2_Products_fk`
        FOREIGN KEY `Products_fk` (ProdNo) REFERENCES Product2(ProdNo)
)
