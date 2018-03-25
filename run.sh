$(yacc -d bibtex.y)
$(lex bibtex.l)
$(gcc y.tab.c lex.yy.c `mysql_config --cflags --libs`)
$(./a.out < input.txt)
