package qmtm.common;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class ExamInfo
{
    public ExamInfo() {}

    public static ExamInfoBean getBean(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("SELECT a.id_exam, a.title, a.qcount, a.allotting, b.exlabel, a.id_auth_type ");
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
            throw new QmTmException("시험 정보 읽어오는 중 오류가 발생되었습니다. [ExamInfo.getBean] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static ExamInfoBean makeBean (ResultSet rst) throws QmTmException
    {
        try {
            ExamInfoBean bean = new ExamInfoBean();
            bean.setId_exam(rst.getString(1));
			bean.setTitle(rst.getString(2));
            bean.setQcount(rst.getInt(3));
            bean.setAllotting(rst.getDouble(4));
            bean.setExlabel(rst.getString(5));
			bean.setId_auth_type(rst.getInt(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험 정보 읽어오는 중 오류가 발생되었습니다. [ExamInfo.makeBean] " + ex.getMessage());
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
            throw new QmTmException("보기 유형 정보 읽어오는 중 오류가 발생되었습니다. [ExamInfo.getExLabel] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}