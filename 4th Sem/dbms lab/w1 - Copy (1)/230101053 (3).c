#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

typedef struct{
   char pincode1[7];
   float latitude;
   float longitude;
   char place[51];
   char pincode2[7];
   char address[51];
   char city[21];

} node;

typedef struct{
   double d;
   char name[51];
} pair;

void insertionSort(pair arr[], int n)
{
   for (int i = 1; i < n; ++i) {
      pair temp = arr[i];
      double key = arr[i].d;
      int j = i - 1;

      
      while (j >= 0 && arr[j].d > key) {
         arr[j + 1] = arr[j];
         j = j - 1;
      }
      arr[j + 1] = temp;
   }
}


int main(){

   ////////////////////// THE SINE AND COS AND OTEHR MATHEMATICAL FUNCTIONS ARE NOT WORKKING UISNG ORDINARY COMPILATION. pLEASE COMILE UISNG THE FLAG -lm USING WHICH THE OUTPUT IS COMING.

   FILE *file = fopen("week01-input-01.txt" , "r");
   node arr[1000];
   if(file == NULL ) {
      printf ("error");
      return 0;
   }

   // char line[1000];
   char * word = (char * ) malloc(50);
   printf("opening file!!");
   // printf("opening file!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

   size_t length = 50;

   for (int i = 0; i < 649 ; i++)
   {

      //reading the inputs using , as deliminator.

      size_t r = 0;
      r = getdelim(&word , &length , ',' , file );
      word[r -1] = '\0';
      strcpy(arr[i].pincode1 , word);

      // printf("%s \n" , word);

      r = getdelim(&word , &length , ',' , file );
      word[r -1] = '\0';
      // printf("%s \n" , word);
      double d = atof(word);
      arr[i].latitude = d;

      r = getdelim(&word , &length , ',' , file );
      word[r -1] = '\0';
      // printf("%s \n" , word);
       d = atof(word);
      arr[i].longitude = d;
      
      r = getdelim(&word , &length , ',' , file );
      word[r -1] = '\0';
      // printf("%s \n" , word);
      strcpy(arr[i].place , word);


      r = getdelim(&word , &length , ',' , file );
      word[r -1] = '\0';
      // printf("%s \n" , word);
      strcpy(arr[i].pincode2 , word);

       r = getdelim(&word , &length , ',' , file );
      word[r -1] = '\0';
      // printf("%s \n" , word);
      strcpy(arr[i].address , word);

      r = getdelim(&word , &length , '\n' , file );
      word[r -1] = '\0';
      // printf("%s \n" , word);
      strcpy(arr[i].city , word);

      // printf( "%s, %f, %f, %s,,,,, %s,,,,, %s, %s" , arr[i].pincode1 , arr[i].latitude , arr[i].longitude , arr[i].place , arr[i].pincode2 ,arr[i].address , arr[i].city);

      // printf("\n");
   }

   free(word);
   fclose(file);

   double dis[649][649];

   for (int i = 0; i < 649; i++)
   {
      for (int j = 0; j < 649; j++)
      {

         double phi1 = (arr[i].latitude * (3.14159)) / 180.00f ;
         double phi2 = (arr[j].latitude * (3.14159)) / 180.00f ;
         double lam1 = (arr[i].longitude * (3.14159)) / 180.00f ;
         double lam2 = (arr[j].longitude * (3.14159)) / 180.00f ;

         double del1 = (phi1 - phi2) / 2.00f;
         double del2 = (lam1 - lam2) / 2.00f;

          
         // printf("%f %f %f %f %f %f  \n" , arr[i].latitude  , arr[j].longitude  ,  phi1 , phi2 , lam1 , lam2);

         dis[i][j] = 2 * 6371 * asin ( sqrt( sin(del1)*sin(del1) + cos(phi1)* cos(phi2) * sin(del2) * sin(del2) ) );
      }
   }
   

   for (int i = 0; i < 649; i++)
   {
      printf("CITY NO %i ..................................................................................\n" , i+1);
      pair ar[648];

      int count = 0;

      for( int j = 0; j < 649; j++ ){ 

         if(i==j) continue;

         ar[count].d = dis[i][j];
         strcpy(ar[count].name, arr[j].place);
         count++;
      }
      insertionSort(ar , 648);
      for (int j = 0; j < 648; j++)
      {
         printf(" %s (%f km), " , ar[j].name , ar[j].d );
      }
      printf("\n");
      printf("\n");
      printf("\n");

   }

   


   return 0;
}