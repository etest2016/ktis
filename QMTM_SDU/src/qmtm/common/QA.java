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
        if (answer.length() == 0) { // 답이 없으면
          ansDisplay = "";
        }
        else if (id_valid_type_ua9 == 2) {
          ansDisplay = "모두 정답 처리";
        }
        else
        {
          if (id_qtype <= 3) {
            // id_qtype = 0 (OX)      -> 2
            // id_qtype = 2 (단수선택) -> 3{^}4
            // id_qtype = 3 (복수선택) -> 2{|}5
            String[] arrCa = answer.split(QmTm.OR_GUBUN_re, -1);

            for (int j = 0; j < arrCa.length; j++) // OR_GUBUN loop
            {
              String[] arrCaLike = arrCa[j].split(QmTm.LIKE_GUBUN_re, -1);
              for (int k = 0; k < arrCaLike.length; k++) // LIKE_GUBUN loop
              {
                for (int l = 0; l < arrEx_order.length; l++) // matching loop
                {
                  if ((arrEx_order[l] + "").equals(arrCaLike[k])) { // matched
                    if (id_qtype == 2) { // 2:단수선택
                      ansDisplay += arrExlabel[l] + " 또는 "; // '② 또는 ⑤ 또는 '
                    } else { // 1:OX, 3:복수선택형
                      ansDisplay += arrExlabel[l]; // 1:'②', 3:'②⑤'
                    }
                    break;
                  }
                }
              }
              if (id_qtype == 2) { // 단수선택 (하나 이상을 정답으로 인정시...
                  ansDisplay = ansDisplay.substring(0, ansDisplay.length() - 4); // '② 또는 ⑤ 또는 ' --> '② 또는 ⑤'
              }
            }
          } else  if (id_qtype == 4) { // 단답형
              if (cacount > 1) { // 복수답
                String[] arrCa = answer.split(QmTm.OR_GUBUN_re, -1);
                for (int j = 0; j < arrCa.length; j++) {
                  ansDisplay += "☞" + arrCa[j].replaceAll(QmTm.LIKE_GUBUN_re, " 또는 ") + "<br>";
                }
              } else { // 단수답
                  ansDisplay = answer.replaceAll(QmTm.LIKE_GUBUN_re, " 또는 ");
              }
            } else { // 5:논술형
                if (id_valid_type_ua9 == 9) { // 제출답안의 경우
                    ansDisplay = QmTm.delTag(answer);
                } else {
                    ansDisplay = "N/A";
                }
            }
          }
          return ansDisplay;
      }
      catch (Exception ex) {
          throw new QmTmException("문제 답안을 표시하는 중 오류가 발생되었습니다. [QA.getAnswerDisplay] " + ex.getMessage());
      }
    }
}
