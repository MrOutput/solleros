extern int main(int argc, char *argv[]);
char *__env[1] = { 0 };
char **environ = __env;
void _start()
{
	unsigned int addr;
	unsigned int endaddr;
	unsigned int variables;
	unsigned int varnum;
	int argc;
	asm("movb $15, %%ah\n\t"
		"int $0x30"
		: "=D" (endaddr), "=S" (addr), "=c" (argc), "=a" (variables), "=b" (varnum)
		:
		: "%edx"
		);
    char args[argc][256];
	int i = 0;
	int n = 0;
	char c = 0;
	while(addr<=endaddr){
		c = *(char*)(void*)(addr);
		if(c==' '){
			args[i][n]=0;
			n=0;
			i++;
		}else{
			args[i][n]=c;
			n++;
		}
		if(c==0){
			args[i][n]=0;
			addr=endaddr;
		}
		addr++;
	}
	exit(main(argc, args));
}
