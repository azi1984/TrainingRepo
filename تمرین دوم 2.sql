use AdventureWorks2017
-----

------------- 
SELECT *
FROM Production.ProductInventory
-----------
SELECT *
FROM Production.Product
----------------------
SELECT sum (pp.ListPrice),ppi.Quantity,pl.name
FROM Production.Product pp
INNER JOIN Production.ProductInventory ppi
ON pp.ProductID = ppi.ProductID
INNER JOIN Production.Location pl
ON ppi.LocationID = pl.LocationID
GROUP BY ppi.Quantity ,pl.name
ORDER BY ListPrice
-------------------
SELECT *
FROM Production.ProductCategory
--------------
--------------------
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
	------------------
SELECT pp.name,pp.SafetyStockLevel,SUM(ppi.Quantity)
FROM Production.Product pp
INNEr join Production.ProductInventory ppi
On ppi.ProductID = pp.ProductID
GROUP BY pp.name,pp.SafetyStockLevel
HAVING  SUM(ppi.Quantity) <= pp.SafetyStockLevel+100 
-----------

-------------
SELECT  p.Name, p.SafetyStockLevel,

SUM(PIN.Quantity) 'Total',

CASE 

WHEN SUM(PIN.Quantity) <= p.SafetyStockLevel THEN N'حداقل موجودی'

ELSE N'موجودی نزدیک به حداقل'

END 



FROM Production.Product p

INNER JOIN Production.ProductInventory PIN

ON p.ProductID = PIN.ProductID

GROUP BY p.Name, p.SafetyStockLevel

HAVING SUM(PIN.Quantity) <= p.SafetyStockLevel + 100 
-----------------------
--------------
Select P.Name , DaysToManufacture

From Production.Product P

where ProductID = 766

Union

Select P.Name , DaysToManufacture

From Production.Product P

where ProductID = 776

Union

Select P.Name , DaysToManufacture

From Production.Product P

where ProductID = 780

Union

Select P.Name , DaysToManufacture

From Production.Product P

where ProductID = 517

Union

Select P.Name , DaysToManufacture

From Production.Product P

where ProductID = 514

Union

Select P.Name , DaysToManufacture

From Production.Product P

where ProductID = 524

Except

Select P.Name , DaysToManufacture

From Production.Product P

where DaysToManufacture >2