package qmtm.admin.etc;

// Package Import
import qmtm.*; 

// Java API Import
import java.sql.*;
import java.util.*;

public class LectureTermUtil
{
    public LectureTermUtil() {
    }
		
	public static LectureTermBean[] getTBeans(String term_id) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select term_id, term_year, term_type_code, term_name, yn_enable ");
		sql.append("From lecture_term ");
		sql.append("Where term_id = ? ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, term_id);
            rst = stm.executeQuery();
            LectureTermBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (LectureTermBean[]) beans.toArray(new LectureTermBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[LectureTermUtil.getTBeans]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static LectureTermBean[] getBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select term_id, term_year, term_type_code, term_name, yn_enable ");
		sql.append("From lecture_term ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            rst = stm.executeQuery();
            LectureTermBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (LectureTermBean[]) beans.toArray(new LectureTermBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[LectureTermUtil.getBeans]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static LectureTermBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            LectureTermBean bean = new LectureTermBean();
            bean.setTerm_id(rst.getString(1));
            bean.setTerm_year(rst.getString(2));
            bean.setTerm_type_code(rst.getString(3));
			bean.setTerm_name(rst.getString(4));
			bean.setYn_enable(rst.getString(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[LectureTermUtil.makeBeans]" + ex.getMessage());
        }
    }
	
	public static String getBean() throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select term_id ");
		sql.append("From lecture_term ");
		sql.append("Where yn_enable = 'Y' ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());            
            rst = stm.executeQuery();

            if (rst.next()) return rst.getString("term_id");
            else return null;
        } catch (SQLException ex) {
            throw new QmTmException("[LectureTermUtil.getBean]" + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static String getTermId(String lecture_id) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select term_id ");
		sql.append("From t_lecture ");
		sql.append("Where lecture_id = ? ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, lecture_id);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getString("term_id");
            else return null;
        } catch (SQLException ex) {
            throw new QmTmException("[LectureTermUtil.getTermId]" + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static String getTermName(String term_id) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select term_name ");
		sql.append("From lecture_term ");
		sql.append("Where term_id = ? ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, term_id);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getString("term_name");
            else return null;
        } catch (SQLException ex) {
            throw new QmTmException("[LectureTermUtil.getTermName]" + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }	
}