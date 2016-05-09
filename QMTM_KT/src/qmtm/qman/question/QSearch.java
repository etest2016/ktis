package qmtm.qman.question;

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

public class QSearch
{
    public QSearch() {
    }	

	// 문제 검색결과 가지고 오기
	public static QSearchListBean[] getSearchBeans(QSearchBean bean, String userid) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_subject, a.id_q, c.qtype, d.difficulty, b.make_cnt, a.q ");
		sql.append("From q a, make_q b, r_qtype c, r_difficulty d ");
		sql.append("Where a.id_qtype = c.id_qtype ");
		sql.append("	  and a.id_q = b.id_q and a.id_difficulty1 = d.id_difficulty ");

		// 문제유형 포함 검색
		if(!bean.getQtypes().equals("")) {
			sql.append("and a.id_qtype = "+ bean.getQtypes() +" ");
        }

		// 난이도 포함 검색
		if(!bean.getDifficultys().equals("")) {
			sql.append("and a.id_difficulty1 = "+ bean.getDifficultys() +" ");
        }

        // 출제 시작횟수 포함 검색
		if(!bean.getCnt1().equals("")) {
			sql.append("and b.make_cnt >= '"+ bean.getCnt1() +"' ");
        }

		// 출제 종료횟수 포함 검색
		if(!bean.getCnt2().equals("")) {
			sql.append("and b.make_cnt <= '"+ bean.getCnt2() +"' ");
        }

		// 문제코드 포함 검색
		if(!bean.getId_qs1().equals("")) {
			sql.append("and a.id_q = '"+ bean.getId_qs1() +"' ");
        }

		// 오류문제 포함 검색
		if(!bean.getIncorrect1().equals("")) {
			sql.append("and a.id_valid_type = '"+ bean.getIncorrect1() +"' ");
        } else {
			sql.append("and a.id_valid_type = 0 ");
		}

		// 문항명 포함 검색
		if(bean.getQs().equals("Y")) {
			sql.append("and a.q like '%"+ bean.getQs1() +"%' ");
        } 

		sql.append("Order by a.id_q desc ");

		System.out.println(sql.toString());

        try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.createStatement();        
		    rst = stm.executeQuery(sql.toString());

			QSearchListBean bean2 = null;
            while(rst.next()) {
				bean2 = makeSearchBeans2(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (QSearchListBean[]) beans.toArray(new QSearchListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException(ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	// 문제 검색결과 가지고 오기
	public static QSearchListBean[] getSearchBeans(QSearchBean bean, String id_subject, String userid) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_subject, a.id_q, c.qtype, d.difficulty, b.make_cnt, a.q ");
		sql.append("From q a, make_q b, r_qtype c, r_difficulty d ");
		sql.append("Where a.id_subject = '"+id_subject+"' and a.id_chapter in ('0', '1') and a.id_qtype = c.id_qtype ");
		sql.append("	  and a.id_q = b.id_q and a.id_difficulty1 = d.id_difficulty ");

		// 문제유형 포함 검색
		if(!bean.getQtypes().equals("")) {
			sql.append("and a.id_qtype = "+ bean.getQtypes() +" ");
        }

		// 난이도 포함 검색
		if(!bean.getDifficultys().equals("")) {
			sql.append("and a.id_difficulty1 = "+ bean.getDifficultys() +" ");
        }

        // 출제 시작횟수 포함 검색
		if(!bean.getCnt1().equals("")) {
			sql.append("and b.make_cnt >= '"+ bean.getCnt1() +"' ");
        }

		// 출제 종료횟수 포함 검색
		if(!bean.getCnt2().equals("")) {
			sql.append("and b.make_cnt <= '"+ bean.getCnt2() +"' ");
        }

		// 문제코드 포함 검색
		if(!bean.getId_qs1().equals("")) {
			sql.append("and a.id_q = '"+ bean.getId_qs1() +"' ");
        }

		// 오류문제 포함 검색
		if(!bean.getIncorrect1().equals("")) {
			sql.append("and a.id_valid_type = '"+ bean.getIncorrect1() +"' ");
        } else {
			sql.append("and a.id_valid_type = 0 ");
		}

		// 문항명 포함 검색
		if(bean.getQs().equals("Y")) {
			sql.append("and a.q like '%"+ bean.getQs1() +"%' ");
        } 

		sql.append("Order by a.id_q desc ");

        try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.createStatement();        
		    rst = stm.executeQuery(sql.toString());

			QSearchListBean bean2 = null;
            while(rst.next()) {
				bean2 = makeSearchBeans2(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (QSearchListBean[]) beans.toArray(new QSearchListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제검색 작업 중 인터넷 연결상태가 좋지 않습니다. [QSearch.getSearchBeans()]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	// 문제 검색결과 가지고 오기
	public static QSearchListBean[] getSearchBeans(QSearchBean bean, String id_subject, String id_chapter, String userid) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_subject, a.id_q, c.qtype, d.difficulty, b.make_cnt, a.q ");
		sql.append("From q a, make_q b, r_qtype c, r_difficulty d ");
		sql.append("Where a.id_subject = '"+id_subject+"' and a.id_chapter = '"+id_chapter+"' and a.id_chapter2 in ('0', '-1') ");
		sql.append("	  and a.id_qtype = c.id_qtype and a.id_q = b.id_q and a.id_difficulty1 = d.id_difficulty ");

		// 문제유형 포함 검색
		if(!bean.getQtypes().equals("")) {
			sql.append("and a.id_qtype = "+ bean.getQtypes() +" ");
        }

		// 난이도 포함 검색
		if(!bean.getDifficultys().equals("")) {
			sql.append("and a.id_difficulty1 = "+ bean.getDifficultys() +" ");
        }

        // 출제 시작횟수 포함 검색
		if(!bean.getCnt1().equals("")) {
			sql.append("and b.make_cnt >= '"+ bean.getCnt1() +"' ");
        }

		// 출제 종료횟수 포함 검색
		if(!bean.getCnt2().equals("")) {
			sql.append("and b.make_cnt <= '"+ bean.getCnt2() +"' ");
        }

		// 문제코드 포함 검색
		if(!bean.getId_qs1().equals("")) {
			sql.append("and a.id_q = '"+ bean.getId_qs1() +"' ");
        }

		// 오류문제 포함 검색
		if(!bean.getIncorrect1().equals("")) {
			sql.append("and a.id_valid_type = '"+ bean.getIncorrect1() +"' ");
        } 

		// 문항명 포함 검색
		if(bean.getQs().equals("Y")) {
			sql.append("and a.q like '%"+ bean.getQs1() +"%' ");
        } 

		sql.append("Order by a.id_q desc ");

        try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.createStatement();        
		    rst = stm.executeQuery(sql.toString());

			QSearchListBean bean2 = null;
            while(rst.next()) {
				bean2 = makeSearchBeans2(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (QSearchListBean[]) beans.toArray(new QSearchListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException(ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	// 문제 검색결과 가지고 오기
	public static QSearchListBean[] getSearchBeans(QSearchBean bean, String id_subject, String id_chapter, String id_chapter2, String userid) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_subject, a.id_q, c.qtype, d.difficulty, b.make_cnt, a.q ");
		sql.append("From q a, make_q b, r_qtype c, r_difficulty d ");
		sql.append("Where a.id_subject = '"+id_subject+"' and a.id_chapter = '"+id_chapter+"' and a.id_chapter2 = '"+id_chapter2+"' ");
		sql.append("	  and a.id_chapter3 in ('0', '-1') and a.id_qtype = c.id_qtype and a.id_q = b.id_q and a.id_difficulty1 = d.id_difficulty ");

		// 문제유형 포함 검색
		if(!bean.getQtypes().equals("")) {
			sql.append("and a.id_qtype = "+ bean.getQtypes() +" ");
        }

		// 난이도 포함 검색
		if(!bean.getDifficultys().equals("")) {
			sql.append("and a.id_difficulty1 = "+ bean.getDifficultys() +" ");
        }

        // 출제 시작횟수 포함 검색
		if(!bean.getCnt1().equals("")) {
			sql.append("and b.make_cnt >= '"+ bean.getCnt1() +"' ");
        }

		// 출제 종료횟수 포함 검색
		if(!bean.getCnt2().equals("")) {
			sql.append("and b.make_cnt <= '"+ bean.getCnt2() +"' ");
        }

		// 문제코드 포함 검색
		if(!bean.getId_qs1().equals("")) {
			sql.append("and a.id_q = '"+ bean.getId_qs1() +"' ");
        }

		// 오류문제 포함 검색
		if(!bean.getIncorrect1().equals("")) {
			sql.append("and a.id_valid_type = '"+ bean.getIncorrect1() +"' ");
        }
		
		// 문항명 포함 검색
		if(bean.getQs().equals("Y")) {
			sql.append("and a.q like '%"+ bean.getQs1() +"%' ");
        } 

		sql.append("Order by a.id_q desc ");

        try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.createStatement();        
		    rst = stm.executeQuery(sql.toString());

			QSearchListBean bean2 = null;
            while(rst.next()) {
				bean2 = makeSearchBeans2(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (QSearchListBean[]) beans.toArray(new QSearchListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제검색 작업 중 인터넷 연결상태가 좋지 않습니다. [QSearch.getSearchBeans()]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	// 문제 검색결과 가지고 오기
	public static QSearchListBean[] getSearchBeans(QSearchBean bean, String id_subject, String id_chapter, String id_chapter2, String id_chapter3, String userid) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_subject, a.id_q, c.qtype, d.difficulty, b.make_cnt, a.q ");
		sql.append("From q a, make_q b, r_qtype c, r_difficulty d ");
		sql.append("Where a.id_subject = '"+id_subject+"' and a.id_chapter = '"+id_chapter+"' and a.id_chapter2 = '"+id_chapter2+"' ");
		sql.append("	  and a.id_chapter3 = '"+id_chapter3+"' and a.id_chapter4 in ('0', '-1') and ");
		sql.append("      a.id_qtype = c.id_qtype and a.id_q = b.id_q and a.id_difficulty1 = d.id_difficulty ");

		// 문제유형 포함 검색
		if(!bean.getQtypes().equals("")) {
			sql.append("and a.id_qtype = "+ bean.getQtypes() +" ");
        }

		// 난이도 포함 검색
		if(!bean.getDifficultys().equals("")) {
			sql.append("and a.id_difficulty1 = "+ bean.getDifficultys() +" ");
        }

        // 출제 시작횟수 포함 검색
		if(!bean.getCnt1().equals("")) {
			sql.append("and b.make_cnt >= '"+ bean.getCnt1() +"' ");
        }

		// 출제 종료횟수 포함 검색
		if(!bean.getCnt2().equals("")) {
			sql.append("and b.make_cnt <= '"+ bean.getCnt2() +"' ");
        }

		// 문제코드 포함 검색
		if(!bean.getId_qs1().equals("")) {
			sql.append("and a.id_q = '"+ bean.getId_qs1() +"' ");
        }

		// 오류문제 포함 검색
		if(!bean.getIncorrect1().equals("")) {
			sql.append("and a.id_valid_type = '"+ bean.getIncorrect1() +"' ");
        } 

		// 문항명 포함 검색
		if(bean.getQs().equals("Y")) {
			sql.append("and a.q like '%"+ bean.getQs1() +"%' ");
        } 

		sql.append("Order by a.id_q desc ");

        try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.createStatement();        
		    rst = stm.executeQuery(sql.toString());

			QSearchListBean bean2 = null;
            while(rst.next()) {
				bean2 = makeSearchBeans2(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (QSearchListBean[]) beans.toArray(new QSearchListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제검색 작업 중 인터넷 연결상태가 좋지 않습니다. [QSearch.getSearchBeans()]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	// 문제 검색결과 가지고 오기
	public static QSearchListBean[] getSearchBeans(QSearchBean bean, String id_subject, String id_chapter, String id_chapter2, String id_chapter3, String id_chapter4, String userid) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_subject, a.id_q, c.qtype, d.difficulty, b.make_cnt, a.q ");
		sql.append("From q a, make_q b, r_qtype c, r_difficulty d ");
		sql.append("Where a.id_subject = '"+id_subject+"' and a.id_chapter = '"+id_chapter+"' and a.id_chapter2 = '"+id_chapter2+"' ");
		sql.append("	  and a.id_chapter3 = '"+id_chapter3+"' and a.id_chapter4 = '"+id_chapter4+"' and ");
		sql.append("      a.id_qtype = c.id_qtype and a.id_q = b.id_q and a.id_difficulty1 = d.id_difficulty ");

		// 문제유형 포함 검색
		if(!bean.getQtypes().equals("")) {
			sql.append("and a.id_qtype = "+ bean.getQtypes() +" ");
        }

		// 난이도 포함 검색
		if(!bean.getDifficultys().equals("")) {
			sql.append("and a.id_difficulty1 = "+ bean.getDifficultys() +" ");
        }

        // 출제 시작횟수 포함 검색
		if(!bean.getCnt1().equals("")) {
			sql.append("and b.make_cnt >= '"+ bean.getCnt1() +"' ");
        }

		// 출제 종료횟수 포함 검색
		if(!bean.getCnt2().equals("")) {
			sql.append("and b.make_cnt <= '"+ bean.getCnt2() +"' ");
        }

		// 문제코드 포함 검색
		if(!bean.getId_qs1().equals("")) {
			sql.append("and a.id_q = '"+ bean.getId_qs1() +"' ");
        }

		// 오류문제 포함 검색
		if(!bean.getIncorrect1().equals("")) {
			sql.append("and a.id_valid_type = '"+ bean.getIncorrect1() +"' ");
        } 

		// 문항명 포함 검색
		if(bean.getQs().equals("Y")) {
			sql.append("and a.q like '%"+ bean.getQs1() +"%' ");
        } 

		sql.append("Order by a.id_q desc ");

        try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.createStatement();        
		    rst = stm.executeQuery(sql.toString());

			QSearchListBean bean2 = null;
            while(rst.next()) {
				bean2 = makeSearchBeans2(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (QSearchListBean[]) beans.toArray(new QSearchListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제검색 작업 중 인터넷 연결상태가 좋지 않습니다. [QSearch.getSearchBeans()]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static QSearchListBean makeSearchBeans2 (ResultSet rst) throws QmTmException
    {
		try {
            QSearchListBean bean = new QSearchListBean();

            bean.setId_subject(rst.getString(1));
			bean.setId_qs(rst.getString(2));
			bean.setQtypes(rst.getString(3));
			bean.setDifficulty(rst.getString(4));
			bean.setMake_cnt(rst.getInt(5));
			bean.setQs(rst.getString(6));
            return bean;

        } catch (SQLException ex) {
            throw new QmTmException("문제검색 작업 중 인터넷 연결상태가 좋지 않습니다. [QSearch.makeSearchBeans2()]");
        }
    }
}