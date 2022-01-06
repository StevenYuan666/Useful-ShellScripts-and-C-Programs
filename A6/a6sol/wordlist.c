#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "wordlist.h"

struct WordNode *makeNode(char* word)
{
	// Allocate memory for a new node -> calloc will also set everything to NULL/0s
	struct WordNode *wn = calloc(sizeof(struct WordNode), 1);
	if(wn == NULL)
		return NULL;

	wn->word = malloc(strlen(word)+1); // allocate memory for storing the word. +1 for \0 char at the end.
	if(wn->word == NULL)
	{
		free(wn); // release the memory allocated to node.
		return NULL;
	}
	strcpy(wn->word, word); // Now copy the word into the structure.
	return wn;
}

// Helper function. Accepts a word and the pointer to the head of the word list, provides
//  (i)  The node for the word (if the word is already in the list)
//  (ii) The parent node (after which the new word can be placed.)
void locateWordPos(char *word, struct WordNode *wordListHead, struct WordNode **wordNode, struct WordNode **parent)
{
	*wordNode = NULL; *parent = NULL;
	if(wordListHead == NULL) // word list is empty
		return;
	
	while(wordListHead != NULL)
	{
		int wcmp = strcmp(wordListHead->word, word);
		if(wcmp == 0) // This node is associated with the word;
		{
			*wordNode = wordListHead; // store this node's information;
			return;
		}
		if(wcmp > 0) // We went past the word's possible position -> means word is not in the list.
			return;
		// Move to the next word in the list.
		*parent = wordListHead; wordListHead = wordListHead->next;
	}
}

// Called to add a word/count
// If the word already exists, the counter for that word is incremented.
//  Otherwise a new word is added at the appropriate position.
struct WordNode *addWord(char* word, struct WordNode *wordListHead, int* outofmemory)
{
	struct WordNode *wn=NULL, *wnParent=NULL;
	locateWordPos(word, wordListHead, &wn, &wnParent);

	if(wn != NULL) // we found the word
		wn->count++;
	else // word is not in the list, need to add it.
	{
		struct WordNode *nw = makeNode(word); //make a new word node.
		if(nw == NULL)	// cannot add a new node, we are out of memory.
		{
			*outofmemory = 1;
			return wordListHead;
		}
		nw->count = 1;

		// Now to plug this word into the list.
		if(wnParent == NULL) // This word should go in the beginning
		{
			nw->next = wordListHead;
			wordListHead = nw;
		}
		else // This word should go in after the node returned by locateWordPos
		{
			nw->next = wnParent->next;
			wnParent->next = nw;
		}
	}

	return wordListHead;
}

// Goes over the list of words and prints the word and count
//  the contents will be displayed in the alphabetical order of the words.
void printWordList(struct WordNode *wordListHead)
{
	while(wordListHead != NULL)
	{
		fprintf(stdout, "%s %lu\n", wordListHead->word, wordListHead->count);
		wordListHead = wordListHead->next;
	}
}

// Free up the memory used by the nodes.
void deleteList(struct WordNode *wordListHead)
{
	while(wordListHead != NULL)
	{
		struct WordNode *next = wordListHead->next; // get the pointer to the next node.
		free(wordListHead->word); // Free the character array.
		free(wordListHead);	// Free the node itself.
		wordListHead = next;
	}
}
