<%
//******************************************************************************
//   프로그램 : exam_user_q_result_excel_download.jsp
//   모 듈 명 : 문제별 응시자 점수
//   설    명 : 문제별 응시자 점수
//   테 이 블 : 
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.answer.UserQScore, qmtm.tman.answer.UserQScoreBean
//   작 성 일 : 2008-05-21
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.QmTm, qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.answer.UserQScore, qmtm.tman.answer.UserQScoreBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	// 엑셀파일 저장
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String filename = id_exam + ".xls";
	response.setHeader("Content-Disposition", "attachment; filename=" + filename); 
    response.setHeader("Content-Description", "JSP Generated Data");

	// 시험 Title 및 문제수 정보 가져오기	
	UserQScoreBean info = null;

	try {
	    info = UserQScore.getExamInfo(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }

	String title = info.getTitle();
	int qcount = info.getQcount();
	
	// 응시자별 답안 정보 가져오기
	UserQScoreBean[] rst = null;

	try {
	    rst = UserQScore.getOxs(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }

%>

<html>
<head>
	<title></title>
</head>

	<table border="1" cellpadding="0" cellspacing="0" >
		<tr align="center" height="30" >
			<td bgcolor="#9DBFFF">시험코드</td>
			<td bgcolor="#9DBFFF">시험명</td>
			<td bgcolor="#9DBFFF">아이디</td>
			<td bgcolor="#9DBFFF">성명</td>
			<td bgcolor="#9DBFFF">문제번호</td>
			<td bgcolor="#9DBFFF">정오여부</td>
			<td bgcolor="#9DBFFF">배점</td>
			<td bgcolor="#9DBFFF">득점</td>
		</tr>
			
<%
	if(rst == null) {
%>
		<tr height="40">
				<td align="center" colspan="7">채점이 진행되지 않았습니다. 채점을 완료한 후 다시 진행하시기 바랍니다.</td>
		</tr>
<%		
	} else {

		String[] arrAnswers;
		String[] arrOxs;
		String[] arrPoints;
		String[] arrUserid;
		String[] arrName;

		UserQScoreBean[] rst2 = null;

		for(int ans=0; ans<rst.length; ans++) {
			int nr_set = rst[ans].getNr_set();
			arrAnswers = rst[ans].getAnswers().split(QmTm.Q_GUBUN_re, -1);
			arrOxs = rst[ans].getOxs().split(QmTm.Q_GUBUN_re, -1);

			// 응시자별 시험지 정보를 가지고 온다.
			try {
				rst2 = UserQScore.getQinfo(id_exam, nr_set);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "close"));

				if(true) return;
			}

			String[] arrUserQ = new String[qcount];

			for(int qinfo=0; qinfo<qcount; qinfo++) {
				arrUserQ[qinfo] = String.valueOf(rst2[qinfo].getId_q());
			}
			
			String imsi_points = rst[ans].getPoints();
			
			if(imsi_points == null || imsi_points.equals("")) {
				for (int i = 0; i < qcount; i++) {
					imsi_points = imsi_points + "{:}";
				}

				imsi_points = imsi_points.substring(0, imsi_points.length()-3);
			} 

			arrPoints = imsi_points.split(QmTm.Q_GUBUN_re, -1);	

			// 문제별 채점 결과를 만든다.
			for(int qinfo=0; qinfo<rst2.length; qinfo++) {				
				String result_ox = "";
				double result_score = 0;
				
				if(arrOxs[rst2[qinfo].getNr_q()-1].equals("O")) {
					result_ox = "O";
					result_score = rst2[qinfo].getAllotting();
				} else if(arrOxs[rst2[qinfo].getNr_q()-1].equals("P")) {
					result_ox = "P";
					result_score = Double.parseDouble(arrPoints[rst2[qinfo].getNr_q()-1]);
				} else {
					result_ox = "X";
					result_score = 0;
				}
				
%>				
		<tr height="27" align="center">
			<td><%=id_exam%></td>
			<td align="left"><%=title%></td>
			<td><%=rst[ans].getUserid()%></td>
			<td><%=rst[ans].getName()%></td>
			<td><%=rst2[qinfo].getId_q()%></td>
			<td><%=result_ox%></td>
			<td><%=rst2[qinfo].getAllotting()%></td>
			<td><%=result_score%></td>
		</tr>
				
<%
			}

		}

	}
%>
	</table>
</body>
</html>
