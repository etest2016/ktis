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
			throw new QmTmException("������� ���� ������ �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [ManagerTUtil.getBeanCnt]");
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
		sql.append("       a.pt_static_edit, to_char(a.regdate, 'yyyy-mm-dd') regdate ");
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
            throw new QmTmException("������ ������� ���������� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [ManagerTUtil.getBeans]");
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
            bean.setRegdate(rst.getString(8));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("������ ������� ���������� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [ManagerTUtil.makeBeans]");
        }
    }	
	
	public static ManagerTBean getBean(String userid, String id_course) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.id_course, b.course, a.pt_exam_edit, a.pt_exam_delete, a.pt_answer_edit, ");
		sql.append("       a.pt_score_edit, a.pt_static_edit, to_char(a.regdate, 'yyyy-mm-dd') regdate ");
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
			throw new QmTmException("������ ������� ���������� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [ManagerTUtil.getBean]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	public static ManagerTBean[] getAddBeans(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_course, course ");
		sql.append("From c_course ");
		sql.append("Where id_course not in (Select id_course From t_worker_subj ");
		sql.append("                        Where userid = ?) and yn_valid = 'Y' ");
		sql.append("Order by regdate desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
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
            throw new QmTmException("������� ���������� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [ManagerTUtil.getAddBeans]");
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
            throw new QmTmException("������� ���������� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [ManagerTUtil.makeAddBeans]");
        }
    }

	public static void insert(String userid, String id_course, String exam_edit, String exam_del, String answer_edit, String score_edit, String static_edit) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO t_worker_subj(userid, id_course, pt_exam_edit, pt_exam_delete, pt_answer_edit, pt_score_edit, pt_static_edit) ");
        sql.append("VALUES (?, ?, ?, ?, ?, ?, ?) ");

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

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("������ ������� ���������� ����ϴ� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [ManagerTUtil.insert]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static void update(String userid, String id_course, String exam_edit, String exam_del, String answer_edit, String score_edit, String static_edit) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update t_worker_subj SET pt_exam_edit = ?, pt_exam_delete = ?, pt_answer_edit = ?, pt_score_edit = ?, pt_static_edit = ? ");
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
			stm.setString(6, userid);
            stm.setString(7, id_course);
			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("������ ������� ���������� �����ϴ� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [ManagerTUtil.update]");
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
            throw new QmTmException("������ ������� ���������� �����ϴ� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [ManagerTUtil.delete]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}