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
			throw new QmTmException("응시자 로그정보 읽어오는 중 오류가 발생되었습니다. [Log.getBeans] " + ex.getMessage());
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
			throw new QmTmException("응시자 로그정보 읽어오는 중 오류가 발생되었습니다. [Log.makeBeans] " + ex.getMessage());
		}
	}

	public static String getEvent(String id)
    {
        int i = Integer.parseInt(id, 10);

        // 정상 : blue (0~9)
        if      (i == 0) return "입실/답안지생성";
        else if (i == 1) return "시험시작";
        else if (i == 2) return "새로고침";
        else if (i == 3) return "이어풀기";
        else if (i == 4) return "?예비항목?";
        else if (i == 5) return "답안지제출";
        else if (i == 6) return "답안지재제출";
        else if (i == 7) return "답안지제출성공";
        else if (i == 8) return "자동채점/성적공개";
        else if (i == 9) return "퇴실";

        // 경고 : red (10~49) -> 창 관련 (10~19)
        else if (i == 11) return "창크기변경";
        else if (i == 12) return "창위치변경";
        else if (i == 13) return "포커스이동";
        // -> Alt 관련 (20~29)
        else if (i == 20) return "강제종료[X]";
        else if (i == 21) return "강제종료[Alt+F4]";
        else if (i == 22) return "화면전환[Alt+Tab]";
        else if (i == 23) return "화면전환[Alt+Esc]";
        
        // -> 기타 조작 (40~49)
        else if (i == 41) return "타이머조작";

        // 주의 : gray (50~89)
        else if (i == 51) return "[Window]";
        else if (i == 52) return "[Context]";
        else if (i == 53) return "도움말[F1]";
        else if (i == 54) return "검색창[F3]";
        else if (i == 55) return "새로고침[F5]";

		else if (i == 56) return "Alt Key 사용";
		else if (i == 57) return "Ctrl Key 사용";

        // ??? : gray
        else if (i == 99) return "기타";
        else              return "????";
    }
}
