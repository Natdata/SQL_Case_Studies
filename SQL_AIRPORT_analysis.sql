use [Flights]
go

-- First need to change ID columns for not null and then set a primary and foreign keys

-- Airplane table
ALTER TABLE[dbo].[Airports]
ALTER COLUMN [Airport ID] NVARCHAR (55) NOT NULL;

 -- Flights table
ALTER TABLE[dbo].[Flights]
ALTER COLUMN [Flight ID] NVARCHAR(55) NOT NULL;

ALTER TABLE[dbo].[Flights]
ALTER COLUMN [Departure Airport ID] NVARCHAR(55) NOT NULL;

ALTER TABLE[dbo].[Flights]
ALTER COLUMN [Arrival Airport ID] NVARCHAR(55) NOT NULL;

ALTER TABLE[dbo].[Flights]
ALTER COLUMN [Plane ID] NVARCHAR(55) NOT NULL;

--Plane table
ALTER TABLE[dbo].[Planes]
ALTER COLUMN [Plane ID] NVARCHAR(55) NOT NULL;

ALTER TABLE [dbo].[Airports]
ADD PRIMARY KEY ([Airport ID]);

ALTER TABLE [dbo].[Flights]
ADD PRIMARY KEY ([Flight ID]);


ALTER TABLE [dbo].[Planes]
ADD PRIMARY KEY ([Plane ID]);


ALTER TABLE [dbo].[Flights]
ADD FOREIGN KEY ([Arrival Airport ID])
REFERENCES [dbo].[Airports]([Airport ID]);

ALTER TABLE [dbo].[Flights]
ADD FOREIGN KEY ([Departure Airport ID])
REFERENCES [dbo].[Airports]([Airport ID]);

ALTER TABLE [dbo].[Flights]
ADD FOREIGN KEY ([Plane ID])
REFERENCES [dbo].[Planes]([Plane ID]);

-- Creating master table

SELECT 
F.[Flight ID],
F.[Airline],
F.[Departure Airport ID],
F.[Arrival Airport ID],
F.[Plane ID],
F.[Flight Delay Flag],
F.[Flight Delay Time (mins)],
A.[Airport Country]					AS [DEPARTURE AIRPORT COUNTRY],
A.[Opening Year]					AS [DEPARTURE AIRPORT OPENING YEAR],
A.[Customer Satisfaction Rating]	AS [DEPARTURE AIRPORT Customer Satisfaction Rating],
AA.[Airport Country]				AS [ARRIVAL AIRPORT COUNTRY],
AA.[Opening Year]					AS [ARRIVAL AIRPORT OPENING YEAR],
AA.[Customer Satisfaction Rating]	AS [ARRIVAL AIRPORT Customer Satisfaction Rating],
P.[Plane Name],
P.[Suppliers Name],
P.[Passenger Capacity],
P.[Commission Year],
P.[Life Time]
INTO [Flights - Master]
FROM [dbo].[Flights] F
LEFT JOIN [dbo].[Airports] A
ON F.[Departure Airport ID]=A.[Airport ID]
LEFT JOIN [dbo].[Airports] AA
ON F.[Arrival Airport ID] = AA.[Airport ID]
LEFT JOIN [dbo].[Planes] P
ON P.[Plane ID]=F.[Plane ID]

-- Analysis 

-- 1. nUMBERS OF Departure and arrival 

SELECT [Departure Airport ID],
[DEPARTURE AIRPORT COUNTRY],
[Arrival Airport ID],
[ARRIVAL AIRPORT COUNTRY],
COUNT(*) AS [Airport frequency]
FROM [dbo].[Flights - Master]
GROUP BY [Departure Airport ID],
[DEPARTURE AIRPORT COUNTRY],
[Arrival Airport ID],
[ARRIVAL AIRPORT COUNTRY];

-- 2. CUSTOMER SATYSFACTION RATING

-- DEPARTURE

SELECT [Departure Airport ID],
[DEPARTURE AIRPORT COUNTRY],
COUNT(*) AS [Airport frequency],
[DEPARTURE AIRPORT Customer Satisfaction Rating]
FROM [dbo].[Flights - Master]
GROUP BY [Departure Airport ID],
[DEPARTURE AIRPORT COUNTRY],
[DEPARTURE AIRPORT Customer Satisfaction Rating]
ORDER BY [DEPARTURE AIRPORT Customer Satisfaction Rating] DESC;

-- ARRIVAL

SELECT [Arrival Airport ID],
[ARRIVAL AIRPORT COUNTRY],
COUNT(*) AS [Airport frequency],
[ARRIVAL AIRPORT Customer Satisfaction Rating]
FROM [dbo].[Flights - Master]
GROUP BY [Arrival Airport ID],
[ARRIVAL AIRPORT COUNTRY],
[ARRIVAL AIRPORT Customer Satisfaction Rating]
ORDER BY [ARRIVAL AIRPORT Customer Satisfaction Rating] DESC;

-- 3. PLANE HISTORY VS FLIGHT DELAYS

SELECT [Plane ID],
 [Commission Year],[Passenger Capacity],[Flight Delay Flag],
COUNT(*) AS [NUMBER OF FLIGHTS]
FROM [dbo].[Flights - Master]
GROUP BY [Plane ID],
 [Commission Year], [Passenger Capacity],[Flight Delay Flag]
ORDER BY COUNT(*) DESC 