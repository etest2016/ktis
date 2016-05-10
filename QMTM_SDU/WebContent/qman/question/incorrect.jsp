<%
//******************************************************************************
//   프로그램 : incorrect.jsp
//   모 듈 명 : 오류문제 처리
//   설    명 : 오류문제 처리
//   테 이 블 : q
//   자바파일 : qmtm.*, qmtm.qman.question.*
//   작 성 일 : 2010-06-05
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, qmtm.common.* " %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q = ""; } else { id_q = id_q.trim(); }	

	String s_id_qtype = request.getParameter("id_qtype");
	if (s_id_qtype == null) { s_id_qtype = ""; } else { s_id_qtype = s_id_qtype.trim(); }	

	String ca = request.getParameter("ca");
	if (ca == null) { ca = ""; } else { ca = ca.trim(); }	

	String s_excount = request.getParameter("excount");
	if (s_excount == null) { s_excount = ""; } else { s_excount = s_excount.trim(); }	

	String s_cacount = request.getParameter("cacount");
	if (s_cacount == null) { s_cacount = ""; } else { s_cacount = s_cacount.trim(); }	

	String s_id_valid_type = request.getParameter("id_valid_type");
	if (s_id_valid_type == null) { s_id_valid_type = ""; } else { s_id_valid_type = s_id_valid_type.trim(); }	
		
	if (id_q.length() == 0 || s_id_qtype.length() == 0 || s_excount.length() == 0 || s_cacount.length() == 0 || s_id_valid_type.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}	

	int id_qtype = Integer.parseInt(s_id_qtype);
	int excount = Integer.parseInt(s_excount);
	int cacount = Integer.parseInt(s_cacount);
	int id_valid_type = Integer.parseInt(s_id_valid_type);
%>

<HTML>
<HEAD>
	<TITLE> :: 오류문제 처리 :: </TITLE>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	<script language="javascript">

		var id_qtype = <%=id_qtype%>;
		var ca = "<%=ca%>";
		var excount = <%=excount%>;
		var cacount = <%=cacount%>;
		var id_valid_type = <%=id_valid_type%>;
		
		function inits() {

			var ArrCa = new Array();
			var ArrCa2 = new Array();

			var frm = document.form1;

			eval("frm.id_valid_type[" +id_valid_type+ "].checked = true;");			
			
			if(id_qtype == 2) {				
				for(var i = 0; i < excount; i++) {
					
				
						ArrCa = ca.split("{^}");

						for (var k = 0; k < ArrCa.length; k++) { 
							if(i+1 == parseInt(ArrCa[k])) {					
								frm.ex[i].checked = true;
							}
						}
					
				}

				types(id_valid_type);
			} 	
		}

		function types(types) {

			var frm = document.form1;
			if(types == 0) {
				frm.strs.value = "정답을 1개만 선택하세요.";
				for(var i=0; i<excount; i++) {
					frm.ex[i].disabled = false;
				}
			} else if(types == 1) {
				frm.strs.value = "정답을 모두 선택하세요.";
				for(var i=0; i<excount; i++) {
					frm.ex[i].disabled = false;
				}
			} else if(types == 2) {
				frm.strs.value = "정답을 선택할 필요가 없습니다.";
				for(var i=0; i<excount; i++) {
					frm.ex[i].disabled = true;
				}
			}
		}

		function Send() {

			var frm = document.form1;

			var ca_cnt = 0;

			if((id_qtype == 2) || (id_qtype == 3)) {
			
			if(frm.id_valid_type[0].checked == true) {
				for(var i=0; i<excount; i++) {
					if(frm.ex[i].checked == true) {
						ca_cnt = ca_cnt + 1;
					}
				}

				if(ca_cnt == 0) {
					alert("정답을 선택하셔야 합니다.");
					return false;
				} else if(ca_cnt > 1) {
					alert("정답은 1개만 선택하셔야 합니다.");
					return false;
				}
			}

			}
			
			frm.submit();
		}

	</script>
</HEAD>

<BODY onLoad="inits();" id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">오류문제 정답 처리 <span>오류문제에 채점 조건을 부여합니다</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">
		<form name="form1" method="post" action="incorrect_ok.jsp">
	
		<input type="hidden" name="id_q" value="<%=id_q%>">
		<input type="hidden" name="id_qtype" value="<%=id_qtype%>">

		<table border="0" width="100%" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC">
			<tr bgcolor="#FFFFFF">
				<td width="88%">
					<table border="0">
					<% if(id_qtype == 2 ) { %>
						<tr>
							<td>&nbsp;&nbsp;<input type="radio" name="id_valid_type" value="0" onClick="types(0)"> 정상 문제</td>
						</tr>
						<tr>
							<td>&nbsp;&nbsp;<input type="radio" name="id_valid_type" value="1" onClick="types(1)"> 정답 오류로 처리</td>
						</tr>
						<tr>
							<td>&nbsp;&nbsp;<input type="radio" name="id_valid_type" value="2" onClick="types(2)"> 모두 정답 처리</td>
						</tr>												
					<% } else { %>
						<tr>
							<td>&nbsp;&nbsp;<input type="checkbox" name="id_valid_type" value="2" > 모두 정답 처리</td>
						</tr>
					<% } %>
					</table>
					</td>
					<td>
					<table border="0">
						<% if(id_qtype == 2) { %>
						<tr>
							<td><input type="text" name="strs" size="50" readonly></td>
						</tr>
						<% } %>
						<tr>
							<td>
							<% 
								if(id_qtype == 2) {
									for(int i=1; i<=excount; i++) { 
							%>
									<input type="checkbox" name="ex" value="<%=i%>">&nbsp;<%=i%>번&nbsp;
							<% 
									}
								} 
							%>
							</td>
						</tr>						
					</table>
				</td>
				<td valign="top" width="12%" align="center"><input type="button" value="확인하기" onClick="Send();" class="form"><br><input type="button" value="취소하기" onClick="window.close();" class="form"></td>
			</tr>
		</table>
		
		<br>
		<div class="box" style="overflow-y:scroll; height:250"> 
			&lt;정상 문제&gt;<br>
			문제 유형에 맞게 정답 오류가 없는 문제입니다. 정상적으로 처리가 가능합니다.<br><br>
			&lt;정답 오류&gt;<br>
			정답을 1개만 선택하는 선다형의 경우에만 해당됩니다.<br>
			원래 정답이 1개였으나 출제 후에 문제의 정답에 오류가 발견되어서 원래 정답외 다른 보기 지문도 정답으로 인정이 된다면<br>
			해당 보기 지문도 정답으로 인정해서 채점합니다.<br>
			예를 들어 정답이 1번인데 3번도 정답으로 볼 수 있다면 1번, 3번 모두 체크해놓으면 TMan에서채점시 반영이 됩니다.
			<br><br>
			&lt;모두 정답 처리&gt;<br>
			문제 자체에 오류가 있어서 모든 응시자의 답안을 답안 제출 유무와 관계없이 정답으로 처리합니다.<br>
			--------------------------------------------------------------------------------------------------------------------<br><br>
			&lt;정답 오류&gt; 와 &lt;모두 정답 처리&gt; 두가지 경우는 다음 출제할 때 이 문제를 사용할 수 없습니다. <br>
			반드시 출제해야 한다면 이 문제를 복사해서 새로 복사한 문제를 편집해서 사용하시기 바랍니다.<br><br>

			문제 상태를 변경할 경우 이미 채점이 진행되었다면 TMan에서 채점과 통계 처리를 다시 해야 성적에 반영이 됩니다.<br>
			출제 횟수가 1회 이상이라면 문제 상태를 변경할 경우 이전 시험에서 정확한 성적 조회가 필요하다면 필요한 모든 시험에서<br>
			채점과 통계 처리를 다시 해야 됩니다.<br>
			--------------------------------------------------------------------------------------------------------------------
		</div>
	
	</form>
	</div>
	<div id="button">
		
	</div>
	
</BODY>

</HTML>
	