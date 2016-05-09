package qmtm;

import java.lang.*;

public class FileSecurity
{
	// User secret key
	public static byte pbUserKey[]  = {(byte)0x00, (byte)0x00, (byte)0x00, (byte)0x00, (byte)0x00, (byte)0x00, (byte)0x00, (byte)0x00,
						 (byte)0x00, (byte)0x00, (byte)0x00, (byte)0x00, (byte)0x00, (byte)0x00, (byte)0x00, (byte)0x00};

	public static byte[] encoding(String data) {
		byte[] byteEnc = null;

		try {
			byte[] plainText = data.getBytes();
			byteEnc = KISA_SEED_ECB.SEED_ECB_Encrypt(pbUserKey, plainText, 0, plainText.length);
		}catch(Exception e){
			System.out.println(e);
		}
		return byteEnc;
	}
	
	public static String decoding(byte[] data) {
		String resultString = null;
		try
		{			
			byte[] resultBytes = KISA_SEED_ECB.SEED_ECB_Decrypt(pbUserKey, data, 0, data.length);
			resultString = new String(resultBytes,0,resultBytes.length);
		}catch(Exception e){
			System.out.println(e);
		}
		return resultString;
	}

	/*
	
	public static byte[] encoding(String txt){
		try{
			System.out.println("[원문]\n"+ txt);
			String strenc = txt;	
			
			//byte 수 채우기
			int max = 0;
			if(strenc.getBytes().length % 16 != 0){
				max = 16-(strenc.getBytes().length % 16);	
			}
			for(int i=0; i<max; i++){
				strenc += " ";
			}	
			
			int size = strenc.getBytes().length;

			
			
			// input plaintext to be encrypted
			byte pbData[]     = strenc.getBytes();

			byte pbCipher[]   = new byte[ 16 ];
			byte reData[][]   = new byte[ size/16 ][16];
			byte reCipher[]   = new byte[ size ];		

			// Derive roundkeys from user secret key
			SEED_KISA.SeedRoundKey(pdwRoundKey, pbUserKey);		

			// Encryption			
			// Encryption
			int b1=0, b2=0;	
			for(int i=0; i < size; i++){
				b1 = (i / 16);
				b2 = (i % 16);					
				reData[ b1 ][ b2 ] = pbData[i];				
			}
			int rf = 0;
			System.out.println("\n[seed encoding]");
			for(int i=0; i<reData.length; i++){
				SEED_KISA.SeedEncrypt(reData[i], pdwRoundKey, pbCipher);				
				for(int j=0; j<pbCipher.length; j++){
					System.out.print(pbCipher[j]);
					reCipher[rf++] = pbCipher[j];
				}
			}
			String strenc_res = new String(reCipher);
			
			return reCipher;
		}catch(Exception e){
			System.out.println(e);
		}
		return null;
	}

	public static byte[] decoding(byte[] reCipher){
		try{
			int size = reCipher.length;
			
			byte pbPlain[]    = new byte[ 16 ];
			byte reData[][]   = new byte[ size/16 ][16];			
			byte rePlain[]    = new byte[ size ];

			// Decryption		
			int b1=0, b2=0;	
			for(int i=0; i<size; i++){
				b1 = (i / 16);
				b2 = (i % 16);							
				reData[ b1 ][ b2 ] = reCipher[i];				
			}		
			int rf = 0;	
			System.out.println("\n\n[seed decoding]");
			for(int i=0; i<reData.length; i++){
				SEED_KISA.SeedDecrypt(reData[i], pdwRoundKey, pbPlain);	
				for(int j=0; j<pbPlain.length; j++){
					System.out.print( pbPlain[j] );
					rePlain[rf++] = pbPlain[j];
				}
			}
			return rePlain;
			
			//String strdec = new String(rePlain);
			//System.out.println("\n\n[base64 decode]\n"+strdec);

			//return strdec;

		}catch(Exception e){
			System.out.println(e);			
		}

		return null;
	}
	*/
}