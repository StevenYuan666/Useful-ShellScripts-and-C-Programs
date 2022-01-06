#ifndef __WORDLIST_H_
#define __WORDLIST_H_
struct WordNode
{
	char *word;
	unsigned long count;
	struct WordNode *next;
};

// Function to add a word to the wordlist. If the word exists, the counter is incremented.
//  returns the head node to the wordlist.
struct WordNode *addWord(char* word, struct WordNode *wordListHead, int *outofmemory);

// cleanup - delete the nodes, etc. that are part of the wordlist.
void deleteList(struct WordNode *wordListHead);

// Goes over the list of words and prints the word and count
void printWordList(struct WordNode *wordListHead);

#endif //__WORDLIST_H_
