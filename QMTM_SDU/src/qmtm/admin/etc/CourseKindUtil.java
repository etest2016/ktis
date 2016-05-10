package qmtm.admin.etc;

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

public class CourseKindUtil
{
    public CourseKindUtil() {  
    }
	
	public static void insert(CourseKindBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO C_COURSE (id_course, course, regdate, yn_valid, id_category, years, orders) ");
        sql.append("VALUES (?, ?, getdate(), 'Y', ?, ?, ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_course());
            stm.setString(2, bean.getCourse());
			stm.setString(3, bean.getId_midcategory());
			stm.setString(4, bean.getYears());
			stm.setInt(5, bean.getOrders());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("과정 등록작업 중 오류가 발생되었습니다. [CourseKindUtil.insert()] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(CourseKindBean bean, String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update c_course SET course = ?, yn_valid = ?, id_category = ?, orders = ? ");
        sql.append("Where id_course = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getCourse());
			stm.setString(2, bean.getYn_valid());
			stm.setString(3, bean.getId_midcategory());
			stm.setInt(4, bean.getOrders());
			stm.setString(5, id_course);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("과정 수정작업 중 오류가 발생되었습니다. [CourseKindUtil.update()] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Delete From c_course ");
		sql.append("Where id_course = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_course);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("과정 삭제작업 중 오류가 발생되었습니다. [CourseKindUtil.delete()] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static CourseKindBean[] getBeans(String id_midcategory) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_course, a.course, a.yn_valid, convert(varchar(16), a.regdate, 120) regdate, a.orders, b.midcategory, c.category ");
		sql.append("FROM c_course a, c_midcategory b, c_category c ");
		sql.append("Where b.id_midcategory = ? and a.id_category = b.id_midcategory and b.id_category = c.id_category ");	
		sql.append("Order by a.course ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_midcategory);
            rst = stm.executeQuery();
            CourseKindBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (CourseKindBean[]) beans.toArray(new CourseKindBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("과정 정보 읽어오는 중 오류가 발생되었습니다. [CourseKindUtil.getBeans()] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static CourseKindBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            CourseKindBean bean = new CourseKindBean();
            bean.setId_course(rst.getString(1));
            bean.setCourse(rst.getString(2));
			bean.setYn_valid(rst.getString(3));
            bean.setRegdate(rst.getString(4));
		    bean.setOrders(rst.getInt(5));
			bean.setMidcategory(rst.getString(6));
			bean.setCategory(rst.getString(7));			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("과정 정보 읽어오는 중 오류가 발생되었습니다. [CourseKindUtil.makeBeans()] " + ex.getMessage());
        }
    }

	public static CourseKindBean[] getBeansAll() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_course, a.course, a.yn_valid, convert(varchar(16), a.regdate, 120) regdate, a.orders, b.id_midcategory, b.midcategory, c.id_category, c.category ");
		sql.append("FROM c_course a, c_midcategory b, c_category c ");
		sql.append("Where a.id_category = b.id_midcategory and b.id_category = c.id_category ");	
		sql.append("Order by c.category, b.midcategory, a.course ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            rst = stm.executeQuery();
            CourseKindBean bean = null;
            while (rst.next()) {
                bean = makeBeansAll(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (CourseKindBean[]) beans.toArray(new CourseKindBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("전체과정 정보 읽어오는 중 오류가 발생되었습니다. [CourseKindUtil.getBeansAll()] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static CourseKindBean makeBeansAll (ResultSet rst) throws QmTmException
    {
		
		try {
            CourseKindBean bean = new CourseKindBean();
            bean.setId_course(rst.getString(1));
            bean.setCourse(rst.getString(2));
			bean.setYn_valid(rst.getString(3));
            bean.setRegdate(rst.getString(4));
		    bean.setOrders(rst.getInt(5));
			bean.setId_midcategory(rst.getString(6));
			bean.setMidcategory(rst.getString(7));
			bean.setId_category(rst.getString(8));
			bean.setCategory(rst.getString(9));			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("과정 정보 읽어오는 중 오류가 발생되었습니다. [CourseKindUtil.makeBeans()] " + ex.getMessage());
        }
    }

	public static CourseKindBean getBean(String id_midcategory, String id_course) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.course, a.yn_valid, convert(varchar(16), a.regdate, 120) regdate, a.orders, b.midcategory, c.category ");
		sql.append("From c_course a, c_midcategory b, c_category c ");
		sql.append("Where a.id_course = ? and b.id_midcategory = ? and a.id_category = b.id_midcategory and b.id_category = c.id_category ");	

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_course);
			stm.setString(2, id_midcategory);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("과정 정보 읽어오는 중 오류가 발생되었습니다. [CourseKindUtil.getBean()] " + ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static CourseKindBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            CourseKindBean bean = new CourseKindBean();
            bean.setCourse(rst.getString(1));
			bean.setYn_valid(rst.getString(2));
            bean.setRegdate(rst.getString(3));
		    bean.setOrders(rst.getInt(4));
			bean.setMidcategory(rst.getString(5));
			bean.setCategory(rst.getString(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("과정 정보 읽어오는 중 오류가 발생되었습니다. [CourseKindUtil.makeBean()] " + ex.getMessage());
        }
    }

	public static int getOrderCnt(String id_midcategory) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select isnull(max(orders),0) + 1 as order_cnt ");
		sql.append("From c_course "); 
		sql.append("Where id_category = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_midcategory);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("order_cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("과정 정렬순서정보 읽어오는 중 오류가 발생되었습니다. [CourseKindUtil.getOrderCnt] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static boolean getDownCnt(String id_course) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_q_subject ");
		sql.append("From q_subject ");
		sql.append("Where id_course = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);

            rst = stm.executeQuery();
            if (rst.next()) { return false; }
            else { return true; }
        } catch (SQLException ex) {
            throw new QmTmException("과정아래 과목 정보를 읽어오는 중 오류가 발생되었습니다. [CourseKindUtil.getDownCnt] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

}