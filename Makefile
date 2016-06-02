all: yacc lex
	gcc -o grammar lex.yy.c y.tab.c main.c

yacc:
	yacc -d grammar.y

lex:
	lex -l lex.l
