USE AdventureWorksDW2022;
GO

-- Unique View for Sales, Products and regions data
IF OBJECT_ID('dbo.vwSalesProductsRegions', 'V') IS NOT NULL
    DROP VIEW dbo.vwSalesProductsRegions;
GO

CREATE VIEW vwSalesProductsRegions
AS
WITH cte_Sales AS (
    SELECT
        SalesOrderNumber,
        OrderDate,
        ProductKey,
        ResellerKey,
        EmployeeKey,
        SalesTerritoryKey,
        OrderQuantity AS Quantity,
        UnitPrice,
        SalesAmount AS Sales,
        TotalProductCost AS Cost
    FROM dbo.FactResellerSales
),

cte_Products AS (
    SELECT
        ProductKey,
        EnglishProductName AS Product,
        StandardCost,
        Color,
        dps.EnglishProductSubcategoryName AS Subcategory,
        dpc.EnglishProductCategoryName AS Category
    FROM DimProduct dp  
        LEFT JOIN DimProductSubcategory dps  
        ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
        LEFT JOIN DimProductCategory dpc 
        ON dps.ProductCategoryKey = dpc.ProductCategoryKey
    WHERE FinishedGoodsFlag = 1
),

cte_Regions AS (
    SELECT
        SalesTerritoryKey,
        SalesTerritoryRegion AS Region,
        SalesTerritoryCountry AS Country,
        SalesTerritoryGroup AS Groupe
    FROM DimSalesTerritory 
    WHERE SalesTerritoryAlternateKey <> 0 AND SalesTerritoryGroup = 'Pacific'
)

SELECT 

    s.SalesOrderNumber,
    s.OrderDate,
    s.Quantity,
    s.UnitPrice,
    s.Sales,
    s.Cost,

    p.Product,
    p.StandardCost,
    p.Color,
    p.Subcategory,
    p.Category,

    r.Region,
    r.Country

FROM cte_Sales s  
    INNER JOIN cte_Products p ON s.ProductKey = p.ProductKey 
    INNER JOIN cte_Regions r ON s.SalesTerritoryKey = r.SalesTerritoryKey;

GO