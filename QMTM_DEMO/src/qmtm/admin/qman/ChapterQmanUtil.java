package qmtm.admin.qman;

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

public class ChapterQmanUtil
{
    public ChapterQmanUtil() {
    }
	
	public static ChapterQmanBean[] getBeans(String id_q_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_q_subject, id_q_chapter, chapter, chapter_order, ");
		//sql.append("       convert(varchar(16), regdate, 120) regdate ");
		sql.append("       to_char(regdate, 'YYYY-MM-DD HH24:MI') regdate ");
		sql.append("From q_chapter ");
		sql.append("Where id_q_subject = ? ");
		sql.append("Order by chapter_order ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_q_subject);
            rst = stm.executeQuery();
            ChapterQmanBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ChapterQmanBean[]) beans.toArray(new ChapterQmanBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제은행 단원정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
    private static ChapterQmanBean makeBeans (ResultSet rst) throws QmTmException
    {		
		try {
            ChapterQmanBean bean = new ChapterQmanBean();
            bean.setId_q_subject(rst.getString(1));
			bean.setId_q_chapter(rst.getString(2));
            bean.setChapter(rst.getString(3));
			bean.setChapter_order(rst.getInt(4));
            bean.setRegdate(rst.getString(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }

	public static ChapterQmanBean getBean(String id_q_chapter) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		//sql.append("SELECT id_q_subject, id_q_chapter, chapter, chapter_order, convert(varchar(16), regdate, 120) regdate ");
		sql.append("SELECT id_q_subject, id_q_chapter, chapter, chapter_order, to_char(regdate, 'YYYY-MM-DD HH24:MI') regdate ");
		sql.append("FROM q_chapter WHERE id_q_chapter = ? ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_q_chapter);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("문제은행 단원정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static ChapterQmanBean makeBean (ResultSet rst) throws QmTmException
    {
		try {
            ChapterQmanBean bean = new ChapterQmanBean();
            bean.setId_q_subject(rst.getString(1));
			bean.setId_q_chapter(rst.getString(2));
			bean.setChapter(rst.getString(3));
			bean.setChapter_order(rst.getInt(4));
            bean.setRegdate(rst.getString(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }

	public static int getCnt(String id_q_subject) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select count(id_q_chapter) as cnt from q_chapter Where id_q_subject = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_q_subject);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static boolean getDownCnt(String id_q_chapter) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select id_q_chapter2 as cnt from q_chapter2 Where id_q_chapter = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_q_chapter);

            rst = stm.executeQuery();
            if (rst.next()) { return false; }
            else { return true; }
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static boolean getDownQCnt(String id_chapter) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select q from q Where id_chapter = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_chapter);

            rst = stm.executeQuery();
            if (rst.next()) { return false; }
            else { return true; }
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void insert(ChapterQmanBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO Q_CHAPTER (id_q_subject, id_q_chapter, chapter, chapter_order, regdate) ");
        sql.append("VALUES (?, ?, ?, ?, now()) ");
        //sql.append("VALUES (?, ?, ?, ?, getdate()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_q_subject());
			stm.setString(2, bean.getId_q_chapter());
            stm.setString(3, bean.getChapter());
			stm.setInt(4, bean.getChapter_order());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("문제은행 단원 등록 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(ChapterQmanBean bean, String id_q_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE q_chapter SET chapter = ?, chapter_order = ? ");
		sql.append("Where id_q_chapter = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getChapter());
			stm.setInt(2, bean.getChapter_order());
			stm.setString(3, id_q_chapter);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("문제은행 단원 수정 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_q_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM q_chapter Where id_q_chapter = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_q_chapter);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("문제은행 단원 삭제 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}