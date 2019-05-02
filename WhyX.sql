-- start 'C:\Users\handj\Desktop\Fall 2018 Work\IS 380\iSell Project\WhyX.sql'

prompt ****** Cancel Reason Code Analysis ********

accept vNumDays prompt "Please enter past number of days for query: "

select orders.reasonCode, (select reasonDesc from rCodes where orders.reasonCode = rCodes.reasonCode),
count(orders.orderNum), sum(orderUnits), sum(orderAmount) 
from orders, rCodes
where orders.reasonCode = rCodes.reasonCode and orders.orderStatus = 'Cancelled' and
orderDate > sysdate - '&vNumDays'
group by orders.reasonCode;
