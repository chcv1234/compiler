;.source
.class public static myResult
.super java/lang/Object
.method public static main([Ljava/lang/String;)V
.limit stack 100
.limit locals 100
ldc 0.0
f2i
istore 0
L1:
iload 0
i2f
ldc 3.0
fcmpl
ifge L2
iload 0
i2f
ldc 1.0
fadd
f2i
istore 0
getstatic java/lang/System/out Ljava/io/PrintStream;
ldc "test\n"
invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
goto L1
L2:
return
.end method
