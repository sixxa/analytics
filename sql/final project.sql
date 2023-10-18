
--Bi shi shetanili selecti

 SELECT CU.CustomerID, 
 CU.Title, 
 CU.FirstName, 
 CU.LastName, 
 AD.CountryRegion, 
 AD.StateProvince, 
 AD.City, 
 SAORHE.OrderDate, 
 CU.CompanyName, 
 PR.Color, 
 PRCA.Name AS CategoryName,
 SAORDE.OrderQty,
 SUM(SAORHE.TotalDue) AS TotalPayed,
   CASE
    WHEN SUM(SAORHE.TotalDue)<9999 THEN 'NormalCustomer'
	 WHEN SUM(SAORHE.TotalDue)<99999 THEN 'LoyalCustomer'
	  WHEN SUM(SAORHE.TotalDue)<999999 THEN 'Loyal+Customer' 
	   WHEN SUM(SAORHE.TotalDue)<9999999 THEN 'EpicCustomer'
	    WHEN SUM(SAORHE.TotalDue)<99999999 THEN 'Epic+Customer'
		 ELSE 'Epic++Customer'
	  END as CustomerType 
  FROM [AdventureWorksLT2019].[SalesLT].[SalesOrderHeader] AS SAORHE
   LEFT JOIN [AdventureWorksLT2019].[SalesLT].[Address] AS AD
  ON SAORHE.ShipToAddressID=AD.AddressID
   LEFT JOIN [AdventureWorksLT2019].[SalesLT].[Customer] AS CU
  ON CU.CustomerID=SAORHE.CustomerID
   LEFT JOIN  [AdventureWorksLT2019].[SalesLT].[SalesOrderDetail] as SAORDE
  ON SAORHE.SalesOrderID=SAORDE.SalesOrderID
  LEFT JOIN  [AdventureWorksLT2019].[SalesLT].[Product] as PR
  ON SAORDE.ProductID=PR.ProductID
  LEFT JOIN  [AdventureWorksLT2019].[SalesLT].[ProductCategory] as PRCA
  ON PR.ProductCategoryID=PRCA.ProductCategoryID
   WHERE 1=1
   AND PR.Color iS NOT NULL
   GROUP BY CU.CustomerID, 
   CU.FirstName, 
   SAORHE.OrderDate, 
   AD.City, 
   AD.CountryRegion, 
   AD.StateProvince,
   PRCA.Name, 
   CU.CompanyName, 
   PR.Color, 
   SAORDE.OrderQty, 
   CU.Title, 
   CU.LastName
   ORDER BY TotalPayed DESC
   


 -- AQ IQMNEBA DROEBITI CXRILI
   
   

   DROP TABLE #MyTable

   SELECT SAORHE.OrderDate,
   SAORHE.ShipDate, 
   CU.CustomerID, 
   SAORHE.TotalDue, 
   AD.City, AD.StateProvince,
   AD.CountryRegion,
   CU.Title, 
   CU.FirstName, 
   CU.CompanyName,
   CU.Phone,
   PR.Color, 
   PRCA.Name AS CategoryName, 
   SAORDE.OrderQty
  INTO  #MyTable
 FROM [AdventureWorksLT2019].[SalesLT].[SalesOrderHeader] AS SAORHE
   LEFT JOIN [AdventureWorksLT2019].[SalesLT].[Address] AS AD
  ON SAORHE.ShipToAddressID=AD.AddressID
   LEFT JOIN [AdventureWorksLT2019].[SalesLT].[Customer] AS CU
  ON CU.CustomerID=SAORHE.CustomerID
   LEFT JOIN [AdventureWorksLT2019].[SalesLT].[CustomerAddress] AS CUAD
  ON CU.CustomerID=CUAD.CustomerID
   LEFT JOIN  [AdventureWorksLT2019].[SalesLT].[SalesOrderDetail] as SAORDE
  ON SAORHE.SalesOrderID=SAORDE.SalesOrderID
  LEFT JOIN  [AdventureWorksLT2019].[SalesLT].[Product] as PR
  ON SAORDE.ProductID=PR.ProductID
  LEFT JOIN  [AdventureWorksLT2019].[SalesLT].[ProductCategory] as PRCA
  ON PR.ProductCategoryID=PRCA.ProductCategoryID
   WHERE 1=1


   --AQ KI DROEBITI CXRILIS CHVENTVIS MORGEBUL PIROBEBZE DAMUSHAVEBA


  SELECT  DATEDIFF(DAY, OrderDate, ShipDate) AS DateDifference, *,
   CASE
    WHEN SUM(TotalDue)<9999 THEN 'B Tier'
	 WHEN SUM(TotalDue)<99999 THEN 'A Tier'
	  WHEN SUM(TotalDue)<999999 THEN 'S Tier'
		 ELSE 'S+ Tier'
	 END as CustomerType
   FROM #MyTable
    WHERE 1=1
    AND Color IS NOT NULL
	AND OrderQty BETWEEN 1 AND 20
	AND CompanyName IN ('Action Bicycle Specialists','Extreme Riding Supplies','Riding Cycles','Closest Bicycle Store','Futuristic Bikes','Instruments and Parts Company','Many Bikes Store','Metropolitan Bicycle Supply')
	AND CustomerID like '29%'
	AND LOWER(Title)='mr.'
	AND Color in (SELECT Color
                         FROM #MyTable
                        WHERE LOWER(Color) IN ('blue','yellow','multi','black')
					)
					GROUP BY OrderDate, 
					ShipDate,
					CustomerID,
					TotalDue, City,
					StateProvince, 
					CountryRegion,
					Title, FirstName,
					CompanyName, Phone, 
					Color,
					CategoryName,
					OrderQty
	ORDER BY TotalDue DESC
	
	
  --Esec jamuri TotalSales

	 SELECT sum(TotalDue) as TotalSales
   FROM #MyTable
	


   

   









