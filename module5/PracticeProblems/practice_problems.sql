-- 1.	List the event number, date held, customer number, customer name, facility number, and facility name
-- of 2018 events placed by Boulder customers.
select e.eventno  as event_number,
       e.dateheld as date_held,
       c.custno   as customer_number,
       f.facno    as facility_no,
       f.facname  as facility_name
from customer c
         join eventrequest e on c.custno = e.custno
         join facility f on f.facno = e.facno
where date_format(e.dateheld, '%Y') = '2018'
  and c.city = 'Boulder';


-- 2.	List the customer number, customer name, event number, date held, facility number,
--      facility name, and estimated audience cost per person (EstCost / EstAudience) for events held on 2018,
--      in which the estimated cost per person is less than $0.2

select e.eventno                 as event_number,
       e.dateheld                as date_held,
       c.custno                  as customer_number,
       f.facno                   as facility_no,
       f.facname                 as facility_name,
       e.estcost / e.estaudience as est_cost_per_person
from customer c
         join eventrequest e on c.custno = e.custno
         join facility f on f.facno = e.facno
where date_format(e.dateheld, '%Y') = '2018'
  and c.city = 'Boulder'
  and e.estcost / e.estaudience < 0.2;


-- 3.	List the customer number, customer name, and total estimated costs for Approved events.
--      The total amount of events is the sum of the estimated cost for each event.
--      Group the results by customer number and customer name.
select c.custno, c.custname, sum(e.estcost)
from customer c
         join eventrequest e on c.custno = e.custno and e.status = 'Approved'
group by c.custno, c.custname;


-- 4.	Insert yourself as a new row in the Customer table.
INSERT INTO athletic.customer (custno, custname, address, Internal, contact, phone, city, state, zip)
VALUES ('C106', 'High School Basketball', '123 AnyStreet', 'N', 'Coach Bob', '4441234', 'Louisville', 'CO', '80027');

-- 5.	Increase the rate by 10 percent of resource names equal to nurse. In MySQL, you need to place the UPDATE statement between two SET statements.
--     SET SQL_SAFE_UPDATES = 0;
--     UPDATE statement
SET SQL_SAFE_UPDATES = 0;
update resourcetbl set rate = rate + 10.00 where resname = 'nurse';

-- 6.	SET SQL_SAFE_UPDATES = 1;
SET SQL_SAFE_UPDATES = 1;
select * from resourcetbl;

-- 7.	Delete the new row added to the Customer table.
select * from customer;
delete from customer where custno = 'C106' limit 1;
