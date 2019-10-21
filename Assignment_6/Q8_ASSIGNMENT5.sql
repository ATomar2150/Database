/*
Write a query to retrieve the top 60% of all costumes that have a mask in their costume description. 
Provide the following information:
•	Costume Name
•	Costume Description
•	Costume Colour
•	Number of pieces
•	Number currently in stock
•	The date it was last rented
Order the single set of results by costume name. 
Note that there may costumes that have not been rented so take that into account
*/
Use
Costume
SELECT DISTINCT TOP 60 PERCENT 
c.costumeName,
c.costumeDescription,
c.colour,
c.numPieces,
(Select CostumeInventory.numberInStock From CostumeInventory 
where c.id = CostumeInventory.costumeId) as numInStock,
(Cast(cr.rentedDate as date)) as 'dateLastRented'
From Costume c
LEFT OUTER JOIN CostumeRental cr ON c.id = cr.costumeId
Where c.costumeDescription like '%[m-M]ask%'
ORDER BY c.costumeName ASC;
