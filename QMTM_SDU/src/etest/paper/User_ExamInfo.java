package etest.paper;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.PreparedStatement;

public class User_ExamInfo
{
    public User_ExamInfo() {}

    public static User_ExamInfoBean getBean(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("SELECT a.title, a.yn_open_qa, a.yn_open_score_direct, a.exam_start1, a.exam_end1, ");
        sql.append("       a.log_option, a.id_exam_type, a.yn_sametime, a.id_auth_type, a.id_course, ");
        sql.append("       a.web_window_mode, a.login_start, a.login_end, a.id_ltimetype, ");
        sql.append("       a.id_movepage, a.qcntperpage, a.yn_viewas, a.id_exlabel, ");
        sql.append("       a.fontname, a.fontsize, a.paper_type, a.qcount, a.allotting, ");
        sql.append("       a.setcount, a.limittime, a.id_exam_kind, b.exlabel, a.yn_activex ");
        sql.append("FROM exam_m a, r_exlabel b ");
        sql.append("WHERE a.id_exam = ? AND a.id_exlabel = b.id_exlabel ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return makeBean(rst); }
            else { return null; }
        }
        catch (SQLException ex) {
			throw new QmTmException("시험 정보 읽어오는중 오류가 발생되었습니다. [User_ExamInfo.getBean] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static User_ExamInfoBean getBean(String id_exam, String yn_sametime, Timestamp login_start, Timestamp login_end, Timestamp exam_start1, Timestamp exam_end1) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("SELECT a.title, a.yn_open_qa, a.yn_open_score_direct, ?, ?, ");
        sql.append("       a.log_option, a.id_exam_type, ?, a.id_auth_type, a.id_course, ");
        sql.append("       a.web_window_mode, ?, ?, a.id_ltimetype, ");
        sql.append("       a.id_movepage, a.qcntperpage, a.yn_viewas, a.id_exlabel, ");
        sql.append("       a.fontname, a.fontsize, a.paper_type, a.qcount, a.allotting, ");
        sql.append("       a.setcount, a.limittime, a.id_exam_kind, b.exlabel, a.yn_activex ");
        sql.append("FROM exam_m a, r_exlabel b ");
        sql.append("WHERE a.id_exam = ? AND a.id_exlabel = b.id_exlabel ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setTimestamp(1, exam_start1);
			stm.setTimestamp(2, exam_end1);
			stm.setString(3, yn_sametime);
			stm.setTimestamp(4, login_start);
			stm.setTimestamp(5, login_end);
			stm.setString(6, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return makeBean(rst); }
            else { return null; }
        }
        catch (SQLException ex) {
			throw new QmTmException("시험 정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [User_ExamInfo.getBean]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static User_ExamInfoBean makeBean (ResultSet rst) throws QmTmException
    {
        try {
            // exam_m a
            User_ExamInfoBean bean = new User_ExamInfoBean();
            bean.setTitle(rst.getString(1));
            bean.setYn_open_qa(rst.getString(2));
            bean.setYn_open_score_direct(rst.getString(3));
            bean.setExam_start1(rst.getTimestamp(4));
            bean.setExam_end1(rst.getTimestamp(5));
            bean.setLog_option(rst.getString(6));
            bean.setId_exam_type(rst.getInt(7));
            bean.setYn_sametime(rst.getString(8));
            bean.setId_auth_type(rst.getInt(9));
            bean.setId_course(rst.getString(10));
            bean.setWeb_window_mode(rst.getInt(11));
            bean.setLogin_start(rst.getTimestamp(12));
            bean.setLogin_end(rst.getTimestamp(13));
            bean.setId_ltimetype(rst.getString(14));
            bean.setId_movepage(rst.getString(15));
            bean.setQcntperpage(rst.getInt(16));
            bean.setYn_viewas(rst.getString(17));
            bean.setId_exlabel(rst.getInt(18));
            bean.setFontname(rst.getString(19));
            bean.setFontsize(rst.getInt(20));
            bean.setPaper_type(rst.getInt(21));
            bean.setQcount(rst.getInt(22));
            bean.setAllotting(rst.getDouble(23));
            bean.setSetcount(rst.getInt(24));
            bean.setLimittime(rst.getLong(25));
			bean.setId_exam_kind(rst.getInt(26));
            // exlabel e
            bean.setExlabel(rst.getString(27));
            bean.setYn_activex(rst.getString(28));
            return bean;
        } catch (SQLException ex) {
			throw new QmTmException("시험 정보 읽어오는중 오류가 발생되었습니다. [User_ExamInfo.makeBean] " +ex.getMessage());
        }
    }

    public static String getExLabel(long id_exlabel) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

        sql = "SELECT exlabel FROM r_exlabel WHERE id_exlabel = ?";

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setLong(1, id_exlabel);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getString(1); }
            else { return null; }
        } catch (SQLException ex) {
			throw new QmTmException("보기유형 정보 읽어오는중 오류가 발생되었습니다. [User_ExamInfo.getExLabel] " +ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
    
	public static String isCorrectExamPassword(String id_exam, String exam_password) throws QmTmException
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();
		String result = null;


        sql.append(" SELECT CASE WHEN EXAM_PWD_STR = ? THEN 'TRUE' ELSE 'FALSE' END AS IS_CORRECT_EXAM_PWD ");
        sql.append(" FROM EXAM_M ");
        sql.append(" WHERE ID_EXAM = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());

            stm.setString(1, exam_password);
            stm.setString(2, id_exam);
			
            rst = stm.executeQuery();
            if (rst.next()) { 
				result = rst.getString("IS_CORRECT_EXAM_PWD");
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 관리자 확인코드 정보를 읽어오는중 오류가 발생되었습니다. [User_ManagerConfirm.getBean] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }

		return result;

	}	
}