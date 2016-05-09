

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;



public class EsSeedCuiTest 
{

	public static void main(String[] args)
	{
		
		try {
			//	encrypt
			String s;
	        String strCurPath = System.getProperty("user.dir");
	        
	        String strCmd =strCurPath + "\\tool\\EsCryptCui";
	        String strCryptKey = "this.is.sample.key";
	        String strSrcPath = strCurPath + "\\data\\plain.txt";
	        String strDestPath = strSrcPath + ".enc";
			
			ProcessBuilder pb = new ProcessBuilder(	strCmd,
													"ef",
													strCryptKey,
													strSrcPath,
													strDestPath);
				
			Process process = pb.start();			 
		    BufferedReader stdOut = new BufferedReader( new InputStreamReader(process.getInputStream()) );		    		    
		    while( (s = stdOut.readLine()) != null ) {
		        System.out.println(s);
		    }
		    
		    //	decrypt
		    strSrcPath = strDestPath;
	        strDestPath = strSrcPath + ".dec";
		    pb = new ProcessBuilder(	strCmd,
					"df",
					strCryptKey,
					strSrcPath,
					strDestPath);

			process = pb.start();			 
			stdOut = new BufferedReader( new InputStreamReader(process.getInputStream()) );		    		    
			while( (s = stdOut.readLine()) != null ) {
				System.out.println(s);
			}
			

	    }
	    catch (IOException e) {
		    System.err.println(e.getMessage());
		    System.exit(-1);
	    }
		   		
	}
	
	 	
}


