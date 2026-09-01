#include<stdio.h>

float AreaOfCircle(float r);
float AreaOfCube(float a);
float AreaOfCylinder(float r, float h);
float AreaOfRectangle(float a, float b);
float AreaOfSphere(float r);

int main(){

	printf("AreaOfCircle of radius 3=%f \n", AreaOfCircle(3.0));
	printf("AreaOfCube of side 3=%f \n", AreaOfCube(3.0));	
	printf("AreaOfCube of Sphere of radius 3=%f \n", AreaOfSphere(3.0));	
	printf("AreaOfCube of Cyllender radius 3 and height 4 =%f \n", AreaOfCylinder(3.0, 4.0));	
	printf("AreaOfCube of Rectangle of size 3 and 4 =%f \n", AreaOfRectangle(3.0, 4.0));	

	return 0;
}

