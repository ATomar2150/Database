/*
Write a single query that retrieves the costumes names and how many times 
that they’ve been rented as shown in the CostumeRental table. 
Sort the results by the number of times that they’ve been rented and 
then secondarily within the same query by costume name. 
Note that this is a bit tricky so 
a) 
Start building your SQL in steps to help get you what you need and 
b) don’t forget to include costumes that have never been rented. 
This should result in 12 rows being returned.
*/

Select c.costumeName,
COUNT(cr.costumeId) as numberOfTimesRented
From Costume c
LEFT OUTER JOIN CostumeRental cr ON c.id = cr.costumeId
GROUP BY c.costumeName
ORDER BY numberOfTimesRented DESC, c.costumeName
