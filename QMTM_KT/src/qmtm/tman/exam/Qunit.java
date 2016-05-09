package qmtm.tman.exam;

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

public class Qunit
{
    public Qunit() {
    }	
	
	public static QunitBean getBean(long id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_qtype, excount, cacount, q, ex1, ex2, ex3, ex4, ex5, ex6, ex7, ex8, ca, isnull(explain,' ') explain ");
		sql.append("From q ");
		sql.append("Where id_q = ? ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setLong(1, id_q);
            rst = stm.executeQuery();
            if (rst.next()) {
                return makeBean(rst);
            } else {
				return null;
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [Qunit.getBean]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static QunitBean makeBean (ResultSet rst) throws QmTmException
    {
		try {
            QunitBean bean = new QunitBean();
            bean.setId_qtype(rst.getInt(1));
			bean.setExcount(rst.getInt(2));
			bean.setCacount(rst.getInt(3));
            bean.setQ(rst.getString(4));
			bean.setEx1(rst.getString(5));
			bean.setEx2(rst.getString(6));
			bean.setEx3(rst.getString(7));
			bean.setEx4(rst.getString(8));
			bean.setEx5(rst.getString(9));
			bean.setEx6(rst.getString(10));
			bean.setEx7(rst.getString(11));
			bean.setEx8(rst.getString(12));
			bean.setCa(rst.getString(13));
			bean.setExplain(rst.getString(14));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [Qunit.makeBean]");
        }
    }

	public static QunitBean getQBean(long id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.excount, a.cacount, a.userid, ");
        sql.append("	   convert(varchar(16), a.regdate, 120) regdate, ");
        sql.append("	   convert(varchar(16), a.up_date, 120) up_date, ");
        sql.append("	   b.qtype, c.difficulty, isnull(d.make_cnt,0) ");
		sql.append("From q as a inner join r_qtype as b ");
        sql.append("	 on a.id_q = ? and a.id_qtype = b.id_qtype inner join r_difficulty as c ");
        sql.append("	 on a.id_difficulty1 = c.id_difficulty ");
        sql.append("	 left outer join make_q as d ");
        sql.append("	 on a.id_q = d.id_q ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setLong(1, id_q);
            rst = stm.executeQuery();
            if (rst.next()) {
                return makeQBean(rst);
            } else {
				return null;
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [Qunit.getQBean]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static QunitBean makeQBean (ResultSet rst) throws QmTmException
    {
		try {
            QunitBean bean = new QunitBean();
			bean.setExcount(rst.getInt(1));
			bean.setCacount(rst.getInt(2));
			bean.setUserid(rst.getString(3));
			bean.setRegdate(rst.getString(4));
			bean.setUp_date(rst.getString(5));
			bean.setQtype(rst.getString(6));
			bean.setDifficulty(rst.getString(7));
			bean.setMake_cnt(rst.getInt(8));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [Qunit.makeQBean]");
        }
    }

	public static QunitBean[] getBeans(String id_qs) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		String str1 = "";

		sql.append("Select a.id_q, a.id_ref, a.id_qtype, a.excount, a.cacount, a.q, a.ex1, a.ex2, a.ex3, a.ex4, ");
		sql.append("       a.ex5, a.ex6, a.ex7, a.ex8, a.ca, c.reftitle, c.refbody1, c.refbody2, c.refbody3 ");
		sql.append("From q as a inner join r_qtype as b ");
		sql.append("     on a.id_q in (" + id_qs + ") and a.id_qtype = b.id_qtype ");
		sql.append("     left outer join q_ref as c on a.id_ref = c.id_ref ");
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();
 	        rst = stm.executeQuery(sql.toString());
            QunitBean bean = null;
			while (rst.next()) {
				bean = makeBeans(rst);
				beans.add(bean);
			}
			if (bean == null) {
				return null;
			} else {
				return (QunitBean[]) beans.toArray(new QunitBean[0]);
			}
		} catch (SQLException ex) {
			throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [Qunit.getBeans]");
		} finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}
	
	private static QunitBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            QunitBean bean = new QunitBean();
            bean.setId_q(rst.getLong(1));
			bean.setId_ref(rst.getString(2));
			bean.setId_qtype(rst.getInt(3));
			bean.setExcount(rst.getInt(4));
			bean.setCacount(rst.getInt(5));
            bean.setQ(rst.getString(6));
			bean.setEx1(rst.getString(7));
			bean.setEx2(rst.getString(8));
			bean.setEx3(rst.getString(9));
			bean.setEx4(rst.getString(10));
			bean.setEx5(rst.getString(11));
			bean.setEx6(rst.getString(12));
			bean.setEx7(rst.getString(13));
			bean.setEx8(rst.getString(14));
			bean.setCa(rst.getString(15));
			bean.setReftitle(rst.getString(16));
			bean.setRefbody1(rst.getString(17));
			bean.setRefbody2(rst.getString(18));
			bean.setRefbody3(rst.getString(19));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [Qunit.makeBean]");
        }
    }
}