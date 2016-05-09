package qmtm.tman.answer;

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

public class PersonalTime2
{
    public PersonalTime2() {
    }
	
	public static PersonalTime2Bean getTime(String id_exam, String userid) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select yn_sametime, login_start, login_end, exam_start1, exam_end1 ");
		sql.append("From personal_time ");
		sql.append("Where id_exam = ? and userid = ? ");
		
	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setString(2, userid);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeTime(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("개인시간 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [PersonalTime2.getTime]");			
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static PersonalTime2Bean makeTime(ResultSet rst) throws QmTmException
    {
		try {
            PersonalTime2Bean bean = new PersonalTime2Bean();
            bean.setYn_sametime(rst.getString(1));
            bean.setLogin_start(rst.getTimestamp(2));
			bean.setLogin_end(rst.getTimestamp(3));
			bean.setExam_start1(rst.getTimestamp(4));
			bean.setExam_end1(rst.getTimestamp(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시간 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [PersonalTime2.makeTime]");
        }
    }

}