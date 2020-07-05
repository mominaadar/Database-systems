CREATE DATABASE nutec;

CREATE TABLE `reg_record`(
	`rollno` VARCHAR(7) NOT NULL,
	`name` VARCHAR(15) NOT NULL,
	`email` VARCHAR(18) NOT NULL,
	`dept` VARCHAR(20) NOT NULL,
	`event` VARCHAR(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET = latin1;


ALTER TABLE `reg_record`
ADD PRIMARY KEY(`rollno`);
