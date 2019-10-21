/*
Write a query that would create a brand new table of costumes named “ScaryCostumes” 
that include only those that are rated at “Scary” or above on the scare-factor. 
Include the following information in the new table:
•	Costume Name
•	Costume Description
•	UPC Code

*/

--Analysis

Use Costume
SELECT id, costumeName, costumeDescription, upcCode
INTO ScaryCostumes 
FROM  Costume
WHERE scareRatingId >= 60;

Select * from ScaryCostumes;


