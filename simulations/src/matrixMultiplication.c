#include <stdio.h>
#define INPUTFILE "in.txt"
#define OUTPUTFILE "out.txt"

int main(){

	FILE *fpInput, *fpOutput;
	int size, tmp;
	
	int mat1[50][50], mat2[50][50], res[50][50];
	
	fpInput = fopen(INPUTFILE, "r");
	fpOutput = fopen(OUTPUTFILE, "w");
	
	if(fpInput == NULL){
		printf("Error reading the input file \n");
		return 1;
	}
	
	if(fpOutput == NULL){
		printf("Error reading the output file \n");
		return 1;
	}
	
	//read size of matrix
	fscanf(fpInput, "%d", &size);
	
	//read input matrices
	for(int i=0; i<size; i++){
		for(int j=0; j<size; j++){
			fscanf(fpInput, "%d", &mat1[i][j]);
		}	
	}
	for(int i=0; i<size; i++){
		for(int j=0; j<size; j++){
			fscanf(fpInput, "%d", &mat2[i][j]);
		}	
	}
	
	//preform matrix multiplication
	for(int i=0; i<size; i++){
		for(int j=0; j<size; j++){
			tmp = 0;
			for(int k=0; k<size; k++){
				tmp += mat1[i][k] * mat2[k][j];
			}
			res[i][j] = tmp;
		}	
	}
	
	
	//write output
	for(int i=0; i<size; i++){
		for(int j=0; j<size; j++){
			fprintf(fpOutput, "%d ", res[i][j]);
		}	
		fprintf(fpOutput, "\n");
	}
	
	fclose(fpInput);
	fclose(fpOutput);
	
	return 0;
}
