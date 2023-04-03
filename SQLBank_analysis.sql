use [Bank]
go

-- NOT NULL CONSTRAINTS

-- CUSTOMER TABLE

ALTER TABLE [dbo].[Customer]
ALTER COLUMN [Customer ID] NVARCHAR(50) NOT NULL;

-- cURRENCY pAIRS

ALTER TABLE [dbo].[Currency Pairs]
ALTER COLUMN [Currency Pair ID] NVARCHAR(50) NOT NULL;

-- FOREX TRANSACTION

ALTER TABLE [dbo].[Forex transactions]
ALTER COLUMN [Transaction ID] NVARCHAR(250) NOT NULL;

ALTER TABLE [dbo].[Forex transactions]
ALTER COLUMN [Currency Pair ID] NVARCHAR(50) NOT NULL;

ALTER TABLE [dbo].[Forex transactions]
ALTER COLUMN [Customer ID] NVARCHAR(50) NOT NULL;

-- ADDING PK AND FK 

ALTER TABLE [dbo].[Customer]
ADD PRIMARY KEY ([Customer ID]);

ALTER TABLE [dbo].[Forex transactions]
ADD PRIMARY KEY ([Transaction ID]);

ALTER TABLE [dbo].[Currency Pairs]
ADD PRIMARY KEY ([Currency Pair ID]);

ALTER TABLE [dbo].[Forex transactions]
ADD FOREIGN KEY ([Customer ID])
REFERENCES [dbo].[Customer]([Customer ID]);

ALTER TABLE [dbo].[Forex transactions]
ADD FOREIGN KEY ([Currency Pair ID])
REFERENCES [dbo].[Currency Pairs]([Currency Pair ID]);

-- CREATING MASTER TABLE
select 
ft.[Transaction ID],
ft.[Customer ID],
c.[Customer Name],
c.[Customer Since],
ft.[Currency Pair ID],
cp.[Currency Pair],
cp.[Currency Pair Text],
cp.[Currency Pair Ratio],
c.[Account Value (Millions)],
c.[Anti Money Laundering Checks],
ft.[Quantity (Millions)]
into [Bank Forex - Master]
fROM [dbo].[Forex transactions] ft
LEFT JOIN [dbo].[Customer] c
on ft.[Customer ID]=c.[Customer ID]
left join [dbo].[Currency Pairs] cp
on ft.[Currency Pair ID]=cp.[Currency Pair ID];








