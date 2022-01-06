#include <stdio.h>
#include <string.h>

#include "wordlist.h"

// Function to convert upper case letters into lower case.
void toLower(char *carray)
{
	while(*carray != '\0')
	{
		if(*carray >= 'A' && *carray <= 'Z') // if it is an upper case letter
			*carray = *carray - 'A' + 'a'; // convert it into a lower case letter
		carray++;
	}
}

int main(int argc, char* argv[])
{
	struct WordNode *head=NULL; // Pointer to the beginning of our word list.
	char *delim = " \t\n,:;'\".?!#$-><(){}[]|\\/*&^%@!~+=_"; // These are our word delimiters.
	int outofmemory=0;
	int returncode=0;

	if(argc < 2)
	{
		fprintf(stderr, "Usage: wcloud article [article]...\n");
		return 1;
	}

	for (int fileno=1; fileno<argc; fileno++)
	{
		FILE *article = fopen(argv[fileno], "rt"); // Open an article
		if(article == NULL)
		{
			fprintf(stderr, "Error! unable to open %s\n", argv[fileno]);
			returncode=2;
		}
		else
		{
			char line[1001];
			while(fgets(line, 1001, article) != NULL) // read one line at a time.
			{
				toLower(line); // convert the letters to lowercase.
				char *word = strtok(line, delim); // split the line into words.
				while(word != NULL)
				{
					head = addWord(word, head, &outofmemory);	// add each word into word into our word cloud list.
					if(outofmemory)
					{ returncode = 3; break; }
					word = strtok(NULL, delim);
				}
			}
			//close the file after reading through it.
			fclose(article);
		}
	}

	if(!outofmemory)
		printWordList(head); // Print the word cloud info.

	deleteList(head); // clean up.
	if(outofmemory)
		fprintf(stderr, "Error!! ran out of memory!\n");

	return returncode;
}
