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

public class ExamPaperOption
{
    public ExamPaperOption() {
    }
	
	public static ExamPaperOptionBean getBean(String id_exam) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_exam, title, yn_sametime, limittime, qcount, ");
		sql.append("       allotting, id_randomtype, qcntperpage, ");
		sql.append("       convert(varchar(16), exam_start1, 120) exam_start, ");
		sql.append("       convert(varchar(16), exam_end1, 120) exam_end ");
		sql.append("From exam_m ");
		sql.append("Where id_exam = ? ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("시험 정보 읽어오는 중 오류가 발생되었습니다. [ExamPaperOption.getBean] " + ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static ExamPaperOptionBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamPaperOptionBean bean = new ExamPaperOptionBean();
            bean.setId_exam(rst.getString(1));
			bean.setTitle(rst.getString(2));
			bean.setYn_sametime(rst.getString(3));
			bean.setLimittime(rst.getInt(4));
			bean.setQcount(rst.getInt(5));
			bean.setAllotting(rst.getDouble(6));
			bean.setId_randomtype(rst.getString(7));
			bean.setQcntperpage(rst.getInt(8));
			bean.setExam_start(rst.getString(9));
			bean.setExam_end(rst.getString(10));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험 정보 읽어오는 중 오류가 발생되었습니다. [ExamPaperOption.makeBean] " + ex.getMessage());
        }
    }

	public static ExamPaperOptionBean[] getBeans(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select case when b.id_qtype = 1 then 'OX형' when b.id_qtype = 2 then '선다형' ");
		sql.append("       when b.id_qtype = 3 then '복수 답안형' when b.id_qtype = 4 then '단답형' ");
		sql.append("       when b.id_qtype = 5 then '논술형' end id_qtypes, ");
		sql.append("       count(b.id_qtype) as qtype_cnt, a.allotting ");
		sql.append("From exam_paper2 a, q b ");
		sql.append("Where id_exam = ? and nr_set = 1 and a.id_q = b.id_q ");
		sql.append("Group by id_qtype, a.allotting ");
		sql.append("Order by b.id_qtype ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
            rst = stm.executeQuery();
            ExamPaperOptionBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamPaperOptionBean[]) beans.toArray(new ExamPaperOptionBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험출제 정보 읽어오는 중 오류가 발생되었습니다. [ExamPaperOption.getBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static ExamPaperOptionBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            ExamPaperOptionBean bean = new ExamPaperOptionBean();
            bean.setId_qtype(rst.getString(1));
            bean.setQtype_cnt(rst.getInt(2));
			bean.setAllotting2(rst.getDouble(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험출제 정보 읽어오는 중 오류가 발생되었습니다. [ExamPaperOption.makeBeans] " + ex.getMessage());
        }
    }

	public static ExamPaperOptionBean[] getBeans2(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select c.chapter, case when b.id_qtype = 1 then 'OX형' when b.id_qtype = 2 then '선다형' ");
		sql.append("       when b.id_qtype = 3 then '복수 답안형' when b.id_qtype = 4 then '단답형' ");
		sql.append("       when b.id_qtype = 5 then '논술형' end id_qtypes, ");
		sql.append("       count(b.id_qtype) as qtype_cnt, a.allotting ");
		sql.append("From exam_paper2 a, q b, q_chapter c ");
		sql.append("Where id_exam = ? and nr_set = 1 and a.id_q = b.id_q and b.id_chapter = c.id_q_chapter ");
		sql.append("Group by c.chapter, id_qtype, a.allotting ");
		sql.append("Order by c.chapter, b.id_qtype ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
            rst = stm.executeQuery();
            ExamPaperOptionBean bean = null;
            while (rst.next()) {
                bean = makeBeans2(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamPaperOptionBean[]) beans.toArray(new ExamPaperOptionBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험출제 정보 읽어오는 중 오류가 발생되었습니다. [ExamPaperOption.getBeans2] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static ExamPaperOptionBean makeBeans2 (ResultSet rst) throws QmTmException
    {
		try {
            ExamPaperOptionBean bean = new ExamPaperOptionBean();
            bean.setChapter(rst.getString(1));
			bean.setId_qtype2(rst.getString(2));
            bean.setQtype_cnt2(rst.getInt(3));
			bean.setAllotting3(rst.getDouble(4));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험출제 정보 읽어오는 중 오류가 발생되었습니다. [ExamPaperOption.makeBeans] " + ex.getMessage());
        }
    }
}