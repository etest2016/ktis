package qmtm.qman.category;

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

public class ModuleUtil
{
    public ModuleUtil() {
    }
	
	public static void insert(ModuleBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO q_chapter (id_q_subject, id_q_chapter, chapter, chapter_order, yn_valid, regdate) ");
        sql.append("VALUES (?, ?, ?, ?, 'Y', getdate()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, bean.getId_subject());
			stm.setString(2, bean.getId_chapter());
            stm.setString(3, bean.getChapter());
			stm.setInt(4, bean.getChapter_order());
			
			stm.execute();
        }
        catch (SQLException ex) {
			throw new QmTmException("모듈 정보 등록하는 중 오류가 발생되었습니다. [ModuleUtil.insert] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static void update(ModuleBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE q_chapter SET chapter = ?, chapter_order = ?, yn_valid = ? ");
        sql.append("WHERE id_q_chapter = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getChapter());
			stm.setInt(2, bean.getChapter_order());
			stm.setString(3, bean.getYn_valid());
			stm.setString(4, bean.getId_chapter());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("모듈 정보 수정하는 중 오류가 발생되었습니다. [ModuleUtil.Update] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Delete From q_chapter ");
		sql.append("Where id_q_chapter = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_chapter);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("모듈 정보 삭제하는 중 오류가 발생되었습니다. [ModuleUtil.delete] "+ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ModuleBean[] getBeans(String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Select id_q_chapter, chapter, chapter_order, yn_valid, convert(varchar(16), regdate, 121) regdate ");
		sql.append("From q_chapter ");
		sql.append("Where id_q_subject = ? ");
		sql.append("Order by chapter_order ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_subject);
            rst = stm.executeQuery();
            ModuleBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ModuleBean[]) beans.toArray(new ModuleBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("모듈 정보 읽어오는 중 오류가 발생되었습니다. [ModuleUtil.getBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static ModuleBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            ModuleBean bean = new ModuleBean();
            bean.setId_chapter(rst.getString(1));
            bean.setChapter(rst.getString(2));
			bean.setChapter_order(rst.getInt(3));            
			bean.setYn_valid(rst.getString(4));
			bean.setRegdate(rst.getString(5));
			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("모듈 정보 읽어오는 중 오류가 발생되었습니다. [ModuleUtil.makeBeans] " + ex.getMessage());
        }
    }

	public static ModuleBean getBean(String id_chapter) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select chapter, yn_valid, chapter_order ");
		sql.append("From q_chapter ");
		sql.append("Where id_q_chapter = ? ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_chapter);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("[ModuleUtil.getBean]" + ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static ModuleBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            ModuleBean bean = new ModuleBean();
            bean.setChapter(rst.getString(1));			
			bean.setYn_valid(rst.getString(2));
			bean.setChapter_order(rst.getInt(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[ModuleUtil.makeBean]" + ex.getMessage());
        }
    }

	public static int getCnt(String id_chapter) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(id_chapter) as cnt ");
		sql.append("From q "); 
		sql.append("Where id_chapter = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_chapter);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("모듈 아래 문제 정보 유무 읽어오는 중 오류가 발생되었습니다. [ModuleUtil.getCnt] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static int getOrderCnt(String id_subject) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select isnull(max(chapter_order),0) + 1 as order_cnt ");
		sql.append("From q_chapter "); 
		sql.append("Where id_q_subject = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_subject);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("order_cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("모듈 정렬순서정보 읽어오는 중 오류가 발생되었습니다. [ModuleUtil.getOrderCnt] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

}