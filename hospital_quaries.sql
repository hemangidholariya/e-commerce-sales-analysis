
-- Hospital management project

-- create databse

create database hospital
use hospital

create table patients(
	patient_id INT IDENTITY(1,1) PRIMARY KEY,
	name VARCHAR(100),
	age INT,
	bloodtype VARCHAR(5)
)

insert into patients values
('Alice Walker', 30, 'O+'),
('Mark Evans', 45, 'A-'),
('Sarah Connor', 28, 'B+');

create table doctors(
	doctor_id INT IDENTITY(101,1) PRIMARY KEY,
	name VARCHAR(100),
	specialization VARCHAR(50),
	consultationfee DECIMAL(10,2)
)

insert into doctors values
('Dr. Strange', 'Neurology', 200.00),
('Dr. House', 'Diagnostics', 350.00),
('Dr. Grey', 'Surgery', 500.00);

create table appointments(
	appt_id INT IDENTITY(1,1) PRIMARY KEY,
	patient_id INT,
	doctor_id INT,
	apptdate DATETIME,
	status VARCHAR(50) DEFAULT 'Schedualed',
	FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
	FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
)

INSERT INTO appointments VALUES
(1,101, '2023-10-25 10:00:00', 'Completed'),
(2,102, '2023-10-26 14:00:00', 'Scheduled');

create table billings (
	biil_id INT IDENTITY(1,1) PRIMARY KEY,
	appt_id INT,
	amount DECIMAL(10,2),
	paymentstatus VARCHAR(20) DEFAULT 'Pending',
	FOREIGN KEY (appt_id) REFERENCES appointments(appt_id)
)

-- create a view

CREATE VIEW view_dailyschedule AS
SELECT 
a.appt_id,
p.name As Patientname,
d.name AS Doctorname,
a.apptdate,
a.status
From appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;

select * from view_dailyschedule;

--Stored Procedure

CREATE PROCEDURE BOOKappointment
	@patientid INT,
	@doctorid INT,
	@newdate DATETIME
AS
BEGIN
	IF EXISTS (select 1 from appointments where doctor_id = @doctorid AND apptdate = @newdate)
	BEGIN
		PRINT 'Error: Doctor is already booked at this time.';
	END
	ELSE
	BEGIN
		INSERT INTO appointments (patient_id,doctor_id,apptdate) 
		values (@patientid,@doctorid,@newdate)
		PRINT 'Sucess: appointment booked!';
	END
END;

EXEC BOOKappointment 2,103,'2023-10-27 14:00:00';

--Trigger

create trigger trg_generatebill
ON appointments
AFTER UPDATE
AS
BEGIN
	IF EXISTS (select * from inserted where status = 'Completed')
	BEGIN
		DECLARE @apptid INT, @doctorid INT, @fee DECIMAL(10,2);

		select @apptid = appt_id, @doctorid = doctor_id from inserted;

		select @fee = consultationfee from doctors where doctor_id = @doctorid;

		insert into billings (appt_id,amount)
		values(@apptid,@fee);

		PRINT 'Bill generated automatically.';
	END

END;

Update appointments set status = 'Pending' where appt_id = 2;
select * from billings;
select * from patients;
select * from doctors;
select * from appointments;