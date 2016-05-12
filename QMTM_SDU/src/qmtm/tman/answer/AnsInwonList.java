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

public class AnsInwonList
{
    public AnsInwonList() {
    }

	public static AnsInwonListBean[] getUserids(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select userid ");
		sql.append("From exam_ans ");
		sql.append("Where id_exam = ? ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeUserids(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.getUserids] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static AnsInwonListBean makeUserids (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.makeUserids] " + ex.getMessage());
        }
    }
	
	public static AnsInwonListBean[] getBeans(String id_exam, String bigos) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, a.nr_set, convert(varchar(16), a.start_time, 120) start_time, ");
		sql.append("       convert(varchar(16), a.end_time, 120) end_time, a.score, a.score_bak, a.score_log, ");
		sql.append("       a.user_ip, c.success_score, c.yn_success_score, a.yn_success ");
		sql.append("From exam_ans a, qt_userid b, exam_m c  ");
		sql.append("Where a.id_exam = ? and a.yn_end = ? and a.userid = b.userid and a.id_exam = c.id_exam ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, bigos);
            rst = stm.executeQuery();
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.getBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static AnsInwonListBean[] getExcelBeans(String id_exam, String bigos) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, b.sosok1, b.sosok2, b.level, a.nr_set, ");
		sql.append("       convert(varchar(16), a.start_time, 120) start_time, convert(varchar(16), a.end_time, 120) end_time, ");
		sql.append("       a.score, a.score_bak, a.score_log, a.user_ip, c.success_score, c.yn_success_score, a.yn_success ");
		sql.append("From exam_ans a, qt_userid b, exam_m c ");
		sql.append("Where a.id_exam = ? and a.yn_end = ? and a.userid = b.userid and a.id_exam = c.id_exam ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, bigos);
            rst = stm.executeQuery();
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeExcelBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 엑셀정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.getExcelBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
    private static AnsInwonListBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
            bean.setNr_set(rst.getInt(3));
			bean.setStart_time(rst.getString(4));
			bean.setEnd_time(rst.getString(5));
			bean.setScore(rst.getDouble(6));
			bean.setScore_bak(rst.getDouble(7));
			bean.setScore_log(rst.getString(8));
			bean.setUser_ip(rst.getString(9));
			bean.setSuccess_score(rst.getDouble(10));
			bean.setYn_success_score(rst.getString(11));			
			bean.setYn_success(rst.getString(12));			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.makeBeans] " + ex.getMessage());
        }
    }

	private static AnsInwonListBean makeExcelBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
			bean.setSosok1(rst.getString(3));
			bean.setSosok2(rst.getString(4));
			bean.setLevel(rst.getString(5));
            bean.setNr_set(rst.getInt(6));
			bean.setStart_time(rst.getString(7));
			bean.setEnd_time(rst.getString(8));
			bean.setScore(rst.getDouble(9));
			bean.setScore_bak(rst.getDouble(10));
			bean.setScore_log(rst.getString(11));
			bean.setUser_ip(rst.getString(12));
			bean.setSuccess_score(rst.getDouble(13));
			bean.setYn_success_score(rst.getString(14));			
			bean.setYn_success(rst.getString(15));			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.makeExcelBeans] " + ex.getMessage());
        }
    }

	public static AnsInwonListBean[] getBeans2(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, a.name ");
		sql.append("From qt_userid a, exam_receipt b, exam_m c ");
		sql.append("Where c.id_exam = ? and c.id_auth_type = '2' and a.userid = b.userid and b.id_exam = c.id_exam ");
		sql.append("      and b.userid not in (select userid from exam_ans where id_exam = ?) ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, id_exam);
            rst = stm.executeQuery();
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeBeans2(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.getBeans2] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static AnsInwonListBean[] getExcelBeans2(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, a.name, a.sosok1, a.sosok2, a.level ");
		sql.append("From qt_userid a, exam_receipt b, exam_m c ");
		sql.append("Where c.id_exam = ? and c.id_auth_type = '2' and a.userid = b.userid and b.id_exam = c.id_exam ");
		sql.append("      and b.userid not in (select userid from exam_ans where id_exam = ?) ");
		sql.append("Union All ");		
		sql.append("Select a.userid, a.name, a.sosok1, a.sosok2, a.level ");
		sql.append("From qt_userid a, qt_course_user b, exam_m c ");
		sql.append("Where c.id_exam = ? and c.id_auth_type = '1' and a.userid = b.userid and b.id_course = c.id_course ");
		sql.append("      and b.course_year = c.course_year and b.course_no = c.course_no ");
		sql.append("      and b.userid not in (select userid from exam_ans where id_exam = ?) ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, id_exam);
			stm.setString(3, id_exam);
			stm.setString(4, id_exam);

            rst = stm.executeQuery();
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeExcelBeans2(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.getBeans2] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static AnsInwonListBean makeBeans2 (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.makeBeans2] " + ex.getMessage());
        }
    }

	private static AnsInwonListBean makeExcelBeans2 (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
			bean.setSosok1(rst.getString(3));
			bean.setSosok2(rst.getString(4));
			bean.setLevel(rst.getString(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.makeExcelBeans2] " + ex.getMessage());
        }
    }

	public static AnsInwonListBean[] getBeans3(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, a.nr_set, convert(varchar(16), a.start_time, 120) start_time, ");
		sql.append("       convert(varchar(16), a.end_time, 120) end_time, a.score, a.score_bak, a.score_log, ");
		sql.append("       a.user_ip, c.success_score, c.yn_success_score, a.yn_success ");
		sql.append("From bak_exam_ans a, qt_userid b, exam_m c ");
		sql.append("Where a.id_exam = ? and a.userid = b.userid and a.id_exam = c.id_exam ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeBeans3(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.getBeans3] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static AnsInwonListBean[] getExcelBeans3(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, b.sosok1, b.sosok2, b.level, a.nr_set, ");
		sql.append("       convert(varchar(16), a.start_time, 120) start_time, convert(varchar(16), a.end_time, 120) end_time, ");
		sql.append("       a.score, a.score_bak, a.score_log, a.user_ip, c.success_score, c.yn_success_score, a.yn_success ");
		sql.append("From bak_exam_ans a, qt_userid b, exam_m c ");
		sql.append("Where a.id_exam = ? and a.userid = b.userid and a.id_exam = c.id_exam ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeExcelBeans3(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.getBeans3] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
    private static AnsInwonListBean makeBeans3 (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
            bean.setNr_set(rst.getInt(3));
			bean.setStart_time(rst.getString(4));
			bean.setEnd_time(rst.getString(5));
			bean.setScore(rst.getDouble(6));
			bean.setScore_bak(rst.getDouble(7));
			bean.setScore_log(rst.getString(8));
			bean.setUser_ip(rst.getString(9));
			bean.setSuccess_score(rst.getDouble(10));
			bean.setYn_success_score(rst.getString(11));			
			bean.setYn_success(rst.getString(12));			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.makeBeans3] " + ex.getMessage());
        }
    }

	private static AnsInwonListBean makeExcelBeans3 (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
			bean.setSosok1(rst.getString(3));
			bean.setSosok2(rst.getString(4));
			bean.setLevel(rst.getString(5));
            bean.setNr_set(rst.getInt(6));
			bean.setStart_time(rst.getString(7));
			bean.setEnd_time(rst.getString(8));
			bean.setScore(rst.getDouble(9));
			bean.setScore_bak(rst.getDouble(10));
			bean.setScore_log(rst.getString(11));
			bean.setUser_ip(rst.getString(12));
			bean.setSuccess_score(rst.getDouble(13));
			bean.setYn_success_score(rst.getString(14));			
			bean.setYn_success(rst.getString(15));			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.makeExcelBeans3] " + ex.getMessage());
        }
    }

	public static AnsInwonListBean[] getSearchBeans(String id_exam, String yn_end, String userid, String name) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, a.nr_set, convert(varchar(16), a.start_time, 120) start_time, ");
		sql.append("       convert(varchar(16), a.end_time, 120) end_time, a.score, a.score_bak, a.score_log, ");
		sql.append("       a.user_ip, c.success_score, c.yn_success_score, a.yn_success ");
		sql.append("From exam_ans a, qt_userid b, exam_m c ");
		sql.append("Where a.id_exam = ? and a.yn_end = ? and a.userid = b.userid and a.id_exam = c.id_exam ");
		
		if(userid.equals("")) {
			sql.append(" and b.name like '%'+?+'%' ");
		} else if(name.equals("")) {
			sql.append(" and b.userid like '%'+?+'%' ");
		} else {
			sql.append(" and b.userid like '%'+?+'%' and b.name like '%'+?+'%' ");
		}

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setString(2, yn_end);
			if(userid.equals("")) {
				stm.setString(3, name);
			} else if(name.equals("")) {
				stm.setString(3, userid);
			} else {
				stm.setString(3, userid);
				stm.setString(4, name);
			}
			rst = stm.executeQuery();
			


            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.getSearchBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static AnsInwonListBean makeSearchBeans (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
            bean.setNr_set(rst.getInt(3));
			bean.setStart_time(rst.getString(4));
			bean.setEnd_time(rst.getString(5));
			bean.setScore(rst.getDouble(6));
			bean.setScore_bak(rst.getDouble(7));
			bean.setScore_log(rst.getString(8));
			bean.setUser_ip(rst.getString(9));
			bean.setSuccess_score(rst.getDouble(10));
			bean.setYn_success_score(rst.getString(11));			
			bean.setYn_success(rst.getString(12));			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.makeSearchBeans] " + ex.getMessage());
        }
    }

	public static AnsInwonListBean[] getSearchBeans2(String id_exam, String userid, String name) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, a.name ");
		sql.append("From qt_userid a, exam_receipt b, exam_m c ");
		sql.append("Where c.id_exam = ? and c.id_auth_type = '2' and a.userid = b.userid and b.id_exam = c.id_exam ");
		sql.append("      and b.userid not in (select userid from exam_ans where id_exam = ?) and ");
		if(userid.equals("")) {
			sql.append(" a.name like '%'+?+'%' ");
		} else if(name.equals("")) {
			sql.append(" a.userid like '%'+?+'%' ");
		} else {
			sql.append(" a.userid like '%'+?+'%' and a.name like '%'+?+'%' ");
		}

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setString(2, id_exam);
			if(userid.equals("")) {
				stm.setString(3, name);
			} else if(name.equals("")) {
				stm.setString(3, userid);
			} else {
				stm.setString(3, userid);
				stm.setString(4, name);
			}
	        rst = stm.executeQuery();
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeSearchBeans2(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.getSearchBeans2] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static AnsInwonListBean makeSearchBeans2 (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.makeSearchBeans2] " + ex.getMessage());
        }
    }

	public static AnsInwonListBean[] getSearchBeans3(String id_exam, String userid, String name) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, a.nr_set, convert(varchar(16), a.start_time, 120) start_time, ");
		sql.append("       convert(varchar(16), a.end_time, 120) end_time, a.score, a.score_bak, a.score_log, ");
		sql.append("       a.user_ip, c.success_score, c.yn_success_score, a.yn_success ");
		sql.append("From bak_exam_ans a, qt_userid b, exam_m c ");
		sql.append("Where a.id_exam = ? and a.userid = b.userid and a.id_exam = c.id_exam ");
		
		if(userid.equals("")) {
			sql.append(" and b.name like '%'+?+'%' ");
		} else if(name.equals("")) {
			sql.append(" and b.userid like '%'+?+'%' ");
		} else {
			sql.append(" and b.userid like '%'+?+'%' and b.name like '%'+?+'%' ");
		}

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			if(userid.equals("")) {
				stm.setString(2, name);
			} else if(name.equals("")) {
				stm.setString(2, userid);
			} else {
				stm.setString(2, userid);
				stm.setString(3, name);
			}
            rst = stm.executeQuery();
            AnsInwonListBean bean = null;
            while (rst.next()) {
                bean = makeSearchBeans3(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListBean[]) beans.toArray(new AnsInwonListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.getSearchBeans3] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static AnsInwonListBean makeSearchBeans3 (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListBean bean = new AnsInwonListBean();
            bean.setUserid(rst.getString(1));
            bean.setName(rst.getString(2));
            bean.setNr_set(rst.getInt(3));
			bean.setStart_time(rst.getString(4));
			bean.setEnd_time(rst.getString(5));
			bean.setScore(rst.getDouble(6));
			bean.setScore_bak(rst.getDouble(7));
			bean.setScore_log(rst.getString(8));
			bean.setUser_ip(rst.getString(9));
			bean.setSuccess_score(rst.getDouble(10));
			bean.setYn_success_score(rst.getString(11));			
			bean.setYn_success(rst.getString(12));			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.makeSearchBeans3] " + ex.getMessage());
        }
    }

	public static int getTotInwon(String id_exam, int id_auth_type) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		if(id_auth_type == 1) {
			sql.append("Select count(b.userid) as totcnt ");
			sql.append("From exam_m a, qt_course_user b ");
			sql.append("Where a.id_exam = ? and a.id_course = b.id_course  ");
			sql.append("      and a.course_year = b.course_year and a.course_no = b.course_no ");
		} else if(id_auth_type == 2) {
			sql.append("Select count(userid) as totcnt ");
			sql.append("From exam_receipt ");
			sql.append("Where id_exam = ? ");
		}

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getInt("totcnt"); 
            else return 0; 
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.getTotInwon] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static int getYesInwon(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(userid) as yescnt ");
		sql.append("From exam_ans ");
		sql.append("Where id_exam = ? and userid <> 'tman@@2008' ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getInt("yescnt"); 
            else return 0; 
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.getYesInwon] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static int getAnsY(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(userid) as yescnt ");
		sql.append("From exam_ans ");
		sql.append("Where id_exam = ? and yn_end = 'Y' and userid <> 'tman@@2008' ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getInt("yescnt"); 
            else return 0; 
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.getAnsY] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static int getAnsN(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(userid) as nocnt ");
		sql.append("From exam_ans ");
		sql.append("Where id_exam = ? and yn_end = 'N' and userid <> 'tman@@2008' ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString()); 
            stm.setString(1, id_exam);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getInt("nocnt"); 
            else return 0; 
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonList.getAnsN] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}