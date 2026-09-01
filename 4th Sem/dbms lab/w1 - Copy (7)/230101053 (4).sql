CREATE DATABASE IF NOT EXISTS week7

CREATE TABLE IF NOT EXISTS  myapp_user (
   user_id INT PRIMARY KEY,
   name CHAR(100) NOT NULL,
   email char(100) UNIQUE NOT NULL,
   phone  CHAR (15) UNIQUE NOT NULL,
   city CHAR (50) NOT NULL
);

CREATE TABLE IF NOT EXISTS restaurant (
   restaurant_id INT PRIMARY KEY,
   name char(100) NOT NULL,
   location char (100) NOT NULL, 
   rating decimal(3 , 2) NOT NULL
);

CREATE TABLE  if not exists my_order (
   order_id int primary key,
   user_id int NOT NULL,
   restaurant_id int NOT NULL, 
   order_date date NOT NULL, 
   amount decimal(10 , 2) NOT NULL,
   foreign key (user_id) references myapp_user(user_id) on delete cascade,
   foreign key (restaurant_id) references restaurant(restaurant_id) on delete cascade
);

CREATE TABLE IF NOT EXISTS menu (
   menu_id int primary key , 
   restaurant_id int not null, 
   dish_name char(100) not null,
   price decimal(10 , 2) not null, 
   foreign key (restaurant_id) references restaurant(restaurant_id) on delete cascade
);

CREATE TABLE IF NOT EXISTS review (
   review_id int primary key ,
   user_id int not null,
   restaurant_id int not null,
   rating decimal (3,2 ) not null,
   rating_text text not null,
   foreign key (user_id ) references myapp_user (user_id) on delete cascade,
   foreign KEY (restaurant_id ) references restaurant (restaurant_id ) on delete cascade
);



LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 7/users.csv" INTO TABLE myapp_user 
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n'
IGNORE 1 lines;

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 7/restaurants.csv" INTO TABLE restaurant 
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n'
IGNORE 1 lines;

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 7/menu_items.csv" INTO TABLE menu 
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n'
IGNORE 1 lines;

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 7/orders.csv" INTO TABLE my_order 
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n'
IGNORE 1 lines;

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 7/reviews.csv" INTO TABLE review 
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n'
IGNORE 1 lines;


-- task 4

--1

SELECT name, order_date , amount 
FROM myapp_user as U , my_order as O
WHERE U.user_id = O.user_id;

SELECT restaurant_name , dish_name , price 
from restaurant , menu
WHERE restaurant.restaurant_id = menu.restaurant_id;

SELECT name , rating, rating_text
from myapp_user , review
WHERE review.user_id = myapp_user.user_id;

SELECT U.name , R.name , O.amount
from myapp_user as U, restaurant as R , my_order as O
WHERE O.user_id = U.user_id AND O.restaurant_id  = R.restaurant_id;


--2

--a Logical error cant be retrieved

--b
SELECT U.name , R.name , O.rating , O.rating_text
from myapp_user as U, restaurant as R , review as O
WHERE O.user_id = U.user_id AND O.restaurant_id  = R.restaurant_id;

--c
SELECT U.name , sum(O.amount)
from myapp_user as U , my_order as O
WHERE U.user_id = O.user_id
group by U.user_id , O.order_date;

--d

--3

--a
SELECT UU.name
from myapp_user as UU
where UU.user_id NOT IN (
   SELECT U.user_id 
   FROM myapp_user as U , my_order as O
   WHERE U.user_id = O.user_id
);

SELECT UU.name
from restaurant as UU
where UU.restaurant_id NOT IN (
   SELECT U.restaurant_id 
   FROM restaurant as U , menu as O
   WHERE U.restaurant_id = O.restaurant_id
);

SELECT  UU.restaurant_id, UU.name
from restaurant as UU
where UU.restaurant_id NOT IN (
   SELECT U.restaurant_id 
   FROM restaurant as U , my_order as O
   WHERE U.restaurant_id = O.restaurant_id
);

SELECT UU.name
from myapp_user as UU
where UU.user_id NOT IN (
   SELECT U.user_id 
   FROM myapp_user as U , review as O
   WHERE U.user_id = O.user_id
);


--4

SELECT count(*)
from my_order;

SELECT R.name, min(O.amount)
from restaurant as R , my_order as O 
WHERE R.restaurant_id = O.restaurant_id 
GROUP BY R.restaurant_id
ORDER BY min(O.amount) 
LIMIT 1;

SELECT R.name , max(W.rating)
FROM restaurant as R, review as W
where R.restaurant_id = W.restaurant_id
GROUP BY R.restaurant_id
ORDER BY max(W.rating) desc
LIMIT 1;

SELECT R.name, avg(O.amount)
from restaurant as R , my_order as O 
WHERE R.restaurant_id = O.restaurant_id 
GROUP BY R.restaurant_id;

--5

--a.

SELECT myapp_user.user_id, myapp_user.name, count(my_order.user_id)
FROM myapp_user JOIN my_order ON my_order.user_id=myapp_user.user_id
GROUP BY myapp_user.user_id
HAVING count(my_order.user_id) >= (
    SELECT count(my_order.user_id)
    FROM myapp_user JOIN my_order ON my_order.user_id=myapp_user.user_id
    GROUP BY myapp_user.user_id
    ORDER BY count(my_order.user_id) DESC
    LIMIT 1
    )
 
--b.
 
SELECT restaurant.restaurant_id, restaurant.name, AVG(review.rating)
FROM restaurant JOIN review ON review.restaurant_id=restaurant.restaurant_id
GROUP BY restaurant.restaurant_id
HAVING AVG(review.rating) >= (
    SELECT AVG(review.rating)
    FROM restaurant JOIN review ON review.restaurant_id=restaurant.restaurant_id
    GROUP BY restaurant.restaurant_id
    ORDER BY AVG(review.rating) DESC
    LIMIT 1
    )
 
--c.
 
SELECT myapp_user.user_id, myapp_user.name, SUM(my_order.amount)

FROM myapp_user JOIN my_order ON my_order.user_id=myapp_user.user_id
GROUP BY myapp_user.user_id
HAVING SUM(my_order.amount) > (
    SELECT AVG(my_order.amount) FROM my_order
)
 
 
--d.
SELECT restaurant.restaurant_id ,restaurant.name

FROM restaurant
WHERE NOT EXISTS ( SELECT * FROM review WHERE review.restaurant_id = restaurant.restaurant_id);