
Select Top 1 R.ProductName

FROM 

(

Select Top 10 P.Name As 'ProductName' , PC.Name As 'CatName' , S.OrderQty , S.LineTotal 

FROM Sales.SalesOrderDetail S

Inner Join Production.Product P

ON s.ProductID=P.ProductID

Inner Join Production.ProductSubcategory PS

ON P.ProductSubcategoryID=PS.ProductSubcategoryID

Inner Join Production.ProductCategory PC

ON PS.ProductCategoryID=PC.ProductCategoryID

Order By S.LineTotal Desc

) R







-------------------------------

تمرین دوم

-------------------------------





Select Top 1 R.ProductName , R.CatName

FROM 

(

Select Top 10 P.Name As 'ProductName' , PC.Name As 'CatName' , S.OrderQty , S.LineTotal 

FROM Sales.SalesOrderDetail S

Inner Join Production.Product P

ON s.ProductID=P.ProductID

Inner Join Production.ProductSubcategory PS

ON P.ProductSubcategoryID=PS.ProductSubcategoryID

Inner Join Production.ProductCategory PC

ON PS.ProductCategoryID=PC.ProductCategoryID

Order By S.LineTotal Desc

) R







-------------------------------

 سوم

-------------------------------





Select  PC.Name As 'CatName' , Format ((Sum (S.LineTotal) / (Select Sum(LineTotal) FROM Sales.SalesOrderDetail)) * 100.0,'#.##') As 'Total Percent'

FROM Sales.SalesOrderDetail S

Inner Join Production.Product P

ON s.ProductID=P.ProductID

Inner Join Production.ProductSubcategory PS

ON P.ProductSubcategoryID=PS.ProductSubcategoryID

Inner Join Production.ProductCategory PC

ON PS.ProductCategoryID=PC.ProductCategoryID

Group By PC.NAME









-------------------------------

چهارم

-------------------------------



Select  R.ProductNAme , R.CatName

From

(

Select P.NAME as 'ProductNAme', PC.Name As 'CatName'  , S.LineTotal as 's', Row_Number() over (Partition by PC.Name Order By S.LineTotal) as 'R0W'

FROM Sales.SalesOrderDetail S

Inner Join Production.Product P

ON s.ProductID=P.ProductID

Inner Join Production.ProductSubcategory PS

ON P.ProductSubcategoryID=PS.ProductSubcategoryID

Inner Join Production.ProductCategory PC

ON PS.ProductCategoryID=PC.ProductCategoryID



) R

Where R.R0W=1



-------------------------------

پنجم

-------------------------------

Select R.SalesPersonID , R.CATNAME , Format ((R.SUB / R.[Cat TOTAL])*100.0,'#.##') + ' %' as 'Total Percent'

FRom 

(

Select SH.SalesPersonID as 'SalesPersonID' ,PC.Name as 'CATNAME' , Sum(SD.LineTotal) as 'SUB', ROW_NUMBER() over (Partition By PC.NAME Order BY Sum(SD.LineTotal) DESC) as 'R0W'

,Sum(SD.LineTotal) Over (Partition By PC.NAME Order By PC.NAME) As 'Cat TOTAL'

From Sales.SalesOrderHeader SH

Inner Join Sales.SalesOrderDetail SD

ON SH.SalesOrderID=SD.SalesOrderID

Inner Join Production.Product P

ON SD.ProductID=P.ProductID

Inner Join Production.ProductSubcategory PS

ON P.ProductSubcategoryID=PS.ProductSubcategoryID

Inner Join Production.ProductCategory PC

ON PS.ProductCategoryID=PC.ProductCategoryID

Group By SalesPersonID , PC.Name , SD.LineTotal

Having SH.SalesPersonID is not Null



) R

Where R.R0W=1

Order By SalesPersonID



-------------------------------

ششم

-------------------------------

SELECT  SH.CustomerID , PC.Name as 'CATNAME', SD.LineTotal

From Sales.SalesOrderHeader SH

Inner Join Sales.SalesOrderDetail SD

ON SH.SalesOrderID=SD.SalesOrderID

Inner Join Production.Product P

ON SD.ProductID=P.ProductID

Inner Join Production.ProductSubcategory PS

ON P.ProductSubcategoryID=PS.ProductSubcategoryID

Inner Join Production.ProductCategory PC

ON PS.ProductCategoryID=PC.ProductCategoryID

Where SD.LineTotal = (Select Max (LineTotal) From Sales.SalesOrderDetail)

--Order By SD.LineTotal DESC



-------------------------------

هفتم

-------------------------------

Select R.[ProductNAME] , R.CATNAME , Format ((100.0*R.SumOrder/R.TotalQTY),'0.000')+' %' As 'Percent'

FRom

(

Select Top 10  P.Name as  'ProductNAME' ,PC.NAME as 'CATNAME', Sum(SD.OrderQty) as 'SumOrder' 

,(Select sum(OrderQty) From Sales.SalesOrderDetail) as 'TotalQTY'

From Sales.SalesOrderHeader SH

Inner Join Sales.SalesOrderDetail SD

ON SH.SalesOrderID=SD.SalesOrderID

Inner Join Production.Product P

ON SD.ProductID=P.ProductID

Inner Join Production.ProductSubcategory PS

ON P.ProductSubcategoryID=PS.ProductSubcategoryID

Inner Join Production.ProductCategory PC

ON PS.ProductCategoryID=PC.ProductCategoryID

Group By P.Name ,PC.NAME

Order By SumOrder ASC

) R 

--Group By R.[ProductNAME] , R.CATNAME ,R.SumOrder

---Order By R0W