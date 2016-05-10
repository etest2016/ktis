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

public class PersonalTime
{
    public PersonalTime() {
    }

	public static PersonalTimeBean getBean(String id_exam, String userid) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select convert(varchar(16), start_time, 120) start_time, convert(varchar(16), end_time, 120) end_time, remain_time ");
		sql.append("From exam_ans ");
		sql.append("Where id_exam = ? and userid = ? ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setString(2, userid);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("������ ��� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [PersonalTime.getBean] " + ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static PersonalTimeBean makeBean (ResultSet rst) throws QmTmException
    {
		try {
            PersonalTimeBean bean = new PersonalTimeBean();
            bean.setStart_time(rst.getString(1));
			bean.setEnd_time(rst.getString(2));
			bean.setRemain_time(rst.getLong(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("������ ����� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [PersonalTime.makeBean] " + ex.getMessage());
        }
    }

	public static PersonalTimeBean getTime(String id_exam, String userid) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select yn_sametime, convert(varchar(19), login_start, 120) login_start, ");
		sql.append("       convert(varchar(19), login_end, 120) login_end, convert(varchar(19), exam_start1, 120) exam_start1, ");
		sql.append("       convert(varchar(19), exam_end1, 120) exam_end1 ");
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
			throw new QmTmException("���νð� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [PersonalTime.getTime] " + ex.getMessage());	
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	public static PersonalTimeBean getTime2(String id_exam) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select yn_sametime, convert(varchar(19), login_start, 120) login_start, ");
		sql.append("       convert(varchar(19), login_end, 120) login_end, convert(varchar(19), exam_start1, 120) exam_start1, ");
		sql.append("       convert(varchar(19), exam_end1, 120) exam_end1 ");
		sql.append("From exam_m ");
		sql.append("Where id_exam = ? ");
		
	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeTime(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("����ð� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [PersonalTime.getTime2] " + ex.getMessage());			
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static PersonalTimeBean makeTime(ResultSet rst) throws QmTmException
    {
		try {
            PersonalTimeBean bean = new PersonalTimeBean();
            bean.setYn_sametime(rst.getString(1));
            bean.setLogin_start(rst.getString(2));
			bean.setLogin_end(rst.getString(3));
			bean.setExam_start1(rst.getString(4));
			bean.setExam_end1(rst.getString(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("�ð� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [PersonalTime.makeTime] " + ex.getMessage());
        }
    }

	public static long getLimittime(String id_exam) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select limittime From exam_m Where id_exam = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getLong("limittime"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("���� ���ѽð� ���� �о���� �� ������ �߻��Ǿ����ϴ�. [PersonalTime.getLimittime] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static PersonalTimeBean[] getUserTimeList(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, convert(varchar(16), a.login_start, 120) login_start, ");
		sql.append("       convert(varchar(16), a.login_end, 120) login_end, convert(varchar(16), a.exam_start1, 120) exam_start1, ");
		sql.append("       convert(varchar(16), a.exam_end1, 120) exam_end1, convert(varchar(16), a.regdate, 120) regdate ");
		sql.append("From personal_time a, qt_userid b ");
		sql.append("Where a.id_exam = ? and a.userid = b.userid ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
            rst = stm.executeQuery();
            PersonalTimeBean bean = null;
            while (rst.next()) {
                bean = makeUserTime(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (PersonalTimeBean[]) beans.toArray(new PersonalTimeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("���κ� ����ð����� �о���� �� ������ �߻��Ǿ����ϴ�. [PersonalTime.getUserTimeList] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static PersonalTimeBean makeUserTime (ResultSet rst) throws QmTmException
    {
		try {
            PersonalTimeBean bean = new PersonalTimeBean();
            bean.setUserid(rst.getString(1));
			bean.setName(rst.getString(2));
            bean.setLogin_start(rst.getString(3));
			bean.setLogin_end(rst.getString(4));
			bean.setExam_start1(rst.getString(5));
			bean.setExam_end1(rst.getString(6));
			bean.setRegdate(rst.getString(7));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("���κ� ����ð����� �о���� �� ������ �߻��Ǿ����ϴ�. [PersonalTime.makeUserTime] " + ex.getMessage());
        }
    }
	
}