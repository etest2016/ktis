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
	
	// 일괄등록 보기 원문자 처리
	public static String text_convert(String ca) {
				
		ca = ca.trim();
		ca = ComLib.htmlDel(ca);
		ca = ca.replaceAll("①","1");
		ca = ca.replaceAll("②","2");
		ca = ca.replaceAll("③","3");
		ca = ca.replaceAll("④","4");
		ca = ca.replaceAll("⑤","5");
		
		return ca;
	}
	
	public static String removeAndDel(String str) {
		str = str.replaceAll("&NBSP;","");
		str = str.replaceAll("&nbsp;","");
		str = str.replaceAll("&lt","");
		str = str.replaceAll("&gt","");
		
		return str;
	}
	
	// 문제 일괄등록 할경우 문장 끝에 &nbsp;태그 제거
	public static String removeNBSP(String str) {
		
		str = str.replaceAll("&NBSP;","");
		str = str.replaceAll("&nbsp;","");
		
		return str;
	}
	
	// 문제 일괄등록 할경우 문장 끝에 <pre>태그 제거
	public static String removePre(String str) {
		
		str = str.replaceAll("</PRE>","");
		str = str.replaceAll("</pre>","");
		
		return str;
	}

	// 문제 일괄등록 할경우 문장 끝에 <br>태그 제거
	public static String removeBR2(String str) {
		
		str = str.replaceAll("<br>","");
		str = str.replaceAll("<BR>","");
		
		return str;
	}
	
	// 문제 일괄등록 할경우 문장 앞에 &nbsp;태그 제거
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
     * jsp변수를 단순html로 보여주려할때 html태그를 깨먹을 소지가 있는 문자를 변환하여 준다.
     *  주로 보여주는 용도로 사용되는 html문자열에만 사용한다.
     *  예) String abc = "ab<>cd\"asdf\'sdd     fsdf";
     *   <td><%=toStrHtml(abc)%></td>
     * @param str  : 치환전 문자열
     * @return str : 치환된 문자열
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
     * jsp변수를 <input> Tag에 입력시 사용한다. : " (double quotation)문자를 변환하여 준다.
     *  코드성 데이터를 제외한 input Tag에 사용한다.
     *  예) String abc = "abcd\"asdfsddfsdf";
     *   <input type="text" name="abc" value="<%=toStrInput(abc)%>">
     * @param str  : 치환전 문자열
     * @return str : 치환된 문자열
     */
    public static String toStrInput(String str) {
        str = getReplace(str, "\"","&quot;");
        return str;
    }

    /**
     * jsp변수를 script에서 쓰일경우 사용 : \n, \ 등의 스크립트 에러발생 가능한 문자를 변환하여 준다.
     *  예) String abc = "asdf\n\nsfsdffd\naf\sfsf\n";
     *   [script]form.abc.value = "<%=toStrScript(abc)%>";[/script]
     * @param str  : 치환전 문자열
     * @return str : 치환된 문자열
     */
    public static String toStrScript(String str) {
        str = getReplace(str, "\r", "");
        str = getReplace(str, "\n", "\\n");
        return str;
    }
    /**
     * 문자열이 null 또는 길이가 0 인지Chcek
     * @param str : check 문자열
     * @return null이면 true, null이 아니면 false
     */
    public static boolean isEmpty(String str) {
        if ( (str == null) || (str.trim().length() == 0) ) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 테이블처리시 셀의 공란을 "&nbsp;"로 대체
     * @param str check 문자열
     * @return null이면 "&nbsp;", null이 아니면 false
     */
    public static String nbsp(String str) {
        if ( str == null || str.trim().length() == 0 ||  str.trim().equals("0") )
            return "&nbsp;";
        return str;
    }

    /**
     * 숫자에 0을 붙여 return
     * 예) zrStr(1, 3) => "001"
     * @param lNum 출력할 숫자
     * @param lSiz return할 String의 크기
     * @return lSiz 앞에 '0'이붙는 String
     */
    public static String zrStr(int lNum, int lSiz) {
        int i;
        StringBuffer lStr = new StringBuffer();
        lStr.append("00000000000000000");
        lStr=lStr.append(String.valueOf(lNum));
        return lStr.toString().substring(lStr.length()-lSiz);
    }

    /**
     * 숫자에 0을 붙여 return
     * 예) zrStr(1, 3) => "001"
     * @param lNum 출력할 숫자
     * @param lSiz return할 String의 크기
     * @return lSiz 앞에 '0'이붙는 String
     */
    public static String zrStr(String lNum, int lSiz) {
        int i;
        StringBuffer lStr = new StringBuffer();
        lStr.append("00000000000000000");
        lStr=lStr.append(lNum);
        return lStr.toString().substring(lStr.length()-lSiz);
    }

    /**
     * 포맷에 따라 시분초 리턴
     * 예) getTime("hh-mm-ss") -->   "05-39-56"
     * 예) getTime("HH-mm-ss") -->   "17-39-56"
     * 예) getTime("hh-mm")    -->   "05-39"
     * 예) getTime("hhmm")     -->   "0539"
     * @param fmtstr 8자리 "hh-mm-ss"
     * @return 주어진 format에 따른 시분초 시간
     */
    public static String getTime(String fmtstr) {
        java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat(fmtstr);
        String str = fmt.format(new Date());
        return str;
    }

    /**
     * 현재일부터 Rng의 일자를 리턴
     * 예) dayRange(180); -->   현재일부터 180일전의 일자
     * @param Rng 전의 일수
     * @return "20040101"형의 배열형 일자문자열
     */
    public static String[] dayRange(int Rng) {
        String[] dayAry = new String[Rng];
        GregorianCalendar today = new GregorianCalendar();

        dayAry[0] = String.valueOf(today.get(GregorianCalendar.YEAR)) + zrStr((today.get(GregorianCalendar.MONTH) + 1), 2) + zrStr(today.get(GregorianCalendar.DATE), 2);
        for ( int mcnt = 1 ; mcnt < Rng; mcnt++ ) {
            today.add(GregorianCalendar.DATE, -1);   // 1 감소
            dayAry[mcnt] = String.valueOf(today.get(GregorianCalendar.YEAR)) + zrStr((today.get(GregorianCalendar.MONTH) + 1), 2) + zrStr(today.get(GregorianCalendar.DATE), 2);
        }
        return dayAry;
    }

    /**
     * 기준일에 rng데이터를 더하여 리턴(구분에 따라 년, 월, 일)
     * @param gijun_date
     * @param rng
     * @return 기준일부터 rng의 일자 20040101
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
     * 현재일에 rng의 일자만큼 더하여 리턴
     * @param rng
     * @return 현재일부터 rng의 일자 20040101
     */
    public static String befdate(int rng) {
        GregorianCalendar today = new GregorianCalendar();
        today.add(GregorianCalendar.DATE, rng);
        return String.valueOf(today.get(GregorianCalendar.YEAR)) + dateSep + zrStr((today.get(GregorianCalendar.MONTH) + 1), 2) + dateSep + zrStr(today.get(GregorianCalendar.DATE), 2);
    }

    /**
     * 현재일에 rng의 월만큼 더하여 리턴
     * @param rng
     * @return 현재일부터 (rng)월 전/후 의 일자 20040101
     */
    public static String befMonth(int rng) {
        GregorianCalendar today = new GregorianCalendar();
        today.add(GregorianCalendar.MONTH, rng);
        return String.valueOf(today.get(GregorianCalendar.YEAR)) + dateSep + zrStr((today.get(GregorianCalendar.MONTH) + 1), 2) + dateSep + zrStr(today.get(GregorianCalendar.DATE), 2);
    }

    /**
     * 현재일에 rng의 년만큼 더하여 리턴
     * @param rng
     * @return 현재일부터 (rng)년
     */
    public static String befYear(int rng) {
        GregorianCalendar today = new GregorianCalendar();
        today.add(GregorianCalendar.YEAR, rng);
        return String.valueOf(today.get(GregorianCalendar.YEAR)) + dateSep + zrStr((today.get(GregorianCalendar.MONTH) + 1), 2) + dateSep + zrStr(today.get(GregorianCalendar.DATE), 2);
    }

    /**
     * 8자리 날짜 String에 dateSep를 붙여 return
     * 예) insSep("20040101") -->  "2004-01-01" (dateSep가 "-"일 경우)로 변환
     * @param str 8자리 날짜 String
     * @return dateSep가 포함된 날짜 String
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
     * date type String에서 dateSep 삭제
     * 예) delSep("2004-01-01") --> "20040101" 로 변환 (dateSep가 "-"가 일경우)
     * @param strdate 2004.01.01
     * @return dateSep가 빠진 8자리 날짜문자열
     * @throws Exception
     */
    public static String delSep(String strdate) throws Exception {
        if ( strdate == null ) return "";
        strdate = strdate.trim();
        return getReplace(strdate,dateSep,"");
    }

    /**
     * yyyyMMdd 형식의 현재일자 (dateSep 무시)
     * @return 당일날짜을 "yyyyMMdd return
     * @throws Exception
     */
    public static String getCurYmd() throws Exception {
        java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("yyyyMMdd");
        String str = fmt.format(new Date());
        return str;
    }

    /**
     * yyyy-MM-dd 형식의 현재일자 (dateSep가 "-" 일경우, "." 일경우는 yyyy.MM.dd)
     * @return 당일날짜을 "yyyy-MM-dd return
     * @throws Exception
     */
    public static String getYmd() throws Exception {
        java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("yyyy"+dateSep+"MM"+dateSep+"dd");
        String str = fmt.format(new Date());
        return str;
    }

    /**
     * yyyy-MM 형식의 당월 (dateSep가 "-" 일경우 ".", 일경우는 yyyy.MM.dd)
     * @return 당월을 "yyyy-MM" return
     * @throws Exception
     */
    public static String getYm() throws Exception {
        java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("yyyy"+dateSep+"MM");
        String str = fmt.format(new Date());
        return str;
    }

    /**
     * yyyy 형식의 당년도
     * @return 당년을 "YYYY"로 return
     * @throws Exception
     */
    public static String getYyyy() throws Exception {
        java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("yyyy");
        String str = fmt.format(new Date());
        return str;
    }

    /**
     * 당해년도에 rng의 년만큼 더하여 리턴
     * @param rng 현재년에 (rng)년을 더한 년도
     * @return 더해진년도
     */
     public static String getYyyy(int rng) {
         GregorianCalendar today = new GregorianCalendar();
         today.add(GregorianCalendar.YEAR, rng);
         return String.valueOf(today.get(GregorianCalendar.YEAR));
     }

    /**
     * 주민등록번호 13자리에 "-"를 넣어서 리턴한다.
     * @param str 주민등록번호
     * @return 123456-1234567 형태의 String
     * @throws Exception
     */
    public static String getJumin(String str) throws Exception  {
        if(str == null || str.length()<13 )
            return str;
        return (new StringBuffer().append(str.substring(0,6)).append("-").append(str.substring(6)).toString());
    }

    /**
     * 우편번호 6자리에 "-"를 넣어서 리턴한다.
     * @param str 우편번호
     * @return 123-123 형태의 String
     * @throws Exception
     */
    public static String getPost(String str) throws Exception {
        if(str == null || str.length() < 6 )
            return str;
        return (new StringBuffer().append(str.substring(0,3)).append("-").append(str.substring(3)).toString());
    }

    /**
     * Integer을 string형 변환
     *  예)numToStr(999990) => 999,990(String)
     * @param inttemp Integer
     * @return 숫자형식으로 포맷된 String
     * @throws Exception
     */
    public static String numToStr(Integer inttemp) throws Exception {
        DecimalFormat df = new DecimalFormat("##,###,###,##0");
        if ( inttemp == null )
            return "0";
        return df.format(inttemp) ;
    }

    /**
     * integer을 string형 변환
     *  예)numToStr(999990) => 999,990(String)
     * @param inttemp integer
     * @return 숫자형식으로 포맷된 String
     * @throws Exception
     */
    public static String numToStr(int inttemp) throws Exception  {
        DecimalFormat df = new DecimalFormat("##,###,###,##0");
        return df.format(inttemp) ;
    }

    /**
     * Double을 String형 변환
     * 예)numToStr( 2000.54 ) => 2,000.54
     * @param dbltemp : Double type의 값
     * @return 숫자형식으로 포맷된 String
     * @throws Exception
     */
    public static String numToStr(Double dbltemp) throws Exception {
        double dbl = dbltemp.doubleValue();
        DecimalFormat df = new DecimalFormat("##,###,###,##0.00");
        if(dbltemp==null)  return "0";
        return df.format(dbl) ;
    }

    /**
     * double을 String형 변환
     * 예)numToStr( 2000.54 ) => 2,000.54
     * @param dbltemp : Double type의 값
     * @return 숫자형식으로 포맷된 String
     * @throws Exception
     */
    public static String numToStr(double dbltemp) throws Exception {
        DecimalFormat df = new DecimalFormat("##,###,###,##0.00");
        return df.format(dbltemp) ;
    }

    /**
     * 숫자로만 된 String을 포맷팅
     * 예)numToStr( "2000.54") => 2,000.54
     * @param strtemp : 숫자문자열
     * @return 숫자형식으로 포맷된 String
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
     * 숫자로만 된 String을 주어진 인수에 따라 포맷팅
     * 예)numToStr( "2000.54", "###,##0.00") => 2,000.54
     * @param strtemp : 숫자문자열
     * @param fmt : 포맷마스크
     * @return 숫자형식으로 포맷된 String
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
     * 문자형 숫자에서 comma 제거
     *  예)delComma("2,000"),delComma("2,000.00");
     * @param  comma  삭제할 String
     * @return comma가 제거된 String
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
     * String 을 int로 변환, null일경우 0으로 리턴
     * 예)nullChkInt( "123456" ) => 123456
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
     * String 을 int로 변환, null일경우 0으로 리턴
     * 예)nullChkInt( "123456" ) => 123456
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
     * string 을 double형으로 변환, null일경우 0.0으로 리턴
     * @param Wtemp 숫자형식으로 포맷된 String
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
     * String이 null이면  공백 문자열 return하고 null이 아니면 전달받은 String을 trim()후 다시 return
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
     * String이 null이면  def로 문자열 을return하고 null이 아니면 전달받은 String을 trim()후 다시 return
     * 단 def도 null일경우는 ""값으로 리턴
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
     * 특정 토큰을 이용하여 문자열 자르른후 String 배열로 리턴한다.
     * getParser( "abc|def", "|")
     * return : [0]=abc [1]=def
     * @param str 필터문자가 포함된 문자열
     * @param sep 필터문자
     * @return String배열
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
		//마지막에 구분자가 있는지 check
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
     * 메시지 다이제스트 문자열을 만든다 : java.security.MessageDigest
     * @param passwd
     * @return result 처리된 문자열
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
     * 문자열을 16진수로 변환한다. ( getSecurity 에서 참조 )
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
     * 문자열 치환 : str이 NULL  일 경우 "" 리턴
     *  예) getReplace( "string\nstring\n", "\n", "<br>")
     *      return : string<br>string<br>
     * @param str 치환될 문자열이 포함된 문자열
     * @param sTo 치환 전 문자
     * @param sFrom 치환 후 문자
     * @return String
     */
    public static String getReplace ( String str,String sTo, String sFrom ) {
        int count = 0;
        int index = 0;
        int index2 = 0;
        int slen = sTo.length() ; // 치환될 문자열길이

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
		err_msg = err_msg + toStrScript("\n\n") + "담당자에게 문의해주시기 바랍니다.";
		                		
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
		str.append("alert('로그인 하셔야 이용하실 수 있습니다.');");
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
     * WebtException error message을 에러팝업으로 string return
     * @param service WebtService
     * @return error message을 alert가 포함된 String
     * @throws Exception
     */
    public static String getExceptionMsg(Exception e, String bigo) throws Exception {
        StringBuffer str = new StringBuffer();

        String err_msg   = e.getLocalizedMessage();
		err_msg = err_msg.replace("'","");
		err_msg = err_msg + toStrScript("\n\n") + "관리자에게 문의해주시기 바랍니다.";
		                
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
     * 전화번호로 묶어서 리턴한다.
     *  예) makePhoneNumber("02","1234","5678");
     *  return "02-1234-5678"
     * @param phone1
     * @param phone2
     * @param phone3
     * @return buf.toString() '-'로 연결된 전화번
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
     * 문자열에 앞에 filler 문자열을 채워넣는다.
     *  예) fillFront("9",10,"0");
     *  return "0000000009"
     * @param str    : 문자열 원본
     * @param len    : 총문자의 길이
     * @param filler : 채워넣을 공백문자열
     * @return len 길이로 채워진 str문자열
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
     * 문자열에 뒤에 filler 문자열을 채워넣는다.
     *  예) fillRear("9",10,"0");
     *  return "0000000009"
     * @param str    : 문자열 원본
     * @param len    : 총문자의 길이
     * @param filler : 채워넣을 공백문자열
     * @return len 길이로 채워진 str문자열
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
     * '-'로 연결된 전화번호를 나눠서 String배열로 리턴한다.
     * @param phoneNumber
     * @return returnValue : 나뉘어진 String[] 전화번호
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
     * Method cropByte. 문자열 바이트수만큼 끊어주고, 생략표시하기
     *  예) cropByte("가나다라마abcde", 6, "...")
     *      return "가나다라마a..."
     *      cropByte("가나다라마바abcde", 6, "...")
     *      return "가나다라마바..."
     * @param str 문자열
     * @param i 바이트수
     * @param trail 생략 문자열. 예) "..."
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
     * 현재 날짜 및 시간 정보를 일정형식의 문자열로 리턴합니다
     * @return String       포맷된 현재 날짜 및 시간 문자열
     */
    public static String getCurrentDate() {
            SimpleDateFormat df = new SimpleDateFormat("<yyyy/MM/dd - HH:mm:ss>") ;
            return df.format(new Date()) ;
    }

    /**
     * &, ' ' @ 등을 인코팅한다.
     * @param str : URLEncoder로 인코딩할 String
     * @return URLEncoder.encode(str)
     */
    public static String encode(String str) {
        return URLEncoder.encode(str);
    }

    /**
     * 인코딩되어 들어온 &, ' ' @ 등의 문자를 디코딩한다.
     * @param str : URLDecoder로 디코딩할 String
     * @return URLDecoder.decode(str)
     */
    public static String decode(String str) {
        return URLDecoder.decode(str);
    }

    /**
     * 인코딩 타입을 KSC5601로 바꿈
     * @param str : 변환할 문자열
     * @return String KSC5601로 변환된 문자열
     * @throws Exception
     */
    public static String toKor(String str) throws Exception {
      return new String(str.getBytes("8859_1"), "EUC-KR");
    }

    /**
     * 인코딩 타입을 8859_1로 바꿈
     * @param str : 변환할 문자열
     * @return String 8859_1로 변환된 문자열
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

    /* 글내용중에 엔터키값에 <br> 태크 넣어주기
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
     * getDateMilTime - 현재 날짜시간를 얻는 함수(17자리) : yyyyMMddHHmmssSSS 포맷
     *
     * @return  String  현재날짜시간 yyyyMMddHHmmssSSS
     */
    public static String getDateMilTime() {
        SimpleDateFormat formatter = new SimpleDateFormat ("yyyyMMddHHmmssSSS");
        return formatter.format(new Date());
    }
    
    /**
     * lengthB - 한글/한문을 2Byte로 계산하여 문자열을 strlen 만큼만 반환한다.
     *
     * @param   String  문자열
     * @return  int     문자열+...
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
     * lengthB - 한글/한문을 2Byte로 계산하여 문자열의 길이를 반환한다.
     *
     * @param   String  문자열
     * @return  int     길이
     */
    public static int lengthB(String str) {
        return str.getBytes().length;
    }        
    
    /*
     * replace - 문자열중의 특정 토큰을 찾아서, 치환한다
     *
     * @param   String  소스 문자열
     * @param   String  검색 토큰
     * @return  String  치환된 문자열
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
     * dateDiff - 두개의 날짜의 간격을 계산한다.
     *
     * @param   String  시작일
     * @param   String  종료일
     * @param   String  어느것을 계산할 것인가("YEAR" : 년도, "MONTH" : 월, "DAY":일)
     * @return  int     날짜간의 차이 (오류시 -1)
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
    		if ((stDate.length()!=8) || (toDate.length()!=8)) return -1;	// 오류처리
    		Calendar cal = Calendar.getInstance(), cal2 = Calendar.getInstance();
    		cal.set(Integer.parseInt(stDate.substring(0,4)), Integer.parseInt(stDate.substring(4,6))-1, Integer.parseInt(stDate.substring(6,8)));
    		cal2.set(Integer.parseInt(toDate.substring(0,4)), Integer.parseInt(toDate.substring(4,6))-1,Integer.parseInt(toDate.substring(6,8)));
    		return (int)Math.floor((Math.abs(cal2.getTime().getTime() - cal.getTime().getTime())) / (60*60*24*1000));
    	}
    	return -1;	
    }    
    
    /**

     * dateCal - 날짜를 받아서 , 특정 일,달,년 만큼 계산된 날자를 리턴한다.

     *

     * @param   String  날짜

     * @param   String  어느항목을 계산할 것인가("YEAR":년도, "MONTH":월, "DAY":일)

     * @param   int     계산값

     * @return  String  계산된 날짜

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
     * getLpadB - 한글/한문을 2Byte로 계산하여 필요한 문자를 왼쪽에 포함하여 원하는 자릿수로 만듬
     *
     * @param   String  소스 문자열
     * @param   String  자릿수를 채울 문자
     * @param   int     필요한 자릿수
     * @return  String  변환된 String
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
     * getDayOfWeek - 날짜를 받아서 , 요일을 리턴한다.
     *
     * @param   String  날짜
     * @return  int     요일(1:월,2:화,3:수,4:목,5:금,6:토,7:월)
     */
    public static int getDayOfWeek(String sDate) {
        if (sDate == null) return 0;
        
        sDate = replace(sDate,"-","");

    	Calendar cal = Calendar.getInstance();
    	cal.set(Integer.parseInt(sDate.substring(0,4)), Integer.parseInt(sDate.substring(4,6))-1,Integer.parseInt(sDate.substring(6)));
    	int nTmp = cal.get(Calendar.DAY_OF_WEEK);
    	if (nTmp == 1) {    // 일요일일 경우, 7로 바꾼다. (기존 휴일자료와 맞추기 위하여, 이렇게 변경한다)
    	    nTmp = 7;  
    	} else {
    	    nTmp --;
    	}
    	return nTmp;
    }
    
    /**
     * getInt - 숫자 String을  int형으로 반환해준다.
     *
     * @param   String  숫자문자열
     * @return  int     int형 숫자
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
     * getStrDouble - 정수 부분이 8자리 이상되는 double형 실수를 소수점뒤로 모든값이 다 나오게 한다.
     *                double형이 8자리 이상일 경우, 111E+14 형태로 나오는 문제를 해결하기 위한 것
     *
     * @param   double  숫자
     * @return  String  소수점뒤로 모든값이 나온 값
     * 설명)
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
     * getDoubleTrunc - double형 숫자를 소수점 ?자리에서 반올림(true) 또는 버림(false)한다
     *
     * @param   double  숫자
     * @param   int     소수점을 몇자리에서 반올림
     * @return  String  포맷된 문자열
     * 예시)
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
	 * int Type의 Primitive Data를 double 형식으로 바꿔준다.
	 * <br><br><pre>
	 * <b>For Example :</b><br>
	 * 	int i = 100;
	 * 	double d = toD( i );
	 * </pre>
	 * @param i int 형식의 Primitive Data Type
	 * @return double 형식의 Primitive Data Type
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