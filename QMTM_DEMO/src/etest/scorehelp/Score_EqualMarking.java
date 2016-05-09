package etest.scorehelp;

import qmtm.*;
import java.sql.*;
import java.util.*;

public class Score_EqualMarking
{

    public Score_EqualMarking() {}

	public static Score_EqualMarkingBean getAns(String id_exam, int id_q, String userid) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select nvl(a.userans1, ' ') userans1, nvl(a.userans2, ' ') userans2, nvl(a.userans3, ' ') userans3, ");
		sql.append("       nvl(a.userans4, ' ') userans4, nvl(a.userans5, ' ') userans5, nvl(a.userans6, ' ') userans6, ");
		sql.append("       to_char(end_time, 'yyyy-mm-dd hh24:mi:ss') end_time ");
		sql.append("From exam_ans_non a, exam_ans b ");
		sql.append("Where a.id_exam = b.id_exam and a.userid = b.userid and ");
		sql.append("      a.id_exam = ? and a.id_q = ? and a.userid = ? ");

		try	{
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, id_q);
			stm.setString(3, userid);
			rst = stm.executeQuery();
			Score_EqualMarkingBean bean = null;

			if (rst.next()) {
				bean = new Score_EqualMarkingBean();

				bean.setUserans(rst.getString("userans1") + rst.getString("userans2") + rst.getString("userans3") + rst.getString("userans4") + rst.getString("userans5") + rst.getString("userans6"));
				bean.setEnd_time(rst.getString("end_time"));

				return bean;
			} else {
				return null;
			}
		}
        catch (SQLException ex) {
            throw new QmTmException("[Score_EqualMarking.getAns]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static Score_EqualMarkingBean getCompResult(String id_exam, int id_q, String userid, String equal_chk) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select t_userid, o_t_res_rate, t_o_res_rate, nvl(equal_ans, ' ') equal_ans ");
		sql.append("From equal_comp_result ");
		sql.append("Where id_exam = ? and id_q = ? and o_userid = ? and equal_chk = ? ");

		try	{
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, id_q);
			stm.setString(3, userid);
			stm.setString(4, equal_chk);
			rst = stm.executeQuery();
			Score_EqualMarkingBean bean = null;

			if (rst.next()) {
				bean = new Score_EqualMarkingBean();

				bean.setT_userid(rst.getString("t_userid"));
				bean.setO_t_res_rate(rst.getString("o_t_res_rate"));
				bean.setT_o_res_rate(rst.getString("t_o_res_rate"));
				bean.setEqual_ans(rst.getString("equal_ans"));

				return bean;
			} else {
				return null;
			}
		}
        catch (SQLException ex) {
            throw new QmTmException("[Score_EqualMarking.getCompResult]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static Score_EqualMarkingBean getAns2(String id_exam, int id_q, String userid) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select nvl(a.userans1, ' ') userans1, nvl(a.userans2, ' ') userans2, nvl(a.userans3, ' ') userans3, ");
		sql.append("       nvl(a.userans4, ' ') userans4, nvl(a.userans5, ' ') userans5, nvl(a.userans6, ' ') userans6, ");
		sql.append("       to_char(end_time, 'yyyy-mm-dd hh24:mi:ss') end_time ");
		sql.append("From exam_ans_non a, exam_ans b ");
		sql.append("Where a.id_exam = b.id_exam and a.userid = b.userid and ");
		sql.append("      a.id_exam = ? and a.id_q = ? and a.userid = ? ");

		try	{
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, id_q);
			stm.setString(3, userid);
			rst = stm.executeQuery();
			Score_EqualMarkingBean bean = null;

			if (rst.next()) {
				bean = new Score_EqualMarkingBean();

				bean.setUserans(rst.getString("userans1") + rst.getString("userans2") + rst.getString("userans3") + rst.getString("userans4") + rst.getString("userans5") + rst.getString("userans6"));
				bean.setEnd_time(rst.getString("end_time"));

				return bean;
			} else {
				return null;
			}
		}
        catch (SQLException ex) {
            throw new QmTmException("[Score_EqualMarking.getAns2]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

}