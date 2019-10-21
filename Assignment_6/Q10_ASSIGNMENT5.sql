/*
Write a query that simply gives us (from a single query) 
the total number of costumes that are in-stock, 
the total number that are on-order 
and the total number that have been lost. 
Be sure to include appropriate column heading names in your query.
*/

Use
Costume
SELECT SUM(ci.numberInStock) AS TotalCostumesInStock,
SUM(ci.numberOnOrder) AS TotalCostumesOnOrder,
SUM(ci.numberLost) AS TotalCostumesOnOrder
FROM CostumeInventory ci;
