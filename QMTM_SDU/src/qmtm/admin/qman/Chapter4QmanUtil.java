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

public class Chapter4QmanUtil
{
    public Chapter4QmanUtil() {
    }
	
	public static Chapter4QmanBean[] getBeans(String id_q_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_q_chapter4, chapter, chapter_order, convert(varchar(16), regdate, 120) regdate ");
		sql.append("From q_chapter4 ");
		sql.append("Where id_q_chapter3 = ? ");
		sql.append("Order by chapter_order ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_q_chapter);
            rst = stm.executeQuery();
            Chapter4QmanBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (Chapter4QmanBean[]) beans.toArray(new Chapter4QmanBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제은행 단원4 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
    private static Chapter4QmanBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            Chapter4QmanBean bean = new Chapter4QmanBean();
			bean.setId_q_chapter4(rst.getString(1));
            bean.setChapter(rst.getString(2));
			bean.setChapter_order(rst.getInt(3));
            bean.setRegdate(rst.getString(4));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원4 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }

	public static Chapter4QmanBean getBean(String id_q_chapter) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT id_q_subject, id_q_chapter, id_q_chapter2, id_q_chapter3, id_q_chapter4, chapter, ");
		sql.append("       chapter_order, convert(varchar(16), regdate, 120) regdate ");
		sql.append("FROM q_chapter4 WHERE id_q_chapter4 = ? ");

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
			throw new QmTmException("문제은행 단원4 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static Chapter4QmanBean makeBean (ResultSet rst) throws QmTmException
    {
		try {
            Chapter4QmanBean bean = new Chapter4QmanBean();
            bean.setId_q_subject(rst.getString(1));
			bean.setId_q_chapter(rst.getString(2));
			bean.setId_q_chapter2(rst.getString(3));
			bean.setId_q_chapter3(rst.getString(4));
			bean.setId_q_chapter4(rst.getString(5));
			bean.setChapter(rst.getString(6));
			bean.setChapter_order(rst.getInt(7));
            bean.setRegdate(rst.getString(8));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원4 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }

	public static int getCnt(String id_q_chapter) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select count(id_q_chapter4) as cnt from q_chapter4 Where id_q_chapter3 = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_q_chapter);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원4 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static boolean getDownQCnt(String id_chapter) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select q from q Where id_chapter4 = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_chapter);

            rst = stm.executeQuery();
            if (rst.next()) { return false; }
            else { return true; }
        } catch (SQLException ex) {
            throw new QmTmException("문제은행 단원4 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void insert(Chapter4QmanBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO Q_CHAPTER4 (id_q_subject, id_q_chapter, id_q_chapter2, id_q_chapter3, id_q_chapter4, chapter, chapter_order, regdate) ");
        sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, getdate()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_q_subject());
			stm.setString(2, bean.getId_q_chapter());
			stm.setString(3, bean.getId_q_chapter2());
			stm.setString(4, bean.getId_q_chapter3());
			stm.setString(5, bean.getId_q_chapter4());
            stm.setString(6, bean.getChapter());
			stm.setInt(7, bean.getChapter_order());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("문제은행 단원4 정보 등록 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(Chapter4QmanBean bean, String id_q_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE q_chapter4 SET chapter = ?, chapter_order = ? ");
		sql.append("Where id_q_chapter4 = ? ");

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
            throw new QmTmException("문제은행 단원4 정보 수정 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_q_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM q_chapter4 Where id_q_chapter4 = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_q_chapter);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("문제은행 단원4 정보 삭제 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}