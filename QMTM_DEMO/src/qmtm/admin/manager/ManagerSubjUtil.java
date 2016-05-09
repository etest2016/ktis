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

public class ManagerSubjUtil
{
    public ManagerSubjUtil() {
    }
			
	public static ManagerSubjBean[] getBeans(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		//sql.append("       a.pt_static_edit, convert(varchar(10), a.regdate, 120) regdate ");
		
		sql.append("Select b.id_course, b.course, a.pt_exam_edit, a.pt_exam_delete, a.pt_answer_edit, a.pt_score_edit, ");
		sql.append("       a.pt_static_edit, to_char(a.regdate, 'YYYY-MM-DD') regdate ");
		sql.append("From t_worker_subj a, c_course b "); 
		sql.append("Where a.userid = ? and a.id_course = b.id_course ");
		sql.append("Order by a.regdate desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
            rst = stm.executeQuery();
            ManagerSubjBean bean = null;
            while (rst.next()) {
                bean = makeBeans_1(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ManagerSubjBean[]) beans.toArray(new ManagerSubjBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("담당자 권한정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerSubjUtil.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static ManagerSubjBean makeBeans_1 (ResultSet rst) throws QmTmException
    {
		try {
            ManagerSubjBean bean = new ManagerSubjBean();
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
            throw new QmTmException("담당자 권한정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerSubjUtil.makeBeans]");
        }
    }	
	

    private static ManagerSubjBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            ManagerSubjBean bean = new ManagerSubjBean();
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
            throw new QmTmException("담당자 권한정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerSubjUtil.makeBeans]");
        }
    }	
	
	public static ManagerSubjBean getBean(String userid, String id_course) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select c.id_course, c.course, a.pt_exam_edit, a.pt_exam_delete, a.pt_answer_edit, a.pt_score_edit, a.pt_static_edit, ");
        //sql.append("       b.pt_q_edit, b.pt_q_delete, convert(varchar(10), a.regdate, 120) regdate ");
		sql.append("       b.pt_q_edit, b.pt_q_delete, to_char(a.regdate, 'YYYY-MM-DD') regdate ");
		sql.append("From t_worker_subj a, q_worker_subj b, c_course c ");
		sql.append("Where a.userid = ? and a.id_course = ? and a.id_course = b.id_subject and a.userid = b.userid and a.id_course = c.id_course ");
		sql.append("Order by a.regdate desc ");

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
			throw new QmTmException("담당자 권한정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerSubjUtil.getBean]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	public static ManagerQBean getQBean(String userid, String id_course) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		//sql.append("Select top 1 a.pt_q_edit, a.pt_q_delete ");
		sql.append("Select a.pt_q_edit, a.pt_q_delete ");
		sql.append("From q_worker_subj a, q_subject b ");
		sql.append("Where a.userid = ? and b.id_course = ? and a.id_subject = b.id_q_subject ");
		sql.append("limit 1 ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_course);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeQBeans(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("담당자 문제은행 권한정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerQBean.getQBean]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static ManagerQBean makeQBeans (ResultSet rst) throws QmTmException
    {
		try {
            ManagerQBean bean = new ManagerQBean();            
			bean.setPt_q_edit(rst.getString(1));
			bean.setPt_q_delete(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("담당자 문제은행 권한정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ManagerSubjUtil.makeQBeans]");
        }
	}
	
}