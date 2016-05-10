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

public class ExamList
{
    public ExamList() {
    }

	public static ExamListBean[] getGrpBeans(String id_course, String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT a.id_exam, a.title, a.yn_enable, convert(varchar(16), a.exam_start1, 120) exam_start1, ");
		sql.append("       convert(varchar(16), a.exam_end1, 120) exam_end1, b.auth_type, convert(varchar(16), a.stat_start, 120) stat_start, ");
		sql.append("       convert(varchar(16), a.stat_end, 120) stat_end, a.userid, convert(varchar(16), a.regdate, 120) regdate, a.yn_open_qa, ");
		sql.append("       convert(varchar(16), a.login_start, 120) login_start, convert(varchar(16), a.login_end, 120) login_end ");
		sql.append("From exam_m a, r_auth_type b ");
		sql.append("Where a.id_course = ? and a.id_subject = ? and a.id_auth_type = b.id_auth_type ");
		sql.append("Order by a.exam_start1 desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);
			stm.setString(2, id_subject);
            rst = stm.executeQuery();
            ExamListBean bean = null;
            while (rst.next()) {
                bean = makeGrpBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamListBean[]) beans.toArray(new ExamListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("검색된 시험정보 읽어오는 중 오류가 발생되었습니다. [ExamList.getGrpBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static ExamListBean makeGrpBeans (ResultSet rst) throws QmTmException
    {
		try {
            ExamListBean bean = new ExamListBean();
            bean.setId_exam(rst.getString(1));
            bean.setTitle(rst.getString(2));
            bean.setYn_enable(rst.getString(3));
			bean.setExam_start1(rst.getString(4));
			bean.setExam_end1(rst.getString(5));
			bean.setId_auth_type(rst.getString(6));
			bean.setStat_start(rst.getString(7));
			bean.setStat_end(rst.getString(8));
			bean.setUserid(rst.getString(9));
			bean.setRegdate(rst.getString(10));			
			bean.setYn_open_qa(rst.getString(11));
			bean.setLogin_start(rst.getString(12));
			bean.setLogin_end(rst.getString(13));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("검색된 시험정보 읽어오는 중 오류가 발생되었습니다. [ExamList.makeGrpBeans] " + ex.getMessage());
     	}
    }
	
	public static ExamListBean[] getBeans(String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT a.id_exam, a.title, a.yn_enable, convert(varchar(19), a.exam_start1, 120) exam_start1, ");
		sql.append("       convert(varchar(19), a.exam_end1, 120) exam_end1, b.auth_type, convert(varchar(19), a.stat_start, 120) stat_start, ");
		sql.append("       convert(varchar(19), a.stat_end, 120) stat_end, a.userid, convert(varchar(19), a.regdate, 120) regdate, a.yn_open_qa, a.limittime ");
		sql.append("From exam_m a, r_auth_type b ");
		sql.append("Where a.id_course = ? and a.id_auth_type = b.id_auth_type ");
		sql.append("Order by a.exam_start1 desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);
            rst = stm.executeQuery();
            ExamListBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamListBean[]) beans.toArray(new ExamListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("검색된 시험정보 읽어오는 중 오류가 발생되었습니다. [ExamList.getBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamListBean[] getBeans(String id_course, String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT a.id_exam, a.title, a.yn_enable, convert(varchar(19), a.exam_start1, 120) exam_start1, ");
		sql.append("       convert(varchar(19), a.exam_end1, 120) exam_end1, b.auth_type, convert(varchar(19), a.stat_start, 120) stat_start, ");
		sql.append("       convert(varchar(19), a.stat_end, 120) stat_end, a.userid, convert(varchar(19), a.regdate, 120) regdate, a.yn_open_qa, a.limittime ");
		sql.append("From exam_m a, r_auth_type b ");
		sql.append("Where a.id_course = ? and a.id_subject = ? and a.id_auth_type = b.id_auth_type ");
		sql.append("Order by a.exam_start1 desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);
			stm.setString(2, id_subject);
            rst = stm.executeQuery();
            ExamListBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamListBean[]) beans.toArray(new ExamListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("검색된 시험정보 읽어오는 중 오류가 발생되었습니다. [ExamList.getBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	private static ExamListBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            ExamListBean bean = new ExamListBean();
            bean.setId_exam(rst.getString(1));
            bean.setTitle(rst.getString(2));
            bean.setYn_enable(rst.getString(3));
			bean.setExam_start1(rst.getString(4));
			bean.setExam_end1(rst.getString(5));
			bean.setId_auth_type(rst.getString(6));
			bean.setStat_start(rst.getString(7));
			bean.setStat_end(rst.getString(8));
			bean.setUserid(rst.getString(9));
			bean.setRegdate(rst.getString(10));			
			bean.setYn_open_qa(rst.getString(11));
			bean.setLimittime(rst.getLong(12));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("검색된 시험정보 읽어오는 중 오류가 발생되었습니다. [ExamList.makeBeans] " + ex.getMessage());
     	}
    }
	
	public static ExamListBean[] getSearchBeans(String fields, String strs, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT a.id_exam, a.title, a.yn_enable, convert(varchar(16), a.exam_start1, 120) exam_start1, ");
		sql.append("       convert(varchar(16), a.exam_end1, 120) exam_end1, b.auth_type, convert(varchar(16), a.stat_start, 120) stat_start, ");
		sql.append("       convert(varchar(16), a.stat_end, 120) stat_end, a.userid, convert(varchar(16), a.regdate, 120) regdate, c.name, d.course ");
		sql.append("From exam_m a, r_auth_type b, qt_workerid c, c_course d ");
		sql.append("Where a.userid = ? and " + fields + " like '%'+?+'%' and a.id_auth_type = b.id_auth_type and ");
		sql.append("      a.userid = c.userid and a.id_course = d.id_course ");
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
			stm.setString(2, strs);
            rst = stm.executeQuery();
            ExamListBean bean = null;
            while (rst.next()) {
                bean = makeSearchBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamListBean[]) beans.toArray(new ExamListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("검색된 시험정보 읽어오는 중 오류가 발생되었습니다. [ExamList.getSearchBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamListBean[] getAdmSearchBeans(String fields, String strs, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT a.id_exam, a.title, a.yn_enable, convert(varchar(16), a.exam_start1, 120) exam_start1, ");
		sql.append("       convert(varchar(16), a.exam_end1, 120) exam_end1, b.auth_type, convert(varchar(16), a.stat_start, 120) stat_start, ");
		sql.append("       convert(varchar(16), a.stat_end, 120) stat_end, a.userid, convert(varchar(16), a.regdate, 120) regdate, c.name, d.course ");
		sql.append("From exam_m a, r_auth_type b, view_qt_workerid c, c_course d ");
		sql.append("Where " + fields + " like '%'+?+'%' and a.id_auth_type = b.id_auth_type and a.userid = c.userid and a.id_course = d.id_course ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, strs);
            rst = stm.executeQuery();
            ExamListBean bean = null;
            while (rst.next()) {
                bean = makeSearchBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamListBean[]) beans.toArray(new ExamListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("검색된 시험정보 읽어오는 중 오류가 발생되었습니다. [ExamList.getAdmSearchBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static ExamListBean makeSearchBeans (ResultSet rst) throws QmTmException
    {
		try {
            ExamListBean bean = new ExamListBean();
            bean.setId_exam(rst.getString(1));
            bean.setTitle(rst.getString(2));
            bean.setYn_enable(rst.getString(3));
			bean.setExam_start1(rst.getString(4));
			bean.setExam_end1(rst.getString(5));
			bean.setId_auth_type(rst.getString(6));
			bean.setStat_start(rst.getString(7));
			bean.setStat_end(rst.getString(8));
			bean.setUserid(rst.getString(9));
			bean.setRegdate(rst.getString(10));
			bean.setName(rst.getString(11));
			bean.setCourse(rst.getString(12));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("검색된 시험정보 읽어오는 중 오류가 발생되었습니다. [ExamList.makeSearchBeans] " + ex.getMessage());
        }
    }

	public static void exam_copy(String ori_id_exam, String copy_id_exam, String copy_title, String course_year, String course_no, String id_course, String id_subject) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO exam_m ");
		sql.append("Select ?, ?, ?, ?, ?, course_class_no, course_study_seq, "); 
		sql.append("       ?, guide, id_exam_kind, yn_enable, exam_start1, exam_end1, receipt_start, receipt_end, login_start, "); 
		sql.append("       login_end, id_exam_type, id_auth_type, yn_stat, stat_start, stat_end, yn_p_rank, yn_p_rank_pct, "); 
		sql.append("       yn_t_avg, yn_t_u_avg, u_avg_basis, yn_t_max, yn_t_min, yn_t_user_cnt, yn_score_dis, yn_opt_subj, "); 
		sql.append("       yn_open_qa, yn_open_score_direct, failure_score, success_score, yn_exam_result_msg, log_option, ");
		sql.append("       web_window_mode, yn_sametime, limittime, qcount, allotting, id_randomtype, setcount, id_ltimetype, ");
		sql.append("       id_movepage, yn_viewas, qcntperpage, id_exlabel, fontname, fontsize, paper_type, userid, cal_stat_date, "); 
		sql.append("       regdate, up_date, exam_pwd_yn, exam_pwd_str, id_category, yn_activex, yn_success_score, exam_method ");				 
		sql.append("From exam_m ");
		sql.append("Where id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, copy_id_exam);
			stm.setString(2, id_course);
			stm.setString(3, id_subject);
			stm.setString(4, course_year);
			stm.setString(5, course_no);
			stm.setString(6, copy_title);
			stm.setString(7, ori_id_exam);
			stm.executeUpdate();

			paper_copy(ori_id_exam, copy_id_exam);

		} catch (SQLException ex) {
			throw new QmTmException("시험 복사 작업 중 오류가 발생되었습니다. [ExamList.exam_copy] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void paper_copy(String ori_id_exam, String copy_id_exam) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO exam_paper2 ");
		sql.append("Select ?, nr_set, nr_q, id_q, ex_order, allotting, page, q_no1, q_no2 "); 
		sql.append("From exam_paper2 ");
		sql.append("Where id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, copy_id_exam);
			stm.setString(2, ori_id_exam);
			stm.executeUpdate();
			
			makecntUpdate(copy_id_exam);

		} catch (SQLException ex) {
			throw new QmTmException("시험지 복사 작업 중 오류가 발생되었습니다. [ExamList.paper_copy] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void makecntUpdate(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update make_q ");
		sql.append("       Set make_cnt = make_cnt + 1 ");
		sql.append("Where id_q in ");
		sql.append("      ( Select distinct id_q From exam_paper2 Where id_exam = ? ) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());			
			stm.setString(1, id_exam);

			stm.execute();
        }
        catch (SQLException ex) {
        	throw new QmTmException("시험지에 문제은행 출제횟수 증가 작업 중 오류가 발생되었습니다. [ExamList.makecntUpdate] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static boolean ans_yn(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select userid ");
		sql.append("FROM exam_ans ");
		sql.append("Where userid <> 'tman@@2008' and id_exam = ? ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            
            if (rst.next()) return true; 
            else return false; 
            
        } catch (SQLException ex) {
            throw new QmTmException("답안제출유무 확인 작업 중 오류가 발생되었습니다. [ExamList.ans_yn] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void exam_deletes(String id_exam) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Delete from exam_m ");
		sql.append("Where id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.executeUpdate();

			makecntMinus(id_exam);

		} catch (SQLException ex) {
			throw new QmTmException("시험 삭제 작업 중 오류가 발생되었습니다. [ExamList.exam_deletes] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}
	
	public static void makecntMinus(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update make_q ");
		sql.append("       Set make_cnt = make_cnt - 1 ");
		sql.append("Where id_q in ");
		sql.append("      ( Select distinct id_q From exam_paper2 Where id_exam = ? ) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			
			stm.setString(1, id_exam);
			stm.execute();

			paper_deletes(id_exam);
        }
        catch (SQLException ex) {
        	throw new QmTmException("문제출제횟수 감소작업 중 오류가 발생되었습니다. [ExamList.makecntMinus] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void paper_deletes(String id_exam) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Delete from exam_paper2 ");
		sql.append("Where id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.executeUpdate();

			answer_deletes(id_exam);

		} catch (SQLException ex) {
			throw new QmTmException("시험지 삭제 작업 중 오류가 발생되었습니다. [ExamList.paper_deletes] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void answer_deletes(String id_exam) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Delete from exam_ans Where id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.executeUpdate();

		} catch (SQLException ex) {
			throw new QmTmException("응시자 답안지 삭제 작업 중 오류가 발생되었습니다. [ExamList.answer_deletes] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static String getExamTitle(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select title ");
		sql.append("FROM exam_m ");
		sql.append("Where id_exam = ? ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            
            if (rst.next()) return rst.getString("title");
            else return null; 
            
        } catch (SQLException ex) {
            throw new QmTmException("시험명을 읽어오는 중 오류가 발생되었습니다. [ExamList.getExamTitle] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static String getRandomType(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_randomtype ");
		sql.append("FROM exam_m ");
		sql.append("Where id_exam = ? ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            
            if (rst.next()) return rst.getString("id_randomtype");
            else return null; 
            
        } catch (SQLException ex) {
            throw new QmTmException("출제유형을 읽어오는 중 오류가 발생되었습니다. [ExamList.getRandomType] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static int getAnsInwon(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select count(userid) as cnts ");
		sql.append("FROM exam_ans ");
		sql.append("Where id_exam = ? ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            
            if (rst.next()) return rst.getInt("cnts");
            else return 0; 
            
        } catch (SQLException ex) {
            throw new QmTmException("시험응시인원을 읽어오는 중 오류가 발생되었습니다. [ExamList.getAnsInwon] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}