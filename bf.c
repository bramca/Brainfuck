#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define ALENGTH(x) (sizeof(x) / sizeof((x)[0]))

int checkLoop(int loop,char** inputLoop,char ch){
    if(loop>0){
        **inputLoop = ch;
        (*inputLoop)++;
        return 1;
    }
    return 0;
}

void executeLoop(char* inputLoop,int length,char** ptr){
    int loop2 = 0;
    char inputLoop2[10000] = {0};
    char* ptrInput2 = inputLoop2;
    int innerloops2 = 0;
    int i = 0;

    while(i < length && inputLoop[i] != 0){
        if(inputLoop[i] == '>' && !checkLoop(loop2,&ptrInput2,inputLoop[i])){
            (*ptr)++;
        }else if(inputLoop[i] == '+' && !checkLoop(loop2,&ptrInput2,inputLoop[i])){
            (**ptr)++;
        }else if(inputLoop[i] == '-' && !checkLoop(loop2,&ptrInput2,inputLoop[i])){
            (**ptr)--;
        }else if(inputLoop[i] == '<' && !checkLoop(loop2,&ptrInput2,inputLoop[i])){
            (*ptr)--;
        }else if(inputLoop[i] == ',' && !checkLoop(loop2,&ptrInput2,inputLoop[i])){
            (**ptr) = getchar();
        }else if(inputLoop[i] == '.' && !checkLoop(loop2,&ptrInput2,inputLoop[i])){
            putchar(**ptr);
        }else if(inputLoop[i] == '['){
            if(!checkLoop(loop2,&ptrInput2,inputLoop[i])){
                loop2 = 1;
            }else{
                innerloops2++;
            }
        }else if(inputLoop[i] == ']'){
            if(innerloops2 > 0){
                checkLoop(loop2,&ptrInput2,inputLoop[i]);
                innerloops2--;
            }else{
                while(**ptr > 0){
                    executeLoop(inputLoop2,sizeof(inputLoop2),ptr);
                }
                loop2 = 0;
                memset(&inputLoop2[0],0,sizeof(inputLoop2));
                ptrInput2 = &inputLoop2[0];
            }
        }
        
        i++;
    }
}

int main(int argc, char *argv[]){
    FILE *fptr;
    char tape[30000] = {0};
    char* ptr = tape;
    char inputLoop[10000] = {0};
    char* ptrInput = inputLoop;
    char ch;
    int loop = 0;
    int innerloops = 0;

    if ((fptr = fopen(argv[argc-1], "r")) == NULL)
    {
        printf("Error! opening file");
        /* Program exits if file pointer returns NULL. */
        exit(1);         
    }

    ch = getc(fptr);

    putchar('\n');

    while(ch != EOF){
        if(ch == '>'){
            if(!checkLoop(loop,&ptrInput,ch)){
                ptr++;
            }
        }else if(ch == '+'){
            if(!checkLoop(loop,&ptrInput,ch)){
                (*ptr)++;
            }
        }else if(ch == '-'){
            if(!checkLoop(loop,&ptrInput,ch)){
                (*ptr)--;
            }
        }else if(ch == '<'){
            if(!checkLoop(loop,&ptrInput,ch)){
                ptr--;
            }
        }else if(ch == '.'){
            if(!checkLoop(loop,&ptrInput,ch)){
                putchar(*ptr);
            }
        }else if(ch == ','){
            if(!checkLoop(loop,&ptrInput,ch)){
                *ptr = getchar();
            }
        }else if(ch == '['){
            if(!checkLoop(loop,&ptrInput,ch)){
                loop = 1;
            }else{
                innerloops++;
            }
        }else if(ch == ']'){
            if(innerloops > 0){
                checkLoop(loop,&ptrInput,ch);
                innerloops--;
            }else{
                while(*ptr > 0){
                    executeLoop(inputLoop,sizeof(inputLoop),&ptr);
                }
                loop = 0;

                memset(&inputLoop[0],0,sizeof(inputLoop));
                ptrInput = &inputLoop[0];
            }
        }
        ch = getc(fptr);
    }
    return 0;
}

