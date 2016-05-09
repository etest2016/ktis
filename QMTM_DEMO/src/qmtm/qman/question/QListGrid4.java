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

public class QListGrid4
{
    public QListGrid4() {
    }
		
	/* 모듈 선택시 쿼리 */
	public static QListGridBean[] getUBeans(String id_subject, String id_chapter, String id_chapter2, String id_chapter3, String id_chapter4, int posStart, int count) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select RowNum, id_q, ca, id_qtype, case when id_qtype = 1 then 'OX형' when id_qtype = 2 then '선다형' when id_qtype = 3 then '복수답안형' ");
		sql.append("       when id_qtype = 4 then '단답형'  when id_qtype = 5 then '논술형' end qtype, excount, cacount, difficulty, ");
		//sql.append("       convert(varchar(10), regdate, 120) regdate, q ");
		sql.append("       regdate, q ");
		sql.append("From ( ");
		sql.append("	  Select a.id_q, a.ca, a.id_qtype, case when a.id_qtype = 1 then 'OX형' when a.id_qtype = 2 then '선다형' when a.id_qtype = 3 then '복수답안형' ");
		sql.append("			 when a.id_qtype = 4 then '단답형'  when a.id_qtype = 5 then '논술형' end qtype, a.excount, a.cacount, b.difficulty, ");
		//sql.append("			 convert(varchar(10), a.regdate, 120) regdate, a.q, ");
		sql.append("			 to_char(a.regdate, 'YYYY-MM-DD') regdate, a.q, ");
        sql.append("			 ROW_NUMBER() OVER (ORDER BY a.id_q) AS RowNum ");
		sql.append("From q as a inner join  r_difficulty as b on a.id_difficulty1 = b.id_difficulty ");
		sql.append("     inner join make_q as c on a.id_q = c.id_q ");
		sql.append("Where a.id_subject = ? and a.id_chapter = ? and a.id_chapter2 = ? and a.id_chapter3 = ? and a.id_chapter4 = ? ");
		sql.append("     ) as MyDerivedTable ");
		sql.append("WHERE MyDerivedTable.RowNum BETWEEN ? AND (? + ?) ");
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_subject);
			stm.setString(2, id_chapter);
			stm.setString(3, id_chapter2);
			stm.setString(4, id_chapter3);
			stm.setString(5, id_chapter4);
			stm.setInt(6, posStart);
			stm.setInt(7, posStart);
			stm.setInt(8, count);
            rst = stm.executeQuery();
            QListGridBean bean = null;
            while (rst.next()) {
                bean = makeLists(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QListGridBean[]) beans.toArray(new QListGridBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 오류가 발생되었습니다. [QListGrid4.getUBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static QListGridBean makeLists (ResultSet rst) throws QmTmException
    {
		try {
			QListGridBean bean = new QListGridBean();
			bean.setRownum(rst.getString(1));
			bean.setId_q(rst.getString(2));
            bean.setCa(rst.getString(3));
			bean.setId_qtype(rst.getString(4));
			bean.setQtype(rst.getString(5));
			bean.setExcount(rst.getString(6));
			bean.setCacount(rst.getString(7));
			bean.setDifficulty(rst.getString(8));
			bean.setRegdate(rst.getString(9));
			bean.setQ(rst.getString(10));
			return bean;
        } catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 오류가 발생되었습니다. [QListGrid4.makeLists] " + ex.getMessage());
        }
	}

	public static int getCnt(String id_subject, String id_chapter, String id_chapter2, String id_chapter3, String id_chapter4) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(a.id_q) as cnt ");
		sql.append("From q as a inner join  r_difficulty as b on a.id_difficulty1 = b.id_difficulty ");
		sql.append("     inner join make_q as c on a.id_q = c.id_q ");
		sql.append("Where a.id_subject = ? and a.id_chapter = ? and a.id_chapter2 = ? and a.id_chapter3 = ? and a.id_chapter4 = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_subject);
			stm.setString(2, id_chapter);
			stm.setString(3, id_chapter2);
			stm.setString(4, id_chapter3);
			stm.setString(5, id_chapter4);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 오류가 발생되었습니다.[QListGrid4.getCnt] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static QListGridBean[] getExcelBeans(String id_qs) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_q, a.ca, a.id_qtype, case when a.id_qtype = 1 then 'OX형' when a.id_qtype = 2 then '선다형' when a.id_qtype = 3 then '복수답안형' ");
		sql.append("  	   when a.id_qtype = 4 then '단답형'  when a.id_qtype = 5 then '논술형' end qtype, a.excount, a.cacount, b.difficulty, ");
		//sql.append("	   convert(varchar(10), a.regdate, 120) regdate, ");
		sql.append("	   to_char(a.regdate, 'YYYY-MM-DD') regdate, ");
		sql.append("       c.make_cnt, a.q, a.ex1, a.ex2, a.ex3, a.ex4, a.ex5, a.explain, a.userid, a.id_valid_type, f.course, d.q_subject, e.chapter ");
		sql.append("From q as a inner join  r_difficulty as b on a.id_difficulty1 = b.id_difficulty ");
		sql.append("     inner join make_q as c on a.id_q = c.id_q ");
		sql.append("     inner join q_subject as d on a.ID_SUBJECT = d.ID_Q_SUBJECT ");
		sql.append("     inner join Q_CHAPTER as e on a.ID_CHAPTER = e.id_q_chapter ");
		sql.append("     inner join C_COURSE as f on d.ID_COURSE = f.id_course ");
		sql.append("Where a.id_q in (" + id_qs + ") ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();
 	        rst = stm.executeQuery(sql.toString());
            QListGridBean bean = null;
            while (rst.next()) {
                bean = makeExcel(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QListGridBean[]) beans.toArray(new QListGridBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 오류가 발생되었습니다. [QListGrid4.getExcelBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static QListGridBean makeExcel (ResultSet rst) throws QmTmException
    {
		try {
			QListGridBean bean = new QListGridBean();
			bean.setId_q(rst.getString(1));
            bean.setCa(rst.getString(2));
			bean.setId_qtype(rst.getString(3));
			bean.setQtype(rst.getString(4));
			bean.setExcount(rst.getString(5));
			bean.setCacount(rst.getString(6));
			bean.setDifficulty(rst.getString(7));
			bean.setRegdate(rst.getString(8));
			bean.setCnt(rst.getString(9));
			bean.setQ(rst.getString(10));
			bean.setEx1(rst.getString(11));
			bean.setEx2(rst.getString(12));
			bean.setEx3(rst.getString(13));
			bean.setEx4(rst.getString(14));
			bean.setEx5(rst.getString(15));
			bean.setExplain(rst.getString(16));
			bean.setUserid(rst.getString(17));
			bean.setId_valid_type(rst.getString(18));
			bean.setCourse(rst.getString(19));
			bean.setQ_subject(rst.getString(20));
			bean.setChapter(rst.getString(21));
			return bean;
        } catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 오류가 발생되었습니다. [QListGrid4.makeExcel] " + ex.getMessage());
        }
	}
	
}