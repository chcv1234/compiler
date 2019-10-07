405410039 資工三 闕浩文

	
Please don't view this Readme.txt on workstation for csie
請不要在系上工作站查看此Readme.txt，由於編碼關係會出現亂碼

由於編碼關係，此Readme.txt在windows系統開啟時會有排版混亂的問題，請見諒
建議用wordpad查看此Readme.txt


使用make指令進行編譯

Makefile內容：
	
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


分別輸入以下指令進行執行：

	使用指令make run 能得到所有測試檔的Jasmin assembly codes(.j檔)
	(資料夾內已包含已生成的.j檔，如有需要可自己重新生成)

	全部執行完後，如有需要可使用make clean指令來刪除檔案(compiler相關檔案)
	使用make cleanj 可刪除Jasmin assembly codes(.j檔)


執行Jasmin assembly codes(.j檔):

	java -jar ./jasmin-2.4/jasmin.jar ZZZ.j (ZZZ為任一測試檔的檔名)
	執行後會出現 "Generated: XXX.class" (通常為myResult.class)
	輸入 java XXX 即可執行 (XXX 為上方 XXX.class 的 XXX) 
	(通常是輸入 java myResult 即可)
	
其他：
	由於電腦運算的關係，浮點數運算時會有些許誤差
	
	產生的Jasmin assembly codes(.j檔)中有許多的 f2i 及 i2f 是為了做到float和int能混合使用
	運算過程全都用float來進行運算，存到記憶體的時候才會依照型態儲存
	因此可能會造成效能降低

	所能支援編譯的.C檔寫法會在C subset文件中描述


	（以在mcore8上測試過能正常執行）



