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
		Call MsgWindow("�����ͺ��̽��� �����ϴ��� ������ �߻� �Ͽ����ϴ�\n\n����ڿ��� ���� �Ͻʽÿ�")
		Response.End
	End If 
%>

<html>
<head>
<title>�ܴ��� �� ����� ������ ä��</title>
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
		<!-- ���� ��� -->
		<TD class="Left" rowspan="2">&nbsp;</TD>
		<!-- ���� ��� Ÿ��Ʋ �� ���� ��ġ ǥ�� -->
		<TD class="CenterTop">
			<div id="L">
			<img src="../images/title_ad_web.gif">
			</div>
			<div id="R"><li>&nbsp;������ ä��</li></div>
		</TD>
		<TD class="Right" rowspan="2">&nbsp;</TD>
	</TR>
	<TR>
		
		<TD class="CenterMain">
		<!-- ���� ���� -->	
			<img src="../images/sub_admin1.gif" id="subt">
			<table border="0" cellspacing="0" cellpadding="0" class="Ctype"> 
				<tr class="title" style="text-align: center;"> 
					<td id="Tleft" width="30">����<br>�ڵ�</td>
					<td>����</td>
					<td width="130">����</td>
					<td width="30">����</td>
					<td width="60">ä��</td>					
				</tr>	
				<%
					' �ش� ���迡 �ܴ��� ������ ������ �ɴϴ�.
					SQL = ""
					SQL = SQL & "Select distinct a.id_q, convert(varchar(3000), b.q) q, b.ca "
					SQL = SQL & "From exam_paper2 a, q b "
					SQL = SQL & "Where a.id_exam='"&id_exam&"' and a.id_q = b.id_q and b.id_qtype = 4 "

					Chk = Rst_OPEN(SQL, "R")	
		
					If Rst.eof Then 
				%>
					<tr> 
						<td colspan="5" class="blank" id="Tleft" style="text-align: center;">�ܴ��� ������ �����ϴ�.</td>
					</tr>
				<%
					Else 
					While Not Rst.eof 

					' �ش� ���迡 �ܴ��� ������ ������ �ɴϴ�.
					SQL = ""
					SQL = SQL & "Select top 1 a.allotting "
					SQL = SQL & "From exam_paper2 a, q b "
					SQL = SQL & "Where a.id_exam='"&id_exam&"' and a.id_q = b.id_q and a.id_q = '"&Rst("id_q")&"' "
					
					Set rs = Cnn.Execute(SQL)

					allot = Rs("allotting")

					rs.Close
					Set rs = Nothing
		
					result = Replace(Rst("ca"), "{^}", " �Ǵ� ")	
					result = Replace(result, "{|}", ", ")		
			%>

					<tr> 
						<td id="Tleft" style="text-align: center;"><%=Rst("id_q")%></td>
						<td style="text-align: left; vertical-align:top;"><%=Rst("q")%></td>    
						<td style="text-align: left; vertical-align:middle;"><%=result%></td>
						<td style="text-align: center;"><%=allot%> ��</td>	
						<td style="text-align: center;"><div class="linkA"><a href="javascript:score_win('<%=id_exam%>','<%=Rst("id_q")%>');">ä���ϱ�</a></div></td>  
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
					<td id="Tleft" width="30">����<br>�ڵ�</td>
					<td>����</td>
					<td width="30">����</td>
					<td width="60">ä��</td>					
				</tr>	
				<%
					' �ش� ���迡 �ܴ��� ������ ������ �ɴϴ�.
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
						<td colspan="4" class="blank" id="Tleft" style="text-align: center;">������ ������ �����ϴ�.</td>
					</tr>
				<%
					Else 
					While Not Rst.eof 

					' �ش� ���迡 ������ ������ ������ �ɴϴ�.
					SQL = ""
					SQL = SQL & "Select top 1 a.allotting "
					SQL = SQL & "From exam_paper2 a, q b "
					SQL = SQL & "Where a.id_exam='"&id_exam&"' and a.id_q = b.id_q and a.id_q = '"&Rst("id_q")&"' "
					
					Set rs = Cnn.Execute(SQL)

					allot = Rs("allotting")

					rs.Close
					Set rs = Nothing
		
'					result = Replace(Rst("ca"), "{^}", " �Ǵ� ")	
'					result = Replace(result, "{|}", "<BR>")		
			%>

					<tr> 
						<td id="Tleft" style="text-align: center;"><%=Rst("id_q")%></td>
						<td style="text-align: left; vertical-align:top;"><%=Rst("q")%></td>    
						<td style="text-align: center;"><%=allot%> ��</td>	
						<td style="text-align: center;"><div class="linkA"><a href="javascript:p_score_win('<%=Rst("id_q")%>');">ä���ϱ�</a></div></td>  
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
						<li>������ ä���� 1�ܰ�� ���� �����Դϴ�. ä���� ���ϴ� ������ �����Ͻ� �� ������ ä�� ��ư�� Ŭ���Ͽ� �� ä���� �����մϴ�.</li>
						<li>�ܴ����� ����� ������ ä�� ����� ���� �ٸ��� �� ���� �����Ͻñ� �ٶ��ϴ�.</li>
					</TD>
				</TR>
				<TR>
					<TD id="bt"></TD>
				</TR>
			</TABLE>
		
		</TD>
	</TR>
	<!-- �ϴ� ī�Ƕ���Ʈ -->
</TABLE>

</BODY>
</HTML>