use hotel
--1. Truy vấn số lượng khách hàng có họ (last_name) là Johnson.
select count(id) as [number_guest] from guest
where last_name like 'Johnson'

--2. Truy vấn id, booking_id, booking_date và arrival_time của khách hàng David Johnson.
select id, booking_id, booking_date,arrival_time from guest
join booking on guest.id=booking.guest_id
where first_name like 'David' and last_name like 'Johnson'

--3. Truy vấn danh sách khách hàng (id, first_name, last_name,address, room_no) đã đặt phòng vào ngày 22-11-2016
select id, first_name, last_name,[address], room_no from guest
join booking on guest.id=booking.guest_id
where booking_date='2016-11-22'

--4. Truy vấn giá một đêm (amount) của những booking có id là 250,569, 666, 705 và 1175
select booking.booking_id, amount from booking
join rate on booking.room_type_requested=rate.room_type
where booking_id in (250,569,666,705,1175) and rate.occupancy=booking.occupants

--5. Truy vấn số lần đặt phòng và tổng số đêm của khách hàng Meghan Johnson.
select count(booking.booking_id) as [number_booking], sum(booking.nights) as [total_night] from booking
join guest on booking.guest_id=guest.id
where first_name like 'Meghan' and last_name like 'Johnson'

--6. Truy vấn tổng số tiền mà khách hàng David Johnson đã trả.
select sum(amount*nights) as [total] from booking
join guest on booking.guest_id=guest.id
join rate on booking.room_type_requested=rate.room_type
where first_name like 'David' and last_name like 'Johnson' and booking.occupants=rate.occupancy

--7. Thống kê số booking mỗi ngày trong tháng 3 năm 2016.
select day(booking_date) as [day],count(booking.booking_id) as [number_booking] from booking
where year(booking_date)=2016 and month(booking_date)=3
group by day(booking_date)

--8. Truy vấn first_name, last_name, address và tổng số đêm đã từng ở tại khách sạn này của những khách hàng đến từ London (address kết thúc là London).
select first_name, last_name, [address], sum(booking.nights) as [total_night] from booking
join guest on booking.guest_id=guest.id
where [address] like '%London'
group by first_name, last_name, [address]

--9. Truy vấn đơn đặt phòng có giá trị (tính bằng nights và amount) cao nhất vào ngày 19-07-2016.
select top 1 booking_id,booking_date,room_no,guest_id,occupants,room_type_requested,nights,arrival_time from booking
join rate on booking.room_type_requested=rate.room_type
where booking_date='2016-07-19' and booking.occupants=rate.occupancy
order by nights*amount desc

--10. Truy vấn ngày (booking_date) có tổng giá trị đơn đặt phòng cao nhất trong tháng 6 năm 2016.
select top 1 day(booking_date) as [day],sum(rate.amount*booking.nights) as [total] from booking
join rate on booking.room_type_requested=rate.room_type
where year(booking_date)=2016 and month(booking_date)=6 and booking.occupants=rate.occupancy
group by day(booking_date)
order by total desc


