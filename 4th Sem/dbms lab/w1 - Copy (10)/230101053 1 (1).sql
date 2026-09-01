   CREATE TABLE IF NOT EXISTS sailors (
      sid int primary key,
      sname char(50),
      rating int , 
      age decimal(3,1)
   );

   CREATE TABLE IF NOT EXISTS boats(
      bid int primary key ,
      bname char (50 ),
      bcolor char(50) 
   );

   CREATE TABLE if NOT EXISTS reserves (
      sid int ,
      bid int ,
      day char(50),
      primary key (sid, bid, day),
      foreign key (sid) references sailors(sid)  on update cascade on delete cascade,
      foreign key (bid) references boats(bid)  on update cascade on delete cascade
   );

   CREATE TABLE IF NOT EXISTS sailors_log (
      sid int ,
      event_ba char(50),
      ops char(50) ,
      date_time datetime default current_timestamp,
      check ( event_ba in ('before' , 'after')),
      check ( ops in ('insert' , 'update' , 'delete'))
   ) ;

   CREATE TABLE IF NOT EXISTS boats_log (
      bid int ,
      event_ba char(50),
      ops char(50) ,
      date_time datetime default current_timestamp,
      check ( event_ba in ('before' , 'after')),
      check ( ops in ('insert' , 'update' , 'delete'))
   ) ;

   CREATE TABLE IF NOT EXISTS reserves_log (
      sid int,
      bid int ,
      day char(10),
      event_ba char(50),
      ops char(50) ,
      date_time datetime default current_timestamp,
      check ( event_ba in ('before' , 'after')),
      check ( ops in ('insert' , 'update' , 'delete'))
   );

   CREATE TABLE IF NOT EXISTS sailors_log_log (
      sid int ,
      event_ba char(50),
      ops char(50) ,
      date_time datetime default current_timestamp,
      check ( event_ba in ('before' , 'after')),
      check ( ops in ('insert' , 'update' , 'delete'))
   ) ;

   CREATE TABLE IF NOT EXISTS sailors_log_log_log (
      sid int ,
      event_ba char(50),
      ops char(50) ,
      date_time datetime default current_timestamp,
      check ( event_ba in ('before' , 'after')),
      check ( ops in ('insert' , 'update' , 'delete'))
   ) ;


-- task 4--------------------------------------------------------

   LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 10/database/sailors01.csv" 
   INTO TABLE sailors
   FIELDS TERMINATED by ','
   LINES TERMINATED BY '\n';

   LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 10/database/boats01.csv" 
   INTO TABLE boats
   FIELDS TERMINATED by ','
   LINES TERMINATED BY '\n';

   LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 10/database/reserves01.csv" 
   INTO TABLE reserves
   FIELDS TERMINATED by ','
   LINES TERMINATED BY '\n';

--- taks 5------------------------------------------------

   --1
   drop TRIGGER sailor_t1;
   delimiter #
   create TRIGGER sailor_t1
   before insert on sailors
   for each row
   begin 
      insert into sailors_log ( sid, event_ba , ops ) values (new.sid, 'before' , 'insert');
   end #
   delimiter ;

   --2
   delimiter #
   create TRIGGER boats_t1
   before insert on boats
   for each row
   begin 
      insert into boats_log ( bid , event_ba , ops ) values (new.bid, 'before' , 'insert');
   end #
   delimiter ;

   --3
   delimiter #
   create TRIGGER reserves_t1
   before insert on reserves
   for each row
   begin 
      insert into reserves_log ( sid, bid,day , event_ba , ops ) values (new.sid, new.bid, new.day, 'before' , 'insert');
   end #
   delimiter ;

   --4
   delimiter #
   create TRIGGER sailor_t2
   after update on sailors
   for each row
   begin 
      insert into sailors_log ( sid, event_ba , ops ) values (new.sid, 'after' , 'update');
   end #
   delimiter ;
   ---new(and not old) told by the ta

   --5
   delimiter #
   create TRIGGER boats_t2
   after update on boats
   for each row
   begin 
      insert into boats_log ( bid, event_ba , ops ) values (new.bid, 'after' , 'update');
   end #
   delimiter ;

   --6
   delimiter #
   create TRIGGER reserves_t2
   after update on reserves
   for each row
   begin 
      insert into reserves_log ( sid, bid,day , event_ba , ops ) values (new.sid, new.bid, new.day, 'after' , 'update');
   end #
   delimiter ;

   --7
   delimiter #
   create TRIGGER sailor_t3
   after delete on sailors
   for each row
   begin 
      insert into sailors_log ( sid, event_ba , ops ) values (old.sid, 'after' , 'delete');
   end #
   delimiter ;

   --8
   delimiter #
   create TRIGGER boats_t3
   after delete on boats
   for each row
   begin 
      insert into boats_log ( bid, event_ba , ops ) values ( old.bid, 'after' , 'delete');
   end #
   delimiter ;


   --9
   delimiter #
   create TRIGGER reserves_t3
   after delete on reserves
   for each row
   begin 
      insert into reserves_log ( bid, event_ba , ops ) values ( old.bid, 'after' , 'delete');
   end #
   delimiter ;


----task 6-------------------------------------------------------------


   --1 2 3

   LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 10/database/insert-sailors02.csv" 
   INTO TABLE sailors
   FIELDS TERMINATED by ','
   LINES TERMINATED BY '\n'
   ignore 1 LINES;

   LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 10/database/insert-boats02.csv" 
   INTO TABLE boats
   FIELDS TERMINATED by ','
   LINES TERMINATED BY '\n'
   ignore 1 LINES;

   DELIMITER #
   CREATE PROCEDURE populate_using_random_insertions()
   BEGIN
      declare i INT DEFAULT 1;
      declare s_id INT;
      declare b_id INT;
   
      declare done INT DEFAULT 0;
   
      declare new_cursor_for_randomm CURSOR FOR
         SELECT sid,bid
         FROM sailors,boats;
   
      declare CONTINUE HANDLER FOR NOT FOUND SET done = 1;
   
      OPEN new_cursor_for_randomm;
   
      loop_01: REPEAT
         FETCH new_cursor_for_randomm INTO s_id,b_id;
   
         IF NOT done THEN
               INSERT INTO reserves(sid,bid,day)
               VALUES(s_id,b_id,DATE_FORMAT(DATE_ADD('2024-01-01',INTERVAL FLOOR(RAND()*175) DAY), '%Y-%m-%d'));
               
               INSERT INTO reserves(sid,bid,day)
               VALUES(s_id,b_id,DATE_FORMAT(DATE_ADD('2024-07-01',INTERVAL FLOOR(RAND()*175) DAY), '%Y-%m-%d'));
   
               SELECT CONCAT(i);
               set i = i + 1;
   
               IF i >= 25000 THEN
                  LEAVE loop_01;
               END IF;
         END IF;
   
      UNTIL done END REPEAT loop_01;
   
      CLOSE new_cursor_for_randomm;
   
   END #
   DELIMITER ;
   DELETE FROM reserves;
   --- ---- ERROR 3819 (HY000): Check constraint 'reserves_log_chk_2' is violated.
   
   CALL populate_using_random_insertions();


   --4 5 6
   SELECT * from sailors_log;
   SELECT * from boats_log;
   SELECT * from reserves_log;

   --7

   CREATE table sailor_update(
      sid int,
      upd_rating int
   );

   LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 10/database/update-sailors02.csv" 
   INTO TABLE sailor_update
   FIELDS TERMINATED by ','
   LINES TERMINATED BY '\n';

   drop procedure sailor_update_pro;
   delimiter #
   CREATE procedure sailor_update_pro()
   begin 

      declare i int default 1;
      declare ssid int ;
      declare new_rating int;
      
      declare cursor_update_sailor CURSOR FOR \
      select *
      from sailor_update;

      open cursor_update_sailor;

         LOOP1: while i<= 100 do

            fetch cursor_update_sailor into ssid, new_rating;
            UPDATE sailors set rating = new_rating where sid =  ssid;
            SET i = i+1;

         end while LOOP1;

      close cursor_update_sailor;

   end #
   delimiter ;

   call sailor_update_pro();


   --8

   CREATE table boat_update(
      sid int,
      upd_color char(50)
   );

   LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 10/database/update-boats02.csv" 
   INTO TABLE boat_update
   FIELDS TERMINATED by ','
   LINES TERMINATED BY '\n'
   ignore 1 LINES;

   drop procedure boat_update_pro;
   delimiter #
   CREATE procedure boat_update_pro()
   begin 

      declare i int default 1;
      declare ssid int ;
      declare new_color char(50);
      
      declare cursor_update_boat CURSOR FOR \
      select *
      from boat_update;

      open cursor_update_boat;

         LOOP1: while i<= 20 do

            fetch cursor_update_boat into ssid, new_color;
            UPDATE boats set bcolor = new_color where bid =  ssid;
            SET i = i+1;

         end while LOOP1;

      close cursor_update_boat;

   end #
   delimiter ;

   call boat_update_pro();

   --9
   drop procedure reserves_update_pro;
   delimiter #
   CREATE procedure reserves_update_pro()
   begin 

      declare i int default 1;
      declare new_sid int ;
      declare new_bid int ;
      declare new_date datetime ;
      
      declare cursor_delete_reserves CURSOR FOR \
      select *
      from reserves;

      open cursor_delete_reserves;

         LOOP1: while i<= 100 do

            fetch cursor_delete_reserves into new_sid, new_bid, new_date;
            update reserves set day = date_add(day , INTERVAL 1 day) where sid = new_sid and bid = new_bid and day = new_date;
            SET i = i+1;

         end while LOOP1;

      close cursor_delete_reserves;

   end #
   delimiter ;

   call reserves_update_pro();

   --10 11 12
   SELECT * from sailors_log;
   SELECT * from boats_log;
   SELECT * from reserves_log;


   --13

   CREATE table sailor_delete(
      sid int,
      upd_rating int
   );

   LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 10/database/delete-sailors02.csv" 
   INTO TABLE sailor_delete
   FIELDS TERMINATED by ','
   LINES TERMINATED BY '\n';

   drop procedure sailor_delete_pro;
   delimiter #
   CREATE procedure sailor_delete_pro()
   begin 

      declare i int default 1;
      declare ssid int ;
      
      declare cursor_delete_sailor CURSOR FOR \
      select *
      from sailor_delete;

      open cursor_delete_sailor;

         LOOP1: while i<= 30 do

            fetch cursor_delete_sailor into ssid;
            delete from sailors where sid =  ssid;
            SET i = i+1;

         end while LOOP1;

      close cursor_delete_sailor;

   end #
   delimiter ;

   call sailor_delete_pro();


   --14

   CREATE table boat_delete(
      sid int,
      upd_color char(50)
   );

   LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 10/database/delete-boats02.csv" 
   INTO TABLE boat_delete
   FIELDS TERMINATED by ','
   LINES TERMINATED BY '\n';

   drop procedure boat_delete_pro;
   delimiter #
   CREATE procedure boat_delete_pro()
   begin 

      declare i int default 1;
      declare ssid int ;
      
      declare cursor_delete_sailor CURSOR FOR \
      select *
      from sailor_delete;

      open cursor_delete_sailor;

         LOOP1: while i<= 10 do

            fetch cursor_delete_sailor into ssid;
            delete from boats where bid =  ssid;
            SET i = i+1;

         end while LOOP1;

      close cursor_delete_sailor;

   end #
   delimiter ;

   call boat_delete_pro();

   --15
   drop procedure reserves_delete_pro;
   delimiter #
   CREATE procedure reserves_delete_pro()
   begin 

      declare i int default 1;
      declare new_sid int ;
      declare new_bid int ;
      declare new_date datetime ;
      
      declare cursor_delete_reserves CURSOR FOR \
      select *
      from reserves;

      open cursor_delete_reserves;

         LOOP1: while i<= 100 do

            fetch cursor_delete_reserves into new_sid, new_bid, new_date;
            delete from reserves where sid = new_sid and bid = new_bid and day = new_date;
            SET i = i+1;

         end while LOOP1;

      close cursor_delete_reserves;

   end #
   delimiter ;

   call reserves_delete_pro();




   --16 17 18
   SELECT * from sailors_log;
   SELECT * from boats_log;
   SELECT * from reserves_log;

--task 07 -------------------------------------------

   delimiter #
   CREATE TRIGGER sailors_t2_task7
   before insert on sailors
   for each row
   precedes sailor_t1
   begin 
      insert into sailors_log (sid, event_ba, ops) values (new.sid, 'before', 'insert');
   end #
   delimiter ;

   ----this gives check contraint error as the table sailors_log only accepts 'insert' , 'update' , 'delete' and will not accwpt t2 insert

   delimiter #
   CREATE TRIGGER sailors_t3_task7
   before insert on sailors
   for each row
   follows sailors_t2_task7
   begin 
      insert into sailors_log (sid, event_ba, ops) values (new.sid, 'before', 'insert');
   end #
   delimiter ;


---task 08 --------------------

   LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 10/database/sailors03.csv" 
   INTO TABLE sailors
   FIELDS TERMINATED by ','
   LINES TERMINATED BY '\n'
   ignore 1 lines;

   select * from sailors_log;

----task 09 ------------

   delimiter #
   CREATE TRIGGER sailors_log_t1_task9
   after INSERT
   ON sailors_log
   FOR EACH ROW
   BEGIN
      INSERT INTO sailors_log_log(sid,event_ba,ops) VALUES (New.sid,'after','insert');
   END #
   delimiter ;

   delimiter #
   CREATE TRIGGER sailors_log_log_t1_task9
   after INSERT
   ON sailors_log_log
   FOR EACH ROW
   BEGIN
      INSERT INTO sailors_log_log_log (sid,event_ba,ops) VALUES (New.sid,'after','insert');
   END #
   delimiter ;

--- task 10 --------

   LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 10/database/sailors04.csv" 
   INTO TABLE sailors
   FIELDS TERMINATED by ','
   LINES TERMINATED BY '\n'
   ignore 1 lines;

   select * from sailors_log;
   select * from sailors_log_log;
   select * from sailors_log_log_log;

----task 11 ------------------

   -- delimiter #
   -- CREATE TRIGGER sailors_log_log_log_t1 
   -- after INSERT
   -- ON sailors_log_log_log
   -- FOR EACH ROW
   -- BEGIN
   -- INSERT INTO sailors(sid,event_ba,ops) VALUES ('kavya','after','insert');
   -- END #
   -- delimiter ;

   delimiter #
   CREATE TRIGGER sailors_log_log_log_t1
   AFTER INSERT ON sailors_log_log_log
   FOR EACH ROW
   BEGIN
      INSERT INTO sailors(sid,sname,rating,age) VALUES (FLOOR(1+RAND()*1000),'Random',FLOOR(1+RAND()*50));
   END #
   delimiter ;

--- task 12 --------

   LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 10/database/sailors05.csv" 
   INTO TABLE sailors
   FIELDS TERMINATED by ','
   LINES TERMINATED BY '\n'
   ignore 1 lines;

   select * from sailor_log;
   select * from sailors_log_log;
   select * from sailors_log_log_log;

---task 13 ------

   drop procedure sailor_insert_duplicates_pro;
   delimiter #
   CREATE procedure sailor_insert_duplicates_pro()
   begin 

      declare i int default 1;
      declare ssid int ;
      declare sname_new char(50);
      declare new_rating int;
      declare new_age decimal(3,1);
      
      declare cursor_insert_duplicates_sailor CURSOR FOR \
      select *
      from sailors;

      open cursor_insert_duplicates_sailor;

         LOOP1: while i<= 10 do

            fetch cursor_insert_duplicates_sailor into ssid,sname_new, new_rating,new_age;
            INSERT into sailors values(ssid,sname_new, new_rating,new_age);
            SET i = i+1;

         end while LOOP1;

      close cursor_insert_duplicates_sailor;

   end #
   delimiter ;

   call sailor_insert_duplicates_pro();

   --2

   drop procedure boats_insert_duplicates_pro;
   delimiter #
   CREATE procedure boats_insert_duplicates_pro()
   begin 

      declare i int default 1;
      declare ssid int ;
      declare sname_new char(50);
      declare new_rating char(50);
      
      declare cursor_insert_duplicates_boats CURSOR FOR \
      select *
      from boats;

      open cursor_insert_duplicates_boats;

         LOOP1: while i<= 10 do

            fetch cursor_insert_duplicates_boats into ssid,sname_new, new_rating;
            INSERT into boats values (ssid,sname_new, new_rating);
            SET i = i+1;

         end while LOOP1;

      close cursor_insert_duplicates_boats;

   end #
   delimiter ;

   call boats_insert_duplicates_pro();

   --3 

   drop procedure reserve_insert_duplicates_pro;
   delimiter #
   CREATE procedure reserve_insert_duplicates_pro()
   begin 

      declare i int default 1;
      declare ssid int ;
      declare new_bid int;
      declare dayy char(50);
      
      declare cursor_insert_duplicates_reserve CURSOR FOR \
      select *
      from reserves;

      open cursor_insert_duplicates_reserve;

         LOOP1: while i<= 10 do

            fetch cursor_insert_duplicates_reserve into ssid,new_bid,dayy;
            INSERT into reserves values(ssid,new_bid,dayy);
            SET i = i+1;

         end while LOOP1;

      close cursor_insert_duplicates_reserve;

   end #
   delimiter ;

   call reserve_insert_duplicates_pro();

   -- 4 5 6
   select * from sailor_log;
   select * from boats_log;
   select * from reserves_log;

