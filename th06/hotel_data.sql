USE hotel;
GO
-- Insert data into room_type
INSERT INTO room_type(id, "description")
SELECT X.myrow.query('id').value('.', 'VARCHAR(20)') AS id,
       X.myrow.query('description').value('.', 'VARCHAR(500)') AS "description"
FROM (
	SELECT CAST(x AS XML)
	FROM OPENROWSET (
		BULK '<<Đường dẫn đến file room_type.xml>>',
		SINGLE_BLOB
	) AS T(x)
) AS U(x)
CROSS APPLY x.nodes('data/row') AS X(myrow)
GO

-- Insert data into rate
INSERT INTO rate(room_type, occupancy, amount)
SELECT X.myrow.query('room_type').value('.', 'VARCHAR(20)') AS id,
       X.myrow.query('occupancy').value('.', 'INT') AS occupancy,
	   X.myrow.query('amount').value('.', 'INT') AS amount
FROM (
	SELECT CAST(x AS XML)
	FROM OPENROWSET (
		BULK '<<Đường dẫn đến file rate.xml>>',
		SINGLE_BLOB
	) AS T(x)
) AS U(x)
CROSS APPLY x.nodes('data/row') AS X(myrow)
GO

-- Insert data into room
INSERT INTO room(id, room_type, max_occupancy)
SELECT X.myrow.query('id').value('.', 'INT') AS id,
       X.myrow.query('room_type').value('.', 'VARCHAR(20)') AS room_type,
	   X.myrow.query('max_occupancy').value('.', 'INT') AS max_occupancy
FROM (
	SELECT CAST(x AS XML)
	FROM OPENROWSET (
		BULK '<<Đường dẫn đến file room.xml>>',
		SINGLE_BLOB
	) AS T(x)
) AS U(x)
CROSS APPLY x.nodes('data/row') AS X(myrow)
GO

-- Insert data into guest
SET IDENTITY_INSERT guest ON;
INSERT INTO guest(id, first_name, last_name, "address")
SELECT X.myrow.query('index').value('.', 'INT') AS id,
	   X.myrow.query('first_name').value('.', 'VARCHAR(50)') AS first_name,
       X.myrow.query('last_name').value('.', 'VARCHAR(50)') AS last_name,
	   X.myrow.query('address').value('.', 'VARCHAR(250)') AS "address"
FROM (
	SELECT CAST(x AS XML)
	FROM OPENROWSET (
		BULK '<<Đường dẫn đến file guest.xml>>',
		SINGLE_BLOB
	) AS T(x)
) AS U(x)
CROSS APPLY x.nodes('data/row') AS X(myrow)
SET IDENTITY_INSERT guest OFF;
GO

-- Insert data into booking
SET IDENTITY_INSERT booking ON;
INSERT INTO booking(booking_id, booking_date, room_no, guest_id, occupants, room_type_requested, nights, arrival_time)
SELECT X.myrow.query('booking_id').value('.', 'INT') AS booking_id,
       X.myrow.query('booking_date').value('.', 'DATE') AS booking_date,
       X.myrow.query('room_no').value('.', 'VARCHAR(50)') AS room_no,
	   X.myrow.query('guest_id').value('.', 'VARCHAR(250)') AS guest_id,
	   X.myrow.query('occupants').value('.', 'INT') AS occupants,
	   X.myrow.query('room_type_requested').value('.', 'VARCHAR(20)') AS room_type_requested,
	   X.myrow.query('nights').value('.', 'INT') AS nights,
	   X.myrow.query('arrival_time').value('.', 'INT') AS arrival_time
FROM (
	SELECT CAST(x AS XML)
	FROM OPENROWSET (
		BULK '<<Đường dẫn đến file booking.xml>>',
		SINGLE_BLOB
	) AS T(x)
) AS U(x)
CROSS APPLY x.nodes('data/row') AS X(myrow)
SET IDENTITY_INSERT booking OFF;
	--booking_id INT IDENTITY(1,1) PRIMARY KEY,
	--booking_date DATE,
	--room_no INT FOREIGN KEY REFERENCES [room] (id),
	--guest_id INT FOREIGN KEY REFERENCES [guest] (id),
	--occupants INT,
	--room_type_requested VARCHAR(20),
	--nights INT,
	--arrival_time INT,

--delete from booking;
--delete from guest;

--select * from room
--select * from rate
--select * from room_type
--select * from booking

