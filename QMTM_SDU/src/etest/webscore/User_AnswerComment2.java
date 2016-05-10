package etest.webscore;

//Package Import
import qmtm.DBPool;
import qmtm.QmTm;
import qmtm.ComLib;
import qmtm.QmTmException;
import etest.*;

import java.sql.*;
import java.util.*;

// for exam/etst.jsp

public class User_AnswerComment2
{
    public User_AnswerComment2() {}

    public static String getComments(String id_exam, String userid, long id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

        sql = "SELECT score_comment FROM exam_ans_comment "
            + " WHERE id_exam = ? and userid = ? and id_q = ? ";

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);
			stm.setString(2, userid);
            stm.setLong(3, id_q);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getString("score_comment"); }
            else { return ""; }
        } catch (SQLException ex) {            
			throw new QmTmException("서술형 강평 정보 읽어오는 중 오류가 발생되었습니다. [AnswerComment2.getComments] " +ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }	
}
