<%
//******************************************************************************
//   프로그램 : nonscore_file.jsp
//   모 듈 명 : 논술형 점수 및 강평 등록
//   설    명 : 논술형 점수 및 강평 등록
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2013-03-12
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.answer.AnswerMarkNon, qmtm.tman.answer.AnswerMarkNonBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");	
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	String id_q = request.getParameter("id_q");	
	if (id_q == null) { id_q = ""; } else { id_q = id_q.trim(); }
	
	if (id_exam.length() == 0 || id_q.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	// 해당 논술형 문제 문제, 정답, 해설을 조회한다.
	AnswerMarkNonBean rst = null;

	try {
		rst = AnswerMarkNon.getBeans3(id_q, id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}	

	String strQ = rst.getQ();
	String strCa = rst.getCa();
	String strExplain = ComLib.nullChk(rst.getExplain());
	double allotting = rst.getAllotting();
	
%>

<HTML>
 <HEAD>
  <TITLE> :: 논술형(실기형) 점수 및 강평 등록 :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <Script language="JavaScript">
	function Sends() {
		if(document.form1.file.value == "") {
			alert("등록할 엑셀파일을 선택해주세요.");
			return;
		} 

		var str = confirm("해당 문제에 점수 및 강평을 등록합니다.\n\n등록할 응시자가 많을경우 시간이 오래걸릴수 있습니다.\n\n점수 및 강평을 등록하시겠습니까?");

		if(str) {
			document.form1.submit();
		}
    }
	
  </Script>
   
</HEAD>

<BODY id="popup2">

	<form name="form1" method="post" action="nonscore_upload.jsp" enctype="multipart/form-data">
	<input type="hidden" name="id_exam" value="<%=id_exam%>">
	<input type="hidden" name="id_q" value="<%=id_q%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">논술형(실기형) 점수 및 강평 등록</div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	
	<div id="contents">
		<img src="../../images/sub2_webscore1.gif">
		<div class="box">		
			[문제코드 <%= id_q %>] <%= strQ %>&nbsp;&nbsp;&nbsp;[배점] <%= allotting %><br>
			[해설(채점기준)] <%= strExplain %>
		</div>
	</div>
	<br>
	<div id="contents">		
		<div align="right">		
			<a href="<%=ComLib.getConfig("adminurl")%>/PracticeSample.zip"><b>[일괄등록샘플파일다운로드]</b></a>
		</div>
	</div>
	
	<div id="contents">
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">			
			<tr>
				<td id="left" width="15%"><li>엑셀파일</td>
				<td colspan="3"><input type="file" name="file" size="65" class="form2">&nbsp;&nbsp;<input type="button" value="엑셀파일 등록" class="form" onClick="Sends();"></td>
				</form>
			</tr>	
		</table>
		</div>
	</div>	
	
	<div id="button">
		<a href="javascript:window.close();"><img src="../../images/bt_close_1.gif" align="top"></a></div>
	</div>
	</form>
 </BODY>
</HTML>