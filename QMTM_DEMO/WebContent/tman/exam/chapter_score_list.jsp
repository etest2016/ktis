<%
//******************************************************************************
//   프로 그램 : exam_copy.jsp
//   모  듈  명 : 시험 복사
//   설       명 : 시험 복사
//   테  이  블 : exam_m
//   자바 파일 : qmtm.tman.ExamListBean, qmtm.tman.ExamList
//   작  성  일 : 2008-06-15
//   작  성  자 : 이테스트 석준호
//   수  정  일 : 
//   수  정  자 : 
//	  수정 사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }	
	
	if (id_exam.length() == 0) { 
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}	

    // 과목 아래 시험정보 가지고오기
	ChapterScoreBean[] rst = null;

    try {
	    rst = ChapterScore.getBeans(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }	
%>

<HTML>
 <HEAD>
  <TITLE> :: 단원별 요구수준 점수 정의 :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
  <script language="JavaScript">
	
	function score_insert(id_chapter) {

		window.open("chapter_score.jsp?id_exam=<%=id_exam%>&id_chapter="+id_chapter,"score_insert","width=350, height=200");
    }

 </script>

</HEAD>

<BODY id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">단원별 요구수준 정의<span>단원별 요구수준 정답률을 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%" style="margin-bottom: 0px;">
			<tr id="tr">				
				<td width="25%">단원코드</td>
				<td>단원명</td>
				<td width="25%">요구수준정답률</td>	
				<td width="10%">정답률등록</td>	
			</tr>
		</table>
		
			<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%">
				<%
					if(rst == null) {
				%>
				<tr>
					<td class="blank" colspan="4">출제된 단원이 없습니다.</td>
				</tr>
				<%
					} else { 
						for(int i = 0; i < rst.length; i++) {

							double score = 0;
							try {
								score = ChapterScore.getScore(id_exam, rst[i].getId_chapter());
							} catch(Exception ex) {
								out.println(ComLib.getExceptionMsg(ex, "close"));

								if(true) return;
							}
				%>
				<tr id="td" align="center">
					<td width="25%">&nbsp;<%=rst[i].getId_chapter()%></td>
					<td><%=rst[i].getChapter()%></td>
					<td width="25%"><%if(score == -1) { %>미지정<% } else { %><%=score%><% } %></td>
					<td width="10%"><input type="button" value="등록하기" class="form" onClick="score_insert('<%=rst[i].getId_chapter()%>');"></td>
				</tr>
				<%
						}
					}
				%>
			</table>
		
	</div>
	<div id="button">
		<a href="javascript:window.close();"><img src="../../images/bt_close_1.gif" align="top"></a></div>
	</div>

	</form>

 </BODY>
</HTML>