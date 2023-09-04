CREATE TRIGGER guestKustutamine on guest for DELETE
as
INSERT INTO logi(kuupaev, kasutaja, andmed, tegevus)
SELECT GETDATE(), USER, CONCAT(deleted.first_name, ', ', deleted.last_name),'guest on kustutatud' from deleted
--Kontroll
DELETE FROM guest WHERE guestID=1
select * from guest;
select * from logi;
