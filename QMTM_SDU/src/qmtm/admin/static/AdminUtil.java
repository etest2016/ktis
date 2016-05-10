package qmtm.admin.admin;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;
import qmtm.ComLib;

// Java API Import
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class AdminUtil
{
    public AdminUtil() {
    }
	
	public static void insert(AdminBean bean) throws QmTmException
    {
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO QT_ADMINID ");
		sql.append("(userid, password, name, content1, yn_valid, regdate, email, hp) ");
		sql.append("VALUES (?, PWDENCRYPT(?), ?, ?, ?, getdate(), ?, ?) ");

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
            throw new QmTmException("관리자 정보 입력하는 중 오류가 발생되었습니다. [AdminUtil.insert] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(AdminBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE QT_ADMINID ");
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
            throw new QmTmException("관리자 정보 수정하는 중 오류가 발생되었습니다. [AdminUtil.update] " +ex.getMessage());
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

        sql.append("DELETE FROM QT_ADMINID ");
		sql.append("Where userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);

			stm.execute();					
        }
        catch (SQLException ex) {
            throw new QmTmException("관리자 정보 삭제하는 중 오류가 발생되었습니다. [AdminUtil.delete] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }	
	
	public static AdminBean[] getBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT userid, name, yn_valid, convert(varchar(10), regdate, 120) regdate, content1, email, hp ");
		sql.append("FROM qt_adminid ");
		sql.append("Order by regdate desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            rst = stm.executeQuery();
            AdminBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AdminBean[]) beans.toArray(new AdminBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("관리자 정보 읽어오는 중 오류가 발생되었습니다. [AdminUtil.getBeans] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
		
    private static AdminBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            AdminBean bean = new AdminBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
			bean.setYn_valid(rst.getString(3));
            bean.setRegdate(rst.getString(4));
			bean.setContent1(rst.getString(5));
			bean.setEmail(rst.getString(6));
			bean.setHp(rst.getString(7));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("관리자 정보 읽어오는 중 오류가 발생되었습니다. [AdminUtil.makeBeans] " +ex.getMessage());
        }
    }

	public static AdminBean getBean(String userid) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT name, content1, yn_valid, convert(varchar(10), regdate, 120) regdate, email, hp ");
		sql.append("FROM qt_adminid ");
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
			throw new QmTmException("관리자 정보 읽어오는 중 오류가 발생되었습니다. [AdminUtil.getBean] " +ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static AdminBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            AdminBean bean = new AdminBean();
            bean.setName(rst.getString(1));
			bean.setContent1(rst.getString(2));
			bean.setYn_valid(rst.getString(3));
            bean.setRegdate(rst.getString(4));
			bean.setEmail(rst.getString(5));
			bean.setHp(rst.getString(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("관리자 정보 읽어오는 중 오류가 발생되었습니다. [AdminUtil.makeBean]");
        }
    }

	public static String getIdChk(String input_id) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select userid ");
		sql.append("From qt_adminid ");
		sql.append("Where userid = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, input_id);

            rst = stm.executeQuery();
            if (rst.next()) { return "true"; }
            else { return "false"; }
        } catch (SQLException ex) {
            throw new QmTmException("관리자 아이디 중복 체크작업 중 오류가 발생되었습니다. [AdminUtil.getIdChk] " +ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
}