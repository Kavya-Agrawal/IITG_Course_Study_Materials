//bar.c
#include<stdio.h>

#include "foo.h"
#include "bar.h"

int main(){
	int x;
	x=foo3x(10);
	printf("Output from Foo is %d\n",x);
	x=bar5x(10);
	printf("Output from Bar is %d\n",x);
	return 0;
}
