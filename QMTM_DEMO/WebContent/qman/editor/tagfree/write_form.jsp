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

// �޴����� ������ �����ֱ�..
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
			<td>&nbsp;������ȣ : 123456</td>
			<td width="100" align="center"><a href="javascript:OnSave()">�����ϱ�</a></td>
			<td width="100" align="center"><a href="javascript:OnInit()">������</a></td>
			<td width="100" align="center">��������</td>
			<td width="100" align="center">�̸�����</td>
			<td width="100" align="center">��������ó��</td>
			<td width="100" align="center">���������ڷ�</td>
			<td width="100" align="center">â�ݱ�</td>
		</tr>
	</table>
	
	<table border="0" width="1000" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC">
		<tr bgcolor="#FFFFFF">
			<td width="500" height="640" valign="top">
			<table border="0">
				<tr>
					<td width="500" height="640">
					<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
					<script language="jscript" src="tweditor.js"></script>
					<!-- Active Designer �߰� �� -->
					</td>			
				</tr>
			</table>
			</td>
		
			<td width="500" align="right" valign="top">
			<table>
				<tr bgcolor="#FFFFFF" height="38">
					<td colspan="2" align="right"><input type="button" value="����/����" onClick="movieLayout('q');">&nbsp;&nbsp;<input type="button" value="�ؼ�" onClick="movieLayout('explain');">&nbsp;&nbsp;<input type="button" value="��Ʈ" onClick="movieLayout('hint');">&nbsp;&nbsp;<input type="button" value="����" onClick="movieLayout('refbody');">&nbsp;&nbsp;<input type="button" value="��������" onClick="movieLayout('infos')">&nbsp;&nbsp;<input type="button" value="��ó����" onClick="movieLayout('prints');"></td>
				</tr>
			</table>
				
		<table border="0" border="0" width="100%" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC" style="display:block;" id="id_q">		
		<tr bgcolor="#FFFFFF">
			<td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="1">
			</td>
			<td width="500" height="<%=600/8%>">
			<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
			<script language="jscript" src="tweditor2.js"></script>
			<!-- Active Designer �߰� �� -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="2">
			</td>
			<td width="500" height="<%=600/8%>">
			<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
			<script language="jscript" src="tweditor3.js"></script>
			<!-- Active Designer �߰� �� -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="3">
			</td>
			<td width="500" height="<%=600/8%>">
			<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
			<script language="jscript" src="tweditor4.js"></script>
			<!-- Active Designer �߰� �� -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="4">
			</td>
			<td width="500" height="<%=600/8%>">
			<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
			<script language="jscript" src="tweditor5.js"></script>
			<!-- Active Designer �߰� �� -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="5">
			</td>
			<td width="500" height="<%=600/8%>">
			<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
			<script language="jscript" src="tweditor6.js"></script>
			<!-- Active Designer �߰� �� -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="6">
			</td>
			<td width="500" height="<%=600/8%>">
			<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
			<script language="jscript" src="tweditor7.js"></script>
			<!-- Active Designer �߰� �� -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="7">
			</td>
			<td width="500" height="<%=600/8%>">
			<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
			<script language="jscript" src="tweditor8.js"></script>
			<!-- Active Designer �߰� �� -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="8">
			</td>
			<td width="500" height="<%=600/8%>">
			<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
			<script language="jscript" src="tweditor9.js"></script>
			<!-- Active Designer �߰� �� -->
			</td>
		</tr>
	</table>

	<!-- �ؼ� ���� -->
	<table border="0" border="0" width="100%" height="600" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC" style="display:none;" id="id_explain">		
		<tr height="30">
			<td bgcolor="FFFFFF" align="left" colspan="4">&nbsp;&nbsp;<b>* �ؼ����</b></td>			
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="500" height="570">
			<script language="jscript" src="tweditor10.js"></script>
			</td>
		</tr>
	</table>
	<!-- �ؼ� ���� -->

	<!-- ��Ʈ ���� -->
	<table border="0" border="0" width="100%" height="600" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC" style="display:none;" id="id_hint">		
		<tr height="30">
			<td bgcolor="FFFFFF" align="left" colspan="4">&nbsp;&nbsp;<b>* ��Ʈ���</b></td>			
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="500" height="570">
			<script language="jscript" src="tweditor11.js"></script>
			</td>
		</tr>
	</table>
	<!-- ��Ʈ ���� -->

	<!-- ���� ���� -->
	<table border="0" border="0" width="100%" height="600" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC" style="display:none;" id="id_refbody">		
		<tr height="30">
			<td bgcolor="FFFFFF" align="left" colspan="4">&nbsp;&nbsp;<b>* �������</b></td>			
		</tr>
		<tr height="30">				
			<td bgcolor="FFFFFF" align="right"><input type="button" value="������������">&nbsp;&nbsp;<input type="button" value="��������"></td>
		</tr>			
		<tr height="30">				
			<td bgcolor="FFFFFF" align="left">&nbsp;�������� : <input type="text" class="input" name="ref_name" size="57"></td>
		</tr>
		<tr>				
			<td width="500" height="508">
			<script language="jscript" src="tweditor12.js"></script>
			</td>
		</tr>	
	</table>
	<!-- ���� ���� -->

	<!-- �������� ���� -->
	<table border="0" border="0" width="100%" height="400" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC" style="display:none;" id="id_infos">
		<tr height="30">
			<td bgcolor="FFFFFF" align="left" colspan="4">&nbsp;&nbsp;<b>* ��������</b></td>			
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right" width="22%">����&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<input type="text" class="input" name="allotts" size="5"> ��</td>
			<td bgcolor="FFFFFF" align="right" width="22%">��������&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<input type="text" class="input" name="id_qtype" size="10"></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right" width="22%">���ѽð�&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<select name="limittime">
			<% for(int i = 1; i <= 59; i++) { %>
			<option value="<%=i%>"><%=i%></option>
			<% } %>
			</select> �� <select name="limittime2">
			<% for(int i = 0; i <= 59; i++) { %>
			<option value="<%=i%>"><%=i%></option>
			<% } %>
			</select> ��</td>
			<td bgcolor="FFFFFF" align="right" width="22%">�����&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<input type="text" class="input" name="excount" size="10"></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right" width="22%">���̵�&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<select name="id_difficulty1">
			<option value="0">����</option>
			<option value="1">�ֻ�</option>
			<option value="2">��</option>
			<option value="3">��</option>
			<option value="4">��</option>
			<option value="5">����</option>
			</select></td>
			<td bgcolor="FFFFFF" align="right" width="22%">�����&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<input type="text" class="input" name="cacount" size="10"></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right" width="22%">�����뵵&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<select name="">				
			<option value="����">��Ÿ</option>
			<option value="�߰���">�߰���</option>
			<option value="�⸻��">�⸻��</option>
			<option value="������">������</option>
			</select></td>
			<td bgcolor="FFFFFF" align="right" width="22%">����Ƚ��&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<input type="text" class="input" name="readonly" size="10" value="0"></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right">����&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" colspan="3">&nbsp;&nbsp;<textarea name="ca" cols="45" rows="3"></textarea></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right" colspan="2">1�ٿ� ǥ���� ���� ��&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" colspan="2">&nbsp;&nbsp;<input type="text" class="input" name="ex_rowcnt" size="10"></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right">����&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" colspan="3">&nbsp;&nbsp;<input type="text" class="input" name="q_chapter" size="45"></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right">�˻�Ű����&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" colspan="3">&nbsp;&nbsp;<input type="text" class="input" name="find_kwd" size="45"></td>
		</tr>

	</table>
	<!-- �������� ���� -->

	<!-- ��ó���� ���� -->
	<table border="0" border="0" width="100%" height="330" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC" style="display:none;" id="id_prints">
		<tr height="30">
			<td bgcolor="FFFFFF" align="left" colspan="4">&nbsp;&nbsp;<b>* ��ó����</b></td>			
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right" width="22%">����&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" colspan="3">&nbsp;&nbsp;<input type="text" class="input" name="" size="45"></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right" width="22%">������&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<input type="text" class="input" name="" size="15"></td>
			<td bgcolor="FFFFFF" align="right" width="22%">���ǿ���&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" width="28%">&nbsp;&nbsp;<select name="">
			<% for(int i = 2008; i <= 2015; i++) { %>
			<option value="<%=i%>"><%=i%>��</option>
			<% } %>
			</select>
			</td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right">���ǻ�&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" colspan="3">&nbsp;&nbsp;<input type="text" class="input" name="" size="45"></td>
		</tr>
		<tr>
			<td bgcolor="FFFFFF" align="right">��Ÿ&nbsp;</td>
			<td bgcolor="FFFFFF" align="left" colspan="3">&nbsp;&nbsp;<textarea name="" cols="45" rows="10"></textarea></td>
		</tr>
	</table>
	<!-- ��ó���� ���� -->

	</td>
		</tr>	
	</table>
	</form>
</body></html>
