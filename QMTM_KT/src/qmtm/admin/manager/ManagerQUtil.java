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
import java.sql.Statement;

public class ManagerQUtil
{
    public ManagerQUtil() {
    }
	
	public static int getBeanCnt(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select count(*) as cnt ");
		sql.append("From q_worker_subj a, q_subject b ");
		sql.append("Where a.userid = ? and a.id_subject = b.id_q_subject and b.yn_valid = 'Y' ");

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
			throw new QmTmException("문제관리 권한 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerQUtil.getBeanCnt]");
        }
        finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }


	public static ManagerQBean[] getBeans(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_subject, b.q_subject, a.pt_q_edit, a.pt_q_delete, ");
		sql.append("       to_char(a.regdate, 'yyyy-mm-dd hh24:mi') regdate ");
		sql.append("From q_worker_subj a, q_subject b ");
		sql.append("Where a.userid = ? and a.id_subject = id_q_subject ");
		sql.append("Order by a.regdate desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
            rst = stm.executeQuery();
            ManagerQBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ManagerQBean[]) beans.toArray(new ManagerQBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("교수자 문제관리 권한정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerQUtil.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static ManagerQBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            ManagerQBean bean = new ManagerQBean();
            bean.setId_subject(rst.getString(1));
            bean.setQ_subject(rst.getString(2));
			bean.setPt_q_edit(rst.getString(3));
			bean.setPt_q_delete(rst.getString(4));
            bean.setRegdate(rst.getString(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("교수자 문제관리 권한정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerQUtil.makeBeans]");
        }
    }

	public static ManagerQBean[] getAddBeans(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_q_subject, q_subject ");
		sql.append("From q_subject ");
		sql.append("Where id_q_subject not in (Select id_subject From q_worker_subj ");
		sql.append("                           Where userid = ?)  and yn_valid = 'Y' ");
		sql.append("Order by regdate desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
            rst = stm.executeQuery();
            ManagerQBean bean = null;
            while (rst.next()) {
                bean = makeAddBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ManagerQBean[]) beans.toArray(new ManagerQBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제관리 과목정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerQUtil.getAddBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static ManagerQBean makeAddBeans (ResultSet rst) throws QmTmException
    {
		try {
            ManagerQBean bean = new ManagerQBean();
            bean.setId_subject(rst.getString(1));
            bean.setQ_subject(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제관리 과목정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerQUtil.makeAddBeans]");
        }
    }

	public static void insert(String userid, String id_subject, String q_edit, String q_del) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO q_worker_subj(userid, id_subject, pt_q_edit, pt_q_delete) ");
        sql.append("Select '"+userid+"', id_q_subject, '"+q_edit+"', '"+q_del+"' ");
		sql.append("From q_subject ");
		sql.append("Where id_course = '"+id_subject+"' ");

        try
        {
            cnn = DBPool.getConnection();
	       stm = cnn.createStatement();
			stm.executeUpdate(sql.toString());

        }
        catch (SQLException ex) {
            throw new QmTmException("교수자 문제관리 권한정보를 등록하는 중 인터넷 연결상태가 좋지 않습니다. [ManagerQUtil.insert]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ManagerQBean getBean(String userid, String id_subject) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select top 1 a.id_subject, b.q_subject, a.pt_q_edit, a.pt_q_delete, to_char(a.regdate, 'yyyy-mm-dd hh24:mi') regdate ");
		sql.append("From q_worker_subj a, q_subject b ");
		sql.append("Where a.userid = ? and b.id_course = ? and a.id_subject = id_q_subject ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_subject);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBeans(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("교수자 문제관리 권한정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerQUtil.getBean]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	public static void update(String userid, String id_subject, String q_edit, String q_del) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update q_worker_subj SET pt_q_edit = ?, pt_q_delete = ? ");
        sql.append("Where userid = ? and  id_subject in (select id_q_subject From q_subject Where id_course = ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());            
			stm.setString(1, q_edit);
			stm.setString(2, q_del);
			stm.setString(3, userid);
            stm.setString(4, id_subject);
			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("교수자 문제관리 권한정보를 수정하는 중 인터넷 연결상태가 좋지 않습니다. [ManagerQUtil.update]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String userid, String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("DELETE FROM q_worker_subj ");
        sql.append("Where userid = ? and id_subject in ");
		sql.append("      ( select id_q_subject from q_subject Where id_course = ? ) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_subject);
			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("교수자 문제관리 권한정보를 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [ManagerQUtil.delete]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}