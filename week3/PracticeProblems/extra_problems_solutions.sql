select *
from Customer;
select*
from Product;
select*
from OrderTbl;
select*
from OrdLine;


-- 1 List the customer number, the name (first and last), and the balance of customers

select CustFirstName as first_name, CustLastName as last_name, CustBal as balance
from Customer;

-- 2.	List the customer number, the name (first and last),
-- and the balance of customers who reside in Colorado (CustState is CO).

select CustFirstName as first_name, CustLastName as last_name, CustBal as balance
from Customer
where CustState in ('CO')
;

-- 3.	List all columns of the Product table for products costing more than $50.
-- Order the result by product manufacturer (ProdMfg) and product name.

select *
from Product
where ProdPrice > 50.0
order by ProdMfg, ProdName;

-- 4.	List the customer number, the name (first and last), the city,
-- and the balance of customers who reside in Denver with a balance greater
-- than $150 or who reside in Seattle with a balance greater than $300.

select CustNo, CustFirstName, CustLastName, CustCity, CustBal
from Customer
where (CustCity = 'Denver' and CustBal > 150.0)
   or (CustCity = 'Seattle' and CustBal > 300.0);

-- 5. List the order number, order date, customer number, and customer name
-- (first and last) of orders placed in January 2017 sent to Colorado recipients.

select OrdNo, OrdDate, C.CustNo, C.CustFirstName, C.CustLastName
from OrderTbl
         join Customer C on C.CustNo = OrderTbl.CustNo
where date_format(OrdDate, '%Y-%m') = '2017-01'
  and CustState = 'CO';


-- 6.	List the average balance of customers by city.
-- Include only customers residing in Washington state (WA).

select avg(CustBal), CustCity
from Customer
where CustState = 'WA'
group by CustCity;

-- 7.	List the average balance and number of customers by city.
-- Only include customers residing in Washington State (WA).
-- Eliminate cities in the result with less than two customers.
select avg(CustBal), CustCity
from Customer
where CustState = 'WA'
group by CustCity
having count(*) > 1
;
