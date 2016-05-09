package qmtm;

public class QmTm {
	// Delimitters
	public static final String Q_GUBUN = "{:}";

	public static final String LIKE_GUBUN = "{^}";

	public static final String OR_GUBUN = "{|}";

	public static final String JOIN_GUBUN = "##JOIN##";

	// Regular Expression
	public static final String Q_GUBUN_re = "\\{:\\}";

	public static final String LIKE_GUBUN_re = "\\{\\^\\}";

	public static final String OR_GUBUN_re = "\\{\\|\\}";

	// pattern
	public static final String CHAR_PATTERN1 = "@@@ET@@@";

	public static final String CHAR_PATTERN2 = "AAAAETAAAA";

	public static final String CHAR_PATTERN3 = "BBBBETBBBB";

	public static final String CHAR_PATTERN4 = "\""; // double quotation (")

	public static final String KEYWORD_A = "&#123;&#58;&#125;"; // {:}

	public static final String KEYWORD_B = "&#123;&#124;&#125;"; // {|}

	public static final String KEYWORD_C = "&#123;&#94;&#125;"; // {^}

	public static final String RKEYWORD_A = "KEYWORD_ATYPE";

	public static final String RKEYWORD_B = "KEYWORD_BTYPE";

	public static final String RKEYWORD_C = "KEYWORD_CTYPE";

	public QmTm() {
	}
    
    public static String delTag(String withTag) {
        String str = withTag;
        try {
            str = str.replaceAll("<P>|<p>|</P>|</p>", "");
            str = str.replaceAll("\r\n|\n", "<br>"); // carrage_return, new_line            
			str.replaceAll("\\\\", "&#92;");           // 원화표시
            return str;
        } catch (Exception ex) {
            return str;
        }
    }

	public static String delTag2(String withTag) {
        String str = withTag;
        try {
            str = str.replaceAll("<P>|<p>|</P>|</p>", "");
            //str.replaceAll("\\\\", "&#92;"); // 원화표시
            return str;
        } catch (Exception ex) {
            return str;
        }
    }

    public static String changeChar(String withSpecialChar) {
        String str = withSpecialChar;
        try {
			str = str.replaceAll("\"", "");   // " --> @@@ET@@@
            str = str.replaceAll("‘", "");    // \ --> \\
			str = str.replaceAll("’", "");    // \ --> \\
            str = str.replaceAll(";", "");    // \ --> \\
            return str;
        } catch (Exception ex) {
            return str;
        }
    }

	public static String changeTag(String withSpecialChar) {
        String str = withSpecialChar;
        try {
			str = str.replaceAll("<P>", "");   // " --> @@@ET@@@
            str = str.replaceAll("</P>", "");    // \ --> \\
            return str;
        } catch (Exception ex) {
            return str;
        }
    }


    public static String join(String[] arrString, String del) {
        String strJoin = "";
        for (int i = 0; i < arrString.length; i++) {
        	
            if (arrString[i] == null) arrString[i] = ""; 
            
            if (i < arrString.length - 1) strJoin += arrString[i] + del;
            else strJoin += arrString[i];
            
        }
        return strJoin;
    }

	public static String ExRandom(int cnts, String randomtype) {
		int[] arr = new int[cnts];
		String ex_orders = "";

		if(randomtype.equals("NT") || randomtype.equals("YT")) {
	        for(int i=0; i<arr.length; i++) { 
		        arr[i] = (int)((Math.random()*cnts)+1);

			    for(int j=0; j<i; j++) {
				    if(arr[i]==arr[j]) {
					    i--;
						break;
	                }
		        }
			}
		} else {
			for(int i=0; i<arr.length; i++) { 
		        arr[i] = i + 1;
			}
		}
	    
		for(int k=0; k<arr.length; k++) {
			ex_orders = ex_orders + arr[k] + ",";
		}

		return ex_orders.substring(0,ex_orders.length()-1);
	}

	public static int getMax(String[] array) {
        int max = 0;

        for(int i=0; i<array.length; i++) {
            if(max < Integer.parseInt(array[i])) {
                max = Integer.parseInt(array[i]);
            }
        }

        return max;
    }

	public static String getReplace(String params) {
		
		String content = "";
		
		content = params.replace("<P>&nbsp;</P>", "<BR>");
		content = params.replace("\"", "&#34;");
		content = params.replace("&nbsp;", " ");
		
		return content;
	}

	public static String getNullChk(String params) {
		if (params == null) { params = ""; } else { params = params.trim(); }

		return params;
	}

	public static double getDblChk(String params) {

		double res = 0;

		if (params == null) { res = 0.0; } else { res = Double.parseDouble(params); }

		return res;
	}

	public static int getIntChk(String params) {

		int res = 0;

		if (params == null) { res = 0; } else { res = Integer.parseInt(params); }

		return res;
	}
}