package etest.scorehelp;

import qmtm.*;

import java.sql.*;
import java.util.*;

public class Score_AnsEqual
{
    public Score_AnsEqual() {
    }

	public static Score_AnsEqualBean getBean(String id_exam, String id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		StringBuffer sql = new StringBuffer();

		sql.append("Select to_char(a.id_q) id_q, b.q, to_char(a.allotting) allotting ");
		sql.append("From exam_paper2 a, q b ");
		sql.append("Where a.id_exam = ? and a.id_q = b.id_q and a.id_q = ? and rownum <= 1 ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setString(2, id_q);
            rst = stm.executeQuery();
            Score_AnsEqualBean bean = null;
            if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_AnsEqual.getBean]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static Score_AnsEqualBean makeBean (ResultSet rst) throws QmTmException
    {
		try {
            Score_AnsEqualBean bean = new Score_AnsEqualBean();

			bean.setId_q(rst.getString(1));
            bean.setQ(rst.getString(2));
			bean.setAllotting(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[Score_AnsEqual.makeBean]" + ex.getMessage());
        }
    }


	public static void delEqualComp(String id_exam, String id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "Delete EQUAL_COMP_RESULT Where id_exam = ? and id_q = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);
            stm.setString(2, id_q);
			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_AnsEqual.delEqualComp]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delEqualTest(String id_exam, String id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "Delete EQUAL_TEST_RESULT2 Where id_exam = ? and id_q = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);
            stm.setString(2, id_q);
			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_AnsEqual.delEqualTest]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delBasicAns(String id_exam, String id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "Delete BASIC_ANS_NON Where id_exam = ? and id_q = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);
            stm.setString(2, id_q);
			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_AnsEqual.delBasicAns]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

}