#include <stdio.h>

unsigned char a[32768];
char code[65536];
int main(int argc, char**argv)
{
	char c;
	int p = 0, i, k = 0;
	int pass = 0;
	if ( argc < 2 ) { puts("Give a filename!"); return 1; }
	FILE *f = fopen(argv[1], "r");

	while( (c=fgetc(f))!=EOF ) code[k++] = c;

	for( i=0; i<k; i++ )
	{
		c = code[i];
		if ( c!=']' && pass ) continue;
		switch( c )
		{
			case '+' : a[p]++; break;
			case '-' : a[p]--; break;
			case '>' : p++; break;
			case '<' : p--; break;
			case '.' : putchar(a[p]); break;
			case ',' : a[p] = getchar(); break;
			case '[' : if ( a[p]==0 ) pass = 1; break;
			case ']' :
						   if ( pass ) pass = 0;
						   else
						   {
							   int cnt = 1;
							   while( cnt )
							   {
								   i--;
								   if ( code[i] == ']' ) cnt++;
								   if ( code[i] == '[' ) cnt--;
							   }
							   i--;
						   }
						   break;
			default: break;
		}
#ifdef ebug
		int j;
		for( j=0; j<10; j++ )
			printf("%3d", a[j]);
		printf("  (pass = %d)\n", pass);
		for( j=0; j<3*p+2; j++ )
			printf(" ");
		printf("^\n");
#endif

	}
	return 0;
}

