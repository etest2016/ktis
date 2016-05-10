package qmtm.tman;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

public class UserInfo {
	public UserInfo() {
	}

	private static UserInfoBean makeBean(ResultSet rst) throws QmTmException {
		try {
			UserInfoBean bean = new UserInfoBean();
			bean.setName(rst.getString("name"));
			bean.setPassword(rst.getString("password"));
			bean.setEmail(rst.getString("email"));
			bean.setHome_phone(rst.getString("home_phone"));
			bean.setMobile_phone(rst.getString("mobile_phone"));			
			bean.setSosok1(rst.getString("sosok1"));
			bean.setSosok2(rst.getString("sosok2"));
			bean.setLevel(rst.getString("level"));
			bean.setRegdate(rst.getString("regdate"));
			return bean;
		} catch (SQLException ex) {
			throw new QmTmException("응시자 정보 읽어오는중 오류가 발생되었습니다. [UserInfo.makeBean] "+ ex.getMessage());
		}
	}

	public static UserInfoBean getBean(String userid) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql = sql.append("SELECT name, password, email, home_phone, mobile_phone, sosok1, sosok2, ");
		sql = sql.append("       level, convert(varchar(16), regdate, 120) regdate ");
		sql = sql.append("FROM qt_userid ");
		sql = sql.append("WHERE userid = ? ");
		
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
			throw new QmTmException("응시자 정보 읽어오는중 오류가 발생되었습니다. [UserInfo.getBean] "+ ex.getMessage());
		} finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) { }
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void update(UserInfoBean bean, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE qt_userid ");
		sql.append("   SET name = ?, email = ?, home_phone = ?, ");
		sql.append("       mobile_phone = ?, sosok1 = ?, sosok2 = ?, level = ? ");
		sql.append("Where userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, bean.getName());
			stm.setString(2, bean.getEmail());
			stm.setString(3, bean.getHome_phone());
			stm.setString(4, bean.getMobile_phone());
			stm.setString(5, bean.getSosok1());
			stm.setString(6, bean.getSosok2());
			stm.setString(7, bean.getLevel());
			stm.setString(8, userid);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 정보 수정 중 오류가 발생되었습니다. [UserInfo.update] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}
