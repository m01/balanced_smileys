%code requires {
}

%{
#include <stdio.h>

#define YYMAXDEPTH 20000

#define YYDEBUG 0 //set to 1 to enable debugs.
#define YYSTYPE int

extern int print_errors;
int all_good_ignore_result;

int yylex(); 
int yyerror(void* scanner, const char *p) {
    if (strcmp("syntax is ambiguous", p) == 0
	|| strcmp("Ambiguity detected.", p) == 0) {
	/* ah that's fiiine! - as long as both are valid! */
	all_good_ignore_result = 1;
    }
    if (print_errors) {
	printf("Error: %s\n", p);
    }
}

int i = 1;

%}

%token NUMBER LETTERS OPEN_PAREN CLOSE_PAREN COLON EOL

/* handle ambiguities */
%glr-parser

%error-verbose

%parse-param {void* scanner}
%lex-param   {void* scanner }

%% /* grammar */

line: messages EOL  {  }
      | EOL

/* atomics */
text : LETTERS
     | COLON

smile : COLON CLOSE_PAREN

frown : COLON OPEN_PAREN

messages: balanced_message
      | messages balanced_message

balanced_message: OPEN_PAREN messages CLOSE_PAREN
      | OPEN_PAREN CLOSE_PAREN /* empty */
      | smile
      | frown
      | text


%%

