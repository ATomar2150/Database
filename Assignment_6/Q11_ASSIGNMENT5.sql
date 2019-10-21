/*
Write a query to update the costume rental information. 
Rachel Scruff just now returned the costume that she had rented and it is damaged. 
Include a comment that she claims it was damaged before she rented it. 
In your results show your update statement 
and then write a SELECT statement to show that the data has been updated in the table.
*/

--Query
BEGIN TRANSACTION
Update CostumeRental
Set returnedDate = GETDATE(),
	returnedDamaged = '1',
	rentalComments = 'Mask of zombie dress was broken when customer opened the box.'
Where rentedToFirstName = 'Rachel' AND rentedToLastName = 'Scruff';
Select * from CostumeRental
Where rentedToFirstName = 'Rachel' AND rentedToLastName = 'Scruff';
COMMIT