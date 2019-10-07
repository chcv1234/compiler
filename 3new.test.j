;.source
.class public static myResult
.super java/lang/Object
.method public static main([Ljava/lang/String;)V
.limit stack 100
.limit locals 100
ldc 1.0
f2i
istore 0
ldc 9.0
f2i
istore 1
iload 0
i2f
iload 1
i2f
fadd
ldc 11.0
fcmpl
ifle L1
iload 1
i2f
iload 0
i2f
ldc 3.5
fadd
fmul
fstore 2
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "num is bigger than 10\n"
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
goto L2
L1:
iload 1
i2f
iload 1
i2f
ldc 3.5
fadd
fmul
fstore 2
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "num is smaller than 10\n"
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
L2:
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "s is "
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
getstatic java/lang/System/out Ljava/io/PrintStream;
fload 2
invokevirtual java/io/PrintStream/print(F)V
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "\n"
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
return
.end method
