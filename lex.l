%{
#include <stdio.h>
#include "y.tab.h"

void count();

int line = 1;
int column = 0;
%}
%option noyywrap
%x C_COMMENT

%%

[ \t\v\f]					{count(); }
[\n]					{count(); ++line; } 

"abstract"				{ count(); return(ABSTRACT); }
"boolean"				{ count(); return(BOOLEAN); }
"break"					{ count(); return(BREAK); }
"byte"					{ count(); return(BYTE); }
"case"					{ count(); return(CASE); }
"catch"					{ count(); return(CATCH); }
"char"					{ count(); return(CHAR); }
"class"					{ count(); return(CLASS); }
"const"					{ count(); return(CONST); }
"continue"				{ count(); return(CONTINUE); }
"default"				{ count(); return(DEFAULT); }
"do"					{ count(); return(DO); }
"double"				{ count(); return(DOUBLE); }
"else"					{ count(); return(ELSE); }
"extends"				{ count(); return(EXTENDS); }
"final"					{ count(); return(FINAL); }
"finally"				{ count(); return(FINALLY); }
"float"					{ count(); return(FLOAT); }
"for"					{ count(); return(FOR); }
"if"					{ count(); return(IF); }
"goto"					{ count(); return(GOTO); }
"implements"			{ count(); return(IMPLEMENTS); }
"import"				{ count(); return(IMPORT); }
"instanceof"			{ count(); return(INSTANCEOF); }
"int"					{ count(); return(INT); }
"interface"				{ count(); return(INTERFACE); }
"long"					{ count(); return(LONG); }
"native"				{ count(); return(NATIVE); }
"new"					{ count(); return(NEW); }
"package"				{ count(); return(PACKAGE); }
"private"				{ count(); return(PRIVATE); }
"protected"				{ count(); return(PROTECTED); }
"public"				{ count(); return(PUBLIC); }
"return"				{ count(); return(RETURN); }
"short"					{ count(); return(SHORT); }
"static"				{ count(); return(STATIC); }
"super"					{ count(); return(SUPER); }
"switch"				{ count(); return(SWITCH); }
"synchronized"			{ count(); return(SYNCHRONIZED); }
"this"					{ count(); return(THIS); }
"throw"					{ count(); return(THROW); }
"throws"				{ count(); return(THROWS); }
"transient"				{ count(); return(TRANSIENT); }
"try"					{ count(); return(TRY); }
"void"					{ count(); return(VOID); }
"volatile"				{ count(); return(VOLATILE); }
"while"					{ count(); return(WHILE); }

[a-zA-Z_][a-zA-Z0-9_]* 	{ count(); return(IDENTIFIER ); }
[0-9]+					{ count(); return(LITERAL ); }

"("						{ count(); return('('); }
")"						{ count(); return(')'); }
"{"						{ count(); return('{'); }
"}"						{ count(); return('}'); }
"["						{ count(); return('['); }
"]"						{ count(); return(']'); }
";"						{ count(); return(';'); }
","						{ count(); return(','); }
"."						{ count(); return('.'); }

"="						{ count(); return('='); }
">"						{ count(); return('>'); }
"<"						{ count(); return('<'); }
"!"						{ count(); return('!'); }
"~"						{ count(); return('~'); }
"?"						{ count(); return('?'); }
":"						{ count(); return(':'); }
"=="					{ count(); return(OP_EQ); }
"<="					{ count(); return(OP_LE); }
">="					{ count(); return(OP_GE); }
"!="					{ count(); return(OP_NE); }
"&&"					{ count(); return(OP_LAND); }
"||"					{ count(); return(OP_LOR); }
"++"					{ count(); return(OP_INC); }
"--"					{ count(); return(OP_DEC); }
"+"						{ count(); return('+'); }
"-"						{ count(); return('-'); }
"*"						{ count(); return('*'); }
"/"						{ count(); return('/'); }
"&"						{ count(); return('&'); }
"|"						{ count(); return('|'); }
"^"						{ count(); return('^'); }
"%"						{ count(); return('%'); }

"+="					{ count(); return(ASS_ADD); }
"-="					{ count(); return(ASS_SUB); }
"*="					{ count(); return(ASS_MUL); }
"/="					{ count(); return(ASS_DIV); }
"%="					{ count(); return(ASS_MOD); }
"&="					{ count(); return(ASS_AND); }
"|="					{ count(); return(ASS_OR); }
"^="					{ count(); return(ASS_XOR); }
"<<="					{ count(); return(ASS_SHL); }
">>="					{ count(); return(ASS_SHR); }
">>>="					{ count(); return(ASS_SHRR); }

"@"						{ count(); return('@'); }

[a-zA-Z_]?\"(\\.|[^\\"])*\"		{ count(); return(LITERAL ); }

"/*"            { BEGIN(C_COMMENT); }
<C_COMMENT>"*/" { BEGIN(INITIAL); }
<C_COMMENT>"\n" { ++line; }
<C_COMMENT>.    { }

"//"[^\r\n]*            

.						printf("Unknown token at line %d: %s\n", line, yytext); YY_FATAL_ERROR("");

%%

void count()
{
	int i;

	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n')
			column = 0;
		else if (yytext[i] == '\t')
			column += 8 - (column % 8);
		else
			column++;

	ECHO;
}

