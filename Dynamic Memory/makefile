wcloud : wcloud.o wordlist.o
	gcc -o wcloud wcloud.o wordlist.o

wcloud.o: wcloud.c wordlist.h
	gcc -c wcloud.c

wordlist.o: wordlist.c
	gcc -c wordlist.c

clean:
	rm -f wcloud wcloud.o wordlist.o
