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

public class Chapter3QmanUtil
{
    public Chapter3QmanUtil() {
    }
	
	public static Chapter3QmanBean[] getBeans(String id_q_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_q_chapter3, chapter, chapter_order, convert(varchar(16), regdate, 120) regdate ");
		sql.append("From q_chapter3 ");
		sql.append("Where id_q_chapter2 = ? ");
		sql.append("Order by chapter_order ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_q_chapter);
            rst = stm.executeQuery();
            Chapter3QmanBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (Chapter3QmanBean[]) beans.toArray(new Chapter3QmanBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제은행 단원3 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
    private static Chapter3QmanBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            Chapter3QmanBean bean = new Chapter3QmanBean();
			bean.setId_q_chapter3(rst.getString(1));
            bean.setChapter(rst.getString(2));
			bean.setChapter_order(rst.getInt(3));
            bean.setRegdate(rst.getString(4));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원3 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }

	public static Chapter3QmanBean getBean(String id_q_chapter) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT id_q_subject, id_q_chapter, id_q_chapter2, id_q_chapter3, chapter, chapter_order, convert(varchar(16), regdate, 120) regdate ");
		sql.append("FROM q_chapter3 WHERE id_q_chapter3 = ? ");

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
			throw new QmTmException("문제은행 단원3 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static Chapter3QmanBean makeBean (ResultSet rst) throws QmTmException
    {
		try {
            Chapter3QmanBean bean = new Chapter3QmanBean();
            bean.setId_q_subject(rst.getString(1));
			bean.setId_q_chapter(rst.getString(2));
			bean.setId_q_chapter2(rst.getString(3));
			bean.setId_q_chapter3(rst.getString(4));
			bean.setChapter(rst.getString(5));
			bean.setChapter_order(rst.getInt(6));
            bean.setRegdate(rst.getString(7));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원3 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }

	public static int getCnt(String id_q_chapter) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select count(id_q_chapter3) as cnt from q_chapter3 Where id_q_chapter2 = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_q_chapter);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원3 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static boolean getDownCnt(String id_q_chapter) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select id_q_chapter4 as cnt from q_chapter4 Where id_q_chapter3 = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_q_chapter);

            rst = stm.executeQuery();
            if (rst.next()) { return false; }
            else { return true; }
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원3 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static boolean getDownQCnt(String id_chapter) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select q from q Where id_chapter3 = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_chapter);

            rst = stm.executeQuery();
            if (rst.next()) { return false; }
            else { return true; }
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원3 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void insert(Chapter3QmanBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO Q_CHAPTER3 (id_q_subject, id_q_chapter, id_q_chapter2, id_q_chapter3, chapter, chapter_order, regdate) ");
        sql.append("VALUES (?, ?, ?, ?, ?, ?, getdate()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_q_subject());
			stm.setString(2, bean.getId_q_chapter());
			stm.setString(3, bean.getId_q_chapter2());
			stm.setString(4, bean.getId_q_chapter3());
            stm.setString(5, bean.getChapter());
			stm.setInt(6, bean.getChapter_order());			

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("문제은행 단원3 등록 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(Chapter3QmanBean bean, String id_q_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE q_chapter3 SET chapter = ?, chapter_order = ? ");
		sql.append("Where id_q_chapter3 = ? ");

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
            throw new QmTmException("문제은행 단원3 수정 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_q_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM q_chapter3 Where id_q_chapter3 = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_q_chapter);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("문제은행 단원3 삭제 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}