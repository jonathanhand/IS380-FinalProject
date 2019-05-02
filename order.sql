--start 'C:\Users\handj\Desktop\Fall 2018 Work\IS 380\iSell Project\order.sql'

set echo off
set verify off
set feedback off
set heading off

spool 'C:\Users\handj\Desktop\Fall 2018 Work\IS 380\iSell Project\order.txt'

prompt ****** Welcome to iSell! ******
prompt ******** Place an Order ********



select 'Today''s Date: '|| TO_CHAR (sysdate) from dual;

accept vcNum prompt 'Enter the Customer Number: ';
select 'Customer Name: ', rtrim(cLastName), ', ', cFirstName, 
'Shipping Address: ', Address,
'City, State, Zip: ', City, State, Zip,
'Phone: ', Phone
	from customer 
	where cNum = '&vcNum';

accept vpItemdesc prompt 'Enter Product Search Keyword: ';
select * from product where lower(product.pItemName) like '%&vpItemdesc%';

accept vpItemNum prompt 'Enter the Item Number: ';
select 'Item Number: ', pitemNum, 'Item Description: ', pitemName, 'Unit Price: ', pUnitPrice 
from product where pItemNum = '&vpItemNum';

accept vqtyOrdered prompt 'Enter the quantity ordered: ';

insert into Orders values((select maxnum from counter), 
	'&vcNum', '&vpItemNum', '&vqtyOrdered', 
	(select pUnitPrice from product where product.pitemNum = '&vpItemNum'), 
	SYSDATE, 'Open', null, null, null, null, 
	('&vqtyOrdered' * (select pUnitPrice from product where product.pitemNum = '&vpItemNum')), null);
commit;
select 'Amount Ordered: ', orderAmount from orders where orderNum = (select maxnum from counter);
update product set availUnits = availUnits - '&vqtyOrdered' where pItemNum = '&vpItemNum';

select 'Order Status: ', orderStatus from orders where orderNum= (select maxnum from counter);

prompt ************** Order number is ---------->
(select maxnum from counter);

update counter set maxnum=maxnum+1;
commit;


spool off;