USE [Energy Plant]
GO

CREATE PROCEDURE [Energy Plant - Key definition]
as 

ALTER TABLE [dbo].[Customers]
ALTER COLUMN [Customer ID] INT NOT NULL;

ALTER TABLE [dbo].[Energy Plants]
ALTER COLUMN [Plant ID] NVARCHAR(55) NOT NULL;


ALTER TABLE [dbo].[Energy Plants]
ALTER COLUMN [Fuel ID] NVARCHAR(55) NOT NULL;


ALTER TABLE [dbo].[Energy Sales Transactions]
ALTER COLUMN [Customer ID] INT NOT NULL;

ALTER TABLE [dbo].[Energy Sales Transactions]
ALTER COLUMN [Plant ID] NVARCHAR(55)  NOT NULL;

ALTER TABLE [dbo].[Energy Sales Transactions]
ALTER COLUMN [Fuel ID] NVARCHAR(55)  NOT NULL;

ALTER TABLE [dbo].[Fuel]
ALTER COLUMN [Fuel ID] NVARCHAR(55)  NOT NULL;



-- PRIMARY AND FOREIGN KEYS SETTING

-- FIRST WE NEED TO SET PRIMARY KEY IN A ENERSY SALES TRANSACTION
SELECT ROW_NUMber() OVER (ORDER BY ([Customer ID])) AS [PK - Sales Transactions],
*
INTO[dbo].[Energy Sales Transactions PK]
FROM [dbo].[Energy Sales Transactions];

ALTER TABLE [dbo].[Energy Sales Transactions PK]
ALTER COLUMN [PK - Sales Transactions] INT  NOT NULL;

ALTER TABLE [dbo].[Customers]
ADD PRIMARY KEY ([Customer ID]);

ALTER TABLE [dbo].[Energy Plants]
ADD PRIMARY KEY ([Plant ID]);

ALTER TABLE [dbo].[Fuel]
ADD PRIMARY KEY ([Fuel ID]);

ALTER TABLE [dbo].[Energy Sales Transactions PK]
ADD PRIMARY KEY ([PK - Sales Transactions]);

ALTER TABLE [dbo].[Energy Plants]
ADD FOREIGN KEY ([Fuel ID])
REFERENCES [dbo].[Fuel]([Fuel ID]);

ALTER TABLE [dbo].[Energy Sales Transactions PK]
ADD FOREIGN KEY ([Plant ID]) 
REFERENCES [dbo].[Energy Plants]([Plant ID]) ;

ALTER TABLE [dbo].[Energy Sales Transactions PK]
ADD FOREIGN KEY([Fuel ID])
REFERENCES[dbo].[Fuel]([Fuel ID]);

ALTER TABLE [dbo].[Energy Sales Transactions PK]
ADD FOREIGN KEY ([Customer ID]) 
REFERENCES [dbo].[Customers]([Customer ID]);





