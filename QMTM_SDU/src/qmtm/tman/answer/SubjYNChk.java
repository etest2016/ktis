package qmtm.tman.answer;

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
import java.sql.PreparedStatement;

public class SubjYNChk
{
    public SubjYNChk() {
    }

	public static SubjYNChkBean[] getBeans(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT userid, name, score1, score2, success_score1, success_score2, success_yn ");
		sql.append("From exam_gubun_score ");
		sql.append("Where id_exam = ? ");
		sql.append("Order by name ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            SubjYNChkBean bean = null;
            while (rst.next()) {
                bean = makeGrpBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (SubjYNChkBean[]) beans.toArray(new SubjYNChkBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("과락점수 정보 읽어오는 중 오류가 발생되었습니다. [SubjYNChk.getBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static SubjYNChkBean makeGrpBeans (ResultSet rst) throws QmTmException
    {
		try {
            SubjYNChkBean bean = new SubjYNChkBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
            bean.setScore1(rst.getString(3));
			bean.setScore2(rst.getString(4));
			bean.setSuccess_score1(rst.getString(5));
			bean.setSuccess_score2(rst.getString(6));
			bean.setSuccess_yn(rst.getString(7));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("과락점수 정보 읽어오는 중 오류가 발생되었습니다. [SubjYNChk.makeGrpBeans] " + ex.getMessage());
     	}
    }

	public static void delete(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Delete From exam_gubun_score ");
		sql.append("Where id_exam = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
		
			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("과락점수 삭제 중 오류가 발생되었습니다. " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void insert(String id_exam, String userid, String name, String score1, String score2, String success_score1, String success_score2, String success_yn) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO EXAM_GUBUN_SCORE (id_exam, userid, name, score1, score2, success_score1, success_score2, success_yn, regdate) ");
        sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, getdate()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, userid);
            stm.setString(3, name);
			stm.setString(4, score1);
			stm.setString(5, score2);
			stm.setString(6, success_score1);
			stm.setString(7, success_score2);
			stm.setString(8, success_yn);

			stm.execute();

			update(id_exam);
        }
        catch (SQLException ex) {
            throw new QmTmException("과락점수 등록 중 오류가 발생되었습니다. " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update EXAM_ANS ");
		sql.append("       Set yn_success = a.success_yn ");
		sql.append("From EXAM_GUBUN_SCORE a, EXAM_ANS B ");
		sql.append("Where a.id_exam = ? and a.id_exam = b.id_exam and a.userid = b.userid ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
		
			stm.execute();

			updateReScore(id_exam);
        }
        catch (SQLException ex) {
            throw new QmTmException("과락점수 수정 중 오류가 발생되었습니다. " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void updateReScore(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update EXAM_ANS ");
		sql.append("       Set yn_success = 'N' ");
		sql.append("From EXAM_M a, EXAM_ANS B ");
		sql.append("Where a.id_exam = ? and a.id_exam = b.id_exam and b.score < a.success_score ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
		
			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("과락점수 수정 중 오류가 발생되었습니다. " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}