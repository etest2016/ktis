package qmtm;

import qmtm.*;
import java.sql.*; 
import javax.servlet.ServletConfig;
import javax.servlet.http.*;

// 암호화/복호화 관련 Package
import java.security.InvalidKeyException; 
import java.security.NoSuchAlgorithmException; 
import java.security.spec.InvalidKeySpecException; 

import javax.crypto.Cipher; 
import javax.crypto.SecretKey; 
import javax.crypto.SecretKeyFactory; 
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class CommonUtil {
	
	private final static byte[] myIV = {(byte)123,(byte)1,(byte)10,(byte)45,(byte)77,(byte)9,(byte)50,(byte)235};
	
	public CommonUtil() {}

	public static String encrypt(String data) throws Exception 
	{ 
        if (data == null || data.length() == 0) return "";
            
        byte[] tdesKeyData = {
              (byte)0xA2, (byte)0x15, (byte)0x37, (byte)0x07, (byte)0xCB, (byte)0x62, 
              (byte)0xC1, (byte)0xD3, (byte)0xF8, (byte)0xF1, (byte)0x97, (byte)0xDF,
              (byte)0xD0, (byte)0x13, (byte)0x4F, (byte)0x79, (byte)0x01, (byte)0x67, 
              (byte)0x7A, (byte)0x85, (byte)0x94, (byte)0x16, (byte)0x31, (byte)0x92 };

		Cipher c3des = Cipher.getInstance("DESede/CBC/PKCS5Padding");
	    SecretKeySpec    myKey = new SecretKeySpec(tdesKeyData, "DESede");
		IvParameterSpec ivspec = new IvParameterSpec(myIV);

        c3des.init(Cipher.ENCRYPT_MODE, myKey, ivspec);
        byte[] inputBytes1 = data.getBytes("UTF8"); 
        byte[] outputBytes1 = c3des.doFinal(inputBytes1); 

        sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder(); 
        return encoder.encode(outputBytes1);
    }

    public static String decrypt(String data) throws Exception 
	{ 
        byte[] tdesKeyData = {
              (byte)0xA2, (byte)0x15, (byte)0x37, (byte)0x07, (byte)0xCB, (byte)0x62, 
              (byte)0xC1, (byte)0xD3, (byte)0xF8, (byte)0xF1, (byte)0x97, (byte)0xDF,
              (byte)0xD0, (byte)0x13, (byte)0x4F, (byte)0x79, (byte)0x01, (byte)0x67, 
              (byte)0x7A, (byte)0x85, (byte)0x94, (byte)0x16, (byte)0x31, (byte)0x92 };


        if (data == null || data.length() == 0)
            return "";

        Cipher c3des = Cipher.getInstance("DESede/CBC/PKCS5Padding");
        SecretKeySpec    myKey = new SecretKeySpec(tdesKeyData, "DESede");
        IvParameterSpec ivspec = new IvParameterSpec(myIV);

        c3des.init(Cipher.DECRYPT_MODE, myKey, ivspec);
        sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
        byte[] inputBytes1 = decoder.decodeBuffer(data);
        byte[] outputBytes2 = c3des.doFinal(inputBytes1);
        return new String(outputBytes2, "UTF8");
    }

	public static void set_Cookie(HttpServletResponse res, String cname, String cvalue) {

		try {
			Cookie	newcookie = new Cookie(cname, cvalue);
			newcookie.setPath("/");
			//newcookie.setMaxAge(2*60*60);
	        res.addCookie(newcookie);
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
	}

	public static String get_Cookie(HttpServletRequest req, String cname) {

		try {
		    Cookie cookies[] = req.getCookies();
			String c_value = null;

	        for (int i=0; i<cookies.length; i++) {
		        if (cname.equals(cookies[i].getName())) {
			        c_value	= (String)cookies[i].getValue();
				}
	        }
		    return	c_value;
	    } catch (Exception ex) {
			return	"";
	    }
	}

	public static String getMakeID(String gubun) {

		String sRandom = "";
		String id = "";

		Timestamp now = new Timestamp(System.currentTimeMillis());

		String dates = now.toString().substring(2,10).replace("-","");
		String times = now.toString().substring(11,19).replace(":","");
		
		sRandom = RndChar() + RndChar();
		
		if(gubun.equals("C1")) {
			id = "C10050" + dates + times + sRandom;
		} else if(gubun.equals("S1")) {
			id = "S10050" + dates + times + sRandom;
		} else if(gubun.equals("U1")) {
			id = "U10050" + dates + times + sRandom;
		} else if(gubun.equals("U2")) {
			id = "U20050" + dates + times + sRandom;
		} else if(gubun.equals("U3")) {
			id = "U30050" + dates + times + sRandom;
		} else if(gubun.equals("U4")) {
			id = "U40050" + dates + times + sRandom;
		} else if(gubun.equals("E")) {
			id = "E" + dates + times + sRandom;
		} else if(gubun.equals("R")) {
			id = "R" + dates + times + sRandom;		
		}

		return id;
	}

	private static String RndChar() {
		String RndStr = "";
		int pNum = 0;

		try {
		   pNum = (int)(Math.random() * 90);
        } catch (Exception ex) {
		   System.out.print(ex.getMessage());
		}
		
		if(pNum < 65) {
			pNum = (pNum / 3) + 65; 
		}

		RndStr = String.valueOf((char)pNum);

		return RndStr;
	}
}