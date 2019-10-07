all:
	java -cp ./antlr-3.5.2-complete.jar org.antlr.Tool myCompiler.g
	javac -cp ./antlr-3.5.2-complete.jar:. testmyCompiler.java

run:
	java -cp ./antlr-3.5.2-complete.jar:. testmyCompiler 1new.test
	java -cp ./antlr-3.5.2-complete.jar:. testmyCompiler 2new.test
	java -cp ./antlr-3.5.2-complete.jar:. testmyCompiler 3new.test
	java -cp ./antlr-3.5.2-complete.jar:. testmyCompiler for.test
	java -cp ./antlr-3.5.2-complete.jar:. testmyCompiler test2.c

clean:
	-rm  myCompiler*.class  myCompiler.tokens testmyCompiler.class myCompiler*.java


cleanj:
	-rm *.j 
