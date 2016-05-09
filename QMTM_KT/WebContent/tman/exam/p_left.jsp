<%
//******************************************************************************
//   ���α׷� : p_left.jsp
//   �� �� �� : ������ ���� ���� ������
//   ��    �� : ������ ���� ���� ������
//   �� �� �� : exam_m
//   �ڹ����� : qmtm.tman.exam.ExamUtil
//   �� �� �� : 2008-04-17
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, java.sql.*" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	if (id_exam.length() == 0) {
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		window.close();
	</script>
<%	
	}

	int papercnt = 0;

	try {
		papercnt = ExamUtil.getPaperCnt(id_exam);
	}
	catch (Exception ex) {
		out.println(ex.getMessage());
	}
%>

<html>
<head>
<title>Tman ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!--link rel="StyleSheet" href="../../css/style.css" type="text/css"-->
<style>
	
	body { margin: 0px; background-color: #fafafa; text-align: center; padding-bottom: 50px; border-right: 1px solid #e1e1e1; 

		scrollbar-face-color:#FFFFFF; 
		scrollbar-shadow-color:#CCC;
		scrollbar-highlight-color: #CCC;
		scrollbar-3dlight-color: #FFFFFF;
		scrollbar-darkshadow-color: #FFFFFF;
		scrollbar-track-color: #FFFFFF;
		scrollbar-arrow-color: #CCC; 
	}

	body, table, tr, td, div { font-size: 12px; }
	img { border: 0px; }
	li { list-style: url(../../images/list_sy2.gif); }
	a:link { text-decoration: none; color: #000000; font-weight: normal; font-size: 12px; }
	a:visited { text-decoration: none; color: #000000; font-weight: normal; font-size: 12px; }
	a:active { text-decoration: none; font-size: 12px; }
	a:hover { color: #000000; text-decoration: underline; font-weight: normal; font-size: 12px;  }

	

</style>
</head>

<body>

	<img src="../../images/mpaper_title.gif"><br>
	<div style="overflow-y: scroll; height: 508px; width: 120px; text-align: left; padding: 10px 5px 0px 7px;">
		<%
			for(int i = 1; i <= papercnt; i++) {
		%>
			<div style="width: 95%; height: 22px; border-bottom: 1px dotted #ccc; padding-top: 2px;"><li><a href="p_main.jsp?id_exam=<%=id_exam%>&nr_set=<%=i%>" target="paperMain">������ <%=i%></a><br></div>
		<%
			}
		%>


	</div>


</body>
</html>
