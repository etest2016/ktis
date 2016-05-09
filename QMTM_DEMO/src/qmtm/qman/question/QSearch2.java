package qmtm.qman.question;

// Package Import
import qmtm.*; 

// Java API Import
import java.sql.*;
import java.util.*;

public class QSearch2
{
    public QSearch2() {
    }
	
	// 문제 검색결과 가지고 오기
	public static QSearchListBean[] getSearchBeans(QSearchBean bean, String userid, String term_id) throws QmTmException
    {
		Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_subject, a.id_q, a.q, c.q_subject, d.chapter, e.qtype, f.difficulty, b.make_cnt ");
		sql.append("From q a, make_q b, q_subject c, q_chapter d, r_qtype e, r_difficulty f ");
		sql.append("Where a.id_q = b.id_q and a.id_subject = c.id_q_subject and c.id_q_subject = d.id_q_subject ");
		sql.append("      and a.id_subject = d.id_q_subject and a.id_qtype = e.id_qtype and a.id_difficulty1 = f.id_difficulty ");
		
		// 문제유형 포함 검색
		if(bean.getQtes().equals("Y")) {
			sql.append("and a.id_qtype = '"+ bean.getQtypes() +"' ");
        }

		// 난이도 포함 검색
		if(bean.getDiffs().equals("Y")) {
			sql.append("and a.id_difficulty1 = '"+ bean.getDifficultys() +"' ");
        }

        // 출제 시작횟수 포함 검색
		if(bean.getCnts().equals("Y")) {
			if(!bean.getCnt1().equals("")) {
				sql.append("and b.make_cnt >= '"+ bean.getCnt1() +"' ");
			}
			if(!bean.getCnt2().equals("")) {
				sql.append("and b.make_cnt <= '"+ bean.getCnt2() +"' ");
			}
        }
		
		// 문제코드 포함 검색
		if(bean.getId_qs().equals("Y")) {
			sql.append("and a.id_q = '"+ bean.getId_qs1() +"' ");
        }

		// 오류문제 포함 검색
		if(bean.getIncorrects().equals("Y")) {
			sql.append("and a.id_valid_type = '"+ bean.getIncorrect1() +"' ");
        }
		
		// 문제명 포함 검색
		if(bean.getQs().equals("Y")) {
			sql.append("and a.q like '%"+ bean.getQs1() +"%' ");
        }

		sql.append("Order by c.q_subject, d.chapter, e.qtype, f.difficulty ");

		System.out.println(sql.toString());

        try
		{
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.createStatement();        
		    rst = stm.executeQuery(sql.toString());

			QSearchListBean bean2 = null;
            while(rst.next()) {
				bean2 = makeSearchBeans(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (QSearchListBean[]) beans.toArray(new QSearchListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[QSearch2.getSearchBeans]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static QSearchListBean makeSearchBeans (ResultSet rst) throws QmTmException
    {
		try {
            QSearchListBean bean = new QSearchListBean();

            bean.setId_subject(rst.getString(1));
			bean.setId_qs(rst.getString(2));
			bean.setQqs(rst.getString(3));
			bean.setSubject(rst.getString(4));
			bean.setChapter(rst.getString(5));			
			bean.setQtypes(rst.getString(6));
			bean.setDifficulty(rst.getString(7));
			bean.setMake_cnt(rst.getInt(8));			
            return bean;

        } catch (SQLException ex) {
            throw new QmTmException("[QSearch2.makeSearchBeans]" + ex.getMessage());
        }
    }
	
}