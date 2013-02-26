#include "grammar.tab.h"
#include "lex.h"
#include <string.h>
#include <assert.h>

#ifdef YYDEBUG
extern int yydebug;
#endif
extern int all_good_ignore_result;
int print_errors;
//typedef void* yyscan_t;

int analyse(char * str, size_t len)
{
    all_good_ignore_result = 0;
    yyscan_t scan;
    YY_BUFFER_STATE buffer;
    int result = -1;
    yylex_init(&scan);
    buffer = yy_scan_string(str, scan);
    //yylex(scan);
    result = yyparse(scan);
    yy_delete_buffer(buffer, scan);
    yylex_destroy(scan);

    if (all_good_ignore_result) {
	result = 0;
    }
    return result;
}


int main()
{
    print_errors=0;
#if YYDEBUG == 1
    yydebug=1;
    print_errors=1;
#endif
    char buf[200];
    bzero(buf, sizeof(buf)); 

    int n, i, result;
    scanf("%d", &n);

    fgets(buf, sizeof(buf), stdin);
    assert(strcmp(buf, "\n") == 0);

    for (i = 0; i < n; i++) {
	bzero(buf, sizeof(buf));
	fgets(buf, sizeof(buf), stdin);
	result = analyse(buf, sizeof(buf));
	printf("Case #%d: %s\n", i+1, result == 0 ? "YES":(result==2?"OOM":"NO"));
    }
/*
    strncpy(buf, "i am sick today (:()\n", sizeof(buf));
    analyse(buf, sizeof(buf));

    strncpy(buf, ":((\n", sizeof(buf));
    analyse(buf, sizeof(buf));
*/

    return 0;
}
