package qmtm.admin.etc;

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

public class QuseUtil
{
    public QuseUtil() {    
    }
	
	public static void insert(QuseBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO r_q_use (id_q_use, q_use, rmk) ");
        sql.append("VALUES (?, ?, ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_q_use());
            stm.setString(2, bean.getQ_use());
			stm.setString(3, bean.getRmk());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("문제용도 정보 등록하는 중 인터넷 연결상태가 좋지 않습니다. [QuseUtil.insert]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(QuseBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE r_q_use SET q_use = ?, rmk = ? ");
        sql.append("Where id_q_use = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, bean.getQ_use());
			stm.setString(2, bean.getRmk());
			stm.setString(3, bean.getId_q_use());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("문제용도 정보 수정하는 중 인터넷 연결상태가 좋지 않습니다. [QuseUtil.update]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_q_use) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM r_q_use Where id_q_use = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_q_use);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("문제용도 정보 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [QuseUtil.delete]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static QuseBean[] getBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		sql = "SELECT id_q_use, q_use, rmk FROM r_q_use order by id_q_use ";

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            rst = stm.executeQuery();
            QuseBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QuseBean[]) beans.toArray(new QuseBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제용도 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QuseUtil.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static QuseBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            QuseBean bean = new QuseBean();
            bean.setId_q_use(rst.getString(1));
            bean.setQ_use(rst.getString(2));
            bean.setRmk(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제용도 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QuseUtil.makeBeans]");
        }
    }

	public static QuseBean getBean(String id_q_use) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		String sql = "SELECT q_use, rmk FROM r_q_use WHERE id_q_use = ? ";

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql);
			stm.setString(1, id_q_use);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("문제용도 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QuseUtil.getBean]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static QuseBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            QuseBean bean = new QuseBean();
            bean.setQ_use(rst.getString(1));
            bean.setRmk(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제용도 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [QuseUtil.makeBean]");
        }
    }
}