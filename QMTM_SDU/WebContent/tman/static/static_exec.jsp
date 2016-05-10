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

<head>
	<title>성적통계처리</title>

	<script>

	function go(){

		Show_LayerProgressBar(false);

		alert("1. 성적통계작업이 완료되었습니다.");
		window.opener.location.reload();
		window.close();
	}
	
	HTML_P = '<DIV id="ProgressBar" class="progress_img_all_cover">' 
		   + '<img src="../../images/loading.gif" style="position:absolute; top:35%; left:35%;"/>' 
		   + '</DIV>'; 
	  
	document.write(HTML_P); 
		  
	function Show_LayerProgressBar(isView) { 
				
		var obj = document.getElementById("ProgressBar"); 
		if (isView) { 
			obj.style.display = "block"; 
		}else{ 
			obj.style.display = "none"; 
		} 
	} 
		
	</script>

</head>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<BODY id="tman" onLoad = "Show_LayerProgressBar(true);">

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	out.flush();

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	try {
	    StaticScore.delete_T(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }

	StaticScoreBean rst = null;

	try {
		rst = StaticScore.getTBeans(id_exam);
	} catch (Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

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
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	StaticScoreBean rst2 = null;

	try {
		rst2 = StaticScore.getTBean(id_exam);
	} catch (Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

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
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }

	try {
	    StaticScore.insert_P(id_exam, rst.getAll_inwon());
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }

	try {
	    StaticQ.insert_Q(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }
	
	StaticQBean[] sqb = null;

	try {
	    sqb = StaticQ.getId_qs(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }


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
	    out.println(ComLib.getExceptionMsg(ex, "back"));

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

	int[] o_cnt = new int[sqb.length];
	int[] x_cnt = new int[sqb.length];
	int[][] q_res = new int[sqb.length][9];

	int imsi = 0;

	StaticQBean[] sqb3 = null;

	for(int ans = 0; ans<sqb2.length; ans++) {
		int nr_set = sqb2[ans].getNr_set();
		arrAnswers = sqb2[ans].getAnswers().split(QmTm.Q_GUBUN_re, -1);
		arrOxs = sqb2[ans].getOxs().split(QmTm.Q_GUBUN_re, -1);

		try {
			sqb3 = StaticQ.getId_qs2(id_exam, nr_set);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
	    }

		//Thread.sleep(400);

		String[] arrUserQ = new String[qcount];

		for(int j=0; j<sqb3.length; j++) {
			arrUserQ[j] = String.valueOf(sqb3[j].getId_qs());
		}

		for(int k=0; k<arrStaticQ.length; k++) {

			if(arrStaticQvalid_type[k].equals("0")) {
			
				for(int m = 0; m<arrUserQ.length; m++) {
					if(arrStaticQ[k].equals(arrUserQ[m])) {
						imsi = m;
						break;
					}
				}
			}

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
		

	} // 답안 종료

	for(int result=0 ; result<arrStaticQ.length; result++) {

		try {
			StaticQ.update_Q(id_exam, Long.parseLong(arrStaticQ[result]), o_cnt[result], x_cnt[result], q_res[result][1], q_res[result][2], q_res[result][3], q_res[result][4], q_res[result][5], q_res[result][6], q_res[result][7], q_res[result][8]);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
		}
	}
	
	// 문제은행 TABLE 정답율 데이타 Update
	try {
		StaticScore.update_correct_ratio(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}
	
	out.println("<script>go()</script>");
%>