package qmtm.tman.answer;

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

public class PaperNonExport
{
    public PaperNonExport() {
    }

	public static PaperNonExportBean getBeans(String id_exam, long id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select distinct a.id_q, b.q, a.allotting ");
		sql.append("From exam_paper2 a, q b ");
		sql.append("Where a.id_exam = ? and b.id_q = ? and b.id_qtype = 5 and a.id_q = b.id_q ");
		sql.append("Order by a.id_q ");
		
		try
        {
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());			       
			stm.setString(1, id_exam);
			stm.setLong(2, id_q);
		    rst = stm.executeQuery();

            if (rst.next()) {
				return makeAllBeans(rst);
			} else {
				return null;
			}
        }
        catch (SQLException ex) {
			throw new QmTmException("시험 문제 정보 읽어오는중 오류가 발생되었습니다. [PaperNonExport.getBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static PaperNonExportBean[] getAllBeans(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select distinct a.id_q, b.q, a.allotting ");
		sql.append("From exam_paper2 a, q b ");
		sql.append("Where a.id_exam = ? and b.id_qtype = 5 and a.id_q = b.id_q ");
		sql.append("Order by a.id_q ");
		
		try
        {
            Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());			       
			stm.setString(1, id_exam);
		    rst = stm.executeQuery();

            PaperNonExportBean bean = null;
            while (rst.next()) {
                bean = makeAllBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (PaperNonExportBean[]) beans.toArray(new PaperNonExportBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험 논술형 문제 정보 읽어오는중 오류가 발생되었습니다. [PaperNonExport.getAllBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static PaperNonExportBean makeAllBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            PaperNonExportBean bean = new PaperNonExportBean();
			bean.setId_q(rst.getLong(1));
            bean.setQ(rst.getString(2));
            bean.setAllotting(rst.getDouble(3));

            return bean;
        } catch (SQLException ex) {
			throw new QmTmException("시험 문제 정보 읽어오는중 오류가 발생되었습니다. [PaperNonExport.makeAllBeans] " + ex.getMessage());
        }
    }
	
	public static PaperNonExportBean[] getAllBeans2(String id_exam, long id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, a.userans1, a.userans2, a.userans3, a.userans4, a.userans5 ");
		sql.append("From exam_ans_non a, qt_userid b ");
		sql.append("Where a.id_exam = ? and a.id_q = ? and a.userid != 'tman@@2008' and a.userid = b.userid ");
		sql.append("Order by b.name ");
		
		try
        {
            Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setLong(2, id_q);
		    rst = stm.executeQuery();

            PaperNonExportBean bean = null;
            while (rst.next()) {
                bean = makeAllBeans2(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (PaperNonExportBean[]) beans.toArray(new PaperNonExportBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험 논술형 답안 정보 읽어오는중 오류가 발생되었습니다. [PaperNonExport.getAllBeans2] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static PaperNonExportBean makeAllBeans2 (ResultSet rst) throws QmTmException
    {
		
		try {
            PaperNonExportBean bean = new PaperNonExportBean();
			bean.setUserid(rst.getString(1));
			bean.setName(rst.getString(2));
 			bean.setUserans1(rst.getString(3));
			bean.setUserans2(rst.getString(4));
			bean.setUserans3(rst.getString(5));
			bean.setUserans4(rst.getString(6));
			bean.setUserans5(rst.getString(7));
			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험 논술형 답안 정보 읽어오는중 오류가 발생되었습니다. [PaperNonExport.makeAllBeans2] " + ex.getMessage());
        }
    }

	public static PaperNonExportBean[] getUserList(String id_exam, long id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name ");
		sql.append("From exam_ans_non a, qt_userid b ");
		sql.append("Where a.id_exam = ? and a.id_q = ? and a.userid != 'tman@@2008' and a.userid = b.userid ");
		sql.append("Order by b.name ");
		
		try
        {
            Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setLong(2, id_q);
		    rst = stm.executeQuery();

            PaperNonExportBean bean = null;
            while (rst.next()) {
                bean = makeUserList(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (PaperNonExportBean[]) beans.toArray(new PaperNonExportBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("논술형 답안 응시자 정보 읽어오는중 오류가 발생되었습니다. [PaperNonExport.getUserList] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static PaperNonExportBean makeUserList (ResultSet rst) throws QmTmException
    {
		
		try {
            PaperNonExportBean bean = new PaperNonExportBean();
			bean.setUserid(rst.getString(1));
			bean.setName(rst.getString(2));
			
            return bean;

        } catch (SQLException ex) {
            throw new QmTmException("논술형 답안 응시자 정보 읽어오는중 오류가 발생되었습니다. [PaperNonExport.makeUserList] " + ex.getMessage());
        }
    }
}