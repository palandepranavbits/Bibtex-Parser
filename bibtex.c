#include<stdio.h>
#include<mysql/mysql.h>

void insertIntoDB(MYSQL *conn,char * strar[15]){
	char q[10000] ;
	//sprintf(q,"INSERT INTO Bibtex VALUES(%d,'%s',%d)",id,name,price);
  sprintf(q,"INSERT INTO bibtex VALUES('%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s')",strar[0],strar[1],strar[2],strar[3],strar[4],strar[5],strar[6],strar[7],strar[8],strar[9],strar[10], strar[11],strar[12],strar[13],strar[14]);
	if (mysql_query(conn, q)) {
      fprintf(stderr, "%s\n", mysql_error(conn));
  }
}
void clearString(char * strar[15]){
  for (int i = 0; i < 15; i++)
  {
    strar[i] = NULL;
  }
}
int main(int argc, char const *argv[])
{
	/* code */
	MYSQL *conn;
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
    char *strar[15]={"aa","aa","aa","aa","aa","aa","aa","aa","aa","aa","aa","aa","aa","aa",NULL};

    insertIntoDB(conn,strar);

     mysql_free_result(res);
     mysql_close(conn);
	return 0;
}
