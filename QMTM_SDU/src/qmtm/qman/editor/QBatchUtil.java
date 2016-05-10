package qmtm.qman.editor;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class QBatchUtil
{
    public QBatchUtil() {
    }

	public static void insert(QBatchBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO Q(id_subject, id_chapter, id_chapter2, id_chapter3, id_chapter4, id_ref, id_qtype, "); 
		sql.append("              excount, cacount, id_difficulty1, q, ex1, ex2, ex3, ex4, ex5, ca, explain, userid) "); 
        sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ");
		sql.append("        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_subject());
			stm.setString(2, bean.getId_chapter());
			stm.setString(3, bean.getId_chapter2());
            stm.setString(4, bean.getId_chapter3());
			stm.setString(5, bean.getId_chapter4());
			stm.setString(6, bean.getId_ref());
			stm.setInt(7, bean.getId_qtype());
			stm.setInt(8, bean.getExcount());
			stm.setInt(9, bean.getCacount());
			stm.setInt(10, bean.getId_difficulty1());
			stm.setString(11, bean.getQ());
			stm.setString(12, bean.getEx1());
			stm.setString(13, bean.getEx2());
			stm.setString(14, bean.getEx3());
			stm.setString(15, bean.getEx4());
			stm.setString(16, bean.getEx5());
			stm.setString(17, bean.getCa());
			stm.setString(18, bean.getExplain());
			stm.setString(19, bean.getUserid());
			
			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("문제 일괄 등록하는 중 오류가 발생되었습니다. [QBatchUtil.insert] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}