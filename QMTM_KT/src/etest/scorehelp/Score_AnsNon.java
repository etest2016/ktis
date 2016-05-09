package etest.scorehelp;

import qmtm.*;

import java.sql.*;
import java.util.*;

public class Score_AnsNon
{
    public Score_AnsNon() {
    }

	public static int getQcnt(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select qcount ");
		sql.append("From exam_m ");
		sql.append("Where id_exam = ? ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            
            if (rst.next()) return rst.getInt("qcount");
            else return 0; 
            
        } catch (SQLException ex) {
            throw new QmTmException("[Score_AnsNon.getQcnt]" + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static int getRcnt(String id_exam, String id_q, String userid) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(*) as Rcnt ");
		sql.append("From equal_test_result2 ");
		sql.append("Where id_exam = ? and id_q = ? and userid = ?");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setString(2, id_q);
            stm.setString(3, userid);
            rst = stm.executeQuery();
            
            if (rst.next()) return rst.getInt("rcnt");
            else return 0; 
            
        } catch (SQLException ex) {
            throw new QmTmException("[Score_AnsNon.getRcnt]" + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static Score_AnsNonBean[] getBeans(String id_exam, String id_q, int k_equal_value, int equal_value, int ans_len_value, String yn_end, int pg, int size) throws QmTmException
	//public static Score_AnsNonBean[] getBeans(String id_exam, String id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();
		int i = 0;
		int nowPos = 0;

		sql.append("Select userid, search_bigo, nvl(SEARCH_RESUTL_RATE,0), nvl(SEARCH_RESUTL_RATE2,0), ");
		sql.append("	nvl(ans_result_rate, 0), ans_result_rate2, nvl(basic_ans_len, 0), nvl(userid_ans_len, 0) ");
		sql.append("From equal_test_result2 ");
		sql.append("Where id_exam = ? and id_q = ? and score_yn = ? ");
		
		
		if(k_equal_value!=0){
			sql.append("	and SEARCH_RESUTL_RATE >= ? ");
			sql.append("Order by SEARCH_RESUTL_RATE DESC ");
		}else if(equal_value!=0) {
			sql.append("	and ans_result_rate >= ? ");
			sql.append("Order by ans_result_rate DESC");
		}else if(ans_len_value!=0){
			sql.append("	and userid_ans_len >= ? ");
			sql.append("Order by userid_ans_len DESC");
		}else {
			sql.append("Order by SEARCH_RESUTL_RATE DESC, ans_result_rate DESC, userid_ans_len DESC ");
		}

        try
        {	
			Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString(), ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            stm.setString(1, id_exam);
            stm.setString(2, id_q);
			stm.setString(3, yn_end);

			if(k_equal_value!=0){
				stm.setInt(4, k_equal_value);
			}else if (equal_value!=0){
				stm.setInt(4, equal_value);
			}else if (ans_len_value!=0){
				stm.setInt(4, ans_len_value);
			}		
            
            rst = stm.executeQuery();
            Score_AnsNonBean bean = null;


			/*
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
			*/

			//페이징 처리를 위하여 변경
			if (rst.next()) {
				nowPos = (pg -1) * size + 1;

				//absolut 로 이동을 시켰기 때문에 bean에 바로 담아야 한다
				rst.absolute(nowPos);
				bean = makeBeans(rst);
				beans.add(bean);

				if (rst.isLast() == false) {
					for (i=1; i<=size-1; i++) {
						rst.next();
						if (rst.isLast()) {
							bean = makeBeans(rst);
							beans.add(bean);
							break;
						} else {
							bean = makeBeans(rst);
							beans.add(bean);
						}
					}
				}
			}
            if (bean == null) {
                return null;
            } else {
                return (Score_AnsNonBean[]) beans.toArray(new Score_AnsNonBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_AnsNon.getBeans]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static Score_AnsNonBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            Score_AnsNonBean bean = new Score_AnsNonBean();
            bean.setUserid(rst.getString(1));
            bean.setSearch_bigo(rst.getString(2));
            bean.setSearch_result_rate(rst.getString(3));
            bean.setSearch_result_rate2(rst.getString(4));
            bean.setAns_result_rate(rst.getString(5));
            bean.setAns_result_rate2(rst.getString(6));
            bean.setBasic_ans_len(rst.getString(7));
            bean.setUserid_ans_len(rst.getString(8));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[Score_AnsNon.makeBeans]" + ex.getMessage());
        }
    }

	public static int getCount(String id_exam, String id_q, int k_equal_value, int equal_value, int ans_len_value, String yn_end) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();
		int i = 0;
		int nowPos = 0;

		sql.append("Select count(*) ");
		sql.append("From equal_test_result2 ");
		sql.append("Where id_exam = ? and id_q = ? and score_yn = ? ");
		
		
		if(k_equal_value!=0){
			sql.append("	and SEARCH_RESUTL_RATE >= ? ");
			sql.append("Order by SEARCH_RESUTL_RATE DESC ");
		}else if(equal_value!=0) {
			sql.append("	and ans_result_rate >= ? ");
			sql.append("Order by ans_result_rate DESC");
		}else if(ans_len_value!=0){
			sql.append("	and userid_ans_len >= ? ");
			sql.append("Order by userid_ans_len DESC");
		}else {
			sql.append("Order by SEARCH_RESUTL_RATE DESC, ans_result_rate DESC, userid_ans_len DESC ");
		}

        try
        {	
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setString(2, id_q);
			stm.setString(3, yn_end);
			if(k_equal_value!=0){
				stm.setInt(4, k_equal_value);
			}else if (equal_value!=0){
				stm.setInt(4, equal_value);
			}else if (ans_len_value!=0){
				stm.setInt(4, ans_len_value);
			}		
            
            rst = stm.executeQuery();
			if (rst.next()) {
				return rst.getInt(1);
			} else {
				return 0;
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_AnsNon.getCount]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static Score_AnsNonBean getPoint(String id_exam, String id_q, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select nvl(a.points, ' ') points, b.nr_q, b.allotting ");
		sql.append("From exam_ans a, exam_paper2 b ");
		sql.append("Where a.id_exam = ? and b.id_q = ? and a.userid = ? ");
		sql.append("	 and a.id_exam = b.id_exam and a.nr_set = b.nr_set ");
		
        try
        {	
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setString(2, id_q);
            stm.setString(3, userid);
            rst = stm.executeQuery();
			if (rst.next()) {
				return makePoint(rst);
			} else {
				return null;
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_AnsNon.getPoint]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static Score_AnsNonBean makePoint (ResultSet rst) throws QmTmException
    {
		try {
            Score_AnsNonBean bean = new Score_AnsNonBean();
            bean.setPoints(rst.getString(1));
            bean.setNr_q(rst.getInt(2));
            bean.setAllotting(rst.getDouble(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[Score_AnsNon.makePoint]" + ex.getMessage());
        }
    }


	public static Score_AnsNonBean getScore(String id_exam, String id_q, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select equal_chk, score, equal_ans ");
		sql.append("From equal_comp_result ");
		sql.append("Where id_exam = ? and id_q = ? and o_userid = ? ");
		
        try
        {	
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setString(2, id_q);
            stm.setString(3, userid);
            rst = stm.executeQuery();
			if (rst.next()) {
				return makeScore(rst);
			} else {
				return null;
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_AnsNon.getScore]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static Score_AnsNonBean makeScore (ResultSet rst) throws QmTmException
    {
		try {
            Score_AnsNonBean bean = new Score_AnsNonBean();
            bean.setEqual_chk(rst.getString(1));
            bean.setScore(rst.getInt(2));
			bean.setEqual_ans(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[Score_AnsNon.makeScore]" + ex.getMessage());
        }
    }


	public static void DelBasicans(String id_exam, String id_q, int comp_bigo) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

        sql.append("Delete From Basic_ans_non Where id_exam = ? and id_q = ? ");

		if(comp_bigo != 0){
			sql.append("	and comp_bigo = ? ");
		}

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setString(2, id_q);
			if(comp_bigo != 0){
				stm.setInt(3, comp_bigo);
			}
			rst = stm.executeQuery();
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_AnsNon.DelBasicans]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static void InsBasicans(String id_exam, String id_q, int comp_bigo, String search_string, String adm_userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

        sql.append("Insert into BASIC_ANS_NON(id_exam, id_q, comp_bigo, search_comp, adm_userid, reg_date) ");
        sql.append("Values(?, ?, ?, ?, ?, sysdate) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setString(2, id_q);
			stm.setInt(3, comp_bigo);
			stm.setString(4, search_string);
			stm.setString(5, adm_userid);
			rst = stm.executeQuery();
        }
        catch (SQLException ex) {
			DelBasicans(id_exam, id_q, 0);
            throw new QmTmException("[Score_AnsNon.InsBasicans]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void InsSresult(String userid, String id_exam, String id_q, double search_cnt, int result_cnts2) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

        sql.append("Insert into EQUAL_TEST_RESULT2(userid, id_exam, id_q, search_bigo, search_resutl_rate, search_resutl_rate2) ");
        sql.append("Values(?, ?, ?, 1, ?, ? ) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_exam);
			stm.setString(3, id_q);
			stm.setDouble(4, search_cnt);
			stm.setInt(5, result_cnts2);
			rst = stm.executeQuery();
        }
        catch (SQLException ex) {
			DelResult(id_exam, id_q);
            throw new QmTmException("[Score_AnsNon.InsSresult]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }


	public static void InsAresult(String userid, String id_exam, String id_q, double ans_result_rate, double ans_result_rate2, int basic_ans_len, int userid_ans_len) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

        sql.append("Insert into EQUAL_TEST_RESULT2(userid, id_exam, id_q, search_bigo, ans_result_rate, ans_result_rate2, basic_ans_len, userid_ans_len) ");
        sql.append("Values(?, ?, ?, 2, ?, ?, ?, ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_exam);
			stm.setString(3, id_q);
			stm.setDouble(4, ans_result_rate);
			stm.setDouble(5, ans_result_rate);
			stm.setInt(6, basic_ans_len);
			stm.setInt(7, userid_ans_len);
			rst = stm.executeQuery();
        }
        catch (SQLException ex) {
			DelResult(id_exam, id_q);
            throw new QmTmException("[Score_AnsNon.InsAresult]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static Score_AnsNonBean[] getAnswers(String id_exam, String id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select userid, nvl(userans1, ' '), nvl(userans2, ' '), nvl(userans3, ' '), ");
		sql.append("       nvl(userans4, ' '), nvl(userans5, ' '), nvl(userans6, ' ') ");
		sql.append("From exam_ans_non ");
		sql.append("Where id_exam = ? and id_q = ? and length(userans1) > 0 ");
		sql.append("Order by userid ");
		
        try
        {	
			Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setString(2, id_q);
            rst = stm.executeQuery();
            Score_AnsNonBean bean = null;
            while (rst.next()) {
                bean = makeAnswers(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (Score_AnsNonBean[]) beans.toArray(new Score_AnsNonBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_AnsNon.getAnswers]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static Score_AnsNonBean makeAnswers (ResultSet rst) throws QmTmException
    {
		try {
            Score_AnsNonBean bean = new Score_AnsNonBean();
            bean.setUserid(rst.getString(1));
            bean.setUserans1(rst.getString(2));
            bean.setUserans2(rst.getString(3));
            bean.setUserans3(rst.getString(4));
			bean.setUserans4(rst.getString(5));
			bean.setUserans5(rst.getString(6));
			bean.setUserans6(rst.getString(7));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[Score_AnsNon.makeAnswers]" + ex.getMessage());
        }
    }

	public static void UpSresult(String userid, String id_exam, String id_q, double search_result_rate, int search_result_rate2) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

        sql.append("Update EQUAL_TEST_RESULT2 ");
        sql.append("Set search_resutl_rate = ?, search_resutl_rate2 = ? ");
        sql.append("Where userid = ? and id_exam = ? and id_q = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(3, userid);
			stm.setString(4, id_exam);
			stm.setInt(5, Integer.parseInt(id_q));
			stm.setDouble(1, search_result_rate);
			stm.setDouble(2, search_result_rate2);
			rst = stm.executeQuery();
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_AnsNon.UpSresult]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void UpAresult(String userid, String id_exam, String id_q, double ans_result_rate, double ans_result_rate2, int basic_ans_len, int userid_ans_len) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

        sql.append("Update EQUAL_TEST_RESULT2 ");
        sql.append("Set ans_result_rate = ?, ans_result_rate2 = ?, basic_ans_len = ?, userid_ans_len = ? ");
        sql.append("Where userid = ? and id_exam = ? and id_q = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(5, userid);
			stm.setString(6, id_exam);
			stm.setString(7, id_q);
			stm.setDouble(1, ans_result_rate);
			stm.setDouble(2, ans_result_rate2);
			stm.setInt(3, basic_ans_len);
			stm.setInt(4, userid_ans_len);
			rst = stm.executeQuery();
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_AnsNon.UpAresult]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	

	public static void DelResult(String id_exam, String id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

        sql.append("Delete From EQUAL_TEST_RESULT2 Where id_exam = ? and id_q = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setString(2, id_q);
			rst = stm.executeQuery();
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_AnsNon.DelResult]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static String getUserName(String userid) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select name ");
		sql.append("From qt_userid ");
		sql.append("Where userid = ?");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
            rst = stm.executeQuery();
            
            if (rst.next()) return rst.getString("name");
            else return null; 
            
        } catch (SQLException ex) {
            throw new QmTmException("[Score_AnsNon.getUserName]" + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
    
}