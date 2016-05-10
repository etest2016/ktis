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
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO QT_WORKERID ");
		sql.append("(userid, password, name, content1, yn_valid, regdate, email, hp, password_date) ");
		sql.append("VALUES (?, PWDENCRYPT(?), ?, ?, ?, getdate(), ?, ?, getdate()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getUserid());
            stm.setString(2, bean.getPassword());
			stm.setString(3, bean.getName());
			stm.setString(4, bean.getContent1());
			stm.setString(5, bean.getYn_valid());
			stm.setString(6, bean.getEmail());
			stm.setString(7, bean.getHp());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("����� ���� �Է��ϴ� �� ������ �߻��Ǿ����ϴ�. [ManagerUtil.insert] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(ManagerBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE QT_WORKERID ");
		sql.append("       SET password = PWDENCRYPT(?), name = ?, content1 = ?, yn_valid = ?, email = ?, hp = ? ");
		sql.append("Where userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getPassword());
			stm.setString(2, bean.getName());
			stm.setString(3, bean.getContent1());
			stm.setString(4, bean.getYn_valid());
			stm.setString(5, bean.getEmail());
			stm.setString(6, bean.getHp());
			stm.setString(7, bean.getUserid());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("����� ���� �����ϴ� �� ������ �߻��Ǿ����ϴ�. [ManagerUtil.update] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("DELETE FROM QT_WORKERID ");
		sql.append("Where userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);

			stm.execute();
						
			delete_t(userid); // ����� ���� ����
        }
        catch (SQLException ex) {
            throw new QmTmException("����� ���� �����ϴ� �� ������ �߻��Ǿ����ϴ�. [ManagerUtil.delete] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }	
	
	public static void delete_t(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("DELETE FROM t_worker_subj ");
		sql.append("Where userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);

			stm.execute();			
        }
        catch (SQLException ex) {
            throw new QmTmException("������� ���� ���� �����ϴ� �� ������ �߻��Ǿ����ϴ�. [ManagerUtil.delete_t] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ManagerBean[] getBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT distinct userid, name, yn_valid, convert(varchar(10), regdate, 120) regdate, content1, email, hp ");
		sql.append("FROM qt_workerid ");
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
            throw new QmTmException("����� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [ManagerUtil.getBeans] " +ex.getMessage());
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
		
		sql.append("Select userid, name, yn_valid, convert(varchar(10), regdate, 120) regdate, content1, email, hp ");
		sql.append("From qt_workerid ");
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
            throw new QmTmException("������� ����� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [ManagerUtil.getTMgrBeans] " +ex.getMessage());
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
			bean.setEmail(rst.getString(6));
			bean.setHp(rst.getString(7));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("����� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [ManagerUtil.makeBeans] " +ex.getMessage());
        }
    }

	public static ManagerBean getBean(String userid) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT name, content1, yn_valid, convert(varchar(10), regdate, 120) regdate, email, hp ");
		sql.append("FROM qt_workerid ");
		sql.append("WHERE userid = ? ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("����� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [ManagerUtil.getBean] " +ex.getMessage());
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
            bean.setName(rst.getString(1));
			bean.setContent1(rst.getString(2));
			bean.setYn_valid(rst.getString(3));
            bean.setRegdate(rst.getString(4));
			bean.setEmail(rst.getString(5));
			bean.setHp(rst.getString(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("����� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [ManagerUtil.makeBean]");
        }
    }

	public static String getIdChk(String input_id) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select userid ");
		sql.append("From qt_workerid ");
		sql.append("Where userid = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, input_id);

            rst = stm.executeQuery();
            if (rst.next()) { return "true"; }
            else { return "false"; }
        } catch (SQLException ex) {
            throw new QmTmException("����� ���̵� �ߺ� üũ�۾� �� ������ �߻��Ǿ����ϴ�. [ManagerUtil.getIdChk] " +ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
}