<%
//******************************************************************************
//   ���α׷� : non_user.jsp
//   �� �� �� : ���׺� ����� ä�� �����
//   ��    �� : ���׺� ����� ä�� �����
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-06-02
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.* " %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q = ""; } else { id_q = id_q.trim(); }

	if (id_exam.length() == 0 || id_q.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	// �ش� ������ �������� �������� �о�´�
	int qcount = 0;

	try {
		qcount = AnswerMarkNon.getQcount(id_exam);	
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	// �������� �����ڵ��� ��ġ ���� �� ������ �о�´�
	AnswerMarkNonBean[] rst = null;

	try {
		rst = AnswerMarkNon.getBean(id_exam, id_q);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	int[] ArrNr_Sets = new int[rst.length];
    int[] ArrNr_Qs = new int[rst.length]; 

	double sngAllotting = rst[0].getAllotting(); 

	String nr_Sets  = ""; 

	for(int i=0; i < rst.length; i++) {        
        nr_Sets = nr_Sets + String.valueOf(rst[i].getNr_set()) + ",";
        ArrNr_Sets[i] = rst[i].getNr_set();
        ArrNr_Qs[i] = rst[i].getNr_q();
    } 

	// �ش� ������ ������ �������� �������� �����ڵ��� ����� �����
	AnswerMarkNonBean[] rst2 = null;

	try {
		rst2 = AnswerMarkNon.getBeans(id_exam, nr_Sets.substring(0,nr_Sets.length()-1));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	if(rst2 == null) {
%>
	<script language="JavaScript">
		alert("����� ������ �����ڿ� ���ؼ�\n\n ä���� �����Ͻ� �� �̿��Ͻñ� �ٶ��ϴ�.");
		top.window.close();
	</script>
<%
		if(true) return;
	}
	
	int lngNr = 0;
    int lngPos = 0;       
        
    String[] ArrPos = new String[rst2.length];
    String[] ArrUserid = new String[rst2.length];
    String[] ArrOxs = new String[rst2.length];
    String[] ArrPoints = new String[rst2.length];
    String[] ArrScore = new String[rst2.length];
	String[] ArrNames = new String[rst2.length];

	for(int i = 0; i < rst2.length; i++) {   
        lngNr = rst2[i].getNr_set();         
            
        //�ش� ������ �¾Ҵ��� Ȯ���ϱ� ���� ������ �������� ���� ��ġ ������ ã�´�
        for(int j = 0; j < rst.length; j++) {
            if(ArrNr_Sets[j] == lngNr) {
               lngPos = ArrNr_Qs[j];
               break;
            }
        } 

		if(lngPos <= 0) {
%>			  
		   <script language="JavaScript">
		      alert("�ش� ������ �������� ä�� ������ ��ġ�� ã�� ���߽��ϴ�.");	
			  top.window.close();	
		   </script>			  
<%
		   if(true) return;
		} 

        ArrPos[i] = String.valueOf(rst2[i].getNr_set());
        ArrUserid[i] = rst2[i].getUserid();
        ArrOxs[i] = rst2[i].getOxs();
		ArrNames[i] = rst2[i].getNames();

		String[] tmpOxs = ArrOxs[i].split(QmTm.Q_GUBUN_re, -1);
				
		String imsi_points = "";

		if(rst2[i].getPoints() == null || rst2[i].getPoints().equals("")) {
			for (int j = 0; j < tmpOxs.length; j++) {
				imsi_points = imsi_points + "{:}";
			}

			ArrPoints[i] = imsi_points.substring(0, imsi_points.length()-3);
		} else {
			ArrPoints[i] = rst2[i].getPoints();
		}		
                   
        String[] tmpPoints = ArrPoints[i].split(QmTm.Q_GUBUN_re, -1);
           
        ArrScore[i] = tmpPoints[lngPos-1]; 
    }           
%>

<html>
<head>
<title> :: ������ ��� :: </title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="Pragma" content="no-cache">
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<Script Language="JavaScript">

	function ftnFocus(pUserid, pPos, piDx) {		
		var oid = document.myform.old_id.value;
		
		if (oid != "") {
			if (parseInt(oid) % 2 == 0) {
				eval("document.all.back" + oid + ".bgColor = '#F1F5FE';");
			} else {
				eval("document.all.back" + oid + ".bgColor = 'FFFFFF';");
			}
		}

		eval("document.all.back" + piDx + ".bgColor = '#e4f5fc';");
		document.myform.old_id.value = piDx;
		
		document.myform.userid.value = pUserid;
		document.myform.pos.value = pPos;
		document.myform.action = "non_mark.jsp";
		document.myform.target = "fraMain";
		document.myform.submit();
	}

</Script>
</head>

<BODY style="margin: 0px 5px 5px 5px;" id="tman">

<form name="myform" method="post">
<input type="hidden" name="id_exam" value="<%= id_exam %>">
<input type="hidden" name="id_q" value="<%= id_q %>">
<input type="hidden" name="allotting" value="<%= sngAllotting %>">
<input type="hidden" name="userid">
<input type="hidden" name="name">
<input type="hidden" name="pos">
<input type="hidden" name="old_id">
</form>

	<img src="../../images/sub2_webscore5.gif"><br>

	<table border="0" cellpadding="0" cellspacing="0" id="tableD">
		<tr id="tr" align="center">
			<td width="120">���̵�</td>
			<td width="110">&nbsp;&nbsp;ä��</td>
		</tr>
	</table>

	<div style="overflow-y: scroll; height: 88%; width: 100%; ">

		<table border="0" cellpadding="0" cellspacing="0">
			<% 
				for (int i = 0; i < rst2.length; i++) {
			%>
			<tr id="back<%= i %>" align="center" height="22">
				<td style="border-bottom: 1px solid #c2c9d9;" width="120">					
					<a href="javascript:ftnFocus('<%= ArrUserid[i] %>', '<%= ArrPos[i] %>', '<%= i %>');"><u><%= ArrUserid[i] %></u>(<%= ArrNames[i] %>)</a>
				</td>
				<td id="score<%= ArrUserid[i] %>" style="border-bottom: 1px solid #c2c9d9;" width="110">&nbsp;<%= ArrScore[i] %></td>
			</tr>
			<% } %>
		</table>
	</div>

</body>
</html>