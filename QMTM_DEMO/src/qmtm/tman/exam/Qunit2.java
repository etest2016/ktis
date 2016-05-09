package qmtm.tman.exam;

import qmtm.*;

import java.sql.*;
import java.util.*;

public class Qunit2
{
    public Qunit2() {
    }	
	
	public static QunitBean getBean(long id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		//sql.append("Select id_qtype, excount, cacount, q, ex1, ex2, ex3, ex4, ex5, ex6, ex7, ex8, ca, null(explain,' ') explain ");
		sql.append("Select id_qtype, excount, cacount, q, ex1, ex2, ex3, ex4, ex5, ex6, ex7, ex8, ca, nullif(explain,' ') explain ");
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
            throw new QmTmException("[Qunit.getBean]" + ex.getMessage());
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
            throw new QmTmException("[Qunit.makeBean]" + ex.getMessage());
        }
    }

	public static QunitBean getQBean(long id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		/*
		sql.append("Select a.excount, a.cacount, a.userid, ");
		sql.append("       convert(varchar(16), a.regdate, 120) regdate, ");
		sql.append("       convert(varchar(16), a.up_date, 120) up_date, ");
		sql.append("       b.qtype, c.difficulty, null(d.make_cnt,0) ");
		sql.append("From q a, r_qtype b, r_difficulty c, make_q d ");
		sql.append("Where a.id_q = ? and a.id_qtype = b.id_qtype and a.id_difficulty1 = c.id_difficulty and a.id_q = d.id_q(+) ");
		 */
		
		sql.append("Select a.excount, a.cacount, a.userid, ");
		sql.append("       to_char(a.regdate, 'YYYY-MM-DD HH24:MI') regdate, ");
		sql.append("       to_char(a.up_date, 'YYYY-MM-DD HH24:MI') up_date, ");
		sql.append("       b.qtype, c.difficulty, nullif(d.make_cnt,0) ");
		sql.append("From q a inner join r_qtype b on a.id_qtype = b.id_qtype inner join r_difficulty c on ");
		sql.append("        a.id_difficulty1 = c.id_difficulty left outer join make_q d on a.id_q = d.id_q ");
		sql.append("Where a.id_q = ? ");

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
            throw new QmTmException("[Qunit.getQBean]" + ex.getMessage());
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
            throw new QmTmException("[Qunit.makeQBean]" + ex.getMessage());
        }
    }

	public static QunitBean[] getBeans(String id_qs) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		String str1 = "";

		sql.append("Select a.id_q, a.id_ref, a.id_qtype, a.excount, a.cacount, a.q, a.ex1, a.ex2, a.ex3, a.ex4, ");
		sql.append("       a.ex5, a.ex6, a.ex7, a.ex8, a.ca, b.reftitle, b.refbody1, b.refbody2, b.refbody3 ");
		//sql.append("From q a, q_ref b ");
		//sql.append("Where a.id_q in (" + id_qs + ") and a.id_ref = b.id_ref(+) ");
		sql.append("From q a left outer join q_ref b on a.id_ref = b.id_ref ");
		sql.append("Where a.id_q in (" + id_qs + ") ");

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
			throw new QmTmException("[Qunit.getBeans]" + ex.getMessage());
		} finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static QunitBean[] getHanBeans(String id_qs) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		String str1 = "";

		sql.append("Select a.id_q, a.id_ref, a.id_qtype, a.excount, a.cacount, a.q, a.ex1, a.ex2, a.ex3, a.ex4, ");
		sql.append("       a.ex5, a.ex6, a.ex7, a.ex8, a.ca, b.reftitle, b.refbody1, b.refbody2, b.refbody3 ");
		//sql.append("From q a, q_ref b ");
		//sql.append("Where a.userid = '98026' and a.subject_id = '302026' and a.id_ref = b.id_ref(+) ");
		sql.append("From q a left outer join q_ref b on a.id_ref = b.id_ref ");
		sql.append("Where a.userid = '98026' and a.subject_id = '302026' ");

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
			throw new QmTmException("[Qunit.getBeans]" + ex.getMessage());
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
            throw new QmTmException("[Qunit.makeBeans]" + ex.getMessage());
        }
    }
}