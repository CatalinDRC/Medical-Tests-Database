use draica_schema;


create table if not exists Test_Stations(
	test_station_id int primary key not null auto_increment,
    physical_address varchar(255) not null,
    other_details varchar(255) not null
);
insert ignore into Test_Stations(physical_address, other_details) values
	('123 Main St', 'Has 4 testing bays'),
    ('456 Elm St', 'Open 24/7'),
    ('789 Oak Ave', 'Offers COVID-19 testing only'),
    ('321 Maple Rd', 'Located inside a shopping mall'),
    ('654 Pine Blvd', 'Provides rapid testing services');
    
create table if not exists Examiners(
	examiner_id int primary key not null auto_increment,
    fist_name varchar(255) not null,
    middle_name varchar(255) not null,
    last_name varchar(255) not null,
    date_of_birth varchar(255) not null,
    gender varchar(255) not null,
    date_appointed varchar(255) not null,
    licence_nr varchar(255) not null,
    place_of_issue varchar(255) not null,
    other_details varchar(255) not null
);


insert ignore into Examiners(fist_name, middle_name, last_name, date_of_birth, gender, date_appointed, licence_nr, place_of_issue, other_details) values
	('John', 'William', 'Smith', '1980-05-15', 'Male', '2020-01-01', '123456', 'New York', 'Specializes in internal medicine'),
	('Mary', 'Elizabeth', 'Johnson', '1992-08-12', 'Female', '2018-06-15', '789012', 'California', 'Specializes in pediatric'),
	('David', 'Andrew', 'Lee', '1985-12-28', 'Male', '2015-02-01', '345678', 'Texas', 'Specializes in cardiology'),
	('Anna', 'Maria', 'Garcia', '1998-03-22', 'Female', '2022-03-01', '901234', 'Florida', 'Specializes in neurology'),
	('Robert', 'Edward', 'Williams', '1977-11-05', 'Male', '2010-07-01', '567890', 'Arizona', 'Specializes in psychiatry');
	

create table if not exists Medical_Register(
	register_id int primary key not null auto_increment,
    first_name varchar(255) not null,
    middle_name varchar(255) not null,
    last_name varchar(255) not null,
    gender varchar(255) not null,
    date_of_birth varchar(255) not null,
    date_of_registration varchar(255) not null,
    address varchar(255) not null,
    health_characteristics varchar(255) not null,
    other_details varchar(255) not null
);
INSERT INTO Medical_Register (first_name, middle_name, last_name, gender, date_of_birth, date_of_registration, address, health_characteristics, other_details)
VALUES 
	('John', 'William', 'Doe', 'Male', '1990-05-12', '2021-02-15', '123 Main St, Anytown, USA', 'Type 2 diabetes', 'None'),
	('Mary', 'Elizabeth', 'Smith', 'Female', '1985-09-22', '2021-03-01', '456 Oak Ave, Anytown, USA', 'Asthma', 'Allergic to penicillin'),
	('James', 'Robert', 'Johnson', 'Male', '1978-11-03', '2021-03-15', '789 Elm St, Anytown, USA', 'High blood pressure', 'None'),
	('Sarah', 'Marie', 'Brown', 'Female', '1995-04-02', '2021-04-01', '321 Maple Ave, Anytown, USA', 'Anxiety', 'Vegetarian'),
	('Michael', 'David', 'Garcia', 'Male', '1980-07-18', '2021-04-15', '654 Pine St, Anytown, USA', 'Allergies', 'None');

create table if not exists Ref_Test_Results(
	result_status_code int primary key not null auto_increment,
    result_status_description varchar(255) not null
);
INSERT INTO Ref_Test_Results (result_status_description)
VALUES 
    ('Pass'),
    ('Fail'),
    ('Incomplete'),
    ('Pending'),
    ('Error');
create table if not exists Medical_Review_Board(
	review_board_id int primary key not null auto_increment,
    date_created varchar(255) not null,
    date_wound_up varchar(255) not null,
    other_details varchar(255) not null
);
INSERT INTO Medical_Review_Board (date_created, date_wound_up, other_details)
VALUES 
    ('2022-01-01', '2022-03-31', 'Patient A - Review for surgical complications'),
    ('2022-02-15', '2022-05-01', 'Patient B - Review for adverse drug reaction'),
    ('2022-03-10', '2022-06-30', 'Patient C - Review for medical negligence'),
    ('2022-04-25', '2022-08-15', 'Patient D - Review for misdiagnosis'),
    ('2022-05-20', '2022-09-30', 'Patient E - Review for treatment delay');
create table if not exists Medical_Policy_and_Guidelines(
	guideline_id int primary key not null auto_increment,
    review_board_id int not null,
    foreign key(review_board_id) references Medical_Review_Board(review_board_id),
    date_estabilished varchar(255) not null,
    guildeine_text varchar(255) not null,
    other_details varchar(255) not null
);
INSERT INTO Medical_Policy_and_Guidelines (review_board_id, date_estabilished, guildeine_text, other_details)
VALUES 
    (1, '2022-04-01', 'Guideline for surgical complication review', 'Applies to all surgical reviews conducted by the board'),
    (2, '2022-05-01', 'Guideline for adverse drug reaction review', 'Applies to all drug reaction reviews conducted by the board'),
    (3, '2022-06-01', 'Guideline for medical negligence review', 'Applies to all negligence reviews conducted by the board'),
    (4, '2022-07-01', 'Guideline for misdiagnosis review', 'Applies to all misdiagnosis reviews conducted by the board'),
    (5, '2022-08-01', 'Guideline for treatment delay review', 'Applies to all delay in treatment reviews conducted by the board');


create table if not exists Medical_Professionals(
	professional_id int primary key not null auto_increment,
    review_board_id int not null,
    foreign key(review_board_id) references Medical_Review_Board(review_board_id),
    first_name varchar(255) not null,
    middle_name varchar(255) not null,
    last_name varchar(255) not null,
    gender varchar(255) not null,
    date_of_birth varchar(255) not null,
    address varchar(255) not null,
    qualifications varchar(255) not null,
    other_details varchar(255) not null
);
INSERT INTO Medical_Professionals (review_board_id, first_name, middle_name, last_name, gender, date_of_birth, address, qualifications, other_details)
VALUES 
    (1, 'John', 'M', 'Doe', 'Male', '1980-01-01', '123 Main St, Anytown, USA', 'MD, FACS', 'Surgeon with over 10 years of experience'),
    (2, 'Jane', 'D', 'Smith', 'Female', '1985-05-15', '456 Oak Ave, Anytown, USA', 'PharmD', 'Pharmacist specializing in drug safety'),
    (3, 'Robert', 'J', 'Johnson', 'Male', '1975-08-20', '789 Elm Rd, Anytown, USA', 'JD, MD', 'Attorney and physician specializing in medical malpractice'),
    (4, 'Emily', 'K', 'Kim', 'Female', '1990-02-28', '111 Maple St, Anytown, USA', 'MD, MPH', 'Public health physician with experience in epidemiology'),
    (5, 'David', 'L', 'Lee', 'Male', '1988-11-12', '222 Pine Rd, Anytown, USA', 'RN, BSN, MSN', 'Nurse with advanced training in critical care');

create table if not exists Tests(
	test_id int primary key not null auto_increment,
    guideline_id int not null,
    foreign key(guideline_id) references Medical_Policy_and_Guidelines(guideline_id),
    date_estabilished varchar(255) not null,
    date_last_used varchar(255) not null,
    test_text varchar(255) not null,
    other_details varchar(255) not null
);
INSERT INTO Tests (guideline_id, date_estabilished, date_last_used, test_text, other_details)
VALUES 
    (1, '2020-01-01', '2022-03-15', 'Blood Pressure Test', 'Used to diagnose hypertension and other cardiovascular conditions'),
    (2, '2019-06-01', '2023-04-20', 'Mammogram', 'Used to detect breast cancer in women'),
    (3, '2021-03-01', '2023-04-22', 'COVID-19 PCR Test', 'Used to detect the presence of the SARS-CoV-2 virus in individuals'),
    (4, '2018-12-01', '2022-09-30', 'Colonoscopy', 'Used to screen for colon cancer and other digestive disorders'),
    (5, '2017-05-01', '2021-11-30', 'Pap Test', 'Used to screen for cervical cancer in women');


create table if not exists Tests_Taken(
	test_taken_id int primary key not null auto_increment,
    examiner_id int not null,
    foreign key (examiner_id) references Examiners(examiner_id),
    register_id int not null,
    foreign key (register_id) references Medical_Register(register_id),
    result_status_code int not null,
    foreign key (result_status_code) references Ref_Test_Results(result_status_code),
    test_id int not null,
    foreign key (test_id) references Tests(test_id),
    test_station_id int not null,
    foreign key (test_station_id) references Test_Stations(test_station_id),
    date_taken varchar(255) not null,
    test_results varchar(255) not null,
    other_details varchar(255) not null
);
INSERT INTO Tests_Taken (examiner_id, register_id, result_status_code, test_id, test_station_id, date_taken, test_results, other_details)
VALUES 
    (1, 1, 1, 1, 1, '2023-04-22', '120/80 mmHg', 'Patient is within normal blood pressure range'),
    (2, 2, 2, 2, 2, '2023-04-21', 'Negative', 'No evidence of breast cancer detected'),
    (3, 3, 3, 3, 3, '2023-04-20', 'Positive', 'Patient has tested positive for COVID-19'),
    (4, 4, 4, 4, 4, '2023-04-19', 'No abnormalities found', 'Patient has no visible signs of colon cancer'),
    (5, 5, 5, 5, 5, '2023-04-18', 'Negative', 'No evidence of cervical cancer detected');

create table if not exists Battery_of_Tests(
	battery_id int primary key not null auto_increment,
    date_defined varchar(255) not null,
    date_last_used varchar(255) not null,
    battery_name varchar(255) not null,
    battery_description varchar(255) not null,
    otehr_details varchar(255) not null
);
INSERT INTO Battery_of_Tests (date_defined, date_last_used, battery_name, battery_description, otehr_details) VALUES
('2022-01-01', '2022-05-01', 'Basic Medical Checkup', 'A standard set of medical tests for a general checkup', ''),
('2021-11-01', '2022-03-01', 'Cardiovascular Risk Assessment', 'A battery of tests to assess the risk of heart disease', 'Requires fasting before the test'),
('2022-02-01', '2022-06-01', 'Diabetes Screening', 'Tests to detect the presence of diabetes', 'Includes a glucose tolerance test'),
('2021-10-01', '2022-02-01', 'Thyroid Function Test', 'Tests to evaluate the function of the thyroid gland', 'May require fasting before the test'),
('2022-03-01', '2022-07-01', 'Allergy Test Panel', 'Tests to identify allergens causing an allergic reaction', 'May require stopping medications prior to the test');


create table if not exists Tests_in_Battery(
	battery_id int not null,
    test_id int not null,
    foreign key(battery_id) references Battery_of_Tests(battery_id),
    foreign key(test_id) references Tests(test_id)
);
INSERT INTO Tests_in_Battery (battery_id, test_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(2, 5);



