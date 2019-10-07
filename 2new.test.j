;.source
.class public static myResult
.super java/lang/Object
.method public static main([Ljava/lang/String;)V
.limit stack 100
.limit locals 100
ldc 4.0
f2i
istore 0
ldc 5.5
fstore 1
fload 1
ldc 3.14
fcmpl
ifle L1
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "D is "
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
getstatic java/lang/System/out Ljava/io/PrintStream;
fload 1
invokevirtual java/io/PrintStream/print(F)V
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "\n"
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
goto L2
L1:
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "D is smaller than 3.14\n"
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
L2:
iload 0
i2f
ldc 5.0
fcmpl
ifle L3
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "C is "
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
getstatic java/lang/System/out Ljava/io/PrintStream;
iload 0
i2f
f2i
invokevirtual java/io/PrintStream/print(I)V
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "\n"
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
goto L4
L3:
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "C is smaller than 5\n"
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
L4:
iload 0
i2f
ldc 7.0
fcmpl
ifne L5
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "test\n"
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
goto L6
L5:
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "1test\n"
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
L6:
fload 1
ldc 2.5
fcmpl
ifeq L7
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "test2\n"
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
goto L8
L7:
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "2test\n"
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
L8:
return
.end method
