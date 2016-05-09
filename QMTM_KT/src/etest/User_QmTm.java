package etest;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.Timestamp;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import etest.paper.User_ExamPaper2Bean;

public class User_QmTm
{
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

    public static final String KEYWORD_A = "&#123;&#58;&#125;";   // {:}
    public static final String KEYWORD_B = "&#123;&#124;&#125;";  // {|}
    public static final String KEYWORD_C = "&#123;&#94;&#125;";   // {^}

    public static final String RKEYWORD_A = "KEYWORD_ATYPE";
    public static final String RKEYWORD_B = "KEYWORD_BTYPE";
    public static final String RKEYWORD_C = "KEYWORD_CTYPE";

    public User_QmTm() {
    }

    public static String getName(String userid, String password) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

        sql = "SELECT NAME FROM QT_USERID WHERE (USERID = ?) AND (PASSWORD = ?)";

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, userid);
            stm.setString(2, password);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getString("name"); }
            else { return null; }
        } catch (SQLException ex) {
            throw new QmTmException("응시자 정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [User_QmTm.getName]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    public static String getYn_end (String userid, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

        sql = "SELECT yn_end FROM exam_ans WHERE userid = ? AND id_exam = ? ";

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, userid);
            stm.setString(2, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getString("yn_end"); }
            else { return null; }
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안제출여부 읽어오는중 인터넷 연결상태가 좋지 않습니다. [User_QmTm.getYn_end]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    public static Timestamp getEnd_time (String userid, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

        sql = "SELECT end_time FROM exam_ans WHERE userid = ? AND id_exam = ? ";

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, userid);
            stm.setString(2, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getTimestamp("end_time"); }
            else { return null; }
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안제출시간 읽어오는중 인터넷 연결상태가 좋지 않습니다. [User_QmTm.getEnd_time]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }   
	
	public static boolean hasAnswer (String userid, String id_exam) throws QmTmException
    {
        try {
            String yn_end = getYn_end(userid, id_exam);
            if (yn_end == null) { return false; }  // 답안지 무
            else { return true; }                  // 답안지 유
        }
        catch (Exception ex) {
            throw new QmTmException("응시자 답안제출여부 읽어오는중 인터넷 연결상태가 좋지 않습니다. [User_QmTm.hasAnswer]");
        }
    }

    public static boolean hasSubmit (String userid, String id_exam) throws QmTmException
    {
        try {
            String yn_end = getYn_end(userid, id_exam);
            if (yn_end == null) { yn_end = ""; }
            if (yn_end.equalsIgnoreCase("Y")) { return true; } // 제출
            else { return false; } // 미제출
        }
        catch (Exception ex) {
            throw new QmTmException("응시자 답안제출여부 읽어오는중 인터넷 연결상태가 좋지 않습니다. [User_QmTm.hasSubmit]");
        }
    }

    public static boolean isAuthTester (long id_auth_type, String userid, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        if (id_auth_type == 1) {
            sql.append("SELECT b.userid FROM exam_m a, qt_course_user b ");
            sql.append("WHERE a.id_exam = ? AND b.userid = ? ");
            sql.append("      AND a.id_course = b.id_course ");
            sql.append("      AND a.course_year = b.course_year AND a.course_no = b.course_no ");
            sql.append("      AND a.course_class_no = b.course_class_no ");
        } else {
            sql.append("SELECT userid FROM exam_receipt ");
            sql.append("WHERE id_exam = ? AND userid = ? ");
        }
        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setString(2, userid);
            rst = stm.executeQuery();
            if (rst.next()) { return true; }
            else { return false; }
        } catch (SQLException ex) {
			throw new QmTmException("시험 대상자 여부 읽어오는중 인터넷 연결상태가 좋지 않습니다. [User_QmTm.isAuthTester]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    public static String delTag(String withTag)
    {
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

    public static String changeChar(String withSpecialChar)
    {
        String str = withSpecialChar;
        try {
            str = str.replaceAll("\"", CHAR_PATTERN1);   // " --> @@@ET@@@
            str = str.replaceAll("\\\\", "\\\\\\\\");    // \ --> \\
            str = str.replaceAll(KEYWORD_A, RKEYWORD_A);
            str = str.replaceAll(KEYWORD_B, RKEYWORD_B);
            str = str.replaceAll(KEYWORD_C, RKEYWORD_C);
            return str;
        } catch (Exception ex) {
            return str;
        }
    }

    public static String join(String[] arrString, String del)
    {
        String strJoin = "";
        for (int i = 0; i < arrString.length; i++)
        {
            if (arrString[i] == null) { arrString[i] = ""; }
            if (i < arrString.length - 1) {
                strJoin += arrString[i] + del;
            } else {
                strJoin += arrString[i];
            }
        }
        return strJoin;
    }
    
    public static String getAnsPart(String ansWhole, int maxLen)
    {
        // 답안지창에 응시자 답안의 일부만을 표시해 준다

        String ansPart = "";
        String[] arr = ansWhole.split("&#");
        int index = 0;
        boolean found;
        String tmp;
        char c;

        for (int i = 0; i < arr.length; i++) // for array
        {
            found = false;
            tmp = "";

            // 변경되어 들어간 문자를 되돌려 1글자로
            tmp = arr[i].replaceAll("&lt;", "<");
            tmp = tmp.replaceAll("&gt;", ">");

            for (int j = 0; j < tmp.length(); j++) // for char
            {
                c = tmp.charAt(j);

                if (i == 0) { index++; ansPart += c; }
                else
                {
                    if (j == 0) { ansPart += "&#"; }
                    if (c != ';' && !found) { ansPart += c; } // 유니코드 문자일 경우 길이에서 제외
                    else if (c ==';') { found = true; index++; ansPart += c; }
                    else if (c == ';' && found) { index++; ansPart += c; }
                    else {index++; ansPart += c;}
                }
                if (index >= maxLen) { break; }
            }
            if (index >= maxLen) { break; }
        }
        if (index > maxLen) { ansPart += ".."; }
        return ansPart;
    }

   public static String getAnsDisplay(int qndx, User_ExamPaper2Bean[] qs, String[] arrAnswers, String[] arrExlabel)
    {
        String strAns = "";
        String strAnsK = "";

        if (qs[qndx].getId_qtype() == 5) // 논술형 답안표시
        {
            if (qs[qndx].getUserans().length() == 0) {
                strAns = "(논술)미작성";
            } else {
                strAns = qs[qndx].getUserans();
                strAns = getAnsPart(strAns, DBPool.ANS_MAX_LEN);
                strAns = strAns.replaceAll("<", "&#60;");
                strAns = strAns.replaceAll(">", "&#62;");
            }
        }
        else // 논술형이 아니면
        {
            if (arrAnswers.length == qs.length) {
                strAns = arrAnswers[qndx];
            } else {
                strAns = "";
            }

            if (strAns.equals(""))
            {
                strAns = "&nbsp;"; // 답안무
            }

            // 답안유

            else if (qs[qndx].getExcount() > 0) // 1:OX, 2:선다, 3:복수답안형
            {
                String[] arrEtmp = qs[qndx].getEx_order().split(",");
                String[] arrAtmp = strAns.split(User_QmTm.OR_GUBUN_re, -1);
                strAns = "";
                for (int x = 0; x < arrAtmp.length; x++)
                {
                    for (int z = 0; z < arrEtmp.length; z++)
                    {
                        if (arrAtmp[x].equals(arrEtmp[z])) {
                            strAns += arrExlabel[z] + ",";
                            break;
                        }
                    }
                }
                strAns = strAns.substring(0, strAns.length() - 1);
            } // end of 1:OX, 2:선다, 3:복수답안형

            else // 4:단답형
            {
                String[] arrBuf = strAns.split(User_QmTm.OR_GUBUN_re, -1);
                if (arrBuf.length > 1 ) // 복수답
                {
                    strAns = "";
                    for (int k = 0; k < arrBuf.length; k++)
                    {
                        strAnsK = arrBuf[k];
                        strAnsK = User_QmTm.getAnsPart(strAnsK, DBPool.ANS_MAX_LEN - 1);
                        strAnsK = strAnsK.replaceAll("<", "&#60;");
                        strAnsK = strAnsK.replaceAll(">", "&#62;");
                        strAns += "☞ " + strAnsK + "<br>";
                    }
                }
                else
                {
                    strAns = arrBuf[0];
                    strAns = getAnsPart(strAns, DBPool.ANS_MAX_LEN);
                    strAns = strAns.replaceAll("<", "&#60;");
                    strAns = strAns.replaceAll(">", "&#62;");
                }

            } // end of 4:단답형

        } // end of 논술형이 아닌경우

        return strAns;
    }

    public static String setMoveY() {
        return "<script language='javascript'>parent.fraTest.gMove_YN = 'Y';</script>";
    }
}