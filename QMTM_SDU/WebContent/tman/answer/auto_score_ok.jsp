<%
//******************************************************************************
//   ���α׷� : auto_score_ok.jsp
//   �� �� �� : �������� ����
//   ��    �� : �������� ����
//   �� �� �� : 
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.answer.UserQScore, 
//              qmtm.tman.answer.UserQScoreBean, qmtm.tman.answer.SubjYNChk, qmtm.tman.answer.SubjYNChkBean
//   �� �� �� : 2013-04-25
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.QmTm, qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.answer.UserQScore, qmtm.tman.answer.UserQScoreBean, qmtm.tman.answer.SubjYNChk, qmtm.tman.answer.SubjYNChkBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String success_score1 = request.getParameter("success_score1");
	if (success_score1 == null) { success_score1 = ""; } else { success_score1 = success_score1.trim(); }

	String success_score2 = request.getParameter("success_score2");
	if (success_score2 == null) { success_score2 = ""; } else { success_score2 = success_score2.trim(); }

	if (id_exam.length() == 0 || success_score1.length() == 0 || success_score2.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}	

	// ���� Title �� ������ ���� ��������	
	UserQScoreBean info = null;

	try {
	    info = UserQScore.getExamInfo(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }

	String title = info.getTitle();
	int qcount = info.getQcount();
	
	// �����ں� ��� ���� ��������
	UserQScoreBean[] rst = null;

	try {
	    rst = UserQScore.getOxs(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }

	if(rst == null) {
%>
<script language="javascript">
	alert("ä���� ������� �ʾҽ��ϴ�.\nä���� �Ϸ��� �� �ٽ� �����Ͻñ� �ٶ��ϴ�.");
	window.close();
</script>				
<%		
		if(true) return;

	} else {

		// �������� ����
		try {
			SubjYNChk.delete(id_exam);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
		}

		String[] arrAnswers;
		String[] arrOxs;
		String[] arrPoints;
		String[] arrUserid;
		String[] arrName;

		UserQScoreBean[] rst2 = null;

		for(int ans=0; ans<rst.length; ans++) {
			int nr_set = rst[ans].getNr_set();
			arrAnswers = rst[ans].getAnswers().split(QmTm.Q_GUBUN_re, -1);
			arrOxs = rst[ans].getOxs().split(QmTm.Q_GUBUN_re, -1);

			// �����ں� ������ ������ ������ �´�.
			try {
				rst2 = UserQScore.getQinfo(id_exam, nr_set);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "close"));

				if(true) return;
			}

			String[] arrUserQ = new String[qcount];

			for(int qinfo=0; qinfo<qcount; qinfo++) {
				arrUserQ[qinfo] = String.valueOf(rst2[qinfo].getId_q());
			}
			
			String imsi_points = rst[ans].getPoints();
			
			if(imsi_points == null || imsi_points.equals("")) {
				for (int i = 0; i < qcount; i++) {
					imsi_points = imsi_points + "{:}";
				}

				imsi_points = imsi_points.substring(0, imsi_points.length()-3);
			} 

			arrPoints = imsi_points.split(QmTm.Q_GUBUN_re, -1);	

			double score1 = 0; // �ʱ��� ����
			double score2 = 0; // �Ǳ��� ����

			String success_yn = "N";

			// ������ ä�� ����� �����.
			for(int qinfo=0; qinfo<rst2.length; qinfo++) {				
				String result_ox = "";
				double result_score = 0;				
				
				if(arrOxs[rst2[qinfo].getNr_q()-1].equals("O")) {
					result_ox = "O";
					result_score = rst2[qinfo].getAllotting();

					if(rst2[qinfo].getYn_practice().equals("Y")) {
						score2 = score2 + rst2[qinfo].getAllotting();
					} else {
						score1 = score1 + rst2[qinfo].getAllotting(); 
					}

				} else if(arrOxs[rst2[qinfo].getNr_q()-1].equals("P")) {
					result_ox = "P";
					result_score = Double.parseDouble(arrPoints[rst2[qinfo].getNr_q()-1]);

					if(rst2[qinfo].getYn_practice().equals("Y")) {
						score2 = score2 + Double.parseDouble(arrPoints[rst2[qinfo].getNr_q()-1]);
					} else {
						score1 = score1 + Double.parseDouble(arrPoints[rst2[qinfo].getNr_q()-1]);
					}

				} else {
					result_ox = "X";
					result_score = 0;
				}
				
			} // ������ ä�� for �� ����
			
			if((score1 >= Double.parseDouble(success_score1)) && (score2 >= Double.parseDouble(success_score2))) {
				success_yn = "Y";
			} else {
				success_yn = "N";
			}

			try {
				SubjYNChk.insert(id_exam, rst[ans].getUserid(), rst[ans].getName(), String.valueOf(score1), String.valueOf(score2), String.valueOf(success_score1), String.valueOf(success_score2), success_yn);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "close"));

				if(true) return;
			}

		} // �����ں� ������ for �� ����

	}
%>

<script language="javascript">
	alert("���������� �Ϸ�Ǿ����ϴ�.");
	location.href="auto_score.jsp?id_exam=<%=id_exam%>";
</script>
