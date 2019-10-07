import org.antlr.runtime.*;
import java.util.ArrayList;
import java.util.List;
import java.io.FileWriter;

public class testmyCompiler {
	public static void main(String[] args) throws Exception {

      CharStream input = new ANTLRFileStream(args[0]);
      myCompilerLexer lexer = new myCompilerLexer(input);
      CommonTokenStream tokens = new CommonTokenStream(lexer);
 
      myCompilerParser parser = new myCompilerParser(tokens);
      parser.prog();

      /* Output text section */
      List<String> text_code = parser.getTextCode();
       
	  
      for (int i=0; i < text_code.size(); i++)
         System.out.println(text_code.get(i));


	String newline = System.getProperty("line.separator");
	String fn = args[0] + ".j" ;	
      	FileWriter fw = new  FileWriter(fn) ;
      
      	for(int i=0 ; i < text_code.size(); i++)
	{
		fw.write(text_code.get(i) + newline);
		fw.flush();
	}

	fw.close();

	}
}
