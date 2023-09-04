CREATE TRIGGER guestLisamine on guest for insert
as
INSERT INTO logi(kuupaev, kasutaja, andmed, tegevus)
SELECT GETDATE(), USER, CONCAT(inserted.first_name, ', ', inserted.last_name),'guest on lisatud' from inserted
--Kontroll
INSERT INTO guest(first_name, last_name, member_since)
VALUES('Aleksander', 'Ivanov', '2022-05-15')
