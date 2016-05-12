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

public class ExamUtil
{
    public ExamUtil() {
    }
	
	public static String getId_midcategory(String id_exam) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.id_category ");
		sql.append("From c_course a, exam_m b ");
		sql.append("Where b.id_exam = ? and a.id_course = b.id_course ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getString("id_category"); }
            else { return null; }
        } catch (SQLException ex) {
            throw new QmTmException("분류 카테고리 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getId_midcategory] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
	public static String getId_category(String id_exam) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_course ");
		sql.append("From exam_m ");
		sql.append("Where id_exam = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getString("id_course"); }
            else { return null; }
        } catch (SQLException ex) {
            throw new QmTmException("분류 카테고리 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getId_category] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
	public static void insert(ExamCreateBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO exam_m (id_exam, id_course, id_subject, course_year, course_no, title, guide, id_exam_kind, yn_enable, exam_start1, exam_end1, ");
		sql.append("                    login_start, login_end, id_exam_type, id_auth_type, yn_stat, stat_start, stat_end, yn_open_qa, u_avg_basis, yn_open_score_direct, ");
		sql.append("                    log_option, web_window_mode, yn_sametime, limittime, qcount, allotting, id_randomtype, id_ltimetype, id_movepage, yn_viewas, ");
		sql.append("                    qcntperpage, id_exlabel, fontname, fontsize, paper_type, userid) ");		
        sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ");
		sql.append("        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ");
		sql.append("        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ");
		sql.append("        ?, ?, ?, ?, ?, ?) ");
		
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());

            stm.setString(1, bean.getId_exam());
			stm.setString(2, bean.getId_course());
			stm.setString(3, bean.getId_subject());
			stm.setString(4, bean.getCourse_year());
			stm.setString(5, bean.getCourse_no());
			stm.setString(6, bean.getTitle());
			stm.setString(7, bean.getGuide());
			stm.setInt(8, bean.getId_exam_kind());
			stm.setString(9, bean.getYn_enable());
            stm.setTimestamp(10, bean.getExam_start1());
			stm.setTimestamp(11, bean.getExam_end1());

			stm.setTimestamp(12, bean.getLogin_start());
			stm.setTimestamp(13, bean.getLogin_end());
			stm.setInt(14, bean.getId_exam_type());
			stm.setInt(15, bean.getId_auth_type());
			stm.setString(16, bean.getYn_stat());
			stm.setTimestamp(17, bean.getStat_start());
			stm.setTimestamp(18, bean.getStat_end());
			stm.setString(19, bean.getYn_open_qa());

			stm.setInt(20, bean.getU_avg_basis());
			stm.setString(21, bean.getYn_open_score_direct());
			stm.setString(22, bean.getLog_option());
			stm.setInt(23, bean.getWeb_window_mode());
			stm.setString(24, bean.getYn_sametime());
			stm.setLong(25, bean.getLimittime());
			stm.setInt(26, bean.getQcount());
			stm.setDouble(27, bean.getAllotting());			
			stm.setString(28, bean.getId_randomtype());

			stm.setString(29, bean.getId_ltimetype());
			stm.setString(30, bean.getId_movepage());
			stm.setString(31, bean.getYn_viewas());
			stm.setInt(32, bean.getQcntperpage());
			stm.setInt(33, bean.getId_exlabel());
			stm.setString(34, bean.getFontname());
			stm.setInt(35, bean.getFontsize());
			stm.setInt(36, bean.getPaper_type());
			stm.setString(37, bean.getUserid());
			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험 정보 등록하는 중 오류가 발생되었습니다. [ExamUtil.insert] " + ex.getMessage());	
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static ExamCreateBean getBean(String id_exam) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_course, id_subject, title, guide, id_exam_kind, yn_enable, exam_start1, exam_end1, login_start, login_end, ");
		sql.append("       id_exam_type, id_auth_type, yn_stat, stat_start, stat_end, yn_open_qa, u_avg_basis, yn_open_score_direct, ");
		sql.append("       log_option, web_window_mode, yn_sametime, limittime, qcount, allotting, id_randomtype, id_movepage, ");
		sql.append("       yn_viewas, qcntperpage, id_exlabel, fontname, fontsize, paper_type,  ");
		sql.append("       course_year, course_no ");
		sql.append("From exam_m ");
		sql.append("Where id_exam = ? ");
				
	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("시험 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getBean] " + ex.getMessage());		
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static ExamCreateBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamCreateBean bean = new ExamCreateBean();
            bean.setId_course(rst.getString(1));
			bean.setId_subject(rst.getString(2));
			bean.setTitle(rst.getString(3));
			bean.setGuide(rst.getString(4));
			bean.setId_exam_kind(rst.getInt(5));
			bean.setYn_enable(rst.getString(6));
			bean.setExam_start1(rst.getTimestamp(7));
			bean.setExam_end1(rst.getTimestamp(8));
			bean.setLogin_start(rst.getTimestamp(9));
			bean.setLogin_end(rst.getTimestamp(10));

			bean.setId_exam_type(rst.getInt(11));
			bean.setId_auth_type(rst.getInt(12));
			bean.setYn_stat(rst.getString(13));
			bean.setStat_start(rst.getTimestamp(14));
			bean.setStat_end(rst.getTimestamp(15));
			bean.setYn_open_qa(rst.getString(16));
			bean.setU_avg_basis(rst.getInt(17));
			bean.setYn_open_score_direct(rst.getString(18));

			bean.setLog_option(rst.getString(19));
			bean.setWeb_window_mode(rst.getInt(20));
			bean.setYn_sametime(rst.getString(21));
			bean.setLimittime(rst.getLong(22));
			bean.setQcount(rst.getInt(23));
			bean.setAllotting(rst.getDouble(24));
			bean.setId_randomtype(rst.getString(25));
			bean.setId_movepage(rst.getString(26));

			bean.setYn_viewas(rst.getString(27));
			bean.setQcntperpage(rst.getInt(28));
			bean.setId_exlabel(rst.getInt(29));
			bean.setFontname(rst.getString(30));
			bean.setFontsize(rst.getInt(31));
			bean.setPaper_type(rst.getInt(32));
			
			bean.setCourse_year(rst.getString(33));
			bean.setCourse_no(rst.getString(34));
						
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeBean] " + ex.getMessage());
        }
    }
	
	public static void update(ExamCreateBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE exam_m SET title = ?, guide = ?, id_exam_kind = ?, ");
		sql.append("                  yn_enable = ?, exam_start1 = ?, exam_end1 = ?, ");
		if(bean.getYn_sametime().equals("Y")) {
			sql.append("                  login_start = ?, login_end = ?, ");
		} else {
			sql.append("                  login_start = login_start, login_end = login_end, ");
		}
		sql.append("                  id_exam_type = ?, id_auth_type = ?, yn_stat = ?, ");
		sql.append("                  stat_start = ?, stat_end = ?, yn_open_qa = ?, yn_open_score_direct = ?, ");
		sql.append("                  log_option = ?, web_window_mode = ?, yn_sametime = ?, limittime = ?, ");
		sql.append("                  qcount = ?, allotting = ?, id_randomtype = ?, id_movepage = ?, yn_viewas = ?, ");
		sql.append("                  qcntperpage = ?, id_exlabel = ?, fontname = ?, fontsize = ?, paper_type = ?, ");
		sql.append("                  course_year = ?, course_no = ? ");
        sql.append("Where id_exam = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			
			stm.setString(1, bean.getTitle());
			stm.setString(2, bean.getGuide());
			stm.setInt(3, bean.getId_exam_kind());
			stm.setString(4, bean.getYn_enable());
            stm.setTimestamp(5, bean.getExam_start1());
			stm.setTimestamp(6, bean.getExam_end1());

			if(bean.getYn_sametime().equals("Y")) {
			stm.setTimestamp(7, bean.getLogin_start());
			stm.setTimestamp(8, bean.getLogin_end());

			stm.setInt(9, bean.getId_exam_type());
			stm.setInt(10, bean.getId_auth_type());
			stm.setString(11, bean.getYn_stat());
			stm.setTimestamp(12, bean.getStat_start());
			stm.setTimestamp(13, bean.getStat_end());
			stm.setString(14, bean.getYn_open_qa());
			stm.setString(15, bean.getYn_open_score_direct());

			stm.setString(16, bean.getLog_option());
			stm.setInt(17, bean.getWeb_window_mode());
			stm.setString(18, bean.getYn_sametime());
			stm.setLong(19, bean.getLimittime());
			stm.setInt(20, bean.getQcount());
			stm.setDouble(21, bean.getAllotting());
			stm.setString(22, bean.getId_randomtype());
			stm.setString(23, bean.getId_movepage());
			stm.setString(24, bean.getYn_viewas());

			stm.setInt(25, bean.getQcntperpage());
			stm.setInt(26, bean.getId_exlabel());
			stm.setString(27, bean.getFontname());
			stm.setInt(28, bean.getFontsize());
			stm.setInt(29, bean.getPaper_type());			
			stm.setString(30, bean.getCourse_year());
			stm.setString(31, bean.getCourse_no());
			stm.setString(32, bean.getId_exam());
			} else {
			stm.setInt(7, bean.getId_exam_type());
			stm.setInt(8, bean.getId_auth_type());
			stm.setString(9, bean.getYn_stat());
			stm.setTimestamp(10, bean.getStat_start());
			stm.setTimestamp(11, bean.getStat_end());
			stm.setString(12, bean.getYn_open_qa());
			stm.setString(13, bean.getYn_open_score_direct());

			stm.setString(14, bean.getLog_option());
			stm.setInt(15, bean.getWeb_window_mode());
			stm.setString(16, bean.getYn_sametime());
			stm.setLong(17, bean.getLimittime());
			stm.setInt(18, bean.getQcount());
			stm.setDouble(19, bean.getAllotting());
			stm.setString(20, bean.getId_randomtype());
			stm.setString(21, bean.getId_movepage());
			stm.setString(22, bean.getYn_viewas());

			stm.setInt(23, bean.getQcntperpage());
			stm.setInt(24, bean.getId_exlabel());
			stm.setString(25, bean.getFontname());
			stm.setInt(26, bean.getFontsize());
			stm.setInt(27, bean.getPaper_type());
			stm.setString(28, bean.getCourse_year());
			stm.setString(29, bean.getCourse_no());	
			stm.setString(30, bean.getId_exam());
			}

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험 정보 수정하는 중 오류가 발생되었습니다. [ExamUtil.update] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static void delete(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Delete From exam_m ");
		sql.append("Where id_exam = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험 정보 삭제하는 중 오류가 발생되었습니다. [ExamUtil.delete] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static double getAllottings(String id_exam) throws QmTmException 
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select allotting ");
		sql.append("From exam_m ");
		sql.append("Where id_exam = ? ");

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getDouble("allotting"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("배점 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getAllottings] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
	public static int getPaperCnt(String id_exam) throws QmTmException 
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(distinct nr_set) as cnts ");
		sql.append("From exam_paper2 ");
		sql.append("Where id_exam = ? ");

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnts"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("시험지 유형 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getPaperCnt] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static int getAnsCnt(String id_exam) throws QmTmException 
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(userid) as cnts ");
		sql.append("From exam_ans ");
		sql.append("Where id_exam = ? and userid <> 'tman@@2008' ");

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnts"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("시험 응시자 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getAnsCnt] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static String getCourse(String id_exam) throws QmTmException 
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_course ");
		sql.append("From exam_m ");
		sql.append("Where id_exam = ? ");

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getString("id_course"); }
            else { return null; }
        } catch (SQLException ex) {
            throw new QmTmException("과정정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getCourse] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static String getCourseName(String id_course) throws QmTmException 
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select course ");
		sql.append("From c_course ");
		sql.append("Where id_course = ? ");

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getString("course"); }
            else { return null; }
        } catch (SQLException ex) {
            throw new QmTmException("과정정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getCourseName] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static ExamUtilBean[] getQBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_q_subject, q_subject ");
		sql.append("From q_subject ");
		sql.append("Where yn_valid = 'Y' ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            rst = stm.executeQuery();
            ExamUtilBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamUtilBean[]) beans.toArray(new ExamUtilBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("과목정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getQBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamUtilBean[] getQBeans(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.id_q_subject, a.q_subject ");
		sql.append("From q_subject a, t_worker_subj b ");
		sql.append("Where a.yn_valid = 'Y' and b.userid = ? and a.id_course = b.id_course ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
            rst = stm.executeQuery();
            ExamUtilBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamUtilBean[]) beans.toArray(new ExamUtilBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("과목정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getQBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static ExamUtilBean[] getBeans(String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select b.id_q_subject, b.q_subject ");
		sql.append("From c_subject a, q_subject b ");
		sql.append("Where a.id_course = ? and a.q_subject <> '-1' ");
		sql.append("and a.q_subject = b.id_q_subject and b.yn_valid = 'Y' ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_course);
            rst = stm.executeQuery();
            ExamUtilBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamUtilBean[]) beans.toArray(new ExamUtilBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("과목정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamUtilBean[] getCourseStaticList(String years) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_course, a.course ");
		sql.append("From c_course a, exam_m b ");
		sql.append("Where a.yn_valid = 'Y' and b.course_year = ? and a.id_course = b.id_course ");
		sql.append("Group by a.id_course, a.course ");
		sql.append("Order by a.course ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, years);
            rst = stm.executeQuery();
            ExamUtilBean bean = null;
            while (rst.next()) {
                bean = makeCourseList(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamUtilBean[]) beans.toArray(new ExamUtilBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("과정정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getCourseStaticList] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamUtilBean[] getCourseList(String id_category) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_course, course ");
		sql.append("From c_course ");
		sql.append("Where yn_valid = 'Y' and id_category = ? ");
		sql.append("Order by course ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_category);
            rst = stm.executeQuery();
            ExamUtilBean bean = null;
            while (rst.next()) {
                bean = makeCourseList(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamUtilBean[]) beans.toArray(new ExamUtilBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("과정정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getCourseList] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamUtilBean[] getCourseList(String id_category, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select distinct a.id_course, a.course ");
		sql.append("From c_course a, t_worker_subj b ");
		sql.append("Where a.yn_valid = 'Y' and a.id_category = ? and b.userid = ? and a.id_course = b.id_course ");
		sql.append("Order by a.course ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_category);
			stm.setString(2, userid);
            rst = stm.executeQuery();
            ExamUtilBean bean = null;
            while (rst.next()) {
                bean = makeCourseList(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamUtilBean[]) beans.toArray(new ExamUtilBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("과정정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getCourseList] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	private static ExamUtilBean makeCourseList (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamUtilBean bean = new ExamUtilBean();
            bean.setId_course(rst.getString(1));
            bean.setCourse(rst.getString(2));    
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("과정정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeCourseList] " + ex.getMessage());
        }
    }

	public static ExamUtilBean[] getAllBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_q_subject, q_subject ");
		sql.append("From q_subject ");
		sql.append("Where yn_valid = 'Y' ");
		sql.append("Order by q_subject ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            rst = stm.executeQuery();
            ExamUtilBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamUtilBean[]) beans.toArray(new ExamUtilBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("과목정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getAllBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static ExamUtilBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamUtilBean bean = new ExamUtilBean();
            bean.setId_q_subject(rst.getString(1));
            bean.setQ_subject(rst.getString(2));    
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("과목정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeBeans] " + ex.getMessage());
        }
    }
	
	// 강의 정보 가지고오기
	public static ExamUtilBean[] getSubjBeans(String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_q_subject, q_subject ");
		sql.append("From q_subject ");
		sql.append("Where id_course = ? and yn_valid = 'Y' ");
		sql.append("Order by subject_order ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_course);
            rst = stm.executeQuery();
            ExamUtilBean bean = null;
            while (rst.next()) {
                bean = makeSubjBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamUtilBean[]) beans.toArray(new ExamUtilBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("과목정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getSubjBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	// 강좌 정보 가지고오기
	public static ExamUtilBean[] getLectureBeans(String id_course, String open_year) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_subject, subject, right(open_year,2) open_year, open_month ");
		sql.append("From c_subject ");
		sql.append("Where id_course = ? and open_year = ? and yn_valid = 'Y' ");
		sql.append("Order by open_year, open_month ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_course);
			stm.setString(2, open_year);
            rst = stm.executeQuery();
            ExamUtilBean bean = null;
            while (rst.next()) {
                bean = makeLectureBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamUtilBean[]) beans.toArray(new ExamUtilBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("과목정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getLectureBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static ExamUtilBean makeSubjBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamUtilBean bean = new ExamUtilBean();
            bean.setId_q_subject(rst.getString(1));
            bean.setQ_subject(rst.getString(2));    
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("과목정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeSubjBeans] " + ex.getMessage());
        }
    }

	private static ExamUtilBean makeLectureBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamUtilBean bean = new ExamUtilBean();
            bean.setId_q_subject(rst.getString(1));
            bean.setQ_subject(rst.getString(2));    
			bean.setOpen_year(rst.getString(3));
			bean.setOpen_month(rst.getString(4)); 
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("과목정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeLectureBeans] " + ex.getMessage());
        }
    }


	// 시험 정보 가지고오기
	public static ExamUtilBean[] getExamBeans(String id_lecture) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_exam, title ");
		sql.append("From exam_m ");
		sql.append("Where id_subject = ? ");
		sql.append("Order by title ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_lecture);
            rst = stm.executeQuery();
            ExamUtilBean bean = null;
            while (rst.next()) {
                bean = makeExamBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamUtilBean[]) beans.toArray(new ExamUtilBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getExamBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static ExamUtilBean makeExamBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamUtilBean bean = new ExamUtilBean();
            bean.setId_exam(rst.getString(1));
            bean.setTitle(rst.getString(2));    
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeExamBeans] " + ex.getMessage());
        }
    }

	// 단원 1 정보 가지고오기
	public static ExamUtilBean[] getCpt1Beans(String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_q_chapter, chapter ");
		sql.append("From q_chapter ");
		sql.append("Where id_q_subject = ? and yn_valid = 'Y' ");
		sql.append("Order by chapter_order ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_subject);
            rst = stm.executeQuery();
            ExamUtilBean bean = null;
            while (rst.next()) {
                bean = makeCpt1Beans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamUtilBean[]) beans.toArray(new ExamUtilBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("단원정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getCpt1Beans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static ExamUtilBean makeCpt1Beans (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamUtilBean bean = new ExamUtilBean();
            bean.setId_q_chapter(rst.getString(1));
            bean.setChapter(rst.getString(2));    
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("단원정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeCpt1Beans] " + ex.getMessage());
        }
    }
	
	private static ExamSearchResBean makeSearchBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamSearchResBean bean = new ExamSearchResBean();

            bean.setId_q(rst.getInt(1));
            bean.setId_subject(rst.getString(2));
			bean.setId_ref(rst.getString(3));
			bean.setId_qtype(rst.getInt(4));
			bean.setAllotting(rst.getDouble(5));
			bean.setId_difficulty1(rst.getInt(6));
			bean.setQ(rst.getString(7));
			bean.setMake_cnt(rst.getInt(8));			
            return bean;

        } catch (SQLException ex) {
            throw new QmTmException("문제검색 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeSearchBeans] " + ex.getMessage());
        }
    }

	public static ExamQsBean[] getQsBeans(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select id_subject, subject, id_qtype, ");
		sql.append("       case when id_qtype = 1 then 'OX형' when id_qtype = 2 then '선다형' ");
		sql.append("       when id_qtype = 3 then '복수 답안형' when id_qtype = 4 then '단답형' ");
		sql.append("       when id_qtype = 5 then '논술형' end id_qtypes, ");				
		sql.append("       count(id_q) as cnts ");
		sql.append("From q_paper ");
		sql.append("Where id_exam = ? and id_ref = '0' ");
		sql.append("Group by id_subject, subject, id_qtype ");
		sql.append("Order by id_subject, subject, id_qtype ");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeQsBeans(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
				return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);                
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getQsBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	private static ExamQsBean makeQsBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamQsBean bean = new ExamQsBean();
			bean.setId_subject(rst.getString(1));
			bean.setQ_subject(rst.getString(2));
			bean.setId_qtype(rst.getString(3));
			bean.setId_qtypes(rst.getString(4));
			bean.setCnts(rst.getInt(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeQsBeans] " + ex.getMessage());
        }
    }

	public static ExamQsBean[] getRefBeans(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		

		sql.append("Select id_subject, subject, id_chapter, chapter, ref_cnt, count(*) as ref_cnt2 ");
		sql.append("From vw_q_paper ");
		sql.append("Where id_exam = ? ");
		sql.append("Group by id_subject, subject, id_chapter, chapter, ref_cnt ");
		sql.append("Order by id_subject, subject, id_chapter ");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeRefBeans(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getRefBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	private static ExamQsBean makeRefBeans (ResultSet rst) throws QmTmException
    {
		try {
            ExamQsBean bean = new ExamQsBean();
			bean.setId_subject(rst.getString(1));
			bean.setQ_subject(rst.getString(2));
			bean.setId_chapter(rst.getString(3));
			bean.setChapter(rst.getString(4));
			bean.setRef_cnts(rst.getInt(5));
			bean.setRef_cnts2(rst.getInt(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeRefBeans] " + ex.getMessage());
        }
    }

	public static ExamQsBean[] getRefsBeans(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select id_subject, subject, id_qtype, ");
		sql.append("       case when id_qtype = 1 then 'OX형' when id_qtype = 2 then '선다형' ");
		sql.append("       when id_qtype = 3 then '복수 답안형' when id_qtype = 4 then '단답형' ");
		sql.append("       when id_qtype = 5 then '논술형' end id_qtypes, ");
		sql.append("       count(id_q) as cnts ");
		sql.append("From q_paper ");
		sql.append("Where id_exam = ? and id_ref <> '0' ");
		sql.append("Group by id_subject, subject, id_qtype ");
		sql.append("Order by id_subject, subject, id_qtype ");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeRefsBeans(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getRefsBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	private static ExamQsBean makeRefsBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamQsBean bean = new ExamQsBean();
			bean.setId_subject(rst.getString(1));
			bean.setQ_subject(rst.getString(2));
			bean.setId_qtype(rst.getString(3));
			bean.setId_qtypes(rst.getString(4));
			bean.setCnts2(rst.getInt(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeRefsBeans] " + ex.getMessage());
        }
    }

	public static ExamQsBean[] getQsBeans2(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select id_subject, subject, id_chapter, chapter, ");
		sql.append("       count(id_q) as cnts ");
		sql.append("From q_paper ");
		sql.append("Where id_exam = ? and id_ref = '0' ");
		sql.append("Group by id_subject, subject, id_chapter, chapter ");
		sql.append("Order by id_subject, subject, id_chapter, chapter ");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeQsBeans2(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getQsBeans2] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	private static ExamQsBean makeQsBeans2 (ResultSet rst) throws QmTmException
    {

		try {
            ExamQsBean bean = new ExamQsBean();
			bean.setId_subject(rst.getString(1));
			bean.setQ_subject(rst.getString(2));
			bean.setId_chapter(rst.getString(3));
			bean.setChapter(rst.getString(4));
			bean.setCnts(rst.getInt(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeQsBeans2] " + ex.getMessage());
        }
    }

	public static ExamQsBean[] getRefsBeans2(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select id_subject, subject, id_chapter, chapter, ");
		sql.append("       count(id_q) as cnts ");
		sql.append("From q_paper ");
		sql.append("Where id_exam = ? and id_ref <> '0' ");
		sql.append("Group by id_subject, subject, id_chapter, chapter ");
		sql.append("Order by id_subject, subject, id_chapter, chapter ");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeRefsBeans2(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getRefsBeans2] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	private static ExamQsBean makeRefsBeans2 (ResultSet rst) throws QmTmException
    {

		try {
            ExamQsBean bean = new ExamQsBean();
			bean.setId_subject(rst.getString(1));
			bean.setQ_subject(rst.getString(2));
			bean.setId_chapter(rst.getString(3));
			bean.setChapter(rst.getString(4));
			bean.setCnts2(rst.getInt(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeRefsBeans2] " + ex.getMessage());
        }
    }

	public static ExamQsBean[] getQsBeans3(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select id_subject, subject, id_chapter, chapter, id_qtype, ");
		sql.append("       case when id_qtype = 1 then 'OX형' when id_qtype = 2 then '선다형' ");
		sql.append("       when id_qtype = 3 then '복수 답안형' when id_qtype = 4 then '단답형' ");
		sql.append("       when id_qtype = 5 then '논술형' end id_qtypes, ");
		sql.append("       count(id_q) as cnts ");	
		sql.append("From q_paper ");
		sql.append("Where id_exam = ? and id_ref = '0' ");
		sql.append("Group by id_subject, subject, id_chapter, chapter, id_qtype ");
		sql.append("Order by id_subject, subject, id_chapter, chapter, id_qtype ");	

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeQsBeans3(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getQsBeans3] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	private static ExamQsBean makeQsBeans3 (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamQsBean bean = new ExamQsBean();
			bean.setId_subject(rst.getString(1));
			bean.setQ_subject(rst.getString(2));
			bean.setId_chapter(rst.getString(3));
			bean.setChapter(rst.getString(4));
			bean.setId_qtype(rst.getString(5));
			bean.setId_qtypes(rst.getString(6));
			bean.setCnts(rst.getInt(7));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeQsBeans3] " + ex.getMessage());
        }
    }

	public static ExamQsBean[] getRefsBeans3(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select id_subject, subject, id_chapter, chapter, id_qtype, ");
		sql.append("       case when id_qtype = 1 then 'OX형' when id_qtype = 2 then '선다형' ");
		sql.append("       when id_qtype = 3 then '복수 답안형' when id_qtype = 4 then '단답형' ");
		sql.append("       when id_qtype = 5 then '논술형' end id_qtypes, ");
		sql.append("       count(id_q) as cnts ");
		sql.append("From q_paper ");
		sql.append("Where id_exam = ? and id_ref <> '0' ");
		sql.append("Group by id_subject, subject, id_chapter, chapter, id_qtype ");
		sql.append("Order by id_subject, subject, id_chapter, chapter, id_qtype ");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeRefsBeans3(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getRefsBeans3] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	private static ExamQsBean makeRefsBeans3 (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamQsBean bean = new ExamQsBean();
			bean.setId_subject(rst.getString(1));
			bean.setQ_subject(rst.getString(2));
			bean.setId_chapter(rst.getString(3));
			bean.setChapter(rst.getString(4));
			bean.setId_qtype(rst.getString(5));
			bean.setId_qtypes(rst.getString(6));
			bean.setCnts2(rst.getInt(7));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeRefsBeans3] " + ex.getMessage());
        }
    }

	public static ExamQsBean[] getQsBeans4(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_difficulty, b.difficulty, ");
		sql.append("       count(a.id_q) as cnts ");
		sql.append("From q_paper a, r_difficulty b ");
		sql.append("Where a.id_exam = ? and id_ref = '0' and a.id_difficulty = b.id_difficulty ");
		sql.append("Group by a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_difficulty, b.difficulty ");
		sql.append("Order by a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_difficulty, b.difficulty ");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeQsBeans4(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getQsBeans4] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	private static ExamQsBean makeQsBeans4 (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamQsBean bean = new ExamQsBean();
			bean.setId_subject(rst.getString(1));
			bean.setQ_subject(rst.getString(2));
			bean.setId_chapter(rst.getString(3));
			bean.setChapter(rst.getString(4));
			bean.setId_difficulty(rst.getString(5));
			bean.setDifficulty(rst.getString(6));
			bean.setCnts(rst.getInt(7));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeQsBeans4] " + ex.getMessage());
        }
    }

	public static ExamQsBean[] getRefsBeans4(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_difficulty, b.difficulty, ");
		sql.append("       count(a.id_q) as cnts ");
		sql.append("From q_paper a, r_difficulty b ");
		sql.append("Where a.id_exam = ? and a.id_difficulty = b.id_difficulty and a.id_ref <> '0' ");
		sql.append("Group by a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_difficulty, b.difficulty ");
		sql.append("Order by a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_difficulty, b.difficulty ");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeRefsBeans4(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getRefsBeans4] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	private static ExamQsBean makeRefsBeans4 (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamQsBean bean = new ExamQsBean();
			bean.setId_subject(rst.getString(1));
			bean.setQ_subject(rst.getString(2));
			bean.setId_chapter(rst.getString(3));
			bean.setChapter(rst.getString(4));
			bean.setId_difficulty(rst.getString(5));
			bean.setDifficulty(rst.getString(6));
			bean.setCnts2(rst.getInt(7));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeRefsBeans4] " + ex.getMessage());
        }
    }

	public static ExamQsBean[] getQsBeans5(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_qtype, ");
		sql.append("       case when a.id_qtype = 1 then 'OX형' when a.id_qtype = 2 then '선다형' ");
		sql.append("       when a.id_qtype = 3 then '복수 답안형' when a.id_qtype = 4 then '단답형' ");
		sql.append("       when a.id_qtype = 5 then '논술형' end id_qtypes, ");
		sql.append("       a.id_difficulty, b.difficulty, count(a.id_q) as cnts ");
		sql.append("From q_paper a, r_difficulty b ");
		sql.append("Where a.id_exam = ? and id_ref = '0' and a.id_difficulty = b.id_difficulty ");
		sql.append("Group by a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_qtype, a.id_difficulty, b.difficulty ");
		sql.append("Order by a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_qtype, a.id_difficulty, b.difficulty");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeQsBeans5(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getQsBeans5] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	private static ExamQsBean makeQsBeans5 (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamQsBean bean = new ExamQsBean();
			bean.setId_subject(rst.getString(1));
			bean.setQ_subject(rst.getString(2));
			bean.setId_chapter(rst.getString(3));
			bean.setChapter(rst.getString(4));
			bean.setId_qtype(rst.getString(5));
			bean.setId_qtypes(rst.getString(6));
			bean.setId_difficulty(rst.getString(7));
			bean.setDifficulty(rst.getString(8));
			bean.setCnts(rst.getInt(9));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeQsBeans5] " + ex.getMessage());
        }
    }

	public static ExamQsBean[] getRefsBeans5(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_qtype, ");
		sql.append("       case when a.id_qtype = 1 then 'OX형' when a.id_qtype = 2 then '선다형' ");
		sql.append("       when a.id_qtype = 3 then '복수 답안형' when a.id_qtype = 4 then '단답형' ");
		sql.append("       when a.id_qtype = 5 then '논술형' end id_qtypes, ");
		sql.append("       a.id_difficulty, b.difficulty, count(a.id_q) as cnts ");
		sql.append("From q_paper a, r_difficulty b ");
		sql.append("Where a.id_exam = ? and a.id_difficulty = b.id_difficulty and a.id_ref <> '0' ");
		sql.append("Group by a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_qtype, a.id_difficulty, b.difficulty ");
		sql.append("Order by a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_qtype, a.id_difficulty, b.difficulty ");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeRefsBeans5(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getRefsBeans5] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	private static ExamQsBean makeRefsBeans5 (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamQsBean bean = new ExamQsBean();
			bean.setId_subject(rst.getString(1));
			bean.setQ_subject(rst.getString(2));
			bean.setId_chapter(rst.getString(3));
			bean.setChapter(rst.getString(4));
			bean.setId_qtype(rst.getString(5));
			bean.setId_qtypes(rst.getString(6));
			bean.setId_difficulty(rst.getString(7));
			bean.setDifficulty(rst.getString(8));
			bean.setCnts2(rst.getInt(9));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeRefsBeans5] " + ex.getMessage());
        }
    }

	public static ExamQsBean[] getQsBeans6(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select id_subject, subject, ");
		sql.append("       count(id_q) as cnts ");
		sql.append("From q_paper ");
		sql.append("Where id_exam = ? ");
		sql.append("Group by id_subject, subject ");
		sql.append("Order by id_subject, subject ");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeQsBeans6(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
				return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);                
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getQsBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static ExamQsBean[] getRQsBeans(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select id_subject, subject, id_qtype, ");
		sql.append("       case when id_qtype = 1 then 'OX형' when id_qtype = 2 then '선다형' ");
		sql.append("       when id_qtype = 3 then '복수 답안형' when id_qtype = 4 then '단답형' ");
		sql.append("       when id_qtype = 5 then '논술형' end id_qtypes, ");
		sql.append("       count(id_q) as cnts ");
		sql.append("From q_paper ");
		sql.append("Where id_exam = ? and id_ref = '0' ");
		sql.append("Group by id_subject, subject, id_qtype ");
		sql.append("Order by id_subject, subject, id_qtype ");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeQsBeans(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
				return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);                
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getRQsBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static ExamQsBean[] getRQsBeans2(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select id_subject, subject, id_chapter, chapter, ");
		sql.append("       count(id_q) as cnts ");
		sql.append("From q_paper ");
		sql.append("Where id_exam = ? and id_ref = '0' ");
		sql.append("Group by id_subject, subject, id_chapter, chapter ");
		sql.append("Order by id_subject, subject, id_chapter, chapter ");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeQsBeans2(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getRQsBeans2] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static ExamQsBean[] getRQsBeans3(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select id_subject, subject, id_chapter, chapter, id_qtype, ");
		sql.append("       case when id_qtype = 1 then 'OX형' when id_qtype = 2 then '선다형' ");
		sql.append("       when id_qtype = 3 then '복수 답안형' when id_qtype = 4 then '단답형' ");
		sql.append("       when id_qtype = 5 then '논술형' end id_qtypes, ");
		sql.append("       count(id_q) as cnts ");
		sql.append("From q_paper ");
		sql.append("Where id_exam = ? and id_ref = '0' ");
		sql.append("Group by id_subject, subject, id_chapter, chapter, id_qtype ");
		sql.append("Order by id_subject, subject, id_chapter, chapter, id_qtype ");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeQsBeans3(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getRQsBeans3] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
	public static ExamQsBean[] getRQsBeans4(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_difficulty, b.difficulty, ");
		sql.append("       count(a.id_q) as cnts ");
		sql.append("From q_paper a, r_difficulty b ");
		sql.append("Where a.id_exam = ? and id_ref = '0' and a.id_difficulty = b.id_difficulty ");
		sql.append("Group by a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_difficulty, b.difficulty ");
		sql.append("Order by a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_difficulty, b.difficulty ");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeQsBeans4(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getRQsBeans4] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
	public static ExamQsBean[] getRQsBeans5(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_qtype, ");
		sql.append("       case when a.id_qtype = 1 then 'OX형' when a.id_qtype = 2 then '선다형' ");
		sql.append("       when a.id_qtype = 3 then '복수 답안형' when a.id_qtype = 4 then '단답형' ");
		sql.append("       when a.id_qtype = 5 then '논술형' end id_qtypes, ");
		sql.append("       a.id_difficulty, b.difficulty, count(a.id_q) as cnts ");
		sql.append("From q_paper a, r_difficulty b ");
		sql.append("Where a.id_exam = ? and id_ref = '0' and a.id_difficulty = b.id_difficulty ");
		sql.append("Group by a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_qtype, a.id_difficulty, b.difficulty ");
		sql.append("Order by a.id_subject, a.subject, a.id_chapter, a.chapter, a.id_qtype, a.id_difficulty, b.difficulty");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeQsBeans5(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getRQsBeans5] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static ExamQsBean[] getRQsBeans6(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select id_subject, subject, ");
		sql.append("       count(id_q) as cnts ");
		sql.append("From q_paper ");
		sql.append("Where id_exam = ? and id_ref = '0' ");
		sql.append("Group by id_subject, subject ");
		sql.append("Order by id_subject, subject ");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeQsBeans6(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
				return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);                
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getRQsBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	private static ExamQsBean makeQsBeans6 (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamQsBean bean = new ExamQsBean();
			bean.setId_subject(rst.getString(1));
			bean.setQ_subject(rst.getString(2));
			bean.setCnts(rst.getInt(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeQsBeans] " + ex.getMessage());
        }
    }

	public static ExamQsBean[] getRefsBeans6(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select id_subject, subject, ");
		sql.append("       count(id_q) as cnts ");
		sql.append("From q_paper ");
		sql.append("Where id_exam = ? and id_ref <> '0' ");
		sql.append("Group by id_subject, subject ");
		sql.append("Order by id_subject, subject ");

		try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
		    stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamQsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeRefsBeans6(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (ExamQsBean[]) beans.toArray(new ExamQsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getRefsBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	private static ExamQsBean makeRefsBeans6 (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamQsBean bean = new ExamQsBean();
			bean.setId_subject(rst.getString(1));
			bean.setQ_subject(rst.getString(2));
			bean.setCnts2(rst.getInt(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeRefsBeans] " + ex.getMessage());
        }
    }

	// 문제 검색결과 가지고 오기
	public static ExamSearchResBean[] getSearchBeans(ExamSearchBean bean, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_q, a.id_subject, a.id_ref, a.id_qtype, a.allotting, a.id_difficulty1, a.q, c.make_cnt ");
		sql.append("From q a, q_subject b, make_q c ");
		sql.append("Where a.id_subject = ? and a.id_subject = b.id_q_subject and a.id_q = c.id_q and a.id_valid_type = 0 ");
		
		// chapter1 포함 검색
		if(bean.getChapter1() != null) {
			sql.append("and a.id_chapter = '"+ bean.getChapter1() +"' ");
        } 

		// 문제유형 포함 검색
		if(bean.getQtype() != null) {
			sql.append("and a.id_qtype = "+ bean.getQtype() +" ");
        }

		// 난이도 포함 검색
		if(bean.getDifficulty() != null) {
			sql.append("and a.id_difficulty1 = "+ bean.getDifficulty() +" ");
        }

		// 문제입력 시작일 포함 검색
		if(bean.getRegdate1() != null) {
			sql.append("and convert(varchar(10),a.regdate, 120) >= '"+ bean.getRegdate1() +"' ");
        }

		// 문제입력 종료일 포함 검색
		if(bean.getRegdate2() != null) {
			sql.append("and convert(varchar(10), a.regdate, 120) <= '"+ bean.getRegdate2() +"' ");
        }

		// 문제수정 시작일 포함 검색
		if(bean.getUpdates1() != null) {
			sql.append("and convert(varchar(10), a.up_date, 120) >= '"+ bean.getUpdates1() +"' ");
        }

		// 문제수정 종료일 포함 검색
		if(bean.getUpdates2() != null) {
			sql.append("and convert(varchar(10), a.up_date, 120) <= '"+ bean.getUpdates2() +"' ");
        }
		
		// 출제 시작횟수 포함 검색
		if(bean.getQ_cnt1() != null) {
			sql.append("and c.make_cnt >= '"+ bean.getQ_cnt1() +"' ");
        }

		// 출제 종료횟수 포함 검색
		if(bean.getQ_cnt2() != null) {
			sql.append("and c.make_cnt <= '"+ bean.getQ_cnt2() +"' ");
        }
		
		// 문제용도1 포함 검색
		if(bean.getQ_uses() != null) {
			sql.append("and a.id_q_use = '"+ bean.getQ_uses() +"' ");
        }

		// 해설 포함 검색
		if(bean.getExplain1() != null) {
			sql.append("and a.explain like '%"+bean.getExplain1()+"%' ");
        }

		// 검색키워드 포함 검색
		if(bean.getFind_kwd1() != null) {
			sql.append("and a.find_kwd like '%"+bean.getFind_kwd1()+"%' ");
        }

		sql.append("Order by a.id_qtype asc, a.id_difficulty1 desc ");

        try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_subject());
			
			
            rst = stm.executeQuery();

			ExamSearchResBean bean2 = null;
            while(rst.next()) {
				bean2 = makeSearchBeans(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (ExamSearchResBean[]) beans.toArray(new ExamSearchResBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제 정보 검색하는 중 오류가 발생되었습니다. [ExamUtil.getSearchBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamSearchResBean[] getPrepapers(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_q, a.id_subject, a.id_ref, a.id_qtype, b.allotting, a.id_difficulty1, a.q, c.make_cnt ");
		sql.append("From q a, q_paper b, make_q c ");
		sql.append("Where b.id_exam = ? and a.id_q = b.id_q and a.id_q = c.id_q and a.id_valid_type = 0 ");
		
        try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			rst = stm.executeQuery();
			
			ExamSearchResBean bean2 = null;
            while(rst.next()) {
				bean2 = makeSearchBeans(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (ExamSearchResBean[]) beans.toArray(new ExamSearchResBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getPrepapers] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamCreateBean getAllotBean(String id_exam) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select qcount, allotting, id_randomtype, qcntperpage ");
		sql.append("From exam_m ");
		sql.append("Where id_exam = ? ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeAllotBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("시험 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getAllotBean] " + ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static ExamCreateBean makeAllotBean (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamCreateBean bean = new ExamCreateBean();
			bean.setQcount(rst.getInt(1));
			bean.setAllotting(rst.getDouble(2));
			bean.setId_randomtype(rst.getString(3));
			bean.setQcntperpage(rst.getInt(4));

            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.makeAllotBean] " + ex.getMessage());
        }
    }

	public static int getOrderCnt(String id_course, String id_subject) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(id_exam) + 1 as order_cnt ");
		sql.append("From exam_m "); 
		sql.append("Where id_course = ? and id_subject = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);
			stm.setString(2, id_subject);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("order_cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("강좌 시험회차 정보 읽어오는 중 오류가 발생되었습니다. [ExamUtil.getOrderCnt] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
}