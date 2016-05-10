package qmtm.tman.paper;

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

public class ExamPaperUtil
{
    public ExamPaperUtil() {
    }

	public static ExamOrderQBean[] getOrderQ(String id_exam, String randomtypes) throws QmTmException
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_q, id_ref, id_qtype, allotting, excount ");
		sql.append("From q_paper ");
		sql.append("Where id_exam = ? ");

		if(randomtypes.equals("NN")) {
			sql.append("Order by orders, id_ref ");
		} else {
			sql.append("Order by orders, id_ref, dbms_random.value ");
	    }

	    try {
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
            rst = stm.executeQuery();

			ExamOrderQBean bean = null;
            while (rst.next()) {
                bean = makeOrderQ(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamOrderQBean[]) beans.toArray(new ExamOrderQBean[0]);
            }
		} catch (SQLException ex) {
			throw new QmTmException("시험지 정보 읽어오는 중 오류가 발생되었습니다. [ExamPaperUtil.getOrderQ] " + ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static ExamOrderQBean makeOrderQ (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamOrderQBean bean = new ExamOrderQBean();
            bean.setId_q(rst.getString(1));
			bean.setId_ref(rst.getString(2));
			bean.setId_qtype(rst.getString(3));
			bean.setAllotting(rst.getDouble(4));
			bean.setExcount(rst.getString(5));

            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 정보 읽어오는 중 오류가 발생되었습니다. [ExamPaperUtil.makeOrderQ] " + ex.getMessage());
        }
    }

	public static ExamOrderQBean[] getOrderQs(String id_exam, int orders) throws QmTmException
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_q, id_subject, id_chapter, id_ref, id_qtype, ");
		sql.append("       allotting, excount, ch_qs, ch_score ");
		sql.append("From q_paper ");
		sql.append("Where id_exam = ? and orders = ? ");
		sql.append("Order by id_ref ");

	    try {
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, orders);
            rst = stm.executeQuery();

			ExamOrderQBean bean = null;
            while (rst.next()) {
                bean = makeOrderQs(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamOrderQBean[]) beans.toArray(new ExamOrderQBean[0]);
            }
		} catch (SQLException ex) {
			throw new QmTmException("시험지 정보 읽어오는 중 오류가 발생되었습니다. [ExamPaperUtil.getOrderQs] " + ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static ExamOrderQBean makeOrderQs (ResultSet rst) throws QmTmException
    {
		try {
            ExamOrderQBean bean = new ExamOrderQBean();
            bean.setId_q(rst.getString(1));
			bean.setId_subject(rst.getString(2));
			bean.setId_chapter(rst.getString(3));
			bean.setId_ref(rst.getString(4));
			bean.setId_qtype(rst.getString(5));
			bean.setAllotting(rst.getDouble(6));
			bean.setExcount(rst.getString(7));
			bean.setCh_qs(rst.getInt(8));
			bean.setCh_score(rst.getDouble(9));			

            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 정보 읽어오는 중 오류가 발생되었습니다. [ExamPaperUtil.makeOrderQ] " + ex.getMessage());
        }
    }

	public static void insert(String id_exam, int nr_set, int nr_q, int id_q, String ex_order, double allotting, int page, int q_no1, int q_no2) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO exam_paper2 (id_exam, nr_set, nr_q, id_q, ex_order, allotting, page, q_no1, q_no2) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());

            stm.setString(1, id_exam);
			stm.setInt(2, nr_set);
			stm.setInt(3, nr_q);
			stm.setInt(4, id_q);
			stm.setString(5, ex_order);
			stm.setDouble(6, allotting);
			stm.setInt(7, page);
			stm.setInt(8, q_no1);
			stm.setInt(9, q_no2);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 정보 등록하는 중 오류가 발생되었습니다. [ExamPaperUtil.getOrderQ] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_exam) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "Delete from exam_paper2 Where id_exam = ? ";

        try
        {		
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("[ExamPaperUtil.delete]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void makecntMinus(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update make_q ");
		sql.append("       Set make_cnt = make_cnt - 1 ");
		sql.append("Where id_q in ");
		sql.append("      ( Select distinct id_q From exam_paper2 Where id_exam = ? ) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			
			stm.setString(1, id_exam);

			stm.execute();

			delete(id_exam);
        }
        catch (SQLException ex) {
            throw new QmTmException("[ExamPaperUtil.makecntMinus]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void setCount(String id_exam, int paper_cnts) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update exam_m set setcount = ? Where id_exam = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());

			stm.setInt(1, paper_cnts);
			stm.setString(2, id_exam);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("[ExamPaperUtil.setCount]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void makecntAdd(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Insert into make_q ");
		sql.append("Select distinct id_q, 0 From exam_paper2 ");
		sql.append("Where id_exam = ? and id_q not in ");
		sql.append("      ( Select id_q From make_q ) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			
			stm.setString(1, id_exam);

			stm.execute();

			// 문제별 출제횟수를 업데이트 한다.
			makecntUpdate(id_exam);
        }
        catch (SQLException ex) {
            throw new QmTmException("[ExamPaperUtil.makecntAdd]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void makecntUpdate(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update make_q ");
		sql.append("       Set make_cnt = make_cnt + 1 ");
		sql.append("Where id_q in ");
		sql.append("      ( Select distinct id_q From exam_paper2 Where id_exam = ? ) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			
			stm.setString(1, id_exam);

			stm.execute();

        }
        catch (SQLException ex) {
            throw new QmTmException("[ExamPaperUtil.makecntUpdate]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}