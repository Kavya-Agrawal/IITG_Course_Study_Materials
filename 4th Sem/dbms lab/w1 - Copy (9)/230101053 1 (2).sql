CREATE TABLE IF NOT EXISTS moves(
   first_player_move char(6),
   second_player_move char(6)
);
CREATE TABLE IF NOT EXISTS correct_moves(
   first_player_move char(6),
   second_player_move char(6)
);

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 9/gukesh-makan (1).csv" 
INTO TABLE moves
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n';

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 5/gukesh-makan.csv" 
INTO TABLE correct_moves
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n';

CREATE TABLE IF NOT EXISTS board(
   a char(1),
   b char(1),
   c char(1),
   d char(1),
   e char(1),
   f char(1),
   g char(1),
   h char(1)
);

CREATE table wknight(
   id int primary key,
   roww int,
   col int
);
CREATE table bknight(
   id int primary key,
   roww int,
   col int
);
CREATE table wrook(
   id int primary key,
   roww int,
   col int
);
CREATE table brook(
   id int primary key,
   roww int,
   col int
);
CREATE table wbishop(
   id int primary key,
   roww int,
   col int
);
CREATE table bbishop(
   id int primary key,
   roww int,
   col int
);
CREATE table wking(
   id int primary key,
   roww int,
   col int
);
CREATE table bking(
   id int primary key,
   roww int,
   col int
);
CREATE table wqueen(
   id int primary key,
   roww int,
   col int
);
CREATE table bqueen(
   id int primary key,
   roww int,
   col int
);
CREATE table wpawn(
   id int primary key,
   roww int,
   col int
);
CREATE table bpawn(
   id int primary key,
   roww int,
   col int
);

INSERT into wknight values (1 , 1 , 2);
INSERT into wknight values (2 , 1 , 7);
INSERT into wrook values (1 , 1 , 1);
INSERT into wrook values (2 , 1 , 8);
INSERT into wbishop values (1 , 1 , 3);
INSERT into wbishop values (2 , 1 , 6);
INSERT into wpawn values (1 , 2 , 1);
INSERT into wpawn values (2 , 2 , 2);
INSERT into wpawn values (3 , 2 , 3);
INSERT into wpawn values (4 , 2 , 4);
INSERT into wpawn values (5 , 2 , 5);
INSERT into wpawn values (6 , 2 , 6);
INSERT into wpawn values (7 , 2 , 7);
INSERT into wpawn values (8 , 2 , 8);
INSERT into wking values (1 , 1 , 5);
INSERT into wqueen values (2 , 1 , 4);

INSERT into bknight values (1 , 8 , 2);
INSERT into bknight values (2 , 8 , 7);
INSERT into brook values (1 , 8 , 1);
INSERT into brook values (2 , 8 , 8);
INSERT into bbishop values (1 , 8 , 3);
INSERT into bbishop values (2 , 8 , 6);
INSERT into bpawn values (1 , 7 , 1);
INSERT into bpawn values (2 , 7 , 2);
INSERT into bpawn values (3 , 7 , 3);
INSERT into bpawn values (4 , 7 , 4);
INSERT into bpawn values (5 , 7 , 5);
INSERT into bpawn values (6 , 7 , 6);
INSERT into bpawn values (7 , 7 , 7);
INSERT into bpawn values (8 , 7 , 8);
INSERT into bking values (1 , 8 , 5);
INSERT into bqueen values (2 , 8 , 4);


-- delimiter //
-- CREATE PROCEDURE valid( IN curmove char(6) , out valid int )
-- begin

   

-- end//
-- delimiter ;

-- delimiter //
-- CREATE PROCEDURE simulate( IN curmove char(6) , IN wb char(1) )
-- begin

--    if wb = 'w' then

--    end if

-- end//
-- delimiter ;


drop procedure incorrect_knight;
delimiter //
CREATE PROCEDURE incorrect_knight()
begin

   declare no_records int default 0;
   declare curmovew char(6);
   declare curmoveb char(6);
   declare curmovew_correct char(6);
   declare curmoveb_correct char(6);
   declare i int ;
   declare cc char(6);

   declare cursor_knight_w CURSOR FOR \
   select first_player_move
   from moves;
   -- where first_player_move like 'N%' ;
   
   declare cursor_knight_b CURSOR FOR \
   select second_player_move
   from moves;
   -- where second_player_move like 'N%' ;

   declare cursor_knight_w_correct CURSOR FOR \
   select first_player_move
   from correct_moves ;
   
   declare cursor_knight_b_correct CURSOR FOR \
   select second_player_move
   from correct_moves ;

   set i = 0;

   open cursor_knight_w;
   open cursor_knight_b;
   open cursor_knight_w_correct;
   open cursor_knight_b_correct;

   SELECT 'Selecting all the moves of knights;';

      myloop : LOOP

         fetch cursor_knight_w into curmovew;
         fetch cursor_knight_b into curmoveb;
         fetch cursor_knight_w_correct into curmovew_correct;
         fetch cursor_knight_b_correct into curmoveb_correct;

         -- SELECT i , curmovew , curmoveb , curmovew_correct, curmoveb_correct;

         -- SELECT FIRST(curmovew , 1) into cc;

         if curmovew like 'N%' then
            if STRCMP(curmovew , curmovew_correct) = 0 then
               select i , curmovew, curmovew_correct , 'white' ,'correct';
            else
               select i , curmovew, curmovew_correct , 'white' ,'incorrect';
            end if;
         end if

         if curmoveb like 'N%' then
            if STRCMP(curmoveb , curmoveb_correct)=0 then
               select i , curmoveb, curmoveb_correct , 'black' ,'correct';
            else
               select i , curmoveb, curmoveb_correct , 'black' ,'incorrect';
            end if;
         end if

         set i = i+1;
         if i = 45 then
            LEAVE myloop;
         end if;

      end LOOP myloop;

   close cursor_knight_w;
   close cursor_knight_b;
   close cursor_knight_w_correct;
   close cursor_knight_b_correct;

end//
delimiter ;


drop procedure incorrect_rook;
delimiter //
CREATE PROCEDURE incorrect_rook()
begin

   declare no_records int default 0;
   declare curmovew char(6);
   declare curmoveb char(6);
   declare curmovew_correct char(6);
   declare curmoveb_correct char(6);
   declare i int ;

   declare cursor_rook_w CURSOR FOR \
   select first_player_move
   from moves;
   -- where first_player_move like 'N%' ;
   
   declare cursor_rook_b CURSOR FOR \
   select second_player_move
   from moves;
   -- where second_player_move like 'N%' ;

   declare cursor_rook_w_correct CURSOR FOR \
   select first_player_move
   from correct_moves ;
   
   declare cursor_rook_b_correct CURSOR FOR \
   select second_player_move
   from correct_moves ;

      -- first_player_move like 'N%' or second_player_move like 'N%'

   -- declare continue handler for not found set no_records = 1;

   set i = 0;

   open cursor_rook_w;
   open cursor_rook_b;
   open cursor_rook_w_correct;
   open cursor_rook_b_correct;

      SELECT 'Selecting all the moves of rooks;';

      myloop : LOOP

         fetch cursor_rook_w into curmovew;
         fetch cursor_rook_b into curmoveb;
         fetch cursor_rook_w_correct into curmovew_correct;
         fetch cursor_rook_b_correct into curmoveb_correct;

         -- SELECT i , curmovew , curmoveb , curmovew_correct, curmoveb_correct;

         if curmovew = 'R%' then
            if STRCMP(curmovew , curmovew_correct) = 0 then
               select i , curmovew, curmovew_correct , 'white' ,'correct';
            else
               select i , curmovew, curmovew_correct , 'white' ,'incorrect';
            end if;
         end if

         if curmoveb = 'R%' then
            if STRCMP(curmoveb , curmoveb_correct)=0 then
               select i , curmoveb, curmoveb_correct , 'black' ,'correct';
            else
               select i , curmoveb, curmoveb_correct , 'black' ,'incorrect';
            end if;
         end if

         set i = i+1;
         if i = 45 then
            LEAVE myloop;
         end if;

      end LOOP myloop;

   close cursor_rook_w;
   close cursor_rook_b;
   close cursor_rook_w_correct;
   close cursor_rook_b_correct;

end//
delimiter ;


drop procedure incorrect_bishop;
delimiter //
CREATE PROCEDURE incorrect_bishop()
begin

   declare no_records int default 0;
   declare curmovew char(6);
   declare curmoveb char(6);
   declare curmovew_correct char(6);
   declare curmoveb_correct char(6);
   declare i int ;

   declare cursor_bishop_w CURSOR FOR \
   select first_player_move
   from moves;
   -- where first_player_move like 'N%' ;
   
   declare cursor_bishop_b CURSOR FOR \
   select second_player_move
   from moves;
   -- where second_player_move like 'N%' ;

   declare cursor_bishop_w_correct CURSOR FOR \
   select first_player_move
   from correct_moves ;
   
   declare cursor_bishop_b_correct CURSOR FOR \
   select second_player_move
   from correct_moves ;

      -- first_player_move like 'N%' or second_player_move like 'N%'

   -- declare continue handler for not found set no_records = 1;

   set i = 0;

   open cursor_bishop_w;
   open cursor_bishop_b;
   open cursor_bishop_w_correct;
   open cursor_bishop_b_correct;

      SELECT 'Selecting all the moves of bishops;';

      myloop : LOOP

         fetch cursor_bishop_w into curmovew;
         fetch cursor_bishop_b into curmoveb;
         fetch cursor_bishop_w_correct into curmovew_correct;
         fetch cursor_bishop_b_correct into curmoveb_correct;

         -- SELECT i , curmovew , curmoveb , curmovew_correct, curmoveb_correct;

         if curmovew = 'B%' then
            if STRCMP(curmovew , curmovew_correct) = 0 then
               select i , curmovew, curmovew_correct , 'white' ,'correct';
            else
               select i , curmovew, curmovew_correct , 'white' ,'incorrect';
            end if;
         end if

         if curmoveb = 'B%' then
            if STRCMP(curmoveb , curmoveb_correct)=0 then
               select i , curmoveb, curmoveb_correct , 'black' ,'correct';
            else
               select i , curmoveb, curmoveb_correct , 'black' ,'incorrect';
            end if;
         end if

         set i = i+1;
         if i = 45 then
            LEAVE myloop;
         end if;

      end LOOP myloop;

   close cursor_bishop_w;
   close cursor_bishop_b;
   close cursor_bishop_w_correct;
   close cursor_bishop_b_correct;

end//
delimiter ;

call incorrect_knight();
call incorrect_rook();
call incorrect_bishop();
