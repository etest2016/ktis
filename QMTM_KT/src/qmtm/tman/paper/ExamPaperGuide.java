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
import java.sql.PreparedStatement;

public class ExamPaperGuide
{
    public ExamPaperGuide() {
    }
	
	public static void insert(ExamPaperGuideBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "INSERT INTO exam_paper_guide (id_exam, nr_q, guide_msg) VALUES (?, ?, ?) ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, bean.getId_exam());
            stm.setInt(2, bean.getNr_q());
			stm.setString(3, bean.getGuide_msg());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("영역 안내문 정보 등록하는 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperGuide.insert]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(ExamPaperGuideBean bean, String id_exam, int nr_qs) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "UPDATE exam_paper_guide SET nr_q = ?, guide_msg = ? Where id_exam = ? and nr_q = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setInt(1, bean.getNr_q());
			stm.setString(2, bean.getGuide_msg());
			stm.setString(3, id_exam);
			stm.setInt(4, nr_qs);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("영역 안내문 정보 수정하는 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperGuide.update]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_exam, int nr_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM exam_paper_guide Where id_exam = ? and nr_q = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_exam);
			stm.setInt(2, nr_q);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("영역 안내문 정보 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperGuide.delete]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamPaperGuideBean[] getBeans(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		sql = "SELECT nr_q, guide_msg FROM exam_paper_guide Where id_exam = ? Order by nr_q ";

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_exam);
            rst = stm.executeQuery();
            ExamPaperGuideBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamPaperGuideBean[]) beans.toArray(new ExamPaperGuideBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("영역 안내문 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperGuide.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static ExamPaperGuideBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamPaperGuideBean bean = new ExamPaperGuideBean();
            bean.setNr_q(rst.getInt(1));
            bean.setGuide_msg(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("영역 안내문 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperGuide.makeBeans]");
        }
    }

	public static ExamPaperGuideBean getBean(String id_exam, int nr_q) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		String sql = "SELECT guide_msg FROM exam_paper_guide WHERE id_exam = ? and nr_q = ? ";

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql);
			stm.setString(1, id_exam);
			stm.setInt(2, nr_q);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("영역 안내문 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperGuide.getBean]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static ExamPaperGuideBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamPaperGuideBean bean = new ExamPaperGuideBean();
            bean.setGuide_msg(rst.getString(1));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("영역 안내문 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperGuide.makeBean]");
        }
    }

	public static int getPaperQcnt(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		sql = "select max(nr_q) as q_cnt from exam_paper2 where id_exam = ? and nr_set = 1 ";

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getInt("q_cnt"); 
            else return 0; 
        } catch (SQLException ex) {
            throw new QmTmException("시험지 출제문항 갯수 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamPaperGuide.getPaperQcnt]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}