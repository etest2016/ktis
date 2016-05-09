package qmtm.tman.exam;

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

public class IngInwon
{
    public IngInwon() {
    }

	public static IngInwonBean[] getBeans(String start_date, String end_date) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		/*
		sql.append("Select id_exam, title, convert(varchar(16), exam_start1, 120) exam_start, ");
		sql.append("       convert(varchar(16), exam_end1, 120) exam_end, id_auth_type ");
		sql.append("From exam_m ");
		sql.append("Where convert(varchar(8), exam_start1, 112) >= ? ");
		sql.append("      and convert(varchar(8), exam_start1, 112) <= ? and yn_enable = 'Y' ");
		*/
		
		sql.append("Select id_exam, title, to_char(exam_start1, 'YYYY-MM-DD HH24:MI') exam_start, ");
		sql.append("       to_char(exam_end1, 'YYYY-MM-DD HH24:MI') exam_end, id_auth_type ");
		sql.append("From exam_m ");
		sql.append("Where to_char(exam_start1, 'YYYYMMDD') >= ? ");
		sql.append("      and to_char(exam_start1, 'YYYYMMDD') <= ? and yn_enable = 'Y' ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, start_date);
			stm.setString(2, end_date);
            rst = stm.executeQuery();
            IngInwonBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (IngInwonBean[]) beans.toArray(new IngInwonBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("1검색일자 내 시험정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	private static IngInwonBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            IngInwonBean bean = new IngInwonBean();
            bean.setId_exam(rst.getString(1));
			bean.setTitle(rst.getString(2));
			bean.setExam_start(rst.getString(3));
			bean.setExam_end(rst.getString(4));
			bean.setId_auth_type(rst.getInt(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("1검색일자 내 시험정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }

	private static IngInwonBean makeInwons (ResultSet rst) throws QmTmException
    {
		try {
            IngInwonBean bean = new IngInwonBean();
            bean.setId_exam(rst.getString(1));
			bean.setTot_inwon(rst.getInt(2));
			bean.setAns_y_inwon(rst.getInt(3));
			bean.setAns_n_inwon(rst.getInt(4));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("1검색일자 내 시험정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }

	public static IngInwonBean getInwons(String id_exam, int id_auth_type) throws QmTmException 
	{
        Connection cnn = null; Statement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_exam, ");
		if(id_auth_type == 0) { // 로그인
			sql.append("       (Select count(userid) From qt_userid) as tot_inwon, ");
		} else if(id_auth_type == 1) { // 과정
			sql.append("       (Select count(b.userid) From exam_m a, qt_course_user b ");
			sql.append("        Where a.id_exam = '"+ id_exam +"' and a.id_course = b.id_course and a.id_subject = b.id_subject ");
			sql.append("       and a.course_year = b.course_year and a.course_no = b.course_no) as tot_inwon, ");
		} else if(id_auth_type == 2) { // 접수
			sql.append("       (Select count(userid) as totcnt From exam_receipt Where id_exam = '"+ id_exam +"') as tot_inwon, ");
		}
		sql.append("       (Select count(userid) From exam_ans Where id_exam  = '"+ id_exam +"' and userid <> 'tman@@2008' and yn_end = 'Y') AS y, ");
		sql.append("       (Select count(userid) From exam_ans Where id_exam = '"+ id_exam +"' and userid <> 'tman@@2008' and yn_end = 'N') AS n ");
		sql.append("From exam_m ");
		sql.append("Where id_exam = '"+ id_exam +"' ");
		sql.append("Group by id_exam ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.createStatement();
			rst = stm.executeQuery(sql.toString());
			if (rst.next()) {
				return makeInwons(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("2검색일자 내 시험 인원정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	public static IngInwonBean[] getInwonRes(String start_date, String end_date) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		/*
		sql.append("Select a.id_exam, a.title, convert(varchar(16),a.exam_start1,120), convert(varchar(16),a.exam_end1,120), "); 
        sql.append("       convert(varchar(16),a.login_start,120), convert(varchar(16),a.login_end,120), convert(varchar(16),a.stat_start,120), "); 
        sql.append("       convert(varchar(16),a.stat_end,120), a.id_exam_kind, a.yn_enable, a.limittime/60, a.qcount, a.allotting, a.setcount, "); 
        sql.append("       a.exam_pwd_yn, a.exam_pwd_str, b.cnt receipt_inwon, isnull(c.cnt,0)+isnull(d.cnt,0) ans_inwon, "); 
        sql.append("       isnull(c.cnt, 0) ans_n_inwon, isnull(d.cnt, 0) ans_y_inwon, b.cnt-(isnull(c.cnt, 0)+isnull(d.cnt, 0)) no_inwon, e.course ");
		sql.append("From exam_m a, ");
		sql.append("( ");
		sql.append("  Select a.id_exam, count(*) as cnt from exam_receipt a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  select id_exam from exam_m where id_auth_type = 2 and convert(varchar(10), exam_start1, 120) between ? and ? ");
		sql.append(") "); 
		sql.append("  group by a.id_exam ");
		sql.append(") b left join ");
		sql.append("( ");
		sql.append("  select a.id_exam, count(*) as cnt from exam_ans a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  select id_exam from exam_m where id_auth_type = 2 and convert(varchar(10), exam_start1, 120) between ? and ? ");
		sql.append(") and a.yn_end = 'N' and a.userid <> 'tman@@2008' ");
		sql.append("  group by a.id_exam ");
		sql.append(") c on b.id_exam = c.id_exam left join ");
		sql.append("( ");
		sql.append("  select a.id_exam, count(*) as cnt from exam_ans a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  select id_exam from exam_m where id_auth_type = 2 and convert(varchar(10), exam_start1, 120) between ? and ? ");
		sql.append(") and a.yn_end = 'Y' and a.userid <> 'tman@@2008' ");
		sql.append("  group by a.id_exam ");
		sql.append(") d on b.id_exam = d.id_exam left join ");
		sql.append("  c_course e on a.id_course = e.id_course ");
		sql.append("Where a.id_exam = b.id_exam ");
		sql.append("	  and convert(varchar(10), a.exam_start1, 120) between ? and ? ");
		sql.append("Order by a.exam_start1 ");
		*/

		sql.append("Select a.id_exam, a.title, to_char(a.exam_start1,'YYYY-MM-DD HH24:MI'), to_char(a.exam_end1,'YYYY-MM-DD HH24:MI'), "); 
        sql.append("       to_char(a.login_start,'YYYY-MM-DD HH24:MI'), to_char(a.login_end,'YYYY-MM-DD HH24:MI'), to_char(a.stat_start,'YYYY-MM-DD HH24:MI'), "); 
        sql.append("       to_char(a.stat_end,'YYYY-MM-DD HH24:MI'), a.id_exam_kind, a.yn_enable, a.limittime/60, a.qcount, a.allotting, a.setcount, "); 
        sql.append("       a.exam_pwd_yn, a.exam_pwd_str, b.cnt receipt_inwon, nullif(c.cnt,0)+nullif(d.cnt,0) ans_inwon, "); 
        sql.append("       nullif(c.cnt, 0) ans_n_inwon, nullif(d.cnt, 0) ans_y_inwon, b.cnt-(nullif(c.cnt, 0)+nullif(d.cnt, 0)) no_inwon, e.course ");
		sql.append("From exam_m a, ");
		sql.append("( ");
		sql.append("  Select a.id_exam, count(*) as cnt from exam_receipt a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  select id_exam from exam_m where id_auth_type = 2 and to_char(exam_start1, 'YYYY-MM-DD') between ? and ? ");
		sql.append(") "); 
		sql.append("  group by a.id_exam ");
		sql.append(") b left join ");
		sql.append("( ");
		sql.append("  select a.id_exam, count(*) as cnt from exam_ans a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  select id_exam from exam_m where id_auth_type = 2 and to_char(exam_start1, 'YYYY-MM-DD') between ? and ? ");
		sql.append(") and a.yn_end = 'N' and a.userid <> 'tman@@2008' ");
		sql.append("  group by a.id_exam ");
		sql.append(") c on b.id_exam = c.id_exam left join ");
		sql.append("( ");
		sql.append("  select a.id_exam, count(*) as cnt from exam_ans a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  select id_exam from exam_m where id_auth_type = 2 and to_char(exam_start1, 'YYYY-MM-DD') between ? and ? ");
		sql.append(") and a.yn_end = 'Y' and a.userid <> 'tman@@2008' ");
		sql.append("  group by a.id_exam ");
		sql.append(") d on b.id_exam = d.id_exam left join ");
		sql.append("  c_course e on a.id_course = e.id_course ");
		sql.append("Where a.id_exam = b.id_exam ");
		sql.append("	  and to_char(a.exam_start1, 'YYYY-MM-DD') between ? and ? ");
		sql.append("Order by a.exam_start1 ");

		
		System.out.println(sql.toString());

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, start_date);
			stm.setString(2, end_date);
			stm.setString(3, start_date);
			stm.setString(4, end_date);
			stm.setString(5, start_date);
			stm.setString(6, end_date);
			stm.setString(7, start_date);
			stm.setString(8, end_date);
            rst = stm.executeQuery();
            IngInwonBean bean = null;
            while (rst.next()) {
                bean = makeInwonRes(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (IngInwonBean[]) beans.toArray(new IngInwonBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("2.검색일자 내 시험 응시현황정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");			
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static IngInwonBean[] getInwonRes(String id_course, String id_subject, String start_date, String end_date) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		/*
		sql.append("Select a.id_exam, a.title, convert(varchar(16),a.exam_start1,120), convert(varchar(16),a.exam_end1,120), "); 
        sql.append("       convert(varchar(16),a.login_start,120), convert(varchar(16),a.login_end,120), convert(varchar(16),a.stat_start,120), "); 
        sql.append("       convert(varchar(16),a.stat_end,120), a.id_exam_kind, a.yn_enable, a.limittime/60, a.qcount, a.allotting, a.setcount, "); 
        sql.append("       a.exam_pwd_yn, a.exam_pwd_str, b.cnt receipt_inwon, isnull(c.cnt,0)+isnull(d.cnt,0) ans_inwon, "); 
        sql.append("       isnull(c.cnt, 0) ans_n_inwon, isnull(d.cnt, 0) ans_y_inwon, b.cnt-(isnull(c.cnt, 0)+isnull(d.cnt, 0)) no_inwon, e.course ");
		sql.append("From exam_m a, ");
		sql.append("( ");
		sql.append("  Select a.id_exam, count(*) as cnt from exam_receipt a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  select id_exam from exam_m where id_auth_type = 2 and convert(varchar(10), exam_start1, 120) between ? and ? ");
		sql.append("         and id_course = ? and id_subject = ? ");
		sql.append(") "); 
		sql.append("  group by a.id_exam ");
		sql.append(") b left join ");
		sql.append("( ");
		sql.append("  select a.id_exam, count(*) as cnt from exam_ans a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  select id_exam from exam_m where id_auth_type = 2 and convert(varchar(10), exam_start1, 120) between ? and ? ");
		sql.append("         and id_course = ? and id_subject = ? ");
		sql.append(") and a.yn_end = 'N' and a.userid <> 'tman@@2008'  ");
		sql.append("  group by a.id_exam ");
		sql.append(") c on b.id_exam = c.id_exam left join ");
		sql.append("( ");
		sql.append("  select a.id_exam, count(*) as cnt from exam_ans a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  select id_exam from exam_m where id_auth_type = 2 and convert(varchar(10), exam_start1, 120) between ? and ? ");
		sql.append("         and id_course = ? and id_subject = ? ");
		sql.append(") and a.yn_end = 'Y' and a.userid <> 'tman@@2008' ");
		sql.append("  group by a.id_exam ");
		sql.append(") d on b.id_exam = d.id_exam left join ");
		sql.append("  c_course e on a.id_course = e.id_course ");
		sql.append("Where a.id_exam = b.id_exam ");
		sql.append("	  and convert(varchar(10), a.exam_start1, 120) between ? and ? ");
		sql.append("      and id_course = ? and id_subject = ? ");
		sql.append("Order by a.exam_start1 ");
		 
		 */
		
		sql.append("Select a.id_exam, a.title, to_char(a.exam_start1,'YYYY-MM-DD HH24:MI'), to_char(a.exam_end1,'YYYY-MM-DD HH24:MI'), "); 
        sql.append("       to_char(a.login_start,'YYYY-MM-DD HH24:MI'), to_char(a.login_end,'YYYY-MM-DD HH24:MI'), to_char(a.stat_start,'YYYY-MM-DD HH24:MI'), "); 
        sql.append("       to_char(a.stat_end,'YYYY-MM-DD HH24:MI'), a.id_exam_kind, a.yn_enable, a.limittime/60, a.qcount, a.allotting, a.setcount, "); 
        sql.append("       a.exam_pwd_yn, a.exam_pwd_str, b.cnt receipt_inwon, nullif(c.cnt,0)+nullif(d.cnt,0) ans_inwon, "); 
        sql.append("       nullif(c.cnt, 0) ans_n_inwon, nullif(d.cnt, 0) ans_y_inwon, b.cnt-(nullif(c.cnt, 0)+nullif(d.cnt, 0)) no_inwon, e.course ");
		sql.append("From exam_m a, ");
		sql.append("( ");
		sql.append("  Select a.id_exam, count(*) as cnt from exam_receipt a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  select id_exam from exam_m where id_auth_type = 2 and to_char(exam_start1, 'YYYY-MM-DD') between ? and ? ");
		sql.append("         and id_course = ? and id_subject = ? ");
		sql.append(") "); 
		sql.append("  group by a.id_exam ");
		sql.append(") b left join ");
		sql.append("( ");
		sql.append("  select a.id_exam, count(*) as cnt from exam_ans a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  select id_exam from exam_m where id_auth_type = 2 and to_char(exam_start1, 'YYYY-MM-DD') between ? and ? ");
		sql.append("         and id_course = ? and id_subject = ? ");
		sql.append(") and a.yn_end = 'N' and a.userid <> 'tman@@2008'  ");
		sql.append("  group by a.id_exam ");
		sql.append(") c on b.id_exam = c.id_exam left join ");
		sql.append("( ");
		sql.append("  select a.id_exam, count(*) as cnt from exam_ans a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  select id_exam from exam_m where id_auth_type = 2 and to_char(exam_start1, 'YYYY-MM-DD') between ? and ? ");
		sql.append("         and id_course = ? and id_subject = ? ");
		sql.append(") and a.yn_end = 'Y' and a.userid <> 'tman@@2008' ");
		sql.append("  group by a.id_exam ");
		sql.append(") d on b.id_exam = d.id_exam left join ");
		sql.append("  c_course e on a.id_course = e.id_course ");
		sql.append("Where a.id_exam = b.id_exam ");
		sql.append("	  and to_char(a.exam_start1, 'YYYY-MM-DD') between ? and ? ");
		sql.append("      and id_course = ? and id_subject = ? ");
		sql.append("Order by a.exam_start1 ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, start_date);
			stm.setString(2, end_date);
			stm.setString(3, id_course);
			stm.setString(4, id_subject);
			stm.setString(5, start_date);
			stm.setString(6, end_date);
			stm.setString(7, id_course);
			stm.setString(8, id_subject);
			stm.setString(9, start_date);
			stm.setString(10, end_date);
			stm.setString(11, id_course);
			stm.setString(12, id_subject);
			stm.setString(13, start_date);
			stm.setString(14, end_date);
			stm.setString(15, id_course);
			stm.setString(16, id_subject);
            rst = stm.executeQuery();
            IngInwonBean bean = null;
            while (rst.next()) {
                bean = makeInwonRes(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (IngInwonBean[]) beans.toArray(new IngInwonBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("2.검색일자 내 시험 응시현황정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");			
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static IngInwonBean makeInwonRes(ResultSet rst) throws QmTmException
    {
		try {
			IngInwonBean bean = new IngInwonBean();
            bean.setId_exam(rst.getString(1));
			bean.setTitle(rst.getString(2));
			bean.setExam_start(rst.getString(3));
			bean.setExam_end(rst.getString(4));
			bean.setLogin_start(rst.getString(5));
			bean.setLogin_end(rst.getString(6));
			bean.setStat_start(rst.getString(7));
			bean.setStat_end(rst.getString(8));
			bean.setId_exam_kind(rst.getInt(9));
			bean.setYn_enable(rst.getString(10));
			bean.setLimittime(rst.getLong(11));
			bean.setQcount(rst.getInt(12));
			bean.setAllotting(rst.getDouble(13));
			bean.setSetcount(rst.getInt(14));
			bean.setExam_pwd_yn(rst.getString(15));
			bean.setExam_pwd_str(rst.getString(16));
			bean.setTot_inwon(rst.getInt(17));
			bean.setAns_inwon(rst.getInt(18));
			bean.setNo_inwon(rst.getInt(19));
			bean.setAns_y_inwon(rst.getInt(20));
			bean.setAns_n_inwon(rst.getInt(21));
			bean.setCourse(rst.getString(22));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("2.검색일자 내 시험정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }

	public static IngInwonBean getInwonRe(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		/*
		sql.append("Select a.id_exam, a.title, convert(varchar(16),a.exam_start1,120), convert(varchar(16),a.exam_end1,120), "); 
        sql.append("       convert(varchar(16),a.login_start,120), convert(varchar(16),a.login_end,120), convert(varchar(16),a.stat_start,120), "); 
        sql.append("       convert(varchar(16),a.stat_end,120), a.id_exam_kind, a.yn_enable, a.limittime/60, a.qcount, a.allotting, a.setcount, "); 
        sql.append("       a.exam_pwd_yn, a.exam_pwd_str, b.cnt receipt_inwon, isnull(c.cnt,0)+isnull(d.cnt,0) ans_inwon, "); 
        sql.append("       isnull(c.cnt, 0) ans_n_inwon, isnull(d.cnt, 0) ans_y_inwon, b.cnt-(isnull(c.cnt, 0)+isnull(d.cnt, 0)) no_inwon, e.course ");
		sql.append("From exam_m a, ");
		sql.append("( ");
		sql.append("  Select a.id_exam, count(*) as cnt from exam_receipt a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  ? ");
		sql.append(") "); 
		sql.append("  group by a.id_exam ");
		sql.append(") b left join ");
		sql.append("( ");
		sql.append("  select a.id_exam, count(*) as cnt from exam_ans a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  ? ");
		sql.append(") and a.yn_end = 'N' and a.userid <> 'tman@@2008' ");
		sql.append("  group by a.id_exam ");
		sql.append(") c on b.id_exam = c.id_exam left join ");
		sql.append("( ");
		sql.append("  select a.id_exam, count(*) as cnt from exam_ans a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  ? ");
		sql.append(") and a.yn_end = 'Y' and a.userid <> 'tman@@2008' ");
		sql.append("  group by a.id_exam ");
		sql.append(") d on b.id_exam = d.id_exam left join ");
		sql.append("  c_course e on a.id_course = e.id_course ");
		sql.append("Where a.id_exam = b.id_exam ");
		sql.append("	  and a.id_exam = ? ");

		 */
		
		sql.append("Select a.id_exam, a.title, to_char(a.exam_start1,'YYYY-MM-DD HH24:MI'), to_char(a.exam_end1,'YYYY-MM-DD HH24:MI'), "); 
        sql.append("       to_char(a.login_start,'YYYY-MM-DD HH24:MI'), to_char(a.login_end,'YYYY-MM-DD HH24:MI'), to_char(a.stat_start,'YYYY-MM-DD HH24:MI'), "); 
        sql.append("       to_char(a.stat_end,'YYYY-MM-DD HH24:MI'), a.id_exam_kind, a.yn_enable, a.limittime/60, a.qcount, a.allotting, a.setcount, "); 
        sql.append("       a.exam_pwd_yn, a.exam_pwd_str, b.cnt receipt_inwon, nullif(c.cnt,0)+nullif(d.cnt,0) ans_inwon, "); 
        sql.append("       nullif(c.cnt, 0) ans_n_inwon, nullif(d.cnt, 0) ans_y_inwon, b.cnt-(nullif(c.cnt, 0)+nullif(d.cnt, 0)) no_inwon, e.course ");
		sql.append("From exam_m a, ");
		sql.append("( ");
		sql.append("  Select a.id_exam, count(*) as cnt from exam_receipt a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  ? ");
		sql.append(") "); 
		sql.append("  group by a.id_exam ");
		sql.append(") b left join ");
		sql.append("( ");
		sql.append("  select a.id_exam, count(*) as cnt from exam_ans a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  ? ");
		sql.append(") and a.yn_end = 'N' and a.userid <> 'tman@@2008' ");
		sql.append("  group by a.id_exam ");
		sql.append(") c on b.id_exam = c.id_exam left join ");
		sql.append("( ");
		sql.append("  select a.id_exam, count(*) as cnt from exam_ans a, qt_userid b where a.userid = b.userid and a.id_exam in ( ");
		sql.append("  ? ");
		sql.append(") and a.yn_end = 'Y' and a.userid <> 'tman@@2008' ");
		sql.append("  group by a.id_exam ");
		sql.append(") d on b.id_exam = d.id_exam left join ");
		sql.append("  c_course e on a.id_course = e.id_course ");
		sql.append("Where a.id_exam = b.id_exam ");
		sql.append("	  and a.id_exam = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, id_exam);
			stm.setString(3, id_exam);
			stm.setString(4, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) {
				return makeInwonRes(rst);
			} else {
				return null;
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("2.검색일자 내 시험 응시현황정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");			
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}