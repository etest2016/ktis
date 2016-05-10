package etest.score;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

public class User_Stat
{
    public User_Stat() {
    }

    private static User_StatExamBean makeUser_StatExamBean (ResultSet rst) throws QmTmException
    {
        try {
            User_StatExamBean bean = new User_StatExamBean();
            bean.setTitle(rst.getString("title"));
            bean.setU_avg_basis(rst.getString("u_avg_basis"));
            bean.setYn_p_rank(rst.getString("yn_p_rank"));
            bean.setYn_p_rank_pct(rst.getString("yn_p_rank_pct"));
            bean.setYn_score_dis(rst.getString("yn_score_dis"));
            bean.setYn_t_avg(rst.getString("yn_t_avg"));
            bean.setYn_t_max(rst.getString("yn_t_max"));
            bean.setYn_t_min(rst.getString("yn_t_min"));
            bean.setYn_t_u_avg(rst.getString("yn_t_u_avg"));
            bean.setYn_t_user_cnt(rst.getString("yn_t_user_cnt"));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("성적통계 정보를 읽어오는 중 오류가 발생되었습니다. [User_Stat.makeUser_StatExamBean] " +ex.getMessage());
        }
    }

    public static User_StatExamBean getUser_StatExamBean(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

        sql = "SELECT * FROM exam_m WHERE id_exam = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return makeUser_StatExamBean(rst); }
            else { return null; }
        }
        catch (SQLException ex) {
            throw new QmTmException("성적통계 정보를 읽어오는 중 오류가 발생되었습니다. [User_Stat.getUser_StatExamBean] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static User_StatTotalBean makeUser_StatTotalBean (ResultSet rst) throws QmTmException
    {
        try {
            User_StatTotalBean bean = new User_StatTotalBean();
            bean.setA(rst.getInt("a"));
            bean.setAllotting(rst.getDouble("allotting"));
            bean.setB(rst.getInt("b"));
            bean.setC(rst.getInt("c"));
            bean.setD(rst.getInt("d"));
            bean.setE(rst.getInt("e"));
            bean.setF(rst.getInt("f"));
            bean.setG(rst.getInt("g"));
            bean.setH(rst.getInt("h"));
            bean.setI(rst.getInt("i"));
            bean.setJ(rst.getInt("j"));
            bean.setQcount(rst.getInt("qcount"));
            bean.setT_avg(rst.getDouble("t_avg"));
            bean.setT_max(rst.getDouble("t_max"));
            bean.setT_min(rst.getDouble("t_min"));
            bean.setT_u_avg(rst.getDouble("t_u_avg"));
            bean.setT_user_cnt(rst.getInt("t_user_cnt"));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("성적통계 정보를 읽어오는 중 오류가 발생되었습니다. [User_Stat.makeUser_StatTotalBean] " +ex.getMessage());
        }
    }

    public static User_StatTotalBean getUser_StatTotalBean(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("SELECT * FROM s_t_result ");
        sql.append("WHERE id_exam = ? AND id_subject = '-1' AND id_chapter = '-1' ");
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return makeUser_StatTotalBean(rst); }
            else { return null; }
        }
        catch (SQLException ex) {
            throw new QmTmException("성적통계 정보를 읽어오는 중 오류가 발생되었습니다. [User_Stat.getUser_StatTotalBean] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static User_StatPersonBean makeUser_StatPersonBean (ResultSet rst) throws QmTmException
    {
        try {
            User_StatPersonBean bean = new User_StatPersonBean();
            bean.setP_rank(rst.getInt("p_rank"));
            bean.setP_rank_pct(rst.getDouble("p_rank_pct"));
            bean.setP_score(rst.getDouble("p_score"));
            bean.setP_score_pct(rst.getDouble("p_score_pct"));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("성적통계 정보를 읽어오는 중 오류가 발생되었습니다. [User_Stat.makeUser_StatPersonBean] " +ex.getMessage());
        }
    }

    public static User_StatPersonBean getUser_StatPersonBean(String userid, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Select * From s_p_result ");
        sql.append("Where userid = ? and id_exam = ? ");
        sql.append("      and id_subject = '-1' and id_chapter = '-1' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
            stm.setString(2, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return makeUser_StatPersonBean(rst); }
            else { return null; }
        }
        catch (SQLException ex) {
            throw new QmTmException("성적통계 정보를 읽어오는 중 오류가 발생되었습니다. [User_Stat.getUser_StatPersonBean] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}
