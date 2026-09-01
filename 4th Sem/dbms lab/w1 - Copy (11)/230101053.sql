CREATE TABLE IF NOT EXISTS sailors_name (
   record_number int primary key,
   sname char(20) 
);

create table if not EXISTS boat_name (
   boat_number int primary key,
   bname char(20) 
);

create table if not EXISTS boat_color ( record_number int primary key, bcolor char(20) );

create table if not EXISTS sailors ( sid int primary key, sname char(50) , rating int, age decimal(3,1) );

   CREATE TABLE IF NOT EXISTS boats(bid int primary key ,bname char (50 ),bcolor char(50) );

   CREATE TABLE if NOT EXISTS reserves (sid int ,bid int ,day char(50),primary key (sid, bid, day),foreign key (sid) references sailors(sid)  on update cascade on delete cascade,foreign key (bid) references boats(bid)  on update cascade on delete cascade);
      


   LOAD DATA  LOCAL INFILE '/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 11/sailor_name.csv' INTO TABLE sailors_name FIELDS TERMINATED by ',' LINES TERMINATED BY '\n' ignore 1 LINES;

   LOAD DATA  LOCAL INFILE '/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 11/boat_name.csv' INTO TABLE boat_name FIELDS TERMINATED by ',' LINES TERMINATED BY '\n' ignore 1 LINES;

   LOAD DATA  LOCAL INFILE '/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 11/boat_color.csv' INTO TABLE boat_color FIELDS TERMINATED by ',' LINES TERMINATED BY '\n' ignore 1 LINES;

   


----------------------- 06

   drop procedure populate_baots;
   delimiter #
   CREATE procedure populate_baots()
   begin 

      declare i int default 1;
      declare bname_rand char(20) ;
      declare bcolor_rand char(20) ;
   

      LOOP1 : while i <= 50 do 

         select bname from boat_name order by RAND() limit 1 into bname_rand;
         select bcolor from boat_color order by RAND() limit 1 into bcolor_rand;

         INSERT into boats values (i,bname_rand, bcolor_rand );

         set i = i+1;

      end while LOOP1;

   end #
   delimiter ;

   call populate_baots();



----task 05

   drop procedure populate_sailors;
   delimiter #
   CREATE procedure populate_sailors()
   begin 

      declare i int default 1;
      declare firstname char(20) ;
      declare age_rand decimal(3,1);
      declare rating_rand int;
      
      -- declare cursor_firstname FOR \
      -- select sname from sailors_name order by RAND() limit 1;
      -- declare cursor_age FOR select 18 + floor(rand() * 48);
      -- declare cursor_rating FOR select 1 + floor(rand() * 10);

      -- open cursor_firstname;
      -- open cursor_age;
      -- open cursor_rating;

      LOOP1 : while i <= 500 do 

         select sname from sailors_name order by RAND() limit 1 into firstname;
         select 18 + floor(rand() * 48) into age_rand;
         select 1 + floor(rand() * 10) into rating_rand;

         INSERT into sailors values (i, firstname ,rating_rand, age_rand );

         set i = i+1;

      end while LOOP1;


      -- close cursor_firstname;
      -- close cursor_age;
      -- close cursor_rating;

   end #
   delimiter ;

   call populate_sailors();


-------------task 07

   drop procedure populate_reserves;
   delimiter #
   CREATE procedure populate_reserves()
   begin 

      declare i int default 1;
      declare rand_datee char (50);
      declare sidrand int ;
      declare bidrand int ;
   

      LOOP1 : while i <= 5000 do 

         select sid from sailors order by rand( ) limit 1 into  sidrand;
         select bid from boats order by rand() limit 1 into bidrand;
         set rand_datee = random_date();


         INSERT into reserves values ( sidrand , bidrand , rand_datee);

         set i = i+1;

      end while LOOP1;

   end #
   delimiter ;

   call populate_reserves();

----------------------------- task 08

   drop function random_date;
   delimiter #
   CREATE function random_date( ) returns char(50) deterministic
   begin 

      declare rand_date char(50);
      declare rand_mm char (2);
      declare rand_dd char (4);

      select 1 + floor(rand() * 12) into rand_mm;
      -- select rand_mm;

      case

         when (rand_mm = 01 ) THEN select 1 + floor(rand() * 31) into rand_dd;
         when (rand_mm = 02 ) THEN select 1 + floor(rand() * 29) into rand_dd;
         when (rand_mm = 03 ) THEN select 1 + floor(rand() * 31) into rand_dd;
         when (rand_mm = 04 ) THEN select 1 + floor(rand() * 30) into rand_dd;
         when (rand_mm = 05 ) THEN select 1 + floor(rand() * 31) into rand_dd;
         when (rand_mm = 06 ) THEN select 1 + floor(rand() * 30) into rand_dd;
         when (rand_mm = 07 ) THEN select 1 + floor(rand() * 31) into rand_dd;
         when (rand_mm = 08 ) THEN select 1 + floor(rand() * 31) into rand_dd;
         when (rand_mm = 09 ) THEN select 1 + floor(rand() * 30) into rand_dd;
         when (rand_mm = 10 ) THEN select 1 + floor(rand() * 31) into rand_dd;
         when (rand_mm = 11 ) THEN select 1 + floor(rand() * 30) into rand_dd;
         when (rand_mm = 12 ) THEN select 1 + floor(rand() * 31) into rand_dd;

      end case;

      set rand_date = CONCAT( "2024-" , rand_mm , "-" , rand_dd);
      -- select rand_date;
      return rand_date;

   end #
   delimiter ;


   -- set @rand_datee = random_date();
   -- select @rand_datee;


----------------------------------------task 10

-- select sid
-- from sailors natural join reserves
-- group by sid
-- having count(bid) > 1;


-- create view v1 as select s.sid, s.age , b.bcolor from (sailors as s) natural join (reserves as r) natural join (boats as b) where s.age >= 20 and sid not in (select s.sid from (sailors as s) natural join (reserves as r) natural join (boats as b) where b.bcolor = "red" );


   
