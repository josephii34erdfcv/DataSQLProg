DROP SCHEMA IF EXISTS spaceline;
-- MySQL Script generated by MySQL Workbench
-- 12/21/16 17:30:09
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema spaceline
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema spaceline
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spaceline`
  DEFAULT CHARACTER SET utf8;
USE `spaceline`;

-- -----------------------------------------------------
-- Table `spaceline`.`Spaceship Model`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spaceline`.`Spaceship Model`;

CREATE TABLE IF NOT EXISTS `spaceline`.`Spaceship Model` (
  `model_name`   VARCHAR(15) NOT NULL,
  `num_of_seats` INT         NOT NULL,
  PRIMARY KEY (`model_name`),
  UNIQUE INDEX `model_name_UNIQUE` (`model_name` ASC)
)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spaceline`.`Spaceship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spaceline`.`Spaceship`;

CREATE TABLE IF NOT EXISTS `spaceline`.`Spaceship` (
  `spaceship_id` INT         NOT NULL AUTO_INCREMENT,
  `year_in_use`  YEAR        NOT NULL,
  `model_name`   VARCHAR(15) NOT NULL,
  PRIMARY KEY (`spaceship_id`),
  INDEX `fk_Spaceship_Spaceship_Model_idx` (`model_name` ASC),
  CONSTRAINT `fk_Spaceship_Spaceship_Model`
  FOREIGN KEY (`model_name`)
  REFERENCES `spaceline`.`Spaceship Model` (`model_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spaceline`.`Seat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spaceline`.`Seat`;

CREATE TABLE IF NOT EXISTS `spaceline`.`Seat` (
  `seat_number`  VARCHAR(5)  NOT NULL,
  `seat_type`    VARCHAR(20) NOT NULL,
  `spaceship_id` INT         NOT NULL,
  PRIMARY KEY (`seat_number`, `spaceship_id`),
  INDEX `fk_Seat_Spaceship1_idx` (`spaceship_id` ASC),
  CONSTRAINT `fk_Seat_Spaceship1`
  FOREIGN KEY (`spaceship_id`)
  REFERENCES `spaceline`.`Spaceship` (`spaceship_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spaceline`.`Spaceport`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spaceline`.`Spaceport`;

CREATE TABLE IF NOT EXISTS `spaceline`.`Spaceport` (
  `country`   VARCHAR(20) NOT NULL,
  `city`      VARCHAR(30) NOT NULL,
  `num_ports` INT         NOT NULL,
  `planet`    VARCHAR(20) NOT NULL,
  PRIMARY KEY (`country`, `city`)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spaceline`.`Path`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spaceline`.`Path`;

CREATE TABLE IF NOT EXISTS `spaceline`.`Path` (
  `departure_country` VARCHAR(20) NOT NULL,
  `departure_city`    VARCHAR(30) NOT NULL,
  `arrival_country`   VARCHAR(20) NOT NULL,
  `arrival_city`      VARCHAR(30) NOT NULL,
  `avg_hours`         INT         NULL,
  `num_meals`         INT         NULL,
  PRIMARY KEY (`departure_country`, `departure_city`, `arrival_country`, `arrival_city`),
  INDEX `fk_Path_Spaceport2_idx` (`arrival_country` ASC, `arrival_city` ASC),
  CONSTRAINT `fk_Path_Spaceport1`
  FOREIGN KEY (`departure_country`, `departure_city`)
  REFERENCES `spaceline`.`Spaceport` (`country`, `city`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Path_Spaceport2`
  FOREIGN KEY (`arrival_country`, `arrival_city`)
  REFERENCES `spaceline`.`Spaceport` (`country`, `city`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spaceline`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spaceline`.`Employee`;

CREATE TABLE IF NOT EXISTS `spaceline`.`Employee` (
  `employee_id` INT         NOT NULL AUTO_INCREMENT,
  `hire_date`   DATETIME    NOT NULL,
  `first_name`  VARCHAR(30) NOT NULL,
  `last_name`   VARCHAR(40) NOT NULL,
  `salary`      FLOAT       NOT NULL,
  PRIMARY KEY (`employee_id`)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spaceline`.`Pilot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spaceline`.`Pilot`;

CREATE TABLE IF NOT EXISTS `spaceline`.`Pilot` (
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `fk_Pilot_Employee1`
  FOREIGN KEY (`employee_id`)
  REFERENCES `spaceline`.`Employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spaceline`.`Flight`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spaceline`.`Flight`;

CREATE TABLE IF NOT EXISTS `spaceline`.`Flight` (
  `flight_id`         INT         NOT NULL AUTO_INCREMENT,
  `spaceship_id`      INT         NOT NULL,
  `departure_country` VARCHAR(20) NOT NULL,
  `departure_city`    VARCHAR(30) NOT NULL,
  `arrival_country`   VARCHAR(20) NOT NULL,
  `arrival_city`      VARCHAR(30) NOT NULL,
  `departure_time`    DATETIME    NOT NULL,
  `arrival_time`      DATETIME    NOT NULL,
  `employee_id`       INT         NOT NULL,
  PRIMARY KEY (`flight_id`),
  INDEX `fk_Flight_Spaceship1_idx` (`spaceship_id` ASC),
  INDEX `fk_Flight_Path1_idx` (`departure_country` ASC, `departure_city` ASC, `arrival_country` ASC, `arrival_city` ASC),
  INDEX `fk_Flight_Pilot1_idx` (`employee_id` ASC),
  CONSTRAINT `fk_Flight_Spaceship1`
  FOREIGN KEY (`spaceship_id`)
  REFERENCES `spaceline`.`Spaceship` (`spaceship_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Flight_Path1`
  FOREIGN KEY (`departure_country`, `departure_city`, `arrival_country`, `arrival_city`)
  REFERENCES `spaceline`.`Path` (`departure_country`, `departure_city`, `arrival_country`, `arrival_city`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Flight_Pilot1`
  FOREIGN KEY (`employee_id`)
  REFERENCES `spaceline`.`Pilot` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spaceline`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spaceline`.`Customer`;

CREATE TABLE IF NOT EXISTS `spaceline`.`Customer` (
  `country`     VARCHAR(20) NOT NULL,
  `passport_id` VARCHAR(45) NOT NULL,
  `first_name`  VARCHAR(30) NOT NULL,
  `last_name`   VARCHAR(40) NOT NULL,
  PRIMARY KEY (`passport_id`, `country`)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spaceline`.`Ticket Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spaceline`.`Ticket Customer`;

CREATE TABLE IF NOT EXISTS `spaceline`.`Ticket Customer` (
  `flight_id`   INT         NOT NULL,
  `seat_number` VARCHAR(5)  NOT NULL,
  `passport_id` VARCHAR(45) NOT NULL,
  `country`     VARCHAR(20) NOT NULL,
  PRIMARY KEY (`flight_id`, `seat_number`, `passport_id`, `country`),
  INDEX `fk_Ticket_Seat1_idx` (`seat_number` ASC),
  INDEX `fk_Ticket_Customer1_idx` (`passport_id` ASC, `country` ASC),
  CONSTRAINT `fk_Ticket_Flight1`
  FOREIGN KEY (`flight_id`)
  REFERENCES `spaceline`.`Flight` (`flight_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_Seat1`
  FOREIGN KEY (`seat_number`)
  REFERENCES `spaceline`.`Seat` (`seat_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_Customer1`
  FOREIGN KEY (`passport_id`, `country`)
  REFERENCES `spaceline`.`Customer` (`passport_id`, `country`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

-- -------------------------------------------------------
-- Table `spaceline`,`Ticket Cost`
-- -------------------------------------------------------
DROP TABLE IF EXISTS `spaceline`.`Ticket Cost`;

CREATE TABLE `Ticket Cost`
(
  `flight_id`   INT   NOT NULL,
  `seat_type`   VARCHAR(20)   NOT NULL,
  `cost`        FLOAT NOT NULL,
  PRIMARY KEY (`flight_id`, `seat_type`),
  CONSTRAINT `Ticket Cost_``Flight``_``flight_id``_fk`
  FOREIGN KEY (`flight_id`)
  REFERENCES `spaceline`.`Flight` (`flight_id`)
);

-- -----------------------------------------------------
-- Table `spaceline`.`Spaceport Manager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spaceline`.`Spaceport Manager`;

CREATE TABLE IF NOT EXISTS `spaceline`.`Spaceport Manager` (
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `fk_Spaceport Manager_Employee1`
  FOREIGN KEY (`employee_id`)
  REFERENCES `spaceline`.`Employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spaceline`.`Flight Attendant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spaceline`.`Flight Attendant`;

CREATE TABLE IF NOT EXISTS `spaceline`.`Flight Attendant` (
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `fk_Flight Attendant_Employee1`
  FOREIGN KEY (`employee_id`)
  REFERENCES `spaceline`.`Employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spaceline`.`Flight Attendance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spaceline`.`Flight Attendance`;

CREATE TABLE IF NOT EXISTS `spaceline`.`Flight Attendance` (
  `employee_id` INT NOT NULL,
  `flight_id`   INT NOT NULL,
  PRIMARY KEY (`employee_id`, `flight_id`),
  INDEX `fk_Flight Attendance_Flight1_idx` (`flight_id` ASC),
  CONSTRAINT `fk_Flight Attendance_Flight Attendant1`
  FOREIGN KEY (`employee_id`)
  REFERENCES `spaceline`.`Flight Attendant` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Flight Attendance_Flight1`
  FOREIGN KEY (`flight_id`)
  REFERENCES `spaceline`.`Flight` (`flight_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spaceline`.`Spaceport Management`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spaceline`.`Spaceport Management`;

CREATE TABLE IF NOT EXISTS `spaceline`.`Spaceport Management` (
  `employee_id` INT         NOT NULL,
  `country`     VARCHAR(20) NOT NULL,
  `city`        VARCHAR(30) NOT NULL,
  `from_date`   DATETIME    NOT NULL,
  `to_date`     DATETIME    NULL,
  PRIMARY KEY (`employee_id`, `country`, `city`, `from_date`),
  INDEX `fk_Spaceport Management_Spaceport1_idx` (`country` ASC, `city` ASC),
  CONSTRAINT `fk_Spaceport Management_Spaceport Manager1`
  FOREIGN KEY (`employee_id`)
  REFERENCES `spaceline`.`Spaceport Manager` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Spaceport Management_Spaceport1`
  FOREIGN KEY (`country`, `city`)
  REFERENCES `spaceline`.`Spaceport` (`country`, `city`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;

USE spaceline;
SHOW TABLES;
-- describe `Spaceship Model`;
-- describe Path;
-- describe Spaceport;
-- describe Employee;
-- describe Seat;
DESCRIBE `Spaceport Management`;

INSERT INTO Spaceport VALUES
  ('Taiwan', 'Taipei', 5, 'Earth'),
  ('United States', 'Los Angeles', 10, 'Earth'),
  ('China', 'Beijing', 45, 'Earth'),
  ('Marsland', 'Chinatown', 10, 'Mars');
#select * from Spaceport;

INSERT INTO `Spaceship Model` VALUES
  ('Bebop CB-369', 796),
  ('Iepiat 101', 1052);
#select * from `Spaceship Model`;

INSERT INTO `Spaceship` VALUES
  (1, 2021, 'Bebop CB-369');
#select * from `Spaceship`;

INSERT INTO `Seat` VALUES
  ('A1', 'Economy Class', 1),
  ('A2', 'Economy Class', 1),
  ('B1', 'Economy Class', 1),
  ('C1', 'Economy Class', 1),
  ('D2', 'Economy Class', 1),
  ('D12', 'Economy Class', 1),
  ('H21', 'Economy Class', 1),
  ('I2', 'Business Class', 1),
  ('O4', 'Business Class', 1),
  ('X1', 'First Class', 1);

INSERT INTO `Path` VALUES
  ('China', 'Beijing', 'Marsland', 'Chinatown', 7, 2),
  ('Marsland', 'Chinatown', 'China', 'Beijing', 6, 2);
#select * from `Path`;

INSERT INTO `Customer` (country, passport_id, first_name, last_name) VALUES
  ('United States', '655787221', 'Claudette', 'Vore'),
  ('United States', '572984341', 'Mario', 'Neidert'),
  ('United States', '923984141', 'Felisha', 'Loving'),
  ('China', '383503186', 'Harvey', 'Byrnes'),
  ('China', '520249310', 'Jaleesa', 'Hennigan'),
  ('China', '309898126', 'Odilia', 'Braz'),
  ('Taiwan', '269965391', 'Meridith', 'Loll'),
  ('Taiwan', '245969586', 'Star', 'Plummill'),
  ('Canada', '925195869', 'Meagan', 'Janus'),
  ('United Kingdom', '736122232', 'Niesha', 'Paredes');
DESCRIBE `Customer`;

INSERT INTO Employee (employee_id, hire_date, first_name, last_name, salary) VALUES
  (1, '2037-1-16', 'Alex', 'Tai', 123400),
  (2, '2036-1-17', 'Clement', 'Chang', 84500),
  (3, '2020-1-1', 'Joseph', 'Huang', 8765400),
  (4, '2037-1-18', 'Sabrina', 'Ho', 84600),
  (5, '2037-1-19', 'Annshine', 'Wu', 84300),
  (6, '2037-1-20', 'Andrew', 'Yeh', 83100),
  (7, '2037-1-21', 'Ruben', 'Pinzon', 124000),
  (8, '2037-1-22', 'Justin', 'Wang', 83500),
  (9, '2037-1-23', 'Jill', 'Hsu', 87000),
  (10, '2037-2-1', 'Michael', 'Chen', 86300);
#select * from Employee;

INSERT INTO Pilot VALUE
  (1),
  (7),
  (10);
#select * from Pilot;

INSERT INTO `Spaceport Manager` VALUES
  (2),
  (6),
  (9);
#select * from `Spaceport Manager`;

INSERT INTO `Flight Attendant` VALUES
  (4),
  (5),
  (8);
#select * from `Flight Attendant`;

INSERT INTO `Spaceport Management` VALUES
  (2, 'United States', 'Los Angeles', '2037-2-7', '2038-6-3'),
  (6, 'China', 'Beijing', '2037-2-8', '2038-10-1'),
  (9, 'Marsland', 'Chinatown', '2037-2-9', '2038-10-15');
#select * from `Spaceport Management`;

INSERT INTO `Flight` (flight_id, spaceship_id, departure_country, departure_city, arrival_country, arrival_city, departure_time, arrival_time, employee_id) VALUES
  (1, 1, 'China', 'Beijing', 'Marsland', 'Chinatown', '20380315103425', '20380315174901', 7),
  (2, 1, 'Marsland', 'Chinatown', 'China', 'Beijing', '20380325103807', '20380325162811', 10);

delete from `Flight Attendance`;
INSERT INTO `Flight Attendance` VALUES
  (4, 1),
  (5, 1),
  (8, 1),
  (4, 2),
  (5, 2),
  (8, 2);
#select * from `Flight Attendance`;

delete from `Ticket Cost`;
INSERT INTO `Ticket Cost` (flight_id, seat_type, cost) VALUES
  (1, 'Economy Class', 100),
  (1, 'Business Class', 200),
  (1, 'First Class', 400),
  (2, 'Economy Class', 100),
  (2, 'Business Class', 200),
  (2, 'First Class', 400);

delete from `Ticket Customer`;
INSERT INTO `Ticket Customer` (flight_id, seat_number, passport_id, country) VALUES
  (1, 'A1', '655787221', 'United States'),
  (1, 'A2', '572984341', 'United States'),
  (1, 'B1', '923984141', 'United States'),
  (1, 'C1', '383503186', 'China'),
  (1, 'D2', '520249310', 'China'),
  (1, 'D12', '309898126', 'China'),
  (1, 'H21', '269965391', 'Taiwan'),
  (1, 'I2', '245969586', 'Taiwan'),
  (1, 'O4', '925195869', 'Canada'),
  (1, 'X1', '736122232', 'United Kingdom'),
  (2, 'O4', '655787221', 'United States'),
  (2, 'C1', '572984341', 'United States'),
  (2, 'A2', '923984141', 'United States'),
  (2, 'I2', '383503186', 'China'),
  (2, 'B1', '520249310', 'China'),
  (2, 'H21', '309898126', 'China'),
  (2, 'D2', '269965391', 'Taiwan'),
  (2, 'X1', '245969586', 'Taiwan'),
  (2, 'A1', '925195869', 'Canada'),
  (2, 'D12', '736122232', 'United Kingdom');

select * from `Ticket Cost` inner join `Seat` using (seat_type)
inner join `Ticket Customer` using (seat_number);

select * from Spaceship where year_in_use = 2021;

select * from Customer where country like 'Taiwan';

select * from Spaceport where planet like 'Mars';

select * from Flight where employee_id = 10;

select Employee.first_name, Employee.last_name from Employee inner join Pilot using (employee_id)
inner join Flight using (employee_id) inner join `Ticket Customer` using (flight_id)
inner join Customer using (passport_id, country) inner join Seat using (seat_number)
inner join `Ticket Cost` using (seat_type) where Customer.country like 'Taiwan'
and `Ticket Cost`.cost = 400 group by Flight.flight_id;

select sum(cost) from Flight inner join `Ticket Customer` using (flight_id)
inner join Seat using (seat_number) inner join `Ticket Cost` using (flight_id, seat_type)
where Flight.departure_country like 'Marsland' and Flight.departure_city like 'Chinatown'
and Flight.arrival_country like 'China' and Flight.arrival_city like 'Beijing'
and date(Flight.departure_time) = 20380325;

select first_name, last_name, count(*) as numFlights from `Flight Attendance`
inner join `Employee` using (employee_id) group by employee_id order by numFlights desc;

select first_name, last_name from Flight inner join
(select first_name, last_name, country as departure_country, city as departure_city,
from_date, to_date from `Spaceport Manager` inner join Employee using (employee_id)
inner join `Spaceport Management` using (employee_id)) as PortManagement
using (departure_country, departure_city) where flight_id = 1 and
Flight.departure_time > PortManagement.from_date
and Flight.departure_time < PortManagement.to_date ;

select country, count(*) as numCustomers from `Ticket Customer` inner join Customer
  using (passport_id, country) group by country;

USE spaceline;