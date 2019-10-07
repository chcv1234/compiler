;.source
.class public static myResult
.super java/lang/Object
.method public static main([Ljava/lang/String;)V
.limit stack 100
.limit locals 100
ldc 5.0
f2i
istore 0
iload 0
i2f
ldc 10.0
fcmpl
ifle L1
ldc 3.0
iload 0
i2f
ldc 3.14
fadd
fmul
fstore 1
goto L2
L1:
iload 0
i2f
iload 0
i2f
ldc 3.14
fsub
fmul
fstore 1
L2:
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "The result is "
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
getstatic java/lang/System/out Ljava/io/PrintStream;
fload 1
invokevirtual java/io/PrintStream/print(F)V
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc " test \n"
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
return
.end method
