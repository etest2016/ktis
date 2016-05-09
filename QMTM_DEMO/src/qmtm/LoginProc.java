package qmtm;

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

public class LoginProc
{
    public LoginProc() {
    }
	
	public static String getPwdChk(String userid) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select password From qt_workerid Where userid = ? and yn_valid = 'Y' ");
	
	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getString("password");
            else return null;
        } catch (SQLException ex) {
            throw new QmTmException("교수자 비밀번호 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static String getLoginChk(String userid, String passwd) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		if(userid.equals("qmtm")) {
			sql.append("Select name From qt_settings Where id = ? and qmtm_password = ? ");
		} else {
			sql.append("Select name From qt_workerid Where userid = ? and password = ? and yn_valid = 'Y' ");
		}

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
			stm.setString(2, passwd);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getString("name");
            else return null;
        } catch (SQLException ex) {
            //throw new QmTmException("교수자 이름 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
			throw new QmTmException(ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static String getId_course(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_course From exam_m Where id_exam = ? ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getString("id_course");
            else return null;
        } catch (SQLException ex) {
            throw new QmTmException("시험 과정코드 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static LoginProcBean makeAdmin_work() throws QmTmException {
		
		try {
            LoginProcBean bean = new LoginProcBean();
            bean.setPt_exam_edit("Y");
			bean.setPt_exam_delete("Y");
			bean.setPt_answer_edit("Y");
			bean.setPt_score_edit("Y");
            bean.setPt_static_edit("Y");
            return bean;
        } catch (Exception ex) {
            throw new QmTmException("시험관리 권한 정보 설정작업 중 인터넷 연결상태가 좋지 않습니다.");
        }
	}
	
	public static LoginProcBean getExam_work(String id_course, String userid) throws QmTmException {
		
		if(userid.equals("qmtm")) {
			return makeAdmin_work();
		} else {

		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select pt_exam_edit, pt_exam_delete, pt_answer_edit, pt_score_edit, pt_static_edit ");
		sql.append("From t_worker_subj ");
		sql.append("Where id_course = ? and userid = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_course);
			stm.setString(2, userid);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeExam_work(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("시험관리 권한 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
		} finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
		}
	}

	private static LoginProcBean makeExam_work (ResultSet rst) throws QmTmException
    {
		try {
            LoginProcBean bean = new LoginProcBean();
            bean.setPt_exam_edit(rst.getString(1));
			bean.setPt_exam_delete(rst.getString(2));
			bean.setPt_answer_edit(rst.getString(3));
			bean.setPt_score_edit(rst.getString(4));
            bean.setPt_static_edit(rst.getString(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험관리 권한 정보 설정작업 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }

	private static LoginProcBean makeAdmin_work2() throws QmTmException {
		
		try {
            LoginProcBean bean = new LoginProcBean();
            bean.setPt_q_edit("Y");
			bean.setPt_q_delete("Y");
            return bean;
        } catch (Exception ex) {
            throw new QmTmException("문제관리 권한 정보 설정작업 중 인터넷 연결상태가 좋지 않습니다.");
        }
	}
	
	public static LoginProcBean getQ_work(String id_subject, String userid) throws QmTmException {
		
		if(userid.equals("qmtm")) {
			return makeAdmin_work2();
		} else {
		
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select pt_q_edit, pt_q_delete ");
		sql.append("From q_worker_subj ");
		sql.append("Where id_subject = ? and userid = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_subject);
			stm.setString(2, userid);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeQ_work(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("문제관리 권한 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}

		}
	}

	private static LoginProcBean makeQ_work (ResultSet rst) throws QmTmException
    {
		try {
            LoginProcBean bean = new LoginProcBean();
            bean.setPt_q_edit(rst.getString(1));
			bean.setPt_q_delete(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제관리 권한 정보 설정작업 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }
}
