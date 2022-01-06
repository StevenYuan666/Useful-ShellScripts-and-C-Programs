/*
Program to implement a scientific calculator
***************************************************************
* Author       Dept.           Date          Notes
***************************************************************
* Ye Yuan   Comp. Science. Nov 12 2020   Initial version .
* Ye Yuan   Comp. Science. Nov 12 2020   Stuck on how to store the value to ip in checkNameExists function.
* Ye Yuan   Comp. Science. Nov 13 2020   Solve the problem with error code of ip(the memory is not correct)
* Ye Yuan   Comp. Science. Nov 13 2020   Try to solve the storage of ip address
* Ye Yuan   Comp. Science. Nov 13 2020   Solve the storage of ip address, try to find all collabrators
* Ye Yuan   Comp. Science. Nov 13 2020   Completed. Start to create the tester.
*/

#include<stdio.h>
#include<stdlib.h>
#include<errno.h>
#include<string.h>

struct logrecord
{
	char name[100];
	char IPAddress[50];
};

struct logrecord readLog(char* logline)
{
	// parse a character array that contains an line from the log
	// and return a structure that contains the fileds of interest to us.
	
	char line[250];
	int index = 0;
	while(*logline != '\0'){
		line[index] = *logline;
		logline ++;
		index ++;
	} 
	struct logrecord r;
	const char s[2] = ",";
	char* n = strtok(line, s);
	
	int i = 0;
	char* ip1;	
	while (i < 6){
		ip1 = strtok(NULL, s);
		i ++;
	}

	char ip2[51];
	index = 0;
	while((*ip1 <= 57 && *ip1 >= 48) || *ip1 == 46){
		ip2[index] = *ip1;
		index ++;
		ip1 ++;
	}
	
	ip2[index] = '\0';
	strcpy(r.name, n);
	strcpy(r.IPAddress, ip2);
	return r;
}

int checkNameExists(FILE* csvfile, char* name, char* ip)
{
	// Read through the CSV data file, keep looking for the name.
	// If found, store the IP address associated with the name
	// to the variable ip and return success.
	// Is bool a valid data type in C? How do you indicate true/false concept in C?

	char line[251];
	struct logrecord tmp;
	fgets(line, 250, csvfile);
	while(!feof(csvfile)){
		char line2[251];
		fgets(line2, 250, csvfile);
		tmp = readLog(line2);
		if(strcmp(tmp.name, name) == 0){
			strcpy(ip, tmp.IPAddress);
			return 0;
		}
	}
	return 1;
}

void findCollaborators(char* sname, char *sip, FILE* csvfile, FILE* rptfile)
{
	// Go through the CSV data file
	// look for collaborators of sname by looking for entries with the same ip as sip
	// if any collaborators are found, write it to the output report file.
	
	char n[101];
	strcpy(n, sname);
	char firstline[251] ;
	fgets(firstline, 250, csvfile);
	int ifHasCollaborators = 0;
	while(!feof(csvfile)){
		char line[251];
		fgets(line, 250, csvfile);
		struct logrecord record;
		record = readLog(line);
		if((strcmp(record.IPAddress, sip) == 0) && (strcmp(n, record.name)) != 0){
			strcpy(n, record.name);
			fputs(record.name, rptfile);
			fputs("\n", rptfile);
			ifHasCollaborators = 1;
		}	
	}
	if(ifHasCollaborators == 0){
		fputs("No collaborators found for ", rptfile);
		fputs(sname, rptfile);
		fputs("\n", rptfile);
	}
}

int main(int argc, char* argv[])
{
	// Do any basic checks, "duct-tape" your full program logic using the above functions,
	// any house-keeping, etc.
	
	//check the number of inputs is 3
	if(argc != 4){
		fprintf(stderr,"Usage ./report <csvfile> %c<student name> %c <reportfile>\n",'"','"');
		return 1;
	}
	
	//check if we can read the input file
	FILE* f = fopen(argv[1], "rt");
	if(f == NULL){
		fprintf(stderr, "Error, unable to open csv file %s\n", argv[1]);
		return 1;
	}
	
	//check if the name input exist in the file
	char* name = argv[2];
	char ip[51];
	if(checkNameExists(f, name, ip) == 1){
		fprintf(stderr, "Error, unable to locate %s\n", name);
		return 1;
	}	

	//check if we can write to the output file
	FILE *output = fopen(argv[3], "wt");
	if(output == NULL){
		fprintf(stderr, "Error, unable to open the output file %s\n", argv[3]);
		return 1;
	}
	
	findCollaborators(name, ip, f, output);	
}

