#include <stdio.h>

int stack[100000];
int top;

int pop()
{
    if ( top == 0 ) return 0;
    int x = stack[--top];
    return x;
}

void push(int x)
{
    stack[top++] = x;
}

int main(int argc, char** argv)
{
    char code[25][80];
    char buf[85];
    enum { R = 0, D = 1, L = 2, U = 3 } d;
    FILE *f = fopen(argv[1], "r");

    int i, j;
    for( i=0; i<25; i++ )
        for( j=0; j<80; j++ )
            code[i][j] = ' ';

    i = 0;
    while( fgets(buf, 85, f) )
    {
        for( j=0; buf[j] && j<80; j++ )
            code[i][j] = buf[j];
        i++;
    }

    d = R;
    i = j = 0;
    top = 0;
    int inStr = 0;
    int skip = 0;
    int terminated = 0;
    int a, b, c, v;
    char ch;
    for( ; ; )
    {
        int st = 0;
#ifdef DEBUG
        for( st=0; st<top; st++ ) fprintf(stderr, "%d ", stack[st]);
        fprintf(stderr, "\n");
#endif
        if ( !skip )
        {
            c = code[i][j];

            if ( inStr )
            {
                if ( c == '"' ) inStr = 0;
                else push(c);
            }
            else
            {
                switch( c )
                {
                    // constant
                    case '0':case '1':case '2':case '3':case '4':
                    case '5':case '6':case '7':case '8':case '9':
                        push(c-'0');
                        break;
                    case '"': inStr = 1; break;

                    // arithmetic
                    case '+': a = pop(); b = pop(); push(a+b); break;
                    case '-': a = pop(); b = pop(); push(b-a); break;
                    case '*': a = pop(); b = pop(); push(a*b); break;
                    case '/': a = pop(); b = pop(); push(b/a); break;
                    case '%': a = pop(); b = pop(); push(b%a); break;

                    // boolean
                    case '!': a = pop(); push(!a);  break;
                    case '`': a = pop(); b = pop(); push(b>a); break;

                    // movement
                    case '>': d = R; break;
                    case '<': d = L; break;
                    case 'v': d = D; break;
                    case '^': d = U; break;
                    case '?': d = rand() % 4; break;
                    case '_': a = pop(); d = a ? L : R; break;
                    case '|': a = pop(); d = a ? U : D; break;
                    case '#': skip = 1; break;

                    // stack
                    case ':': a = pop(); push(a); push(a); break;
                    case '\\': a = pop(); b = pop(); push(a); push(b); break;
                    case '$': pop(); break;

                    // io
                    case '.': a = pop(); printf("%d", a); break;
                    case ',': a = pop(); printf("%c", a); break;
                    case '&': scanf("%d", &a); push(a); break;
                    case '~': scanf("%c", &ch); a = ch; push(a); break;

                    // code change
                    case 'p': b = pop(); a = pop(); v = pop(); code[a][b] = v; break;
                    case 'g': b = pop(); a = pop(); push(code[a][b]); break;

                    case '@': terminated = 1; break;

                    // other -> comment
                    default: break;
                }
            }
        }
        else
        {
            skip = 0;
        }

        if ( terminated ) break;

        if ( d == R ) j = (j+1) % 80;
        if ( d == L ) j = (j+79) % 80;
        if ( d == U ) i = (i+24) % 25;
        if ( d == D ) i = (i+1) % 25;
    }
    return 0;
}

