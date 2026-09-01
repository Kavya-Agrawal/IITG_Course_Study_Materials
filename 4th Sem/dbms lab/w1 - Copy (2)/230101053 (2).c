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

/// @brief TA HAS ASSURED THAT IF THE OUTPUT IS CORRECT, THEN THERE IS NO NEED TO DO QUICKSORT MULTIPLE TIMES RATHER WE CAN CREATE A COMPARISION FUNCTION   
/// @return 

int compare( struct record a , struct record b ){
   if( strcmp(a.origin , b.origin) == 0){

      if( strcmp(a.destination , b.destination) == 0){
         if(a.depTime.hrs == b.depTime.hrs){
            if(a.depTime.mins == b.depTime.mins){
               return 1;
            }
            else if(a.depTime.mins < b.depTime.mins) return 1;
            else return 0;
         }
         else if(a.depTime.hrs < b.depTime.hrs) return 1;
         else return 0;
      }
      else if(strcmp(a.destination , b.destination) > 0) return 1;
      else return 0; 
   }

   else if(strcmp(a.origin , b.origin) > 0) return 0;
   else return 1;
}

int partition(record arr[], int low, int high) {
   record pivot = arr[high];
   int i = low - 1;
   for (int j = low; j <= high - 1; j++) {
      if (compare(arr[j] , pivot)) {
         i++;
         record temp  = arr[i];
         arr[i] = arr[j];
         arr[j] = temp;
      }
   }
   record temp  = arr[i+1];
   arr[i+1] = arr[high];
   arr[high] = temp; 
   return i + 1;
}

void quickSort(record arr[], int low, int high) {
   if (low < high) {
      int pi = partition(arr, low, high);
      quickSort(arr, low, pi - 1);
      quickSort(arr, pi + 1, high);
   }
}

int main(){

   FILE * file = fopen("week02-input.txt" , "r");
   if(file == NULL ) {
      printf ("error");
      return 0;
   }

   struct record data[444];

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
   fclose(file);
   FILE * outfile = fopen("output.txt" , "a");

   quickSort(data , 0 , 443 );

   for( int i = 0; i < 444; i++ ){ 

      //// CONVERTING THE INT TO STRINGS SO THAT  "5" CHANGES TO "05";

      char a[3];
      a[2] =  '\0';
      if(data[i].depTime.hrs < 10 ){
         a[0] = '0';
         a[1] = (char)(data[i].depTime.hrs + '0');
      }
      else {
         a[1] = (char)(data[i].depTime.hrs%10 + '0');
         a[0] = (char)(data[i].depTime.hrs/10 + '0');
      }
      char b[3];
      b[2] =  '\0';
      if(data[i].depTime.mins < 10 ){
         b[0] = '0';
         b[1] = (char)(data[i].depTime.mins + '0');
      }
      else {
         b[1] = (char)(data[i].depTime.mins%10 + '0');
         b[0] = (char)(data[i].depTime.mins/10 + '0');
      }
      char c[3];
      c[2] =  '\0';
      if(data[i].arrival.hrs < 10 ){
         c[0] = '0';
         c[1] = (char)(data[i].arrival.hrs + '0');
      }
      else {
         c[1] = (char)(data[i].arrival.hrs%10 + '0');
         c[0] = (char)(data[i].arrival.hrs/10 + '0');
      }
      char d[3];
      d[2] =  '\0';
      if(data[i].arrival.mins < 10 ){
         d[0] = '0';
         d[1] = (char)(data[i].arrival.mins + '0');
      }
      else {
         d[1] = (char)(data[i].arrival.mins%10 + '0');
         d[0] = (char)(data[i].arrival.mins/10 + '0');
      }

      //////////////////////////CONVERSION DONE

      // printf("%s %s %s %s\n" , a , b , c , d);
      fprintf(outfile  , "%s %s  %s  %s:%s %s:%s \n", data[i].origin , data[i].destination,  data[i].flightNumber , a , b ,c ,d );
      // printf("%s %s  %s  %s:%s %s:%s \n", data[i].origin , data[i].destination,  data[i].flightNumber , a , b ,c ,d );

   }

   fclose(file);

   return 0;
}