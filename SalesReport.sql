-- start 'C:\Users\handj\Desktop\Fall 2018 Work\IS 380\iSell Project\SalesReport.sql'

prompt ***** SALES REPORT ******

select orders.pItemNum, (select pItemName from product where 
	orders.pItemNum = product.pItemNum), to_char(orderDate, 'MM-YYYY'), count(orders.orderNum), sum(orderUnits), sum(orderAmount) 
from orders, product
where orders.pItemNum = product.pItemNum and orders.orderStatus != 'Cancelled' and
orderDate > sysdate - 30
group by orders.pItemNum, to_char(orderDate, 'MM-YYYY');
