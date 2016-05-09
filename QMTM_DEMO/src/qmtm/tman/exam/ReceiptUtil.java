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

public class ReceiptUtil
{
    public ReceiptUtil() {
    }
	
	public static ReceiptBean[] getBeans(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		//sql.append("Select a.userid, a.password, a.name, a.sosok1, a.sosok2, convert(varchar(16), a.regdate, 120) regdate ");
		sql.append("Select a.userid, a.password, a.name, a.sosok1, a.sosok2, to_char(a.regdate, 'YYYY-MM-DD HH24:MI') regdate ");
		sql.append("From qt_userid a, exam_receipt b ");
		sql.append("Where b.id_exam = ? and a.userid = b.userid ");
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
            throw new QmTmException("접수 인원 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ReceiptUtil.getBeans]");
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
			bean.setSosok2(rst.getString(5));
            bean.setRegdate(rst.getString(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("접수 인원 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ReceiptUtil.makeBeans]");
        }
    }
	
	public static void deleteMember(String id_exam, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Delete From exam_receipt Where id_exam = ? and userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, userid);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("대상자정보 삭제 중 인터넷 연결상태가 좋지 않습니다. [ReceiptUtil.deleteMember]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static void getMCnt(String id_exam, String userid, ReceiptBean rb) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		int results = 0;

		sql = "Select count(userid) as cnt from qt_userid Where userid = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, userid);

            rst = stm.executeQuery();
            if (rst.next()) { results = rst.getInt("cnt"); }

			if(results > 0) {
				updateMember(id_exam, userid, rb);
			} else {
				insertMember(id_exam, userid, rb);
			}

        } catch (SQLException ex) {
            throw new QmTmException("회원 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ReceiptUtil.getMCnt]");
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

        sql.append("INSERT INTO qt_userid(userid, password, name, sosok1, sosok2, regdate) ");
        sql.append("VALUES (?, ?, ?, ?, ?, now()) ");
        //sql.append("VALUES (?, ?, ?, ?, ?, getdate()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
			stm.setString(2, bean.getPassword());			
			stm.setString(3, bean.getName());
			stm.setString(4, bean.getSosok1());
			stm.setString(5, bean.getSosok2());

			stm.execute();

			getECnt(id_exam, userid);
        }
        catch (SQLException ex) {
            throw new QmTmException("회원정보 등록 중 인터넷 연결상태가 좋지 않습니다. [ReceiptUtil.insertMember]");			
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

        //sql.append("UPDATE qt_userid SET password = ?, name = ?, sosok1 = ?, sosok2 = ?, regdate = getdate() ");
		sql.append("UPDATE qt_userid SET password = ?, name = ?, sosok1 = ?, sosok2 = ?, regdate = now() ");
		sql.append("Where userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getPassword());
			stm.setString(2, bean.getName());
			stm.setString(3, bean.getSosok1());
			stm.setString(4, bean.getSosok2());
			stm.setString(5, userid);

			stm.execute();

			getECnt(id_exam, userid);
        }
        catch (SQLException ex) {
            throw new QmTmException("회원정보 수정 중 인터넷 연결상태가 좋지 않습니다. [ReceiptUtil.updateMember]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void getECnt(String id_exam, String userid) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		int results = 0;

		sql = "Select count(userid) as cnt from exam_receipt Where id_exam = ? and userid = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);
			stm.setString(2, userid);

            rst = stm.executeQuery();
            if (rst.next()) { results = rst.getInt("cnt"); }

			if(results > 0) { 
				updateExamReceipt(id_exam, userid);
			} else {
				insertExamReceipt(id_exam, userid);
			}
        } catch (SQLException ex) {
            throw new QmTmException("시험접수인원 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ReceiptUtil.getECnt]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void insertExamReceipt(String id_exam, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO exam_receipt(id_exam, userid, yn_pay, receipt_date) ");
        sql.append("VALUES (?, ?, 'Y', now()) ");
        //sql.append("VALUES (?, ?, 'Y', getdate()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, userid);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("접수테이블 등록 중 인터넷 연결상태가 좋지 않습니다. [ReceiptUtil.insertExamReceipt]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void updateExamReceipt(String id_exam, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        //sql.append("UPDATE exam_receipt SET receipt_date = getdate() ");
		sql.append("UPDATE exam_receipt SET receipt_date = now() ");
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
            throw new QmTmException("접수테이블 수정 중 인터넷 연결상태가 좋지 않습니다. [ReceiptUtil.updateExamReceipt]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

}