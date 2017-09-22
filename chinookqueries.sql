1. --Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT FirstName, LastName, CustomerID, Country 
FROM Customer 
WHERE NOT Country = 'USA'

2. --Provide a query only showing the Customers from Brazil.
SELECT * FROM Customer 
WHERE Country = 'Brazil'

3. --Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT FirstName, LastName, Customer.CustomerID, InvoiceID, InvoiceDate, Country 
FROM Customer 
LEFT JOIN Invoice 
WHERE Country = 'Brazil' and Customer.CustomerID = Invoice.CustomerID

4. --Provide a query showing only the Employees who are Sales Agents.
SELECT * FROM Employee 
WHERE Title = 'Sales Support Agent'

5. --Provide a query showing a unique list of billing countries from the Invoice table.
SELECT DISTINCT BillingCountry FROM Invoice

6. --Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT Employee.FirstName, Employee.LastName, Customer.CustomerID, InvoiceID, InvoiceDate 
FROM Employee 
LEFT JOIN Invoice 
LEFT JOIN Customer 
WHERE Customer.CustomerID = Invoice.CustomerID and Customer.SupportRepID = Employee.EmployeeID 
ORDER BY Invoice.InvoiceID

7. --Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
SELECT Invoice.total, Customer.FirstName, Customer.LastName, Invoice.BillingCountry, Employee.FirstName, Employee.LastName 
FROM Employee 
LEFT JOIN Invoice LEFT JOIN Customer 
WHERE Customer.CustomerID = Invoice.CustomerID and Customer.SupportRepID = Employee.EmployeeID 
ORDER BY Customer.FirstName

8. --How many Invoices were there in 2009 and 2011? What are the respective total sales for each of those years?
SELECT Total, InvoiceDate 
FROM Invoice 
WHERE InvoiceDate BETWEEN '2009-01-01' and '2011-12-31'

SELECT SUM(Total)
FROM Invoice 
WHERE InvoiceDate BETWEEN '2009-01-01' and '2010-01-01'

9. --Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
SELECT COUNT()
FROM InvoiceLine 
WHERE InvoiceID = 37

10. --Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY
SELECT COUNT()
FROM InvoiceLine 
GROUP BY InvoiceID

11. --Provide a query that includes the track name with each invoice line item.
SELECT InvoiceLine.InvoiceLineID, Track.Name
FROM InvoiceLine 
LEFT JOIN Track
WHERE InvoiceLine.TrackID = Track.TrackID
ORDER BY InvoiceLineID

-- SELECT COUNT(), Track.Name
-- FROM InvoiceLine 
-- LEFT JOIN Track
-- WHERE InvoiceLine.TrackID = Track.TrackID
-- GROUP BY InvoiceID

12. --Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT Invoice.InvoiceID, Track.Name, Artist.Name
FROM Track
JOIN Artist
JOIN Album
JOIN Invoice
JOIN InvoiceLine
WHERE InvoiceLine.InvoiceID = Invoice.InvoiceID and InvoiceLine.TrackID = Track.TrackID and Track.AlbumID = Album.AlbumID and Album.ArtistId = Artist.ArtistID

13. --Provide a query that shows the # of invoices per country. HINT: GROUP BY
SELECT COUNT(), BillingCountry
FROM Invoice
GROUP BY BillingCountry

14. --Provide a query that shows the total number of tracks in each playlist. The Playlist name should be included on the resultant table.
SELECT COUNT(Playlist.PlaylistID), Playlist.Name
FROM Playlist
JOIN PlaylistTrack
WHERE PlaylistTrack.PlaylistID = Playlist.PlaylistID
GROUP BY Playlist.PlaylistID

15. --Provide a query that shows all the Tracks, but displays no IDs. The resultant table should include the Album name, Media type and Genre.
SELECT Track.Name, Album.Title, MediaType.Name AS 'Media Type', Genre.Name AS 'Genre'
FROM Track
JOIN Album
JOIN MediaType
JOIN Genre
WHERE Track.AlbumID = Album.AlbumID and Track.GenreID = Genre.GenreID and Track.MediaTypeId = MediaType.MediaTypeId


16. -- Provide a query that shows all Invoices but includes the # of invoice line items.
SELECT Invoice.InvoiceID, Count(InvoiceLine.Quantity) AS 'Quantity'
FROM Invoice
JOIN InvoiceLine
WHERE Invoice.InvoiceID = InvoiceLine.InvoiceId
GROUP BY InvoiceLine.InvoiceID

17. -- Provide a query that shows total sales made by each sales agent.
SELECT Employee.FirstName, COUNT(InvoiceLine.Quantity)
FROM Employee
JOIN Customer
JOIN Invoice
JOIN InvoiceLine
WHERE Invoice.CustomerID = Customer.CustomerID and Customer.SupportRepId = Employee.EmployeeID and Invoice.InvoiceID = InvoiceLine.InvoiceId
GROUP BY Employee.EmployeeId

18. -- Which sales agent made the most in sales in 2009?
SELECT Employee.FirstName, COUNT(InvoiceLine.Quantity) AS 'Total'
FROM Employee
JOIN Customer
JOIN Invoice
JOIN InvoiceLine
WHERE Invoice.CustomerID = Customer.CustomerID and Customer.SupportRepId = Employee.EmployeeID and Invoice.InvoiceID = InvoiceLine.InvoiceId 
and Invoice.InvoiceDate BETWEEN '2009-01-01' and '2009-12-31'
GROUP BY Employee.EmployeeId
ORDER BY Total DESC LIMIT 1

19. -- Which sales agent made the most in sales in 2010?
SELECT Employee.FirstName, COUNT(InvoiceLine.Quantity) AS 'Total'
FROM Employee
JOIN Customer
JOIN Invoice
JOIN InvoiceLine
WHERE Invoice.CustomerID = Customer.CustomerID and Customer.SupportRepId = Employee.EmployeeID and Invoice.InvoiceID = InvoiceLine.InvoiceId 
and Invoice.InvoiceDate BETWEEN '2010-01-01' and '2010-12-31'
GROUP BY Employee.EmployeeId
ORDER BY Total DESC LIMIT 1


20. -- Which sales agent made the most in sales over all?
SELECT Employee.FirstName, COUNT(InvoiceLine.Quantity) AS 'Total'
FROM Employee
JOIN Customer
JOIN Invoice
JOIN InvoiceLine
WHERE Invoice.CustomerID = Customer.CustomerID and Customer.SupportRepId = Employee.EmployeeID and Invoice.InvoiceID = InvoiceLine.InvoiceId 
GROUP BY Employee.EmployeeId
ORDER BY Total DESC LIMIT 1

21. --Provide a query that shows the # of customers assigned to each sales agent.
SELECT Employee.FirstName, COUNT(Customer.CustomerID)
FROM Employee
JOIN Customer
WHERE Customer.SupportRepId = Employee.EmployeeID
GROUP BY Employee.EmployeeId

22. --Provide a query that shows the total sales per country. Which country's customers spent the most?
SELECT Invoice.BillingCountry, SUM(Invoice.Total) as 'Total'
FROM Invoice
GROUP BY Invoice.BillingCountry
ORDER BY Total DESC LIMIT 1

23. --Provide a query that shows the most purchased track of 2013.
SELECT Track.Name, COUNT(InvoiceLine.InvoiceLineID) as 'Total'
FROM Invoice
JOIN InvoiceLine ON InvoiceLine.InvoiceID = Invoice.InvoiceID
JOIN Track ON Track.TrackID = InvoiceLine.TrackID
WHERE Invoice.InvoiceDate BETWEEN '2013-01-01' and '2013-12-31'
GROUP BY Track.Name
ORDER BY Total DESC


24. --Provide a query that shows the top 5 most purchased tracks over all.
SELECT Track.Name, COUNT(InvoiceLine.InvoiceLineID) as 'Total'
FROM Invoice
JOIN InvoiceLine ON InvoiceLine.InvoiceID = Invoice.InvoiceID
JOIN Track ON Track.TrackID = InvoiceLine.TrackID
WHERE Invoice.InvoiceDate
GROUP BY Track.Name
ORDER BY Total DESC LIMIT 5

25. --Provide a query that shows the top 3 best selling artists.
SELECT Artist.Name, COUNT(InvoiceLine.InvoiceLineID) as 'Total'
FROM Invoice
JOIN Album ON Album.AlbumID = Track.AlbumID
JOIN Artist on Artist.ArtistID = Album.ArtistID
JOIN InvoiceLine ON InvoiceLine.InvoiceID = Invoice.InvoiceID
JOIN Track ON Track.TrackID = InvoiceLine.TrackID
WHERE Invoice.InvoiceDate
GROUP BY Artist.Name
ORDER BY Total DESC LIMIT 3

26. --Provide a query that shows the most purchased Media Type.
SELECT MediaType.Name, COUNT(InvoiceLine.InvoiceLineID) as 'Total'
FROM Invoice
JOIN InvoiceLine ON InvoiceLine.InvoiceID = Invoice.InvoiceID
JOIN Track ON Track.TrackID = InvoiceLine.TrackID
JOIN MediaType ON Track.MediaTypeID = MediaType.MediaTypeID
WHERE Invoice.InvoiceDate
GROUP BY MediaType.Name
ORDER BY Total DESC LIMIT 1

27. --Provide a query that shows the number tracks purchased in all invoices that contain more than one genre.

SELECT InvoiceLine.InvoiceID, COUNT(DISTINCT Genre.GenreID) as 'Genres'
FROM Invoice
JOIN Genre ON Genre.GenreID = Track.GenreID
JOIN InvoiceLine ON InvoiceLine.InvoiceID = Invoice.InvoiceID
JOIN Track ON Track.TrackID = InvoiceLine.TrackID
JOIN MediaType ON Track.MediaTypeID = MediaType.MediaTypeID
GROUP BY Invoice.InvoiceID
HAVING COUNT(DISTINCT Genre.GenreID) > 1;