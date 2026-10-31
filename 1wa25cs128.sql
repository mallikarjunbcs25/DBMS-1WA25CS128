
USE insuranceDB;

CREATE TABLE PERSON (
    driver_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL
);

CREATE TABLE CAR (
    reg_num VARCHAR(15) PRIMARY KEY,
    model VARCHAR(30) NOT NULL,
    year INT NOT NULL,
    CHECK (year BETWEEN 1886 AND 2100)
);

CREATE TABLE ACCIDENT (
    report_num INT PRIMARY KEY,
    accident_date DATE NOT NULL,
    location VARCHAR(100) NOT NULL
);

CREATE TABLE OWNS (
    driver_id VARCHAR(10),
    reg_num VARCHAR(15),

    PRIMARY KEY (driver_id, reg_num),

    FOREIGN KEY (driver_id)
        REFERENCES PERSON(driver_id)
        ON DELETE RESTRICT,

    FOREIGN KEY (reg_num)
        REFERENCES CAR(reg_num)
        ON DELETE RESTRICT
);

CREATE TABLE PARTICIPATED (
    driver_id VARCHAR(10),
    reg_num VARCHAR(15),
    report_num INT,
    damage_amount INT NOT NULL,

    PRIMARY KEY (driver_id, reg_num, report_num),

    FOREIGN KEY (driver_id)
        REFERENCES PERSON(driver_id)
        ON DELETE RESTRICT,

    FOREIGN KEY (reg_num)
        REFERENCES CAR(reg_num)
        ON DELETE RESTRICT,

    FOREIGN KEY (report_num)
        REFERENCES ACCIDENT(report_num)
        ON DELETE RESTRICT,

    CHECK (damage_amount >= 0)
);

INSERT INTO PERSON VALUES
('A01', 'Richard', 'Srinivas nagar'),
('A02', 'Pradeep', 'Rajaji nagar'),
('A03', 'Smith', 'Ashok nagar'),
('A04', 'Venu', 'N R Colony'),
('A05', 'Jhon', 'Hanumanth nagar');

INSERT INTO CAR VALUES
('KA052250', 'Indica', 1990),
('KA031181', 'Lancer', 1957),
('KA095477', 'Toyota', 1998),
('KA053408', 'Honda', 2008),
('KA041702', 'Audi', 2005);

INSERT INTO ACCIDENT VALUES
(11, '2003-01-01', 'Mysore Road'),
(12, '2004-02-02', 'South end Circle'),
(13, '2003-01-21', 'Bull temple Road'),
(14, '2008-02-17', 'Mysore Road'),
(15, '2005-03-04', 'Kanakpura Road');

INSERT INTO OWNS VALUES
('A01', 'KA052250'),
('A02', 'KA053408'),
('A03', 'KA031181'),
('A04', 'KA095477'),
('A05', 'KA041702');

INSERT INTO PARTICIPATED VALUES
('A01', 'KA052250', 11, 10000),
('A02', 'KA053408', 12, 50000),
('A03', 'KA095477', 13, 25000),
('A04', 'KA031181', 14, 3000),
('A05', 'KA041702', 15, 5000);

UPDATE PARTICIPATED
SET damage_amount = 25000
WHERE reg_num = 'KA053408'
AND report_num = 12;
  
INSERT INTO ACCIDENT
VALUES (16, '2026-10-24', 'Bengaluru Road');

INSERT INTO PARTICIPATED
VALUES ('A01', 'KA052250', 16, 15000);

SELECT accident_date, location
FROM ACCIDENT;

SELECT DISTINCT driver_id
FROM PARTICIPATED
WHERE damage_amount >= 25000;

SELECT *
FROM CAR
ORDER BY year ASC;

SELECT COUNT(DISTINCT P.report_num) AS total_accidents
FROM PARTICIPATED P
JOIN CAR C ON P.reg_num = C.reg_num
WHERE C.model = 'Lancer';

SELECT COUNT(DISTINCT O.driver_id) AS total_people
FROM OWNS O
JOIN PARTICIPATED P ON O.reg_num = P.reg_num
JOIN ACCIDENT A ON P.report_num = A.report_num
WHERE YEAR(A.accident_date) = 2008;


SELECT COUNT(DISTINCT P.report_num) AS total_accidents
FROM PARTICIPATED P
JOIN CAR C ON P.reg_num = C.reg_num
JOIN ACCIDENT A ON P.report_num = A.report_num
WHERE C.model = 'Lancer'
AND YEAR(A.accident_date) = 2008;