#include <stdio.h>

#define INPUTFILE "in.txt"
#define OUTPUTFILE "out.txt"

int main(){
	FILE *fp;
	int a,b,c,d,e,f;
	
	//read 4 numbers from file. Sum the first two, subtract the second two
	
	fp = fopen(INPUTFILE, "r");
	if(fp == NULL){
		printf("Error reading the input file\n");
		return 1;
	}
	
	fscanf(fp, "%d %d %d %d", &a, &b, &c, &d);
	
	e = a+b;
	f = c-d;
	
	fclose(fp);
	
	fp = fopen(OUTPUTFILE, "w");
	if(fp == NULL){
		printf("Error reading the output file\n");
		return 1;
	}
	
	fprintf(fp, "%d + %d = %d\n", a, b, e);
	fprintf(fp, "%d - %d = %d\n", c, d, f);
	
	fclose(fp);
	
	return 0;
}
