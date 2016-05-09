<%
//******************************************************************************
//   프로그램 : non_user.jsp
//   모 듈 명 : 문항별 논술형 채점 대상자
//   설    명 : 문항별 논술형 채점 대상자
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-06-02
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
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

	// 해당 시험의 시험지의 문제수를 읽어온다
	int qcount = 0;

	try {
		qcount = AnswerMarkNon.getQcount(id_exam);	
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	// 시험지별 문제코드의 위치 정보 및 배점을 읽어온다
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

	// 해당 문제가 출제된 시험지로 시험을본 응시자들의 목록을 만든다
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
		alert("답안을 제출한 응시자에 대해서\n\n 채점을 진행하신 후 이용하시기 바랍니다.");
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
            
        //해당 문제가 맞았는지 확인하기 위해 시험지 정보에서 문제 위치 정보를 찾는다
        for(int j = 0; j < rst.length; j++) {
            if(ArrNr_Sets[j] == lngNr) {
               lngPos = ArrNr_Qs[j];
               break;
            }
        } 

		if(lngPos <= 0) {
%>			  
		   <script language="JavaScript">
		      alert("해당 시험지 정보에서 채점 정보의 위치를 찾지 못했습니다.");	
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
<title> :: 응시자 목록 :: </title>
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
			<td width="120">아이디</td>
			<td width="110">&nbsp;&nbsp;채점</td>
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