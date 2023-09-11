--Reservation ja guest

--Triger mis jälgib tabelisse lisamine (SQL SERVER)
CREATE TRIGGER reservationLisamine
ON reservation
FOR INSERT
AS
INSERT INTO logi(kuupaev,andmed,kasutaja)
SELECT GETDATE(),
CONCAT(inserted.reservationID,', ', g.guestID),
USER
FROM inserted
INNER JOIN guest g ON inserted.guestID=g.guestID
--kontroll
INSERT INTO guest(first_name, last_name, member_since)
VALUES('Aleksander', 'Ivanov', '2022-05-15')

--Triger mis jälgib tabelisse uuendamine (SQL SERVER)
CREATE TRIGGER reservationUuendamine
ON reservation
FOR UPDATE
AS
INSERT INTO logi(kuupaev,andmed,kasutaja)
SELECT GETDATE(),
CONCAT('Vanad andmed ',deleted.date_out,', ', g1.last_name, ' Uued -', inserted.date_out,', ', g2.last_name),
USER
FROM deleted
INNER JOIN inserted ON deleted.reservationID=inserted.reservationID
INNER JOIN guest g1 ON deleted.guestID=g1.guestID
INNER JOIN guest g2 ON inserted.guestID=g2.guestID
--kontroll
UPDATE reservation SET date_out='2023-10-24'
WHERE reservationID=1;

--Triger mis jälgib tabelisse uuendamine (XAMPP)
CREATE TRIGGER `reservationLisamine` BEFORE INSERT ON `reservation` FOR EACH ROW *
INSERT INTO logi(kuupaev,andmed,kasutaja) 
VALUES (NOW(), 
CONCAT(NEW.reservationID,', ', g.guestID), 
USER())
FROM reservation 
INNER JOIN guest g ON NEW.guestID=g.guestID

--Triger mis jälgib tabelisse uuendamine (XAMPP)
CREATE TRIGGER `reservationUuendamine` BEFORE UPDATE ON `reservation` FOR EACH ROW 
INSERT INTO logi(kuupaev,andmed,kasutaja) 
VALUES (NOW(), CONCAT('Vanad andmed ',OLD.date_out,', ', g1.last_name, '\n Uued -', NEW.date_out,', ', g2.last_name), 
USER())
FROM reservation r 
INNER JOIN guest g1 ON OLD.guestID=g1.guestID 
INNER JOIN guest g2 ON NEW.guestID=g2.guestID 
WHERE r.reservationID=NEW.reservationID 
