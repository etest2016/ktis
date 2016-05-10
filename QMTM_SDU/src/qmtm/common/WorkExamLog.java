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

public class WorkExamLog
{
    public WorkExamLog() {}

    public static void insert(WorkExamLogBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO worker_exam_log(id_exam, userid, gubun, id_q, bigo, regdate) ");
        sql.append("VALUES (?, ?, ?, ?, ?, getdate()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_exam());
			stm.setString(2, bean.getUserid());
			stm.setString(3, bean.getGubun());
            stm.setString(4, bean.getId_q());
			stm.setString(5, bean.getBigo());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관련 로그 등록 중 오류가 발생되었습니다. [WorkExamLog.insert] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static int getCounts(String gubun, String start_date, String field, String str) throws QmTmException {
		
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Select count(c.sid) as cnts ");
		sql.append("From c_course a inner join exam_m b on a.id_course = b.id_course  ");
		sql.append("     inner join worker_exam_log c on b.id_exam = c.id_exam ");
		sql.append("     inner join view_qt_workerid d on c.userid = d.userid ");
		sql.append("Where convert(varchar(10), c.regdate, 120) = ? ");
		if(!gubun.equals("")) {
			sql.append("      and c.gubun = ? ");
		}

		if(!field.equals("")) {
			sql.append("      and "+ field + " like '%'+?+'%' ");
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
			//	i = i + 1;
			//	stm.setString(i, field);
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
			throw new QmTmException("시험로그관리 정보 읽어오는 중 오류가 발생되었습니다. [WorkExamLog.getCounts] " +ex.getMessage());
		} finally {
			if (rst != null)    try {   rst.close();    } catch (SQLException ex) {}
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static WorkExamLogBean[] getBeans(int list_cnt, int lists, String gubun, String start_date, String field, String str) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select top " + list_cnt + " a.course, c.sid, c.id_exam, b.title, c.userid, isnull(d.name, '관리자') name, c.gubun, c.bigo, convert(varchar(16), c.regdate, 120) regdate ");
		sql.append("From c_course a inner join exam_m b on a.id_course = b.id_course "); 
		sql.append("     inner join worker_exam_log c on b.id_exam = c.id_exam "); 
		sql.append("     inner join view_qt_workerid d on c.userid = d.userid "); 
		sql.append("Where c.sid not in ");
		sql.append("     (Select top " + lists + " c.sid ");
		sql.append("	  From c_course a inner join exam_m b on a.id_course = b.id_course "); 
		sql.append("           inner join worker_exam_log c on b.id_exam = c.id_exam "); 
		sql.append("           inner join view_qt_workerid d on c.userid = d.userid "); 
		sql.append("      Where convert(varchar(10), c.regdate, 120) = ? ");
		if(!gubun.equals("")) {
			sql.append("      and c.gubun = ? ");
		}
		if(!field.equals("")) {
			sql.append("      and " + field + " like '%'+?+'%' ");
		}
		sql.append("      Order by c.regdate desc ) ");
		sql.append("      and convert(varchar(10), c.regdate, 120) = ? ");
		if(!gubun.equals("")) {
			sql.append("      and c.gubun = ? ");
		}
		if(!field.equals("")) {
			sql.append("      and " + field + " like '%'+?+'%' ");
		}
		sql.append("Order by c.regdate desc ");

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
				//i = i + 1;
				//stm.setString(i, field);
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
				//i = i + 1;
				//stm.setString(i, field);
				i = i + 1;
				stm.setString(i, str);
			}

			rst = stm.executeQuery();

            WorkExamLogBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (WorkExamLogBean[]) beans.toArray(new WorkExamLogBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험로그관리 정보 읽어오는 중 오류가 발생되었습니다. [WorkExamLog.getBeans] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static WorkExamLogBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            WorkExamLogBean bean = new WorkExamLogBean();
			bean.setCourse(rst.getString(1));
			bean.setSid(rst.getInt(2));
			bean.setId_exam(rst.getString(3));
			bean.setTitle(rst.getString(4));
			bean.setUserid(rst.getString(5));
			bean.setName(rst.getString(6));
			bean.setGubun(rst.getString(7));
			bean.setBigo(rst.getString(8));
			bean.setRegdate(rst.getString(9));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험로그관리 정보 읽어오는 중 오류가 발생되었습니다. [WorkExamLog.makeBeans] " +ex.getMessage());
        }
    }

}