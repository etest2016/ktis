package qmtm;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

import java.math.BigDecimal;

import java.util.Date;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.GregorianCalendar;

import org.apache.commons.codec.binary.Base64;

import java.util.ResourceBundle;

public class ComLib {

    public static boolean verbose = true ;
    private static final String dateSep = ".";
    private static final String timeSep = ":";
    
    public static String runMode = "";
    public static ResourceBundle runmodeBundle = null;
	public static ResourceBundle configBundle = null;
      	
	public static String getDecodeStr(String str) {
		String decodedData = new String(Base64.decodeBase64(str.getBytes()));

		return decodedData;
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
		} else if(gubun.equals("A")) {
			id = "A" + dates + times + sRandom;
		} else if(gubun.equals("B")) {
			id = "B" + dates + times + sRandom;
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
	
	// �ϰ���� ���� ������ ó��
	public static String text_convert(String ca) {
				
		ca = ca.trim();
		ca = ComLib.htmlDel(ca);
		ca = ca.replaceAll("��","1");
		ca = ca.replaceAll("��","2");
		ca = ca.replaceAll("��","3");
		ca = ca.replaceAll("��","4");
		ca = ca.replaceAll("��","5");
		
		return ca;
	}
	
	public static String removeAndDel(String str) {
		str = str.replaceAll("&NBSP;","");
		str = str.replaceAll("&nbsp;","");
		str = str.replaceAll("&lt","");
		str = str.replaceAll("&gt","");
		
		return str;
	}
	
	// ���� �ϰ���� �Ұ�� ���� ���� &nbsp;�±� ����
	public static String removeNBSP(String str) {
		
		str = str.replaceAll("&NBSP;","");
		str = str.replaceAll("&nbsp;","");
		
		return str;
	}
	
	// ���� �ϰ���� �Ұ�� ���� ���� <pre>�±� ����
	public static String removePre(String str) {
		
		str = str.replaceAll("</PRE>","");
		str = str.replaceAll("</pre>","");
		
		return str;
	}

	// ���� �ϰ���� �Ұ�� ���� ���� <br>�±� ����
	public static String removeBR2(String str) {
		
		str = str.replaceAll("<br>","");
		str = str.replaceAll("<BR>","");
		
		return str;
	}
	
	// ���� �ϰ���� �Ұ�� ���� �տ� &nbsp;�±� ����
	public static String removeBR(String str) {

		for(int i=0; i<10; i++) {
			
			if(str.endsWith("<BR>") || str.endsWith("<br>")) {
				str = str.substring(0,str.length()-4);
				continue;
			} else {
				break;
			}
		}

		return str;
	}
	
	public static String toParamChk(String str) {        
        str = getReplace(str, "'", "''");
     
        return str;
    }	
	
	/**
     * jsp������ �ܼ�html�� �����ַ��Ҷ� html�±׸� ������ ������ �ִ� ���ڸ� ��ȯ�Ͽ� �ش�.
     *  �ַ� �����ִ� �뵵�� ���Ǵ� html���ڿ����� ����Ѵ�.
     *  ��) String abc = "ab<>cd\"asdf\'sdd     fsdf";
     *   <td><%=toStrHtml(abc)%></td>
     * @param str  : ġȯ�� ���ڿ�
     * @return str : ġȯ�� ���ڿ�
     */
    public static String toStrHtml(String str) {
        str = getReplace(str, "&", "&amp;");
        str = getReplace(str, "\"", "&quot;");
        str = getReplace(str, "'", "&#039;");
        str = getReplace(str, "<", "&lt;");
        str = getReplace(str, ">", "&gt;");
        str = getReplace(str, " ", "&nbsp;");
        str = getReplace(str, "\r", "");
        str = getReplace(str, "\n", "<BR>");
        if( str.length() > 0 && str.trim().length() == 0 ){
            str = "&nbsp;";
        }
        return str;
    }

	public static String toStrHtml2(String str) {
		str = getReplace(str, "\r", "");
        str = getReplace(str, "\n", "");
        if( str.length() > 0 && str.trim().length() == 0 ){
            str = "&nbsp;";
        }
        return str;
    }

    /**
     * jsp������ <input> Tag�� �Է½� ����Ѵ�. : " (double quotation)���ڸ� ��ȯ�Ͽ� �ش�.
     *  �ڵ强 �����͸� ������ input Tag�� ����Ѵ�.
     *  ��) String abc = "abcd\"asdfsddfsdf";
     *   <input type="text" name="abc" value="<%=toStrInput(abc)%>">
     * @param str  : ġȯ�� ���ڿ�
     * @return str : ġȯ�� ���ڿ�
     */
    public static String toStrInput(String str) {
        str = getReplace(str, "\"","&quot;");
        return str;
    }

    /**
     * jsp������ script���� ���ϰ�� ��� : \n, \ ���� ��ũ��Ʈ �����߻� ������ ���ڸ� ��ȯ�Ͽ� �ش�.
     *  ��) String abc = "asdf\n\nsfsdffd\naf\sfsf\n";
     *   [script]form.abc.value = "<%=toStrScript(abc)%>";[/script]
     * @param str  : ġȯ�� ���ڿ�
     * @return str : ġȯ�� ���ڿ�
     */
    public static String toStrScript(String str) {
        str = getReplace(str, "\r", "");
        str = getReplace(str, "\n", "\\n");
        return str;
    }
    /**
     * ���ڿ��� null �Ǵ� ���̰� 0 ����Chcek
     * @param str : check ���ڿ�
     * @return null�̸� true, null�� �ƴϸ� false
     */
    public static boolean isEmpty(String str) {
        if ( (str == null) || (str.trim().length() == 0) ) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * ���̺�ó���� ���� ������ "&nbsp;"�� ��ü
     * @param str check ���ڿ�
     * @return null�̸� "&nbsp;", null�� �ƴϸ� false
     */
    public static String nbsp(String str) {
        if ( str == null || str.trim().length() == 0 ||  str.trim().equals("0") )
            return "&nbsp;";
        return str;
    }

    /**
     * ���ڿ� 0�� �ٿ� return
     * ��) zrStr(1, 3) => "001"
     * @param lNum ����� ����
     * @param lSiz return�� String�� ũ��
     * @return lSiz �տ� '0'�̺ٴ� String
     */
    public static String zrStr(int lNum, int lSiz) {
        int i;
        StringBuffer lStr = new StringBuffer();
        lStr.append("00000000000000000");
        lStr=lStr.append(String.valueOf(lNum));
        return lStr.toString().substring(lStr.length()-lSiz);
    }

    /**
     * ���ڿ� 0�� �ٿ� return
     * ��) zrStr(1, 3) => "001"
     * @param lNum ����� ����
     * @param lSiz return�� String�� ũ��
     * @return lSiz �տ� '0'�̺ٴ� String
     */
    public static String zrStr(String lNum, int lSiz) {
        int i;
        StringBuffer lStr = new StringBuffer();
        lStr.append("00000000000000000");
        lStr=lStr.append(lNum);
        return lStr.toString().substring(lStr.length()-lSiz);
    }

    /**
     * ���˿� ���� �ú��� ����
     * ��) getTime("hh-mm-ss") -->   "05-39-56"
     * ��) getTime("HH-mm-ss") -->   "17-39-56"
     * ��) getTime("hh-mm")    -->   "05-39"
     * ��) getTime("hhmm")     -->   "0539"
     * @param fmtstr 8�ڸ� "hh-mm-ss"
     * @return �־��� format�� ���� �ú��� �ð�
     */
    public static String getTime(String fmtstr) {
        java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat(fmtstr);
        String str = fmt.format(new Date());
        return str;
    }

    /**
     * �����Ϻ��� Rng�� ���ڸ� ����
     * ��) dayRange(180); -->   �����Ϻ��� 180������ ����
     * @param Rng ���� �ϼ�
     * @return "20040101"���� �迭�� ���ڹ��ڿ�
     */
    public static String[] dayRange(int Rng) {
        String[] dayAry = new String[Rng];
        GregorianCalendar today = new GregorianCalendar();

        dayAry[0] = String.valueOf(today.get(GregorianCalendar.YEAR)) + zrStr((today.get(GregorianCalendar.MONTH) + 1), 2) + zrStr(today.get(GregorianCalendar.DATE), 2);
        for ( int mcnt = 1 ; mcnt < Rng; mcnt++ ) {
            today.add(GregorianCalendar.DATE, -1);   // 1 ����
            dayAry[mcnt] = String.valueOf(today.get(GregorianCalendar.YEAR)) + zrStr((today.get(GregorianCalendar.MONTH) + 1), 2) + zrStr(today.get(GregorianCalendar.DATE), 2);
        }
        return dayAry;
    }

    /**
     * �����Ͽ� rng�����͸� ���Ͽ� ����(���п� ���� ��, ��, ��)
     * @param gijun_date
     * @param rng
     * @return �����Ϻ��� rng�� ���� 20040101
     */
    public static String befdate(String gijun_date, int rng) {
        if (gijun_date.length() != 8) return "";
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, Integer.parseInt(gijun_date.substring(0,4)));
        cal.set(Calendar.MONTH, (Integer.parseInt(gijun_date.substring(4,6))-1));
        cal.set(Calendar.DAY_OF_MONTH,Integer.parseInt(gijun_date.substring(6,8)));

        cal.add(Calendar.DATE, rng);
        return String.valueOf(cal.get(Calendar.YEAR)) + dateSep + zrStr((cal.get(Calendar.MONTH) + 1), 2) + dateSep + zrStr(cal.get(Calendar.DATE), 2);
    }

    /**
     * �����Ͽ� rng�� ���ڸ�ŭ ���Ͽ� ����
     * @param rng
     * @return �����Ϻ��� rng�� ���� 20040101
     */
    public static String befdate(int rng) {
        GregorianCalendar today = new GregorianCalendar();
        today.add(GregorianCalendar.DATE, rng);
        return String.valueOf(today.get(GregorianCalendar.YEAR)) + dateSep + zrStr((today.get(GregorianCalendar.MONTH) + 1), 2) + dateSep + zrStr(today.get(GregorianCalendar.DATE), 2);
    }

    /**
     * �����Ͽ� rng�� ����ŭ ���Ͽ� ����
     * @param rng
     * @return �����Ϻ��� (rng)�� ��/�� �� ���� 20040101
     */
    public static String befMonth(int rng) {
        GregorianCalendar today = new GregorianCalendar();
        today.add(GregorianCalendar.MONTH, rng);
        return String.valueOf(today.get(GregorianCalendar.YEAR)) + dateSep + zrStr((today.get(GregorianCalendar.MONTH) + 1), 2) + dateSep + zrStr(today.get(GregorianCalendar.DATE), 2);
    }

    /**
     * �����Ͽ� rng�� �⸸ŭ ���Ͽ� ����
     * @param rng
     * @return �����Ϻ��� (rng)��
     */
    public static String befYear(int rng) {
        GregorianCalendar today = new GregorianCalendar();
        today.add(GregorianCalendar.YEAR, rng);
        return String.valueOf(today.get(GregorianCalendar.YEAR)) + dateSep + zrStr((today.get(GregorianCalendar.MONTH) + 1), 2) + dateSep + zrStr(today.get(GregorianCalendar.DATE), 2);
    }

    /**
     * 8�ڸ� ��¥ String�� dateSep�� �ٿ� return
     * ��) insSep("20040101") -->  "2004-01-01" (dateSep�� "-"�� ���)�� ��ȯ
     * @param str 8�ڸ� ��¥ String
     * @return dateSep�� ���Ե� ��¥ String
     * @throws Exception
     */
    public static String insSep(String str) throws Exception {
        if ( (str == null) || (str.equals("")) ) return " ";
        str = str.trim();
        if (str.length() == 4) return str;
        if (str.length() == 6) return str.substring(0,4) + dateSep + str.substring(4,6);
        if (str.length() == 8) return str.substring(0,4) + dateSep + str.substring(4,6) + dateSep + str.substring(6,8);
        if (str.length() == 14) return str.substring(0,4) + dateSep + str.substring(4,6) + dateSep + str.substring(6,8) + " " + str.substring(8,10) + timeSep + str.substring(10,12) + timeSep + str.substring(12,14);
        return " ";
    }

    /**
     * date type String���� dateSep ����
     * ��) delSep("2004-01-01") --> "20040101" �� ��ȯ (dateSep�� "-"�� �ϰ��)
     * @param strdate 2004.01.01
     * @return dateSep�� ���� 8�ڸ� ��¥���ڿ�
     * @throws Exception
     */
    public static String delSep(String strdate) throws Exception {
        if ( strdate == null ) return "";
        strdate = strdate.trim();
        return getReplace(strdate,dateSep,"");
    }

    /**
     * yyyyMMdd ������ �������� (dateSep ����)
     * @return ���ϳ�¥�� "yyyyMMdd return
     * @throws Exception
     */
    public static String getCurYmd() throws Exception {
        java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("yyyyMMdd");
        String str = fmt.format(new Date());
        return str;
    }

    /**
     * yyyy-MM-dd ������ �������� (dateSep�� "-" �ϰ��, "." �ϰ��� yyyy.MM.dd)
     * @return ���ϳ�¥�� "yyyy-MM-dd return
     * @throws Exception
     */
    public static String getYmd() throws Exception {
        java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("yyyy"+dateSep+"MM"+dateSep+"dd");
        String str = fmt.format(new Date());
        return str;
    }

    /**
     * yyyy-MM ������ ��� (dateSep�� "-" �ϰ�� ".", �ϰ��� yyyy.MM.dd)
     * @return ����� "yyyy-MM" return
     * @throws Exception
     */
    public static String getYm() throws Exception {
        java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("yyyy"+dateSep+"MM");
        String str = fmt.format(new Date());
        return str;
    }

    /**
     * yyyy ������ ��⵵
     * @return ����� "YYYY"�� return
     * @throws Exception
     */
    public static String getYyyy() throws Exception {
        java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("yyyy");
        String str = fmt.format(new Date());
        return str;
    }

    /**
     * ���س⵵�� rng�� �⸸ŭ ���Ͽ� ����
     * @param rng ����⿡ (rng)���� ���� �⵵
     * @return �������⵵
     */
     public static String getYyyy(int rng) {
         GregorianCalendar today = new GregorianCalendar();
         today.add(GregorianCalendar.YEAR, rng);
         return String.valueOf(today.get(GregorianCalendar.YEAR));
     }

    /**
     * �ֹε�Ϲ�ȣ 13�ڸ��� "-"�� �־ �����Ѵ�.
     * @param str �ֹε�Ϲ�ȣ
     * @return 123456-1234567 ������ String
     * @throws Exception
     */
    public static String getJumin(String str) throws Exception  {
        if(str == null || str.length()<13 )
            return str;
        return (new StringBuffer().append(str.substring(0,6)).append("-").append(str.substring(6)).toString());
    }

    /**
     * �����ȣ 6�ڸ��� "-"�� �־ �����Ѵ�.
     * @param str �����ȣ
     * @return 123-123 ������ String
     * @throws Exception
     */
    public static String getPost(String str) throws Exception {
        if(str == null || str.length() < 6 )
            return str;
        return (new StringBuffer().append(str.substring(0,3)).append("-").append(str.substring(3)).toString());
    }

    /**
     * Integer�� string�� ��ȯ
     *  ��)numToStr(999990) => 999,990(String)
     * @param inttemp Integer
     * @return ������������ ���˵� String
     * @throws Exception
     */
    public static String numToStr(Integer inttemp) throws Exception {
        DecimalFormat df = new DecimalFormat("##,###,###,##0");
        if ( inttemp == null )
            return "0";
        return df.format(inttemp) ;
    }

    /**
     * integer�� string�� ��ȯ
     *  ��)numToStr(999990) => 999,990(String)
     * @param inttemp integer
     * @return ������������ ���˵� String
     * @throws Exception
     */
    public static String numToStr(int inttemp) throws Exception  {
        DecimalFormat df = new DecimalFormat("##,###,###,##0");
        return df.format(inttemp) ;
    }

    /**
     * Double�� String�� ��ȯ
     * ��)numToStr( 2000.54 ) => 2,000.54
     * @param dbltemp : Double type�� ��
     * @return ������������ ���˵� String
     * @throws Exception
     */
    public static String numToStr(Double dbltemp) throws Exception {
        double dbl = dbltemp.doubleValue();
        DecimalFormat df = new DecimalFormat("##,###,###,##0.00");
        if(dbltemp==null)  return "0";
        return df.format(dbl) ;
    }

    /**
     * double�� String�� ��ȯ
     * ��)numToStr( 2000.54 ) => 2,000.54
     * @param dbltemp : Double type�� ��
     * @return ������������ ���˵� String
     * @throws Exception
     */
    public static String numToStr(double dbltemp) throws Exception {
        DecimalFormat df = new DecimalFormat("##,###,###,##0.00");
        return df.format(dbltemp) ;
    }

    /**
     * ���ڷθ� �� String�� ������
     * ��)numToStr( "2000.54") => 2,000.54
     * @param strtemp : ���ڹ��ڿ�
     * @return ������������ ���˵� String
     */
    public static String numToStr(String strtemp) {
        double dbl;
        if( strtemp == null || "".equals(strtemp)) {
            dbl = 0;
        } else {
            dbl = new Double(strtemp).doubleValue();
        }
        DecimalFormat df = new DecimalFormat("##,###,###,##0.00");
        return df.format(dbl) ;
    }

    /**
     * ���ڷθ� �� String�� �־��� �μ��� ���� ������
     * ��)numToStr( "2000.54", "###,##0.00") => 2,000.54
     * @param strtemp : ���ڹ��ڿ�
     * @param fmt : ���˸���ũ
     * @return ������������ ���˵� String
     */
    public static String numToStr(String strtemp, String fmt) {
        double dbl;
        if( fmt == null || fmt.trim().length() == 0 ) return strtemp;
        if( strtemp == null || strtemp.length() == 0 ) {
            dbl = 0;
        } else {
            dbl = new Double(strtemp).doubleValue();
        }
        DecimalFormat df = new DecimalFormat(fmt);
        return df.format(dbl) ;
    }

    /**
     * ������ ���ڿ��� comma ����
     *  ��)delComma("2,000"),delComma("2,000.00");
     * @param  comma  ������ String
     * @return comma�� ���ŵ� String
     * @throws Exception
     */
    public static String commaDel(String comma) throws Exception {
        int index = 0;
        if ( (comma == null) || comma.equals("")) {
            return "0";
        }
        while((index = comma.indexOf(",", index)) >= 0) {
            comma = comma.substring(0,index) + "" + comma.substring(index + 1);
            index += 1;
        }
        return comma ;
    }

    /**
     * String �� int�� ��ȯ, null�ϰ�� 0���� ����
     * ��)nullChkInt( "123456" ) => 123456
     * @param inttemp
     * @return int
     * @throws Exception
     */
    public static int nullChkInt(String inttemp) throws Exception {
        if ( (inttemp == null) || inttemp.equals("") )
            return 0;
        return Integer.parseInt(inttemp);
    }

    /**
     * String �� int�� ��ȯ, null�ϰ�� 0���� ����
     * ��)nullChkInt( "123456" ) => 123456
     * @param inttemp
     * @return int
     * @throws Exception
     */
    public static long nullChkLng(String lngtemp) throws Exception {
        if ( (lngtemp == null) || lngtemp.equals("") )
            return 0;
        return Long.parseLong(lngtemp);
    }

    /**
     * string �� double������ ��ȯ, null�ϰ�� 0.0���� ����
     * @param Wtemp ������������ ���˵� String
     * @return double
     * @throws Exception
     */
    public static double nullChkDbl(String Wtemp) throws Exception {
        double dbltemp;
        if ( (Wtemp == null) || Wtemp.equals("") )
            return 0.0d;
        dbltemp = new Double(commaDel(Wtemp)).doubleValue();
        return dbltemp;
    }

    /**
     * String�� null�̸�  ���� ���ڿ� return�ϰ� null�� �ƴϸ� ���޹��� String�� trim()�� �ٽ� return
     * @param str String
     * @return str String
     */
    public static String nullChk(String str) {
        if(str == null)
            return "";
        return str.trim();
    }

	public static String nullChk2(String str) {
        if(str == null || str.equals(""))
            return "&nbsp;";
        return str.trim();
    }

    /**
     * String�� null�̸�  def�� ���ڿ� ��return�ϰ� null�� �ƴϸ� ���޹��� String�� trim()�� �ٽ� return
     * �� def�� null�ϰ��� ""������ ����
     * @param str String
     * @param def String
     * @return str String
     */
    public static String nullChk(String str,String  def) {
        if(def == null) def =  "";
        if(str == null || "".equals(str.trim()))
            return def;
        return str.trim();
    }

    /**
     * Ư�� ��ū�� �̿��Ͽ� ���ڿ� �ڸ����� String �迭�� �����Ѵ�.
     * getParser( "abc|def", "|")
     * return : [0]=abc [1]=def
     * @param str ���͹��ڰ� ���Ե� ���ڿ�
     * @param sep ���͹���
     * @return String�迭
     * @throws Exception
     */
    public static String[] getParser(String str,String sep) throws Exception {
 		int count = 0;
		int index = -1;
		int index2 = 0;

		if( str == null ) return null;

        if ("".equals(str)) {
    		String[] substr = new String[1];
    		substr[0] = "";
    		return substr;
        }

		do {
			++count;
			++index;
			index = str.indexOf(sep, index);
		} while (index != -1);
		//�������� �����ڰ� �ִ��� check
		if (isEmpty(str.substring(index2))) {
			count--;
		}
		String[] substr = new String[count];
		index = 0;
		int endIndex = 0;
		for (int i = 0; i < (count); i++) {
			endIndex = str.indexOf(sep, index);
			if (endIndex == -1) {
				substr[i] = str.substring(index);
			} else {
				substr[i] = str.substring(index, endIndex);
			}
			index = endIndex + 1;
		}
		return substr;
    }

    /**
     * �޽��� ��������Ʈ ���ڿ��� ����� : java.security.MessageDigest
     * @param passwd
     * @return result ó���� ���ڿ�
     * @throws java.lang.Exception
     */
    public static String getSecurity(String passwd) throws java.lang.Exception {
        byte[] temp = passwd.getBytes();
        String result = null;

        try{
            java.security.MessageDigest md5 = java.security.MessageDigest.getInstance("MD5");
            md5.update(temp);
            result = toHex(md5.digest());
        } catch(Exception e) {
            throw e;
        }
        return result;
    }

    /**
     * ���ڿ��� 16������ ��ȯ�Ѵ�. ( getSecurity ���� ���� )
     * @param digest
     * @return buf.toString()
     */
    private static String toHex(byte[] digest) {
        StringBuffer buf = new StringBuffer();

        for(int i=0;i< digest.length;i++)
            buf.append(Integer.toHexString((int)digest[i] & 0x00ff));
        return buf.toString();
    }

    /**
     * ���ڿ� ġȯ : str�� NULL  �� ��� "" ����
     *  ��) getReplace( "string\nstring\n", "\n", "<br>")
     *      return : string<br>string<br>
     * @param str ġȯ�� ���ڿ��� ���Ե� ���ڿ�
     * @param sTo ġȯ �� ����
     * @param sFrom ġȯ �� ����
     * @return String
     */
    public static String getReplace ( String str,String sTo, String sFrom ) {
        int count = 0;
        int index = 0;
        int index2 = 0;
        int slen = sTo.length() ; // ġȯ�� ���ڿ�����

        if( str == null ) return "";

        do {
            ++count;
            index = str.indexOf(sTo, index);
        }while (index++ != -1);

        String[] substr = new String[count];
        index = 0;
        int endIndex = 0;
        for ( int i = 0; i < (count); i++ ) {
            endIndex = str.indexOf(sTo, index);
            if ( endIndex == -1) {
                substr[i] = str.substring(index);
            } else {
                substr[i] = str.substring(index, endIndex) + sFrom;
            }
            index = endIndex + slen ;
        }
        String tmp = "";
        for(int i = 0; i < count; i++ ) {
            tmp += substr[i] ;
        }
        return tmp;
    }

	public static String getSendMsg(String msg, String bigo) {
		StringBuffer str = new StringBuffer();

		String err_msg = msg;
		err_msg = err_msg + toStrScript("\n\n") + "����ڿ��� �������ֽñ� �ٶ��ϴ�.";
		                		
		str.append("<script>");
		str.append("alert('"+err_msg+"');");
		if(bigo.equals("close")) {
			str.append("window.close();");
		} else if(bigo.equals("fclose")) {
			str.append("top.window.close();");
		} else if(bigo.equals("back")) {
			str.append("history.back();");
		}
		str.append("</script>");


        return ((str.toString()==null)?"":str.toString());
	}

	public static String getParameterChk(String bigo) {
		StringBuffer str = new StringBuffer();

		str.append("<script>");
		str.append("alert('�α��� �ϼž� �̿��Ͻ� �� �ֽ��ϴ�.');");
		if(bigo.equals("close")) {
			str.append("window.close();");
		} else if(bigo.equals("fclose")) {
			str.append("top.window.close();");
		} else if(bigo.equals("back")) {
			str.append("history.back();");
		}
		str.append("</script>");


        return ((str.toString()==null)?"":str.toString());
	}
       
    /**
     * WebtException error message�� �����˾����� string return
     * @param service WebtService
     * @return error message�� alert�� ���Ե� String
     * @throws Exception
     */
    public static String getExceptionMsg(Exception e, String bigo) throws Exception {
        StringBuffer str = new StringBuffer();

        String err_msg   = e.getLocalizedMessage();
		err_msg = err_msg.replace("'","");
		err_msg = err_msg + toStrScript("\n\n") + "�����ڿ��� �������ֽñ� �ٶ��ϴ�.";
		                
        str.append("<script>");
		str.append("alert('"+err_msg+"');");
		if(bigo.equals("close")) {
			str.append("window.close();");
		} else if(bigo.equals("fclose")) {
			str.append("top.window.close();");
		} else if(bigo.equals("back")) {
			str.append("history.back();");
		}
		str.append("</script>");

        return ((str.toString()==null)?"":str.toString());
    }
	
	public static String getAlertMsg(String err_msg, String bigo) throws Exception {
        StringBuffer str = new StringBuffer();
        
		err_msg = err_msg.replace("'","");
				                
        str.append("<script>");
		str.append("alert('"+err_msg+"');");
		if(bigo.equals("close")) {
			str.append("window.close();");
		} else if(bigo.equals("fclose")) {
			str.append("top.window.close();");
		} else if(bigo.equals("back")) {
			str.append("history.back();");
		}
		str.append("</script>");

        return ((str.toString()==null)?"":str.toString());
    }
    
	/**
     * ��ȭ��ȣ�� ��� �����Ѵ�.
     *  ��) makePhoneNumber("02","1234","5678");
     *  return "02-1234-5678"
     * @param phone1
     * @param phone2
     * @param phone3
     * @return buf.toString() '-'�� ����� ��ȭ��
     * @throws Exception
     */
    public static String makePhoneNumber(String phone1, String phone2, String phone3) throws Exception {
        StringBuffer buf = new StringBuffer();
        boolean b = false;

        if(!phone1.equals("")){
            buf.append(phone1);
            b=true;
        }
        if(!phone2.equals("")){
            if(b) buf.append("-");
            buf.append(phone2);
            b = true;
        }
        if(!phone3.equals("")){
            if(b) buf.append("-");
            buf.append(phone3);
        }
        return buf.toString();
    }


    /**
     * ���ڿ��� �տ� filler ���ڿ��� ä���ִ´�.
     *  ��) fillFront("9",10,"0");
     *  return "0000000009"
     * @param str    : ���ڿ� ����
     * @param len    : �ѹ����� ����
     * @param filler : ä������ ���鹮�ڿ�
     * @return len ���̷� ä���� str���ڿ�
     * @throws Exception
     */
    public static String fillFront(String str, int len, String filler) throws Exception {

        int fillLen = len-str.getBytes("MS949").length;
        if( fillLen < 0 ){
            if( str.getBytes("MS949").length < len ){
                for (int i=0;i < len - str.getBytes("MS949").length;i++){
                    str = filler+str;
                }
            }else{
                str = str.substring(str.getBytes("MS949").length-len);
            }
        }else{
            for (int i=0;i < fillLen;i++){
                str = filler+str;
            }
        }
        return str;
    }
    /**
     * ���ڿ��� �ڿ� filler ���ڿ��� ä���ִ´�.
     *  ��) fillRear("9",10,"0");
     *  return "0000000009"
     * @param str    : ���ڿ� ����
     * @param len    : �ѹ����� ����
     * @param filler : ä������ ���鹮�ڿ�
     * @return len ���̷� ä���� str���ڿ�
     * @throws Exception
     */
    public static String fillRear(String str, int len, String filler) throws Exception {

        int fillLen = len-str.getBytes("MS949").length;
        if( fillLen < 0 ){
            str = cropByte(str, len, "");
            if( str.getBytes("MS949").length < len ){
                for (int i=0;i < len - str.getBytes("MS949").length;i++){
                    str = str+filler;
                }
            }
        }else{
            for (int i=0;i < fillLen;i++){
                str = str+filler;
            }
        }
        return str;
    }

    /**
     * '-'�� ����� ��ȭ��ȣ�� ������ String�迭�� �����Ѵ�.
     * @param phoneNumber
     * @return returnValue : �������� String[] ��ȭ��ȣ
     * @throws Exception
     */
    public static String[] separatePhoneNumber(String phoneNumber) throws Exception {
        String[] returnValue = new String[3];
        int len = phoneNumber.length();
        int j = 0, startPos = 0;

        for(int i = 0; i < 3; i++) returnValue[i] = "";
        if (len != 0) {
            for(int i = 0; i < len; i++) {
                if(phoneNumber.charAt(i) == '-'){
                    returnValue[j] = phoneNumber.substring(startPos, i);
                    j++;
                    startPos = i+1;
                }
            }
            returnValue[j] = phoneNumber.substring(startPos, len);
        }
        return returnValue;
    }

    /**
     * Method cropByte. ���ڿ� ����Ʈ����ŭ �����ְ�, ����ǥ���ϱ�
     *  ��) cropByte("�����ٶ�abcde", 6, "...")
     *      return "�����ٶ�a..."
     *      cropByte("�����ٶ󸶹�abcde", 6, "...")
     *      return "�����ٶ󸶹�..."
     * @param str ���ڿ�
     * @param i ����Ʈ��
     * @param trail ���� ���ڿ�. ��) "..."
     * @return String
     */
    public static String cropByte(String str, int i, String trail) {
        if (str==null) return "";
        String tmp = str;
        int slen = 0, blen = 0;
        char c;
        try {
            if(tmp.getBytes("MS949").length>i) {
                while (blen+1 < i) {
                    c = tmp.charAt(slen);
                    blen++;
                    slen++;
                    if ( c  > 127 ) blen++;  //2-byte character..
                }
                tmp=tmp.substring(0,slen)+trail;
            }
        } catch(java.io.UnsupportedEncodingException e) {}
        return tmp;
    }

    /**
     * ���� ��¥ �� �ð� ������ ���������� ���ڿ��� �����մϴ�
     * @return String       ���˵� ���� ��¥ �� �ð� ���ڿ�
     */
    public static String getCurrentDate() {
            SimpleDateFormat df = new SimpleDateFormat("<yyyy/MM/dd - HH:mm:ss>") ;
            return df.format(new Date()) ;
    }

    /**
     * &, ' ' @ ���� �������Ѵ�.
     * @param str : URLEncoder�� ���ڵ��� String
     * @return URLEncoder.encode(str)
     */
    public static String encode(String str) {
        return URLEncoder.encode(str);
    }

    /**
     * ���ڵ��Ǿ� ���� &, ' ' @ ���� ���ڸ� ���ڵ��Ѵ�.
     * @param str : URLDecoder�� ���ڵ��� String
     * @return URLDecoder.decode(str)
     */
    public static String decode(String str) {
        return URLDecoder.decode(str);
    }

    /**
     * ���ڵ� Ÿ���� KSC5601�� �ٲ�
     * @param str : ��ȯ�� ���ڿ�
     * @return String KSC5601�� ��ȯ�� ���ڿ�
     * @throws Exception
     */
    public static String toKor(String str) throws Exception {
      return new String(str.getBytes("8859_1"), "EUC-KR");
    }

    /**
     * ���ڵ� Ÿ���� 8859_1�� �ٲ�
     * @param str : ��ȯ�� ���ڿ�
     * @return String 8859_1�� ��ȯ�� ���ڿ�
     * @throws Exception
     */
    public static String toEng(String str) throws Exception {
      return new String(str.getBytes("KSC5601"), "EUC-KR");
    }

    // String str = "1234567890";
    // format(str,"3-4-3");  ==> "123-4567-890"
    public static String format(String str, String fmt) {
    
    	if (str == null) return "";
    	if (str.trim().length() == 0) return "";
    
    	StringBuffer result = new StringBuffer();
    	int strIdx = 0;
    	int etcCnt = 0;
    
    	StringBuffer fmt2 = new StringBuffer();
    	for (int i = 0; i < fmt.length(); i++) {
    		if (fmt.charAt(i) >= '1' && fmt.charAt(i) <= '9') {
    			for (int j = '0'; j < fmt.charAt(i); j++) {
    				fmt2.append("#");
    			}
    		} else {
    			fmt2.append(String.valueOf(fmt.charAt(i)));
    		}
    	}
    
    	strIdx = 0;
    	etcCnt = 0;
    
    
    	for (int i = 0; i < fmt2.length(); i++) {
    		if (i >= (str.length() + etcCnt))
    			break;
    
    		if (fmt2.charAt(i) == '#') {
    			result.append(String.valueOf(str.charAt(strIdx)));
    			strIdx++;
    		} else {
    			result.append(String.valueOf(fmt2.charAt(i)));
    			etcCnt++;
    		}
    	}
    
    	return result.toString();
    }

    /* �۳����߿� ����Ű���� <br> ��ũ �־��ֱ�
     */
  	public static String brTag(String content)
  	{
  		
  		String token = "\r\n";
  		String tag   = "<br>";
  		String sub_1 = null;
  		String sub_2 = null;
  		
  		int idx_2 = 0;			
  		for(int i=1; i<6; i++)
  		{
  			int idx = content.indexOf(token);
  			
  			if(idx == -1)
  			{
  				content = content;
  			}
  			else
  			{
  				while((idx_2 = content.indexOf(token))!=-1)
  				{
  					sub_1= content.substring(0,idx_2);
  					sub_2= content.substring(idx_2+2);				
  					content = sub_1 + tag + sub_2;
  				}
  			}
  		}
  		return content;
  	}

  	/**
     * getDateMilTime - ���� ��¥�ð��� ��� �Լ�(17�ڸ�) : yyyyMMddHHmmssSSS ����
     *
     * @return  String  ���糯¥�ð� yyyyMMddHHmmssSSS
     */
    public static String getDateMilTime() {
        SimpleDateFormat formatter = new SimpleDateFormat ("yyyyMMddHHmmssSSS");
        return formatter.format(new Date());
    }
    
    /**
     * lengthB - �ѱ�/�ѹ��� 2Byte�� ����Ͽ� ���ڿ��� strlen ��ŭ�� ��ȯ�Ѵ�.
     *
     * @param   String  ���ڿ�
     * @return  int     ���ڿ�+...
     */
    public static String checkAltViewByte(String viewstr, int strlen){
    	if(viewstr==null)
    	    return "";
    	String newstrs = "";
    	boolean newgubun = false;
    	int viewstri = lengthB(viewstr);
    	if(viewstr.indexOf("&nbsp;")!=-1){
    		newstrs = viewstr.replaceAll("&nbsp;","@");
    		viewstri = lengthB(newstrs);
    		newgubun = true;
    	}
    	if( viewstri >strlen ){
    		//viewstr = "<span onmouseover=\"showtip('"+viewstr+"');\" onmouseout=\"hidetip();\">"+viewstr.substring(0,strlen)+"..</span>";
    		if(strlen > 3){
    			strlen = strlen - 3;
    		}
    		if(newgubun){
    			viewstr = ""+getSubstr(newstrs,strlen).replaceAll("@","&nbsp;")+"<span title='"+viewstr+"'>...</span>";	
    		}else{
    		
    			viewstr = ""+getSubstr(viewstr,strlen)+"<span title='"+viewstr+"'>...</span>";
    		}
    	    return viewstr;
    	}else{
    	    return viewstr;
    	}
    
    }

    public static String cutStr(String viewstr, int strlen){
    	
        if(viewstr==null) return "";

    	String newstrs = "";
    	
    	boolean newgubun = false;
    	
    	int viewstri = viewstr.length();

    	if( viewstri > strlen ){
    			viewstr = ""+viewstr.substring(0,strlen)+"<span title='"+viewstr+"'>...</span>";	
  		}
    	
    	return viewstr;    
    }     
    
    public static String getSubstr(String pstrs, int len){
        StringBuffer sb = new StringBuffer( Math.round(len*1.1f) );
        int subint = 0;
        for( int i=0 ; i<pstrs.length() ; i++) {
            if(lengthB(pstrs.charAt(i)+"")==2){
            	subint = subint +2;
            }else{
            	subint++;
            }
            sb.append(pstrs.charAt(i)+"");
            if( subint > len )
            	break;
        }
        return sb.toString();
    }
    
    /**
     * lengthB - �ѱ�/�ѹ��� 2Byte�� ����Ͽ� ���ڿ��� ���̸� ��ȯ�Ѵ�.
     *
     * @param   String  ���ڿ�
     * @return  int     ����
     */
    public static int lengthB(String str) {
        return str.getBytes().length;
    }        
    
    /*
     * replace - ���ڿ����� Ư�� ��ū�� ã�Ƽ�, ġȯ�Ѵ�
     *
     * @param   String  �ҽ� ���ڿ�
     * @param   String  �˻� ��ū
     * @return  String  ġȯ�� ���ڿ�
     */
	public static String replace(String src, String token, String repl)	{
		if (src == null) return null;
		String ret = "";
		int len = token.length();
		
		for(int i=0;i<src.length();i++) {
			if(len!=0&&((i+len)<=src.length())&&(src.substring(i,i+len).equals(token))) {
				ret = ret + repl;
				i = i + len -1;
			} else {
				ret = ret + src.substring(i,i+1);
			}
		}
		return ret;
	}
	
    /**
     * dateDiff - �ΰ��� ��¥�� ������ ����Ѵ�.
     *
     * @param   String  ������
     * @param   String  ������
     * @param   String  ������� ����� ���ΰ�("YEAR" : �⵵, "MONTH" : ��, "DAY":��)
     * @return  int     ��¥���� ���� (������ -1)
     */
    public static int dateDiff(String stDate, String toDate, String type) {
    	
    	if ((stDate == null) || (toDate==null)) return -1;
    	stDate = replace(stDate,"-","").trim();
    	toDate = replace(toDate,"-","").trim();
    	if (stDate.length() != 8 || toDate.length() != 8) return -1;
    	
    	if ("YEAR".equals(type.toUpperCase())) {
    		if ((stDate.length() < 4) || (toDate.length() < 4)) return -1;
    		return (Integer.parseInt(stDate.substring(0,4)) - Integer.parseInt(toDate.substring(0,4)));
    	} else if ("MONTH".equals(type.toUpperCase())) {
    		if ((stDate.length() < 6) || (toDate.length() < 6)) return -1;
    		return ((Integer.parseInt(stDate.substring(0,4)) - Integer.parseInt(toDate.substring(0,4)))*12+
    				(Integer.parseInt(stDate.substring(4,6)) - Integer.parseInt(toDate.substring(4,6))));
    	} else if ("DAY".equals(type.toUpperCase())) {
    		if ((stDate.length()!=8) || (toDate.length()!=8)) return -1;	// ����ó��
    		Calendar cal = Calendar.getInstance(), cal2 = Calendar.getInstance();
    		cal.set(Integer.parseInt(stDate.substring(0,4)), Integer.parseInt(stDate.substring(4,6))-1, Integer.parseInt(stDate.substring(6,8)));
    		cal2.set(Integer.parseInt(toDate.substring(0,4)), Integer.parseInt(toDate.substring(4,6))-1,Integer.parseInt(toDate.substring(6,8)));
    		return (int)Math.floor((Math.abs(cal2.getTime().getTime() - cal.getTime().getTime())) / (60*60*24*1000));
    	}
    	return -1;	
    }    
    
    /**

     * dateCal - ��¥�� �޾Ƽ� , Ư�� ��,��,�� ��ŭ ���� ���ڸ� �����Ѵ�.

     *

     * @param   String  ��¥

     * @param   String  ����׸��� ����� ���ΰ�("YEAR":�⵵, "MONTH":��, "DAY":��)

     * @param   int     ��갪

     * @return  String  ���� ��¥

     */

    public static String dateCal(String sDate, String type, int iValue) {

    	if (sDate ==null) return sDate;

    	sDate = replace(sDate,"-","").trim();

    	if (sDate.length() != 8) return sDate;

    	

    	Calendar cal = Calendar.getInstance();

    	cal.set(Calendar.YEAR, Integer.parseInt(sDate.substring(0,4)));

    	cal.set(Calendar.MONTH, (Integer.parseInt(sDate.substring(4,6))-1));

    	cal.set(Calendar.DAY_OF_MONTH,Integer.parseInt(sDate.substring(6,8)));

    

    	if ("YEAR".equals(type.toUpperCase())) {

    		cal.add(Calendar.YEAR,iValue);

    	} else if ("MONTH".equals(type.toUpperCase())) {

    		cal.add(Calendar.MONTH,iValue); 

    	} else if ("DAY".equals(type.toUpperCase())) {

    		cal.add(Calendar.DAY_OF_MONTH,iValue);

    	}

    	String monValue  = Integer.toString(cal.get(Calendar.MONTH)+1);

    	String dateValue = Integer.toString(cal.get(Calendar.DAY_OF_MONTH));

    	

    	monValue  = getLpadB(monValue, "0",2);

    	dateValue = getLpadB(dateValue,"0",2);

    	

    	return Integer.toString(cal.get(Calendar.YEAR))+monValue+dateValue;

    }
    
    /**
     * getLpadB - �ѱ�/�ѹ��� 2Byte�� ����Ͽ� �ʿ��� ���ڸ� ���ʿ� �����Ͽ� ���ϴ� �ڸ����� ����
     *
     * @param   String  �ҽ� ���ڿ�
     * @param   String  �ڸ����� ä�� ����
     * @param   int     �ʿ��� �ڸ���
     * @return  String  ��ȯ�� String
     */
    public static String getLpadB(String str, String apnd, int cipher) {
        StringBuffer sb = new StringBuffer();
        int j = lengthB(str);
        int a = cipher - j;
        for (int i = 1; i <= a; i++) {
            sb.append(apnd);
        }
        sb.append(str);
        return sb.toString();
    }
    
    /**
     * getDayOfWeek - ��¥�� �޾Ƽ� , ������ �����Ѵ�.
     *
     * @param   String  ��¥
     * @return  int     ����(1:��,2:ȭ,3:��,4:��,5:��,6:��,7:��)
     */
    public static int getDayOfWeek(String sDate) {
        if (sDate == null) return 0;
        
        sDate = replace(sDate,"-","");

    	Calendar cal = Calendar.getInstance();
    	cal.set(Integer.parseInt(sDate.substring(0,4)), Integer.parseInt(sDate.substring(4,6))-1,Integer.parseInt(sDate.substring(6)));
    	int nTmp = cal.get(Calendar.DAY_OF_WEEK);
    	if (nTmp == 1) {    // �Ͽ����� ���, 7�� �ٲ۴�. (���� �����ڷ�� ���߱� ���Ͽ�, �̷��� �����Ѵ�)
    	    nTmp = 7;  
    	} else {
    	    nTmp --;
    	}
    	return nTmp;
    }
    
    /**
     * getInt - ���� String��  int������ ��ȯ���ش�.
     *
     * @param   String  ���ڹ��ڿ�
     * @return  int     int�� ����
     */
	public static int getInt(String str) {
		int retValue = 0;
		try {
			if (str == null) {
				return 0;
			} else if (str.trim().equals("")) {
				return 0;
			} else {
				str = replace(str.trim(),",","");
				int pos = str.indexOf(".");
				if (pos != -1) {
					str = str.substring(0, pos);
				}
				retValue = Integer.parseInt(str);
			}
		} catch (Exception e) {
			return 0;
		}
		return retValue;
	}
	
    /**
     * getStrDouble - ���� �κ��� 8�ڸ� �̻�Ǵ� double�� �Ǽ��� �Ҽ����ڷ� ��簪�� �� ������ �Ѵ�.
     *                double���� 8�ڸ� �̻��� ���, 111E+14 ���·� ������ ������ �ذ��ϱ� ���� ��
     *
     * @param   double  ����
     * @return  String  �Ҽ����ڷ� ��簪�� ���� ��
     * ����)
     * 1.2345678901234512E14     ==>   123456789012345.12   
     */
    public static String getStrDouble(double real) throws IllegalArgumentException {
        String strDouble = Double.toString(1529.249135747E05);
        strDouble = strDouble.toUpperCase();
        int indexOfE = strDouble.indexOf("E");
        int indexOfPoint = strDouble.indexOf(".");
        String rawStr = replace(strDouble.substring(0, indexOfE),".","");
        int PorM = getInt(strDouble.substring(indexOfE+1, strDouble.length()));
        
        int pointNum = indexOfE-indexOfPoint+PorM;
        
        StringBuffer sb = new StringBuffer();
        sb.append("##");
        if (pointNum > 0) {
            sb.append(".");
            for (int i = 0; i < pointNum; i++)
                sb.append("#");
        }
        java.text.DecimalFormat df = new java.text.DecimalFormat(sb.toString());
		return df.format(real);
    }
    
    /**
     * getDoubleTrunc - double�� ���ڸ� �Ҽ��� ?�ڸ����� �ݿø�(true) �Ǵ� ����(false)�Ѵ�
     *
     * @param   double  ����
     * @param   int     �Ҽ����� ���ڸ����� �ݿø�
     * @return  String  ���˵� ���ڿ�
     * ����)
     * NumberUtil.getDoubleTrunc( 123403.00143d , 3 , false) ==> 123,403.001
     * NumberUtil.getDoubleTrunc( 123403.00153d , 3 , false) ==> 123,403.002
     * NumberUtil.getDoubleTrunc( 123403.00163d , 3 , false) ==> 123,403.002
     */
	public static double getDoubleTrunc(double in, int scale, boolean bRoundDown) {
		String strDouble = getStrDouble(in);

		double retValue = 0.0;
		if (scale >= (strDouble.length() - (strDouble.indexOf(".") + 1))) {
			retValue = in;
		} else {
			if (bRoundDown) {
				retValue = new BigDecimal(in).setScale(scale, BigDecimal.ROUND_HALF_UP).doubleValue();
			} else {
				retValue = new BigDecimal(in).setScale(scale, BigDecimal.ROUND_DOWN).doubleValue();
			}
		}
		return retValue;
	}
	
	/**
	 * int Type�� Primitive Data�� double �������� �ٲ��ش�.
	 * <br><br><pre>
	 * <b>For Example :</b><br>
	 * 	int i = 100;
	 * 	double d = toD( i );
	 * </pre>
	 * @param i int ������ Primitive Data Type
	 * @return double ������ Primitive Data Type
	 */
	public static double toD(int i){
		
		return i;
	}

	public static String htmlDel(String Word) {		
		
		Word = Word.trim();
		int a = Word.indexOf("<");
		int b = Word.indexOf(">");
		int len = Word.length();

		if(a == -1) {
			return Word;
		}

		String c = Word.substring(0,a);

		if(b == -1) b = a;

		String d = Word.substring((b+1), len);
		Word = c + d;

		int tagCheck = Word.indexOf("<");

		if(tagCheck != -1) Word = htmlDel(Word);

		return Word;			
	}

	public static String getConfig(String key) {
		String result = null;
		ResourceBundle bundle = null;
		
		try {
			if (runMode.equals("")){
				runmodeBundle = ResourceBundle.getBundle("runmode");
				runMode = runmodeBundle.getString("runmode");
			}
		} catch (Exception e) {
			//out.println("Err: "+e.toString());
		}	
		
		if (key.equals("runmode")) {
			return runMode;
		} else {
			try {
				if(configBundle == null) {
					configBundle = ResourceBundle.getBundle(runMode);
				}
				
				result = configBundle.getString(key);
				
			} catch (Exception e) {
				//out.println("Err: "+e.toString());
			}	
			
			return result;
		}
		
	}

}