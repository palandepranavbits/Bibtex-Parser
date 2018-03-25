%{
void yyerror(char *s);
#include <stdio.h>
#include <stdlib.h>
#include<string.h>
#include<mysql/mysql.h>
void connectDB();
void insertIntoDB();
void clearString();
void insertIntoArray(char *name,char *value);
void closeDB();
char strar[15][50];
char tempval[100];
char tempkey[100];
MYSQL *conn;
void connectDB();
%}
%union {int num; char* str;}
%start bibfile
%token <str> NAME
%token <str> EQUALS
%token <str> LBRACE
%token <str> RBRACE
%token <str> COMMA
%token <str> STRING
%token <str> NUMBER
%token <str> AT
%token <str> JUNK
%token <str> COMMENT
%token <str> QUOTE
%token <str> HASH
%token <str> LPAREN
%token <str> RPAREN
%token <str> NEWLINE
%token <str> ENDOFFILE

%%

bibfile :  entries  {;} ;

entries : entry NEWLINE entries	{;}
		| entry	 ENDOFFILE { closeDB();exit(EXIT_SUCCESS);}
		| entry	 NEWLINE { closeDB();exit(EXIT_SUCCESS);}
		;

entry 	: AT NAME LBRACE key COMMA fields RBRACE {/*insert into DB and clear string array*/
													insertIntoArray("bibkey",tempkey);
													insertIntoDB();
													clearString();};

key   	:  NAME	{strcpy(tempkey,$1);} 
		|   NUMBER	{strcpy(tempkey,$1);}
		;
fields 	:  field COMMA fields	{;}
		|  field	{;}
		;
field 	: NAME EQUALS LBRACE value RBRACE	{printf("$1 is %s, tempval is %s\n",$1,tempval);insertIntoArray($1,tempval);}
		;
value 	: STRING	{printf("String in yacc, %s\n",$1);strcpy(tempval,$1);printf("Tempval :%s\n",tempval);}	
		| NUMBER	{printf("Number in yacc %s\n",$1);strcpy(tempval,$1);printf("Tempval :%s\n",tempval);}
		| NAME		{printf("Name in yacc %s\n",$1);strcpy(tempval,$1);printf("Tempval :%s\n",tempval);}
		;


%%

void yyerror(char *s){
	printf("%s\n",s);
}


void connectDB(){
	 MYSQL_RES *res;
      MYSQL_ROW row;

      char *server = "localhost";
      char *user = "root";
      //set the password for mysql server here
      char *password = "pranav123"; /* set me first */
      char *database = "newdb";

      conn = mysql_init(NULL);

      /* Connect to database */
      if (!mysql_real_connect(conn, server,
            user, password, database, 0, NULL, 0)) {
          fprintf(stderr, "%s\n", mysql_error(conn));
          exit(1);
      }

  if (mysql_query(conn, "DROP TABLE IF EXISTS bibtex")) {
      fprintf(stderr, "%s\n", mysql_error(conn));
  }
  
  if (mysql_query(conn, "create table bibtex(bibkey varchar(50) primary key not null,bibtype varchar(50) not null,address varchar(255),author varchar(255) not null, booktitle varchar(255), chapter varchar(50), edition varchar(25), journal varchar(100), number varchar(25), pages varchar(25),publisher varchar(100),school varchar(100),title varchar(255),volume varchar(50),year varchar(25))")) {      
      fprintf(stderr, "%s\n", mysql_error(conn));
  }
	//mysql_free_result(res);
}

void insertIntoDB(){
	char q[10000] ;
	printf("Inside insertIntoDB()\n");
	//sprintf(q,"INSERT INTO Bibtex VALUES(%d,'%s',%d)",id,name,price);
  sprintf(q,"INSERT INTO bibtex VALUES('%s', '%s','%s' ,'%s', '%s', '%s','%s' ,'%s' , '%s' , '%s' , '%s' ,'%s' ,'%s' ,'%s' ,'%s' )",strar[0],strar[1],strar[2],strar[3],strar[4],strar[5],strar[6],strar[7],strar[8],strar[9],strar[10], strar[11],strar[12],strar[13],strar[14]);
	printf("%s\n",q);
	if (mysql_query(conn, q)) {
	  fprintf(stderr, "%s\n", mysql_error(conn));
  }
}

void clearString(){
	  /*initialise all strings to null*/
	  for (int i = 0; i < 15; i++)
	  {
			strar[i][0] = '\0';
	  }
}

void insertIntoArray(char* name,char* value){
	
	if(!strcmp(name,"bibkey")){
		printf("Found match\n");
		int i = 0;		
		for(i = 0 ; i < strlen(value); i++){
			strar[0][i] = value[i];		
		}
		strar[0][i] = '\0';
		printf("%s\n",strar[0]);
		
	}

	if(!strcmp(name,"bibtype")){
		printf("Found match\n");
		int i = 0;		
		for(i = 0 ; i < strlen(value); i++){
			strar[1][i] = value[i];		
		}
		strar[1][i] = '\0';
		printf("%s\n",strar[1]);
		
	}

	if(!strcmp(name,"address")){
		printf("Found match\n");
		int i = 0;		
		for(i = 0 ; i < strlen(value); i++){
			strar[2][i] = value[i];		
		}
		strar[2][i] = '\0';
		printf("%s\n",strar[2]);
		
	}

	if(!strcmp(name,"author")){
		printf("Found match\n");
		int i = 0;		
		for(i = 0 ; i < strlen(value); i++){
			strar[3][i] = value[i];		
		}
		strar[3][i] = '\0';
		printf("%s\n",strar[3]);
		
	}

	if(!strcmp(name,"booktitle")){
		printf("Found match\n");
		int i = 0;		
		for(i = 0 ; i < strlen(value); i++){
			strar[4][i] = value[i];		
		}
		strar[4][i] = '\0';
		printf("%s\n",strar[4]);
		
	}

	if(!strcmp(name,"chapter")){
		printf("Found match\n");
		int i = 0;		
		for(i = 0 ; i < strlen(value); i++){
			strar[5][i] = value[i];		
		}
		strar[5][i] = '\0';
		printf("%s\n",strar[5]);
		
	}

	if(!strcmp(name,"edition")){
		printf("Found match\n");
		int i = 0;		
		for(i = 0 ; i < strlen(value); i++){
			strar[6][i] = value[i];		
		}
		strar[6][i] = '\0';
		printf("%s\n",strar[6]);
		
	}

	if(!strcmp(name,"journal")){
		printf("Found match\n");
		int i = 0;		
		for(i = 0 ; i < strlen(value); i++){
			strar[7][i] = value[i];		
		}
		strar[7][i] = '\0';
		printf("%s\n",strar[7]);
		
	}

	if(!strcmp(name,"number")){
		printf("Found match\n");
		printf("Found match\n");
		int i = 0;		
		for(i = 0 ; i < strlen(value); i++){
			strar[8][i] = value[i];		
		}
		strar[8][i] = '\0';
		printf("%s\n",strar[8]);
	}

	if(!strcmp(name,"pages")){
		printf("Found match\n");
		int i = 0;		
		for(i = 0 ; i < strlen(value); i++){
			strar[9][i] = value[i];		
		}
		strar[9][i] = '\0';
		printf("%s\n",strar[9]);
		
	}

	if(!strcmp(name,"publisher")){
		printf("Found match\n");
		int i = 0;		
		for(i = 0 ; i < strlen(value); i++){
			strar[10][i] = value[i];		
		}
		strar[10][i] = '\0';
		printf("%s\n",strar[10]);
		
	}

	if(!strcmp(name,"school")){
		printf("Found match\n");
		int i = 0;		
		for(i = 0 ; i < strlen(value); i++){
			strar[11][i] = value[i];		
		}
		strar[11][i] = '\0';
		printf("%s\n",strar[11]);
		
	}
	if(!strcmp(name,"title")){
		printf("Found match\n");
		int i = 0;		
		for(i = 0 ; i < strlen(value); i++){
			strar[12][i] = value[i];		
		}
		strar[12][i] = '\0';
		printf("%s\n",strar[12]);
		
	}

	if(!strcmp(name,"volume")){
		printf("Found match\n");
		int i = 0;		
		for(i = 0 ; i < strlen(value); i++){
			strar[13][i] = value[i];		
		}
		strar[13][i] = '\0';
		printf("%s\n",strar[13]);
		
	}

	if(!strcmp(name,"year")){
		printf("Found match\n");
		int i = 0;		
		for(i = 0 ; i < strlen(value); i++){
			strar[14][i] = value[i];		
		}
		strar[14][i] = '\0';
		printf("%s\n",strar[14]);
		
	}
}

void closeDB(){
	/*Closes connection to DB*/
	printf("Inside closeDB()\n");
	mysql_close(conn);
}

int main(){
	/*code for connecting DB and clear string array*/
	connectDB();
	clearString();
	yyparse();
}
