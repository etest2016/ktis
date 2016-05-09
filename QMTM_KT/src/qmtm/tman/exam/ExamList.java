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
		
		sql.append("SELECT a.id_exam, a.title, a.yn_enable, to_char(a.exam_start1, 'yyyy-mm-dd hh24:mi') exam_start1, ");
		sql.append("       to_char(a.exam_end1, 'yyyy-mm-dd hh24:mi') exam_end1, b.auth_type, to_char(a.stat_start, 'yyyy-mm-dd hh24:mi') stat_start, ");
		sql.append("       to_char(a.stat_end, 'yyyy-mm-dd hh24:mi') stat_end, a.userid, to_char(a.regdate, 'yyyy-mm-dd hh24:mi') regdate, a.yn_open_qa, ");
		sql.append("       to_char(a.login_start, 'yyyy-mm-dd hh24:mi') login_start, to_char(a.login_end, 'yyyy-mm-dd hh24:mi') login_end ");
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
            throw new QmTmException("검색된 시험정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamList.getGrpBeans]");
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
            throw new QmTmException("검색된 시험정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamList.makeGrpBeans]");
     	}
    }

	public static ExamListBean[] getBeans(String id_course, String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT a.id_exam, a.title, a.yn_enable, to_char(a.exam_start1, 'yyyy-mm-dd hh24:mi:ss') exam_start1, ");
		sql.append("       to_char(a.exam_end1, 'yyyy-mm-dd hh24:mi:ss') exam_end1, b.auth_type, to_char(a.stat_start, 'yyyy-mm-dd hh24:mi:ss') stat_start, ");
		sql.append("       to_char(a.stat_end, 'yyyy-mm-dd hh24:mi:ss') stat_end, a.userid, to_char(a.regdate, 'yyyy-mm-dd hh24:mi:ss') regdate, a.yn_open_qa ");
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
            throw new QmTmException("검색된 시험정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamList.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamListBean[] getMarkBeans(String id_course, String id_subject, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT a.id_exam, a.title, a.yn_enable, to_char(a.exam_start1, 'yyyy-mm-dd hh24:mi:ss') exam_start1, ");
		sql.append("       to_char(a.exam_end1, 'yyyy-mm-dd hh24:mi:ss') exam_end1, b.auth_type, to_char(a.stat_start, 'yyyy-mm-dd hh24:mi:ss') stat_start, ");
		sql.append("       to_char(a.stat_end, 'yyyy-mm-dd hh24:mi:ss') stat_end, a.userid, to_char(a.regdate, 'yyyy-mm-dd hh24:mi:ss') regdate, a.yn_open_qa ");
		sql.append("From exam_m a, r_auth_type b, score_manager_exam c ");
		sql.append("Where a.id_course = ? and a.id_subject = ? and c.userid = ? and a.id_exam = c.id_exam and a.id_auth_type = b.id_auth_type ");
		sql.append("Order by a.exam_start1 desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);
			stm.setString(2, id_subject);
			stm.setString(3, userid);
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
            throw new QmTmException("검색된 시험정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamList.getBeans]");
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
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("검색된 시험정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamList.makeBeans]");
     	}
    }

	public static ExamListBean[] getReExamBeans(String id_course, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT a.id_exam, a.title, a.yn_enable, to_char(a.exam_start1, 'yyyy-mm-dd hh24:mi:ss') exam_start1, ");
		sql.append("       to_char(a.exam_end1, 'yyyy-mm-dd hh24:mi:ss') exam_end1, b.auth_type, to_char(a.stat_start, 'yyyy-mm-dd hh24:mi:ss') stat_start, ");
		sql.append("       to_char(a.stat_end, 'yyyy-mm-dd hh24:mi:ss') stat_end, a.userid, to_char(a.regdate, 'yyyy-mm-dd hh24:mi:ss') regdate, a.yn_open_qa ");
		sql.append("From exam_m a, r_auth_type b ");
		sql.append("Where a.id_course = ? and a.id_subject = '-1' and a.id_auth_type in (0,1) and a.id_exam <> ? and a.id_auth_type = b.id_auth_type ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);
			stm.setString(2, id_exam);
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
            throw new QmTmException("재시험정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamList.getReExamBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamListBean[] getSearchBeans(String fields, String strs, String userid) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT a.id_exam, a.title, a.yn_enable, to_char(a.exam_start1, 'yyyy-mm-dd hh24:mi') exam_start1, ");
		sql.append("       to_char(a.exam_end1, 'yyyy-mm-dd hh24:mi') exam_end1, b.auth_type, to_char(a.stat_start, 'yyyy-mm-dd hh24:mi') stat_start, ");
		sql.append("       to_char(a.stat_end, 'yyyy-mm-dd hh24:mi') stat_end, a.userid, to_char(a.regdate, 'yyyy-mm-dd hh24:mi') regdate, c.name, d.course ");
		sql.append("From exam_m a, r_auth_type b, qt_workerid c, c_course d ");
		sql.append("Where a.userid = '"+ userid +"' and "+ fields +" like '%"+ strs +"%' and a.id_auth_type = b.id_auth_type and ");
		sql.append("      a.userid = c.userid and a.id_course = d.id_course ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();
			rst = stm.executeQuery(sql.toString());
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
            throw new QmTmException("검색된 시험정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamList.getSearchBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamListBean[] getAdmSearchBeans(String fields, String strs, String userid) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT a.id_exam, a.title, a.yn_enable, to_char(a.exam_start1, 'yyyy-mm-dd hh24:mi') exam_start1, ");
		sql.append("       to_char(a.exam_end1, 'yyyy-mm-dd hh24:mi') exam_end1, b.auth_type, to_char(a.stat_start, 'yyyy-mm-dd hh24:mi') stat_start, ");
		sql.append("       to_char(a.stat_end, 'yyyy-mm-dd hh24:mi') stat_end, a.userid, to_char(a.regdate, 'yyyy-mm-dd hh24:mi') regdate, c.name, d.course ");
		sql.append("From exam_m a, r_auth_type b, qt_workerid c, c_course d ");
		sql.append("Where "+ fields +" like '%"+ strs +"%' and a.id_auth_type = b.id_auth_type and a.userid = c.userid and a.id_course = d.id_course ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();
			rst = stm.executeQuery(sql.toString());
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
            throw new QmTmException("검색된 시험정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamList.getAdmSearchBeans]");
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
            throw new QmTmException("검색된 시험정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamList.makeSearchBeans]");
        }
    }

	public static void reExamRegDel(String id_exam, String rid_exam)  throws QmTmException {
		
		Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "Delete From exam_receipt Where id_exam = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_exam);

			stm.execute();

			reExamReg(id_exam, rid_exam); // 미응시자들을 대상자로 등록합니다.
        }
        catch (SQLException ex) {
            throw new QmTmException("대상자인원 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [ExamList.reExamRegDel]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void reExamReg(String id_exam, String rid_exam) throws QmTmException {		
		
		Connection cnn = null; Statement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO exam_receipt ");
		sql.append("Select '"+ id_exam +"', a.userid, 'Y', sysdate From qt_course_user a, exam_m b "); 
		sql.append("Where b.id_exam = '"+ rid_exam +"' and b.id_auth_type = '1' and a.id_course = b.id_course "); 
		sql.append("      and a.id_subject = b.id_subject and a.course_year = b.course_year "); 
		sql.append("      and a.course_no = b.course_no and a.userid not in (Select userid From exam_ans Where id_exam = '"+ rid_exam +"') "); 

		try {
			cnn = DBPool.getConnection();
			stm = cnn.createStatement(); 
			stm.executeUpdate(sql.toString());

		} catch (SQLException ex) {
			throw new QmTmException("시험에 대상자 등록 작업 중 인터넷 연결상태가 좋지 않습니다. [ExamList.reExamReg]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}
	
	public static void exam_copy(String ori_id_exam, String copy_id_exam) throws QmTmException {

		Connection cnn = null; Statement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO exam_m ");
		sql.append("Select '"+ copy_id_exam +"', id_course, id_subject, course_year, course_no, course_class_no, course_study_seq, '사본 '+title, "); 
		sql.append("       guide, id_exam_kind, yn_enable, exam_start1, exam_end1, receipt_start, receipt_end, login_start, "); 
		sql.append("       login_end, id_exam_type, id_auth_type, yn_stat, stat_start, stat_end, yn_p_rank, yn_p_rank_pct, "); 
		sql.append("       yn_t_avg, yn_t_u_avg, u_avg_basis, yn_t_max, yn_t_min, yn_t_user_cnt, yn_score_dis, yn_opt_subj, "); 
		sql.append("       yn_open_qa, yn_open_score_direct, failure_score, success_score, yn_exam_result_msg, log_option, ");
		sql.append("       web_window_mode, yn_sametime, limittime, qcount, allotting, id_randomtype, setcount, id_ltimetype, ");
		sql.append("       id_movepage, yn_viewas, qcntperpage, id_exlabel, fontname, fontsize, paper_type, userid, cal_stat_date, "); 
		sql.append("       regdate, up_date ");
		sql.append("From exam_m ");
		sql.append("Where id_exam = '"+ ori_id_exam +"' ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.createStatement(); 
			stm.executeUpdate(sql.toString());

			paper_copy(ori_id_exam, copy_id_exam);

		} catch (SQLException ex) {
			throw new QmTmException("시험 복사 작업 중 인터넷 연결상태가 좋지 않습니다. [ExamList.exam_copy]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void exam_copy(String ori_id_exam, String copy_id_exam, String copy_title) throws QmTmException {

		Connection cnn = null; Statement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO exam_m ");
		sql.append("Select '"+ copy_id_exam +"', id_course, id_subject, course_year, course_no, course_class_no, course_study_seq, "); 
		sql.append("       '"+ copy_title +"', guide, id_exam_kind, yn_enable, exam_start1, exam_end1, receipt_start, receipt_end, login_start, "); 
		sql.append("       login_end, id_exam_type, id_auth_type, yn_stat, stat_start, stat_end, yn_p_rank, yn_p_rank_pct, "); 
		sql.append("       yn_t_avg, yn_t_u_avg, u_avg_basis, yn_t_max, yn_t_min, yn_t_user_cnt, yn_score_dis, yn_opt_subj, "); 
		sql.append("       yn_open_qa, yn_open_score_direct, failure_score, success_score, yn_exam_result_msg, log_option, ");
		sql.append("       web_window_mode, yn_sametime, limittime, qcount, allotting, id_randomtype, setcount, id_ltimetype, ");
		sql.append("       id_movepage, yn_viewas, qcntperpage, id_exlabel, fontname, fontsize, paper_type, userid, cal_stat_date, "); 
		sql.append("       regdate, up_date, exam_pwd_yn, exam_pwd_str ");
		sql.append("From exam_m ");
		sql.append("Where id_exam = '"+ ori_id_exam +"' ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.createStatement(); 
			stm.executeUpdate(sql.toString());

			paper_copy(ori_id_exam, copy_id_exam);

		} catch (SQLException ex) {
			//throw new QmTmException("시험 복사 작업 중 인터넷 연결상태가 좋지 않습니다. [ExamList.exam_copy]");
			throw new QmTmException(ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void paper_copy(String ori_id_exam, String copy_id_exam) throws QmTmException {
		Connection cnn = null; Statement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO exam_paper2 ");
		sql.append("Select '"+ copy_id_exam +"', nr_set, nr_q, id_q, ex_order, allotting, page, q_no1, q_no2 "); 
		sql.append("From exam_paper2 ");
		sql.append("Where id_exam = '"+ ori_id_exam +"' ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.createStatement(); 
			stm.executeUpdate(sql.toString());

		} catch (SQLException ex) {
			throw new QmTmException("시험지 복사 작업 중 인터넷 연결상태가 좋지 않습니다. [ExamList.paper_copy]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static boolean ans_yn(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		String sql = "Select userid FROM exam_ans Where userid <> 'tman@@2008' and id_exam = ? ";

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            
            if (rst.next()) return true; 
            else return false; 
            
        } catch (SQLException ex) {
            throw new QmTmException("답안제출유무 확인 작업 중 인터넷 연결상태가 좋지 않습니다. [ExamList.ans_yn]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void exam_deletes(String id_exam) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Delete from exam_m Where id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.executeUpdate();

			paper_deletes(id_exam);

		} catch (SQLException ex) {
			throw new QmTmException("시험 삭제 작업 중 인터넷 연결상태가 좋지 않습니다. [ExamList.exam_deletes]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void paper_deletes(String id_exam) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Delete from exam_paper2 Where id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.executeUpdate();

			answer_deletes(id_exam);

		} catch (SQLException ex) {
			throw new QmTmException("시험지 삭제 작업 중 인터넷 연결상태가 좋지 않습니다. [ExamList.paper_deletes]");
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
			throw new QmTmException("응시자 답안지 삭제 작업 중 인터넷 연결상태가 좋지 않습니다. [ExamList.answer_deletes]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static String getExamTitle(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		String sql = "Select title FROM exam_m Where id_exam = ? ";

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            
            if (rst.next()) return rst.getString("title");
            else return null; 
            
        } catch (SQLException ex) {
            throw new QmTmException("시험명을 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamList.getExamTitle]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static String getRandomType(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		String sql = "Select id_randomtype FROM exam_m Where id_exam = ? ";

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            
            if (rst.next()) return rst.getString("id_randomtype");
            else return null; 
            
        } catch (SQLException ex) {
            throw new QmTmException("출제유형을 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamList.getRandomType]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static int getAnsInwon(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		String sql = "Select count(userid) as cnts FROM exam_ans Where id_exam = ? ";

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            
            if (rst.next()) return rst.getInt("cnts");
            else return 0; 
            
        } catch (SQLException ex) {
            throw new QmTmException("시험응시인원을 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamList.getAnsInwon]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}