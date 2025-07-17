USE BookLearning;

ALTER TABLE Vendors
ADD vend_phone CHAR(20);

ALTER TABLE Vendors
DROP COLUMN vend_phone;

DROP TABLE CustCopy;

ALTER TABLE Vendors
ADD COLUMN vend_web CHAR(100);

UPDATE Vendors
SET vend_web = 'www.baidu.com'
WHERE vend_id = 'DLL01';

SELECT * 
FROM Vendors;



