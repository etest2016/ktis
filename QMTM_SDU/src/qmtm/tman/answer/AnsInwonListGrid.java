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

public class AnsInwonListGrid
{
    public AnsInwonListGrid() {
    }
	
	public static int getCnt(String id_exam, String bigos) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(a.userid) as cnt ");
		sql.append("From exam_ans a, qt_userid b, exam_m c  ");
		sql.append("Where a.id_exam = ? and a.yn_end = ? and a.userid = b.userid and a.id_exam = c.id_exam ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, bigos);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 인원 정보를 읽어오는 중 오류가 발생되었습니다.[AnsInwonListGrid.getCnt] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
	public static AnsInwonListGridBean[] getBeans(String id_exam, String bigos, int posStart, int count) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select RowNum, userid, name, nr_set, convert(varchar(16),start_time,120) start_time, ");
		sql.append("       convert(varchar(16),end_time,120) end_time, score, score_bak, score_log, user_ip, ");
		sql.append("	   success_score, yn_success_score ");
		sql.append("From ( ");
		sql.append("	   Select a.userid, b.name, a.nr_set, convert(varchar(16),a.start_time,120) start_time, ");
		sql.append("              convert(varchar(16),a.end_time,120) end_time, a.score, a.score_bak, a.score_log, a.user_ip, ");
		sql.append("	          c.success_score, c.yn_success_score, ROW_NUMBER() OVER (ORDER BY a.userid) AS RowNum ");
		sql.append("From exam_ans a inner join qt_userid b on a.userid = b.userid ");
		sql.append("     inner join exam_m c on a.id_exam = c.id_exam ");
		sql.append("Where a.id_exam = ? and a.yn_end = ? ");
		sql.append("      ) as MyDerivedTable ");
		sql.append("WHERE MyDerivedTable.RowNum BETWEEN ? AND (? + ?) ");
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, bigos);
			stm.setInt(3, posStart);
			stm.setInt(4, posStart);
			stm.setInt(5, count);
            rst = stm.executeQuery();
            AnsInwonListGridBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListGridBean[]) beans.toArray(new AnsInwonListGridBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonListGrid.getBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
    private static AnsInwonListGridBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListGridBean bean = new AnsInwonListGridBean();            
            bean.setRownum(rst.getString(1));
            bean.setUserid(rst.getString(2));
            bean.setName(rst.getString(3));
            bean.setNr_set(rst.getInt(4));
			bean.setStart_time(rst.getString(5));
			bean.setEnd_time(rst.getString(6));
			bean.setScore(rst.getDouble(7));
			bean.setScore_bak(rst.getDouble(8));
			bean.setScore_log(rst.getString(9));
			bean.setUser_ip(rst.getString(10));
			bean.setSuccess_score(rst.getDouble(11));
			bean.setYn_success_score(rst.getString(12));			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonListGrid.makeBeans] " + ex.getMessage());
        }
    }

	public static int getCnt2(String id_exam) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select COUNT(*) as cnts From ( ");		
		sql.append("Select a.userid, a.name ");
		sql.append("From qt_userid a, exam_receipt b, exam_m c ");
		sql.append("Where c.id_exam = ? and c.id_auth_type = '2' and a.userid = b.userid and b.id_exam = c.id_exam ");
		sql.append("      and b.userid not in (select userid from exam_ans where id_exam = ?) ");
		sql.append("Union All ");		
		sql.append("Select a.userid, a.name ");
		sql.append("From qt_userid a, qt_course_user b, exam_m c ");
		sql.append("Where c.id_exam = ? and c.id_auth_type = '1' and a.userid = b.userid and b.id_course = c.id_course ");
		sql.append("      and b.id_subject = c.id_subject and b.course_year = c.course_year and b.course_no = c.course_no ");
		sql.append("      and b.userid not in (select userid from exam_ans where id_exam = ?) ");
		sql.append(") as cnts ");
		
		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, id_exam);
			stm.setString(3, id_exam);
			stm.setString(4, id_exam);
			
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnts"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 인원 정보를 읽어오는 중 오류가 발생되었습니다.[AnsInwonListGrid.getCnt2] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
	public static AnsInwonListGridBean[] getBeans2(String id_exam, int posStart, int count) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select RowNum, userid, name ");
		sql.append("From ( ");
		sql.append("	  Select a.userid, a.name, ROW_NUMBER() OVER (ORDER BY a.userid) AS RowNum ");
		sql.append("      From qt_userid a inner JOIN  exam_receipt b ON a.userid = b.userid AND ");
		sql.append("           b.userid not in (select userid from exam_ans where id_exam = ?) ");     
		sql.append("           inner JOIN exam_m c ON b.id_exam = c.id_exam ");
		sql.append("      Where c.id_exam = ? and c.id_auth_type = '2' ");
		sql.append("      ) as MyDerivedTable ");
		sql.append("WHERE MyDerivedTable.RowNum BETWEEN ? AND (? + ?) ");				
		sql.append("Union All ");
		sql.append("Select RowNum, userid, name ");
		sql.append("From ( ");
		sql.append("	  Select a.userid, a.name, ROW_NUMBER() OVER (ORDER BY a.userid) AS RowNum ");
		sql.append("      From qt_userid a inner JOIN qt_course_user b ON a.userid = b.userid AND ");
		sql.append("           b.userid not in (select userid from exam_ans where id_exam = ?) ");     
		sql.append("           inner JOIN exam_m c ON b.id_course = c.id_course and b.id_subject = c.id_subject and b.course_year = c.course_year and b.course_no = c.course_no ");
		sql.append("      Where c.id_exam = ? and c.id_auth_type = '1' ");
		sql.append("      ) as MyDerivedTable ");
		sql.append("WHERE MyDerivedTable.RowNum BETWEEN ? AND (? + ?) ");
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, id_exam);
			stm.setInt(3, posStart);
			stm.setInt(4, posStart);
			stm.setInt(5, count);
			stm.setString(6, id_exam);
			stm.setString(7, id_exam);
			stm.setInt(8, posStart);
			stm.setInt(9, posStart);
			stm.setInt(10, count);
		    rst = stm.executeQuery();

            AnsInwonListGridBean bean = null;
            while (rst.next()) {
                bean = makeBeans2(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListGridBean[]) beans.toArray(new AnsInwonListGridBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonListGrid.getBeans2] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static AnsInwonListGridBean makeBeans2 (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListGridBean bean = new AnsInwonListGridBean();            
            bean.setRownum(rst.getString(1));
            bean.setUserid(rst.getString(2));
            bean.setName(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonListGrid.makeBeans2] " + ex.getMessage());
        }
    }

	public static int getCnt3(String id_exam) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(*) as cnt ");
		sql.append("From bak_exam_ans a, qt_userid b, exam_m c ");
		sql.append("Where a.id_exam = ? and a.userid = b.userid and a.id_exam = c.id_exam ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 인원 정보를 읽어오는 중 오류가 발생되었습니다.[AnsInwonListGrid.getCnt3] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
	public static AnsInwonListGridBean[] getBeans3(String id_exam, int posStart, int count) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select RowNum, userid, name, nr_set, convert(varchar(16),start_time,120) start_time, ");
		sql.append("       convert(varchar(16),end_time,120) end_time, score, score_bak, score_log, user_ip, ");
		sql.append("	   success_score, yn_success_score ");
		sql.append("From ( ");
		sql.append("	   Select a.userid, b.name, a.nr_set, convert(varchar(16),a.start_time,120) start_time, ");
		sql.append("              convert(varchar(16),a.end_time,120) end_time, a.score, a.score_bak, a.score_log, a.user_ip, ");
		sql.append("	          c.success_score, c.yn_success_score, ROW_NUMBER() OVER (ORDER BY a.userid) AS RowNum ");
		sql.append("	   From bak_exam_ans a inner join qt_userid b on a.userid = b.userid ");
		sql.append("            inner join exam_m c on a.id_exam = c.id_exam ");
		sql.append("       Where a.id_exam = ? ");
		sql.append("      ) as MyDerivedTable ");
		sql.append("WHERE MyDerivedTable.RowNum BETWEEN ? AND (? + ?) ");
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setInt(2, posStart);
			stm.setInt(3, posStart);
			stm.setInt(4, count);
            rst = stm.executeQuery();
            AnsInwonListGridBean bean = null;
            while (rst.next()) {
                bean = makeBeans3(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListGridBean[]) beans.toArray(new AnsInwonListGridBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonListGrid.getBeans3] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
    private static AnsInwonListGridBean makeBeans3 (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListGridBean bean = new AnsInwonListGridBean();            
            bean.setRownum(rst.getString(1));
            bean.setUserid(rst.getString(2));
            bean.setName(rst.getString(3));
            bean.setNr_set(rst.getInt(4));
			bean.setStart_time(rst.getString(5));
			bean.setEnd_time(rst.getString(6));
			bean.setScore(rst.getDouble(7));
			bean.setScore_bak(rst.getDouble(8));
			bean.setScore_log(rst.getString(9));
			bean.setUser_ip(rst.getString(10));
			bean.setSuccess_score(rst.getDouble(11));
			bean.setYn_success_score(rst.getString(12));			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonListGrid.makeBeans3] " + ex.getMessage());
        }
    }

	public static int getSearchCnt(String id_exam, String yn_end, String userid, String name) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(a.userid) as cnt ");
		sql.append("From exam_ans a, qt_userid b, exam_m c ");
		sql.append("Where a.id_exam = ? and a.yn_end = ? and a.userid = b.userid and a.id_exam = c.id_exam ");
		
		if(userid.equals("")) {
			sql.append(" and b.name like '%" + name + "%' ");
		} else if(name.equals("")) {
			sql.append(" and b.userid like '%" + userid + "%' ");
		} else {
			sql.append(" and b.userid like '%" + userid + "%' and b.name like '%" + name + "%' ");
		}

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
             stm.setString(1, id_exam);
            stm.setString(2, yn_end);
			
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 인원 정보를 읽어오는 중 오류가 발생되었습니다.[AnsInwonListGrid.getSearchCnt] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
	public static AnsInwonListGridBean[] getSearchBeans(String id_exam, String yn_end, String userid, String name, int posStart, int count) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select RowNum, userid, name, nr_set, convert(varchar(16),start_time,120) start_time, ");
		sql.append("       convert(varchar(16),end_time,120) end_time, score, score_bak, score_log, user_ip, ");
		sql.append("	   success_score, yn_success_score ");
		sql.append("From ( ");
		sql.append("	   Select a.userid, b.name, a.nr_set, convert(varchar(16),a.start_time,120) start_time, ");
		sql.append("              convert(varchar(16),a.end_time,120) end_time, a.score, a.score_bak, a.score_log, a.user_ip, ");
		sql.append("	          c.success_score, c.yn_success_score, ROW_NUMBER() OVER (ORDER BY a.userid) AS RowNum ");
		sql.append("       From exam_ans a inner join qt_userid b on a.userid = b.userid ");
		sql.append("            inner join exam_m c on a.id_exam = c.id_exam ");
		sql.append("       Where a.id_exam = ? and a.yn_end = ? ");
		
		if(userid.equals("")) {
			sql.append("        and b.name like '%" + name + "%' ");
		} else if(name.equals("")) {
			sql.append("        and b.userid like '%" + userid + "%' ");
		} else {
			sql.append("        and b.userid like '%" + userid + "%' and b.name like '%" + name + "%' ");
		}
		
		sql.append("      ) as MyDerivedTable ");
		sql.append("WHERE MyDerivedTable.RowNum BETWEEN ? AND (? + ?) ");
				
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setString(2, yn_end);
            stm.setInt(3, posStart);
			stm.setInt(4, posStart);
			stm.setInt(5, count);
						
			rst = stm.executeQuery();

            AnsInwonListGridBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListGridBean[]) beans.toArray(new AnsInwonListGridBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonListGrid.getSearchBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static AnsInwonListGridBean makeSearchBeans (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListGridBean bean = new AnsInwonListGridBean();            
            bean.setRownum(rst.getString(1));
            bean.setUserid(rst.getString(2));
            bean.setName(rst.getString(3));
            bean.setNr_set(rst.getInt(4));
			bean.setStart_time(rst.getString(5));
			bean.setEnd_time(rst.getString(6));
			bean.setScore(rst.getDouble(7));
			bean.setScore_bak(rst.getDouble(8));
			bean.setScore_log(rst.getString(9));
			bean.setUser_ip(rst.getString(10));
			bean.setSuccess_score(rst.getDouble(11));
			bean.setYn_success_score(rst.getString(12));			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonListGrid.makeSearchBeans] " + ex.getMessage());
        }
    }

	public static int getSearchCnt2(String id_exam, String userid, String name) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select COUNT(*) From ( ");
		sql.append("Select a.userid, a.name ");
		sql.append("From qt_userid a, exam_receipt b, exam_m c ");
		sql.append("Where c.id_exam = ? and c.id_auth_type = '2' and a.userid = b.userid and b.id_exam = c.id_exam ");
		sql.append("      and b.userid not in (select userid from exam_ans where id_exam = ?) ");
		if(userid.equals("")) {
			sql.append("  and a.name like '%" + name + "%' ");
		} else if(name.equals("")) {
			sql.append("  and a.userid like '%" + userid + "%' ");
		} else {
			sql.append("  and a.userid like '%" + userid + "%' and a.name like '%" + name + "%' ");
		}		
		sql.append("Union All ");		
		sql.append("Select a.userid, a.name ");
		sql.append("From qt_userid a, qt_course_user b, exam_m c ");
		sql.append("Where c.id_exam = ? and c.id_auth_type = '1' and a.userid = b.userid and b.id_course = c.id_course ");
		sql.append("      and b.id_subject = c.id_subject and b.course_year = c.course_year and b.course_no = c.course_no ");
		sql.append("      and b.userid not in (select userid from exam_ans where id_exam = ?) ");
		if(userid.equals("")) {
			sql.append("  and a.name like '%" + name + "%' ");
		} else if(name.equals("")) {
			sql.append("  and a.userid like '%" + userid + "%' ");
		} else {
			sql.append("  and a.userid like '%" + userid + "%' and a.name like '%" + name + "%' ");
		}		
		sql.append(") as cnts ");
		
		
		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setString(2, id_exam);
            stm.setString(3, id_exam);
            stm.setString(4, id_exam);
						
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 인원 정보를 읽어오는 중 오류가 발생되었습니다.[AnsInwonListGrid.getSearchCnt2] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
	public static AnsInwonListGridBean[] getSearchBeans2(String id_exam, String userid, String name, int posStart, int count) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select RowNum, userid, name ");
		sql.append("From ( ");
		sql.append("	 Select a.userid, a.name, ROW_NUMBER() OVER (ORDER BY a.userid) AS RowNum ");
		sql.append("	 From qt_userid a inner JOIN  exam_receipt b ON a.userid = b.userid AND ");
		sql.append("          b.userid not in (select userid from exam_ans where id_exam = ?) ");     
		sql.append("          inner JOIN exam_m c ON b.id_exam = c.id_exam ");
		sql.append("     Where c.id_exam = ? and c.id_auth_type = '2' ");
		
		if(userid.equals("")) {
			sql.append("       and a.name like '%" + name + "%' ");
		} else if(name.equals("")) {
			sql.append("       and a.userid like '%" + userid + "%' ");
		} else {
			sql.append("       and a.userid like '%" + userid + "%' and a.name like '%" + name + "%' ");
		}
		
		sql.append("      ) as MyDerivedTable ");
		sql.append("WHERE MyDerivedTable.RowNum BETWEEN ? AND (? + ?) ");
					
		sql.append("Union All ");
		sql.append("Select RowNum, userid, name ");
		sql.append("From ( ");
		sql.append("	  Select a.userid, a.name, ROW_NUMBER() OVER (ORDER BY a.userid) AS RowNum ");
		sql.append("      From qt_userid a inner JOIN qt_course_user b ON a.userid = b.userid AND ");
		sql.append("           b.userid not in (select userid from exam_ans where id_exam = ?) ");     
		sql.append("           inner JOIN exam_m c ON b.id_course = c.id_course and b.id_subject = c.id_subject and b.course_year = c.course_year and b.course_no = c.course_no ");
		sql.append("      Where c.id_exam = ? and c.id_auth_type = '1' ");
		
		if(userid.equals("")) {
			sql.append("        and a.name like '%" + name + "%' ");
		} else if(name.equals("")) {
			sql.append("        and a.userid like '%" + userid + "%' ");
		} else {
			sql.append("        and a.userid like '%" + userid + "%' and a.name like '%" + name + "%' ");
		}
		
		sql.append("      ) as MyDerivedTable ");
		sql.append("WHERE MyDerivedTable.RowNum BETWEEN ? AND (? + ?) ");
				
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setString(2, id_exam);
            stm.setInt(3, posStart);
			stm.setInt(4, posStart);
			stm.setInt(5, count);
			stm.setString(6, id_exam);
            stm.setString(7, id_exam);
            stm.setInt(8, posStart);
			stm.setInt(9, posStart);
			stm.setInt(10, count);
		
	        rst = stm.executeQuery();

            AnsInwonListGridBean bean = null;
            while (rst.next()) {
                bean = makeSearchBeans2(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListGridBean[]) beans.toArray(new AnsInwonListGridBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonListGrid.getSearchBeans2] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static AnsInwonListGridBean makeSearchBeans2 (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListGridBean bean = new AnsInwonListGridBean();            
            bean.setRownum(rst.getString(1));
            bean.setUserid(rst.getString(2));
            bean.setName(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonListGrid.makeSearchBeans2] " + ex.getMessage());
        }
    }

	public static int getSearchCnt3(String id_exam, String userid, String name) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(a.userid) as cnt ");
		sql.append("From bak_exam_ans a, qt_userid b, exam_m c ");
		sql.append("Where a.id_exam = ? and a.userid = b.userid and a.id_exam = c.id_exam ");
		
		if(userid.equals("")) {
			sql.append(" and b.name like '%" + name + "%' ");
		} else if(name.equals("")) {
			sql.append(" and b.userid like '%" + userid + "%' ");
		} else {
			sql.append(" and b.userid like '%" + userid + "%' and b.name like '%" + name + "%' ");
		}

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 인원 정보를 읽어오는 중 오류가 발생되었습니다.[AnsInwonListGrid.getSearchCnt3] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
	public static AnsInwonListGridBean[] getSearchBeans3(String id_exam, String userid, String name, int posStart, int count) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select RowNum, userid, name, nr_set, convert(varchar(16),start_time,120) start_time, ");
		sql.append("       convert(varchar(16),end_time,120) end_time, score, score_bak, score_log, user_ip, ");
		sql.append("	   success_score, yn_success_score ");
		sql.append("From ( ");
		sql.append("	   Select a.userid, b.name, a.nr_set, convert(varchar(16),a.start_time,120) start_time, ");
		sql.append("              convert(varchar(16),a.end_time,120) end_time, a.score, a.score_bak, a.score_log, a.user_ip, ");
		sql.append("	          c.success_score, c.yn_success_score, ROW_NUMBER() OVER (ORDER BY a.userid) AS RowNum ");
		sql.append("       From bak_exam_ans a inner join qt_userid b on a.userid = b.userid ");
		sql.append("            inner join exam_m c on a.id_exam = c.id_exam ");
		sql.append("       Where a.id_exam = ? ");
		
		if(userid.equals("")) {
			sql.append("        and b.name like '%" + name + "%' ");
		} else if(name.equals("")) {
			sql.append("        and b.userid like '%" + userid + "%' ");
		} else {
			sql.append("        and b.userid like '%" + userid + "%' and b.name like '%" + name + "%' ");
		}
		
		sql.append("      ) as MyDerivedTable ");
		sql.append("WHERE MyDerivedTable.RowNum BETWEEN ? AND (? + ?) ");
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);	
            stm.setInt(2, posStart);
			stm.setInt(3, posStart);
			stm.setInt(4, count);
            rst = stm.executeQuery();

            AnsInwonListGridBean bean = null;
            while (rst.next()) {
                bean = makeSearchBeans3(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnsInwonListGridBean[]) beans.toArray(new AnsInwonListGridBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonListGrid.getSearchBeans3] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static AnsInwonListGridBean makeSearchBeans3 (ResultSet rst) throws QmTmException
    {
		try {
            AnsInwonListGridBean bean = new AnsInwonListGridBean();
            bean.setRownum(rst.getString(1));
			bean.setUserid(rst.getString(2));
            bean.setName(rst.getString(3)); 
            bean.setNr_set(rst.getInt(4));
			bean.setStart_time(rst.getString(5));
			bean.setEnd_time(rst.getString(6));
			bean.setScore(rst.getDouble(7));
			bean.setScore_bak(rst.getDouble(8));
			bean.setScore_log(rst.getString(9));
			bean.setUser_ip(rst.getString(10));
			bean.setSuccess_score(rst.getDouble(11));
			bean.setYn_success_score(rst.getString(12));			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 인원 리스트 정보 읽어오는 중 오류가 발생되었습니다. [AnsInwonListGrid.makeSearchBeans3] " + ex.getMessage());
        }
    }
	
}