#include<iostream>

using namespace std;

int main(){

    int lines;
    cin>>lines;

    char department_name[lines][3];
    int semester[lines];
    char course_id[lines][6];
    char course_name[lines][80];
    int hours[lines];
    int tuthours[lines];
    int prachours[lines];
    int Credits[lines];
    char ** Ddepartment = new char *[lines];
    int * Dsemester = new int[lines];
    char ** Dcourseid = new char* [lines];
    char ** Dcourse_name = new char* [lines];
    int * Dhours = new int [lines];
    int * Dtuthours = new int [lines]; 
    int * Dprachours = new int [lines];   
    int * DCred = new int [lines];


    for (int i = 0; i < lines; i++)
    {
        cin>>department_name[i]>>semester[i]>>course_id[i]>>course_name[i];
        cin>>hours[i]>>tuthours[i]>>prachours[i]>>Credits[i];
    }

    for (int i = 0; i < lines; i++)
    {
        Ddepartment[i] = new char [3];
        for (int j = 0; j < 3; j++) 
         {
             Ddepartment[i][j]=department_name[i][j];
         }
        Dsemester[i]=semester[i];
        Dcourseid[i] = new char[6];
        for (int j = 0; j < 6; j++)
        {
            Dcourseid[i][j]=course_id[i][j];
        }
        Dcourse_name[i] = new char[80];
        for (int j = 0; j < lines; j++)
        {
            Dcourse_name[i][j]=course_name[i][j];
        }
        Dhours[i] = hours[i];
        Dtuthours[i] = tuthours[i];
        Dprachours[i] = prachours[i];
        DCred[i] = Credits[i];
        
    }
    
    int totlechours=0 ,tottuthours=0, totprachours=0, totalcredit=0;
    int totlechours_e=0,tottuthours_e=0,totprachours_e=0,totalcredit_e=0;
    int totlechours_cse=0,tottuthours_cse=0,totprachours_cse=0,totalcredit_cse=0;
    int Dtotlechours=0,Dtottuthours=0,Dtotprachours=0,Dtotalcredit=0;
    int Dtotlechours_e=0,Dtottuthours_e=0,Dtotprachours_e=0,Dtotalcredit_e=0;
    int Dtotlechours_cse=0,Dtottuthours_cse=0,Dtotprachours_cse=0,Dtotalcredit_cse=0;

    for (int i = 0; i < lines; i++)
    {
        if(course_id[i][0]=='C' && course_id[i][1]=='S' )
        {    totlechours_cse+=hours[i];
            tottuthours_cse+=tuthours[i];
            totprachours_cse+=prachours[i];
            totalcredit_cse+=Credits[i];
        }
        tottuthours+=tuthours[i];
        totlechours+=hours[i];
        totprachours+=prachours[i];
        totalcredit+=Credits[i];

        if(semester[i]%2==0){
            totlechours_e+=hours[i];
            tottuthours_e+=tuthours[i];
            totprachours_e+=prachours[i];
            totalcredit_e+=Credits[i];
        }
    
    }
    cout << " Task no 3 \n";
    cout<<totlechours<<" "<<tottuthours<<" "<<totprachours<<" "<<totalcredit<<"\n";
    cout << " Task no 4 \n";
    cout<<totlechours_e<<" "<<tottuthours_e<<" "<<totprachours_e<<" "<<totalcredit_e<<"\n";
    cout << " Task no 5 \n";
    cout<<totlechours_cse<<" "<<tottuthours_cse<<" "<<totprachours_cse<<" "<<totalcredit_cse<<"\n";


    for (int i = 0; i < lines; i++)
    {
        Dtotlechours+=Dhours[i];
        Dtottuthours+=Dtuthours[i];
        Dtotprachours+=Dprachours[i];
        Dtotalcredit+=DCred[i];
    
        if(semester[i]%2==0){
            Dtotlechours_e+=Dhours[i];
            Dtottuthours_e+=Dtuthours[i];
            Dtotprachours_e+=Dprachours[i];
            Dtotalcredit_e+=DCred[i];
        }
    
        if(course_id[i][0]=='C' && course_id[i][1]=='S' )
        {    Dtotlechours_cse+=Dhours[i];
            Dtottuthours_cse+=Dtuthours[i];
            Dtotprachours_cse+=Dprachours[i];
            Dtotalcredit_cse+=DCred[i];
        }
    }
    
    cout<<"Task3 with dynamic\n ";
    cout<<Dtotlechours<<" "<<Dtottuthours<<" "<<Dtotprachours<<" "<<Dtotalcredit<<"\n";
    cout<<"Task4 with dynamic\n";
    cout<<Dtotlechours_e<<" "<<Dtottuthours_e<<" "<<Dtotprachours_e<<" "<<Dtotalcredit_e<<"\n";
    cout<<"Task5 with dynamic\n";
    cout<<Dtotlechours_cse<<" "<<Dtottuthours_cse<<" "<<Dtotprachours_cse<<" "<<Dtotalcredit_cse<<"\n";
    
    for (int i = 0; i < lines; i++)
    {
        delete( Ddepartment[i]);
        delete (Dcourse_name[i]);
        delete ( Dcourseid[i]);
    }

    delete(Dhours);
    delete(Dprachours);
    delete(Dtuthours);
    delete(DCred);
    
    /////////////////////////now seven 
    cout << " Task no 7 \n";

    int * lectures = new int [lines];
    int * tutorials = new int [lines];
    int * practicals = new int [lines];
    int * creditss = new int [lines];

    for (int i = 0; i < lines; i++)
    {
        lectures[i]  = hours[i];
        tutorials[i] = tuthours[i];
        practicals[i] = prachours[i] ;
        creditss[i] = Credits[i];
    }
     int * p1= &lectures[29];
     int * p2= &tutorials[29];
     int * p3= &practicals[29];
     int * p4= &creditss[29];

    int Ptotlechours=0 ,Ptottuthours=0, Ptotprachours=0, Ptotalcredit=0;
    int Ptotlechours_e=0,Ptottuthours_e=0,Ptotprachours_e=0,Ptotalcredit_e=0;
    int Ptotlechours_cse=0,Ptottuthours_cse=0,Ptotprachours_cse=0,Ptotalcredit_cse=0;

    for (int i = 29; i < lines; i++)
    {
        Ptotlechours+= *p1;
        Ptottuthours+= *p2;
        Ptotprachours+= *p3;
        Ptotalcredit+= *p4;
        if(semester[i] % 2 ==0 ) {
            Ptotlechours_e += *p1;
            Ptottuthours_e += *p2;
            Ptotprachours_e += *p3;
            Ptotalcredit_e += *p4;

        }
        if(course_id[i][0]=='C' && course_id[i][1]=='S' )
        {   Ptotlechours_cse+= *p1;
            Ptottuthours_cse+= *p2;
            Ptotprachours_cse+= *p3;
            Ptotalcredit_cse+= *p4;
        }
        p1++;p2++;p3++;p4++;

    }
    p1= &lectures[28];
     p2= &tutorials[28];
     p3= &practicals[28];
     p4= &creditss[28];   

    for (int i = 28; i >=0 ; i--)
    {
        Ptotlechours+= *p1;
        Ptottuthours+= *p2;
        Ptotprachours+= *p3;
        Ptotalcredit+= *p4;
        if(semester[i] % 2 ==0 ) {
            Ptotlechours_e += *p1;
            Ptottuthours_e += *p2;
            Ptotprachours_e += *p3;
            Ptotalcredit_e += *p4;

        }
        if(course_id[i][0]=='C' && course_id[i][1]=='S' )
        {   Ptotlechours_cse+= *p1;
            Ptottuthours_cse+= *p2;
            Ptotprachours_cse+= *p3;
            Ptotalcredit_cse+= *p4;
        }
        p1--;p2--;p3--;p4--;

    }

    cout  <<  "Task3 with Pointer Arithmetic\n ";
    cout  <<  Ptotlechours<<" "<<Ptottuthours<<" "<<Ptotprachours<<" "<<Ptotalcredit<<"\n";
    cout  <<  "Task4 with Pointer Arithmetic\n";
    cout  <<  Ptotlechours_e<<" "<<Ptottuthours_e<<" "<<Ptotprachours_e<<" "<<Ptotalcredit_e<<"\n";
    cout  <<  "Task5 with Pointer Arithmetic\n";
    cout  <<  Ptotlechours_cse<<" "<<Ptottuthours_cse<<" "<<Ptotprachours_cse<<" "<<Ptotalcredit_cse<<"\n";

    
    


    return 0;
}