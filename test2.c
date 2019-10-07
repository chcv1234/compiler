void main()
{
   int a;
   int b;
   int i;
	a=10;
	b=2;
	for(i=0;i<10;i=i+1) {
		a=a+b;
	}
	printf("a=%d\n",a);
	
	while(i!=0) {
		b=a-b;
		i=i-1;
		printf("test\n");
	}
	printf("b=%d\n",b);

	a = a/b ;

	printf("a=%d\n",a);
   
}
