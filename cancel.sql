
prompt ***** Welcome to iSell!
prompt ****** CANCEL ORDER *******

select 'Todays Date: ', TO_CHAR (sysdate) from dual;
accept vOrderNum prompt 'Please enter the Order Number: '

select 'Order Number: ' || orderNum || chr(10) ||
'Date Ordered: ' || orderDate || chr(10)  ||
'Order Status: ' || orderStatus || chr(10) ||
'Customer Number: ' || orders.cNum || chr(10) ||
cLastName || ', ' || cFirstName|| chr(10) || 
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

prompt *********************************************************

select 'Cancel Reason Codes: ' || chr(10) ||
reasonCode || ' ' || reasonDesc
from rCodes;

accept vreason prompt 'Please enter a reason code: '
update orders set reasonCode = '&vreason', orderStatus = 'Cancelled'
where orderNum = '&vOrderNum';

select * from product;
update product set availUnits = availUnits + (select orders.orderUnits from orders where orderNum = '&vordernum')
	where product.pItemNum = (select pItemNum from orders where orderNum = '&vordernum');

select * from product;

commit;

