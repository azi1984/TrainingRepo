USE AdventureWorks2017
------------
SELECT *
FROM Production.ProductInventory
---------
SELECT *
FROm Production.Product
-----------
SELECT *
FROM Production.Location
---------
SELECT 
	pl.Name,
	Sum(ppi.Quantity) as TotalQuantity,
	Sum(ListPrice) as TotalAsset
FROM Production.ProductInventory ppi
INNER JOIN Production.Location pl
ON ppi.LocationID = pl.LocationID
INnER JOIN Production.Product pp
ON pp.ProductID = ppi.ProductID
Group By
	pl.Name
-------------------
SELECT 
	pl.Name,
	pc.Name,
	Sum(ppi.Quantity) as TotalQuantity,
	( cast(Sum(ppi.Quantity) as float)/ (
		SELECT cast(SUM(spp.Quantity) as float) from Production.ProductInventory spp
		where spp.LocationID = pl.LocationID
	) ) * 100 as [Percentage],
	(
		SELECT SUM(spp.Quantity) from Production.ProductInventory spp
		where spp.LocationID = pl.LocationID
	) as TotalQuanityInLocation 
FROM Production.ProductInventory ppi
INNER JOIN Production.Location pl
ON ppi.LocationID = pl.LocationID
INnER JOIN Production.Product pp
ON pp.ProductID = ppi.ProductID
INNER JOIN Production.ProductSubcategory pc
ON pc.ProductCategoryID = pp.ProductSubcategoryID
Group By
	pl.LocationID,
	pl.Name,
	pc.Name