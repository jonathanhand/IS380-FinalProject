set echo off
set heading off
set feedback off
set verify off

spool 

prompt ***** Welcome to iSell! *****
prompt *******SHOW ORDER DETAILS *******

accept vordernum prompt 'Please enter the Order Number: '

select 'OrderNumber: ' || orderNum || chr(10) ||
'Order Status: ' || orderStatus
from orders
where ordernum = '&vordernum';


select 'Customer Number: ' || cNum from orders where ordernum = '&vordernum';

select  cLastName || ', ' || cFirstName|| chr(10) || 
Address|| ',' || chr(10) ||
City || ', '|| State ||' '|| Zip || chr(10) ||
Phone
	from customer, orders
	where orders.cnum = customer.cNum and ordernum = '&vordernum';

select 'Item Number: ' || product.pItemNum || chr(10) ||
'Item Description: ' ||  product.pItemName|| chr(10) ||
'Unit Price: $' || product.pUnitPrice
from product, customer, orders
where product.pitemnum = orders.pitemnum and orders.cnum = customer.cNum and orders.ordernum = '&vordernum';

select 'Date Ordered: ', orderDate || chr(10) ||
'Date Shipped: ', shipDate
from orders
where ordernum = '&vordernum';

select 'Quantity Ordered: '|| orderUnits from orders
where ordernum = '&vordernum';

select 'Amount Ordered: $' || orderAmount from orders
where ordernum = '&vordernum';

select 'Quantity Shipped: ' || shipQty from orders
where ordernum = '&vordernum';

select'Amount Shipped: ' || shipAmount from orders
where ordernum = '&vordernum';


spool off;