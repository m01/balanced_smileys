all: solver

CFLAGS=-ggdb
BISON=/usr/local/opt/bison/bin/bison

grammar.tab.c: grammar.y
	$(BISON) -d grammar.y

lex.yy.c: lex.l
	flex --header-file=lex.h lex.l

solver: grammar.tab.c lex.yy.c main.c
	gcc $(CFLAGS) -o solver lex.yy.c grammar.tab.c main.c

clean:
	rm -f *.tab.* solver lex.yy.c lex.h
	rm -rf *.dSYM
