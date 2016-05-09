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
import java.sql.PreparedStatement;

public class NameUtil
{
    public NameUtil() {
    }

	public static NameBean getSubject(String id_subject) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT id_q_subject, q_subject FROM q_subject WHERE id_q_subject = ? ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_subject);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeSubject(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("�������� ���� ���� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [NameUtil.getSubject]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static NameBean makeSubject (ResultSet rst) throws QmTmException
    {
		
		try {
            NameBean bean = new NameBean();
            bean.setId_subject(rst.getString(1));
			bean.setSubject(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("�������� ���� ���� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [NameUtil.makeSubject]");
        }
    }

	public static NameBean getChapter1(String id_chapter) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select b.id_q_subject, b.id_q_chapter, a.q_subject, b.chapter ");
		sql.append("From q_subject a, q_chapter b ");
		sql.append("Where b.id_q_chapter = ? and a.id_q_subject = b.id_q_subject ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_chapter);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeChapter1(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("�������� ī�װ� ���� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [NameUtil.getChapter1]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static NameBean makeChapter1 (ResultSet rst) throws QmTmException
    {
		
		try {
            NameBean bean = new NameBean();
            bean.setId_subject(rst.getString(1));
			bean.setId_chapter1(rst.getString(2));
			bean.setSubject(rst.getString(3));
			bean.setChapter1(rst.getString(4));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("�������� ī�װ� ���� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [NameUtil.makeChapter1]");
        }
    }

	public static NameBean getChapter2(String id_chapter) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select c.id_q_subject, c.id_q_chapter, c.id_q_chapter2, a.q_subject, b.chapter, c.chapter ");
		sql.append("From q_subject a, q_chapter b, q_chapter2 c  ");
		sql.append("Where c.id_q_chapter2 = ? and a.id_q_subject = b.id_q_subject and b.id_q_chapter = c.id_q_chapter ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_chapter);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeChapter2(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("�������� ī�װ� ���� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [NameUtil.getChapter2]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static NameBean makeChapter2 (ResultSet rst) throws QmTmException
    {
		
		try {
            NameBean bean = new NameBean();
            bean.setId_subject(rst.getString(1));
			bean.setId_chapter1(rst.getString(2));
			bean.setId_chapter2(rst.getString(3));
			bean.setSubject(rst.getString(4));
			bean.setChapter1(rst.getString(5));
			bean.setChapter2(rst.getString(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("�������� ī�װ� ���� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [NameUtil.makeChapter2]");
        }
    }

	public static NameBean getChapter3(String id_chapter) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select d.id_q_subject, d.id_q_chapter, d.id_q_chapter2, d.id_q_chapter3, a.q_subject, b.chapter, c.chapter, d.chapter ");
		sql.append("From q_subject a, q_chapter b, q_chapter2 c, q_chapter3 d  ");
		sql.append("Where d.id_q_chapter3 = ? and a.id_q_subject = b.id_q_subject ");
		sql.append("      and b.id_q_chapter = c.id_q_chapter and c.id_q_chapter2 = d.id_q_chapter2 ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_chapter);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeChapter3(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("�������� ī�װ� ���� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [NameUtil.getChapter3]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static NameBean makeChapter3 (ResultSet rst) throws QmTmException
    {
		
		try {
            NameBean bean = new NameBean();
            bean.setId_subject(rst.getString(1));
			bean.setId_chapter1(rst.getString(2));
			bean.setId_chapter2(rst.getString(3));
			bean.setId_chapter3(rst.getString(4));
			bean.setSubject(rst.getString(5));
			bean.setChapter1(rst.getString(6));
			bean.setChapter2(rst.getString(7));
			bean.setChapter3(rst.getString(8));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("�������� ī�װ� ���� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [NameUtil.makeChapter3]");
        }
    }

	public static NameBean getChapter4(String id_chapter) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select e.id_q_subject, e.id_q_chapter, e.id_q_chapter2, e.id_q_chapter3, ");
		sql.append("       e.id_q_chapter4, a.q_subject, b.chapter, c.chapter, d.chapter, e.chapter ");
		sql.append("From q_subject a, q_chapter b, q_chapter2 c, q_chapter3 d, q_chapter4 e ");
		sql.append("Where e.id_q_chapter4 = ? and a.id_q_subject = b.id_q_subject and b.id_q_chapter = c.id_q_chapter ");
		sql.append("      and c.id_q_chapter2 = d.id_q_chapter2 and d.id_q_chapter3 = e.id_q_chapter3 ");
		
	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_chapter);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeChapter4(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("�������� ī�װ� ���� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [NameUtil.getChapter4]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static NameBean makeChapter4 (ResultSet rst) throws QmTmException
    {
		
		try {
            NameBean bean = new NameBean();
            bean.setId_subject(rst.getString(1));
			bean.setId_chapter1(rst.getString(2));
			bean.setId_chapter2(rst.getString(3));
			bean.setId_chapter3(rst.getString(4));
			bean.setId_chapter4(rst.getString(5));
			bean.setSubject(rst.getString(6));
			bean.setChapter1(rst.getString(7));
			bean.setChapter2(rst.getString(8));
			bean.setChapter3(rst.getString(9));
			bean.setChapter4(rst.getString(10));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("�������� ī�װ� ���� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [NameUtil.makeChapter4]");
        }
    }
}