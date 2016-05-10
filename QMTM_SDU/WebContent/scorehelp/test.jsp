<%
//******************************************************************************
//   프로그램 : exam_list.jsp
//   모 듈 명 : 모사답안 및 채점도우미
//   설    명 : 모사답안 및 채점도우미
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.AnswerMark, qmtm.tman.answer.AnswerMarkBean
//   작 성 일 : 2009-01-21
//   작 성 자 : 이테스트 강진아
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*, etest.scorehelp.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = "E090416115011HA";
	int id_q = 134126;
	String nonAns = "";

	Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
	StringBuffer sql = new StringBuffer();

	sql.append("Select userid, userans1, nvl(userans2, ' ') userans2, nvl(userans3, ' ') userans3, ");
	sql.append("       nvl(userans4, ' ') userans4, nvl(userans5, ' ') userans5, nvl(userans6, ' ') userans6 ");
	sql.append("From exam_ans_non ");
	sql.append("Where id_exam = ? and id_q = ? and length(userans1) > 0 ");
	sql.append("Order by userid ");

	try	{
		cnn = DBPool.getConnection();
		stm = cnn.prepareStatement(sql.toString());
		stm.setString(1, id_exam);
		stm.setInt(2, id_q);
		rst = stm.executeQuery();

		while (rst.next()) {
			nonAns = "";
			nonAns = rst.getString("userans1") + rst.getString("userans2") + rst.getString("userans3") + rst.getString("userans4") + rst.getString("userans5");

			out.println(rst.getString("userid"));
			out.println("<BR>");
			out.println(nonAns);
			out.println("<BR>");
			out.println("<BR>");

		}
	}
    catch (SQLException ex) {
        out.println(ex.getMessage());
    }
    finally {
        if (rst != null) try { rst.close(); } catch (SQLException ex) {}
        if (stm != null) try { stm.close(); } catch (SQLException ex) {}
        if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
    }


%>