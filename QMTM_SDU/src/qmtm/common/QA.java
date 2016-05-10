package qmtm.common;

import qmtm.*;

public class QA
{
    public QA() {
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
          throw new QmTmException("���� ����� ǥ���ϴ� �� ������ �߻��Ǿ����ϴ�. [QA.getAnswerDisplay] " + ex.getMessage());
      }
    }
}
