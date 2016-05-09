package qmtm.common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import qmtm.QmTm;
import qmtm.SET;
import qmtm.QmTmException;

// for paper/etest.jsp

public class ExamWritePaper {
	
	public ExamWritePaper() {
	}

	public static ExamPaperBean[] getBeans(String id_exam, int nr_set) throws QmTmException {
		// ������Ʈ ��ü

		Connection cnn = null;
		PreparedStatement stm = null;
		ResultSet rst = null;
		StringBuffer sql = new StringBuffer();  
		
		sql.append("SELECT a.nr_q, a.id_q, b.id_qtype, b.excount, b.cacount, b.q, b.ex1, b.ex2, b.ex3, b.ex4, b.ex5, a.ex_order ");
		sql.append("FROM exam_paper2 as a inner join q as b ");
		sql.append("     on a.id_q = b.id_q and a.id_exam = ? and a.nr_set = ? ");
		sql.append("ORDER BY a.nr_q ");

		try {
			Collection beans = new ArrayList();
			cnn = SET.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, nr_set);
			rst = stm.executeQuery();
			ExamPaperBean bean = null;
			while (rst.next()) {
				bean = makeBean(rst);
				beans.add(bean);
			}
			if (bean == null) {
				return null;
			} else {
				return (ExamPaperBean[]) beans.toArray(new ExamPaperBean[0]);
			}
		} catch (SQLException ex) {
			throw new QmTmException("������Ʈ ���� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [ExamWritePaper.getBeans2]");
		} finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) { }
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	private static ExamPaperBean makeBean(ResultSet rst) throws QmTmException {
		try {
			ExamPaperBean bean = new ExamPaperBean();
			bean.setNr_q(rst.getInt(1));
			bean.setId_q(rst.getLong(2));
			bean.setId_qtype(rst.getInt(3));
			bean.setExcount(rst.getInt(4));
			bean.setCacount(rst.getInt(5));
			bean.setQ(rst.getString(6));
			bean.setEx1(rst.getString(7));
			bean.setEx2(rst.getString(8));
			bean.setEx3(rst.getString(9));
			bean.setEx4(rst.getString(10));
			bean.setEx5(rst.getString(11));
			bean.setEx_order(rst.getString(12));
			
			return bean;
		} catch (SQLException ex) {
			throw new QmTmException("������Ʈ ���� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [ExamWritePaper.makeBean2]");
		}
	}
	
	public static String getAnswerDisplay (int id_valid_type_ua9, int id_qtype, int cacount, int[] arrEx_order, String answer, String[] arrExlabel) throws QmTmException
    {
      String ansDisplay = "";
      try
      {
        if (answer.length() == 0) { // ���� ������
          ansDisplay = "";
        }
        else if (id_valid_type_ua9 == 2) {
          ansDisplay = "��� ���� ó��";
        }
        else
        {
          if (id_qtype <= 3) {
            // id_qtype = 0 (OX)      -> 2
            // id_qtype = 2 (�ܼ�����) -> 3{^}4
            // id_qtype = 3 (��������) -> 2{|}5
            String[] arrCa = answer.split(QmTm.OR_GUBUN_re, -1);

            for (int j = 0; j < arrCa.length; j++) // OR_GUBUN loop
            {
              String[] arrCaLike = arrCa[j].split(QmTm.LIKE_GUBUN_re, -1);
              for (int k = 0; k < arrCaLike.length; k++) // LIKE_GUBUN loop
              {
                for (int l = 0; l < arrEx_order.length; l++) // matching loop
                {
                  if ((arrEx_order[l] + "").equals(arrCaLike[k])) { // matched
                    if (id_qtype == 2) { // 2:�ܼ�����
                      ansDisplay += arrExlabel[l] + " �Ǵ� "; // '�� �Ǵ� �� �Ǵ� '
                    } else { // 1:OX, 3:����������
                      ansDisplay += arrExlabel[l]; // 1:'��', 3:'���'
                    }
                    break;
                  }
                }
              }
              if (id_qtype == 2) { // �ܼ����� (�ϳ� �̻��� �������� ������...
                  ansDisplay = ansDisplay.substring(0, ansDisplay.length() - 4); // '�� �Ǵ� �� �Ǵ� ' --> '�� �Ǵ� ��'
              }
            }
          } else  if (id_qtype == 4) { // �ܴ���
              if (cacount > 1) { // ������
                String[] arrCa = answer.split(QmTm.OR_GUBUN_re, -1);
                for (int j = 0; j < arrCa.length; j++) {
                  ansDisplay += "��" + arrCa[j].replaceAll(QmTm.LIKE_GUBUN_re, " �Ǵ� ") + "<br>";
                }
              } else { // �ܼ���
                  ansDisplay = answer.replaceAll(QmTm.LIKE_GUBUN_re, " �Ǵ� ");
              }
            } else { // 5:�����
                if (id_valid_type_ua9 == 9) { // �������� ���
                    ansDisplay = QmTm.delTag(answer);
                } else {
                    ansDisplay = "N/A";
                }
            }
          }
          return ansDisplay;
      }
      catch (Exception ex) {
		  //throw new QmTmException("���� ���� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [ExamWritePaper.getAnswerDisplay]");
		  throw new QmTmException(ex.getMessage());
      }
    }
}
