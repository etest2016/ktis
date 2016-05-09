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
	
	public static int getId_category(String id_exam) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_category ");
		sql.append("From exam_m ");
		sql.append("Where id_exam = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("id_category"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("분류 카테고리 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
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
		sql.append("                    login_start, login_end, id_exam_type, id_auth_type, yn_stat, stat_start, stat_end, yn_open_qa, ");
		sql.append("                    u_avg_basis, yn_open_score_direct, log_option, web_window_mode, yn_sametime, limittime, qcount, allotting, id_randomtype, ");
		sql.append("                    id_ltimetype, id_movepage, yn_viewas, qcntperpage, id_exlabel, fontname, fontsize, paper_type, userid, exam_pwd_yn, exam_pwd_str, id_category, yn_stat_r) ");
        sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ");
		sql.append("        ?, ?, ?, ?, ?, ?, ?, ?, ");
		sql.append("        ?, ?, ?, ?, ?, ?, ?, ?, ?, ");
		sql.append("        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

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
			stm.setString(38, bean.getExam_pwd_yn());
			stm.setString(39, bean.getExam_pwd_str());
			stm.setString(40, bean.getId_category());
			stm.setString(41, bean.getYn_stat_r());

			//System.out.println(stm.toString());
			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험 정보 등록하는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.insert]");			
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

		sql.append("Select id_course, title, guide, id_exam_kind, yn_enable, exam_start1, exam_end1, login_start, login_end, ");
		sql.append("       id_exam_type, id_auth_type, yn_stat, stat_start, stat_end, yn_open_qa, u_avg_basis, yn_open_score_direct, ");
		sql.append("       log_option, web_window_mode, yn_sametime, limittime, qcount, allotting, id_randomtype, id_movepage, ");
		sql.append("       yn_viewas, qcntperpage, id_exlabel, fontname, fontsize, paper_type, exam_pwd_yn, exam_pwd_str, yn_stat_r ");
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
			throw new QmTmException("시험 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getBean]");			
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
			bean.setTitle(rst.getString(2));
			bean.setGuide(rst.getString(3));
			bean.setId_exam_kind(rst.getInt(4));
			bean.setYn_enable(rst.getString(5));
			bean.setExam_start1(rst.getTimestamp(6));
			bean.setExam_end1(rst.getTimestamp(7));
			bean.setLogin_start(rst.getTimestamp(8));
			bean.setLogin_end(rst.getTimestamp(9));

			bean.setId_exam_type(rst.getInt(10));
			bean.setId_auth_type(rst.getInt(11));
			bean.setYn_stat(rst.getString(12));
			bean.setStat_start(rst.getTimestamp(13));
			bean.setStat_end(rst.getTimestamp(14));
			bean.setYn_open_qa(rst.getString(15));
			bean.setU_avg_basis(rst.getInt(16));
			bean.setYn_open_score_direct(rst.getString(17));

			bean.setLog_option(rst.getString(18));
			bean.setWeb_window_mode(rst.getInt(19));
			bean.setYn_sametime(rst.getString(20));
			bean.setLimittime(rst.getLong(21));
			bean.setQcount(rst.getInt(22));
			bean.setAllotting(rst.getDouble(23));
			bean.setId_randomtype(rst.getString(24));
			bean.setId_movepage(rst.getString(25));

			bean.setYn_viewas(rst.getString(26));
			bean.setQcntperpage(rst.getInt(27));
			bean.setId_exlabel(rst.getInt(28));
			bean.setFontname(rst.getString(29));
			bean.setFontsize(rst.getInt(30));
			bean.setPaper_type(rst.getInt(31));
			bean.setExam_pwd_yn(rst.getString(32));
			bean.setExam_pwd_str(rst.getString(33));
			bean.setYn_stat_r(rst.getString(34));
			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeBean]");
        }
    }

	public static ExamCreateBean getInfos(String id_exam) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select allotting, score100_yn, rate100_yn ");
		sql.append("From exam_m ");
		sql.append("Where id_exam = ? ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeInfos(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("시험 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getInfos]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}
	
	private static ExamCreateBean makeInfos (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamCreateBean bean = new ExamCreateBean();
            
			bean.setAllotting(rst.getDouble(1));			
			bean.setScore100_yn(rst.getString(2));
			bean.setRate100_yn(rst.getString(3));

            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeInfos]");
        }
    }
	
	public static void score100(String id_exam, double allott) throws QmTmException
    {
        Connection cnn = null; Statement stm = null;
		StringBuffer sql = new StringBuffer();

        sql.append("Update exam_ans set score = score + (100 - "+ allott +") ");
		sql.append("Where id_exam = '"+ id_exam +"' and yn_end = 'Y' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();        
	        stm.executeUpdate(sql.toString());

			score100_Y(id_exam);
        }
        catch (SQLException ex) {
            throw new QmTmException("100점 환산점수로 변환하는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.score100]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void score100_reset(String id_exam, double allott) throws QmTmException
    {
        Connection cnn = null; Statement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Update exam_ans set score = score - (100 - "+ allott +") ");
        sql.append("Where id_exam = '"+ id_exam +"' and yn_end = 'Y' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();        
	        stm.executeUpdate(sql.toString());

			score100_N(id_exam);
        }
        catch (SQLException ex) {
            throw new QmTmException("100점 환산점수로 변환하는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.score100_reset]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void score100_Y(String id_exam) throws QmTmException
    {
        Connection cnn = null; Statement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Update exam_m set score100_YN = 'Y' ");
        sql.append("Where id_exam = '"+ id_exam +"' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();        
	        stm.executeUpdate(sql.toString());
        }
        catch (SQLException ex) {
            throw new QmTmException("100점 환산점수로 변환하는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.score100_Y]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    } 

	public static void score100_N(String id_exam) throws QmTmException
    {
        Connection cnn = null; Statement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Update exam_m set score100_YN = 'N' ");
        sql.append("Where id_exam = '"+ id_exam +"' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();        
	        stm.executeUpdate(sql.toString());
        }
        catch (SQLException ex) {
            throw new QmTmException("100점 환산점수로 변환하는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.score100_N]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    } 

	public static void rate100(String id_exam, double allott) throws QmTmException
    {
        Connection cnn = null; Statement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Update exam_ans set score = (score / "+ allott +") * 100 ");
        sql.append("Where id_exam = '"+ id_exam +"' and yn_end = 'Y' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();        
	        stm.executeUpdate(sql.toString());

			rate100_Y(id_exam);
        }
        catch (SQLException ex) {
            throw new QmTmException("100점 환산점수로 변환하는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.rate100]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void rate100_reset(String id_exam, double allott) throws QmTmException
    {
        Connection cnn = null; Statement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Update exam_ans set score = (score / 100) * "+ allott +" ");
        sql.append("Where id_exam = '"+ id_exam +"' and yn_end = 'Y' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();        
	        stm.executeUpdate(sql.toString());

			rate100_N(id_exam);
        }
        catch (SQLException ex) {
            throw new QmTmException("100점 환산점수로 변환하는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.rate100_reset]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void rate100_Y(String id_exam) throws QmTmException
    {
        Connection cnn = null; Statement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Update exam_m set rate100_YN = 'Y' ");
        sql.append("Where id_exam = '"+ id_exam +"' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();        
	        stm.executeUpdate(sql.toString());
        }
        catch (SQLException ex) {
            throw new QmTmException("100점 환산점수로 변환하는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.rate100_Y]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    } 

	public static void rate100_N(String id_exam) throws QmTmException
    {
        Connection cnn = null; Statement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Update exam_m set rate100_YN = 'N' ");
        sql.append("Where id_exam = '"+ id_exam +"' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();        
	        stm.executeUpdate(sql.toString());
        }
        catch (SQLException ex) {
            throw new QmTmException("100점 환산점수로 변환하는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.rate100_N]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
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
		sql.append("                  exam_pwd_yn = ?, exam_pwd_str = ?, yn_stat_r = ? ");
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
			stm.setString(30, bean.getExam_pwd_yn());
			stm.setString(31, bean.getExam_pwd_str());
			stm.setString(32, bean.getYn_stat_r());
			stm.setString(33, bean.getId_exam());
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
			stm.setString(28, bean.getExam_pwd_yn());
			stm.setString(29, bean.getExam_pwd_str());
			stm.setString(30, bean.getYn_stat_r());
			stm.setString(31, bean.getId_exam());			
			}

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험 정보 수정하는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.update]");
			//throw new QmTmException(ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void group_update(ExamCreateBean bean, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE exam_m SET guide = ?, id_exam_kind = ?, ");
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
		sql.append("                  exam_pwd_yn = ?, exam_pwd_str = ?, yn_stat_r = ? ");
        sql.append("Where id_exam = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			
			stm.setString(1, bean.getGuide());
			stm.setInt(2, bean.getId_exam_kind());
			stm.setString(3, bean.getYn_enable());
            stm.setTimestamp(4, bean.getExam_start1());
			stm.setTimestamp(5, bean.getExam_end1());

			if(bean.getYn_sametime().equals("Y")) {
			stm.setTimestamp(6, bean.getLogin_start());
			stm.setTimestamp(7, bean.getLogin_end());

			stm.setInt(8, bean.getId_exam_type());
			stm.setInt(9, bean.getId_auth_type());
			stm.setString(10, bean.getYn_stat());
			stm.setTimestamp(11, bean.getStat_start());
			stm.setTimestamp(12, bean.getStat_end());
			stm.setString(13, bean.getYn_open_qa());
			stm.setString(14, bean.getYn_open_score_direct());

			stm.setString(15, bean.getLog_option());
			stm.setInt(16, bean.getWeb_window_mode());
			stm.setString(17, bean.getYn_sametime());
			stm.setLong(18, bean.getLimittime());
			stm.setInt(19, bean.getQcount());
			stm.setDouble(20, bean.getAllotting());
			stm.setString(21, bean.getId_randomtype());
			stm.setString(22, bean.getId_movepage());
			stm.setString(23, bean.getYn_viewas());

			stm.setInt(24, bean.getQcntperpage());
			stm.setInt(25, bean.getId_exlabel());
			stm.setString(26, bean.getFontname());
			stm.setInt(27, bean.getFontsize());
			stm.setInt(28, bean.getPaper_type());			
			stm.setString(29, bean.getExam_pwd_yn());
			stm.setString(30, bean.getExam_pwd_str());
			stm.setString(31, bean.getYn_stat_r());
			stm.setString(32, id_exam);
			} else {
			stm.setInt(6, bean.getId_exam_type());
			stm.setInt(7, bean.getId_auth_type());
			stm.setString(8, bean.getYn_stat());
			stm.setTimestamp(9, bean.getStat_start());
			stm.setTimestamp(10, bean.getStat_end());
			stm.setString(11, bean.getYn_open_qa());
			stm.setString(12, bean.getYn_open_score_direct());

			stm.setString(13, bean.getLog_option());
			stm.setInt(14, bean.getWeb_window_mode());
			stm.setString(15, bean.getYn_sametime());
			stm.setLong(16, bean.getLimittime());
			stm.setInt(17, bean.getQcount());
			stm.setDouble(18, bean.getAllotting());
			stm.setString(19, bean.getId_randomtype());
			stm.setString(20, bean.getId_movepage());
			stm.setString(21, bean.getYn_viewas());

			stm.setInt(22, bean.getQcntperpage());
			stm.setInt(23, bean.getId_exlabel());
			stm.setString(24, bean.getFontname());
			stm.setInt(25, bean.getFontsize());
			stm.setInt(26, bean.getPaper_type());
			stm.setString(27, bean.getExam_pwd_yn());
			stm.setString(28, bean.getExam_pwd_str());
			stm.setString(29, bean.getYn_stat_r());
			stm.setString(30, id_exam);			
			}

			stm.execute();
        }
        catch (SQLException ex) {
            //throw new QmTmException("시험 정보 수정하는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.group_update]");
			throw new QmTmException(ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM exam_m Where id_exam = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_exam);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험 정보 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.delete]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static double getAllottings(String id_exam) throws QmTmException 
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select allotting From exam_m Where id_exam = ? ";

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getDouble("allotting"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("배점 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getAllottings]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
	public static int getPaperCnt(String id_exam) throws QmTmException 
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select count(distinct nr_set) as cnts From exam_paper2 Where id_exam = ? ";

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnts"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("시험지 유형 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getPaperCnt]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static int getAnsCnt(String id_exam) throws QmTmException 
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select count(userid) as cnts From exam_ans Where id_exam = ? and userid <> 'tman@@2008' ";

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnts"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("시험 응시자 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getAnsCnt]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static String getCourse(String id_exam) throws QmTmException 
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select id_course From exam_m Where id_exam = ? ";

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getString("id_course"); }
            else { return null; }
        } catch (SQLException ex) {
            throw new QmTmException("과정정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getCourse]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static String getCourseName(String id_course) throws QmTmException 
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select course From c_course Where id_course = ? ";

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_course);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getString("course"); }
            else { return null; }
        } catch (SQLException ex) {
            throw new QmTmException("과정정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getCourseName]");
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
            throw new QmTmException("과목정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getQBeans]");
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
		sql.append("From q_subject a, q_worker_subj b ");
		sql.append("Where a.yn_valid = 'Y' and b.userid = ? and a.id_q_subject = b.id_subject ");

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
            throw new QmTmException("과목정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getQBeans]");
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
            throw new QmTmException("과목정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamUtilBean[] getAllBeans2(int id_category) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_q_subject, q_subject ");
		sql.append("From q_subject ");
		sql.append("Where yn_valid = 'Y' and id_category = ? ");
		sql.append("Order by q_subject ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, Integer.toString(id_category));
			//stm.setInt(1, id_category);
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
            throw new QmTmException("과목정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getAllBeans2]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamUtilBean[] getAllBeans3(int id_category, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_q_subject, q_subject ");
		sql.append("From q_subject a, q_worker_subj b ");
		sql.append("Where a.yn_valid = 'Y' and a.id_category = ? and b.userid = ? and a.id_q_subject = b.id_subject ");
		sql.append("Order by a.q_subject ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setInt(1, id_category);
			stm.setString(2, userid);
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
            throw new QmTmException("과목정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getAllBeans3]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
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
            throw new QmTmException("과목정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getAllBeans]");
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
            throw new QmTmException("과목정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.. [ExamUtil.makeBeans]");
        }
    }

	// 강의 정보 모두 가지고오기
	public static ExamUtilBean[] getSubjBeans(String term_id) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_q_subject, a.q_subject ");
		sql.append("From q_subject a, q_worker_subj b ");
		sql.append("Where a.term_id = ? and a.id_q_subject = b.id_subject ");
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, term_id);
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
            throw new QmTmException("과목정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getSubjBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	// 강의 정보 가지고오기
	public static ExamUtilBean[] getSubjBeans(String term_id, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.id_q_subject, a.q_subject ");
		sql.append("From q_subject a, q_worker_subj b ");
		sql.append("Where a.term_id = ? and b.userid = ? and a.id_q_subject = b.id_subject ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, term_id);
			stm.setString(2, userid);
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
            throw new QmTmException("과목정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getSubjBeans]");
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
            throw new QmTmException("과목정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeSubjBeans]");
        }
    }

	// 단원 1 정보 가지고오기
	public static ExamUtilBean[] getCpt1Beans(String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		sql = "Select id_q_chapter, chapter From q_chapter Where id_q_subject = ? Order by regdate ";

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
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
            throw new QmTmException("단원정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getCpt1Beans]");
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
            throw new QmTmException("단원정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeCpt1Beans]");
        }
    }

	// 단원 2 정보 가지고오기
	public static ExamUtilBean[] getCpt2Beans(String id_q_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		sql = "Select id_q_chapter2, chapter From q_chapter2 Where id_q_chapter = ? Order by regdate ";

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_q_chapter);
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
            throw new QmTmException("단원2정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getCpt2Beans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	// 단원 3 정보 가지고오기
	public static ExamUtilBean[] getCpt3Beans(String id_q_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		sql = "Select id_q_chapter3, chapter From q_chapter3 Where id_q_chapter2 = ? Order by regdate ";

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_q_chapter);
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
            throw new QmTmException("단원3정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getCpt3Beans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	// 단원 4 정보 가지고오기
	public static ExamUtilBean[] getCpt4Beans(String id_q_chapter) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		sql = "Select id_q_chapter4, chapter From q_chapter4 Where id_q_chapter3 = ? Order by regdate ";

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_q_chapter);
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
            throw new QmTmException("단원4정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getCpt4Beans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
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
            throw new QmTmException("문제검색 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeSearchBeans]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getQsBeans]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeQsBeans]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getRefBeans]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeRefBeans]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getRefsBeans]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeRefsBeans]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getQsBeans2]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeQsBeans2]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getRefsBeans2]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeRefsBeans2]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getQsBeans3]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeQsBeans3]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getRefsBeans3]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeRefsBeans3]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getQsBeans4]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeQsBeans4]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getRefsBeans4]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeRefsBeans4]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getQsBeans5]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeQsBeans5]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getRefsBeans5]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeRefsBeans5]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getQsBeans]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getRQsBeans]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getRQsBeans2]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getRQsBeans3]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getRQsBeans4]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getRQsBeans5]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getRQsBeans]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeQsBeans]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getRefsBeans]");
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
            throw new QmTmException("시험지 임시저장 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeRefsBeans]");
        }
    }

	// 문제 검색결과 가지고 오기
	public static ExamSearchResBean[] getSearchBeans(ExamSearchBean bean, String userid) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_q, a.id_subject, a.id_ref, a.id_qtype, a.allotting, a.id_difficulty1, a.q, c.make_cnt ");
		sql.append("From q a, q_subject b, make_q c ");
		sql.append("Where a.id_subject = '"+ bean.getSubjects() +"' and a.id_subject = b.id_q_subject and a.id_q = c.id_q and a.id_valid_type = 0 ");
		if(!userid.equals("qmtm")) {
			sql.append(" and a.userid = '"+ userid +"' ");
		}

		// chapter1 포함 검색
		if(bean.getChapter1() != null && bean.getChapter2() == null) {
			sql.append("and a.id_chapter = '"+ bean.getChapter1() +"' ");
			sql.append("and a.id_chapter2 = '-1' and a.id_chapter3 = '-1' and a.id_chapter4 = '-1' ");
        } else if(bean.getChapter1() != null  && bean.getChapter2() != null && bean.getChapter3() == null ) { 	// chapter2 포함 검색
			sql.append("and a.id_chapter = '"+ bean.getChapter1() +"' and a.id_chapter2 = '"+ bean.getChapter2() +"' ");
			sql.append("and a.id_chapter3 = '-1' and a.id_chapter4 = '-1' ");
		} else if(bean.getChapter1() != null  && bean.getChapter2() != null && bean.getChapter3() != null && bean.getChapter4() == null ) { 	// chapter3 포함 검색
			sql.append("and a.id_chapter = '"+ bean.getChapter1() +"' and a.id_chapter2 = '"+ bean.getChapter2() +"' and a.id_chapter3 = '"+ bean.getChapter3() +"' ");
			sql.append("and a.id_chapter4 = '-1' ");
		} else if(bean.getChapter1() != null  && bean.getChapter2() != null && bean.getChapter3() != null && bean.getChapter4() != null ) { 	// chapter4 포함 검색
			sql.append("and a.id_chapter = '"+ bean.getChapter1() +"' and a.id_chapter2 = '"+ bean.getChapter2() +"' ");
			sql.append("and a.id_chapter3 = '"+ bean.getChapter3() +"' and a.id_chapter4 = '"+ bean.getChapter4() +"' ");
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
			sql.append("and to_char(a.regdate, 'yyyy-mm-dd') >= '"+ bean.getRegdate1() +"' ");
        }

		// 문제입력 종료일 포함 검색
		if(bean.getRegdate2() != null) {
			sql.append("and to_char(a.regdate, 'yyyy-mm-dd') <= '"+ bean.getRegdate2() +"' ");
        }

		// 문제수정 시작일 포함 검색
		if(bean.getUpdates1() != null) {
			sql.append("and to_char(a.up_date, 'yyyy-mm-dd') >= '"+ bean.getUpdates1() +"' ");
        }

		// 문제수정 종료일 포함 검색
		if(bean.getUpdates2() != null) {
			sql.append("and to_char(a.up_date, 'yyyy-mm-dd') <= '"+ bean.getUpdates2() +"' ");
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

		// 문제용도2 포함 검색
		if(bean.getQ_uses2() != null) {
			sql.append("and a.q_use_detail = '"+ bean.getQ_uses2() +"' ");
        }

			sql.append("Order by a.id_qtype asc, a.id_difficulty1 desc ");

        try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.createStatement();        
		    rst = stm.executeQuery(sql.toString());

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
            throw new QmTmException("문항 정보 검색하는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getSearchBeans]");
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
		
		sql.append("Select a.id_q, a.id_subject, a.id_ref, a.id_qtype, b.allotting, a.id_difficulty1, substring(a.q,0,20), c.make_cnt ");
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
            throw new QmTmException("문항 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getPrepapers]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamCreateBean getAllotBean(String id_exam) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select qcount, allotting, id_randomtype, qcntperpage From exam_m Where id_exam = ? ";

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql);
			stm.setString(1, id_exam);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeAllotBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("시험 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.getAllotBean]");
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
            throw new QmTmException("시험 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamUtil.makeAllotBean]");
        }
    }
}