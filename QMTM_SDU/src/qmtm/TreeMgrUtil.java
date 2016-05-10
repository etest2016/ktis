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

public class TreeMgrUtil
{
    public TreeMgrUtil() {
    }
	
	// 소영역 정보 가지고오기 (관리자)
	public static TreeMgrBean[] getCategory(String id_category, String aligns) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_midcategory, midcategory, orders, regdate ");
		sql.append("From c_midcategory ");
		sql.append("Where id_category = ? and yn_valid = 'Y' ");
		if(aligns.equals("orders")) {
			sql.append("Order by orders ");
		} else if(aligns.equals("course")) {
			sql.append("Order by midcategory ");
		} else {
			sql.append("Order by regdate ");
		}
				        
		try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_category);

            rst = stm.executeQuery();
            TreeMgrBean bean = null;
            while (rst.next()) {
                bean = makeCategory(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeMgrBean[]) beans.toArray(new TreeMgrBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("소영역 카테고리 정보를 읽어오는 중 오류가 발생되었습니다. [TreeMgrUtil.getCategory()] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }		
    }

	// 소영역 정보 가지고오기 (과정 담당자)
	public static TreeMgrBean[] getCategory(String userid, String id_category, String aligns) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select distinct a.id_midcategory, a.midcategory, a.orders, a.regdate ");
		sql.append("From c_midcategory a, c_course b, t_worker_subj c ");
		sql.append("Where c.userid = ? and a.id_category = ? and a.id_midcategory = b.id_category and b.id_course = c.id_course ");
		if(aligns.equals("orders")) {
			sql.append("Order by a.orders ");
		} else if(aligns.equals("course")) {
			sql.append("Order by a.midcategory ");
		} else {
			sql.append("Order by a.regdate ");
		}
		        
		try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_category);

            rst = stm.executeQuery();
            TreeMgrBean bean = null;
            while (rst.next()) {
                bean = makeCategory(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeMgrBean[]) beans.toArray(new TreeMgrBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("소영역 카테고리 정보를 읽어오는 중 오류가 발생되었습니다. [TreeMgrUtil.getCategory()] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }		
    }
	
	private static TreeMgrBean makeCategory (ResultSet rst) throws QmTmException
    {
		
		try {
            TreeMgrBean bean = new TreeMgrBean();
            bean.setId_midcategory(rst.getString(1));            
            bean.setMidcategory(rst.getString(2));
			bean.setChapter_order(rst.getInt(3));
			bean.setRegdate(rst.getTimestamp(4));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("소영역 정보를 읽어오는 중 오류가 발생되었습니다.  [TreeMgrUtil.makeCategory()] " + ex.getMessage());
        }
    }

	public static TreeMgrBean[] getQmanBean(String id_category, String id_midcategory, String aligns) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT DISTINCT ID_NODE, ID_PARENTNODE, NODE_NAME, NODE_GUBUN, ");
		sql.append("	   REGDATE, CHAPTER_ORDER ");
		sql.append("From TREE_CATEGORY2 ");
		sql.append("WHERE id_category = ? and id_MIDcategory = ? ");
		if(aligns.equals("orders")) {
			sql.append("Order by 6 ");
		} else if(aligns.equals("course")) {
			sql.append("Order by 3 ");
		} else {
			sql.append("Order by 5 ");
		}
				
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());

			stm.setString(1, id_category);
			stm.setString(2, id_midcategory);
				
            rst = stm.executeQuery();
            TreeMgrBean bean = null;
            while (rst.next()) {
                bean = makeQmanBean(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeMgrBean[]) beans.toArray(new TreeMgrBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제관리 카테고리 정보를 읽어오는 중 오류가 발생되었습니다. [TreeMgrUtil.getQmanBean()] " + ex.getMessage());	
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static TreeMgrBean[] getQmanBean(String userid, String id_category, String id_midcategory, String aligns) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
				
		sql.append("SELECT DISTINCT ID_NODE, ID_PARENTNODE, NODE_NAME, NODE_GUBUN, ");
		sql.append("	   REGDATE, CHAPTER_ORDER ");
		sql.append("From TREE_CATEGORY2 ");
		sql.append("WHERE id_category = ? and id_MIDcategory = ? and userid = ? ");
		if(aligns.equals("orders")) {
			sql.append("Order by 6 ");
		} else if(aligns.equals("course")) {
			sql.append("Order by 3 ");
		} else {
			sql.append("Order by 5 ");
		}
				
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			
            stm.setString(1, id_category);
			stm.setString(2, id_midcategory);
			stm.setString(3, userid);
						
            rst = stm.executeQuery();
            TreeMgrBean bean = null;
            while (rst.next()) {
                bean = makeQmanBean(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeMgrBean[]) beans.toArray(new TreeMgrBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제관리 카테고리 정보를 읽어오는 중 오류가 발생되었습니다. [TreeMgrUtil.getQmanBean()] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static TreeMgrBean makeQmanBean (ResultSet rst) throws QmTmException
    {
		try {
            TreeMgrBean bean = new TreeMgrBean();
            bean.setId_node(rst.getString(1));
            bean.setId_parentnode(rst.getString(2));
            bean.setNode_name(rst.getString(3));
			bean.setNode_gubun(rst.getString(4));
			bean.setRegdate(rst.getTimestamp(5));
			bean.setChapter_order(rst.getInt(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("카테고리 정보를 읽어오는 중 오류가 발생되었습니다. [TreeMgrUtil.makeQmanBean()] " + ex.getMessage());
        }
    }

	public static TreeMgrBean[] getTmanBean(String id_category, String id_midcategory, String aligns) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT DISTINCT ID_NODE, ID_PARENTNODE, NODE_NAME, NODE_GUBUN, ");
		sql.append("	   REGDATE, CHAPTER_ORDER, TERMS ");
		sql.append("FROM TREE_CATEGORY ");
		sql.append("WHERE id_category = ? and id_MIDcategory = ? ");
						
		if(aligns.equals("orders")) {
			sql.append("Order by 6 ");
		} else if(aligns.equals("course")) {
			sql.append("Order by 3 ");
		} else {
			sql.append("Order by 5 ");
		}
				
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_category);
			stm.setString(2, id_midcategory);
						
            rst = stm.executeQuery();
            TreeMgrBean bean = null;
            while (rst.next()) {
                bean = makeTmanBean(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeMgrBean[]) beans.toArray(new TreeMgrBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 카테고리 정보를 읽어오는 중 오류가 발생되었습니다. [TreeMgrUtil.getTmanBean()] " + ex.getMessage());	
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static TreeMgrBean[] getTmanBean(String userid, String id_category, String id_midcategory, String aligns) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT DISTINCT ID_NODE, ID_PARENTNODE, NODE_NAME, NODE_GUBUN, ");
		sql.append("	   REGDATE, CHAPTER_ORDER, TERMS ");
		sql.append("FROM TREE_CATEGORY ");
		sql.append("WHERE id_category = ? and id_MIDcategory = ? and userid = ? ");
				
		if(aligns.equals("orders")) {
			sql.append("Order by 6 ");
		} else if(aligns.equals("course")) {
			sql.append("Order by 3 ");
		} else {
			sql.append("Order by 5 ");
		}
				
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			
			stm.setString(1, id_category);
			stm.setString(2, id_midcategory);
			stm.setString(3, userid);
									
            rst = stm.executeQuery();
            TreeMgrBean bean = null;
            while (rst.next()) {
                bean = makeTmanBean(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeMgrBean[]) beans.toArray(new TreeMgrBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 카테고리 정보를 읽어오는 중 오류가 발생되었습니다. [TreeMgrUtil.getTmanBean()] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static TreeMgrBean makeTmanBean (ResultSet rst) throws QmTmException
    {
		try {
            TreeMgrBean bean = new TreeMgrBean();
            bean.setId_node(rst.getString(1));
            bean.setId_parentnode(rst.getString(2));
            bean.setNode_name(rst.getString(3));
			bean.setNode_gubun(rst.getString(4));
			bean.setRegdate(rst.getTimestamp(5));
			bean.setChapter_order(rst.getInt(6));
			bean.setTerms(rst.getString(7));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("카테고리 정보를 읽어오는 중 오류가 발생되었습니다. [TreeMgrUtil.makeTmanBean()] " + ex.getMessage());
        }
    }

}