package etest.scorehelp;

import qmtm.*;

import java.sql.*;
import java.util.*;

// for exam/myTest.jsp

public class Score_ExamList
{
    public Score_ExamList() {}

    public static Score_ExamListBean[] getBeans(String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.title, a.id_exam, to_char(a.exam_start1, 'yyyy-mm-dd hh24:mi') exam_start, ");
		sql.append("       to_char(a.exam_end1, 'yyyy-mm-dd hh24:mi') exam_end, ");
		sql.append("       (Select to_char(nvl(count(b.id_q), 0)) from exam_q b, q c where b.id_q = c.id_q and a.id_exam = b.id_exam and c.id_qtype = 4) nums, ");
		sql.append("       (Select to_char(nvl(count(b.id_q), 0)) from exam_q b, q c where b.id_q = c.id_q and a.id_exam = b.id_exam and c.id_qtype = 5) nums2 ");
		sql.append("From exam_m a ");
		sql.append("Where a.id_course = ? ");
		sql.append("Order by a.title ");

		//System.out.println(id_course);
		//System.out.println(sql.toString());
        
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);
            rst = stm.executeQuery();
            Score_ExamListBean bean = null;
            while (rst.next()) {
                bean = makeBean(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (Score_ExamListBean[]) beans.toArray(new Score_ExamListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_ExamList.getBeans]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static Score_ExamListBean makeBean (ResultSet rst) throws QmTmException
    {
        try {
            Score_ExamListBean bean = new Score_ExamListBean();
            bean.setTitle(rst.getString(1));
            bean.setId_exam(rst.getString(2));
            bean.setExam_start(rst.getString(3));
            bean.setExam_end(rst.getString(4));
            bean.setNums1(rst.getString(5));
            bean.setNums2(rst.getString(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[Score_ExamList.makeBean]" + ex.getMessage());
        }
    }

    public static String getWorkerid(String userid, String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid ");
		sql.append("From qt_workerid a, t_worker_subj b ");
		sql.append("Where a.userid = b.userid and a.userid = ? and b.id_course = ? ");
        
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
            stm.setString(2, id_course);
            rst = stm.executeQuery();
			
			if (rst.next()) {
				return rst.getString(1);
			} else {
				return null;
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_ExamList.getWorkerid]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}
