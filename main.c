#include <stdio.h>

extern int yyparse();

int main(int argc, char **argv) {
    if (argc != 2) {
        printf("no input files\n");
        printf("usage: %s source\n", argv[0]);
        return 1;
    }
    if (!freopen(argv[1], "r", stdin)) {
        printf("could not open file: %s\n", argv[1]);
        return 1;
    }
    int res = yyparse();
    if (!res) {
        printf("\n\n\nSyntax is valid\n");
    }
}
