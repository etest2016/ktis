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

public class QstandardBUtil
{
    public QstandardBUtil() {
    }
	
	public static void insert(QstandardBBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO q_standard_b (id_standardb, standardb, yn_valid, regdate, id_standarda) ");
        sql.append("VALUES (?, ?, 'Y', getdate(), ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_standardb());
            stm.setString(2, bean.getStandardb());
			stm.setString(3, bean.getId_standarda());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("소분류 정보 등록하는 중 오류가 발생되었습니다. [QstandardBUtil.insert] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(QstandardBBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE q_standard_b ");
		sql.append("       SET standardb = ?, yn_valid = ? ");
        sql.append("Where id_standardb = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, bean.getStandardb());
			stm.setString(2, bean.getYn_valid());
			stm.setString(3, bean.getId_standardb());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("소분류 정보 수정하는 중 오류가 발생되었습니다. [QstandardBUtil.update] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_standardb) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("DELETE FROM q_standard_b ");
		sql.append("Where id_standardb = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_standardb);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("소분류 정보 삭제하는 중 오류가 발생되었습니다. [QstandardBUtil.delete] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static QstandardBBean getBean(String id_standardb) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT standardb, yn_valid, regdate ");
		sql.append("FROM q_standard_b ");
		sql.append("WHERE id_standardb = ? ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_standardb);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("소분류 정보 읽어오는 중 오류가 발생되었습니다. [QstandardBUtil.getBean] " +ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static QstandardBBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            QstandardBBean bean = new QstandardBBean();
            bean.setStandardb(rst.getString(1));
            bean.setYn_valid(rst.getString(2));
			bean.setRegdate(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("소분류 정보 읽어오는 중 오류가 발생되었습니다. [QstandardBUtil.makeBean] " +ex.getMessage());
        }
    }
	
	public static QstandardBBean[] getBeans(String id_standarda) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_standardb, standardb, yn_valid, Convert(varchar(10),regdate,120) ");
		sql.append("From q_standard_b ");
		sql.append("Where id_standarda = ? ");
		sql.append("Order by regdate ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_standarda);
            rst = stm.executeQuery();
            QstandardBBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QstandardBBean[]) beans.toArray(new QstandardBBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("소분류 정보 읽어오는 중 오류가 발생되었습니다. [QstandardBUtil.getBeans] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	private static QstandardBBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            QstandardBBean bean = new QstandardBBean();
            bean.setId_standardb(rst.getString(1));
            bean.setStandardb(rst.getString(2));
            bean.setYn_valid(rst.getString(3));
			bean.setRegdate(rst.getString(4));
			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("소분류 정보 읽어오는 중 오류가 발생되었습니다. [QstandardBUtil.makeBeans] " +ex.getMessage());
        }
    }

	public static QstandardBBean[] getSelectBeans(String id_standarda) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_standardb, standardb ");
		sql.append("From q_standard_b ");
		sql.append("Where id_standarda = ? and yn_valid = 'Y' ");
		sql.append("Order by standardb ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_standarda);
            rst = stm.executeQuery();
            QstandardBBean bean = null;
            while (rst.next()) {
                bean = makeSelectBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QstandardBBean[]) beans.toArray(new QstandardBBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("소분류 정보 읽어오는 중 오류가 발생되었습니다. [QstandardBUtil.getSelectBeans] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	private static QstandardBBean makeSelectBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            QstandardBBean bean = new QstandardBBean();
            bean.setId_standardb(rst.getString(1));
            bean.setStandardb(rst.getString(2));
			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("소분류 정보 읽어오는 중 오류가 발생되었습니다. [QstandardBUtil.makeSelectBeans] " +ex.getMessage());
        }
    }

}