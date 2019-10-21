USE Costume
GO
SELECT costumeName
FROM dbo.Costume
WHERE colour IN ( 'Brown', 'Black', 'Green', 'White');

