CREATE PROCEDURE lisaGuest
@nimi varchar(80),
@perenimi varchar(80) NULL,
@memberSince date
AS
BEGIN
INSERT INTO guest(first_name,last_name,member_since)
VALUES(@nimi,@perenimi,memberSince)
SELECT * FROM guest;
SELECT * FROM logi;
END
--Kontroll
EXEC guestLisamine 'Anton, 'Leonets', '05-05-2023';

CREATE PROCEDURE kustutaGuest
@id int
AS
BEGIN
DELETE FROM guest WHERE guestID=@id
SELECT * FROM guest;
SELECT * FROM logi;
END
--Kontroll
EXEC guestLisamine 2;

CREATE PROCEDURE uuendaGuest
AS
@nimi varchar(80),
@id int
BEGIN
UPDATE guest set first_name=@nimi WHERE guestID=@id;
SELECT * FROM guest;
SELECT * FROM logi;
END
--Kontroll
EXEC uuendaGuest 'Maria', 3;
