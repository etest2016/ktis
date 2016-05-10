package qmtm.common;

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

public class WorkQLog
{
    public WorkQLog() {}

    public static void insert(WorkQLogBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO worker_q_log(id_subject, id_chapter, id_chapter2, id_chapter3, id_chapter4, userid, gubun, id_q, bigo, regdate) ");
        sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, getdate()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_subject());
			stm.setString(2, bean.getId_chapter());
			stm.setString(3, bean.getId_chapter2());
			stm.setString(4, bean.getId_chapter3());
			stm.setString(5, bean.getId_chapter4());
			stm.setString(6, bean.getUserid());
			stm.setString(7, bean.getGubun());
            stm.setString(8, bean.getId_q());
			stm.setString(9, bean.getBigo());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관련 로그 등록 중 오류가 발생되었습니다. [WorkQLog.insert] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static int getCounts(String gubun, String start_date, String field, String str) throws QmTmException {
		
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Select count(b.sid) as cnts ");
		sql.append("From q_subject a inner join worker_q_log b on a.id_q_subject = b.id_subject ");
        sql.append("     left outer join view_qt_workerid c on b.userid = c.userid ");
		sql.append("Where convert(varchar(10), b.regdate, 120) = ? ");
		if(!gubun.equals("")) {
			sql.append("      and b.gubun = ? ");
		}

		if(!field.equals("")) {
			sql.append("      and "+field+" like '%'+?+'%' ");
		}

		try {
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, start_date);
			int i = 1;
			if(!gubun.equals("")) {
				i = i + 1;
				stm.setString(i, gubun);
			}

			if(!field.equals("")) {
				i = i + 1;
				stm.setString(i, str);
			}
			rst = stm.executeQuery();

			if (rst.next()) {
				return rst.getInt("cnts");
			} else {
				return 0;
			}

		} catch (SQLException ex) {
			throw new QmTmException("문제로그관리 정보 읽어오는 중 오류가 발생되었습니다. [WorkQLog.getCounts] " +ex.getMessage());
		} finally {
			if (rst != null)    try {   rst.close();    } catch (SQLException ex) {}
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static WorkQLogBean[] getBeans(int list_cnt, int lists, String gubun, String start_date, String field, String str) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select top "+list_cnt+" a.q_subject, b.id_chapter, b.id_chapter2,  b.sid, b.userid, isnull(c.name, '관리자') name, b.gubun, b.bigo, convert(varchar(16), b.regdate, 120) regdate ");
		sql.append("From q_subject a inner join worker_q_log b on a.id_q_subject = b.id_subject "); 
		sql.append("     left outer join view_qt_workerid c on b.userid = c.userid "); 
		sql.append("Where b.sid not in ");
		sql.append("     (Select top "+lists+" b.sid ");
		sql.append("	  From q_subject a inner join worker_q_log b on a.id_q_subject = b.id_subject "); 
		sql.append("           left outer join qt_workerid c on b.userid = c.userid "); 
		sql.append("      Where convert(varchar(10), b.regdate, 120) = ? ");
		if(!gubun.equals("")) {
			sql.append("      and b.gubun = ? ");
		}
		if(!field.equals("")) {
			sql.append("      and "+field+" like '%'+?+'%' ");
		}
		sql.append("      Order by b.regdate desc ) ");
		sql.append("      and convert(varchar(10), b.regdate, 120) = ? ");
		if(!gubun.equals("")) {
			sql.append("      and b.gubun = ? ");
		}
		if(!field.equals("")) {
			sql.append("      and "+field+" like '%'+?+'%' ");
		}
		sql.append("Order by b.regdate desc ");

        try
        {
            Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, start_date);
			int i = 1;
			if(!gubun.equals("")) {
				i = i + 1;
				stm.setString(i, gubun);
			}
			if(!field.equals("")) {
				i = i + 1;
				stm.setString(i, str);
			}
			
			i = i + 1;
			stm.setString(i, start_date);

			if(!gubun.equals("")) {
				i = i + 1;
				stm.setString(i, gubun);
			}
			if(!field.equals("")) {
				i = i + 1;
				stm.setString(i, str);
			}

			rst = stm.executeQuery();

            WorkQLogBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (WorkQLogBean[]) beans.toArray(new WorkQLogBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제로그관리 정보 읽어오는 중 오류가 발생되었습니다. [WorkExamLog.getBeans] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static WorkQLogBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            WorkQLogBean bean = new WorkQLogBean();
			bean.setSubject(rst.getString(1));
			bean.setId_chapter(rst.getString(2));
			bean.setId_chapter2(rst.getString(3));
			bean.setSid(rst.getInt(4));
			bean.setUserid(rst.getString(5));
			bean.setName(rst.getString(6));
			bean.setGubun(rst.getString(7));
			bean.setBigo(rst.getString(8));
			bean.setRegdate(rst.getString(9));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제로그관리 정보 읽어오는 중 오류가 발생되었습니다. [WorkExamLog.makeBeans] " +ex.getMessage());
        }
    }

	public static String getChapter(String id_chapter) throws QmTmException {
		
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Select chapter ");
		sql.append("From q_chapter ");
		sql.append("Where id_q_chapter = ? ");	

		try {
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_chapter);
			
			rst = stm.executeQuery();

			if (rst.next()) {
				return rst.getString("chapter");
			} else {
				return "단원없음";
			}

		} catch (SQLException ex) {
			throw new QmTmException("단원명 정보 읽어오는 중 오류가 발생되었습니다. [WorkQLog.getChapter] " +ex.getMessage());
		} finally {
			if (rst != null)    try {   rst.close();    } catch (SQLException ex) {}
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}
	
}