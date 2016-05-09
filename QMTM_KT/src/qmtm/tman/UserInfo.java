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
			bean.setHome_addr1(rst.getString("home_addr1"));
			bean.setHome_addr2(rst.getString("home_addr2"));
			bean.setHome_phone(rst.getString("home_phone"));
			bean.setMobile_phone(rst.getString("mobile_phone"));
			bean.setRegdate(rst.getString("regdate"));
			bean.setSosok1(rst.getString("sosok1"));
			bean.setSosok2(rst.getString("sosok2"));
			bean.setSosok3(rst.getString("sosok3"));
			bean.setSosok4(rst.getString("sosok4"));
			bean.setJikwi(rst.getString("jikwi"));
			bean.setJikmu(rst.getString("jikmu"));
			bean.setCompany(rst.getString("company"));
			return bean;
		} catch (SQLException ex) {
			throw new QmTmException("응시자 정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [UserInfo.makeBean]"+ ex.getMessage());
		}
	}

	public static UserInfoBean getBean(String userid) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql = sql.append("SELECT name, password, email, home_addr1, home_addr2, home_phone, mobile_phone, sosok1, sosok2, sosok3, ");
		sql = sql.append("       sosok4, jikwi, jikmu, company, convert(varchar(16), regdate, 120) regdate ");
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
			throw new QmTmException("응시자 정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [UserInfo.getBean]"+ ex.getMessage());
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
		sql.append("   SET password = ?, name = ?, email = ?, home_addr1 = ?, home_addr2 = ?, ");
		sql.append("       home_phone = ?, mobile_phone = ?, sosok1 = ?, sosok2 = ?, ");
		sql.append("       sosok3 = ?, sosok4 = ?, jikwi = ?, jikmu = ?, company = ? ");
		sql.append("Where userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getPassword());
			stm.setString(2, bean.getName());
			stm.setString(3, bean.getEmail());
			stm.setString(4, bean.getHome_addr1());
			stm.setString(5, bean.getHome_addr2());
			stm.setString(6, bean.getHome_phone());
			stm.setString(7, bean.getMobile_phone());
			stm.setString(8, bean.getSosok1());
			stm.setString(9, bean.getSosok2());
			stm.setString(10, bean.getSosok3());
			stm.setString(11, bean.getSosok4());
			stm.setString(12, bean.getJikwi());
			stm.setString(13, bean.getJikmu());
			stm.setString(14, bean.getCompany());
			stm.setString(15, userid);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 정보 수정 중 인터넷 연결상태가 좋지 않습니다. [UserInfo.update]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}
