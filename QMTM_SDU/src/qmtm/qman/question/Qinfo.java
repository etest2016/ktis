package qmtm.qman.question;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class Qinfo
{
    public Qinfo() {
    }	
	
	/* 문제 이동 */
	public static void Q_updates(String id_qs, QinfoBean bean) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update q set up_date = getdate() ");
		
		// 배점 업데이트
		if(bean.getQ_allots() != null) {
			sql.append(", allotting = '"+ bean.getQ_allots() +"' ");
        }
		
		// 난이도 업데이트
		if(bean.getQ_diffs() != null) {
			sql.append(", id_difficulty1 = '"+ bean.getQ_diffs() +"' ");
        }
		
		// 출판사 업데이트
		if(bean.getQ_pub_comps() != null) {
			sql.append(", src_pub_comp = '"+ bean.getQ_pub_comps() +"' ");
        }
		
		// 비고정보 업데이트
		if(bean.getQ_etcs() != null) {
			sql.append(", src_misc = '"+ bean.getQ_etcs() +"' ");
        }

		// 키워드 업데이트
		if(bean.getQ_kwds() != null) {
			sql.append(", find_kwd = '"+ bean.getQ_kwds() +"' ");
        }

		// 문제용도1 업데이트
		if(bean.getQ_uses() != null) {
			sql.append(", id_q_use = '"+ bean.getQ_uses() +"' ");
        }
		
		sql.append("Where id_q in (" + id_qs + ") ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();
		    stm.executeUpdate(sql.toString());
        }
        catch (SQLException ex) {
            throw new QmTmException("문제정보를 수정하는 중 오류가 발생되었습니다. [Qinfo.Q_updates] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}