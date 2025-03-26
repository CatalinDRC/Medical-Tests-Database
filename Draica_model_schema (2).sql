use lefti_draicagheorghe;


create table if not exists Test_Stations(
	test_station_id int primary key not null auto_increment,
    physical_address varchar(255) not null,
    other_details varchar(255) not null
);
    
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

create table if not exists Ref_Test_Results(
	result_status_code int primary key not null auto_increment,
    result_status_description varchar(255) not null
);

create table if not exists Medical_Review_Board(
	review_board_id int primary key not null auto_increment,
    date_created varchar(255) not null,
    date_wound_up varchar(255) not null,
    other_details varchar(255) not null
);

create table if not exists Medical_Policy_and_Guidelines(
	guideline_id int primary key not null auto_increment,
    review_board_id int not null,
    foreign key(review_board_id) references Medical_Review_Board(review_board_id),
    date_estabilished varchar(255) not null,
    guildeine_text varchar(255) not null,
    other_details varchar(255) not null
);


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


create table if not exists Tests(
	test_id int primary key not null auto_increment,
    guideline_id int not null,
    foreign key(guideline_id) references Medical_Policy_and_Guidelines(guideline_id),
    date_estabilished varchar(255) not null,
    date_last_used varchar(255) not null,
    test_text varchar(255) not null,
    other_details varchar(255) not null
);



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


create table if not exists Battery_of_Tests(
	battery_id int primary key not null auto_increment,
    date_defined varchar(255) not null,
    date_last_used varchar(255) not null,
    battery_name varchar(255) not null,
    battery_description varchar(255) not null,
    otehr_details varchar(255) not null
);



create table if not exists Tests_in_Battery(
	battery_id int not null,
    test_id int not null,
    foreign key(battery_id) references Battery_of_Tests(battery_id),
    foreign key(test_id) references Tests(test_id)
);



