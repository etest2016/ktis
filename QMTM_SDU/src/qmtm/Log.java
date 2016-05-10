package qmtm;

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

public class Log
{
    public Log() {
    }

    public static LogAnswerBean[] getBeans(String id_exam, String userid) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 

		StringBuffer sb = new StringBuffer();

		sb.append("Select isnull(b.ex_order,'') ex_order, c.id_qtype, b.nr_q ");
		sb.append("From exam_ans a, exam_paper2 b, q c ");
		sb.append("Where a.id_exam = ? and a.userid = ? ");
		sb.append("      and a.id_exam = b.id_exam ");
		sb.append("      and a.nr_set = b.nr_set ");
		sb.append("      and b.id_q = c.id_q ");
		sb.append("Order by b.nr_q ");

		try {
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sb.toString());
			stm.setString(1, id_exam);
			stm.setString(2, userid);
			rst = stm.executeQuery();
			
			LogAnswerBean bean = null;
			
			while (rst.next()) {
				bean = makeBeans(rst);
				beans.add(bean);
			}
			if (bean == null) {
				return null;
			} else {
				return (LogAnswerBean[]) beans.toArray(new LogAnswerBean[0]);
			}
		} catch (SQLException ex) {
			throw new QmTmException("������ �α����� �о���� �� ������ �߻��Ǿ����ϴ�. [Log.getBeans] " + ex.getMessage());
		} finally {
			if (rst != null) 	try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) 	try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) 	try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static LogAnswerBean makeBeans(ResultSet rst) throws QmTmException {
		try {
			LogAnswerBean bean = new LogAnswerBean();
			bean.setEx_order(rst.getString("ex_order"));
			bean.setId_qtype(rst.getInt("id_qtype"));
			bean.setNr_q(rst.getInt("nr_q"));
			return bean;
		} catch (SQLException ex) {
			throw new QmTmException("������ �α����� �о���� �� ������ �߻��Ǿ����ϴ�. [Log.makeBeans] " + ex.getMessage());
		}
	}

	public static String getEvent(String id)
    {
        int i = Integer.parseInt(id, 10);

        // ���� : blue (0~9)
        if      (i == 0) return "�Խ�/���������";
        else if (i == 1) return "�������";
        else if (i == 2) return "���ΰ�ħ";
        else if (i == 3) return "�̾�Ǯ��";
        else if (i == 4) return "?�����׸�?";
        else if (i == 5) return "���������";
        else if (i == 6) return "�����������";
        else if (i == 7) return "��������⼺��";
        else if (i == 8) return "�ڵ�ä��/��������";
        else if (i == 9) return "���";

        // ��� : red (10~49) -> â ���� (10~19)
        else if (i == 11) return "âũ�⺯��";
        else if (i == 12) return "â��ġ����";
        else if (i == 13) return "��Ŀ���̵�";
        // -> Alt ���� (20~29)
        else if (i == 20) return "��������[X]";
        else if (i == 21) return "��������[Alt+F4]";
        else if (i == 22) return "ȭ����ȯ[Alt+Tab]";
        else if (i == 23) return "ȭ����ȯ[Alt+Esc]";
        
        // -> ��Ÿ ���� (40~49)
        else if (i == 41) return "Ÿ�̸�����";

        // ���� : gray (50~89)
        else if (i == 51) return "[Window]";
        else if (i == 52) return "[Context]";
        else if (i == 53) return "����[F1]";
        else if (i == 54) return "�˻�â[F3]";
        else if (i == 55) return "���ΰ�ħ[F5]";

		else if (i == 56) return "Alt Key ���";
		else if (i == 57) return "Ctrl Key ���";

        // ??? : gray
        else if (i == 99) return "��Ÿ";
        else              return "????";
    }
}
