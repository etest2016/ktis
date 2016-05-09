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

	
	// Tman 전체 관리자일 경우
	public static TreeBean[] getTBeans(String userid, String years, String id_category, String aligns, String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_course, '0', course, 'C1', regdate, '1' as orders From c_course ");
		sql.append("Where yn_valid = 'Y' and id_category = ? and years = ? and id_course = ? ");
		sql.append("Union all ");
		sql.append("Select id_subject, id_course, subject, 'S1', regdate, '2' as orders From c_subject Where yn_valid = 'Y' ");
		sql.append("Union all ");
		sql.append("Select id_exam, id_course, title, 'E1', regdate, '3' as orders From exam_m Where id_subject = '-1' ");
		sql.append("Union all ");
		sql.append("Select id_exam, id_subject, title, 'E1', regdate, '3' as orders From exam_m Where id_subject <> '-1' ");
		if(aligns.equals("regdate")) {
			sql.append("Order by 6 asc, 5 desc ");
		} else if(aligns.equals("q_subject")) {
			sql.append("Order by 6, 3  ");
		}

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_category);
			stm.setString(2, years);
			stm.setString(3, id_course);
            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeBean(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 카테고리 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	// Tman 전체 관리자일 경우
	public static TreeBean[] getBeans(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_course, '0', course, 'C1', regdate From c_course Where yn_valid = 'Y' ");
		sql.append("Union all ");
		sql.append("Select id_subject, id_course, subject, 'S1', regdate From c_subject Where yn_valid = 'Y' ");
		sql.append("Order by regdate desc ");
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeBean(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 카테고리 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	// Tman 담당자일 경우
	public static TreeBean[] getMgrBeans(String userid, String years, String id_category, String aligns, String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select b.id_course as id_node, '0' as id_parentnode, b.course as node_name, 'C1', b.regdate ");
		sql.append("From t_worker_subj a, c_course b ");
		sql.append("Where a.userid = ? and a.id_course = b.id_course and b.id_category = ? and b.years = ? and b.id_course = ? ");
		sql.append("Union all ");
		sql.append("Select b.id_subject as id_node, b.id_course as id_parentnode, b.subject as node_name, 'S1', b.regdate ");
		sql.append("From t_worker_subj a, c_subject b ");
		sql.append("Where a.userid = ? and a.id_course = b.id_course and b.yn_valid = 'Y' ");
		sql.append("Union all ");
		sql.append("Select b.id_exam as id_node, b.id_course as id_parentnode, b.title as node_name, 'E1', b.regdate ");
		sql.append("From t_worker_subj a, exam_m b ");
		sql.append("Where a.userid = ? and a.id_course = b.id_course and b.id_subject = '-1' ");
		sql.append("Union all ");
		sql.append("Select b.id_exam as id_node, b.id_subject as id_parentnode, b.title as node_name, 'E1', b.regdate ");
		sql.append("From t_worker_subj a, exam_m b ");
		sql.append("Where a.userid = ? and a.id_course = b.id_course and b.id_subject <> '-1' ");
		if(aligns.equals("regdate")) {
			sql.append("Order by 5 desc ");
		} else if(aligns.equals("q_subject")) {
			sql.append("Order by 3  ");
		}

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());			
            stm.setString(1, userid);
			stm.setString(2, id_category);
			stm.setString(3, years);
			stm.setString(4, id_course);
			stm.setString(5, userid);
			stm.setString(6, userid);
			stm.setString(7, userid);
            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeBean(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 카테고리 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	// 채점 담당자일 경우
	public static TreeBean[] getExamMgrBeans(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select b.id_course as id_node, '0' as id_parentnode, b.course as node_name, 'C1', b.regdate ");
		sql.append("From score_manager a, c_course b ");
		sql.append("Where a.userid = ? and a.id_course = b.id_course ");
		sql.append("Order by 3  ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeBean(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 카테고리 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }


	// Qman 전체 관리자용 트리노드......
	public static TreeBean[] getBeans2(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_category, '0', category, 'G1', regdate, 1 as chapter_order From c_category ");
		sql.append("Order by 4 ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeBean2(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제관리 카테고리 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static TreeBean[] getAdmSubjectBeans(String userid, String years, String id_category, String aligns) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_q_subject, q_subject ");
		sql.append("From q_subject ");
		sql.append("Where years = ? and id_category = ? and yn_valid = 'Y' ");		
		if(aligns.equals("regdate")) {
			sql.append("Order by regdate desc ");
		} else if(aligns.equals("q_subject")) {
			sql.append("Order by q_subject  ");
		}
		        
		try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, years);
			stm.setString(2, id_category);

            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeAdmSubjectBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제관리 카테고리 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [TreeList.getAdmSubjectBeans()]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }		
    }

	public static TreeBean[] getAdmSubjectBeans2(String userid, String years, String id_category, String aligns) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_q_subject, q_subject ");
		sql.append("From q_subject a, q_worker_subj b ");
		sql.append("Where a.years = ? and a.id_category = ? and b.userid = ? and a.yn_valid = 'Y' and ");
		sql.append("      a.id_q_subject = b.id_subject ");
		if(aligns.equals("regdate")) {
			sql.append("Order by a.regdate desc ");
		} else if(aligns.equals("q_subject")) {
			sql.append("Order by a.q_subject  ");
		}
		        
		try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, years);
			stm.setString(2, id_category);
			stm.setString(3, userid);

            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeAdmSubjectBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제관리 카테고리 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [TreeList.getAdmSubjectBeans2()]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }		
    }

	public static TreeBean[] getAdmCourseBeans(String userid, String years, String id_category, String aligns) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_course, course ");
		sql.append("From c_course ");
		sql.append("Where years = ? and id_category = ? and yn_valid = 'Y' ");		
		if(aligns.equals("regdate")) {
			sql.append("Order by regdate desc ");
		} else if(aligns.equals("q_subject")) {
			sql.append("Order by course ");
		}
		        
		try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, years);
			stm.setString(2, id_category);

            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeAdmSubjectBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제관리 카테고리 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [TreeList.getAdmCourseBeans()]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }		
    }

	public static TreeBean[] getAdmCourseBeans2(String userid, String years, String id_category, String aligns) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_course, a.course ");
		sql.append("From c_course a, t_worker_subj b ");
		sql.append("Where a.years = ? and a.id_category = ? and b.userid = ? and a.yn_valid = 'Y' and ");		
		sql.append("      a.id_course = b.id_course ");
		if(aligns.equals("regdate")) {
			sql.append("Order by a.regdate desc ");
		} else if(aligns.equals("q_subject")) {
			sql.append("Order by a.course ");
		}
		        
		try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, years);
			stm.setString(2, id_category);
			stm.setString(3, userid);

            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeAdmSubjectBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제관리 카테고리 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [TreeList.getAdmCourseBeans2()]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }		
    }

	private static TreeBean makeAdmSubjectBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            TreeBean bean = new TreeBean();
            bean.setId_node(rst.getString(1));            
            bean.setNode_name(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("카테고리 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }


	public static TreeBean[] getQBeans2(String userid, String years, String id_category, String aligns, String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_q_subject, '0', q_subject, 'S1', regdate, 1 as chapter_order From q_subject ");
		sql.append("Where yn_valid = 'Y' and id_category = ? and years = ? and id_q_subject = ? ");
		sql.append("Union all ");
		sql.append("Select id_q_chapter, id_q_subject, chapter, 'U1', regdate, chapter_order From q_chapter ");
		sql.append("Union all ");
		sql.append("Select id_q_chapter2, id_q_chapter, chapter, 'U2', regdate, chapter_order FROM q_chapter2 ");
		sql.append("Union all ");
		sql.append("Select id_q_chapter3, id_q_chapter2, chapter, 'U3', regdate, chapter_order FROM q_chapter3 ");
		sql.append("Union all ");
		sql.append("Select id_q_chapter4, id_q_chapter3, chapter, 'U4', regdate, chapter_order FROM q_chapter4 ");
		if(aligns.equals("regdate")) {
			sql.append("Order by 6 asc, 5 desc ");
		} else if(aligns.equals("q_subject")) {
			sql.append("Order by 3,6  ");
		}
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_category);
			stm.setString(2, years);
			stm.setString(3, id_subject);
            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeBean2(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제관리 카테고리 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static TreeBean[] getQMgrBeans(String userid, String years, String id_category, String aligns, String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select b.id_q_subject as id_node, '0' as id_parentnode, b.q_subject as node_name, ");
        sql.append("       'S1' as node_gubun, b.regdate, 1 as chapter_order ");
		sql.append("From q_worker_subj a, q_subject b ");
		sql.append("Where a.userid = ? and a.id_subject = b.id_q_subject and b.id_category = ? and b.years = ? and b.id_q_subject = ? ");
		sql.append("Union all ");
		sql.append("Select b.id_q_chapter as id_node, b.id_q_subject as id_parentnode, b.chapter as node_name, ");
		sql.append("       'U1' as node_gubun, b.regdate, b.chapter_order ");
		sql.append("From q_worker_subj a, q_chapter b ");
		sql.append("Where a.userid = ? and a.id_subject = b.id_q_subject and b.id_q_subject = ? ");
		sql.append("Union all ");
		sql.append("Select b.id_q_chapter2 as id_node, b.id_q_chapter as id_parentnode, b.chapter as node_name, ");
		sql.append("       'U2' as node_gubun, b.regdate, b.chapter_order ");
		sql.append("From q_worker_subj a, q_chapter2 b ");
		sql.append("Where a.userid = ? and a.id_subject = b.id_q_subject and b.id_q_subject = ? ");
		sql.append("Union all ");
		sql.append("Select b.id_q_chapter3 as id_node, b.id_q_chapter2 as id_parentnode, b.chapter as node_name, ");
		sql.append("       'U3' as node_gubun, b.regdate, b.chapter_order ");
		sql.append("From q_worker_subj a, q_chapter3 b ");
		sql.append("Where a.userid = ? and a.id_subject = b.id_q_subject and b.id_q_subject = ? ");
		sql.append("Union all ");
		sql.append("Select b.id_q_chapter4 as id_node, b.id_q_chapter3 as id_parentnode, b.chapter as node_name, ");
		sql.append("       'U4' as node_gubun, b.regdate, b.chapter_order ");
		sql.append("From q_worker_subj a, q_chapter4 b ");
		sql.append("Where a.userid = ? and a.id_subject = b.id_q_subject and b.id_q_subject = ? ");
		if(aligns.equals("regdate")) {
			sql.append("Order by 6 asc, 5 desc ");
		} else if(aligns.equals("q_subject")) {
			sql.append("Order by 3, 6 ");
		}
		        
		try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
			stm.setString(2, id_category);
			stm.setString(3, years);
			stm.setString(4, id_subject);
			stm.setString(5, userid);
			stm.setString(6, id_subject);
			stm.setString(7, userid);
			stm.setString(8, id_subject);
			stm.setString(9, userid);
			stm.setString(10, id_subject);
			stm.setString(11, userid);
			stm.setString(12, id_subject);

            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeBean2(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제관리 카테고리 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }		
    }
	
	// Qman 담당자일 경우
	public static TreeBean[] getQMgr2Beans(String userid, String term_id, String lecture_id) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select b.id_q_subject as id_node, '0' as id_parentnode, b.q_subject as node_name, ");
        sql.append("       'S1' as node_gubun, b.regdate, 1 as chapter_order ");
		sql.append("From q_worker_subj a, q_subject b ");
		sql.append("Where a.userid = ? and a.id_subject = b.id_q_subject ");
		sql.append("      and b.subject_id in (Select subject_id From q_subject Where id_q_subject = ? ) ");
		sql.append("Union all ");
		sql.append("Select b.id_q_chapter as id_node, b.id_q_subject as id_parentnode, b.chapter as node_name, ");
		sql.append("       'U1' as node_gubun, b.regdate, b.chapter_order ");
		sql.append("From q_worker_subj a, q_chapter b, q_subject c ");
		sql.append("Where a.userid = ? and a.id_subject = b.id_q_subject and b.id_q_subject = c.id_q_subject ");
		sql.append("      and c.subject_id in (Select subject_id From q_subject Where id_q_subject = ? ) ");
		sql.append("Union all ");
		sql.append("Select b.id_q_chapter2 as id_node, b.id_q_chapter as id_parentnode, b.chapter as node_name, ");
		sql.append("       'U2' as node_gubun, b.regdate, b.chapter_order ");
		sql.append("From q_worker_subj a, q_chapter2 b, q_subject c ");
		sql.append("Where a.userid = ? and a.id_subject = b.id_q_subject and b.id_q_subject = c.id_q_subject ");
		sql.append("      and c.subject_id in (Select subject_id From q_subject Where id_q_subject = ? ) ");
		sql.append("Order by b.regdate desc ");
		        
		try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
			stm.setString(2, term_id);
			stm.setString(3, lecture_id);			
			stm.setString(4, userid);
			stm.setString(5, term_id);
			stm.setString(6, lecture_id);
			stm.setString(7, userid);
			stm.setString(8, term_id);
			stm.setString(9, lecture_id);

            rst = stm.executeQuery();
            TreeBean bean = null;
            while (rst.next()) {
                bean = makeBean2(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TreeBean[]) beans.toArray(new TreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제관리 카테고리 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }		
    }

    private static TreeBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            TreeBean bean = new TreeBean();
            bean.setId_node(rst.getString(1));
            bean.setId_parentnode(rst.getString(2));
            bean.setNode_name(rst.getString(3));
			bean.setNode_gubun(rst.getString(4));
			bean.setRegdate(rst.getTimestamp(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("카테고리 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }

	private static TreeBean makeBean2 (ResultSet rst) throws QmTmException
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
            throw new QmTmException("카테고리 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }

}