package qmtm.admin;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

public class MemberStatic
{
    public MemberStatic() {
    }

	public static MemberStaticBean[] getBeans(int list_cnt, int lists, String id_category, String start_date, String end_date) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select top "+list_cnt+" c.userid, c.name, c.sosok2, c.sosok3, c.sosok4, d.title,  a.p_score,  b.t_avg, a.p_rank ");
		sql.append("From s_p_result a, s_t_result b, qt_userid c, exam_m d "); 
		sql.append("Where c.userid not in ");
		sql.append("     (Select top "+lists+" c.userid ");
		sql.append("      From s_p_result a, s_t_result b, qt_userid c, exam_m d ");
		sql.append("      Where d.id_category = ? and a.id_exam = b.id_exam and a.userid = c.userid and ");
		sql.append("      a.id_exam = d.id_exam and d.exam_start1 between ? and ? ");
		sql.append("      Order by d.title, c.sosok2, c.sosok3, c.name ) ");
		sql.append("      and d.id_category = ? and a.id_exam = b.id_exam and a.userid = c.userid and ");
		sql.append("      a.id_exam = d.id_exam and d.exam_start1 between ? and ? ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_category);
			stm.setString(2, start_date);
			stm.setString(3, end_date);
			stm.setString(4, id_category);
			stm.setString(5, start_date);
			stm.setString(6, end_date);
            rst = stm.executeQuery();
            MemberStaticBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (MemberStaticBean[]) beans.toArray(new MemberStaticBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("개별성적통계 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [MemberStatic.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static MemberStaticBean[] getAllBeans(String id_category, String start_date, String end_date) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select c.userid, c.name, c.sosok2, c.sosok3, c.sosok4, d.title,  a.p_score,  b.t_avg, a.p_rank ");
		sql.append("From s_p_result a, s_t_result b, qt_userid c, exam_m d "); 
		sql.append("Where d.id_category = ? and a.id_exam = b.id_exam and a.userid = c.userid and ");
		sql.append("      a.id_exam = d.id_exam and d.exam_start1 between ? and ? ");
		sql.append("Order by d.title, c.sosok2, c.sosok3, c.name ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_category);
			stm.setString(2, start_date);
			stm.setString(3, end_date);
	        rst = stm.executeQuery();
            MemberStaticBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (MemberStaticBean[]) beans.toArray(new MemberStaticBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("개별성적통계 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [MemberStatic.getAllBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
    private static MemberStaticBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            MemberStaticBean bean = new MemberStaticBean();
			bean.setUserid(rst.getString(1));
			bean.setName(rst.getString(2));
			bean.setSosok2(rst.getString(3));
			bean.setSosok3(rst.getString(4));
			bean.setSosok4(rst.getString(5));
			bean.setTitle(rst.getString(6));
			bean.setP_score(rst.getDouble(7));
			bean.setT_avg(rst.getDouble(8));
			bean.setP_rank(rst.getInt(9));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("접수 인원 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [MemberStatic.makeBeans]");
        }
    }
			
	public static int getCounts(String id_category, String start_date, String end_date) throws QmTmException {
		
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Select count(*) as cnts ");
		sql.append("From s_p_result a, s_t_result b, qt_userid c, exam_m d ");
		sql.append("Where d.id_category = ? and a.id_exam = b.id_exam and a.userid = c.userid and ");
		sql.append("      a.id_exam = d.id_exam and d.exam_start1 between ? and ? ");

		try {
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_category);
			stm.setString(2, start_date);
			stm.setString(3, end_date);
			rst = stm.executeQuery();

			if (rst.next()) {
				return rst.getInt("cnts");
			} else {
				return 0;
			}

		} catch (SQLException ex) {
			throw new QmTmException("대상자 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [MemberStatic.getCounts]");
		} finally {
			if (rst != null)    try {   rst.close();    } catch (SQLException ex) {}
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

}