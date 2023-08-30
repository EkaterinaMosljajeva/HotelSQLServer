CREATE TABLE guest(
guestID int primary key identity(1,1),
first_name varchar(80),
last_name varchar (80) NULL,
member_since date)

CREATE TABLE room_type(
roomTypeID int PRIMARY KEY identity(1,1),
description_ varchar(80),
max_capacity int)

CREATE TABLE reservation(
reservationID int primary key identity(1,1),
date_in date,
date_out date,
made_by varchar(20),
guestID int,
FOREIGN KEY (guestID) REFERENCES guest(guestID))

CREATE TABLE reserved_room(
reserved_roomID int primary key identity(1,1),
number_of_rooms int,
roomTypeID int,
FOREIGN KEY (roomTypeID) REFERENCES room_type(roomTypeID),
reservationID int,
FOREIGN KEY (reservationID) REFERENCES reservation(reservationID),
status varchar(20))

CREATE TABLE room(
roomID int primary key identity(1,1),
number varchar(10),
name varchar(40),
status varchar(10),
smoke bit,
roomTypeID int,
FOREIGN KEY (roomTypeID) REFERENCES room_type(roomTypeID))

CREATE TABLE occupied_room(
occupied_roomID int primary key identity(1,1),
check_in datetime,
check_out datetime,
roomID int,
FOREIGN KEY (roomID) REFERENCES room(roomID),
reservationID int,
FOREIGN KEY (reservationID) REFERENCES reservation(reservationID))

CREATE TABLE hosted_at(
hosted_atID int primary key identity(1,1),
guestID int,
FOREIGN KEY (guestID) REFERENCES guest(guestID),
occupied_roomID int,
FOREIGN KEY (occupied_roomID) REFERENCES occupied_room(occupied_roomID))