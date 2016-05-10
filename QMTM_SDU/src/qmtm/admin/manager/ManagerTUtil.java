package qmtm.admin.manager;

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

public class ManagerTUtil
{
    public ManagerTUtil() {
    }
	
	public static int getBeanCnt(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select count(*) as cnt ");
		sql.append("From t_worker_subj a, c_course b ");
		sql.append("Where a.userid = ? and a.id_course = b.id_course and b.yn_valid = 'Y' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        }
        catch (SQLException ex) {
			throw new QmTmException("시험관리 권한 정보를 읽어오는 중 오류가 발생되었습니다. [ManagerTUtil.getBeanCnt] " + ex.getMessage());
        }
        finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static ManagerTBean[] getBeans(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_course, b.course, a.pt_exam_edit, a.pt_exam_delete, a.pt_answer_edit, a.pt_score_edit, ");
		sql.append("       a.pt_static_edit, a.pt_q_edit, a.pt_q_delete, convert(varchar(10), a.regdate, 120) regdate ");
		sql.append("From t_worker_subj a, c_course b  ");
		sql.append("Where a.userid = ? and a.id_course = b.id_course ");
		sql.append("Order by a.regdate desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
            rst = stm.executeQuery();
            ManagerTBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ManagerTBean[]) beans.toArray(new ManagerTBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("교수자 시험관리 권한정보를 읽어오는 중 오류가 발생되었습니다. [ManagerTUtil.getBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static ManagerTBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            ManagerTBean bean = new ManagerTBean();
            bean.setId_course(rst.getString(1));
            bean.setCourse(rst.getString(2));
			bean.setPt_exam_edit(rst.getString(3));
			bean.setPt_exam_delete(rst.getString(4));
			bean.setPt_answer_edit(rst.getString(5));
			bean.setPt_score_edit(rst.getString(6));
			bean.setPt_static_edit(rst.getString(7));
			bean.setPt_q_edit(rst.getString(8));
			bean.setPt_q_delete(rst.getString(9));
            bean.setRegdate(rst.getString(10));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("교수자 시험관리 권한정보를 읽어오는 중 오류가 발생되었습니다. [ManagerTUtil.makeBeans] " + ex.getMessage());
        }
    }	
	
	public static ManagerTBean getBean(String userid, String id_course) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.id_course, b.course, a.pt_exam_edit, a.pt_exam_delete, a.pt_answer_edit, ");
		sql.append("       a.pt_score_edit, a.pt_static_edit, a.pt_q_edit, a.pt_q_delete, convert(varchar(10), a.regdate, 120) regdate ");
		sql.append("From t_worker_subj a, c_course b ");
		sql.append("Where a.userid = ? and a.id_course = ? and a.id_course = b.id_course ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_course);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBeans(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("교수자 시험관리 권한정보를 읽어오는 중 오류가 발생되었습니다. [ManagerTUtil.getBean] " + ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	public static ManagerTBean[] getAddBeans(String userid, String mid_category) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_course, course ");
		sql.append("From c_course ");
		sql.append("Where id_course not in (Select id_course From t_worker_subj ");
		sql.append("                        Where userid = ?) and yn_valid = 'Y' ");
		sql.append("      and id_category = ? ");
		sql.append("Order by regdate desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, mid_category);
            rst = stm.executeQuery();
            ManagerTBean bean = null;
            while (rst.next()) {
                bean = makeAddBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ManagerTBean[]) beans.toArray(new ManagerTBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 과정정보를 읽어오는 중 오류가 발생되었습니다. [ManagerTUtil.getAddBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static ManagerTBean makeAddBeans (ResultSet rst) throws QmTmException
    {
		try {
            ManagerTBean bean = new ManagerTBean();
            bean.setId_course(rst.getString(1));
            bean.setCourse(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험관리 과정정보를 읽어오는 중 오류가 발생되었습니다. [ManagerTUtil.makeAddBeans] " + ex.getMessage());
        }
    }

	public static void insert(String userid, String id_course, String exam_edit, String exam_del, String answer_edit, String score_edit, String static_edit, String q_edit, String q_delete) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO t_worker_subj(userid, id_course, pt_exam_edit, pt_exam_delete, pt_answer_edit, pt_score_edit, pt_static_edit, pt_q_edit, pt_q_delete) ");
        sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
            stm.setString(2, id_course);
			stm.setString(3, exam_edit);
			stm.setString(4, exam_del);
			stm.setString(5, answer_edit);
			stm.setString(6, score_edit);
			stm.setString(7, static_edit);
			stm.setString(8, q_edit);
			stm.setString(9, q_delete);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("교수자 시험관리 권한정보를 등록하는 중 오류가 발생되었습니다. [ManagerTUtil.insert] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static void update(String userid, String id_course, String exam_edit, String exam_del, String answer_edit, String score_edit, String static_edit, String q_edit, String q_delete) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update t_worker_subj SET pt_exam_edit = ?, pt_exam_delete = ?, pt_answer_edit = ?, pt_score_edit = ?, ");
		sql.append("                         pt_static_edit = ?, pt_q_edit = ?, pt_q_delete = ? ");
        sql.append("Where userid = ? and id_course = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());            
			stm.setString(1, exam_edit);
			stm.setString(2, exam_del);
			stm.setString(3, answer_edit);
			stm.setString(4, score_edit);
			stm.setString(5, static_edit);
			stm.setString(6, q_edit);
			stm.setString(7, q_delete);
			stm.setString(8, userid);
            stm.setString(9, id_course);
			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("교수자 시험관리 권한정보를 수정하는 중 오류가 발생되었습니다. [ManagerTUtil.update] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String userid, String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM t_worker_subj Where userid = ? and id_course = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, userid);
			stm.setString(2, id_course);
			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("교수자 시험관리 권한정보를 삭제하는 중 오류가 발생되었습니다. [ManagerTUtil.delete] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}