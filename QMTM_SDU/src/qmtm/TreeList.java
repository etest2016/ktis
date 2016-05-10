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

public class TreeList
{
    public TreeList() {
    }
	
    public static TreeBean[] getAdmCosBeans(String course_year, String course_no, String aligns) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select distinct c.id_course as id_node, ");
		sql.append("                '0' as id_parentnode, ");
		sql.append("                c.course as node_name, "); 
		sql.append("                'C1' as node_gubun, ");
		sql.append("                c.regdate, ");
		sql.append("                1 as chapter_order ");
		sql.append("From c_course_no cc inner join c_course c on cc.id_course = c.id_course ");
		sql.append("Where cc.course_year = ? and cc.course_no = ? ");	
		
		if(aligns.equals("regdate")) {
			sql.append("Order by 5 desc ");
		} else if(aligns.equals("course")) {
			sql.append("Order by 3 asc  ");
		} else if(aligns.equals("orders")) {
			sql.append("Order by 6 asc  ");
		}
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, course_year);
			stm.setString(2, course_no);			
            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[시험관리 카테고리 정보를 읽어오는 중 오류가 발생되었습니다. TreeList.getAdmCosBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
    
    public static TreeBean[] getCosBeans(String id_group, String course_year, String course_no, String aligns) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select distinct c.id_course as id_node, ");
		sql.append("                '0' as id_parentnode, ");
		sql.append("                c.course as node_name, "); 
		sql.append("                'C1' as node_gubun, ");
		sql.append("                c.regdate, ");
		sql.append("                1 as chapter_order ");
		sql.append("From c_course_no cc inner join c_course c on cc.id_course = c.id_course ");
		sql.append("     inner join t_group_subject tg on cc.id_course = tg.id_course and c.id_course = tg.id_course ");
		sql.append("Where cc.course_year = ? and cc.course_no = ? and tg.id_group = ? ");	
		
		if(aligns.equals("regdate")) {
			sql.append("Order by 5 desc ");
		} else if(aligns.equals("course")) {
			sql.append("Order by 3 asc  ");
		} else if(aligns.equals("orders")) {
			sql.append("Order by 6 asc  ");
		}
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, course_year);
			stm.setString(2, course_no);			
			stm.setString(3, id_group);			
            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[시험관리 카테고리 정보를 읽어오는 중 오류가 발생되었습니다. TreeList.getCosBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
    
    public static TreeBean[] getAdmExamBeans(String course_year, String course_no, String aligns, String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select distinct c.id_course as id_node, ");
		sql.append("                '0' as id_parentnode, ");
		sql.append("                c.course as node_name, "); 
		sql.append("                'C1' as node_gubun, ");
		sql.append("                c.regdate, ");
		sql.append("                1 as chapter_order ");
		sql.append("From c_course_no cc inner join c_course c on cc.id_course = c.id_course ");
		sql.append("Where cc.course_year = ? and cc.course_no = ? and c.id_course = ? ");
		sql.append("Union All ");
		sql.append("Select em.id_exam as id_node, ");
		sql.append("       em.id_course as id_parentnode, "); 
		sql.append("       em.title as node_name, "); 
		sql.append("       'E1' as node_gubun, "); 
		sql.append("       em.regdate, "); 
		sql.append("       1 as chapter_order "); 
		sql.append("From c_course_no cc inner join exam_m em on cc.id_course = em.id_course and cc.course_year = em.course_year and cc.course_no = em.course_no "); 
		sql.append("Where cc.course_year = ? and cc.course_no = ? and em.id_course = ? ");				 
		
		if(aligns.equals("regdate")) {
			sql.append("Order by 5 desc ");
		} else if(aligns.equals("course")) {
			sql.append("Order by 3 asc  ");
		} else if(aligns.equals("orders")) {
			sql.append("Order by 6 asc  ");
		}
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, course_year);
			stm.setString(2, course_no);			
			stm.setString(3, id_subject);
			stm.setString(4, course_year);
			stm.setString(5, course_no);			
			stm.setString(6, id_subject);
            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[시험관리 카테고리 정보를 읽어오는 중 오류가 발생되었습니다. TreeList.getAdmExamBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
    
    public static TreeBean[] getExamBeans(String id_group, String course_year, String course_no, String aligns, String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select distinct c.id_course as id_node, ");
		sql.append("                '0' as id_parentnode, ");
		sql.append("                c.course as node_name, "); 
		sql.append("                'C1' as node_gubun, ");
		sql.append("                c.regdate, ");
		sql.append("                1 as chapter_order ");
		sql.append("From c_course_no cc inner join c_course c on cc.id_course = c.id_course ");
		sql.append("     inner join t_group_subject tg on cc.id_course = tg.id_course and c.id_course = tg.id_course ");
		sql.append("Where cc.course_year = ? and cc.course_no = ? and tg.id_group = ? and c.id_course = ? ");
		sql.append("Union All ");
		sql.append("Select em.id_exam as id_node, ");
		sql.append("       em.id_course as id_parentnode, "); 
		sql.append("       em.title as node_name, "); 
		sql.append("       'E1' as node_gubun, "); 
		sql.append("       em.regdate, "); 
		sql.append("       1 as chapter_order "); 
		sql.append("From c_course_no cc inner join exam_m em on cc.id_course = em.id_course and cc.course_year = em.course_year and cc.course_no = em.course_no ");
		sql.append("     inner join t_group_subject tg on cc.id_course = tg.id_course and em.id_course = tg.id_course ");
		sql.append("Where cc.course_year = ? and cc.course_no = ? and tg.id_group = ? and em.id_course = ? ");
		
		if(aligns.equals("regdate")) {
			sql.append("Order by 5 desc ");
		} else if(aligns.equals("course")) {
			sql.append("Order by 3 asc  ");
		} else if(aligns.equals("orders")) {
			sql.append("Order by 6 asc  ");
		}
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, course_year);
			stm.setString(2, course_no);			
			stm.setString(3, id_group);
			stm.setString(4, id_subject);
			stm.setString(5, course_year);
			stm.setString(6, course_no);			
			stm.setString(7, id_group);
			stm.setString(8, id_subject);
            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[시험관리 카테고리 정보를 읽어오는 중 오류가 발생되었습니다. TreeList.getExamBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    
    public static TreeBean[] getAdmSubjBeans(String course_year, String course_no, String aligns) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select distinct qs.id_q_subject as id_node, ");
		sql.append("                '0' as id_parentnode, ");
		sql.append("                qs.q_subject as node_name, "); 
		sql.append("                'S1' as node_gubun, ");
		sql.append("                qs.regdate, ");
		sql.append("                1 as chapter_order ");
		sql.append("From c_course_no cc inner join q_subject qs on cc.id_course = qs.id_q_subject ");
		sql.append("Where cc.course_year = ? and cc.course_no = ? ");	
		
		if(aligns.equals("regdate")) {
			sql.append("Order by 5 desc ");
		} else if(aligns.equals("course")) {
			sql.append("Order by 3 asc  ");
		} else if(aligns.equals("orders")) {
			sql.append("Order by 6 asc  ");
		}
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, course_year);
			stm.setString(2, course_no);			
            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[문제관리 카테고리 정보를 읽어오는 중 오류가 발생되었습니다. TreeList.getAdmSubjBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
    
    public static TreeBean[] getSubjBeans(String id_group, String course_year, String course_no, String aligns) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select distinct qs.id_q_subject as id_node, ");
		sql.append("                '0' as id_parentnode, ");
		sql.append("                qs.q_subject as node_name, "); 
		sql.append("                'S1' as node_gubun, ");
		sql.append("                qs.regdate, ");
		sql.append("                1 as chapter_order ");
		sql.append("From c_course_no cc inner join q_subject qs on cc.id_course = qs.id_q_subject ");
		sql.append("     inner join t_group_subject tg on cc.id_course = tg.id_course and qs.id_q_subject = tg.id_course ");
		sql.append("Where cc.course_year = ? and cc.course_no = ? and tg.id_group = ? ");	
		
		if(aligns.equals("regdate")) {
			sql.append("Order by 5 desc ");
		} else if(aligns.equals("course")) {
			sql.append("Order by 3 asc  ");
		} else if(aligns.equals("orders")) {
			sql.append("Order by 6 asc  ");
		}
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, course_year);
			stm.setString(2, course_no);			
			stm.setString(3, id_group);			
            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[문제관리 카테고리 정보를 읽어오는 중 오류가 발생되었습니다. TreeList.getSubjBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	private static TreeBean makeBeans(ResultSet rst) throws QmTmException
    {
		
		try {
            TreeBean bean = new TreeBean();
            bean.setId_node(rst.getString(1));
            bean.setId_parentnode(rst.getString(2));
            bean.setNode_name(rst.getString(3));
			bean.setNode_gubun(rst.getString(4));
			bean.setRegdate(rst.getTimestamp(5));
			bean.setChapter_order(rst.getInt(6));
            return bean;
        } catch (SQLException ex) {
        	throw new QmTmException("[문제관리 카테고리 정보를 읽어오는 중 오류가 발생되었습니다. TreeList.makeBeans] " + ex.getMessage());
        }
    }
	
	public static TreeBean[] getAdmCptBeans(String course_year, String course_no, String aligns, String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select distinct qs.id_q_subject as id_node, ");
		sql.append("                '0' as id_parentnode, ");
		sql.append("                qs.q_subject as node_name, "); 
		sql.append("                'S1' as node_gubun, ");
		sql.append("                qs.regdate, ");
		sql.append("                1 as chapter_order ");
		sql.append("From c_course_no cc inner join q_subject qs on cc.id_course = qs.id_q_subject ");
		sql.append("Where cc.course_year = ? and cc.course_no = ? and qs.id_q_subject = ? ");
		sql.append("Union All ");
		sql.append("Select qc.id_q_chapter as id_node, ");
		sql.append("       qc.id_q_subject as id_parentnode, "); 
		sql.append("       qc.chapter as node_name, "); 
		sql.append("       'U1' as node_gubun, "); 
		sql.append("       qc.regdate, "); 
		sql.append("       qc.chapter_order "); 
		sql.append("From c_course_no cc inner join q_chapter qc on cc.id_course = qc.id_q_subject "); 
		sql.append("Where cc.course_year = ? and cc.course_no = ? and qc.id_q_subject = ? ");				 
		
		if(aligns.equals("regdate")) {
			sql.append("Order by 5 desc ");
		} else if(aligns.equals("course")) {
			sql.append("Order by 3 asc  ");
		} else if(aligns.equals("orders")) {
			sql.append("Order by 6 asc  ");
		}
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, course_year);
			stm.setString(2, course_no);			
			stm.setString(3, id_subject);
			stm.setString(4, course_year);
			stm.setString(5, course_no);			
			stm.setString(6, id_subject);
            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[문제관리 카테고리 정보를 읽어오는 중 오류가 발생되었습니다. TreeList.getAdmCptBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
    
    public static TreeBean[] getCptBeans(String id_group, String course_year, String course_no, String aligns, String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select distinct qs.id_q_subject as id_node, ");
		sql.append("                '0' as id_parentnode, ");
		sql.append("                qs.q_subject as node_name, "); 
		sql.append("                'S1' as node_gubun, ");
		sql.append("                qs.regdate, ");
		sql.append("                1 as chapter_order ");
		sql.append("From c_course_no cc inner join q_subject qs on cc.id_course = qs.id_q_subject ");
		sql.append("     inner join t_group_subject tg on cc.id_course = tg.id_course and qs.id_q_subject = tg.id_course ");
		sql.append("Where cc.course_year = ? and cc.course_no = ? and tg.id_group = ? and qs.id_q_subject = ? ");
		sql.append("Union All ");
		sql.append("Select qc.id_q_chapter as id_node, ");
		sql.append("       qc.id_q_subject as id_parentnode, "); 
		sql.append("       qc.chapter as node_name, "); 
		sql.append("       'U1' as node_gubun, "); 
		sql.append("       qc.regdate, "); 
		sql.append("       qc.chapter_order "); 
		sql.append("From c_course_no cc inner join q_chapter qc on cc.id_course = qc.id_q_subject "); 
		sql.append("     inner join t_group_subject tg on cc.id_course = tg.id_course and qc.id_q_subject = tg.id_course ");
		sql.append("Where cc.course_year = ? and cc.course_no = ? and tg.id_group = ? and qc.id_q_subject = ? ");
		
		if(aligns.equals("regdate")) {
			sql.append("Order by 5 desc ");
		} else if(aligns.equals("course")) {
			sql.append("Order by 3 asc  ");
		} else if(aligns.equals("orders")) {
			sql.append("Order by 6 asc  ");
		}
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, course_year);
			stm.setString(2, course_no);			
			stm.setString(3, id_group);
			stm.setString(4, id_subject);
			stm.setString(5, course_year);
			stm.setString(6, course_no);			
			stm.setString(7, id_group);
			stm.setString(8, id_subject);
            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[문제관리 카테고리 정보를 읽어오는 중 오류가 발생되었습니다. TreeList.getCptBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

}