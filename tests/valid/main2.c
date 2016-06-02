extern int yyparse();

int max(int num1, int num2);

int main(int argc, char **argv) {
    printf("%d\n", max(1, 2));
}

/* function returning the max between two numbers */
int max(int num1, int num2) {

   /* local variable declaration */
   int result;
 
   if (num1 > num2)
      result = num1;
   else
      result = num2;
 
   return result; 
}
