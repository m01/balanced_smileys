%{
#include "grammar.tab.h"
%}

/* only scan 1 file */
%option noyywrap reentrant

%%

[0-9]+ {return NUMBER; }
[a-z ]+ { return LETTERS; }
"("    { return OPEN_PAREN; }
")"    { return CLOSE_PAREN; }
[\r\n]+ { return EOL; }
":"    { return COLON; }
[ \t]+  { }
<<EOF>> { return 0; }

%%
