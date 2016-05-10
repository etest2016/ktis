package qmtm.common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import qmtm.*;
import qmtm.QmTmException;

// for paper/etest.jsp

public class ExamPaper2 {
	
	public ExamPaper2() {
	}

	public static ExamPaper3Bean[] getBeans(String id_exam, int nr_set) throws QmTmException {
		// 문제세트 전체

		Connection cnn = null;
		PreparedStatement stm = null;
		ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT a.nr_q, a.id_q, a.ex_order, a.allotting, a.page, a.q_no1, a.q_no2, ");
        sql.append("       b.id_ref, b.id_qtype, b.excount, b.cacount, b.q, ");
        sql.append("       b.ex1, b.ex2, b.ex3, b.ex4, b.ex5, b.ca, b.hint, b.explain, b.id_valid_type, ");
        sql.append("       c.reftitle, c.refbody1, c.refbody2, c.refbody3, b.yn_single_line, b.ex_rowcnt ");
        sql.append("FROM exam_paper2 as a inner join q as b ");
        sql.append("     on a.id_q = b.id_q and a.id_exam = ? AND a.nr_set = ? ");
        sql.append("     left outer join q_ref as c on b.id_ref = c.id_ref ");
        sql.append("ORDER BY a.nr_q ");

		try {
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, nr_set);
			rst = stm.executeQuery();
			ExamPaper3Bean bean = null;
			while (rst.next()) {
				bean = makeBean(rst);
				beans.add(bean);
			}
			if (bean == null) {
				return null;
			} else {
				return (ExamPaper3Bean[]) beans.toArray(new ExamPaper3Bean[0]);
			}
		} catch (SQLException ex) {
			throw new QmTmException("[ExamPaper2.getBeans]" + ex.getMessage());
		} finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) { }
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	private static ExamPaper3Bean makeBean(ResultSet rst) throws QmTmException {
		try {
			ExamPaper3Bean bean = new ExamPaper3Bean();
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
			bean.setYn_single_line(rst.getString(26));
			bean.setEx_rowcnt(rst.getInt(27));			
			
			return bean;
		} catch (SQLException ex) {
			throw new QmTmException("[ExamPaper2.makeBean]" + ex.getMessage());
		}
	}
}
