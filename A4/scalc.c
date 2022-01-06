/*
Program to implement a scientific calculator
***************************************************************
* Author       Dept.           Date          Notes
***************************************************************
* Ye Yuan   Comp. Science. Oct 30 2020   Initial version .
* Ye Yuan   Comp. Science. Oct 30 2020   Stuck on how to deal with the float inputs
* Ye Yuan   Comp. Science. Oct 31 2020   Try to deal with the float inputs with the method in PPT Lecture Week7 page32
* Ye Yuan   Comp. Science. Oct 31 2020   Try to solve the question 7&8 together by using char *
* Ye Yuan   Comp. Science. Nov 1  2020   Continue to solve the question 7&8,failed with char * yesterday
* Ye Yuan   Comp. Science. Nov 1  2020   Succeed with char[] to solve the question 7&8, and passed the tester.
* Ye Yuan   Comp. Science. Nov 6  2020   Notice that the professor said we should consider the situation if the input is like 2012xa9, so I changed the part of code to deal with this situation. Then test it again, and resubmit to mycourse.
* Ye Yuan   Comp. Science. Nov 6  2020   Check the piazza again, and notice that we should consider the situation if the second input is like +++ or +p, so change the part of code, and resumbit to mycourse again.
*/

//add the built-in library first
#include<stdio.h>

//write the only function main
int main(int argc, char *argv[]){

	//deal with the situation when the number of inputs is not equal to 3
	if (argc != 4) {
		printf("Error: invalid number of arguments!\n");
		printf("scalc <operand%d> <operator> <operand%d>\n",1,2);
		return 1;
	}

	//deal with the situation when the operator is not "+"
	char *operator = argv[2];
	int countO = 0;
	while (*operator != '\0'){
		if (*operator != 43 || countO != 0) {
			printf("Error: operator can only be + !\n");
			return 1;
		}
		countO ++;
		operator ++;
	}

	//deal with the situation if the first input is a float number
	char *p1 = argv[1];
	while (*p1 != '\0') {
		if (*p1 > 57 || *p1 < 48) {
			printf("Error!! operand can only be positive integers\n");
			return 1;
		}
		p1 ++;
	}

	//deal with the situation if the second operand is a float number
	char *p2 = argv[3];
	while (*p2 != '\0') {
		if (*p2 > 57 || *p2 < 48) {
			printf("Error!! operand can only be positive integers\n");
			return 1;
		}
		p2 ++;
	}

	//start the part of calculating
	p1 = argv[1];
	p2 = argv[3];
	char o1[1000];
	char o2[1000];
	int i = 0;
	while(*p1 != '\0') {
		o1[i] = *p1;
		p1 ++;
		i ++;
	}
	o1[i] = '\0';
	int j = 0;
	while(*p2 != '\0') {
                o2[j] = *p2;
                p2 ++;
                j ++;
        }
	o2[j] = '\0';
	
	int tmp = 0;
	int len = 0;
	if (i > j) len = i + 2; else len = j + 2;
	int result[len];
	if( i >= j) {
		i --;
		j --;
		while ( j != -1) {
			int d = ((int)o1[i] - 48) + ((int)o2[j] - 48) + tmp;
			tmp = 0;
			if (d > 9){
				tmp = 1;
				d = d - 10;
			}
			result[i+1] = d;
			i --;
			j --;
		}
		while (i != -1) {
			int d = ((int)o1[i] - 48) + tmp;
			tmp = 0;
			if (d > 9){
                                tmp = 1;
                                d = d - 10;
                        }
                        result[i+1] = d;
                        i --;
		}
		if (tmp != 0) result[0] = tmp; else result[0] = -1;
	}
	else{
		i --;
		j --;
		while(i != -1) {
			int d = ((int)o1[i] - 48) + ((int)o2[j] - 48) + tmp;
                        tmp = 0;
                        if (d > 9){
                                tmp = 1;
                                d = d - 10;
                        }
                        result[j+1] = d;
                        i --;
                        j --;
		}
		while (j != -1) {
			int d = ((int)o2[j] - 48) + tmp;
                        tmp = 0;
                        if (d > 9){
                                tmp = 1;
                                d = d - 10;
                        }
                        result[j+1] = d;
                        j --;
		}
		if (tmp != 0) result[0] = tmp; else result[0] = -1;
	}
	for (int index = 0; index < len - 1; index ++){
		if (result[index] != -1) printf("%d", result[index]);
	}
	printf("\n");
	return 0;
}













