#include <mysql/mysql.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
   MYSQL *con = mysql_init(NULL);

   if (con == NULL)
   {
      fprintf(stderr, "%s\n", mysql_error(con));
      exit(1);
   }

   if (mysql_real_connect(con, "localhost", "root", "jindalsa@9910",
                          NULL, 0, NULL, 0) == NULL)
   {
      fprintf(stderr, "%s\n", mysql_error(con));
      mysql_close(con);
      exit(1);
   }


   if (mysql_options(con, MYSQL_OPT_LOCAL_INFILE , NULL))
   {
      fprintf(stderr, "%s\n", mysql_error(con));
      mysql_close(con);
      exit(1);
   }

   /* mysql_query() function is used to fire any SQL query */
   if (mysql_query(con, "CREATE DATABASE IF NOT EXISTS week11"))
   {
      fprintf(stderr, "%s\n", mysql_error(con));
      mysql_close(con);
      exit(1);
   }

   if (mysql_query(con, "use week11;"))
   {
      fprintf(stderr, "%s\n", mysql_error(con));
      mysql_close(con);
      exit(1);
   }




   if (mysql_query(con, "CREATE TABLE IF NOT EXISTS sailors_name ( record_number int primary key, sname char(20) );"))
   {
      fprintf(stderr, "%s\n", mysql_error(con));
      mysql_close(con);
      exit(1);
   }
   if (mysql_query(con, "create table if not EXISTS boat_name (   boat_number int primary key, bname char(20) ); "))
   {
      fprintf(stderr, "%s\n", mysql_error(con));
      mysql_close(con);
      exit(1);
   }
   if (mysql_query(con, "create table if not EXISTS boat_color ( record_number int primary key, bcolor char(20) ); "))
   {
      fprintf(stderr, "%s\n", mysql_error(con));
      mysql_close(con);
      exit(1);
   }



   // task 03 /////////////////////////////////////////////////////

   ///giving errror

   if (mysql_query(con, "LOAD DATA  LOCAL INFILE '/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 11/sailor_name.csv' INTO TABLE sailors_name FIELDS TERMINATED by ',' LINES TERMINATED BY '\n' ignore 1 LINES;"))
   {
      fprintf(stderr, "%s\n", mysql_error(con));
      mysql_close(con);
      exit(1);
   }

   if (mysql_query(con, "LOAD DATA  LOCAL INFILE '/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 11/boat_name.csv' INTO TABLE boat_name FIELDS TERMINATED by ',' LINES TERMINATED BY '\n' ignore 1 LINES;"))
   {
      fprintf(stderr, "%s\n", mysql_error(con));
      mysql_close(con);
      exit(1);
   }


   if (mysql_query(con, "LOAD DATA  LOCAL INFILE '/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 11/boat_color.csv' INTO TABLE boat_color FIELDS TERMINATED by ',' LINES TERMINATED BY '\n' ignore 1 LINES;"))
   {
      fprintf(stderr, "%s\n", mysql_error(con));
      mysql_close(con);
      exit(1);
   }


   

   // task 04 /////////////////////////////////////////////////////




   if (mysql_query(con, "create table if not EXISTS sailors ( sid int primary key, sname char(50) , rating int, age decimal(3,1) );"))
   {
      fprintf(stderr, "%s\n", mysql_error(con));
      mysql_close(con);
      exit(1);
   }

   if (mysql_query(con, "   CREATE TABLE IF NOT EXISTS boats(bid int primary key ,bname char (50 ),bcolor char(50) );"))
   {
      fprintf(stderr, "%s\n", mysql_error(con));
      mysql_close(con);
      exit(1);
   }
   if (mysql_query(con, "   CREATE TABLE if NOT EXISTS reserves (sid int ,bid int ,day char(50),primary key (sid, bid, day),foreign key (sid) references sailors(sid)  on update cascade on delete cascade,foreign key (bid) references boats(bid)  on update cascade on delete cascade);"))
   {
      fprintf(stderr, "%s\n", mysql_error(con));
      mysql_close(con);
      exit(1);
   }
   
   //duplicate errer
   

   /// task 09 ////////////////////////////
   
   
   if (mysql_query(con, "call populate_sailors(); "))
   {
      fprintf(stderr, "%s\n", mysql_error(con));
      mysql_close(con);
      exit(1);
   }
   if (mysql_query(con, "   call populate_baots();"))
   {
      fprintf(stderr, "%s\n", mysql_error(con));
      mysql_close(con);
      exit(1);
   }
   if (mysql_query(con, "   call populate_reserves();"))
   {
      fprintf(stderr, "%s\n", mysql_error(con));
      mysql_close(con);
      exit(1);
   }
 

   //////////////////////////// task 10
 
// 1)
 
   if (mysql_query(con , "SELECT sailors.sname FROM sailors WHERE sailors.sid IN (select reserves.sid from reserves GROUP BY reserves.sid HAVING COUNT(DISTINCT reserves.bid)>=2);"))
   {
      fprintf(stderr, "%s\n", mysql_error(con ));
      mysql_close(con );
      exit(1);
   }

   MYSQL_RES *result = mysql_store_result(con );

   if (result == NULL)
   {
      fprintf(stderr, "%s\n", mysql_error(con ));
      mysql_close(con );
      exit(1);
   }

   int num_fields = mysql_num_fields(result);

   MYSQL_ROW row;

   while ((row = mysql_fetch_row(result)))
   {
      for(int i = 0; i < num_fields; i++)
      {
         printf("%s ", row[i] ? row[i] : "NULL");
      }

      printf("\n");
   }

   // 2)

   if (mysql_query(con , "CREATE VIEW v1 AS SELECT s.sid, s.age, b.bcolor FROM  reserves r, sailors s, boats b WHERE s.age > 20 AND s.sid=r.sid AND b.bid=r.bid AND s.sid NOT IN (SELECT DISTINCT r2.sid FROM reserves r2, boats b2 WHERE r2.bid=b2.bid AND b2.bcolor='red')"))
   {
      fprintf(stderr, "%s\n", mysql_error(con ));
      mysql_close(con );
      exit(1);
   }

   if (mysql_query(con , "SELECT * from v1;"))
   {
      fprintf(stderr, "%s\n", mysql_error(con ));
      mysql_close(con );
      exit(1);
   }
   MYSQL_RES *result1 = mysql_store_result(con );

   if (result1 == NULL)
   {
      fprintf(stderr, "%s\n", mysql_error(con ));
      mysql_close(con );
      exit(1);
   }

   int num_fields1 = mysql_num_fields(result1);

   MYSQL_ROW row1;

   while ((row1 = mysql_fetch_row(result1)))
   {
      for(int i = 0; i < num_fields1; i++)
      {
         printf("%s ", row1[i] ? row1[i] : "NULL");
      }

      printf("\n");
   }


   //TASK :11 --
   mysql_free_result(result);
   mysql_free_result(result1);


   exit(0);
}
