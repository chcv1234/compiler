;.source
.class public static myResult
.super java/lang/Object
.method public static main([Ljava/lang/String;)V
.limit stack 100
.limit locals 100
ldc 10.0
f2i
istore 0
ldc 2.0
f2i
istore 1
ldc 0.0
f2i
istore 2
L1:
iload 2
i2f
ldc 10.0
fcmpl
ifge L2
iload 2
i2f
ldc 1.0
fadd
f2i
istore 2
iload 0
i2f
iload 1
i2f
fadd
f2i
istore 0
goto L1
L2:
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "a="
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
getstatic java/lang/System/out Ljava/io/PrintStream;
iload 0
i2f
f2i
invokevirtual java/io/PrintStream/print(I)V
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "\n"
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
L3:
iload 2
i2f
ldc 0.0
fcmpl
ifeq L4
iload 0
i2f
iload 1
i2f
fsub
f2i
istore 1
iload 2
i2f
ldc 1.0
fsub
f2i
istore 2
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "test\n"
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
goto L3
L4:
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "b="
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
getstatic java/lang/System/out Ljava/io/PrintStream;
iload 1
i2f
f2i
invokevirtual java/io/PrintStream/print(I)V
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "\n"
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
iload 0
i2f
iload 1
i2f
fdiv
f2i
istore 0
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "a="
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
getstatic java/lang/System/out Ljava/io/PrintStream;
iload 0
i2f
f2i
invokevirtual java/io/PrintStream/print(I)V
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "\n"
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
return
.end method
