package qmtm.qman.category;

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

public class SubjectUtil
{
    public SubjectUtil() {
    }
	
	public static void insert(SubjectBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO q_subject (id_q_subject, q_subject, yn_valid, regdate, years, id_course, subject_order) ");
        sql.append("VALUES (?, ?, 'Y', getdate(), ?, ?, ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, bean.getId_subject());
            stm.setString(2, bean.getSubject());
			stm.setString(3, bean.getYears());
			stm.setString(4, bean.getId_course());
			stm.setInt(5, bean.getSubject_order());

			stm.execute();
        }
        catch (SQLException ex) {
			throw new QmTmException("과목 정보 등록하는 중 오류가 발생되었습니다. [SubjectUtil.insert] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static void update(SubjectBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE q_subject SET q_subject = ?, subject_order = ?, yn_valid = ? ");
        sql.append("WHERE id_q_subject = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getSubject());
			stm.setInt(2, bean.getSubject_order());
			stm.setString(3, bean.getYn_valid());
			stm.setString(4, bean.getId_subject());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("과목 정보 수정하는 중 오류가 발생되었습니다. [SubjectUtil.Update] " + ex.getMessage());		
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Delete From q_subject ");
		sql.append("Where id_q_subject = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_subject);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("과목 정보 삭제하는 중 오류가 발생되었습니다. [SubjectUtil.delete] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static SubjectBean[] getBeans(String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Select id_q_subject, q_subject, yn_valid, convert(varchar(16), regdate, 121) regdate, subject_order ");
		sql.append("From q_subject ");
		sql.append("Where id_course = ? ");
		sql.append("Order by subject_order ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_course);
            rst = stm.executeQuery();
            SubjectBean bean = null;
            while (rst.next()) {
                bean = makeBean(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (SubjectBean[]) beans.toArray(new SubjectBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("과목 정보 읽어오는 중 오류가 발생되었습니다. [SubjectUtil.getBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static SubjectBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            SubjectBean bean = new SubjectBean();
            bean.setId_subject(rst.getString(1));
            bean.setSubject(rst.getString(2));
			bean.setYn_valid(rst.getString(3));
			bean.setRegdate(rst.getString(4));
			bean.setSubject_order(rst.getInt(5));            
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("과목 정보 읽어오는 중 오류가 발생되었습니다. [SubjectUtil.makeBean] " + ex.getMessage());
        }
    }

	public static SubjectBean getBean(String id_subject) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select q_subject, yn_valid, subject_order ");
		sql.append("From q_subject ");
		sql.append("Where id_q_subject = ? ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_subject);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBeans(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("[SubjectUtil.getBean] " + ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static SubjectBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            SubjectBean bean = new SubjectBean();
            bean.setSubject(rst.getString(1));			
			bean.setYn_valid(rst.getString(2));
			bean.setSubject_order(rst.getInt(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[SubjectUtil.makeBeans] " + ex.getMessage());
        }
    }

	public static int getCnt(String id_subject) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(id_q_subject) as cnt ");
		sql.append("From q_chapter "); 
		sql.append("Where id_q_subject = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_subject);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("과목 아래 단원 정보 유무 읽어오는 중 오류가 발생되었습니다. [SubjectUtil.getCnt] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static int getOrderCnt(String id_course) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select isnull(max(subject_order),0) + 1 as order_cnt ");
		sql.append("From q_subject "); 
		sql.append("Where id_course = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("order_cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("과목 정렬순서정보 읽어오는 중 오류가 발생되었습니다. [SubjectUtil.getOrderCnt] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

}