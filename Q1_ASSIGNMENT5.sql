/*
Write a single query to show a list of costumes that have been rented within the last 2 weeks. In your query include the following information:
•	Costume rented
•	Name of person who rented the costume (formatted nicely)
•	Date rented (just the date without a time)
Sort the result with the latest rental first
*/

--Review of participating tables

--Query
Use Costume
Go
Select 
c.costumeName,
cr.rentedToFirstName + ' ' + cr.rentedToLastName as customerName,
(Select  Cast(cr.rentedDate as date)) as 'rentedOn'
From CostumeRental cr 
INNER JOIN Costume c ON c.id = cr.costumeId
Where (cr.rentedDate) >= GETDATE() - 14
Order By 'rentedOn' DESC;



