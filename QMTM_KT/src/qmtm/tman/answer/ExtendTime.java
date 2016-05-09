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

public class ExtendTime
{
    public ExtendTime() {
    }
	
	public static void delete(String id_exam, String userid, int extend_time) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Delete From extend_time ");
		sql.append("Where id_exam = ? and userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, userid);

			stm.execute();

			insert(id_exam, userid, extend_time);
        }
        catch (SQLException ex) {
            throw new QmTmException("개인별 제한시간 삭제 중 인터넷 연결상태가 좋지 않습니다. [ExtendTime.delete]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void insert(String id_exam, String userid, int extend_time) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Insert into extend_time ");
		sql.append("Values(?, ?, '인터넷장애로시간연장', ?, 'N', getdate()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, userid);
			stm.setInt(3, extend_time);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("개인별 제한시간 등록 중 인터넷 연결상태가 좋지 않습니다. [ExtendTime.insert]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void allDelete(String id_exam, int extend_time) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Delete From extend_time ");
		sql.append("Where id_exam = ? and userid in ");
		sql.append("     ( ");
		sql.append("      Select userid From exam_ans ");
		sql.append("      Where id_exam = ? and yn_end = 'N' ");
		sql.append("     ) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, id_exam);

			stm.execute();

			allInsert(id_exam, extend_time);
        }
        catch (SQLException ex) {
            throw new QmTmException("미완료자 제한시간 삭제 중 인터넷 연결상태가 좋지 않습니다. [ExtendTime.allDelete]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void allInsert(String id_exam, int extend_time) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Insert into extend_time ");
		sql.append("Select id_exam, userid, '인터넷장애로시간연장', ?, 'N', getdate() ");
		sql.append("From exam_ans ");
		sql.append("Where id_exam = ? and yn_end = 'N' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setInt(1, extend_time);
			stm.setString(2, id_exam);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("미완료자 제한시간 등록 중 인터넷 연결상태가 좋지 않습니다. [ExtendTime.allInsert]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void pDelete(ExtendTimeBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Delete From personal_time ");
        sql.append("Where id_exam = ? and userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());            
			stm.setString(1, bean.getId_exam());
			stm.setString(2, bean.getUserid());

			stm.execute();

			pInsert(bean);
        }
        catch (SQLException ex) {
            throw new QmTmException("개인시간 삭제 작업 중 인터넷 연결상태가 좋지 않습니다. [ExtendTime.pDelete]");			
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static void pInsert(ExtendTimeBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO personal_time (id_exam, userid, yn_sametime, login_start, login_end, exam_start1, exam_end1, regdate) ");
        sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, getdate()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());            
			stm.setString(1, bean.getId_exam());
			stm.setString(2, bean.getUserid());
			stm.setString(3, bean.getYn_sametime());
			stm.setTimestamp(4, bean.getLogin_start());
            stm.setTimestamp(5, bean.getLogin_end());
			stm.setTimestamp(6, bean.getExam_start1());
			stm.setTimestamp(7, bean.getExam_end1());

			stm.execute();
        }
        catch (SQLException ex) {
            //throw new QmTmException("개인시간 변경 작업 중 인터넷 연결상태가 좋지 않습니다. [ExtendTime.pInsert]");
			throw new QmTmException(ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void handicapDelete(String id_exam, String userid, int extend_time) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Delete From extend_time ");
        sql.append("Where id_exam = ? and userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());            
			stm.setString(1, id_exam);
			stm.setString(2, userid);

			stm.execute();

			handicapInsert(id_exam, userid, extend_time);
        }
        catch (SQLException ex) {
            throw new QmTmException("장애학우 시간연장 삭제 작업 중 인터넷 연결상태가 좋지 않습니다. [ExtendTime.handicapDelete]");			
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static void handicapInsert(String id_exam, String userid, int extend_time) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Insert into extend_time ");
		sql.append("Values(?, ?, '장애학우시간연장', ?, 'N', getdate()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, userid);
			stm.setInt(3, extend_time);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("장애학우 제한시간 등록 중 인터넷 연결상태가 좋지 않습니다. [ExtendTime.handicapInsert]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExtendTimeBean[] getExtendTimeList(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, a.ext_reason, a.ext_min, a.yn_start, ");
		sql.append("       convert(varchar(16), a.regdate, 120) regdate ");
		sql.append("From extend_time a, qt_userid b ");
		sql.append("Where a.id_exam = ? and a.userid = b.userid ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
            rst = stm.executeQuery();
            ExtendTimeBean bean = null;
            while (rst.next()) {
                bean = makeExtendTime(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExtendTimeBean[]) beans.toArray(new ExtendTimeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("개인별 시간연장정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExtendTime.getExtendTimeList]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static ExtendTimeBean makeExtendTime (ResultSet rst) throws QmTmException
    {
		try {
            ExtendTimeBean bean = new ExtendTimeBean();
            bean.setUserid(rst.getString(1));
			bean.setName(rst.getString(2));
            bean.setExt_reason(rst.getString(3));
			bean.setExt_min(rst.getInt(4));
			bean.setYn_start(rst.getString(5));
			bean.setRegdate(rst.getString(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("개인별 시간연장정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExtendTime.makeExtendTime]");
        }
    }

	public static ExtendTimeBean getExtendTime(String id_exam, String userid) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select ext_min, yn_start ");
		sql.append("From extend_time ");
		sql.append("Where id_exam = ? and userid = ? ");
		
	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setString(2, userid);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeExtendTime2(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("개인별 시간연장정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [PersonalTime2.getExtendTime]");			
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static ExtendTimeBean makeExtendTime2 (ResultSet rst) throws QmTmException
    {
		try {
            ExtendTimeBean bean = new ExtendTimeBean();
           	bean.setExt_min(rst.getInt(1));
			bean.setYn_start(rst.getString(2));			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("개인별 시간연장정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExtendTime.makeExtendTime2]");
        }
    }

	public static void extendTimeUpdate(String id_exam, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update extend_time ");
		sql.append("       Set yn_start = 'Y' ");
		sql.append("Where id_exam = ? and userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, userid);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("남은시간 연장 관련 수정완료 중 인터넷 연결상태가 좋지 않습니다. [ExtendTime.extendTimeUpdate]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void remainTimeUpdate(String id_exam, String userid, int lngExtTime) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Update extend_ans ");
		sql.append("       Set remain_time = remain_time + ? ");
		sql.append("Where id_exam = ? and userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setInt(1, lngExtTime);
			stm.setString(2, id_exam);
			stm.setString(3, userid);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험시간 연장 관련 수정완료 중 인터넷 연결상태가 좋지 않습니다. [ExtendTime.remainTimeUpdate]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}