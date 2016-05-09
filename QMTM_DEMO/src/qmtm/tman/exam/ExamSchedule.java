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
import java.sql.PreparedStatement;

public class ExamSchedule
{
    public ExamSchedule() {
    }

	public static int getCounts(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select count(*) as cnt ");
		sql.append("From exam_receipt ");
		sql.append("Where id_exam = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        }
        catch (SQLException ex) {
			throw new QmTmException("시험 대상자 인원 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamSchedule.getCounts]");
        }
        finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamScheduleBean[] getBeans(String years, String months, String days) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_exam, title From exam_m ");
		//sql.append("Where convert(varchar(4), exam_start1, 112) = ? and substring(convert(varchar(8), exam_start1, 112),5,2) = ? ");
		//sql.append("      and substring(convert(varchar(8), exam_start1, 112),7,2) = ? ");
		sql.append("Where to_char(exam_start1, 'YYYY') = ? and substring(to_char(exam_start1, 'YYYYMMDD'),5,2) = ? ");
		sql.append("      and substring(to_char(exam_start1, 'YYYYMMDD'),7,2) = ? ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, years);
			stm.setString(2, months);
			stm.setString(3, days);
            rst = stm.executeQuery();
            ExamScheduleBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamScheduleBean[]) beans.toArray(new ExamScheduleBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험 일정정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamScheduleBean[] getBeans2(String years, String months, String days, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_exam, title From exam_m ");
		//sql.append("Where convert(varchar(4), exam_start1, 112) = ? and substring(convert(varchar(8), exam_start1, 112),5,2) = ? ");
		//sql.append("      and substring(convert(varchar(8), exam_start1, 112),7,2) = ? and userid = ? ");
		sql.append("Where to_char(exam_start1, 'YYYY') = ? and substring(to_char(exam_start1, 'YYYYMMDD'),5,2) = ? ");
		sql.append("      and substring(to_char(exam_start1, 'YYYYMMDD'),7,2) = ? and userid = ? ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, years);
			stm.setString(2, months);
			stm.setString(3, days);
			stm.setString(4, userid);
            rst = stm.executeQuery();
            ExamScheduleBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamScheduleBean[]) beans.toArray(new ExamScheduleBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험 일정정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static ExamScheduleBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            ExamScheduleBean bean = new ExamScheduleBean();
            bean.setId_exam(rst.getString(1));
			bean.setTitle(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험 일정정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }
	
	public static ExamScheduleBean[] getInwonRes(String start_date, String end_date) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		/*
		sql.append("Select a.course, b.id_exam, b.title, convert(varchar(10),b.exam_start1,120) exam_start, ");
        sql.append("	   convert(varchar(10),b.exam_end1,120) exam_end, c.inwons, d.ans_inwons ");
		sql.append("From c_course a, exam_m b, "); 
		sql.append("	(Select a.id_exam, count(b.userid) inwons From exam_m a, exam_receipt b "); 
		sql.append("     Where convert(varchar(10), exam_start1, 120) between ? and ? and a.id_exam = b.id_exam "); 
		sql.append("     Group by a.id_exam ) c, "); 
		sql.append("    (Select a.id_exam, count(b.userid) ans_inwons From exam_m a, exam_ans b "); 
		sql.append("     Where convert(varchar(10), exam_start1, 120) between ? and ? and "); 
		sql.append("           a.id_exam = b.id_exam and b.userid <> 'tman@@2008' ");
		sql.append("     Group by a.id_exam ) d ");
		sql.append("Where convert(varchar(10), exam_start1, 120) between ? and ? and ");
		sql.append("      a.id_course = b.id_course and b.id_exam = c.id_exam and b.id_exam = d.id_exam and c.id_exam = d.id_exam ");
		sql.append("Order by b.exam_start1 ");
		*/

		sql.append("Select a.course, b.id_exam, b.title, to_char(b.exam_start1,'YYYY-MM-DD') exam_start, ");
        sql.append("	   to_char(b.exam_end1,'YYYY-MM-DD') exam_end, c.inwons, d.ans_inwons ");
		sql.append("From c_course a, exam_m b, "); 
		sql.append("	(Select a.id_exam, count(b.userid) inwons From exam_m a, exam_receipt b "); 
		sql.append("     Where to_char(exam_start1, 'YYYY-MM-DD') between ? and ? and a.id_exam = b.id_exam "); 
		sql.append("     Group by a.id_exam ) c, "); 
		sql.append("    (Select a.id_exam, count(b.userid) ans_inwons From exam_m a, exam_ans b "); 
		sql.append("     Where to_char(exam_start1, 'YYYY-MM-DD') between ? and ? and "); 
		sql.append("           a.id_exam = b.id_exam and b.userid <> 'tman@@2008' ");
		sql.append("     Group by a.id_exam ) d ");
		sql.append("Where to_char(exam_start1, 'YYYY-MM-DD') between ? and ? and ");
		sql.append("      a.id_course = b.id_course and b.id_exam = c.id_exam and b.id_exam = d.id_exam and c.id_exam = d.id_exam ");
		sql.append("Order by b.exam_start1 ");
		
		
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
            rst = stm.executeQuery();
            ExamScheduleBean bean = null;
            while (rst.next()) {
                bean = makeInwonRes(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamScheduleBean[]) beans.toArray(new ExamScheduleBean[0]);
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

	public static ExamScheduleBean[] getInwonResDown(String id_course, String start_date, String end_date) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		/*
		sql.append("Select a.course, b.id_exam, b.title, convert(varchar(10),b.exam_start1,120) exam_start, ");
        sql.append("	   convert(varchar(10),b.exam_end1,120) exam_end, c.inwons, d.ans_inwons ");
		sql.append("From c_course a, exam_m b, "); 
		sql.append("	(Select a.id_exam, count(b.userid) inwons From exam_m a, exam_receipt b "); 
		sql.append("     Where convert(varchar(10), exam_start1, 120) between ? and ? and a.id_course = ? and a.id_exam = b.id_exam "); 
		sql.append("     Group by a.id_exam ) c, "); 
		sql.append("    (Select a.id_exam, count(b.userid) ans_inwons From exam_m a, exam_ans b "); 
		sql.append("     Where convert(varchar(10), exam_start1, 120) between ? and ? and a.id_course = ? and "); 
		sql.append("           a.id_exam = b.id_exam and b.userid <> 'tman@@2008' ");
		sql.append("     Group by a.id_exam ) d ");
		sql.append("Where convert(varchar(10), exam_start1, 120) between ? and ? and a.id_course = ? and ");
		sql.append("      a.id_course = b.id_course and b.id_exam = c.id_exam and b.id_exam = d.id_exam and c.id_exam = d.id_exam ");
		sql.append("Order by b.exam_start1 ");
		*/

		
		sql.append("Select a.course, b.id_exam, b.title, to_char(b.exam_start1,'YYYY-MM-DD') exam_start, ");
        sql.append("	   to_char(b.exam_end1,'YYYY-MM-DD') exam_end, c.inwons, d.ans_inwons ");
		sql.append("From c_course a, exam_m b, "); 
		sql.append("	(Select a.id_exam, count(b.userid) inwons From exam_m a, exam_receipt b "); 
		sql.append("     Where to_char(exam_start1, 'YYYY-MM-DD') between ? and ? and a.id_course = ? and a.id_exam = b.id_exam "); 
		sql.append("     Group by a.id_exam ) c, "); 
		sql.append("    (Select a.id_exam, count(b.userid) ans_inwons From exam_m a, exam_ans b "); 
		sql.append("     Where to_char(exam_start1, 'YYYY-MM-DD') between ? and ? and a.id_course = ? and "); 
		sql.append("           a.id_exam = b.id_exam and b.userid <> 'tman@@2008' ");
		sql.append("     Group by a.id_exam ) d ");
		sql.append("Where to_char(exam_start1, 'YYYY-MM-DD') between ? and ? and a.id_course = ? and ");
		sql.append("      a.id_course = b.id_course and b.id_exam = c.id_exam and b.id_exam = d.id_exam and c.id_exam = d.id_exam ");
		sql.append("Order by b.exam_start1 ");
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, start_date);
			stm.setString(2, end_date);
			stm.setString(3, id_course);
			stm.setString(4, start_date);
			stm.setString(5, end_date);
			stm.setString(6, id_course);
			stm.setString(7, start_date);
			stm.setString(8, end_date);
			stm.setString(9, id_course);
            rst = stm.executeQuery();
            ExamScheduleBean bean = null;
            while (rst.next()) {
                bean = makeInwonRes(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamScheduleBean[]) beans.toArray(new ExamScheduleBean[0]);
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

	public static ExamScheduleBean[] getInwonRes2(String start_date, String end_date, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		/*
		sql.append("Select a.course, b.id_exam, b.title, convert(varchar(10),b.exam_start1,120) exam_start, ");
        sql.append("	   convert(varchar(10),b.exam_end1,120) exam_end, c.inwons, d.ans_inwons ");
		sql.append("From c_course a, exam_m b, "); 
		sql.append("	(Select a.id_exam, count(b.userid) inwons From exam_m a, exam_receipt b "); 
		sql.append("     Where convert(varchar(10), exam_start1, 120) between ? and ? and a.userid = ? and a.id_exam = b.id_exam "); 
		sql.append("     Group by a.id_exam ) c, "); 
		sql.append("    (Select a.id_exam, count(b.userid) ans_inwons From exam_m a, exam_ans b "); 
		sql.append("     Where convert(varchar(10), exam_start1, 120) between ? and ? and a.userid = ? and "); 
		sql.append("           a.id_exam = b.id_exam and b.userid <> 'tman@@2008' ");
		sql.append("     Group by a.id_exam ) d ");
		sql.append("Where convert(varchar(10), b.exam_start1, 120) between ? and ? and b.userid = ? and ");
		sql.append("      a.id_course = b.id_course and b.id_exam = c.id_exam and b.id_exam = d.id_exam and c.id_exam = d.id_exam ");
		sql.append("Order by b.exam_start1 ");
		*/
		
		
		sql.append("Select a.course, b.id_exam, b.title, to_char(b.exam_start1,'YYYY-MM-DD') exam_start, ");
        sql.append("	   to_char(b.exam_end1,'YYYY-MM-DD') exam_end, c.inwons, d.ans_inwons ");
		sql.append("From c_course a, exam_m b, "); 
		sql.append("	(Select a.id_exam, count(b.userid) inwons From exam_m a, exam_receipt b "); 
		sql.append("     Where to_char(exam_start1, 'YYYY-MM-DD') between ? and ? and a.userid = ? and a.id_exam = b.id_exam "); 
		sql.append("     Group by a.id_exam ) c, "); 
		sql.append("    (Select a.id_exam, count(b.userid) ans_inwons From exam_m a, exam_ans b "); 
		sql.append("     Where to_char(exam_start1, 'YYYY-MM-DD') between ? and ? and a.userid = ? and "); 
		sql.append("           a.id_exam = b.id_exam and b.userid <> 'tman@@2008' ");
		sql.append("     Group by a.id_exam ) d ");
		sql.append("Where to_char(b.exam_start1, 'YYYY-MM-DD') between ? and ? and b.userid = ? and ");
		sql.append("      a.id_course = b.id_course and b.id_exam = c.id_exam and b.id_exam = d.id_exam and c.id_exam = d.id_exam ");
		sql.append("Order by b.exam_start1 ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, start_date);
			stm.setString(2, end_date);
			stm.setString(3, userid);
			stm.setString(4, start_date);
			stm.setString(5, end_date);
			stm.setString(6, userid);
			stm.setString(7, start_date);
			stm.setString(8, end_date);
			stm.setString(9, userid);
            rst = stm.executeQuery();
            ExamScheduleBean bean = null;
            while (rst.next()) {
                bean = makeInwonRes(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamScheduleBean[]) beans.toArray(new ExamScheduleBean[0]);
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

	public static ExamScheduleBean[] getInwonResDown2(String id_course, String userid, String start_date, String end_date) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		/*
		sql.append("Select a.course, b.id_exam, b.title, convert(varchar(10),b.exam_start1,120) exam_start, ");
        sql.append("	   convert(varchar(10),b.exam_end1,120) exam_end, c.inwons, d.ans_inwons ");
		sql.append("From c_course a, exam_m b, "); 
		sql.append("	(Select a.id_exam, count(b.userid) inwons From exam_m a, exam_receipt b "); 
		sql.append("     Where convert(varchar(10), exam_start1, 120) between ? and ? and a.id_course = ? and a.userid = ? and a.id_exam = b.id_exam "); 
		sql.append("     Group by a.id_exam ) c, "); 
		sql.append("    (Select a.id_exam, count(b.userid) ans_inwons From exam_m a, exam_ans b "); 
		sql.append("     Where convert(varchar(10), exam_start1, 120) between ? and ? and a.id_course = ? and a.userid = ? and "); 
		sql.append("           a.id_exam = b.id_exam and b.userid <> 'tman@@2008' ");
		sql.append("     Group by a.id_exam ) d ");
		sql.append("Where convert(varchar(10), exam_start1, 120) between ? and ? and a.id_course = ? and a.userid = ? and ");
		sql.append("      a.id_course = b.id_course and b.id_exam = c.id_exam and b.id_exam = d.id_exam and c.id_exam = d.id_exam ");
		sql.append("Order by b.exam_start1 ");
		*/
		
		
		sql.append("Select a.course, b.id_exam, b.title, to_char(b.exam_start1,'YYYY-MM-DD') exam_start, ");
        sql.append("	   to_char(b.exam_end1,'YYYY-MM-DD') exam_end, c.inwons, d.ans_inwons ");
		sql.append("From c_course a, exam_m b, "); 
		sql.append("	(Select a.id_exam, count(b.userid) inwons From exam_m a, exam_receipt b "); 
		sql.append("     Where to_char(exam_start1, 'YYYY-MM-DD') between ? and ? and a.id_course = ? and a.userid = ? and a.id_exam = b.id_exam "); 
		sql.append("     Group by a.id_exam ) c, "); 
		sql.append("    (Select a.id_exam, count(b.userid) ans_inwons From exam_m a, exam_ans b "); 
		sql.append("     Where to_char(exam_start1, 'YYYY-MM-DD') between ? and ? and a.id_course = ? and a.userid = ? and "); 
		sql.append("           a.id_exam = b.id_exam and b.userid <> 'tman@@2008' ");
		sql.append("     Group by a.id_exam ) d ");
		sql.append("Where to_char(exam_start1, 'YYYY-MM-DD') between ? and ? and a.id_course = ? and a.userid = ? and ");
		sql.append("      a.id_course = b.id_course and b.id_exam = c.id_exam and b.id_exam = d.id_exam and c.id_exam = d.id_exam ");
		sql.append("Order by b.exam_start1 ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, start_date);
			stm.setString(2, end_date);
			stm.setString(3, id_course);
			stm.setString(4, userid);
			stm.setString(5, start_date);
			stm.setString(6, end_date);
			stm.setString(7, id_course);
			stm.setString(8, userid);
			stm.setString(9, start_date);
			stm.setString(10, end_date);
			stm.setString(11, id_course);
			stm.setString(12, userid);
            rst = stm.executeQuery();
            ExamScheduleBean bean = null;
            while (rst.next()) {
                bean = makeInwonRes(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamScheduleBean[]) beans.toArray(new ExamScheduleBean[0]);
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

	private static ExamScheduleBean makeInwonRes(ResultSet rst) throws QmTmException
    {
		try {
			ExamScheduleBean bean = new ExamScheduleBean();
            bean.setCourse(rst.getString(1));
			bean.setId_exam(rst.getString(2));
			bean.setTitle(rst.getString(3));
			bean.setExam_start(rst.getString(4));
			bean.setExam_end(rst.getString(5));
			bean.setTot_inwon(rst.getInt(6));
			bean.setAns_inwon(rst.getInt(7));			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("2.검색일자 내 시험정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }
}