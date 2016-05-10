package qmtm.tman.exam;

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

public class QchangeUtil
{
    public QchangeUtil() {
    }
		
	public static QchangeBean[] getBeans(String id_exam, String id_subject, String id_chapter, String id_q, String id_qtype, int posStart, int count) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT RowNum, id_q, q, ex1, ex2, ex3, ex4, ex5, ca, id_qtype, case when id_qtype = 1 then 'OX형' when id_qtype = 2 then '선다형' when id_qtype = 3 then '복수답안형' ");
		sql.append("       when id_qtype = 4 then '단답형'  when id_qtype = 5 then '논술형' end qtype, excount, cacount, difficulty, ");
        sql.append("       convert(varchar(10), regdate, 120) regdate, correct_pct, make_cnt ");
		sql.append("FROM ( ");
		sql.append("	  Select a.id_q, q, ex1, ex2, ex3, ex4, ex5, a.ca, a.id_qtype, case when a.id_qtype = 1 then 'OX형' when a.id_qtype = 2 then '선다형' when a.id_qtype = 3 then '복수답안형' ");
        sql.append("		     when a.id_qtype = 4 then '단답형'  when a.id_qtype = 5 then '논술형' end qtype, a.excount, a.cacount, b.difficulty, ");
        sql.append("			 convert(varchar(10), a.regdate, 120) regdate, a.correct_pct, c.make_cnt, "); 
        sql.append("			 ROW_NUMBER() OVER (ORDER BY a.id_q) AS RowNum ");
		sql.append("	  From q a, r_difficulty b, make_q c ");
		sql.append("      Where a.id_subject = ? ");
		sql.append("            and a.id_q not in ");
		sql.append("            ( Select distinct id_q From exam_paper2 Where id_exam = ? ) ");
		if(!id_chapter.equals("0")) {
			sql.append("            and a.id_chapter = ? ");
		}
		sql.append("            and a.id_q <> ? ");
		if(id_qtype.equals("5")) {
			sql.append("      and a.id_qtype = 5 ");
		}
		sql.append("    	  and a.id_valid_type = 0 and a.id_difficulty1 = b.id_difficulty and a.id_q = c.id_q ");
		sql.append(") as MyDerivedTable ");
		sql.append("WHERE MyDerivedTable.RowNum BETWEEN ? AND (? + ?) ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_subject);
			stm.setString(2, id_exam);
			if(!id_chapter.equals("0")) {
				stm.setString(3, id_chapter);
				stm.setString(4, id_q);
				stm.setInt(5, posStart);
				stm.setInt(6, posStart);
				stm.setInt(7, count);
			} else {
				stm.setString(3, id_q);
				stm.setInt(4, posStart);
				stm.setInt(5, posStart);
				stm.setInt(6, count);
			}
            rst = stm.executeQuery();
            QchangeBean bean = null;
            while (rst.next()) {
                bean = makeLists(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QchangeBean[]) beans.toArray(new QchangeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 오류가 발생되었습니다. [QchangeUtil.getBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static QchangeBean makeLists (ResultSet rst) throws QmTmException
    {
		try {
			QchangeBean bean = new QchangeBean();
			bean.setRownum(rst.getString(1));
			bean.setId_q(rst.getString(2));
            bean.setQ(rst.getString(3));
			bean.setEx1(rst.getString(4));
			bean.setEx2(rst.getString(5));
			bean.setEx3(rst.getString(6));
			bean.setEx4(rst.getString(7));
			bean.setEx5(rst.getString(8));
			bean.setCa(rst.getString(9));
			bean.setId_qtype(rst.getString(10));
			bean.setQtype(rst.getString(11));
			bean.setExcount(rst.getString(12));
			bean.setCacount(rst.getString(13));
			bean.setDifficulty(rst.getString(14));
			bean.setRegdate(rst.getString(15));			
			bean.setCorrect_pct(rst.getString(16));			
			bean.setCnt(rst.getString(17));
			return bean;
        } catch (SQLException ex) {
            throw new QmTmException("등록된 문제정보를 읽어오는 중 오류가 발생되었습니다. [QchangeUtil.makeLists] " + ex.getMessage());
        }
	}

	public static int getCnt(String id_exam, String id_subject, String id_chapter, String id_q, String id_qtype) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(a.id_q) as cnt ");
		sql.append("From q a, r_difficulty b, make_q c ");
		sql.append("Where a.id_subject = ? ");
		sql.append("      and a.id_q not in ");
		sql.append("      ( Select distinct id_q From exam_paper2 Where id_exam = ? ) ");
		if(!id_chapter.equals("0")) {
			sql.append("      and a.id_chapter = ? ");
		}
		sql.append("      and a.id_q <> ? ");
		if(id_qtype.equals("5")) {
			sql.append("      and a.id_qtype = 5 ");
		}
		sql.append("	  and a.id_valid_type = 0 and a.id_difficulty1 = b.id_difficulty and a.id_q = c.id_q "); 

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_subject);
			stm.setString(2, id_exam);
			if(!id_chapter.equals("0")) {
				stm.setString(3, id_chapter);
				stm.setString(4, id_q);
			} else {				
				stm.setString(3, id_q);
			}
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("문제 정보를 읽어오는 중 오류가 발생되었습니다.[QchangeUtil.getCnt] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void qChange(String id_exam, long org_id_q, long new_id_q, String ex_order) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update exam_paper2 ");
		sql.append("       SET id_q = ?, ex_order = ? ");
        sql.append("Where id_exam = ? and id_q = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setLong(1, new_id_q);
			stm.setString(2, ex_order);
			stm.setString(3, id_exam);
			stm.setLong(4, org_id_q);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 문제 교체 작업하는 중 오류가 발생되었습니다. [QchangeUtil.qChange] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
}