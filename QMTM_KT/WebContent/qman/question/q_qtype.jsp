<%
//******************************************************************************
//   프로그램 : q_qtype.jsp
//   모 듈 명 : 문제 유형 설정
//   설    명 : 신규 문제 유형(QTYPE) 설정
//   테 이 블 : q
//   자바파일 : qmtm.*, qmtm.qman.question.*, qmtm.admin.*
//   작 성 일 : 2008-04-17
//   작 성 자 : 이테스트 강진아
//   수 정 일 : 2008-08-18
//   수 정 자 : 이테스트 석준호
//	 수정사항 : 문제유형, 보기설정 부분 변경
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.qman.question.*, qmtm.admin.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = "0"; } else { id_q_subject = id_q_subject.trim(); }	

	if (id_q_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String id_q_chapter = request.getParameter("id_q_chapter"); // 단원 1
	if (id_q_chapter == null) { id_q_chapter = "-1"; } else { id_q_chapter = id_q_chapter.trim(); }

	String id_q_chapter2 = request.getParameter("id_q_chapter2"); // 단원 2
	if (id_q_chapter2 == null) { id_q_chapter2 = "-1"; } else { id_q_chapter2 = id_q_chapter2.trim(); }

	String id_q_chapter3 = request.getParameter("id_q_chapter3"); // 단원 3
	if (id_q_chapter3 == null) { id_q_chapter3 = "-1"; } else { id_q_chapter3 = id_q_chapter3.trim(); }

	String id_q_chapter4 = request.getParameter("id_q_chapter4"); // 단원 4
	if (id_q_chapter4 == null) { id_q_chapter4 = "-1"; } else { id_q_chapter4 = id_q_chapter4.trim(); }

	String qtype = (String)session.getAttribute("qtype"); // 문제유형
	if (qtype == null) { qtype= "2"; } else { qtype = qtype.trim(); }

	String excounts = (String)session.getAttribute("excounts"); // 보기갯수	
	if (excounts == null) { excounts= "4"; } else { excounts = excounts.trim(); }
%>

<HTML>
 <HEAD>
  <TITLE>:: 문제 유형 설정 ::</TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <SCRIPT LANGUAGE="JavaScript">
  <!--

	var excounts = "<%=excounts%>";
	
	function ChkQtype(qtype) {

		var qtype, i, ex_type, ca_type;	

		var frm = document.frmdata;

		if(qtype==1){
			ex = 2;
			ca = 1;
			k1 = 2;
			l1 = 1;
			frm.explains.value = "제시한 문제의 정답을 예, 아니오 둘 중 하나의 정답을 요구하는 문제유형입니다.";
		} else if(qtype==2){
			ex = 5;
			ca = 1;		
			k1 = 3;
			l1 = 1;
			frm.explains.value = "보기 지문 3 ~ 5개 중 하나의 정답을 고르는 문제유형입니다.";
		} else if(qtype==3){
			ex = 5;
			ca = 5;
			k1 = 3;
			l1 = 2;
			frm.explains.value = "보기 지문 3 ~ 5개 중 두개 이상의 정답을 고르는 문제유형입니다.";
		} else if(qtype==4){
			ex = 0;
			ca = 5;
			k1 = 0;
			l1 = 1;
			frm.explains.value = "보기 지문 없이 제시한 문제의 하나 또는 그 이상의 정답을 응시자가 직접 기입하도록 하는 문제유형입니다.";
		} else if(qtype==5){
			ex = 0;
			ca = 0;
			k1 = 0;
			l1 = 0;
			frm.explains.value = "제시한 문제가 요구하는 답안을 응시자가 서술식으로 답안을 작성하도록 하는 문제유형입니다. 이 문제유형은 자동 채점을 지원하지 않습니다.";
		}

		var str = "";
		str += "<select name=excount>";

		var sels = "";
		
		for(var i = k1; i <= ex; i++){
			if(excounts == i) {
				sels = "selected";
			} else {
				sels = "";
			}
			str += "<OPTION VALUE=" + i + " " + sels + " >" + i + "</option>";
		}

		str += "</SELECT>";
		
		document.all.qex.innerHTML = str;

		var str2 = "";

		str2 += "<SELECT NAME=cacount>";   
		
		for(var j = l1; j <= ca; j++){
			str2 += "<OPTION VALUE=" + j + ">" + j + "</option>";
		}

		str2 += "</SELECT>";
		
		document.all.qca.innerHTML = str2;		
	}

	function aaa()
	{
		document.frmdata.action = "../editor/write_form.jsp";
		document.frmdata.method = "";
		document.frmdata.submit();

	}

	function bbb()
	{
		document.frmdata.action = "../editor/write_form_text.jsp";
		document.frmdata.method = "";
		document.frmdata.submit();

	}

  //-->
  </SCRIPT>
 </HEAD>

 <BODY onLoad = "ChkQtype(<%=qtype%>)" id="popup2">
	
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">문제유형 설정<span>신규문제의 유형을 선택합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>	

	<FORM name="frmdata" method="post">

	<div id="contents">		
	
		<INPUT TYPE="hidden" NAME="id_q_subject" value="<%=id_q_subject%>">
		<INPUT TYPE="hidden" NAME="id_q_chapter" value="<%=id_q_chapter%>">
		<INPUT TYPE="hidden" NAME="id_q_chapter2" value="<%=id_q_chapter2%>">
		<INPUT TYPE="hidden" NAME="id_q_chapter3" value="<%=id_q_chapter3%>">
		<INPUT TYPE="hidden" NAME="id_q_chapter4" value="<%=id_q_chapter4%>">

		<TABLE width="100%" border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">유형 선택</td>
				<td style="padding: 15px 10px 15px 10px;" align="center">
					<TABLE border="0" cellpadding ="0" cellspacing="0" id="tableA" style="margin-bottom: 10px;">
						<tr align="center" id="tr">
							<td>OX형</TD>
							<td>선다형</TD>
							<td>복수답안형</TD>
							<td>단답형</TD>
							<td>논술형</TD>
						</TR>
						<tr align="center" id="td">
							<TD><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype('1');" VALUE="1" <%if(qtype.equals("1")) { %>checked<% } %>></TD>
							<TD><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype('2');" VALUE="2" <%if(qtype.equals("2")) { %>checked<% } %>></TD>
							<TD><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype('3');" VALUE="3" <%if(qtype.equals("3")) { %>checked<% } %>></TD>
							<TD><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype('4');" VALUE="4" <%if(qtype.equals("4")) { %>checked<% } %>></TD>
							<TD><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype('5');" VALUE="5" <%if(qtype.equals("5")) { %>checked<% } %>></TD>
						</TR>
					</TABLE>
					<textarea name="explains" rows="4" readonly style="width: 310px; padding: 10px;"></textarea>
				</td>
			</tr>
			<tr>
				<td id="left">보기 갯수</td>
				<td id="qex"></td>
			</tr>
			<tr>
				<td id="left">정답 갯수</td>
				<td id="qca"></td>
			</tr>
		</table>
				
		</FORM>

	</div>

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>* <font color=red>멀티미디어 문제등록</font> : 멀티미디어(표, 이미지, 동영상 등)가 포함된 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;문항 등록시 선택
	<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* <font color=red>텍스트 문제등록</font> : 텍스트로만 문제 등록시 선택</b>

	<DIV id="button"><a href="javascript:aaa();" style="cursor: hand;">[멀티미디어 문제등록]</a>&nbsp;&nbsp;<a href="javascript:bbb();" style="cursor: hand;">[텍스트 문제등록]</a>&nbsp;&nbsp;<a href="javascript:window.close();" style="cursor: hand;">[창닫기]</a></DIV>
 
 </BODY>
</HTML>