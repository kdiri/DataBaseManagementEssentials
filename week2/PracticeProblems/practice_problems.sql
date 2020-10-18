use athletic;

create table Customer(
    custNo varchar(30) primary key,
    custName varchar(30),
    address varchar(256),
    Internal ENUM('Y', 'N') COMMENT 'Y stands for Yes. N stands for No.',
    contact varchar(30),
    phone int,
    city varchar(30),
    state varchar(2),
    zip varchar(7)
);

create table Facility(
    facNo int auto_increment primary key,
    facName varchar(30),
    CONSTRAINT CNSfacName UNIQUE (facName)
);

create table Location(
    locNo int auto_increment primary key,
    facNo int NOT NULL ,
    locName varchar(30) NOT NULL,
    FOREIGN KEY (facNo) references Facility(facNo)
)

