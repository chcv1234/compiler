grammar  myCompiler;


options {
	language = Java ;
	backtrack = true ;
}


@header {
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Scanner;
}

@members {
/** Map variable name to Integer object holding value */
HashMap memory = new HashMap();
HashMap TP = new HashMap();
HashMap store = new HashMap();
Queue id = new LinkedList();
Queue q = new LinkedList();

int labelCount = 0;
int storageIndex = 0;
List<String> TextCode = new ArrayList<String>();

public enum Type{
       INT, FLOAT, CHAR;
    }

     /*
     * Output prologue.
     */
    void prologue()
    {
       TextCode.add(";.source");
       TextCode.add(".class public static myResult");
       TextCode.add(".super java/lang/Object");
       TextCode.add(".method public static main([Ljava/lang/String;)V");

       /* The size of stack and locals should be properly set. */
       TextCode.add(".limit stack 100");
       TextCode.add(".limit locals 100");
    }


     /*
     * Output epilogue.
     */
    void epilogue()
    {
       /* handle epilogue */
       TextCode.add("return");
       TextCode.add(".end method");
    }
    
    
    /* Generate a new label */
    String newLabel()
    {
       labelCount ++;
       return (new String("L")) + Integer.toString(labelCount);
    } 
    
    
    public List<String> getTextCode()
    {
       return TextCode;
    }	


}

prog:   VOID MAIN '(' ')' 
	{
           /* Output function prologue */
           prologue();
        }
	NEWLINE 
	'{' NEWLINE decl+ stats[0] '}' 
	{
           /* output function epilogue */	  
           epilogue();
        }
	;
    
decl:	type ID ';' NEWLINE
	{
		TP.put($ID.text, $type.types);
		store.put($ID.text,storageIndex);
		storageIndex = storageIndex + 1 ;
	}	
	;

stats[int truth]: stat[truth] stats[truth] 
		| ;

stat[int truth]:   expr ';' NEWLINE {System.out.println($expr.fvalue);} 
    |   ID '=' expr ';' NEWLINE
        {Integer t = (Integer)TP.get($ID.text);
	 Integer the_mem = (Integer) store.get($ID.text);
	 //if(truth == 0)
	 //{
		if( t == 1)
	 	{

		//System.out.printf("IDOLD : \%d", old.get($ID.text));
		//System.out.printf("\%s",$ID.text);

			Integer test = (int) $expr.fvalue ;

			memory.put($ID.text, new Integer(test));
		//System.out.printf(" ID = \%d \%n" , memory.get($ID.text));
		
			TextCode.add("f2i");
			TextCode.add("istore " + the_mem);
	 	}
	 	else if(t == 2)
	 	{
			

			memory.put($ID.text, new Float($expr.fvalue));

		//System.out.printf(" ID = \%f \%n" , memory.get($ID.text));

			TextCode.add("fstore " + the_mem);
	 	}
		
	  //}
	}	
    |   NEWLINE
    |	IF '(' logic ')' if_stat[$logic.YN] {TextCode.add("goto " + newLabel() ); } ELSE {TextCode.add("L" + Integer.toString(labelCount-1) + ":"); } if_stat[Math.abs($logic.YN-1)] {TextCode.add("L" + Integer.toString(labelCount) + ":") ; }
//    |	scanf_stat[truth] ';' NEWLINE
    |	printf_stat[truth] ';' NEWLINE
    |   FOR '(' forstat {TextCode.add(newLabel() + ":");}';' logic ';' forstat ')' '{' stats[truth] {TextCode.add("goto " + "L" + Integer.toString(labelCount-1) ) ;}'}' {TextCode.add("L" + Integer.toString(labelCount) + ":") ;} NEWLINE
    |	WHILE {TextCode.add(newLabel() + ":") ;}'(' logic ')' '{' stats[truth] {TextCode.add("goto " + "L" + Integer.toString(labelCount-1) ) ; }'}' {TextCode.add("L" + Integer.toString(labelCount) + ":") ;} NEWLINE
    ;

type returns [int types]
    :	INT {$types = 1 ; }
   	| FLOAT {$types = 2 ;} 
	;

expr returns [float fvalue , int type]
    :   e=multExpr 
	{
	  	$fvalue = $e.fvalue;
		$type = $e.type; 
	}
        (   '+' e=multExpr 
		{
	  		$fvalue += $e.fvalue;

			if(($type == 2) || ($e.type == 2))
			{
				TextCode.add("fadd");
				$type = 2 ;
			}
			else
			{
				TextCode.add("iadd");
			}
		}
        |   '-' e=multExpr 
		{
	  		$fvalue -= $e.fvalue;

			if(($type == 2) || ($e.type == 2))
			{
				TextCode.add("fsub");
				$type = 2 ;
			}
			else
			{
				TextCode.add("isub");
			}
		}
        )*
    ;

multExpr returns [float fvalue , int type]
    :   e=atom 
	{
	  	$fvalue = $e.fvalue;
		$type = $e.type ; 
	} 
	('*' e=atom
		{
	  		$fvalue *= $e.fvalue;
			
			if(($type == 2) || ($e.type == 2))
			{
				TextCode.add("fmul");
				$type = 2 ;
			}
			else
			{
				TextCode.add("imul");
			}
		}
	| '/' e=atom
		{
			$fvalue /= $e.fvalue;

			if(($type == 2) || ($e.type == 2))
			{
				TextCode.add("fdiv");
				$type = 2 ;
			}
			else
			{
				TextCode.add("idiv");
			}
		} 
	)*
    ; 

atom returns [float fvalue , int type]
    :   Integer_constant 
	{$fvalue = Integer.parseInt($Integer_constant.text); 
	 Integer testout = (int) $fvalue ;
	 //System.out.printf(" atom = \%d \%n" , testout);
	 $type = 2 ;
	 TextCode.add("ldc " + $Integer_constant.text + ".0");
	}
    |   Floating_point_constant 
	{$fvalue = Float.parseFloat($Floating_point_constant.text);

	 //System.out.printf(" atom = \%f \%n" , $fvalue);
	 $type = 2 ;
	 TextCode.add("ldc " + $Floating_point_constant.text);
	}
    |   ID
        {
	Integer t = (Integer)TP.get($ID.text);
	$type = 2 ;
		if (t == 1)
		{
			Integer v = (Integer)memory.get($ID.text);
			if ( v!=null )
			{ 
				$fvalue = v.intValue();
				TextCode.add("iload " + store.get($ID.text));
				TextCode.add("i2f");
			}        		
			else 
				System.err.println("undefined variable "+$ID.text);
			
			Integer testout = (int) $fvalue ;
			//System.out.printf(" atomID = \%d \%n" , testout);
		}
		else if (t == 2)
		{
			Float v = (Float)memory.get($ID.text);
			if ( v!=null ) 
			{			
				$fvalue = v.floatValue();
				TextCode.add("fload " + store.get($ID.text));
			}        		
			else 
				System.err.println("undefined variable "+$ID.text);

			//System.out.printf(" atomID = \%f \%n" , $fvalue);		
		}
        
        }
    |   '(' expr ')' {$fvalue = $expr.fvalue; }
    ;


logic returns[int YN]:
		expr logicOP
		{
			TextCode.add("fcmpl");

			if( $logicOP.OP == 1)
			{
				TextCode.add("ifge " + newLabel() );

				if( $expr.fvalue < $logicOP.fvalue)
				{
						$YN = 0 ;	
				}				
				else
						$YN = 1;
			}
			else if( $logicOP.OP == 2)
			{
				TextCode.add("ifle " + newLabel() );				

				if( $expr.fvalue > $logicOP.fvalue)
				{				
						$YN = 0 ;
						
				}				
				else
						$YN = 1 ;
			}
			else if( $logicOP.OP == 3)
			{
				TextCode.add("ifgt " + newLabel() );

				if( $expr.fvalue <= $logicOP.fvalue)
				{					
						$YN = 0 ;		
				}				
				else
						$YN = 1 ;
			}
			else if( $logicOP.OP == 4)
			{
				TextCode.add("iflt " + newLabel() );	

				if( $expr.fvalue >= $logicOP.fvalue)
				{				
						$YN = 0 ;		
				}				
				else 
						$YN = 1 ;
			}
			else if( $logicOP.OP == 5)
			{
				TextCode.add("ifne " + newLabel() );
			
				if( $expr.fvalue == $logicOP.fvalue)
				{				
					$YN = 0 ;	
				}				
				else
					$YN = 1 ;
			}
			else if( $logicOP.OP == 6)
                        {
				TextCode.add("ifeq " + newLabel() );
			
                                if( $expr.fvalue != $logicOP.fvalue)
				{                                
				        $YN = 0 ;
				}                                
				else
                                        $YN = 1 ;
                        }

		}
		;

logicOP returns[int OP , float fvalue]: 
		'<' expr {$OP = 1; $fvalue = $expr.fvalue;} 
		| '>' expr {$OP = 2; $fvalue = $expr.fvalue;}
		| '<=' expr {$OP = 3; $fvalue = $expr.fvalue;}
		| '>=' expr {$OP = 4; $fvalue = $expr.fvalue;}
		| '==' expr {$OP = 5; $fvalue = $expr.fvalue;}
		| '!=' expr {$OP = 6; $fvalue = $expr.fvalue;}
		;


if_stat[int truth] :
		stat[truth] stat[truth]
		| '{' stats[truth] '}' NEWLINE
		;	


/*
scanf_stat[int truth]:
	'scanf' '(' A=LITERAL (',''&'B=ID{id.offer($B.text);} )* ')' 
	{
		String S = $A.text ;
		String tmp = new String() ;
		S = S.substring(1,S.length()-1);
		int count = S.length() - S.replace("\%","").length();
		S = S.replace("\%","");
		int numi ;
		int index =0 ;
		float numf ;


		
		if(truth == 0)
		{

		//System.out.println("SCANNER");
		//System.out.println(S);
		Scanner scanner = new Scanner(System.in);

		while(count!=0)
		{
			tmp = (String) id.poll();
			//index = S.indexOf("\%");

			if(S.charAt(index)== 'd' )
			{
				numi = scanner.nextInt();
				memory.put(tmp,new Integer(numi));
				//System.out.println("find D");
			}
			else if(S.charAt(index) == 'f' )
			{
				numf = scanner.nextFloat();
				memory.put(tmp,new Float(numf));
				//System.out.println("find F");
			}
			else
			{
				System.err.println("wrong scanf");
			}

			//S = S.substring(0,index)+ S.substring(index+2,S.length());

			index++;
			count--;
		}

		//System.out.println(S);

		}

		id.clear();
	}
	
	;
*/

		

printf_stat[int truth]:
	'printf' '(' A=LITERAL 
	{
	   String S = $A.text;
	   int in ;
	   S = S.substring(1,S.length()-1);
	   in = S.indexOf("\%");

	   if(in == -1)
	   {
		TextCode.add("getstatic java/lang/System/out Ljava/io/PrintStream;");
		TextCode.add("ldc " +  "\"" + S + "\"");
		TextCode.add("invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V");
	   }
	   else if(in != 0)
	   {
		TextCode.add("getstatic java/lang/System/out Ljava/io/PrintStream;");
		TextCode.add("ldc " +  "\"" + S.substring(0,in) + "\"");
		TextCode.add("invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V");
		TextCode.add("getstatic java/lang/System/out Ljava/io/PrintStream;");
	   }
	   else
	   {
		TextCode.add("getstatic java/lang/System/out Ljava/io/PrintStream;");
	   }
	   
	}
	(',' B=expr 
		{
			q.offer($B.fvalue);

			String S = $A.text;
			String newline = System.getProperty("line.separator");
	   		int in ;
	   		S = S.substring(1,S.length()-1);
	   		in = S.indexOf("\%");

			if(S.charAt(in+1) == 'd')
			{
				TextCode.add("f2i");
				TextCode.add("invokevirtual java/io/PrintStream/print(I)V");
			}
			else if(S.charAt(in+1) == 'f')
			{
				TextCode.add("invokevirtual java/io/PrintStream/print(F)V");
			}
/*
			if(S.indexOf("\\n")>=0)
			{
				TextCode.add("getstatic java/lang/System/out Ljava/io/PrintStream;");
				TextCode.add("ldc " +  "\"" + newline + "\"");
				TextCode.add("invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V");
			}

*/
			if(in+2<=S.length())
			{
				TextCode.add("getstatic java/lang/System/out Ljava/io/PrintStream;");
				TextCode.add("ldc " +  "\"" + S.substring(in+2,S.length()) + "\"");
				TextCode.add("invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V");
			}			
		} 
	)* ')'
	{
		String S = $A.text ;
		int in , line;
		float v ;
		String newline = System.getProperty("line.separator");
		
		if(truth == 0)
		{

		S = S.substring(1,S.length()-1);

		S = S.replace("\\n",newline);

		while(q.size()!=0)
		{
			v = (Float) q.poll();
			in = S.indexOf("\%");

			if(S.charAt(in+1) == 'd')
			{
				S = S.substring(0,in)+Integer.toString((int)v)+S.substring(in+2,S.length());
			}
			else if(S.charAt(in+1) == 'f')
			{
				S = S.substring(0,in)+Float.toString((float)v)+S.substring(in+2,S.length());
			}
			else
			{
				System.err.println("wrong printf");
			}

		}

		System.out.printf("\%s",S);


		}

		q.clear();

	}
	
	;


forstat: ID '=' expr 
	{Integer t = (Integer)TP.get($ID.text);
	 Integer the_mem = (Integer) store.get($ID.text);
	 //if(truth == 0)
	 //{
		if( t == 1)
	 	{

		//System.out.printf("IDOLD : \%d", old.get($ID.text));
		//System.out.printf("\%s",$ID.text);

			Integer test = (int) $expr.fvalue ;

			memory.put($ID.text, new Integer(test));
		//System.out.printf(" ID = \%d \%n" , memory.get($ID.text));
		
			TextCode.add("f2i");
			TextCode.add("istore " + the_mem);
	 	}
	 	else if(t == 2)
	 	{
			

			memory.put($ID.text, new Float($expr.fvalue));

		//System.out.printf(" ID = \%f \%n" , memory.get($ID.text));

			TextCode.add("fstore " + the_mem);
	 	}
		
	  //}
	}	
;



/* description of the tokens */
FOR: 'for' ;
WHILE: 'while' ;
FLOAT:'float';
INT:'int';
MAIN: 'main';
VOID: 'void';
IF: 'if';
ELSE: 'else';
LITERAL: '"'(.)*'"';

ID  :   ('a'..'z'|'A'..'Z')+ ;
Integer_constant:'0'..'9'+;
Floating_point_constant:'0'..'9'+ '.' '0'..'9'+;

NEWLINE:'\r'? '\n' ;
WS  :   (' '|'\t')+ {skip();} ;
//WS : (' ' | '\t' | '\r' | '\n' ){$channel = HIDDEN;};
