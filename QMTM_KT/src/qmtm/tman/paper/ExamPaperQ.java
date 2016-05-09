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

public class ExamPaperQ
{
    public ExamPaperQ() {
    }

	public static void saveQ(String q, String allott, String id_exam) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO q_paper ");
        sql.append("Select b.id_q, '"+ id_exam +"', b.id_subject, a.q_subject, b.id_chapter, c.chapter, b.q, ");
		sql.append("        b.id_ref, b.id_qtype, b.id_difficulty1, "+ allott +", b.excount, 1, 0, 0 ");
		sql.append("From q_subject as a inner join q as b ");
		sql.append("     on b.id_q = "+ q +" and a.id_q_subject = b.id_subject ");
		sql.append("     left outer join q_chapter c on b.id_chapter = c.id_q_chapter ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();

			stm.executeUpdate(sql.toString());
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 만들기에서 출제문항 저장 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperQ.saveQ]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void saveQ2(String qs, String id_exam) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO q_paper ");
        sql.append("Select b.id_q, '"+ id_exam +"', b.id_subject, a.q_subject, b.id_chapter, c.chapter, b.q, ");
		sql.append("        b.id_ref, b.id_qtype, b.id_difficulty1, b.allotting, b.excount, 1, 0, 0 ");
		sql.append("From q_subject as a inner join q as b ");
		sql.append("     on b.id_q in ( "+ qs +" ) and a.id_q_subject = b.id_subject ");
		sql.append("     left outer join q_chapter c on b.id_chapter = c.id_q_chapter ");
		
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();

			stm.executeUpdate(sql.toString());
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 만들기에서 출제문항 저장 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperQ.saveQ2]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static boolean getPapers(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

        sql = "SELECT id_exam FROM q_paper WHERE id_exam = ? ";

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);

            rst = stm.executeQuery();
            if (rst.next()) { return true; }
            else { return false; }
        } catch (SQLException ex) {
            throw new QmTmException("시험지 만들기에서 시험코드 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperQ.getPapers]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static void delete(String id_exam) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "Delete From q_paper Where id_exam = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 만들기에서 출제문항 삭제 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperQ.delete]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void updateOrders(String id_exam, String id_subject, int id_qtype, int orders, int ch_qs, double ch_score) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update q_paper Set orders = ?, ch_qs = ?, ch_score = ? ");
		sql.append("Where id_exam = ? and id_subject = ? and id_qtype = ? and id_ref = '0' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setInt(1, orders);
			stm.setInt(2, ch_qs);
			stm.setDouble(3, ch_score);
			stm.setString(4, id_exam);
			stm.setString(5, id_subject);
			stm.setInt(6, id_qtype);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 만들기에서 출제문항 정보 수정 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperQ.updateOrders]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void updateOrders2(String id_exam, String id_subject, String id_chapter, int orders, int ch_qs, double ch_score) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update q_paper Set orders = ?, ch_qs = ?, ch_score = ? ");
		sql.append("Where id_exam = ? and id_subject = ? and id_chapter = ? and id_ref = '0' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setInt(1, orders);
			stm.setInt(2, ch_qs);
			stm.setDouble(3, ch_score);
			stm.setString(4, id_exam);
			stm.setString(5, id_subject);
			stm.setString(6, id_chapter);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 만들기에서 출제문항 정보 수정 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperQ.updateOrders2]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void updateOrders3(String id_exam, String id_subject, String id_chapter, int id_qtype, int orders, int ch_qs, double ch_score) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update q_paper Set orders = ?, ch_qs = ?, ch_score = ? ");
		sql.append("Where id_exam = ? and id_subject = ? and id_chapter = ? and id_qtype = ? and id_ref = '0' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setInt(1, orders);
			stm.setInt(2, ch_qs);
			stm.setDouble(3, ch_score);
			stm.setString(4, id_exam);
			stm.setString(5, id_subject);
			stm.setString(6, id_chapter);
			stm.setInt(7, id_qtype);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 만들기에서 출제문항 정보 수정 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperQ.updateOrders3]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void updateOrders4(String id_exam, String id_subject, String id_chapter, int id_difficulty, int orders, int ch_qs, double ch_score) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update q_paper Set orders = ?, ch_qs = ?, ch_score = ? ");
		sql.append("Where id_exam = ? and id_subject = ? and id_chapter = ? and id_difficulty = ? and id_ref = '0' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setInt(1, orders);
			stm.setInt(2, ch_qs);
			stm.setDouble(3, ch_score);
			stm.setString(4, id_exam);
			stm.setString(5, id_subject);
			stm.setString(6, id_chapter);
			stm.setInt(7, id_difficulty);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 만들기에서 출제문항 정보 수정 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperQ.updateOrders4]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void updateOrders5(String id_exam, String id_subject, String id_chapter, int id_qtype, int id_difficulty, int orders, int ch_qs, double ch_score) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update q_paper Set orders = ?, ch_qs = ?, ch_score = ? ");
		sql.append("Where id_exam = ? and id_subject = ? and id_chapter = ? and id_qtype = ? and id_difficulty = ? and id_ref = '0' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setInt(1, orders);
			stm.setInt(2, ch_qs);
			stm.setDouble(3, ch_score);
			stm.setString(4, id_exam);
			stm.setString(5, id_subject);
			stm.setString(6, id_chapter);
			stm.setInt(7, id_qtype);
			stm.setInt(8, id_difficulty);			

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 만들기에서 출제문항 정보 수정 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperQ.updateOrders5]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void updateOrders6(String id_exam, String id_subject, int orders, int ch_qs, double ch_score) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update q_paper Set orders = ?, ch_qs = ?, ch_score = ? ");
		sql.append("Where id_exam = ? and id_subject = ? and id_ref = '0' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setInt(1, orders);
			stm.setInt(2, ch_qs);
			stm.setDouble(3, ch_score);
			stm.setString(4, id_exam);
			stm.setString(5, id_subject);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 만들기에서 출제문항 정보 수정 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperQ.updateOrders6]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}


	public static void updateRefOrders(String id_exam, int orders) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update q_paper Set orders = ? ");
		sql.append("Where id_exam = ? and id_ref <> '0' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setInt(1, orders);
			stm.setString(2, id_exam);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 만들기에서 출제문항 정보 수정 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperQ.updateRefOrders]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void updateRefOrders(String id_exam, String id_subject, String id_chapter, int orders, int ref_qs, double ref_score) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update q_paper Set orders = ?, ch_qs = ?, ch_score = ? Where id_ref in ");
		sql.append("       ( Select id_ref From vw_q_paper ");
		sql.append("         Where id_exam = ? and id_subject = ? and ref_cnt = ? ) ");
		sql.append("       and id_exam = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setInt(1, orders);
			stm.setInt(2, ref_qs);
			stm.setDouble(3, ref_score);
			stm.setString(4, id_exam);
			stm.setString(5, id_subject);
			stm.setInt(6, ref_qs);
			stm.setString(7, id_exam);			

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 만들기에서 출제문항 정보 수정 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperQ.updateRefOrders]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
}