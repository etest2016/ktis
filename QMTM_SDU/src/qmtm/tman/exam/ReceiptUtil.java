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

public class ReceiptUtil
{
    public ReceiptUtil() {
    }
		 
	public static ReceiptBean[] getBeans(String id_exam, String field, String str) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.userid, a.password, a.name, b.sosok1, convert(varchar(16), a.regdate, 120) regdate ");
		sql.append("From qt_userid a, exam_receipt b ");
		sql.append("Where b.id_exam = ? and a.userid = b.userid ");
		if(field.equals("") || field == null) {
		} else {
			sql.append("  and " + field + " like '%" + str + "%' ");
		}
		
		sql.append("Order by a.name ");

        try
        {
            Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			
			rst = stm.executeQuery();
            
            ReceiptBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ReceiptBean[]) beans.toArray(new ReceiptBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("대상 인원 정보 읽어오는 중 오류가 발생되었습니다. [ReceiptUtil.getBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static ReceiptBean[] getBeans2(String id_exam, String field, String str) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();		
		
		sql.append("Select a.userid, a.password, a.name, a.sosok1, convert(varchar(16), a.regdate, 120) regdate ");
		sql.append("From qt_userid a, exam_m b, qt_course_user c ");
		sql.append("Where b.id_exam = ? and a.userid = c.userid and b.id_course = c.id_course and ");
		sql.append("          b.course_year = c.course_year and b.course_no = c.course_no ");
		if(field.equals("") || field == null) {
		} else {
			sql.append("  and " + field + " like '%" + str + "%' ");
		}
		sql.append("Order by a.name ");

		//System.out.println(sql.toString());
		
        try
        {
            Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			
			rst = stm.executeQuery();
            
            ReceiptBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ReceiptBean[]) beans.toArray(new ReceiptBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("대상 인원 정보 읽어오는 중 오류가 발생되었습니다. [ReceiptUtil.getBeans2] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static ReceiptBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            ReceiptBean bean = new ReceiptBean();
			bean.setUserid(rst.getString(1));
            bean.setPassword(rst.getString(2));
			bean.setName(rst.getString(3));			
			bean.setSosok1(rst.getString(4));
            bean.setRegdate(rst.getString(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("대상 인원 정보 읽어오는 중 오류가 발생되었습니다. [ReceiptUtil.makeBeans] " + ex.getMessage());
        }
    }

	public static ReceiptBean[] getSearch(String id_exam, String field, String str) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select userid, name, sosok1 ");
		sql.append("From qt_userid ");
		sql.append("Where " + field + " like '%'+?+'%' and userid not in ");
		sql.append("(Select userid ");
		sql.append(" From exam_receipt ");
		sql.append(" Where id_exam = ?) ");
		sql.append("Order by name ");

        try
        {
            Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, str);
			stm.setString(2, id_exam);
			rst = stm.executeQuery();
            
            ReceiptBean bean = null;
            while (rst.next()) {
                bean = makeSearch(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ReceiptBean[]) beans.toArray(new ReceiptBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("회원 정보 읽어오는 중 오류가 발생되었습니다. [ReceiptUtil.getSearch] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
    private static ReceiptBean makeSearch (ResultSet rst) throws QmTmException
    {
		
		try {
            ReceiptBean bean = new ReceiptBean();
			bean.setUserid(rst.getString(1));
			bean.setName(rst.getString(2));
			bean.setSosok1(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("회원 정보 읽어오는 중 오류가 발생되었습니다. [ReceiptUtil.makeSearch] " + ex.getMessage());
        }
    }

	public static ReceiptBean getBean(String id_exam, String userid) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.userid, a.password, a.name, a.email, a.home_phone, a.mobile_phone, b.sosok1, convert(varchar(16), a.regdate, 120) regdate ");
		sql.append("From qt_userid a, exam_receipt b ");
		sql.append("Where b.id_exam = ? and a.userid = ? and a.userid = b.userid ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setString(2, userid);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("대상 인원 정보 읽어오는 중 오류가 발생되었습니다. [ReceiptUtil.getBean] " + ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static ReceiptBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            ReceiptBean bean = new ReceiptBean();
			bean.setUserid(rst.getString(1));
            bean.setPassword(rst.getString(2));
			bean.setName(rst.getString(3));
			bean.setEmail(rst.getString(4));
			bean.setHome_phone(rst.getString(5));
			bean.setMobile_phone(rst.getString(6));
			bean.setSosok1(rst.getString(7));
            bean.setRegdate(rst.getString(8));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("대상 인원 정보 읽어오는 중 오류가 발생되었습니다. [ReceiptUtil.makeBean] " + ex.getMessage());
        }
    }
	
	public static void deleteMember(String id_exam, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Delete From exam_receipt ");
		sql.append("Where id_exam = ? and userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, userid);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("대상자정보 삭제 중 오류가 발생되었습니다. [ReceiptUtil.deleteMember] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static void getMCnt(String id_exam, String userid, ReceiptBean rb) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		int results = 0;

		sql.append("Select count(userid) as cnt ");
		sql.append("From qt_userid ");
		sql.append("Where userid = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);

            rst = stm.executeQuery();
            if (rst.next()) { results = rst.getInt("cnt"); }

			if(results > 0) {
				updateMember(id_exam, userid, rb);
			} else {
				insertMember(id_exam, userid, rb);
			}

        } catch (SQLException ex) {
            throw new QmTmException("회원 정보 읽어오는 중 오류가 발생되었습니다. [ReceiptUtil.getMCnt] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
	public static void insertMember(String id_exam, String userid, ReceiptBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO qt_userid(userid, password, name, sosok1, regdate) ");
        sql.append("VALUES (?, PWDENCRYPT(?), ?, ?, getdate()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
			stm.setString(2, bean.getPassword());			
			stm.setString(3, bean.getName());
			stm.setString(4, bean.getSosok1());

			stm.execute();

			getECnt(id_exam, userid, bean.getSosok1());
        }
        catch (SQLException ex) {
            throw new QmTmException("회원정보 등록 중 오류가 발생되었습니다. [ReceiptUtil.insertMember] " + ex.getMessage());	
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
		
	public static void updateMember(String id_exam, String userid, ReceiptBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE qt_userid ");
		sql.append("       SET name = ?, sosok1 = ? ");
		sql.append("Where userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());            
			stm.setString(1, bean.getName());			
			stm.setString(2, bean.getSosok1());
			stm.setString(3, userid);

			stm.execute();

			getECnt(id_exam, userid, bean.getSosok1());
        }
        catch (SQLException ex) {
            throw new QmTmException("회원정보 수정 중 오류가 발생되었습니다. [ReceiptUtil.updateMember] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void memberReg(String id_exam, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Insert into exam_receipt(id_exam, userid, yn_pay, receipt_date, sosok1) ");
		sql.append("Select ?, userid, 'Y', getdate(), sosok1 ");
		sql.append("From qt_userid ");
		sql.append("Where userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, userid);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("대상자정보 입력하는 중 오류가 발생되었습니다. [ReceiptUtil.memberReg] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void getECnt(String id_exam, String userid, String sosok1) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		int results = 0;

		sql.append("Select count(userid) as cnt ");
		sql.append("From exam_receipt ");
		sql.append("Where id_exam = ? and userid = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, userid);

            rst = stm.executeQuery();
            if (rst.next()) { results = rst.getInt("cnt"); }

			if(results > 0) { 
				updateExamReceipt(id_exam, userid, sosok1);
			} else {
				insertExamReceipt(id_exam, userid, sosok1);
			}
        } catch (SQLException ex) {
            throw new QmTmException("시험대상인원 정보 읽어오는 중 오류가 발생되었습니다. [ReceiptUtil.getECnt] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void insertExamReceipt(String id_exam, String userid, String sosok1) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO exam_receipt(id_exam, userid, yn_pay, receipt_date, sosok1) ");
        sql.append("VALUES (?, ?, 'Y', getdate(), ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, userid);
			stm.setString(3, sosok1);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("대상자 테이블 등록 중 오류가 발생되었습니다. [ReceiptUtil.insertExamReceipt] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void updateExamReceipt(String id_exam, String userid, String sosok1) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE exam_receipt ");
		sql.append("       SET receipt_date = getdate(), sosok1 = ? ");
		sql.append("Where id_exam = ? and userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, sosok1);
			stm.setString(2, id_exam);
			stm.setString(3, userid);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("대상자 테이블 수정 중 오류가 발생되었습니다. [ReceiptUtil.updateExamReceipt] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static String getIdChk(String input_id) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select userid ");
		sql.append("From qt_userid ");
		sql.append("Where userid = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, input_id);

            rst = stm.executeQuery();
            if (rst.next()) { return "true"; }
            else { return "false"; }
        } catch (SQLException ex) {
            throw new QmTmException("회원 아이디 중복 체크작업 중 오류가 발생되었습니다. [ReceiptUtil.getIdChk] " +ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
	public static void receiptImport(String id_course, String id_subject, String course_year, String course_no) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Delete From qt_course_user ");
		sql.append("Where id_course = ? and id_subject = ? and course_year = ? and course_no = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);
			stm.setString(2, id_subject);
			stm.setString(3, course_year);
			stm.setString(4, course_no);

			stm.execute();
			
			receiptImport_res(id_course, id_subject, course_year, course_no);
        }
        catch (SQLException ex) {
            throw new QmTmException("과정대상자정보 Import하는 중 오류가 발생되었습니다. [ReceiptUtil.receiptImport] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	
	public static void receiptImport_res(String id_course, String id_subject, String course_year, String course_no) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Insert into qt_course_user ");
		sql.append("SELECT CONVERT(VARCHAR(30),B.CURRICULUM_REVISION_ID), CONVERT(VARCHAR(30),B.TRAINING_COURSE_SEQS_ID), ");
		sql.append("       '20'+B.TRAINING_YYYY, B.CURRICULUM_SEQS, '-1', A.TRAINING_MEMBERSHIP_ID_NO, 'Y', GETDATE() "); 
		sql.append("FROM TB_EDUC_COURSE_SEQS_APPLY_M A, TB_EDUC_COURSE_SEQS_M B, TB_EDUC_COURSE_M C "); 
		sql.append("WHERE A.TRAINING_COURSE_SEQS_ID = B.TRAINING_COURSE_SEQS_ID AND A.CONFIRM_STATUS_CODE = 'C' AND ");
		sql.append("      B.CURRICULUM_REVISION_ID = C.CURRICULUM_REVISION_ID AND B.CURRICULUM_ID = C.CURRICULUM_ID AND ");
		sql.append("      C.TRAINING_EVALUATION_USE_FLAG = 'Y' AND B.TRAINING_YYYY >= '13' AND ");
		sql.append("      B.CURRICULUM_REVISION_ID = ? AND A.TRAINING_COURSE_SEQS_ID = ? AND ");
		sql.append("      '20'+B.TRAINING_YYYY = ? AND B.CURRICULUM_SEQS = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);
			stm.setString(2, id_subject);
			stm.setString(3, course_year);
			stm.setString(4, course_no);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("과정대상자정보 Import하는 중 오류가 발생되었습니다. [ReceiptUtil.receiptImport_res] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

}