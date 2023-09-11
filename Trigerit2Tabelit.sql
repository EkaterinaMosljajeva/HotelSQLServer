--Reservation ja guest

--Triger mis jälgib tabelisse lisamine
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

--Triger mis jälgib tabelisse uuendamine 
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