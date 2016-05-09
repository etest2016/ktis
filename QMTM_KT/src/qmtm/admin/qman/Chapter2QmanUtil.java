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

public class Chapter2QmanUtil
{
    public Chapter2QmanUtil() {
    }
	
	public static Chapter2QmanBean[] getBeans(String id_q_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_q_chapter2, chapter, chapter_order, to_char(regdate, 'yyyy-mm-dd hh24:mi') regdate ");
		sql.append("From q_chapter2 ");
		sql.append("Where id_q_chapter = ? ");
		sql.append("Order by chapter_order ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_q_chapter);
            rst = stm.executeQuery();
            Chapter2QmanBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (Chapter2QmanBean[]) beans.toArray(new Chapter2QmanBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제은행 단원2 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [Chapter2QmanUtil.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
    private static Chapter2QmanBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            Chapter2QmanBean bean = new Chapter2QmanBean();
			bean.setId_q_chapter2(rst.getString(1));
            bean.setChapter(rst.getString(2));
			bean.setChapter_order(rst.getInt(3));
            bean.setRegdate(rst.getString(4));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원2 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [Chapter2QmanUtil.makeBeans]");
        }
    }

	public static Chapter2QmanBean getBean(String id_q_chapter) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT id_q_subject, id_q_chapter, id_q_chapter2, chapter, chapter_order, to_char(regdate, 'yyyy-mm-dd hh24:mi') regdate ");
		sql.append("FROM q_chapter2 WHERE id_q_chapter2 = ? ");

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
			throw new QmTmException("문제은행 단원2 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [Chapter2QmanUtil.getBean]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static Chapter2QmanBean makeBean (ResultSet rst) throws QmTmException
    {		
		try {
            Chapter2QmanBean bean = new Chapter2QmanBean();
            bean.setId_q_subject(rst.getString(1));
			bean.setId_q_chapter(rst.getString(2));
			bean.setId_q_chapter2(rst.getString(3));
			bean.setChapter(rst.getString(4));
			bean.setChapter_order(rst.getInt(5));
            bean.setRegdate(rst.getString(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원2 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [Chapter2QmanUtil.makeBean]");
        }
    }

	public static int getCnt(String id_q_chapter) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select count(id_q_chapter2) as cnt from q_chapter2 Where id_q_chapter = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_q_chapter);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원2 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [Chapter2QmanUtil.getCnt]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static boolean getDownCnt(String id_q_chapter) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select id_q_chapter3 as cnt from q_chapter3 Where id_q_chapter2 = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_q_chapter);

            rst = stm.executeQuery();
            if (rst.next()) { return false; }
            else { return true; }
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원2 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [Chapter2QmanUtil.getDownCnt]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static boolean getDownQCnt(String id_chapter) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select q from q Where id_chapter2 = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_chapter);

            rst = stm.executeQuery();
            if (rst.next()) { return false; }
            else { return true; }
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원2 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [Chapter2QmanUtil.getDownQCnt]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void insert(Chapter2QmanBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO Q_CHAPTER2 (id_q_subject, id_q_chapter, id_q_chapter2, chapter, chapter_order, regdate) ");
        sql.append("VALUES (?, ?, ?, ?, ?, sysdate) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_q_subject());
			stm.setString(2, bean.getId_q_chapter());
			stm.setString(3, bean.getId_q_chapter2());
            stm.setString(4, bean.getChapter());
			stm.setInt(5, bean.getChapter_order());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("문제은행 단원2 등록 중 인터넷 연결상태가 좋지 않습니다. [Chapter2QmanUtil.insert]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(Chapter2QmanBean bean, String id_q_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE q_chapter2 SET chapter = ?, chapter_order = ? ");
		sql.append("Where id_q_chapter2 = ? ");

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
            throw new QmTmException("문제은행 단원2 수정 중 인터넷 연결상태가 좋지 않습니다. [Chapter2QmanUtil.update]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_q_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM q_chapter2 Where id_q_chapter2 = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_q_chapter);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("문제은행 단원2 삭제 중 인터넷 연결상태가 좋지 않습니다. [Chapter2QmanUtil.delete]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}