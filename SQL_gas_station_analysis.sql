-- USTAWIAMY PRIMARY I FOREIGN KEY DO TABELI
--1 Pre-proccesing

USE [Gas Station]
GO

  alter table [dbo].[Vehicles]
  alter COLUMN [Vehicle ID] NVARCHAR(50) NOT NULL;
  
  alter table [dbo].[Gas Station Fills]
  alter COLUMN [Vehicle ID] NVARCHAR(50) NOT NULL;

  alter table [dbo].[Gas Station Fills]
  alter COLUMN [FILL ID] NVARCHAR(50) NOT NULL;

-- 2 Primary and foreign key

ALTER TABLE [dbo].[Gas Station Fills]
ADD PRIMARY KEY ([Fill ID]);

ALTER TABLE [dbo].[Vehicles]
ADD PRIMARY KEY ([VEHICLE ID]);

ALTER TABLE [dbo].[Gas Station Fills]
ADD FOREIGN KEY ([VEHICLE ID])
REFERENCES [dbo].[Vehicles]([Vehicle ID]);

-- MASTER TABLE

SELECT 
A.[Fill ID],
A.[Vehicle ID],
A.[Fuel Type],
A.[Cost of Fill (£)],
A.[Customer Membership],
B.[Vehicle Name],
B.[Vehicle Type],
B.[Vehicle Cost (£)]
INTO [Gas Station - Master]
FROM [dbo].[Gas Station Fills] AS A
LEFT JOIN [dbo].[Vehicles] AS B
ON A.[Vehicle ID]=B.[Vehicle ID];

-- ANALITICS PART
-- 1 The breakdown of the gas fields for the different vehicles.
 
select [Vehicle ID],
 [Vehicle Name],
sum(cast([Cost of Fill (£)] as int)) fill_costs_per_vehicle,
count(*) as [Total Fill Count]
 from  [Gas Station - Master]
 group by [Vehicle ID],[Vehicle Name]
 order by [Vehicle ID];


 --2. So the second analysis is the number of gas bills for members and nonmembers.

 select 
 [Customer Membership],
 count(*) as [Memberships Bills],
 sum(cast([Cost of Fill (£)] as int)) fill_costs_per_vehicle
 from [Gas Station - Master]
 group by [Customer Membership];

 /* 3. The gas fill breakdown based on the fuel type.
The total fill cost and the count.
The average fill cost based on the fuel type.*/

select [Fuel Type],
sum([Cost of Fill (£)]) as [Total Cost],
round(avg([Cost of Fill (£)]), 2) as [Average Cost],
count(*) as [Number of bills]
 from  [Gas Station - Master]
 group by [Fuel Type];

 -- 4. the ratio between the fill and the vehicle costs

 with cte
 as
  (select [Vehicle ID],
  [Vehicle Name],
  [Vehicle Type],
  sum([Cost of Fill (£)]) as Total_fill_cost,
  sum([Vehicle Cost (£)]) as [Total vehicle cost]
 from  [Gas Station - Master]
 group by [Vehicle ID],
  [Vehicle Name],
  [Vehicle Type])
 select[Vehicle ID],
  [Vehicle Name],
  [Vehicle Type],
 Total_fill_cost,
 [Total vehicle cost],
 round([Total vehicle cost]/ Total_fill_cost, 2) as Ratio
    from  cte

 
 select 
 from  [Gas Station - Master]
