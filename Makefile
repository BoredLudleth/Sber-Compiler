all: flex compile

flex: flex.l
	flex flex.l

compile: lex.yy.c
	g++ lex.yy.c

clean:
	rm *.out lex.yy.c