%{

/* Declarations section */
#include <stdio.h>
#include <stdlib.h>
#include "output.hpp"
#include "parser.tab.hpp"
using namespace std;
using namespace output;
%}

%option yylineno 
%option noyywrap
%x comment


relop           (>=|<=|<|>)
equalop			(==|!=)
mult 			([*])
div				([/])
plus			([+])
minus			([-])
digit   		([0-9])
letter			([a-zA-Z])
id  			([a-zA-Z][a-zA-Z0-9]*)
whitespace		([\r\t\n ])

%%
{whitespace}+				;
void                        return VOID;
int                        return INT;
byte                        return BYTE;
b                        return B;
bool                        return BOOL;
and                        return AND;
or                        return OR;
not                        return NOT;
true                        return TRUE;
false                     return FALSE;
return                        return RETURN;
if                        return IF;
else                        return ELSE;
while                        return WHILE;
break                        return BREAK;
continue                        return CONTINUE;
switch                        return SWITCH;
case                        return CASE;
default                        return DEFAULT;
:                        return COLON;
;                        return SC;
,                        return COMMA;
\(                        return LPAREN;
\)                        return RPAREN;
\{                        return LBRACE;
\}                        return RBRACE;
=                        return ASSIGN;
{relop}                        return RELOP;
{equalop}						return EQUALOP;
{mult}							return MULT;
{div}							return DIV;
{plus}							return PLUS;
{minus}							return MINUS;
"//"[^\r|\n]*         BEGIN(comment);
<comment>{
	\r		{BEGIN(INITIAL);}
	\n		{BEGIN(INITIAL);}
	<<EOF>>	{BEGIN(INITIAL);}
	}
	
{id}+ return ID;
0 return NUM;
[1-9]+{digit}* return NUM;
\"([^\n\r\"\\]|\\[rnt"\\])+\" 	return STRING;
.		{
			errorLex(yylineno);
		}

%%
/* c code */


