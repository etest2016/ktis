package qmtm.admin.manager;

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

public class ManagerUtil
{
    public ManagerUtil() {
    }
	
	public static void insert(ManagerBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "INSERT INTO QT_WORKERID (userid, password, name, content1, yn_valid) VALUES (?, ?, ?, ?, ?) ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, bean.getUserid());
            stm.setString(2, bean.getPassword());
			stm.setString(3, bean.getName());
			stm.setString(4, bean.getContent1());
			stm.setString(5, bean.getYn_valid());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("담당자 정보 입력하는 중 인터넷 연결상태가 좋지 않습니다. [ManagerUtil.insert]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(ManagerBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "UPDATE QT_WORKERID SET password = ?, name = ?, content1 = ?, yn_valid = ? Where userid = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, bean.getPassword());
			stm.setString(2, bean.getName());
			stm.setString(3, bean.getContent1());
			stm.setString(4, bean.getYn_valid());
			stm.setString(5, bean.getUserid());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("담당자 정보 수정하는 중 인터넷 연결상태가 좋지 않습니다. [ManagerUtil.update]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM QT_WORKERID Where userid = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, userid);

			stm.execute();
			
			delete_q(userid); // 문제은행 권한 삭제
			delete_t(userid); // 시험관리 권한 삭제
        }
        catch (SQLException ex) {
            throw new QmTmException("담당자 정보 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [ManagerUtil.delete]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }	

	public static void delete_q(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM q_worker_subj Where userid = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, userid);

			stm.execute();			
        }
        catch (SQLException ex) {
            throw new QmTmException("문제은행 권한 정보 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [ManagerUtil.delete_q]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete_t(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM t_worker_subj Where userid = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, userid);

			stm.execute();			
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 권한 정보 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [ManagerUtil.delete_t]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ManagerBean[] getBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		//sql = "SELECT userid, name, yn_valid, convert(varchar(10), regdate, 120) regdate, content1 FROM qt_workerid Order by regdate desc ";
        sql = "SELECT userid, name, yn_valid, to_char(regdate, 'YYYY-MM-DD') regdate, content1 FROM qt_workerid Order by regdate desc ";

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            rst = stm.executeQuery();
            ManagerBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ManagerBean[]) beans.toArray(new ManagerBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("담당자 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerUtil.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ManagerBean[] getQMgrBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		//sql.append("Select userid, name, yn_valid, convert(varchar(10), regdate, 120) regdate, content1 From qt_workerid ");
		sql.append("Select userid, name, yn_valid, to_char(regdate, 'YYYY-MM-DD') regdate, content1 From qt_workerid ");
		sql.append("Where userid in (Select distinct userid From q_worker_subj) "); 
		sql.append("Order by regdate desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            rst = stm.executeQuery();
            ManagerBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ManagerBean[]) beans.toArray(new ManagerBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제은행 담당자 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerUtil.getQMgrBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ManagerBean[] getTMgrBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		//sql.append("Select userid, name, yn_valid, convert(varchar(10), regdate, 120) regdate, content1 From qt_workerid ");
		sql.append("Select userid, name, yn_valid, to_char(regdate, 'YYYY-MM-DD') regdate, content1 From qt_workerid ");
		sql.append("Where userid in (Select distinct userid From t_worker_subj) ");
		sql.append("Order by regdate desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            rst = stm.executeQuery();
            ManagerBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ManagerBean[]) beans.toArray(new ManagerBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 담당자 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerUtil.getTMgrBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static ManagerBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            ManagerBean bean = new ManagerBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
			bean.setYn_valid(rst.getString(3));
            bean.setRegdate(rst.getString(4));
			bean.setContent1(rst.getString(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("담당자 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerUtil.makeBeans]");
        }
    }

	public static ManagerBean getBean(String userid) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		//String sql = "SELECT password, name, content1,  yn_valid, convert(varchar(10), regdate, 120) regdate FROM qt_workerid WHERE userid = ? ";
        String sql = "SELECT password, name, content1,  yn_valid, to_char(regdate, 'YYYY-MM-DD') regdate FROM qt_workerid WHERE userid = ? ";

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql);
			stm.setString(1, userid);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("담당자 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerUtil.getBean]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static ManagerBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            ManagerBean bean = new ManagerBean();
            bean.setPassword(rst.getString(1));
            bean.setName(rst.getString(2));
			bean.setContent1(rst.getString(3));
			bean.setYn_valid(rst.getString(4));
            bean.setRegdate(rst.getString(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("담당자 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerUtil.makeBean]");
        }
    }
}