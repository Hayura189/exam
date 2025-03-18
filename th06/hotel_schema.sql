CREATE DATABASE hotel;
GO
USE hotel;
GO

-- Create tables
CREATE TABLE room_type (
	id VARCHAR(20) NOT NULL PRIMARY KEY,
	"description" VARCHAR(500)
)
GO

CREATE TABLE rate (
	room_type VARCHAR(20) NOT NULL,
	occupancy INT NOT NULL,
	amount INT,
	PRIMARY KEY (room_type, occupancy),
	FOREIGN KEY (room_type) REFERENCES room_type (id) ON DELETE CASCADE ON UPDATE CASCADE
)
GO

CREATE TABLE room (
	id INT NOT NULL PRIMARY KEY,
	room_type VARCHAR(20) NOT NULL,
	max_occupancy INT,
	FOREIGN KEY (room_type) REFERENCES room_type (id) ON DELETE CASCADE ON UPDATE CASCADE
)
GO

CREATE TABLE guest (
	id INT IDENTITY(1,1) PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	"address" VARCHAR(250)
)
GO

CREATE TABLE booking(
	booking_id INT IDENTITY(1,1) PRIMARY KEY,
	booking_date DATE,
	room_no INT,
	guest_id INT,
	occupants INT,
	room_type_requested VARCHAR(20),
	nights INT,
	arrival_time INT,
	FOREIGN KEY (room_no) REFERENCES room (id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (guest_id) REFERENCES guest (id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (room_type_requested,occupants) REFERENCES rate (room_type, occupancy) ON DELETE NO ACTION ON UPDATE NO ACTION
)
GO