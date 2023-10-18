/****** Script for SelectTopNRows command from SSMS  ******/

-- N1
--SELECT *
 -- FROM [master].[dbo].[Orders]

SELECT CustomerID , SUM(Freight) SumOfFreight , count(*) CountOfEve,
     CASE
   WHEN EmployeeID<5  then 'low level'
   WHEN EmployeeID>=5 and EmployeeID<=7 then 'medium level'
   WHEN EmployeeID>7  then 'high level'
   ELSE  'ERROR'
   END AS EmployLevel
  FROM [master].[dbo].[Orders]
  where 1=1
  and ShipCity in ('Madrid','Cunewalde','Reggio Emilia')
  GROUP BY CustomerID ,
  CASE
   WHEN EmployeeID<5  then 'low level'
   WHEN EmployeeID>=5 and EmployeeID<=7 then 'medium level'
   WHEN EmployeeID>7  then 'high level'
   ELSE  'ERROR'
  END
 

 --N2 
SELECT  SUM(UnitPrice) as UunitPrice, AVG(UnitsInStock) as UunitInStock
  FROM [master].[dbo].[Products]
  where 1=1
  AND ProductName LIKE '%Chef%'
  AND CategoryID NOT IN (1,3,5,7);

--N3
 
SELECT * ,
    CASE
	WHEN UnitPrice<20 THEN UnitPrice*0.2
	WHEN UnitPrice>20 AND UnitPrice<30 THEN UnitPrice*0.3
	WHEN UnitPrice<100 THEN UnitPrice
	else UnitPrice*0.15
	END AS SmtProduct
	into blabla
  FROM [master].[dbo].[Products]
  



  SELECT * ,
  CASE
	WHEN 1=1 THEN UnitPrice-SmtProduct
	END AS ProductMinus
   FROM [master].[dbo].[blabla]



     SELECT * ,
  CASE
	WHEN 1=1 THEN UnitsInStock*UnitPrice
	END AS ProductMult
   FROM [master].[dbo].[blabla]

   

    SELECT * ,
  CASE
	WHEN 1=1 THEN UnitsInStock*UnitPrice-SmtProduct
	END AS ProductMultMinus
   FROM [master].[dbo].[blabla]

   
   --N4

   
SELECT CompanyName, ContactName, ContactTitle, Region,
CASE
 WHEN Region IS NOT NULL THEN 'Shevsebulia'
  END AS TYPE
  FROM [master].[dbo].[Customers]
  where 1=1
  AND Region IS NOT NULL

  UNION

  SELECT CompanyName, ContactName, ContactTitle, Region,
CASE 
 WHEN Region IS NULL THEN 'Carielia'
  END AS TYPE
  FROM [master].[dbo].[Customers]
  where 1=1
  AND Region IS NULL
  AND Phone like '%(%'





  SELECT CompanyName, ContactName, ContactTitle, Region,
CASE
 WHEN Region IS NOT NULL THEN 'Shevsebulia'
  END AS TYPE
  FROM [master].[dbo].[Customers]
  where 1=1
  AND Region IS NOT NULL

  UNION ALL

  SELECT CompanyName, ContactName, ContactTitle, Region,
CASE 
 WHEN Region IS NULL THEN 'Carielia'
  END AS TYPE
  FROM [master].[dbo].[Customers]
  where 1=1
  AND Region IS NULL
  AND Phone like '%(%'


  --N5
SELECT *
  INTO #SUP
  FROM [master].[dbo].[Suppliers]
  WHERE 1=1
  AND CompanyName in ('Exotic Liquids','Specialty Biscuits, Ltd.','Escargots Nouveaux')
 

  SELECT   S.SupplierID, S.CompanyName, PR.ProductName
  FROM [master].[dbo].[Products] as PR 
 INNER JOIN #SUP as S
 ON  PR.ProductID=S.SupplierID
 ORDER BY SupplierID


 --N6
SELECT * 
  into #MyCus2
  FROM [master].[dbo].[Customers]
  WHERE 1=1
  AND City NOT IN ('London')

  


SELECT  MC.ContactName, COUNT(OrderID) AS COO, SUM(Freight) AS SF
  FROM [master].[dbo].[Orders] as O
  LEFT JOIN #MyCus2 as MC
  on MC.CustomerID=O.CustomerID
 WHERE 1=1	
 AND ShipPostalCode NOT IN ('CO7 6JX','S-958 22')
  GROUP BY  MC.ContactName
   HAVING SUM(Freight)>20

   --N7
   SELECT
   CASE
    WHEN ShipCountry = 'France'  Then UnitPrice*0.2 
	WHEN ShipCountry = 'Germany'  Then UnitPrice*0.1
	WHEN ShipCountry = 'Brazil'  Then UnitPrice*0.3
	ELSE 0 
	END AS Odd , ORD.*, ORDDE.Quantity, ORDDE.Discount, ORDDE.UnitPrice
	 INTO #MyTable
  FROM [master].[dbo].[Orders] AS ORD
  LEFT JOIN [master].[dbo].[Order Details] AS ORDDE
  ON ORD.OrderID=ORDDE.OrderID
  WHERE 1=1

  

 

  SELECT  UnitPrice-Odd as PriceWithoutOdd, UnitPrice as UnitPrice1  ,*
  INTO #MyTable1
  FROM #MyTable
  WHERE 1=1


  SELECT 
   CASE
    WHEN UnitPrice<20 THEN (UnitPrice* 0.2)+UnitPrice
	 WHEN UnitPrice BETWEEN 20 AND 30  THEN (UnitPrice* 0.3)+UnitPrice
	  ELSE UnitPrice* 0.15+UnitPrice
	  END as NewPrice ,*
  FROM #MyTable1



  
  SELECT 
   CASE
    WHEN UnitPrice<20 THEN (UnitPrice* 1.2)
	 WHEN UnitPrice BETWEEN 20 AND 30  THEN (UnitPrice* 1.3)
	  ELSE UnitPrice* 1.15
	  END as NewPrice ,*
  FROM #MyTable1



  SELECT  COUNT(ContactName) , City
  FROM [master].[dbo].[Customers]
  WHERE 1=1
  AND City NOT IN ('Berlin','London')
  GROUP BY City 

  SELECT *
  FROM [master].[dbo].[Customers] as CUS
  



  
   SELECT CUS.CustomerID , ORD.OrderID
  FROM [master].[dbo].[Orders]as ORD
   LEFT JOIN [master].[dbo].[Customers] as CUS
   ON ORD.CustomerID=CUS.CustomerID
   WHERE 1=1
   AND DATEDIFF(day, ORD.OrderDate , ORD.ShippedDate)=10
   AND City IN ('London','Berlin')

   --N8
 SELECT * FROM (SELECT *
                 FROM [master].[dbo].[Customers]
                 WHERE CustomerID in ('ALFKI','ANATR','ANTON','AROUT')
                ) As hehe 
		 LEFT JOIN   ( SELECT *
                 FROM [master].[dbo].[Customers]
                 WHERE CustomerID in ('ALFKI','ANATR','ANTON')
	            ) AS hehe1
				ON hehe.CustomerID=hehe1.CustomerID


				SELECT * FROM (SELECT *
                 FROM [master].[dbo].[Customers]
                 WHERE CustomerID in ('ALFKI','ANATR','ANTON','AROUT')
                ) AS hehe 
		INNER JOIN   ( SELECT *
                 FROM [master].[dbo].[Customers]
                 WHERE CustomerID in ('ALFKI','ANATR','ANTON')
	            ) AS hehe1
				ON hehe.CustomerID=hehe1.CustomerID
 




