add file ./script4.py;

USE test_01;;


SELECT 
    transform (ip, dt, url, size, status, info)
USING 
    'python3 ./script4.py' 
AS 
    (ip, dt, url, size, status, info)
FROM 
    logs
LIMIT 
    10;
