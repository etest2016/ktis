package qmtm.admin.etc;

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

public class ExamKindUtil
{
    public ExamKindUtil() {
    }
	
	public static void insert(ExamKindBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO r_exam_kind (id_exam_kind, exam_kind, rmk) ");
        sql.append("VALUES (?, ?, ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_exam_kind());
            stm.setString(2, bean.getExam_kind());
			stm.setString(3, bean.getRmk());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("그룹구분 정보 등록하는 중 오류가 발생되었습니다. [ExamKindUtil.insert] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(ExamKindBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE r_exam_kind SET exam_kind = ?, rmk = ? ");
        sql.append("Where id_exam_kind = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, bean.getExam_kind());
			stm.setString(2, bean.getRmk());
			stm.setString(3, bean.getId_exam_kind());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("그룹구분 정보 수정하는 중 오류가 발생되었습니다. [ExamKindUtil.update] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_exam_kind) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM r_exam_kind Where id_exam_kind = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_exam_kind);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("그룹구분 정보 삭제하는 중 오류가 발생되었습니다. [ExamKindUtil.delete] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ExamKindBean[] getBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		sql = "SELECT id_exam_kind, exam_kind, rmk FROM r_exam_kind order by id_exam_kind desc ";

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            rst = stm.executeQuery();
            ExamKindBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ExamKindBean[]) beans.toArray(new ExamKindBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("그룹구분 정보 읽어오는 중 오류가 발생되었습니다. [ExamKindUtil.getBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static ExamKindBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamKindBean bean = new ExamKindBean();
            bean.setId_exam_kind(rst.getString(1));
            bean.setExam_kind(rst.getString(2));
            bean.setRmk(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("그룹구분 정보 읽어오는 중 오류가 발생되었습니다. [ExamKindUtil.makeBeans] " + ex.getMessage());
        }
    }

	public static ExamKindBean getBean(String id_exam_kind) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		String sql = "SELECT exam_kind, rmk FROM r_exam_kind WHERE id_exam_kind = ? ";

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql);
			stm.setString(1, id_exam_kind);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("그룹구분 정보 읽어오는 중 오류가 발생되었습니다. [ExamKindUtil.getBean] " + ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static ExamKindBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            ExamKindBean bean = new ExamKindBean();
            bean.setExam_kind(rst.getString(1));
            bean.setRmk(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("그룹구분 정보 읽어오는 중 오류가 발생되었습니다. [ExamKindUtil.makeBean] " + ex.getMessage());
        }
    }
}