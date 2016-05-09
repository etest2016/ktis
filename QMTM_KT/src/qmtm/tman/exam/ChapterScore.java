package qmtm.tman.exam;

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

public class ChapterScore
{
    public ChapterScore() {
    }
	
	public static ChapterScoreBean[] getBeans(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select b.id_chapter, c.chapter ");
		sql.append("From exam_paper2 a, q b, q_chapter c "); 
		sql.append("Where a.id_exam = ? and a.id_q = b.id_q and b.id_chapter = c.id_q_chapter ");
		sql.append("Group by b.id_chapter, c.chapter ");
		sql.append("Order by c.chapter ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
            rst = stm.executeQuery();
            ChapterScoreBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ChapterScoreBean[]) beans.toArray(new ChapterScoreBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("단원 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ChapterScore.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
    private static ChapterScoreBean makeBeans (ResultSet rst) throws QmTmException
    {		
		try {
            ChapterScoreBean bean = new ChapterScoreBean();
			bean.setId_chapter(rst.getString(1));
            bean.setChapter(rst.getString(2));
			return bean;
        } catch (SQLException ex) {
            throw new QmTmException("단원 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ChapterScore.makeBeans]");
        }
    }
	
	public static double getScore(String id_exam, String id_chapter) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select score From t_chapter_rscore Where id_exam = ? and id_chapter = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);
			stm.setString(2, id_chapter);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getDouble("score"); }
            else { return -1; }
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원2 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ChapterScore.getCnt]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
	public static void insert(String id_exam, String id_chapter, double score) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO t_chapter_rscore (id_exam, id_chapter, score) ");
        sql.append("VALUES (?, ?, ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, id_chapter);
			stm.setDouble(3, score);
 
			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("단원별 요구수준 점수 등록 중 인터넷 연결상태가 좋지 않습니다. [ChapterScore.insert]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_exam, String id_chapter, double score) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Delete t_chapter_rscore ");
		sql.append("Where id_exam = ? and id_chapter = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, id_chapter);

			stm.execute();

			insert(id_exam, id_chapter, score);
        }
        catch (SQLException ex) {
            throw new QmTmException("단원별 요구수준 점수 삭제 중 인터넷 연결상태가 좋지 않습니다. [ChapterScore.delete]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }	
}