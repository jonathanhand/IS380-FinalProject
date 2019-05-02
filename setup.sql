set echo on

spool 'C:\Users\handj\Desktop\Fall 2018 Work\IS 380\iSell Project\setup.txt'

-- start 'C:\Users\handj\Desktop\Fall 2018 Work\IS 380\iSell Project\setup.sql'

--Jonathan Hand
--IS 380


drop table orders;
drop table rCodes;
drop table product;
drop table customer;
drop sequence seq_order;
drop table counter;

CREATE SEQUENCE seq_order
MINVALUE 1001
START WITH 1001
INCREMENT BY 1
CACHE 10;

Create table customer(
cNum number(3),
cLastName varChar2(25),
cFirstName varChar2(25),
Address varChar2(40),
City varChar2(20),
State varChar2(20),
Zip varChar2(5),
Phone varChar2(14),
primary key (cNum));

Create table product(
pItemNum varChar2(3),
pItemName varChar2(15),
pUnitPrice number(10,2),
pType varChar2(12),
warehouseUnits number(8),
availUnits number(8),
primary key(pItemNum));


Create table rCodes(
ReasonCode number(1),
ReasonDesc varchar2(30),
primary key(ReasonCode));

Create table orders(
orderNum number(4),
cNum number(3),
pItemNum varchar2(3),
orderUnits number(5),
orderUnitPrice number(12,2),
orderDate DATE,
orderStatus varChar2(10),
shipDate DATE,
shipQty number(5),
rCode number(1),
shipAmount number(12,2),
orderAmount number(12, 2),
reasonCode number(1),
primary key(orderNum),
CONSTRAINT fk_orders_pItemNum FOREIGN KEY (pItemNum) references product(pItemNum),
CONSTRAINT fk_orders_cNum FOREIGN KEY (cNum) references customer(cNum),
CONSTRAINT fk_rCodes_reasonCode FOREIGN KEY (rCode) references rCodes(reasonCode));

Create table counter(
maxnum number(4));



insert into customer values(101, 'Smith', 'John', '456 Easy Street', 'Long Beach', 'CA', 90802, '(323) 555-1232');
insert into customer values(102, 'Jones', 'Elaine', '123 Main Street', 'Los Angeles', 'CA', 91001, '(323) 511-1195');
insert into customer values(103, 'McNulty', 'John', '233 1st Street', 'Long Beach', 'CA', 90802, '(323) 555-1242');
insert into customer values(104, 'Adams', 'Amy', '123 2nd Street', 'Los Angeles', 'CA', 91001, '(323) 531-1199');
insert into customer values(105, 'Smith', 'Bob', '456 3rd Street', 'Long Beach', 'CA', 90802, '(323) 554-1232');
commit;
select * from customer;

insert into product values('p1', 'Pen', 1.59, 'Regular', 1000, 1000);
insert into product values('p2', 'Pencil', 2.00, 'Promo', 500, 500);
insert into product values('p3', 'Ballpen', 2.49, 'Regular', 800, 800);
insert into product values('p4', 'Paper Clip', 1.00, 'Promo', 1500, 1500);
insert into product values('p5', 'Eraser', 3.49, 'Regular', 900, 900);
commit;

insert into orders values(seq_order.nextval, 102, 'p2', 20, 2.00, '28-OCT-2018', 'Cancelled', null, null, null, null, 40, 3);
insert into orders values(seq_order.nextval, 101, 'p1', 100, 1.50, '29-NOV-2018', 'Cancelled', null, null, null, null, 150, 2);
insert into orders values(seq_order.nextval, 101, 'p2', 30, 2.00, '28-NOV-2018', 'Cancelled', null, null, null, null, 60, 4);
insert into orders values(seq_order.nextval, 103, 'p4', 150, 1.50, '27-NOV-2018', 'Cancelled', null, null, null, null, 225, 1);
insert into orders values(seq_order.nextval, 104, 'p4', 20, 1.00, '28-NOV-2018', 'Cancelled', null, null, null, null, 20, 2);
commit;

insert into orders values(seq_order.nextval, 102, 'p2', 20, 2.00, '28-OCT-2018', 'Open', null, null, null, null, 40, null);
insert into orders values(seq_order.nextval, 101, 'p1', 100, 1.50, '27-NOV-2018', 'Open', null, null, null, null, 150, null);
insert into orders values(seq_order.nextval, 104, 'p2', 40, 2.25, '28-NOV-2018', 'Open', null, null, null, null, 88, null);
insert into orders values(seq_order.nextval, 103, 'p4', 150, 1.00, '26-NOV-2018', 'Open', null, null, null, null, 150, null);
insert into orders values(seq_order.nextval, 104, 'p4', 20, 1.00, '28-NOV-2018', 'Open', null, null, null, null, 20, null);
commit;
select * from orders;

insert into rCodes values(1, 'No longer need');
insert into rCodes values(2, 'Found better price');
insert into rCodes values(3, 'Too long to deliver');
insert into rCodes values(4, 'Others');

commit;

insert into counter values(1011);
	--start counter value at 1011
commit;


spool off;