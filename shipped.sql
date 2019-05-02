
prompt ***** Welcome to iSell!
prompt ****** UPDATE SHIPPING *******

select 'Today''s Date: ' || TO_CHAR (sysdate) from dual;
accept vOrderNum prompt 'Please enter the Order Number: '

select 'OrderNumber: ' || orderNum || chr(10) ||
'Date Ordered: ' || orderDate
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
'Unit Price: $' || product.pUnitPrice ||chr(10) ||
'Quantity Ordered: ' || orders.orderUnits ||chr(10) ||
'Amount Ordered: $' || orders.orderAmount
from product, customer, orders
where product.pitemnum = orders.pitemnum and orders.cnum = customer.cNum and orders.ordernum = '&vordernum';

prompt ***********************************************************

accept vqtyShipped prompt 'Quantity Shipped: '

update orders set shipDate = sysdate, shipQty = '&vqtyShipped', orderStatus = 'Shipped', 
	shipAmount = orderUnitPrice * '&vqtyShipped'
 where orderNum = '&vOrderNum';

 update product set warehouseUnits = warehouseUnits - '&vqtyShipped' 
 where pItemNum = (select pItemNum from orders where orderNum = '&vordernum');
 commit;


select 'orderStatus ' || orderStatus || chr(10) ||
'Date Shipped: ' || shipDate || chr(10) ||
'Quantity Shipped: ' || shipQty || chr(10) ||
'Amount Shipped: $' || shipAmount
from orders
where ordernum = '&vordernum';

