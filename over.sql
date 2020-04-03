SELECT 
    SUM([freight]) OVER (PARTITION BY custid) as 'sum',
	SUM(freight) OVER (PARTITION BY custid
		 --ORDER BY orderdate, orderid
		 ORDER BY orderdate, orderid
		 ROWS BETWEEN UNBOUNDED PRECEDING
		 AND CURRENT ROW) AS runningtotal,
	Cast(100 * freight / SUM([freight]) OVER (PARTITION BY custid) as numeric (10,2)) as '%',
	LAST_VALUE(freight) OVER(PARTITION BY custid
		 ORDER BY freight
		 ROWS BETWEEN CURRENT ROW
		 AND UNBOUNDED FOLLOWING) AS last_val, 
	SUM(freight) OVER() AS total, 
	[shipcountry]
  FROM [TSQL2012].[Sales].[Orders]

  order by custid