output : y.tab.c lex.yy.c
	gcc -o output y.tab.c lex.yy.c `mysql_config --cflags --libs`
	@echo executable created
lex.yy.c : bibtex.l
	lex bibtex.l
	@echo intermediate file generated by lex	
y.tab.c y.tab.h : bibtex.y
	yacc -d bibtex.y
	@echo intermediate file generated by bison
clean :
	rm y.tab.c y.tab.h lex.yy.c output
	@echo clean complete