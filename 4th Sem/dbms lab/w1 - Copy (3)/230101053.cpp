#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>


/// task 1 
struct time
{
   int hrs;
   int mins;
};

typedef struct record{
   char origin[4];
   char destination[4];
   char flightNumber[7];
   struct time depTime;
   struct time arrival;
} record;


bool timecmp ( struct time b , struct time a){

   //////////////////////////////ASSUMING THE FLIGHT TIMIGS ARE OF THE SAME DAY OTHERWISE IT WOULD NOT WORK////////

   if(b.hrs <= a.hrs){ return 0;}
   else if(b.hrs >= a.hrs + 2) return 1;
   else {
      int mins = b.mins + 60 - a.mins;
      if(mins >= 60) return 1;
      else return 0;
   }
}
struct record data[444];

void printt( struct record dat, FILE * outfile){

      //// CONVERTING THE INT TO STRINGS SO THAT  "5" CHANGES TO "05";

      char a[3];
      a[2] =  '\0';
      if(dat.depTime.hrs < 10 ){
         a[0] = '0';
         a[1] = (char)(dat.depTime.hrs + '0');
      }
      else {
         a[1] = (char)(dat.depTime.hrs%10 + '0');
         a[0] = (char)(dat.depTime.hrs/10 + '0');
      }
      char b[3];
      b[2] =  '\0';
      if(dat.depTime.mins < 10 ){
         b[0] = '0';
         b[1] = (char)(dat.depTime.mins + '0');
      }
      else {
         b[1] = (char)(dat.depTime.mins%10 + '0');
         b[0] = (char)(dat.depTime.mins/10 + '0');
      }
      char c[3];
      c[2] =  '\0';
      if(dat.arrival.hrs < 10 ){
         c[0] = '0';
         c[1] = (char)(dat.arrival.hrs + '0');
      }
      else {
         c[1] = (char)(dat.arrival.hrs%10 + '0');
         c[0] = (char)(dat.arrival.hrs/10 + '0');
      }
      char d[3];
      d[2] =  '\0';
      if(dat.arrival.mins < 10 ){
         d[0] = '0';
         d[1] = (char)(dat.arrival.mins + '0');
      }
      else {
         d[1] = (char)(dat.arrival.mins%10 + '0');
         d[0] = (char)(dat.arrival.mins/10 + '0');
      }

      int cnt = 0;
      for( int i = 0; i < 7; i++ ){ 
         if(dat.flightNumber[i] != '\0'){
            cnt++;
         }
      }

      //////////////////////////CONVERSION DONE

      // printf("%s %s %s %s\n" , a , b , c , d);
      // fprintf(outfile  , "%s %s  %s  %s:%s %s:%s \n", dat.origin , dat.destination,  dat.flightNumber , a , b ,c ,d );
      if(cnt == 6){
         fprintf(outfile , "%s %s  %s  %s:%s %s:%s \n", dat.origin , dat.destination,  dat.flightNumber , a , b ,c ,d );

      }
      else{
         fprintf(outfile , "%s %s  %s   %s:%s %s:%s \n", dat.origin , dat.destination,  dat.flightNumber , a , b ,c ,d );

      }

   // }
}

int main(){

   FILE * file = fopen("week03-input.txt" , "r");
   if(file == NULL ) {
      printf ("error");
      return 0;
   }


   char * word = (char * ) malloc(10);
   printf("opening file!!");
   size_t length = 10;

   printf("\n");

   for( int i = 0; i < 444; i++ ){ 

      size_t r = 0;
      r = getdelim( &word , &length , ' ' , file );
      word[r -1] = '\0';
      strcpy(data[i].origin , word);


      r = getdelim( &word , &length , ' ' , file );
      word[r -1] = '\0';
      strcpy(data[i].destination , word);

      r = getdelim( &word , &length , ' ' , file );

      r = getdelim( &word , &length , ' ' , file );
      word[r -1] = '\0';
      strcpy(data[i].flightNumber , word);
      
      r = getdelim( &word , &length , ':' , file );
      word[r -1] = '\0';
      int d = atoi(word);
      r = getdelim( &word , &length , ' ' , file );
      word[r -1] = '\0';
      int dd = atoi(word);
      
      data[i].depTime.hrs = d;
      data[i].depTime.mins = dd;

      r = getdelim( &word , &length , ':' , file );
      word[r -1] = '\0';
       d = atoi(word);
      r = getdelim( &word , &length , '\n' , file );
      word[r -1] = '\0';
       dd = atoi(word);
      
      data[i].arrival.hrs = d;
      data[i].arrival.mins = dd;


      // printf("%s %s  %s  %d:%d %d:%d \n", data[i].origin , data[i].destination,  data[i].flightNumber , data[i].depTime.hrs , data[i].depTime.mins , data[i].arrival.hrs , data[i].arrival.mins);

   }

   printf("\n");
   free(word);
   fclose(file);

   char origin[4];
   char destin[4];

   scanf("%s %s" , origin , destin);
   FILE * outfile = fopen("output.txt" , "w");

///////////////////////////////////TASK 1///////////////////////////////////////////////////////////////////
   printf("TWO HOP FLIGHTS............................................................\n");
   fprintf(outfile , "TWO HOP FLIGHTS.....................................................\n");
   for( int i = 0; i < 444; i++ ){ 
      if(strcmp(origin , data[i].origin ) == 0 ){

         for( int j = 0; j < 444; j++ ){ 
            if(strcmp(destin , data[j].destination) == 0 && strcmp(data[i].destination , data[j].origin) == 0){
               printt(data[i] , outfile);
               printt(data[j] , outfile);
               fprintf(outfile , "\n");
            }
         }
      }     
   }

///////////////////////////////////TASK 2///////////////////////////////////////////////////////////////////
   printf("TWO HOP FLIGHTS WITH CONSTRAINT............................................................\n");
   fprintf(outfile , "TWO HOP FLIGHTS WITH CONSTRAINT......................................................\n");
   for( int i = 0; i < 444; i++ ){ 
      if(strcmp(origin , data[i].origin ) == 0 ){

         for( int j = 0; j < 444; j++ ){ 
            if(strcmp(destin , data[j].destination) == 0 && strcmp(data[i].destination , data[j].origin) == 0 && timecmp(data[j].depTime ,  data[i].arrival )){
               printt(data[i] , outfile);
               printt(data[j] , outfile);
               fprintf(outfile , "\n");
            }
         }
      }     
   }

///////////////////////////////////TASK 3///////////////////////////////////////////////////////////////////
   printf("THREE HOP FLIGHTS............................................................\n");
   fprintf(outfile , "THREE HOP FLIGHTS............................................................\n");
   for( int i = 0; i < 444; i++ ){ 
      if(strcmp(origin , data[i].origin ) == 0 ){
         for( int j = 0; j < 444; j++ ){ 
            if(strcmp(data[i].destination , data[j].origin) == 0 ){
               for( int k = 0; k < 444; k++ ){ 
                  if(strcmp(data[j].destination , data[k].origin) == 0 && strcmp(data[k].destination , destin) == 0)
                  {
                     printt(data[i] , outfile);
                     printt(data[j] , outfile);
                     printt(data[k] , outfile);
                  fprintf(outfile , "\n");
                  }
               }
            }
         }
      }     
   }

   fclose(outfile);

   return 0;
}