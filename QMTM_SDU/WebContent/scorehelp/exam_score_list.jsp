<!--#include file="../common/ADO.asp" -->
<!--#include file="../common/function.asp" -->
<%
	Response.CacheControl = "no-cache" 
	Response.AddHeader "pragma", "no-cache" 
	Response.Expires = -1

	if Session("adminid") = "" Then
		Call MsgLogout
		Response.End
	End if

	userid = Session("adminid")
	id_exam = Request("id_exam")
    
	CChk = CNN_OPEN("qmtmdb")
	
	if CChk = -1 then
		Call MsgWindow("데이터베이스에 연결하던중 오류가 발생 하였습니다\n\n담당자에게 문의 하십시요")
		Response.End
	End If 
%>

<html>
<head>
<title>단답형 및 논술형 문제별 채점</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/jquery.etest.poster.js"></script>
<script language="javascript">

	function score_win(id_exam,id_q) {
		$.posterPopup("./score_help_Res2.asp?id_exam=<%= id_exam %>&id_q="+id_q, "score", "menubar=no, scrollbars=yes, width=100, height=100, fullscreen");
	}

	function p_score_win(id_q) {
		$.posterPopup("./qmarknon.asp?id_exam=<%= id_exam %>&id_q="+id_q, "p_scorewin", "fullscree=yes, menubar=no, scrollbars=yes, width=100, height=100, fullscreen, top=0, left=0");
	}
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="../css/style_admin.css" type="text/css">
<link rel="stylesheet" href="../css/table_admin.css" type="text/css">
</HEAD>

<body oncontextmenu="javascript:return false;" ondragstart="javascript:return false;" onselectstart="javascript:return false;">
<TABLE cellpadding="0" cellspacing="0" border="0" class="Layout">
	<TR>
		<!-- 좌측 배경 -->
		<TD class="Left" rowspan="2">&nbsp;</TD>
		<!-- 본문 상단 타이틀 및 현재 위치 표시 -->
		<TD class="CenterTop">
			<div id="L">
			<img src="../images/title_ad_web.gif">
			</div>
			<div id="R"><li>&nbsp;문제별 채점</li></div>
		</TD>
		<TD class="Right" rowspan="2">&nbsp;</TD>
	</TR>
	<TR>
		
		<TD class="CenterMain">
		<!-- 본문 시작 -->	
			<img src="../images/sub_admin1.gif" id="subt">
			<table border="0" cellspacing="0" cellpadding="0" class="Ctype"> 
				<tr class="title" style="text-align: center;"> 
					<td id="Tleft" width="30">문제<br>코드</td>
					<td>문제</td>
					<td width="130">정답</td>
					<td width="30">배점</td>
					<td width="60">채점</td>					
				</tr>	
				<%
					' 해당 시험에 단답형 문제를 가지고 옵니다.
					SQL = ""
					SQL = SQL & "Select distinct a.id_q, convert(varchar(3000), b.q) q, b.ca "
					SQL = SQL & "From exam_paper2 a, q b "
					SQL = SQL & "Where a.id_exam='"&id_exam&"' and a.id_q = b.id_q and b.id_qtype = 4 "

					Chk = Rst_OPEN(SQL, "R")	
		
					If Rst.eof Then 
				%>
					<tr> 
						<td colspan="5" class="blank" id="Tleft" style="text-align: center;">단답형 문제가 없습니다.</td>
					</tr>
				<%
					Else 
					While Not Rst.eof 

					' 해당 시험에 단답형 배점을 가지고 옵니다.
					SQL = ""
					SQL = SQL & "Select top 1 a.allotting "
					SQL = SQL & "From exam_paper2 a, q b "
					SQL = SQL & "Where a.id_exam='"&id_exam&"' and a.id_q = b.id_q and a.id_q = '"&Rst("id_q")&"' "
					
					Set rs = Cnn.Execute(SQL)

					allot = Rs("allotting")

					rs.Close
					Set rs = Nothing
		
					result = Replace(Rst("ca"), "{^}", " 또는 ")	
					result = Replace(result, "{|}", ", ")		
			%>

					<tr> 
						<td id="Tleft" style="text-align: center;"><%=Rst("id_q")%></td>
						<td style="text-align: left; vertical-align:top;"><%=Rst("q")%></td>    
						<td style="text-align: left; vertical-align:middle;"><%=result%></td>
						<td style="text-align: center;"><%=allot%> 점</td>	
						<td style="text-align: center;"><div class="linkA"><a href="javascript:score_win('<%=id_exam%>','<%=Rst("id_q")%>');">채점하기</a></div></td>  
					</tr>				
				<% 
							Rst.MoveNext
							Wend
						End If
						Call Rst_Close						
				%>

			</table>

			<br><br>
			<img src="../images/sub_admin2.gif" id="subt">
			<table border="0" cellspacing="0" cellpadding="0" class="Ctype"> 
				<tr class="title" style="text-align: center;"> 
					<td id="Tleft" width="30">문제<br>코드</td>
					<td>문제</td>
					<td width="30">배점</td>
					<td width="60">채점</td>					
				</tr>	
				<%
					' 해당 시험에 단답형 문제를 가지고 옵니다.
					SQL = ""
					SQL = SQL & "Select distinct a.id_q, convert(varchar(3000), b.q) q, b.ca "
					SQL = SQL & "From exam_paper2 a, q b "
					SQL = SQL & "Where a.id_exam='"&id_exam&"' and a.id_q = b.id_q and b.id_qtype = 5 "

'					Response.Write SQL
'					Response.End

					Chk = Rst_OPEN(SQL, "R")	
		
					If Rst.eof Then 
				%>
					<tr> 
						<td colspan="4" class="blank" id="Tleft" style="text-align: center;">서술형 문제가 없습니다.</td>
					</tr>
				<%
					Else 
					While Not Rst.eof 

					' 해당 시험에 서술형 배점을 가지고 옵니다.
					SQL = ""
					SQL = SQL & "Select top 1 a.allotting "
					SQL = SQL & "From exam_paper2 a, q b "
					SQL = SQL & "Where a.id_exam='"&id_exam&"' and a.id_q = b.id_q and a.id_q = '"&Rst("id_q")&"' "
					
					Set rs = Cnn.Execute(SQL)

					allot = Rs("allotting")

					rs.Close
					Set rs = Nothing
		
'					result = Replace(Rst("ca"), "{^}", " 또는 ")	
'					result = Replace(result, "{|}", "<BR>")		
			%>

					<tr> 
						<td id="Tleft" style="text-align: center;"><%=Rst("id_q")%></td>
						<td style="text-align: left; vertical-align:top;"><%=Rst("q")%></td>    
						<td style="text-align: center;"><%=allot%> 점</td>	
						<td style="text-align: center;"><div class="linkA"><a href="javascript:p_score_win('<%=Rst("id_q")%>');">채점하기</a></div></td>  
					</tr>				
				<% 
							Rst.MoveNext
							Wend
						End If
						Call Rst_Close
						Call Cnn_Close
				%>

			</table>

			<TABLE class="Etype" cellpadding="0" cellspacing="0" border="0"> 
				<TR>
					<TD>
						<li>문제별 채점의 1단계는 문제 선택입니다. 채점을 원하는 문제를 선택하신 후 우측의 채점 버튼을 클릭하여 웹 채점을 진행합니다.</li>
						<li>단답형과 논술형 문제의 채점 방식이 서로 다르니 이 점에 유의하시기 바랍니다.</li>
					</TD>
				</TR>
				<TR>
					<TD id="bt"></TD>
				</TR>
			</TABLE>
		
		</TD>
	</TR>
	<!-- 하단 카피라이트 -->
</TABLE>

</BODY>
</HTML>