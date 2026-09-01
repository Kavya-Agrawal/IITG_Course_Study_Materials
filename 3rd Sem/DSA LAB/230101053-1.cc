#include <bits/stdc++.h>
#include <vector>
#include <fstream>
#include <string>
using namespace std;
typedef long long ll;
typedef unsigned long long ull;
typedef pair<ll, ll> pll;
typedef pair<int, int> pii;
typedef pair<int, ll> pil;
typedef pair<ll, int> pli;
typedef vector<ll> vl;
typedef vector<int> vi;

typedef struct matrix
{
   float gx;
   float gy;
   float G ;
   int value;
   
} matrix; 

typedef struct meta_data
{
   int image_rows ;
   int image_columns ;
   int kx_rows;
   int kx_columns;
   int ky_columns;
   int ky_rows;

} meta_data;

void compute_gx( matrix ** kx , matrix ** image , int i , int j , meta_data mydata){
      float ans = 0;
      // cout << i << j << mydata.kx_rows << mydata.kx_columns  << endl;
      for (int a = i- mydata.kx_rows / 2 ; a <= i + mydata.kx_rows / 2 ; a++)
      {
         for (int b = j- mydata.kx_columns / 2; b <= j + mydata.kx_columns / 2; b++)
         {
            ans+= ( (float) image[a][b].value *  (float) kx[a - (i- mydata.kx_rows / 2)][b - (j- mydata.kx_rows / 2)].value );
         }
         
      }
      image[i][j].gx  = ans ;    
}

void compute_gy( matrix ** ky , matrix ** image , int i , int j , meta_data mydata){
      float ans = 0;
      for (int a = i- mydata.ky_rows / 2 ; a <= i + mydata.ky_rows / 2 ; a++)
      {
         for (int b = j- mydata.ky_columns / 2; b <= j+ mydata.ky_columns / 2; b++)
         {
            // cout << a << b << endl;
            ans+= ( (float) image[a][b].value * (float) ky[a - (i- mydata.kx_rows / 2)][b - (j- mydata.kx_rows / 2)].value );
         }
         
      }
      image[i][j].gy = ans ;    
}

void compute_g( matrix ** image, int i, int j ){
   image[i][j].G =  sqrt( image[i][j].gx * image[i][j].gx + image[i][j].gy * image[i][j].gy );
}





int main(){


   ios_base::sync_with_stdio(false);
   cin.tie(NULL);cout.tie(NULL);

   matrix mymat;
   meta_data mydata ;

   matrix * * kx = NULL;
   matrix * * ky = NULL;
   matrix * * image = NULL;

   ifstream inFile("kx.txt");
   if (!inFile.is_open())
   {
      cout << "Error occured !" ;
   }
   else
   {
      inFile >> mydata.kx_rows >> mydata.kx_columns ;  
   }

   kx = new matrix * [mydata.kx_rows];
   for (int i = 0; i < mydata.kx_columns; i++)
   {
      kx[i] = new matrix [mydata.kx_columns];
   }

   if (!inFile.is_open())
   {
      cout << "Error occured !" ;
   }
   else
   {
      for (int i = 0; i < mydata.kx_rows; i++)
      {
         for (int j = 0; j < mydata.kx_columns; j++)
         {
            inFile >> kx[i][j].value ;
         }
         
      }
      inFile.close();
      
   }



   ifstream inFile2("ky.txt");
   if (!inFile2.is_open())
   {
      cout << "Error occured !" ;
   }
   else
   {
      inFile2 >> mydata.ky_rows >> mydata.ky_columns ;  
   }
   ky = new matrix * [mydata.ky_rows];
   for (int i = 0; i < mydata.ky_columns; i++)
   {
      ky[i] = new matrix [mydata.ky_columns];
   }

   if (!inFile2.is_open())
   {
      cout << "Error occured !" ;
   }
   else
   {
      for (int i = 0; i < mydata.ky_rows; i++)
      {
         for (int j = 0; j < mydata.ky_columns; j++)
         {
            inFile2 >> ky[i][j].value ;
         }
         
      }
      inFile2.close();
      
   }
   
   ifstream inFile3("image.txt");
   if (!inFile3.is_open())
   {
      cout << "Error occured !" ;
   }
   else
   {
      inFile3 >> mydata.image_rows >> mydata.image_columns;
      
   }
   image = new matrix * [mydata.image_rows];
   for (int i = 0; i < mydata.image_columns; i++)
   {
      image[i] = new matrix [mydata.image_columns];
   }

   if (!inFile3.is_open())
   {
      cout << "Error occured !" ;
   }
   else
   {
      for (int i = 0; i < mydata.image_rows; i++)
      {
         for (int j = 0; j < mydata.image_columns; j++)
         {
            inFile3 >> image[i][j].value ;
         }
         
      }
      inFile3.close();
   }



   for (int i = 1 ; i < mydata.image_rows - 1; i++)
   {
      for (int j = 1 ; j < mydata.image_columns - 1; j++)
      {
         compute_gx(kx, image, i , j , mydata);
         compute_gy(ky, image, i , j , mydata);
         compute_g(image , i , j);
      }
      
   }

   ofstream outFile("output1.txt");
   for (int i = mydata.kx_rows / 2 ; i < mydata.image_rows - mydata.kx_rows / 2; i++)
   {
      for (int j = mydata.kx_columns / 2 ; j < mydata.image_columns- mydata.ky_columns / 2; j++)
      {
         outFile << "(  " << i << ",  " << j << "): g_x: " << image[i][j].gx <<", g_y: " << image[i][j].gy << ", G: " << image[i][j].G << endl;
      }
      
   }
   outFile.close();



   ////////////task 6//////////////////


   matrix ** lambda_image = image;
   
   auto lambda_compute_gx =  [& lambda_image , & kx , & mydata]( int i , int j ) -> float{
      float ans = 0;
      // cout << i << j << mydata.kx_rows << mydata.kx_columns  << endl;
      for (int a = i- mydata.kx_rows / 2 ; a <= i + mydata.kx_rows / 2 ; a++)
      {
         for (int b = j- mydata.kx_columns / 2; b <= j + mydata.kx_columns / 2; b++)
         {
            ans+= ( (float) lambda_image[a][b].value *  (float) kx[a - (i- mydata.kx_rows / 2)][b - (j- mydata.kx_rows / 2)].value );
         }
         
      }
      return ans ; 
   };
   auto lambda_compute_gy =  [& lambda_image , & ky , & mydata ]( int i , int j ) -> float{
      float ans = 0;
      // cout << i << j << mydata.kx_rows << mydata.kx_columns  << endl;
      for (int a = i- mydata.ky_rows / 2 ; a <= i + mydata.ky_rows / 2 ; a++)
      {
         for (int b = j- mydata.ky_rows / 2; b <= j + mydata.ky_rows / 2; b++)
         {
            ans+= ( (float) lambda_image[a][b].value *  (float) ky[a - (i- mydata.kx_rows / 2)][b - (j- mydata.kx_rows / 2)].value );
         }
      }
      return ans ; 
   };
   auto lambda_compute =  [] ( float gx , float gy ) -> float{
      return  sqrt( gx * gx + gy * gy );
   };


   for (int i = 1 ; i < mydata.image_rows - 1; i++)
   {
      for (int j = 1 ; j < mydata.image_columns - 1; j++)
      {
         lambda_image[i][j].gx  =  lambda_compute_gx(i , j);
         lambda_image[i][j].gy  =  lambda_compute_gy(i , j);
         lambda_image[i][j].G  = lambda_compute( lambda_image[i][j].gx , lambda_image[i][j].gy);
      }
      
   }
   ofstream outFile2("output2.txt");
   for (int i = mydata.kx_rows / 2 ; i < mydata.image_rows - mydata.kx_rows / 2; i++)
   {
      for (int j = mydata.kx_columns / 2 ; j < mydata.image_columns- mydata.ky_columns / 2; j++)
      {
         outFile2 << "(  " << i << ",  " << j << "): g_x: " << lambda_image[i][j].gx <<", g_y: " << lambda_image[i][j].gy << ", G: " << lambda_image[i][j].G << endl;
      }
      
   }
   outFile2.close();

   ///////////using pointers////////////


   void (* pointer_gx) (matrix ** kx , matrix ** image , int i , int j , meta_data mydata) = & compute_gx ; 
   void (* pointer_gy) (matrix ** ky , matrix ** image , int i , int j , meta_data mydata) = & compute_gx ; 
   void (* pointer_g) (matrix ** image, int i, int j) = & compute_g ; 


   for (int i = 1 ; i < mydata.image_rows - 1; i++)
   {
      for (int j = 1 ; j < mydata.image_columns - 1; j++)
      {
         (*pointer_gx) ( kx, image, i , j , mydata);
         (*pointer_gy) (ky, image, i , j , mydata);
         (*pointer_g) (image , i , j);
      }
      
   }

   fstream outFile3("output3.txt");
   for (int i = mydata.kx_rows / 2 ; i < mydata.image_rows - mydata.kx_rows / 2; i++)
   {
      for (int j = mydata.kx_columns / 2 ; j < mydata.image_columns- mydata.ky_columns / 2; j++)
      {
         outFile3 << "(  " << i << ",  " << j << "): g_x: " << image[i][j].gx <<", g_y: " << image[i][j].gy << ", G: " << image[i][j].G << endl;
      }
      
   }
   outFile3.close();


   return 0;
}