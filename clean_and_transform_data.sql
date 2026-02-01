
/*
-- DimEmployee = Salesperson

SELECT 
    EmployeeKey,
    EmployeeNationalIDAlternateKey AS EmployeeID,
    Title,
    EmailAddress AS UPN,
    CONCAT(FirstName, ' ', LastName) AS Salesperson
FROM DimEmployee
WHERE AdventureWorksDW2022.dbo.SalesPersonFlag = 1;
GO

-- DimSalesTerritory = SalespersonRegion
SELECT *
FROM AdventureWorksDW2022.dbo.DimSalesTerritory;
GO
*/


-- DimProduct
SELECT
    ProductKey,
    EnglishProductName AS Product,
    StandardCost,
    Color,
    ProductSubcategoryKey
FROM DimProduct
WHERE FinishedGoodsFlag = 1; --Produits finis

-- DimProductCategory
SELECT
    ProductCategoryKey,
    EnglishProductCategoryName AS Category 
FROM DimProductCategory;

-- DimProductSubcategory
SELECT
    ProductSubcategoryKey,
    EnglishProductSubcategoryName AS Subcategory,
    ProductCategoryKey
FROM DimProductSubcategory;



-- Rassembler DimProduct, DimProductCategory et DimProductSubcategory en une seule table Product
SELECT
    ProductKey,
    EnglishProductName AS Product,
    StandardCost,
    Color,
    dps.EnglishProductSubcategoryName AS Subcategory,
    dpc.EnglishProductCategoryName AS Category
FROM AdventureWorksDW2022.dbo.DimProduct dp  
    LEFT JOIN DimProductSubcategory dps  
    ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
    LEFT JOIN DimProductCategory dpc 
    ON dps.ProductCategoryKey = dpc.ProductCategoryKey
WHERE FinishedGoodsFlag = 1;
GO


/*
-- DimReseller = Reseller
SELECT
    ResellerKey,
    BusinessType,
    ResellerName AS Reseller

FROM AdventureWorksDW2022.dbo.DimReseller;
GO
*/


-- DimSalesTerritory = Region
SELECT
    SalesTerritoryKey,
    SalesTerritoryRegion AS Region,
    SalesTerritoryCountry AS Country,
    SalesTerritoryGroup AS Groupe
FROM DimSalesTerritory 
WHERE SalesTerritoryAlternateKey <> 0;
GO

-- FactResellerSales = Sales 
SELECT
    SalesOrderNumber,
    OrderDate,
    YEAR(OrderDate) AS OrderYear,
    DATEPART(QUARTER, OrderDate) AS OrderQuarter,
    MONTH(OrderDate) AS OrderMonth,
    DATENAME(MONTH, OrderDate) AS OrderMonthName,
    DAY(OrderDate) AS OrderDay,
    DATENAME(WEEKDAY, OrderDate) AS OrderWeekdayName,
    ProductKey,
    ResellerKey,
    EmployeeKey,
    SalesTerritoryKey,
    OrderQuantity AS Quantity,
    UnitPrice,
    SalesAmount AS Sales,
    TotalProductCost AS Cost
FROM AdventureWorksDW2022.dbo.FactResellerSales;
GO