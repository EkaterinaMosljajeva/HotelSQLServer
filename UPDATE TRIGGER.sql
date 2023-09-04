CREATE TRIGGER guestUuendamine on guest for UPDATE
as
INSERT INTO logi(kuupaev, kasutaja, andmed, tegevus)
SELECT GETDATE(), USER, CONCAT('Vanad - ',deleted.first_name, ', ', deleted.last_name,
'UUED - ',inserted.first_name, ', ', inserted.last_name),'guest on uuendatud' 
from deleted INNER JOIN inserted
ON deleted.guestID=inserted.guestID

--Kontroll
UPDATE guest set first_name='Maria' WHERE guestID=3;
SELECT * from guest;
SELECT * FROM logi
