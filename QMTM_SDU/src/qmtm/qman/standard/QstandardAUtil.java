package qmtm.qman.standard;

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

public class QstandardAUtil
{
    public QstandardAUtil() {
    }
	
	public static void insert(QstandardABean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO q_standard_a (id_standarda, standarda, yn_valid, regdate, id_chapter) ");
        sql.append("VALUES (?, ?, 'Y', getdate(), ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_standarda());
            stm.setString(2, bean.getStandarda());
			stm.setString(3, bean.getId_chapter());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("��з� ���� ����ϴ� �� ������ �߻��Ǿ����ϴ�. [QstandardAUtil.insert] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(QstandardABean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE q_standard_a ");
		sql.append("       SET standarda = ?, yn_valid = ? ");
        sql.append("Where id_standarda = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, bean.getStandarda());
			stm.setString(2, bean.getYn_valid());
			stm.setString(3, bean.getId_standarda());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("��з� ���� �����ϴ� �� ������ �߻��Ǿ����ϴ�. [QstandardAUtil.update] " +ex.getMessage());		
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_standarda) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("DELETE FROM q_standard_a ");
		sql.append("Where id_standarda = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_standarda);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("��з� ���� �����ϴ� �� ������ �߻��Ǿ����ϴ�. [QstandardAUtil.delete] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static QstandardABean getBean(String id_standarda) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT standarda, yn_valid, regdate ");
		sql.append("FROM q_standard_a ");
		sql.append("WHERE id_standarda = ? ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_standarda);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("��з� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [QstandardAUtil.getBean] " +ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static QstandardABean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            QstandardABean bean = new QstandardABean();
            bean.setStandarda(rst.getString(1));
            bean.setYn_valid(rst.getString(2));
			bean.setRegdate(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("��з� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [QstandardAUtil.makeBean] " +ex.getMessage());
        }
    }
	
	public static QstandardABean[] getBeans(String id_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_standarda, standarda, yn_valid, Convert(varchar(10),regdate,120) ");
		sql.append("From q_standard_a ");
		sql.append("Where id_chapter = ? ");
		sql.append("Order by regdate ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_chapter);
            rst = stm.executeQuery();
            QstandardABean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QstandardABean[]) beans.toArray(new QstandardABean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("��з� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [QstandardAUtil.getBeans] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	private static QstandardABean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            QstandardABean bean = new QstandardABean();
            bean.setId_standarda(rst.getString(1));
            bean.setStandarda(rst.getString(2));
            bean.setYn_valid(rst.getString(3));
			bean.setRegdate(rst.getString(4));
			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("��з� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [QstandardAUtil.makeBeans] " +ex.getMessage());
        }
    }

	public static QstandardABean[] getSelectBeans(String id_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_standarda, standarda ");
		sql.append("From q_standard_a ");
		sql.append("Where id_chapter = ? and yn_valid = 'Y' ");
		sql.append("Order by standarda ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_chapter);
            rst = stm.executeQuery();
            QstandardABean bean = null;
            while (rst.next()) {
                bean = makeSelectBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QstandardABean[]) beans.toArray(new QstandardABean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("��з� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [QstandardAUtil.getSelectBeans] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static QstandardABean makeSelectBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            QstandardABean bean = new QstandardABean();
            bean.setId_standarda(rst.getString(1));
            bean.setStandarda(rst.getString(2));
			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("��з� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [QstandardAUtil.makeSelectBeans] " +ex.getMessage());
        }
    }
	
	public static int getCnt(String id_standarda) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(id_standarda) as cnt ");
		sql.append("From q_standard_b ");
		sql.append("Where id_standarda = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_standarda);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("�Һз� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [QstandardAUtil.getCnt] " +ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
}