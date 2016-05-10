package etest.paper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import qmtm.DBPool;
import qmtm.QmTmException;

public class User_PaperList2 {
	public User_PaperList2() {
	}

	public static User_PaperList2Bean[] getBeans(String id_exam)
			throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT nr_q, guide_msg "); 
		sql.append("FROM exam_paper_guide ");
		sql.append("WHERE id_exam = ? ");  
		sql.append("ORDER BY nr_q ");

		try {
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			rst = stm.executeQuery();
			User_PaperList2Bean bean = null;
			while (rst.next()) {
				bean = makeBeans(rst);
				beans.add(bean);
			}
			if (bean == null) {
				return null;
			} else {
				return (User_PaperList2Bean[]) beans.toArray(new User_PaperList2Bean[0]);
			}
		} catch (SQLException ex) {
			throw new QmTmException("영역안내문 정보 읽어오는중 오류가 발생되었습니다. [User_PaperList2.getBeans] " +ex.getMessage());
		} finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) { }
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	private static User_PaperList2Bean makeBeans(ResultSet rst) throws QmTmException {

		try {
			User_PaperList2Bean bean = new User_PaperList2Bean();
			bean.setNr_q(rst.getInt(1));
			bean.setGuide_msg(rst.getString(2));
			return bean;
		} catch (SQLException ex) {
			throw new QmTmException("영역안내문 정보 읽어오는중 오류가 발생되었습니다. [User_PaperList2.makeBeans] " +ex.getMessage());
		}
	}
}
