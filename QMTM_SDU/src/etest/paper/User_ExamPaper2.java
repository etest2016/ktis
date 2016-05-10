package etest.paper;

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

// for paper/etest.jsp

public class User_ExamPaper2
{
    private static int nonCount = 0;       // 논술형 문제수
    private static double nonAllot = 0.0;  // 논술형 배점
    private static String pageList = "";   // 페이지번호          = 1:2:3:4:...
    private static String startList = "";  // 페이지별 최초문제번호 = 1:6:11:16...
    private static String endList = "";    // 페이지별 최종문제번호 = 5:10:15:20...

    public User_ExamPaper2() {}

    public static User_ExamPaper2Bean[] getBeans(String id_exam, int nr_set, String userid) throws QmTmException
    {
        // 문제세트 전체

        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

 		sql.append("SELECT a.nr_q, a.id_q, a.ex_order, a.allotting, a.page, a.q_no1, a.q_no2, ");
        sql.append("       b.id_ref, b.id_qtype, b.excount, b.cacount, b.q, ");
        sql.append("       b.ex1, b.ex2, b.ex3, b.ex4, b.ex5, b.ca, b.hint, b.explain, b.id_valid_type, ");
        sql.append("       c.reftitle, c.refbody1, c.refbody2, c.refbody3, b.ex_rowcnt, b.yn_single_line ");
        sql.append("FROM exam_paper2 a inner join q b on a.id_q = b.id_q ");
		sql.append("     left outer join q_ref c on b.id_ref = c.id_ref ");
        sql.append("WHERE a.id_exam = ? AND a.nr_set = ? ");
        sql.append(" ORDER BY a.nr_q ");

		try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setInt(2, nr_set);
            rst = stm.executeQuery();
            User_ExamPaper2Bean bean = null;
            while (rst.next()) {
                bean = makeBean(rst, userid, id_exam);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (User_ExamPaper2Bean[]) beans.toArray(new User_ExamPaper2Bean[0]);
            }
        }
        catch (SQLException ex) {
			throw new QmTmException("시험지 문제 정보 읽어오는중 오류가 발생되었습니다. [User_ExamPaper2.getBeans] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static User_ExamPaper2Bean[] getBeans45(String id_exam, int nr_set, String userid) throws QmTmException
    {
        // 문제세트중 단답형(4) 및 논술형(5)

        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
	
		sql.append("SELECT a.nr_q, a.id_q, a.ex_order, a.allotting, a.page, a.q_no1, a.q_no2, ");
        sql.append("       b.id_ref, b.id_qtype, b.excount, b.cacount, b.q, ");
        sql.append("       b.ex1, b.ex2, b.ex3, b.ex4, b.ex5, b.ca, b.hint, b.explain, b.id_valid_type, ");
        sql.append("       c.reftitle, c.refbody1, c.refbody2, c.refbody3, b.ex_rowcnt, b.yn_single_line ");
        sql.append("FROM exam_paper2 as a inner join q as b ");
        sql.append("     on a.id_q = b.id_q and a.id_exam = ? AND a.nr_set = ? AND b.id_qtype >= 4 ");
        sql.append("     left outer join q_ref as c on b.id_ref = c.id_ref ");
        sql.append("ORDER BY a.nr_q ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setInt(2, nr_set);
            rst = stm.executeQuery();
            User_ExamPaper2Bean bean = null;
            while (rst.next()) {
                bean = makeBean(rst, userid, id_exam);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (User_ExamPaper2Bean[]) beans.toArray(new User_ExamPaper2Bean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 논술형 문제 정보 읽어오는중 오류가 발생되었습니다. [User_ExamPaper2.getBeans45] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static User_ExamPaper2Bean makeBean (ResultSet rst, String userid, String id_exam) throws QmTmException
    {
        try {
            User_ExamPaper2Bean bean = new User_ExamPaper2Bean();
			bean.setNr_q(rst.getInt(1));
            bean.setId_q(rst.getLong(2));
            bean.setEx_order(rst.getString(3));
            bean.setAllotting(rst.getDouble(4));
            bean.setPage(rst.getInt(5));
            bean.setQ_no1(rst.getInt(6));
            bean.setQ_no2(rst.getInt(7));
            bean.setId_ref(rst.getString(8));
            bean.setId_qtype(rst.getInt(9));
            bean.setExcount(rst.getInt(10));
            bean.setCacount(rst.getInt(11));
            bean.setQ(rst.getString(12));
            bean.setEx1(rst.getString(13));
            bean.setEx2(rst.getString(14));
            bean.setEx3(rst.getString(15));
            bean.setEx4(rst.getString(16));
            bean.setEx5(rst.getString(17));
            bean.setCa(rst.getString(18));
            bean.setHint(rst.getString(19));
            bean.setExplain(rst.getString(20));
            bean.setId_valid_type(rst.getInt(21));
            bean.setReftitle(rst.getString(22));
            bean.setRefbody1(rst.getString(23));
            bean.setRefbody2(rst.getString(24));
            bean.setRefbody3(rst.getString(25));
			bean.setEx_rowcnt(rst.getInt(26));
			bean.setYn_single_line(rst.getString(27));
			
			if (bean.getId_qtype() == 5) { // id_qtype == 5 : 논술형
                long id_q = bean.getId_q();
                User_ExamAnsNonBean nonbean = User_ExamAnsNon.getBean(id_q, userid, id_exam);
                bean.setUserans1(nonbean.getUserans1());
                bean.setUserans2(nonbean.getUserans2());
                bean.setUserans3(nonbean.getUserans3());
            } else {
                bean.setUserans1("");
                bean.setUserans2("");
                bean.setUserans3("");
            }
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 문제 정보 읽어오는중 오류가 발생되었습니다. [User_ExamPaper2.makeBean] " +ex.getMessage());
        }
    }

	public static User_ExamPaper2Bean[] getBeansCorrect45(String id_exam, int nr_set, String userid, String strSql) throws QmTmException
    {
        // 문제세트중 단답형(4) 및 논술형(5)

        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("SELECT a.nr_q, a.id_q, a.ex_order, a.allotting, a.page, a.q_no1, a.q_no2, ");
        sql.append("       b.id_ref, b.id_qtype, b.excount, b.cacount, b.q, ");
        sql.append("       b.ex1, b.ex2, b.ex3, b.ex4, b.ex5, b.ca, b.hint, b.explain, b.id_valid_type, ");
		sql.append("       c.reftitle, c.refbody1, c.refbody2, c.refbody3 ");
        sql.append("FROM exam_paper2 as a inner join q as b ");
        sql.append("     on a.id_q = b.id_q and a.id_exam = ? AND a.nr_set = ? AND b.id_qtype >= 4 ?" );
        sql.append("     left outer join q_ref as c on b.id_ref = c.id_ref ");
        sql.append("ORDER BY a.nr_q ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, nr_set);
			stm.setString(3, strSql);
			rst = stm.executeQuery();
            User_ExamPaper2Bean bean = null;
            while (rst.next()) {
                bean = make45Bean(rst, userid, id_exam);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (User_ExamPaper2Bean[]) beans.toArray(new User_ExamPaper2Bean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 논술형 문제 정보 읽어오는중 오류가 발생되었습니다. [User_ExamPaper2.getBeansCorrect45] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
    
    private static User_ExamPaper2Bean make45Bean (ResultSet rst, String userid, String id_exam) throws QmTmException
    {
        try {
            User_ExamPaper2Bean bean = new User_ExamPaper2Bean();
			bean.setNr_q(rst.getInt(1));
            bean.setId_q(rst.getLong(2));
            bean.setEx_order(rst.getString(3));
            bean.setAllotting(rst.getDouble(4));
            bean.setPage(rst.getInt(5));
            bean.setQ_no1(rst.getInt(6));
            bean.setQ_no2(rst.getInt(7));
            bean.setId_ref(rst.getString(8));
            bean.setId_qtype(rst.getInt(9));
            bean.setExcount(rst.getInt(10));
            bean.setCacount(rst.getInt(11));
            bean.setQ(rst.getString(12));
            bean.setEx1(rst.getString(13));
            bean.setEx2(rst.getString(14));
            bean.setEx3(rst.getString(15));
            bean.setEx4(rst.getString(16));
            bean.setEx5(rst.getString(17));
            bean.setCa(rst.getString(18));
            bean.setHint(rst.getString(19));
            bean.setExplain(rst.getString(20));
            bean.setId_valid_type(rst.getInt(21));
            
			if (bean.getId_qtype() == 5) { // id_qtype == 5 : 논술형
                long id_q = bean.getId_q();
                User_ExamAnsNonBean nonbean = User_ExamAnsNon.getBean(id_q, userid, id_exam);
                bean.setUserans1(nonbean.getUserans1());
                bean.setUserans2(nonbean.getUserans2());
                bean.setUserans3(nonbean.getUserans3());
            } else {
                bean.setUserans1("");
                bean.setUserans2("");
                bean.setUserans3("");
            }
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 논술형 문제 정보 읽어오는중 오류가 발생되었습니다. [User_ExamPaper2.getBeansCorrect45] " +ex.getMessage());
        }
    }
        
    public static void setPageInfo(User_ExamPaper2Bean[] beans) throws QmTmException
    {
        int oldPage = 0;
        int oldNrQ = 0;

        nonCount = 0;
        nonAllot = 0;
        pageList = "";
        startList = "";
        endList = "";

        if (beans != null)
        {
            for (int i = 0; i < beans.length; i++)
            {
                if (oldPage != beans[i].getPage())
                {
                    if (pageList.length() > 0) {
                        endList += oldNrQ + ":";
                    }
                    pageList += beans[i].getPage() + ":";
                    startList += beans[i].getNr_q() + ":";
                    oldPage = beans[i].getPage();
                    oldNrQ = beans[i].getNr_q();
                } else {
                    oldNrQ = beans[i].getNr_q();
                }
                if (beans[i].getId_qtype() == 5) {
                    nonCount++;
                    nonAllot += beans[i].getAllotting();
                }
            }
        }
        // 마지막 구분자(:) 제거
        pageList = pageList.substring(0, pageList.length() - 1);
        startList = startList.substring(0, startList.length() - 1);
        // 마지막 문제번호 추가
        endList += beans[beans.length - 1].getNr_q();
    }

    public static int getNonCount() {
        return nonCount;
    }

    public static double getNonAllot() {
        return nonAllot;
    }

    public static String getPageList() {
        return pageList;
    }

    public static String getStartList() {
        return startList;
    }

    public static String getEndList() {
        return endList;
    }
}
