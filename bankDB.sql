create database bankDB;

use bankDB;

create table branch(
branch_name varchar(20) primary key,
branch_city varchar(20),
assets int);


create table bankaccount(
accno int primary key,
branch_name varchar(20),
balance int,
foreign key(branch_name) references branch(branch_name)
);

create table bankCustomer(
c_name varchar(20),
c_street varchar(30),
c_city varchar(20));

create table loan(
l_number int,	
branch_name varchar(20),
amount int,
foreign key(branch_name) references branch(branch_name)
);

insert into branch (branch_name, branch_city, assets) 
values('SBI_Chamrajpet', 'Bangalore', 50000),
('SBI_ResidencyRoad', 'Bangalore', 100000),
('SBI_Shivajiroad', 'Bombay', 20000),
('SBI_ParliamentRoad', 'Delhi', 100000),
('SBI_Jantarmantar', 'Delhi', 20000);

INSERT INTO BankAccount (accno, branch_name, balance)
VALUES
(1, 'SBI_Chamrajpet', 2000),
(2, 'SBI_ResidencyRoad', 5000),
(3, 'SBI_Shivajiroad', 6000),
(4, 'SBI_ParliamentRoad', 9000),
(5, 'SBI_Jantarmantar', 8000),
(6, 'SBI_Shivajiroad', 4000),
(8, 'SBI_ResidencyRoad', 4000),
(9, 'SBI_ParliamentRoad', 3000),
(10, 'SBI_ResidencyRoad', 5000),
(11, 'SBI_Jantarmantar', 2000);

