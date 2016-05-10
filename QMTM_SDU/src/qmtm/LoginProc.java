package qmtm;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;
import qmtm.ComLib;


// Java API Import
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.Statement;
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
            throw new QmTmException("교수자 비밀번호 정보를 읽어오는 중 오류가 발생되었습니다. [LoginProc.getPwdChk()] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static String getLoginChk(String userid, String passwd) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
        String runMode = ComLib.getConfig("runmode");
        if(runMode.equals("ETEST_DEV")) {
     		if(userid.equals("qmtm")) {
     			//sql.append("Select name From qt_settings Where id = ? and (PWDCOMPARE (?, qmtm_password ) = 1) ");
     			sql.append("Select name From qt_settings Where id = ? and qmtm_password = ? ");
     		} else {
     			sql.append("Select name From qt_workerid Where userid = ? and (PWDCOMPARE (?, password) = 1) and yn_valid = 'Y' ");
     		}
        } else {
    		if(userid.equals("qmtm")) {
    			sql.append("Select name From qt_settings Where id = ? and qmtm_password = DBO.FN_GET_HASHBYTES_VALUE( ? ) ");
    		} else {
    			sql.append("Select name From qt_workerid Where userid = ? and password = ? and yn_valid = 'Y' ");
    		}
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
            throw new QmTmException("교수자 이름 정보를 읽어오는 중 오류가 발생되었습니다. [LoginProc.getLoginChk()] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static String getLoginName(String userid) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		if(userid.equals("qmtm")) {
			sql.append("Select name From qt_settings Where id = ? ");
		} else {
			sql.append("Select name From qt_workerid Where userid = ? and yn_valid = 'Y' ");
		}

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getString("name");
            else return null;
        } catch (SQLException ex) {
            throw new QmTmException("교수자 이름 정보를 읽어오는 중 오류가 발생되었습니다. [LoginProc.getLoginName()] " + ex.getMessage());
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
            throw new QmTmException("시험 과정코드 정보를 읽어오는 중 오류가 발생되었습니다. [LoginProc.getId_course()] " + ex.getMessage());
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
            throw new QmTmException("시험관리 권한 정보 설정작업 중 오류가 발생되었습니다. [LoginProc.makeAdmin_work()] " + ex.getMessage());
        }
	}
	
	public static LoginProcBean getExam_work(String id_course, String userid, String usergrade) throws QmTmException {
		
		if(userid.equals("qmtm") || usergrade.equals("M")) {
			return makeAdmin_work();
		} else {

		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select pt_exam_edit, pt_exam_delete, pt_answer_edit, pt_score_edit, pt_static_edit, pt_q_edit, pt_q_delete ");
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
			throw new QmTmException("시험관리 권한 정보를 읽어오는 중 오류가 발생되었습니다. [LoginProc.getExam_work] " + ex.getMessage());
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
			bean.setPt_q_edit(rst.getString(6));
			bean.setPt_q_delete(rst.getString(7));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험관리 권한 정보 설정작업 중 오류가 발생되었습니다. [LoginProc.makeExam_work] " + ex.getMessage());
        }
    }

	private static LoginProcBean makeAdmin_work2() throws QmTmException {
		
		try {
            LoginProcBean bean = new LoginProcBean();
            bean.setPt_q_edit("Y");
			bean.setPt_q_delete("Y");
            return bean;
        } catch (Exception ex) {
            throw new QmTmException("문제관리 권한 정보 설정작업 중 오류가 발생되었습니다. [LoginProc.getmakeAdmin_work2] " + ex.getMessage());
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
			throw new QmTmException("문제관리 권한 정보를 읽어오는 중 오류가 발생되었습니다. [LoginProc.getQ_work] " + ex.getMessage());
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
            throw new QmTmException("문제관리 권한 정보 설정작업 중 오류가 발생되었습니다. [LoginProc.makeQ_work] " + ex.getMessage());
        }
    }

	public static String getUseridDecode(String userid) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select userid ");
		sql.append("From qt_workerid ");
		//sql.append("Where userid = DBO.FN_GET_HASHBYTES_VALUE( ? ) ");
		sql.append("Where userid = ? ");

	    try {
	    	cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			rst = stm.executeQuery();
            if (rst.next()) return rst.getString("userid");
            else return null;
        } catch (SQLException ex) {
            throw new QmTmException("복호화된 아이디 정보를 읽어오는 중 오류가 발생되었습니다. [LoginProc.getUseridDecode()] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}
