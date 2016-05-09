<%
//******************************************************************************
//   프로그램 : static_exec.jsp
//   모 듈 명 : 성적통계 처리 
//   설    명 : 성적통계 처리
//   테 이 블 : s_t_result, s_p_result, exam_q
//   자바파일 : qmtm.tman.statics.StaticScoreBean, qmtm.tman.statics.StaticScore
//   작 성 일 : 2008-06-10
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.statics.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	try {
	    StaticScore.delete_T(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }

	try {
		StaticQ.delete_Chapter(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));
				
		if(true) return;
	}

	StaticScoreBean rst = null;

	try {
		rst = StaticScore.getTBeans(id_exam);
	} catch (Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}

	if(rst == null) {
%>
	<Script language="JavaScript">
		alert("응시자가 없거나 채점이 진행되지 않았습니다.");
		window.close();
	</Script>
<%
		if(true) return;
	}

	int qcount = rst.getQcount();

	double top_score = 0;

	try {
		top_score = StaticScore.getTop_score(id_exam);
	} catch (Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}

	StaticScoreBean rst2 = null;

	try {
		rst2 = StaticScore.getTBean(id_exam);
	} catch (Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}

	StaticScoreBean res = new StaticScoreBean();

	res.setQcount(rst.getQcount());
	res.setAllotting(rst.getAllotting());
	res.setAvg_score(rst.getAvg_score());
	res.setTop_score(top_score);
	res.setMax_score(rst.getMax_score());
	res.setMin_score(rst.getMin_score());
	res.setAll_inwon(rst.getAll_inwon());
	res.setMax_score(rst.getMax_score());
	res.setInwon1(rst2.getInwon1());
	res.setInwon2(rst2.getInwon2());
	res.setInwon3(rst2.getInwon3());
	res.setInwon4(rst2.getInwon4());
	res.setInwon5(rst2.getInwon5());
	res.setInwon6(rst2.getInwon6());
	res.setInwon7(rst2.getInwon7());
	res.setInwon8(rst2.getInwon8());
	res.setInwon9(rst2.getInwon9());
	res.setInwon10(rst2.getInwon10());

    try {
	    StaticScore.insert_T(res, id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }

	try {
	    StaticScore.insert_P(id_exam, rst.getAll_inwon());
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }

	try {
	    StaticQ.insert_Q(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }
	
	StaticQBean[] sqb = null;

	try {
	    sqb = StaticQ.getId_qs(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }

%>

<head>
	<title>성적통계처리</title>

	<script>

		function go(ing,end){
			document.all.div1.style.width = (ing+1)/end*100+"%";
			document.all.div2.innerHTML = parseInt((ing+1)/end*100,10)+"%진행중";
			//ing+1 하는이유는 (ing+1)/end*100  =0 이되면 에러가 나기 때문
		}
	
	</script>

</head>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<BODY id="tman">
<center>
<Table width="400" height="50" border="0" >

<tr>
 <td valign="middle">
  <div id ="div2" align="center" style="margin-top:10;width:100%;height:30px;color:#FF00FF;font-size:11px;"></div>
  <div id ="div1" style="whdth:0px;height:30px;background-color:#6666FF;"></div>
 </td>
</tr>

</table> 

<%
	String[] arrStaticQ = new String[sqb.length];
	String[] arrStaticQtype = new String[sqb.length];
	String[] arrStaticQvalid_type = new String[sqb.length];

	for(int i=0; i<sqb.length; i++) {
		arrStaticQ[i] = String.valueOf(sqb[i].getId_q());
		arrStaticQtype[i] = String.valueOf(sqb[i].getId_qtype());
		arrStaticQvalid_type[i] = String.valueOf(sqb[i].getId_valid_type());
	}

	StaticQBean[] sqb2 = null;

	try {
	    sqb2 = StaticQ.getOxs(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }

	if(sqb2 == null) {
%>
	<Script language="JavaScript">
		alert("성적통계 처리할 응시자가 없습니다.\n\n답안지 관리 통해서 채점 진행 후 진행하시기 바랍니다.");
		window.close();
	</Script>
<%
		if(true) return;
	}

	String[] arrAnswers;
	String[] arrOxs;
	String[] arrPoints;
	String[] arrUserid;

	int[] o_cnt = new int[sqb.length];
	int[] x_cnt = new int[sqb.length];
	int[][] q_res = new int[sqb.length][9];

	int imsi = 0;

	StaticQ2Bean[] sqb3_1 = null;

	for(int ans = 0; ans<sqb2.length; ans++) {
		int nr_set = sqb2[ans].getNr_set();
		arrAnswers = sqb2[ans].getAnswers().split(QmTm.Q_GUBUN_re, -1);
		arrOxs = sqb2[ans].getOxs().split(QmTm.Q_GUBUN_re, -1);

		try {
			sqb3_1 = StaticQ.getId_qs2(id_exam, nr_set);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
	    }

		String[] arrUserQ = new String[qcount];

		for(int j=0; j<sqb3_1.length; j++) {
			arrUserQ[j] = String.valueOf(sqb3_1[j].getId_q());
		}
		
		String imsi_points = sqb2[ans].getPoints();
		
		if(imsi_points == null || imsi_points.equals("")) {
			for (int i = 0; i < qcount; i++) {
				imsi_points = imsi_points + "{:}";
			}

			imsi_points = imsi_points.substring(0, imsi_points.length()-3);
		} 

		arrPoints = imsi_points.split(QmTm.Q_GUBUN_re, -1);		

		StaticQBean[] sgb = null;

		try {
			sgb = StaticQ.getChapterGrp(id_exam, nr_set);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
	    }		

		String[] arrId_chapters = new String[sgb.length];
		double[] arrAllottings = new double[sgb.length];
				
		for(int g=0; g<sgb.length; g++) { //단원별로 loop 시험지 set 와 해당 단원으로 비교한다.			
			double chapterScore = 0;

			StaticQ2Bean[] sqb3 = null;

			try {
				sqb3 = StaticQ.getId_qs2(id_exam, nr_set, sgb[g].getId_chapter());
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "close"));

				if(true) return;
			}

			for(int j=0; j<sqb3.length; j++) {
				//arrUserQ[j] = String.valueOf(sqb3[j].getId_qs());
		
				if(arrOxs[sqb3[j].getNr_q()-1].equals("O")) {
					chapterScore = chapterScore + sqb3[j].getAllotting();
				} else if(arrOxs[sqb3[j].getNr_q()-1].equals("P")) {
					chapterScore = chapterScore + ComLib.nullChkDbl(arrPoints[sqb3[j].getNr_q()-1]);
				}
			}

			double score_pct = (chapterScore / sgb[g].getAllotting()) * 100;

			try {
				StaticQ.insert_Chapter(id_exam, sqb2[ans].getUserid(), sgb[g].getId_chapter(), sgb[g].getAllotting(), chapterScore, score_pct);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "close"));
				//out.println(ex.getMessage());
				
				if(true) return;
			}
			
		}

		for(int k=0; k<arrStaticQ.length; k++) {

			if(arrStaticQvalid_type[k].equals("0")) {
			
				for(int m = 0; m<arrUserQ.length; m++) {
					
					if(arrStaticQ[k].equals(arrUserQ[m])) {
						imsi = m;
						break;
					} else {
						imsi = 1000;
					}					
				}
			}

			if(imsi < 1000) {
			
			if(arrOxs[imsi].equalsIgnoreCase("x")) {
				x_cnt[k] = x_cnt[k] + 1;
			} else {
				o_cnt[k] = o_cnt[k] + 1;
			}

			if(!(arrStaticQtype[k].equals("4") || arrStaticQtype[k].equals("5"))) {
				if(arrStaticQtype[k].equals("3")) {
					if(arrAnswers[imsi] != null && (!arrAnswers[imsi].equals(""))) {
						String ans_imp = arrAnswers[imsi].replace(QmTm.OR_GUBUN,",");
						String[] arrAns = ans_imp.split(",",-1);
						if(arrAns.length > 0) {
							for(int arr = 0; arr<arrAns.length-1; arr++) {
								q_res[k][Integer.parseInt(arrAns[arr])] = q_res[k][Integer.parseInt(arrAns[arr])] + 1;
							}
						}
					}
				} else {
					if(arrAnswers[imsi] != null && (!arrAnswers[imsi].equals(""))) {
						q_res[k][Integer.parseInt(arrAnswers[imsi])] = q_res[k][Integer.parseInt(arrAnswers[imsi])] + 1;
					}
				}
			}
			
		} // 문항 종료

		}
		

	} // 답안 종료

	for(int result=0 ; result<arrStaticQ.length; result++) {

		try {
			StaticQ.update_Q(id_exam, Long.parseLong(arrStaticQ[result]), o_cnt[result], x_cnt[result], q_res[result][1], q_res[result][2], q_res[result][3], q_res[result][4], q_res[result][5], q_res[result][6], q_res[result][7], q_res[result][8]);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
	}
	
	
%>

<Script language="JavaScript">
	alert("성적통계작업이 완료되었습니다.");
	opener.location.reload();
	top.window.close();
</Script>