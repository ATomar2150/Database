/*
1. Fixed coloum name: returnDamaged --> returnedDamaged
2. Ran the given Query
3. This query provides names of thoses Costumes Which:
	- Was rented
	- Was returned
	- Is Damaged
4. This query helps management to do things:
	- Fix the damaged dresses
	- Make dress unavailable for rental
5. Result: Zombie & Ghost costumes are damaged.
*/

Use Costume
SELECT costumeName as 'DamagedCostumes'
FROM dbo.Costume
WHERE id IN ( SELECT costumeId
                 FROM dbo.CostumeRental
                WHERE returnedDate IS NOT NULL
                      AND returnedDamaged = 1 )
