<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,com.tagfree.util.*,org.w3c.tidy.*,org.w3c.dom.*" %>
<html>
<head>
<title>NKiller</title>
<link rel="StyleSheet" href="../../../../css/style.css" type="text/css">
<script>
<!--
function OnSave()
{
	var form = document.writeForm;
	var str = document.twe.MimeValue();
	var str2 = document.twe2.MimeValue();
	var str3 = document.twe3.MimeValue();
	var str4 = document.twe4.MimeValue();
	var str5 = document.twe5.MimeValue();
	var str6 = document.twe6.MimeValue();
	var str7 = document.twe7.MimeValue();
	var str8 = document.twe8.MimeValue();
	var str9 = document.twe9.MimeValue();
	var str10 = document.twe10.MimeValue();
	var str11 = document.twe11.MimeValue();
	var str12 = document.twe12.MimeValue();

	form.mime_contents.value = str;
	form.mime_contents2.value = str2;
	form.mime_contents3.value = str3;
	form.mime_contents4.value = str4;
	form.mime_contents5.value = str5;
	form.mime_contents6.value = str6;
	form.mime_contents7.value = str7;
	form.mime_contents8.value = str8;
	form.mime_contents9.value = str9;
	form.mime_contents10.value = str10;
	form.mime_contents11.value = str11;
	form.mime_contents12.value = str12;
	form.submit();
}

function OnInit()
{
	var form = document.writeForm;
	form.twe12.InitDocument();
	form.twe11.InitDocument();
	form.twe10.InitDocument();
	form.twe9.InitDocument();
	form.twe8.InitDocument();
	form.twe7.InitDocument();
	form.twe6.InitDocument();
	form.twe5.InitDocument();
	form.twe4.InitDocument();
	form.twe3.InitDocument();
	form.twe2.InitDocument();
	form.twe.InitDocument();
}

// 메뉴별로 페이지 보여주기..
	function movieLayout(obj) {
		if(obj == "q") {
			document.all.id_q.style.display = "block";
			document.all.id_explain.style.display = "none";
			document.all.id_hint.style.display = "none";
			document.all.id_refbody.style.display = "none";
			document.all.id_infos.style.display = "none";
			document.all.id_prints.style.display = "none";
		} else if(obj == "explain") {
			document.all.id_q.style.display = "none";
			document.all.id_explain.style.display = "block";
			document.all.id_hint.style.display = "none";
			document.all.id_refbody.style.display = "none";
			document.all.id_infos.style.display = "none";
			document.all.id_prints.style.display = "none";
		} else if(obj == "hint"){
		    document.all.id_q.style.display = "none";
			document.all.id_explain.style.display = "none";
			document.all.id_hint.style.display = "block";
			document.all.id_refbody.style.display = "none";
			document.all.id_infos.style.display = "none";
			document.all.id_prints.style.display = "none";
		} else if(obj == "refbody"){
		    document.all.id_q.style.display = "none";
			document.all.id_explain.style.display = "none";
			document.all.id_hint.style.display = "none";
			document.all.id_refbody.style.display = "block";
			document.all.id_infos.style.display = "none";
			document.all.id_prints.style.display = "none";
		} else if(obj == "infos"){
		    document.all.id_q.style.display = "none";
			document.all.id_explain.style.display = "none";
			document.all.id_hint.style.display = "none";
			document.all.id_refbody.style.display = "none";
			document.all.id_infos.style.display = "block";
			document.all.id_prints.style.display = "none";
		} else if(obj == "prints"){
		    document.all.id_q.style.display = "none";
			document.all.id_explain.style.display = "none";
			document.all.id_hint.style.display = "none";
			document.all.id_refbody.style.display = "none";
			document.all.id_infos.style.display = "none";
			document.all.id_prints.style.display = "block";
		}
	}
-->
</script>
</head>
<body topmargin="0" leftmargin="0" bgcolor="white" scroll="auto">
	<form name="writeForm" method="post" action="write.jsp">
	<input type="hidden" name="mime_contents">
	<input type="hidden" name="mime_contents2">
	<input type="hidden" name="mime_contents3">
	<input type="hidden" name="mime_contents4">
	<input type="hidden" name="mime_contents5">
	<input type="hidden" name="mime_contents6">
	<input type="hidden" name="mime_contents7">
	<input type="hidden" name="mime_contents8">
	<input type="hidden" name="mime_contents9">
	<input type="hidden" name="mime_contents10">
	<input type="hidden" name="mime_contents11">
	<input type="hidden" name="mime_contents12">
	<table border="0" width="1000" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC">
		<tr bgcolor="#FFFFFF" height="30">
			<td>&nbsp;문제번호 : 123456</td>
			<td width="100" align="center"><a href="javascript:OnSave()">저장하기</a></td>
			<td width="100" align="center"><a href="javascript:OnInit()">새문제</a></td>
			<td width="100" align="center">문제유형</td>
			<td width="100" align="center">미리보기</td>
			<td width="100" align="center">오류문제처리</td>
			<td width="100" align="center">응답집계자료</td>
			<td width="100" align="center">창닫기</td>
		</tr>
	</table>
	
	<table border="0" width="1000" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC">
		<tr bgcolor="#FFFFFF">
			<td width="500" height="640" valign="top">
			<table border="0">
				<tr>
					<td width="500" height="640">
					<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
					<script language="jscript" src="tweditor.js"></script>
					<!-- Active Designer 추가 끝 -->
					</td>			
				</tr>
			</table>
			</td>
		
			<td width="500" align="right" valign="top">
			<table>
				<tr bgcolor="#FFFFFF" height="38">
					<td colspan="2" align="right"><input type="button" value="보기/정답" onClick="movieLayout('q');">&nbsp;&nbsp;<input type="button" value="해설" onClick="movieLayout('explain');">&nbsp;&nbsp;<input type="button" value="힌트" onClick="movieLayout('hint');">&nbsp;&nbsp;<input type="button" value="지문" onClick="movieLayout('refbody');">&nbsp;&nbsp;<input type="button" value="문제정보" onClick="movieLayout('infos')">&nbsp;&nbsp;<input type="button" value="출처정보" onClick="movieLayout('prints');"></td>
				</tr>
			</table>
				
		<table border="0" border="0" width="100%" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC" style="display:block;" id="id_q">		
		<tr bgcolor="#FFFFFF">
			<td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="1">
			</td>
			<td width="500" height="<%=600/8%>">
			<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
			<script language="jscript" src="tweditor2.js"></script>
			<!-- Active Designer 추가 끝 -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="2">
			</td>
			<td width="500" height="<%=600/8%>">
			<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
			<script language="jscript" src="tweditor3.js"></script>
			<!-- Active Designer 추가 끝 -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="3">
			</td>
			<td width="500" height="<%=600/8%>">
			<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
			<script language="jscript" src="tweditor4.js"></script>
			<!-- Active Designer 추가 끝 -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="4">
			</td>
			<td width="500" height="<%=600/8%>">
			<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
			<script language="jscript" src="tweditor5.js"></script>
			<!-- Active Designer 추가 끝 -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="5">
			</td>
			<td width="500" height="<%=600/8%>">
			<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
			<script language="jscript" src="tweditor6.js"></script>
			<!-- Active Designer 추가 끝 -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="6">
			</td>
			<td width="500" height="<%=600/8%>">
			<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
			<script language="jscript" src="tweditor7.js"></script>
			<!-- Active Designer 추가 끝 -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="7">
			</td>
			<td width="500" height="<%=600/8%>">
			<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
			<script language="jscript" src="tweditor8.js"></script>
			<!-- Active Designer 추가 끝 -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="8">
			</td>
			<td width="500" height="<%=600/8%>">
			<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
			<script language="jscript" src="tweditor9.js"></script>
			<!-- Active Designer 추가 끝 -->
			</td>
		</tr>
	</table>

	<!-- 해설 시작 -->
	<table border="0" border="0" width="100%" height="600" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC" style="display:none;" id="id_explain">		
		<tr height="30">
			<td bgcolor="FFFFFF" align="left" colspan="4">&nbsp;&nbsp;<b>* 해설등록</b></td>			
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="500" height="570">
			<script language="jscript" src="tweditor10.js"></script>
			</td>
		</tr>
	</table>
	<!-- 해설 종료 -->

	<!-- 힌트 시작 -->
	<table border="0" border="0" width="100%" height="600" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC" style="display:none;" id="id_hint">		
		<tr height="30">
			<td bgcolor="FFFFFF" align="left" colspan="4">&nbsp;&nbsp;<b>* 힌트등록</b></td>			
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="500" height="570">
			<script language="jscript" src="tweditor11.js"></script>
			</td>
		</tr>
	</table>
	<!-- 힌트 종료 -->

	<!-- 지문 시작 -->
	<table border="0" border="0" width="100%" height="600" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC" style="display:none;" id="id_refbody">		
		<tr height="30">
			<td bgcolor="FFFFFF" align="left" colspan="4">&nbsp;&nbsp;<b>* 지문등록</b></td>			
		</tr>
		<tr height="30">				
			<td bgcolor="FFFFFF" align="right"><input type="button" value="기존지문선택">&nbsp;&nbsp;<input type="button" value="지문저장"></td>
		</tr>			
		<tr height="30">				
			<td bgcolor="FFFFFF" align="left">&nbsp;지문제목 : <input type="text" class="input" name="ref_name" size="57"></td>
		</tr>
		<tr>				
			<td width="500" height="508">
			<script language="jscript" src="tweditor12.js"></script>
			</td>
		</tr>	
	</table>
	<!-- 지문 종료 -->

	<!-- 문제정보 시작 -->
	<table border="0" border="0" width="100%" height="400" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC" style="display:none;" id="id_infos">
		<tr height="30">
			<td bgcolor="FFFFFF" align="left" colspan="4">&nbsp;&nbsp;<b>* 문제정보</b></td>			
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right" width="22%">배점&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<input type="text" class="input" name="allotts" size="5"> 점</td>
			<td bgcolor="FFFFFF" align="right" width="22%">문제유형&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<input type="text" class="input" name="id_qtype" size="10"></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right" width="22%">제한시간&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<select name="limittime">
			<% for(int i = 1; i <= 59; i++) { %>
			<option value="<%=i%>"><%=i%></option>
			<% } %>
			</select> 분 <select name="limittime2">
			<% for(int i = 0; i <= 59; i++) { %>
			<option value="<%=i%>"><%=i%></option>
			<% } %>
			</select> 초</td>
			<td bgcolor="FFFFFF" align="right" width="22%">보기수&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<input type="text" class="input" name="excount" size="10"></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right" width="22%">난이도&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<select name="id_difficulty1">
			<option value="0">없음</option>
			<option value="1">최상</option>
			<option value="2">상</option>
			<option value="3">중</option>
			<option value="4">하</option>
			<option value="5">최하</option>
			</select></td>
			<td bgcolor="FFFFFF" align="right" width="22%">정답수&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<input type="text" class="input" name="cacount" size="10"></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right" width="22%">문제용도&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<select name="">				
			<option value="없음">기타</option>
			<option value="중간평가">중간평가</option>
			<option value="기말평가">기말평가</option>
			<option value="퀴즈평가">퀴즈평가</option>
			</select></td>
			<td bgcolor="FFFFFF" align="right" width="22%">출제횟수&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<input type="text" class="input" name="readonly" size="10" value="0"></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right">정답&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" colspan="3">&nbsp;&nbsp;<textarea name="ca" cols="45" rows="3"></textarea></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right" colspan="2">1줄에 표시할 보기 수&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" colspan="2">&nbsp;&nbsp;<input type="text" class="input" name="ex_rowcnt" size="10"></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right">영역&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" colspan="3">&nbsp;&nbsp;<input type="text" class="input" name="q_chapter" size="45"></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right">검색키워드&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" colspan="3">&nbsp;&nbsp;<input type="text" class="input" name="find_kwd" size="45"></td>
		</tr>

	</table>
	<!-- 문제정보 종료 -->

	<!-- 출처정보 시작 -->
	<table border="0" border="0" width="100%" height="330" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC" style="display:none;" id="id_prints">
		<tr height="30">
			<td bgcolor="FFFFFF" align="left" colspan="4">&nbsp;&nbsp;<b>* 출처정보</b></td>			
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right" width="22%">저자&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" colspan="3">&nbsp;&nbsp;<input type="text" class="input" name="" size="45"></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right" width="22%">페이지&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<input type="text" class="input" name="" size="15"></td>
			<td bgcolor="FFFFFF" align="right" width="22%">출판연도&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<select name="">
			<% for(int i = 2008; i <= 2015; i++) { %>
			<option value="<%=i%>"><%=i%>년</option>
			<% } %>
			</select>
			</td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right">출판사&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" colspan="3">&nbsp;&nbsp;<input type="text" class="input" name="" size="45"></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right">기타&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" colspan="3">&nbsp;&nbsp;<textarea name="" cols="45" rows="10"></textarea></td>
		</tr>
	</table>
	<!-- 출처정보 종료 -->

	</td>
		</tr>	
	</table>
	</form>
</body></html>
