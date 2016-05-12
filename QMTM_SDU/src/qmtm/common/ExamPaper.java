package qmtm.common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import qmtm.QmTm;
import qmtm.DBPool;
import qmtm.QmTmException;
import qmtm.tman.answer.ExamAnswerNon;
import qmtm.tman.answer.ExamAnswerNonBean;

// for paper/etest.jsp

public class ExamPaper {
	
	public ExamPaper() {
	}

	public static ExamPaperBean[] getBeans(String id_exam, int nr_set) throws QmTmException {
		// 문제세트 전체

		Connection cnn = null;
		PreparedStatement stm = null;
		ResultSet rst = null;
		StringBuffer sql = new StringBuffer();  
		
		sql.append("SELECT a.nr_q, a.id_q, a.ex_order, a.allotting, a.page, a.q_no1, a.q_no2, b.id_ref, b.id_qtype, ");
		sql.append("       b.excount, b.cacount, b.q, b.ex1, b.ex2, b.ex3, b.ex4, b.ex5, ");
		sql.append("       b.ca, b.yn_caorder, b.yn_case, b.yn_blank, b.hint, b.explain, b.id_valid_type, ");
		sql.append("       b.yn_single_line, b.ex_rowcnt, b.id_difficulty1, c.chapter ");
		sql.append("FROM exam_paper2 as a inner join q as b ");
		sql.append("     on a.id_q = b.id_q and a.id_exam = ? and a.nr_set = ? ");
		sql.append("     left outer join q_chapter c on b.id_chapter = c.id_q_chapter ");
		sql.append("ORDER BY a.nr_q ");

		try {
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
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
			throw new QmTmException("문제세트 정보 읽어오는 중 오류가 발생되었습니다. [ExamPaper.getBeans] " + ex.getMessage());
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
			bean.setEx_order(rst.getString(3));
			bean.setAllotting(rst.getDouble(4));
			bean.setPage(rst.getInt(5));
			bean.setQ_no1(rst.getInt(6));
			bean.setQ_no2(rst.getInt(7));
			bean.setId_ref(rst.getString(8));
			bean.setId_qtype(rst.getInt(9));
			bean.setExcount(rst.getInt(10));
			bean.setCacount(rst.getInt(11));
			bean.setQ(rst.getString(12));
			bean.setEx1(rst.getString(13));
			bean.setEx2(rst.getString(14));
			bean.setEx3(rst.getString(15));
			bean.setEx4(rst.getString(16));
			bean.setEx5(rst.getString(17));
			bean.setCa(rst.getString(18));
			bean.setYn_caorder(rst.getString(19));
			bean.setYn_case(rst.getString(20));
			bean.setYn_blank(rst.getString(21));
			bean.setHint(rst.getString(22));
			bean.setExplain(rst.getString(23));
			bean.setId_valid_type(rst.getInt(24));			
			bean.setYn_single_line(rst.getString(25));
			bean.setEx_rowcnt(rst.getInt(26));
			bean.setId_difficulty1(rst.getInt(27));			
			bean.setQ_chapter(rst.getString(28));
			
			return bean;
		} catch (SQLException ex) {
			throw new QmTmException("문제세트 정보 읽어오는 중 오류가 발생되었습니다. [ExamPaper.makeBean] " + ex.getMessage());
		}
	}

	public static ExamPaperBean[] getBeans45(String id_exam, int nr_set, String userid) throws QmTmException {
		// 문제세트 전체

		Connection cnn = null;
		PreparedStatement stm = null;
		ResultSet rst = null;
		StringBuffer sql = new StringBuffer();   
		
		sql.append("SELECT a.nr_q, a.id_q, a.ex_order, a.allotting, a.page, a.q_no1, a.q_no2, b.id_ref, b.id_qtype, ");
		sql.append("       b.excount, b.cacount, b.q, b.ex1, b.ex2, b.ex3, b.ex4, b.ex5, ");
		sql.append("       b.ca, b.yn_caorder, b.yn_case, b.yn_blank, b.hint, b.explain, b.id_valid_type, ");
		sql.append("       c.reftitle, c.refbody1, c.refbody2, c.refbody3, b.yn_single_line, b.ex_rowcnt, b.id_difficulty1 ");
		sql.append("FROM exam_paper2 as a inner join q as b ");
        sql.append("     on a.id_q = b.id_q and a.id_exam = ? AND a.nr_set = ? ");
        sql.append("     left outer join q_ref as c on b.id_ref = c.id_ref ");
        sql.append("ORDER BY a.nr_q ");

		try {
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, nr_set);
			rst = stm.executeQuery();
			ExamPaperBean bean = null;
			while (rst.next()) {
				bean = makeBeans45(rst, userid, id_exam);
				beans.add(bean);
			}
			if (bean == null) {
				return null;
			} else {
				return (ExamPaperBean[]) beans.toArray(new ExamPaperBean[0]);
			}
		} catch (SQLException ex) {
			throw new QmTmException("문제세트 정보 읽어오는 중 오류가 발생되었습니다. [ExamPaper.getBeans45] " + ex.getMessage());
		} finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) { }
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	private static ExamPaperBean makeBeans45(ResultSet rst, String userid, String id_exam) throws QmTmException {
		try {
			ExamPaperBean bean = new ExamPaperBean();
			bean.setNr_q(rst.getInt(1));
			bean.setId_q(rst.getLong(2));
			bean.setEx_order(rst.getString(3));
			bean.setAllotting(rst.getDouble(4));
			bean.setPage(rst.getInt(5));
			bean.setQ_no1(rst.getInt(6));
			bean.setQ_no2(rst.getInt(7));
			bean.setId_ref(rst.getString(8));
			bean.setId_qtype(rst.getInt(9));
			bean.setExcount(rst.getInt(10));
			bean.setCacount(rst.getInt(11));
			bean.setQ(rst.getString(12));
			bean.setEx1(rst.getString(13));
			bean.setEx2(rst.getString(14));
			bean.setEx3(rst.getString(15));
			bean.setEx4(rst.getString(16));
			bean.setEx5(rst.getString(17));
			bean.setCa(rst.getString(18));
			bean.setYn_caorder(rst.getString(19));
			bean.setYn_case(rst.getString(20));
			bean.setYn_blank(rst.getString(21));
			bean.setHint(rst.getString(22));
			bean.setExplain(rst.getString(23));
			bean.setId_valid_type(rst.getInt(24));
			bean.setReftitle(rst.getString(25));
			bean.setRefbody1(rst.getString(26));
			bean.setRefbody2(rst.getString(27));
			bean.setRefbody3(rst.getString(28));
			bean.setYn_single_line(rst.getString(29));
			bean.setEx_rowcnt(rst.getInt(30));
			bean.setId_difficulty1(rst.getInt(31));

			if (bean.getId_qtype() == 5) { // id_qtype == 5 : 논술형
                long id_q = bean.getId_q();
                ExamAnswerNonBean nonbean = ExamAnswerNon.getBean(id_q, userid, id_exam);
                bean.setUserans1(nonbean.getUserans1());
                bean.setUserans2(nonbean.getUserans2());
                bean.setUserans3(nonbean.getUserans3());
            } else {
                bean.setUserans1("");
                bean.setUserans2("");
                bean.setUserans3("");
            }
			
			return bean;
		} catch (SQLException ex) {
			throw new QmTmException("문제세트 정보 읽어오는 중 오류가 발생되었습니다. [ExamPaper.makeBeans45] " + ex.getMessage());
		}
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
		  throw new QmTmException("문제 정답 읽어오는 중 오류가 발생되었습니다. [ExamPaper.getAnswerDisplay] " + ex.getMessage());
      }
    }
}
