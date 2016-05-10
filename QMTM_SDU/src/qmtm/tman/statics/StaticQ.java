package qmtm.tman.statics;
  
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
 
public class StaticQ
{
    public StaticQ() {
    }

	public static void insert_Q(String id_exam) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO exam_q(id_exam, id_q) ");
		sql.append("SELECT distinct id_exam, id_q From exam_paper2 Where id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.execute();
		} catch (SQLException ex) {
			throw new QmTmException("시험지문항을 등록하는 중 인터넷 연결상태가 좋지 않습니다. [StaticQ.insert_Q]");			
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static StaticQBean[] getId_qs(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select b.id_q, b.id_qtype, b.id_valid_type ");
		sql.append("From exam_q a, q b ");
		sql.append("Where a.id_exam = ? and a.id_q = b.id_q and b.id_valid_type = 0 ");
		sql.append("Order by b.id_qtype ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            StaticQBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (StaticQBean[]) beans.toArray(new StaticQBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지문항을 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticQ.getId_qs]");
        } 
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
   
	private static StaticQBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            StaticQBean bean = new StaticQBean();
            bean.setId_q(rst.getLong(1));
            bean.setId_qtype(rst.getInt(2));
			bean.setId_valid_type(rst.getInt(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지문항을 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticQ.makeBeans]");
        }
    }

	public static StaticQBean[] getOxs(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select nr_set, answers, oxs ");
		sql.append("From exam_ans ");
		sql.append("Where id_exam = ? and yn_end = 'Y' and oxs is not null and answers is not null and userid <> 'tman@@2008' ");
		sql.append("Order by nr_set ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            StaticQBean bean = null;
            while (rst.next()) {
                bean = makeBeans2(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (StaticQBean[]) beans.toArray(new StaticQBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 답안을 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticQ.getOxs]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static StaticQBean makeBeans2 (ResultSet rst) throws QmTmException
    {
		try {
            StaticQBean bean = new StaticQBean();
            bean.setNr_set(rst.getInt(1));
            bean.setAnswers(rst.getString(2));
			bean.setOxs(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안을 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticQ.makeBeans2]");
        }
    }

	public static StaticQBean[] getId_qs2(String id_exam, int nr_set) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_q From exam_paper2 ");
		sql.append("Where id_exam = ? and nr_set = ? ");
		sql.append("Order by nr_q ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setInt(2, nr_set);
            rst = stm.executeQuery();
            StaticQBean bean = null;
            while (rst.next()) {
                bean = makeBeans3(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (StaticQBean[]) beans.toArray(new StaticQBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 문항을 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticQ.getId_qs2]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static StaticQBean makeBeans3 (ResultSet rst) throws QmTmException
    {
		try {
            StaticQBean bean = new StaticQBean();
            bean.setId_qs(rst.getLong(1));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 문항을 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticQ.makeBeans3]");
        }
    }

	public static void update_Q(String id_exam, long id_q, int o_cnt, int x_cnt, int ex1, int ex2, int ex3, int ex4, int ex5, int ex6, int ex7, int ex8) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Update exam_q set o_cnt = ?, x_cnt = ?, ex1_cnt = ?, ex2_cnt = ?, ex3_cnt = ?, ");
		sql.append("                  ex4_cnt = ?, ex5_cnt = ?, ex6_cnt = ?, ex7_cnt = ?, ex8_cnt = ? ");
		sql.append("Where id_exam = ? and id_q = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());

			stm.setInt(1, o_cnt);
			stm.setInt(2, x_cnt);
			stm.setInt(3, ex1);
			stm.setInt(4, ex2);
			stm.setInt(5, ex3);
			stm.setInt(6, ex4);
			stm.setInt(7, ex5);
			stm.setInt(8, ex6);
			stm.setInt(9, ex7);
			stm.setInt(10, ex8);
			stm.setString(11, id_exam);
			stm.setLong(12, id_q);

			stm.execute();

		} catch (SQLException ex) {
			throw new QmTmException("시험지 문항을 수정하는 중 인터넷 연결상태가 좋지 않습니다. [StaticQ.update_Q]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static StaticQBean[] getQList(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.id_q, a.o_cnt, a.x_cnt, a.ex1_cnt, a.ex2_cnt, a.ex3_cnt, a.ex4_cnt, a.ex5_cnt, a.ex6_cnt, a.ex7_cnt, a.ex8_cnt, ");
		sql.append("       c.qtype, b.excount, b.cacount, (a.o_cnt + a.x_cnt) as all_sum, round(((o_cnt / (case when a.o_cnt = 0 then 1 else a.o_cnt end+x_cnt)) * 100),2) as o_rate ");
		sql.append("From exam_q a, q b, r_qtype c ");
		sql.append("Where a.id_exam = ? and a.id_q = b.id_q and b.id_qtype = c.id_qtype ");
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            
			StaticQBean bean = null;
			
			while (rst.next()) {
				bean = makeQList(rst);
				beans.add(bean);
			}
			if (bean == null) {
				return null;
			} else {
				return (StaticQBean[]) beans.toArray(new StaticQBean[0]);
			}
		}
        catch (SQLException ex) {
            throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticQ.getQList]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static StaticQBean makeQList (ResultSet rst) throws QmTmException
    {
		try {
            StaticQBean bean = new StaticQBean();
			bean.setId_q(rst.getLong(1));
			bean.setO_cnt(rst.getInt(2));
			bean.setX_cnt(rst.getInt(3));
			bean.setEx1_cnt(rst.getInt(4));
			bean.setEx2_cnt(rst.getInt(5));
			bean.setEx3_cnt(rst.getInt(6));
			bean.setEx4_cnt(rst.getInt(7));
			bean.setEx5_cnt(rst.getInt(8));
			bean.setEx6_cnt(rst.getInt(9));
			bean.setEx7_cnt(rst.getInt(10));
			bean.setEx8_cnt(rst.getInt(11));
			bean.setQtype(rst.getString(12));
			bean.setExcount(rst.getInt(13));
			bean.setCacount(rst.getInt(14));
			bean.setAll_sum(rst.getInt(15));
			bean.setO_rate(rst.getDouble(16));

            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticQ.makeQList]");
        }
    }

	public static StaticQBean[] getQList2(long id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.o_cnt, a.x_cnt, a.ex1_cnt, a.ex2_cnt, a.ex3_cnt, a.ex4_cnt, a.ex5_cnt, a.ex6_cnt, a.ex7_cnt, a.ex8_cnt, ");
		sql.append("       c.title, (a.o_cnt + a.x_cnt) as all_sum, round(((o_cnt / (case when a.o_cnt = 0 then 1 else a.o_cnt end+x_cnt)) * 100),2) as o_rate, c.id_exam ");
		sql.append("From exam_q a, q b, exam_m c ");
		sql.append("Where a.id_q = ? and a.id_q = b.id_q and a.id_exam = c.id_exam ");
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setLong(1, id_q);
            rst = stm.executeQuery();
            
			StaticQBean bean = null;
			
			while (rst.next()) {
				bean = makeQList2(rst);
				beans.add(bean);
			}
			if (bean == null) {
				return null;
			} else {
				return (StaticQBean[]) beans.toArray(new StaticQBean[0]);
			}
		}
        catch (SQLException ex) {
            throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticQ.getQList2]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static StaticQBean makeQList2 (ResultSet rst) throws QmTmException
    {
		try {
            StaticQBean bean = new StaticQBean();
			bean.setO_cnt(rst.getInt(1));
			bean.setX_cnt(rst.getInt(2));
			bean.setEx1_cnt(rst.getInt(3));
			bean.setEx2_cnt(rst.getInt(4));
			bean.setEx3_cnt(rst.getInt(5));
			bean.setEx4_cnt(rst.getInt(6));
			bean.setEx5_cnt(rst.getInt(7));
			bean.setEx6_cnt(rst.getInt(8));
			bean.setEx7_cnt(rst.getInt(9));
			bean.setEx8_cnt(rst.getInt(10));
			bean.setTitle(rst.getString(11));
			bean.setAll_sum(rst.getInt(12));
			bean.setO_rate(rst.getDouble(13));
			bean.setId_exam(rst.getString(14));

            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticQ.makeQList2]");
        }
    }

	public static StaticQBean getQStaticList(String id_exam, long id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select o_cnt, x_cnt, ex1_cnt, ex2_cnt, ex3_cnt, ex4_cnt, ex5_cnt, ex6_cnt, ex7_cnt, ex8_cnt ");
		sql.append("From exam_q ");
		sql.append("Where id_exam = ? and id_q = ? ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setLong(2, id_q);
            rst = stm.executeQuery();
            if (rst.next()) {
                return makeQStaticList(rst);
            } else {
				return null;
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticQ.getQStaticList]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static StaticQBean makeQStaticList (ResultSet rst) throws QmTmException
    {
		try {
            StaticQBean bean = new StaticQBean();
            bean.setO_cnt(rst.getInt(1));
			bean.setX_cnt(rst.getInt(2));
			bean.setEx1_cnt(rst.getInt(3));
			bean.setEx2_cnt(rst.getInt(4));
			bean.setEx3_cnt(rst.getInt(5));
			bean.setEx4_cnt(rst.getInt(6));
			bean.setEx5_cnt(rst.getInt(7));
			bean.setEx6_cnt(rst.getInt(8));
			bean.setEx7_cnt(rst.getInt(9));
			bean.setEx8_cnt(rst.getInt(10));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticQ.makeQStaticList]");
        }
    }

	public static StaticQBean getQStaticList2(String id_exam, long id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.o_cnt, a.x_cnt, a.ex1_cnt, a.ex2_cnt, a.ex3_cnt, a.ex4_cnt, a.ex5_cnt, a.ex6_cnt, a.ex7_cnt, a.ex8_cnt, b.title ");
		sql.append("From exam_q a, exam_m b ");
		sql.append("Where a.id_exam = ? and a.id_q = ? and a.id_exam = b.id_exam ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setLong(2, id_q);
            rst = stm.executeQuery();
            if (rst.next()) {
                return makeQStaticList2(rst);
            } else {
				return null;
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticQ.getQStaticList2]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static StaticQBean makeQStaticList2 (ResultSet rst) throws QmTmException
    {
		try {
            StaticQBean bean = new StaticQBean();
            bean.setO_cnt(rst.getInt(1));
			bean.setX_cnt(rst.getInt(2));
			bean.setEx1_cnt(rst.getInt(3));
			bean.setEx2_cnt(rst.getInt(4));
			bean.setEx3_cnt(rst.getInt(5));
			bean.setEx4_cnt(rst.getInt(6));
			bean.setEx5_cnt(rst.getInt(7));
			bean.setEx6_cnt(rst.getInt(8));
			bean.setEx7_cnt(rst.getInt(9));
			bean.setEx8_cnt(rst.getInt(10));
			bean.setTitle(rst.getString(11));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticQ.makeQStaticList2]");
        }
    }
}