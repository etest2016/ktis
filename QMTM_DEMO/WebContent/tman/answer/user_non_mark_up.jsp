<%
//******************************************************************************
//   ���α׷� : user_non_mark_up.jsp
//   �� �� �� : ���� ����� ���� �����ں� ä��
//   ��    �� : ���� ����� ���� �����ں� ä��
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.answer.AnswerMark, qmtm.tman.answer.AnswerMarkBean
//   �� �� �� : 2008-09-01
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q= ""; } else { id_q = id_q.trim(); }

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String lngScore = request.getParameter("scores");
	if (lngScore == null) { lngScore = ""; } else { lngScore = lngScore.trim(); }
	
	if (id_exam.length() == 0 || id_q.length() == 0 || userid.length() == 0 || lngScore.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
    double ExamAllotting = 0;
    int nr_q = 0;
    String old_score;

	// �ش� ����� ���׺� ����ä�� ��ȸ�Ѵ�.
	AnswerMarkNonBean rst2 = null;

	try {
		rst2 = AnswerMarkNon.getBean3(id_q, userid, id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	ExamAllotting = rst2.getAllotting();
    nr_q = rst2.getNr_q();      
    old_score = String.valueOf(rst2.getScore()); // ������ ä�� ����   

    String oxs = rst2.getOxs();
    String points = rst2.getPoints();

	if(points == null || points.equals("")) {
%>
	<script language="JavaScript">
		alert("������ ä���� ������� �ʾҽ��ϴ�.\n\n����ä���� �Ͻñ����� �������������\n\n�ϰ�ä�� Ŭ���Ͻ��� ������ �����ڸ� ä��\n\n�Ǵ� ��� ������ ä���� �����ϼž߸�\n\n����ä���� �����Ͻ� �� �ֽ��ϴ�.");
	</script>
<%
		if(true) return;
	
	} else {
		points = rst2.getPoints();
	}		

    String[] ArrOxs = oxs.split(QmTm.Q_GUBUN_re, -1);
    String[] ArrPoints = points.split(QmTm.Q_GUBUN_re, -1);         

    if (ArrOxs.length != ArrPoints.length) {
%>
	<script language="JavaScript">
		alert("OXS �� POINTS �� ������ �ٸ��ϴ�");
	</script>
<%
		if(true) return;
    }

	// ����� ����ä�� ����
    if(lngScore.length() > 0) {     

        String ox;
        if(ExamAllotting == Double.parseDouble(lngScore)) { // lngScore �� ���� ����, Ʋ��, �κ����� ����
			ox = "O";
		} else if(Double.parseDouble(lngScore) == 0.0) {
		    ox = "X";
		} else {
		    ox = "P";
		}

        ArrOxs[nr_q - 1] = ox;          

        double tmpScore2 = ComLib.nullChkDbl(ArrPoints[nr_q - 1]);  // ������ ����� ������ ������ �´�.

        double add_point = 0; 
        if(tmpScore2 > Double.parseDouble(lngScore)) {
		   add_point = (tmpScore2 - Double.parseDouble(lngScore)) * -1;
        } else {
           add_point = Double.parseDouble(lngScore) - tmpScore2;
        }

		oxs = QmTm.join(ArrOxs, QmTm.Q_GUBUN);

        ArrPoints[nr_q - 1] = "" + lngScore;			   
        points = QmTm.join(ArrPoints, QmTm.Q_GUBUN);
        
        double score = Double.parseDouble(old_score) + add_point;

		AnswerMarkNonBean beans = new AnswerMarkNonBean();

		beans.setOxs(oxs);	
		beans.setPoints(points);	
		beans.setScore(score);	
		
		try {
			AnswerMarkNon.updateNon(id_exam, userid, beans);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
	}
%>

<Script language="JavaScript">
	location.href="user_non_mark.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>";
</Script>