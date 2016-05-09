<%
//******************************************************************************
//   ���α׷� : receipt_inwons_excel.jsp
//   �� �� �� : �����ο�
//   ��    �� : �����ο� ������
//   �� �� �� : exam_receipt, qt_userid
//   �ڹ����� : qmtm.tman.exam.ExamCreateBean, qmtm.admin.etc.ExamKindUtil,
//              qmtm.admin.etc.ExamKindSubUtil, qmtm.admin.etc.StdGradeUtil,
//              qmtm.admin.etc.StdLevelUtil, qmtm.tman.TreeUtil, 
//              qmtm.tman.exam.RexlabelBean, qmtm.tman.exam.RexlabelUtil
//   �� �� �� : 2008-06-23
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, qmtm.tman.*, java.net.URLDecoder, qmtm.admin.*, java.sql.*, java.util.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	response.setHeader("Content-Disposition", "attachment; filename=MemberList.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");

	String field = request.getParameter("field");
	if (field == null) { field = ""; } else { field = field.trim(); }

	String str = request.getParameter("str");
	if (str == null) { str = ""; } else { str = str.trim(); }
	
	str = new String(str.getBytes("8859_1"),"euc-kr");
			
	MemberBean[] rst = null;
	
	try {
		rst = MemberUtil.getAllBeans(field, str);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

		<table border="1" cellpadding ="0" cellspacing="0" bordercolor="#e1e1e1">
			<tr align="center">							
				<td width="5%" bgcolor="#D8D8D8">NO</td>
				<td width="10%" bgcolor="#D8D8D8">���̵�</td>
				<td width="10%" bgcolor="#D8D8D8">��й�ȣ</td>
				<td width="10%" bgcolor="#D8D8D8">����</td>
				<td bgcolor="#D8D8D8">�Ҽ�����</td>
				<td width="10%" bgcolor="#D8D8D8">����</td>
				<td width="10%" bgcolor="#D8D8D8">����</td>
				<td width="10%" bgcolor="#D8D8D8">ȸ��</td>
				<td width="10%" bgcolor="#D8D8D8">�������</td>
			</tr>
		
				<%
					if(rst == null) {
				%>
				<tr >
					<td colspan="9">��ϵ� ����ڰ� �����ϴ�.</td>
				</tr>
				<%
					} else { 
						for(int i = 0; i < rst.length; i++) {							
				%>
				<tr >
					<td width="5%">&nbsp;<%=i+1%></td>
					<td width="10%"><%=rst[i].getUserid()%></td>
					<td width="10%"><%=rst[i].getPassword()%></td>
					<td width="10%"><%=rst[i].getName()%></td>
					<td >&nbsp;<%=ComLib.nullChk(rst[i].getSosok1())%></td>
					<td width="10%">&nbsp;<%=ComLib.nullChk(rst[i].getJikwi())%></td>
					<td width="10%">&nbsp;<%=ComLib.nullChk(rst[i].getJikmu())%></td>
					<td width="10%"><%=ComLib.nullChk(rst[i].getCompany())%></td>					
					<td width="10%"><%=rst[i].getRegdate()%></td>
				</tr>
				<%
						}
					}
				%>
			</table>	
