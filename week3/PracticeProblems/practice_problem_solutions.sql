-- 1
-- List the customer number, the name, the phone number, and the city of customers.
select custno   as customer_number,
       custname as customer_name,
       phone    as customer_phone,
       city     as customer_city
from customer;


-- 2
-- List the customer number, the name, the phone number,
-- and the city of customers who reside in Colorado (State is CO).
select custno   as customer_number,
       custname as customer_name,
       phone    as customer_phone,
       city     as customer_city
from customer
where state in ('CO');

-- 3
-- List all columns of the EventRequest table for events costing more than $4000.
-- Order the result by the event date (DateHeld).
select *
from eventrequest
where estcost > 4000
order by dateheld desc;


-- 4
-- List the event number, the event date (DateHeld), and
-- the estimated audience number with approved status and
-- audience greater than 9000 or with pending status and audience greater than 7000.
select eventno
from eventrequest
where (status in ('Approved') and estaudience > 9000)
   or (status in ('Pending') and estaudience > 7000);


-- 5
-- List the event number, event date (DateHeld), customer number
-- and customer name of events placed in January 2018 by customers from Boulder.
select *
from customer as c
         join eventrequest e on c.custno = e.custno
where city in ('Boulder')
  and date_format(dateheld, '%Y-%m') >= '2018-01'

-- 6
-- List the average number of resources used (NumberFld) by plan number.
-- Include only location number L100.

select planno, avg(numberfld) as avg_numberfld
from eventplanline
where locno = 'L100'
group by planno;

-- 7
-- List the average number of resources used (NumberFld) by plan number.
-- Only include location number L100. Eliminate plans with less than
-- two event lines containing location number L100.

select planno, avg(numberfld) as avg_numberfld
from eventplanline
where locno = 'L100'
group by planno
having count(planno) < 2
;
