<%
//******************************************************************************
//   프로그램 : q_search.jsp
//   모 듈 명 : 문제검색 페이지
//   설    명 : 문제검색 페이지
//   테 이 블 : q
//   자바파일 : qmtm.tman.exam.ExamUtil
//   작 성 일 : 2008-04-21
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, qmtm.tman.exam.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	
	if (id_exam.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	int id_category = 0;

	try {
		id_category = ExamUtil.getId_category(id_exam);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	// 과정에 속한 과목 가지고오기
	ExamUtilBean[] rst = null;

    if(userid.equals("qmtm")) {

		try {
			rst = ExamUtil.getAllBeans2(id_category);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

	} else {

		try {
			rst = ExamUtil.getAllBeans3(id_category, userid);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

	}

	if(rst == null) {
%>
	<Script language="javascript">
		alert("문제은행 카테고리가 없습니다.\n\n문제은행 카테고리를 등록하신 후 진행하시기 바랍니다.\n\nADMIN 메뉴에 권한이 없을경우에는 관리자에게 문의하시기 바랍니다.");
		window.close();
	</script>
<%
		if(true) return;
	}

	// 문제유형 정보 가지고오기
	RqtypeBean[] qtype = null;

    try {
	    qtype = RqtypeUtil.getBeans();
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	// 난이도 정보 가지고오기
	RdifficultBean[] diff = null;

    try {
	    diff = RdifficultUtil.getBeans();
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	// 문제용도1 가지고 오기
	QuseBean[] quse = null;

    try {
	    quse = QuseUtil.getBeans();
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<html>
<head>
	<title>문제 검색</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	<script language="JavaScript">

		var cpt1;
		var cpt2;
		var cpt3;
		var cpt4;

		// 단원 1 정보 가지고오기
		function get_cpt1_list(cpts1) {
			
			var frm = document.form1;

			frm.cpt1.checked = false;			

			if(frm.cpt1.checked == true) {
				frm.chapter1.disabled = false;
			} else {
				frm.chapter1.disabled = true;
			}

			Show_LayerProgressBar(true);
			
			cpt1 = new ActiveXObject("Microsoft.XMLHTTP");
			cpt1.onreadystatechange = get_cpt1_list_callback;
			cpt1.open("GET", "cpt1.jsp?cpt1="+cpts1, true);
			cpt1.send();
		}

		function get_cpt1_list_callback() {

			if(cpt1.readyState == 4) {
				if(cpt1.status == 200) {
					if(typeof(document.all.div_cpt1) == "object") {
						Show_LayerProgressBar(false);
						document.all.div_cpt1.innerHTML = cpt1.responseText;
					}
				}
			}
		}

		// 단원 2 정보 가지고오기
		function get_cpt2_list(cpts2) {
			
			var frm = document.form1;
			
			frm.cpt2.checked = false;

			Show_LayerProgressBar(true);
			
			cpt2 = new ActiveXObject("Microsoft.XMLHTTP");
			cpt2.onreadystatechange = get_cpt2_list_callback;
			cpt2.open("GET", "cpt2.jsp?cpt2="+cpts2, true);
			cpt2.send();
		}

		function get_cpt2_list_callback() {			
			if(cpt2.readyState == 4) {
				if(cpt2.status == 200) {
					if(typeof(document.all.div_cpt2) == "object") {
						Show_LayerProgressBar(false);
						document.all.div_cpt2.innerHTML = cpt2.responseText;
					}
				}
			}
		}
		
		// 단원 3 정보 가지고오기
		function get_cpt3_list(cpts3) {
			
			var frm = document.form1;
			frm.cpt3.checked = false;

			Show_LayerProgressBar(true);
			
			cpt3 = new ActiveXObject("Microsoft.XMLHTTP");
			cpt3.onreadystatechange = get_cpt3_list_callback;
			cpt3.open("GET", "cpt3.jsp?cpt3="+cpts3, true);
			cpt3.send();
		}

		function get_cpt3_list_callback() {			
			if(cpt3.readyState == 4) {
				if(cpt3.status == 200) {
					if(typeof(document.all.div_cpt3) == "object") {
						Show_LayerProgressBar(false);
						document.all.div_cpt3.innerHTML = cpt3.responseText;
					}
				}
			}
		}

		// 단원 4 정보 가지고오기
		function get_cpt4_list(cpts4) {
			
			var frm = document.form1;
			frm.cpt4.checked = false;

			Show_LayerProgressBar(true);
			
			cpt4 = new ActiveXObject("Microsoft.XMLHTTP");
			cpt4.onreadystatechange = get_cpt4_list_callback;
			cpt4.open("GET", "cpt4.jsp?cpt4="+cpts4, true);
			cpt4.send();
		}

		function get_cpt4_list_callback() {
			if(cpt4.readyState == 4) {
				if(cpt4.status == 200) {
					if(typeof(document.all.div_cpt4) == "object") {
						Show_LayerProgressBar(false);
						document.all.div_cpt4.innerHTML = cpt4.responseText;
					}
				}
			}
		}

		// 단원 1
		function checks2() {
			var frm = document.form1;
			
			if(frm.cpt1.checked == true) {
				frm.chapter1.disabled = false;
			} else {
				frm.chapter1.disabled = true;
			}
		}

		// 단원 2
		function checks3() {
			var frm = document.form1;
			
			if(frm.cpt2.checked == true) {
				frm.chapter2.disabled = false;
			} else {
				frm.chapter2.disabled = true;
			}
		}

		// 단원 3
		function checks4() {
			var frm = document.form1;
			
			if(frm.cpt3.checked == true) {
				frm.chapter3.disabled = false;
			} else {
				frm.chapter3.disabled = true;
			}
		}

		// 단원 4
		function checks5() {
			var frm = document.form1;
			
			if(frm.cpt4.checked == true) {
				frm.chapter4.disabled = false;
			} else {
				frm.chapter4.disabled = true;
			}
		}
		
		function checks6() {
			var frm = document.form1;
			
			if(frm.qte.checked == true) {
				frm.qtype.disabled = false;
			} else {
				frm.qtype.disabled = true;
			}
		}

		function checks7() {
			var frm = document.form1;
			
			if(frm.diff.checked == true) {
				frm.difficulty.disabled = false;
			} else {
				frm.difficulty.disabled = true;
			}
		}

		function checks8() {
			var frm = document.form1;
			
			if(frm.regdate.checked == true) {
				frm.regdate1.disabled = false;
				frm.regdate2.disabled = false;
			} else {
				frm.regdate1.disabled = true;
				frm.regdate2.disabled = true;
			}
		}

		function checks9() {
			var frm = document.form1;
			
			if(frm.updates.checked == true) {
				frm.updates1.disabled = false;
				frm.updates2.disabled = false;
			} else {
				frm.updates1.disabled = true;
				frm.updates2.disabled = true;
			}
		}

		function checks10() {
			var frm = document.form1;
			
			if(frm.q_cnt.checked == true) {
				frm.q_cnt1.disabled = false;
				frm.q_cnt2.disabled = false;
			} else {
				frm.q_cnt1.disabled = true;
				frm.q_cnt2.disabled = true;
			}
		}

		function checks11() {
			var frm = document.form1;
			
			if(frm.userid.checked == true) {
				frm.userids.disabled = false;
			} else {
				frm.userids.disabled = true;
			}
		}

		function checks12() {
			var frm = document.form1;
			
			if(frm.q_use.checked == true) {
				frm.q_uses.disabled = false;
			} else {
				frm.q_uses.disabled = true;
			}
		}

		function checks13() {
			var frm = document.form1;
			
			if(frm.q_use2.checked == true) {
				frm.q_uses2.disabled = false;
			} else {
				frm.q_uses2.disabled = true;
			}
		}

		HTML_P = '<DIV id="ProgressBar" class="progress_img_all_cover">' 
               + '<img src="../../images/loading.gif" style="position:absolute; top:35%; left:30%;"/>' 
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

	<BODY id="popup2" onLoad = "Show_LayerProgressBar(false);">

	<form name="form1" method="post" action="q_search_ok.jsp">
	<input type="hidden" name="id_exam" value="<%=id_exam%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">문제 검색</div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">		

		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" align="center" width="100">과목선택&nbsp;&nbsp;</td>
				<td>&nbsp;&nbsp;<select name="subjects" style=width:300 onChange="get_cpt1_list(this.value);">
					<option value="">선택하세요</option>
					<% for(int i=0; i<rst.length; i++) { %>
						<option value="<%=rst[i].getId_q_subject()%>"><%=rst[i].getQ_subject()%></option>
					<% } %>
					</select>
				</td>
			<tr>
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="cpt1" onClick="checks2();">&nbsp;&nbsp;단원 1&nbsp;&nbsp;</td>
				<td><div id="div_cpt1">&nbsp;&nbsp;<select name="chapter1" style=width:300 disabled onChange="get_cpt2_list(this.value);">
				<option value="">과목을 선택하세요</option>
				</select>
				</div>
				</td>
			</tr>
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="cpt2" onClick="checks3();">&nbsp;&nbsp;단원 2&nbsp;&nbsp;</td>
				<td><div id="div_cpt2">&nbsp;&nbsp;<select name="chapter2" style=width:300 disabled onChange="get_cpt3_list(this.value);">
				<option value="">단원1을 선택하세요</option>
				</select>
				</div>
				</td>
			</tr>
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="cpt3" onClick="checks4();">&nbsp;&nbsp;단원 3&nbsp;&nbsp;</td>
				<td><div id="div_cpt3">&nbsp;&nbsp;<select name="chapter3" style=width:300 disabled onChange="get_cpt4_list(this.value);">
				<option value="">단원2를 선택하세요</option>
				</select>
				</div>
				</td>
			</tr>
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="cpt4" onClick="checks5();">&nbsp;&nbsp;단원 4&nbsp;&nbsp;</td>
				<td><div id="div_cpt4">&nbsp;&nbsp;<select name="chapter4" style=width:300 disabled>
				<option value="">단원3을 선택하세요</option>
				</select>
				</div>
				</td>
			</tr>
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="qte" onClick="checks6(this);">&nbsp;&nbsp;문제유형&nbsp;&nbsp;</td>
				<td>&nbsp;&nbsp;<select name="qtype" style=width:300 disabled>
					<% for(int i=0; i<qtype.length; i++) { %>
						<option value="<%=qtype[i].getId_qtype()%>"><%=qtype[i].getQtype()%></option>
					<% } %>
					</select>
				</td>
			</tr>		
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="diff" onClick="checks7();">&nbsp;&nbsp;난이도&nbsp;&nbsp;</td>
				<td>&nbsp;&nbsp;<select name="difficulty" style=width:300 disabled>
					<% for(int i=0; i<diff.length; i++) { %>
						<option value="<%=diff[i].getId_difficulty()%>"><%=diff[i].getDifficulty()%></option>
					<% } %>
					</select>
				</td>
			</tr>		
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="regdate" onClick="checks8();">&nbsp;&nbsp;문제입력일&nbsp;&nbsp;</td>
				<td>&nbsp;&nbsp;<input type="text" class="input" name="regdate1" size="12" disabled>&nbsp;~&nbsp;<input type="text" class="input" name="regdate2" size="12" disabled>
				</td>
			</tr>
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="updates" onClick="checks9();">&nbsp;&nbsp;문제수정일&nbsp;&nbsp;</td>
				<td>&nbsp;&nbsp;<input type="text" class="input" name="updates1" size="12" disabled>&nbsp;~&nbsp;<input type="text" class="input" name="updates2" size="12" disabled>
				</td>
			</tr>
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_cnt" onClick="checks10();">&nbsp;&nbsp;출제횟수&nbsp;&nbsp;</td>
				<td>&nbsp;&nbsp;<input type="text" class="input" name="q_cnt1" size="4" disabled>&nbsp;~&nbsp;<input type="text" class="input" name="q_cnt2" size="4" disabled>
				</td>
			</tr>
			<!--<tr>
				<td id="left"><input type="checkbox" value="Y" name="userid" onClick="checks11();">&nbsp;&nbsp;입력자 ID&nbsp;&nbsp;</td>
				<td>&nbsp;&nbsp;<input type="text" class="input" name="userids" size="41" disabled>
				</td>
			</tr>-->		
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_use" onClick="checks12();">&nbsp;&nbsp;문제용도1&nbsp;&nbsp;</td>
				<td>&nbsp;&nbsp;<select name="q_uses" style=width:300 disabled>
					<% for(int i=0; i<quse.length; i++) { %>
						<option value="<%=quse[i].getId_q_use()%>"><%=quse[i].getQ_use()%></option>
					<% } %>
					</select>
				</td>
			</tr>
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_use2" onClick="checks13();">&nbsp;&nbsp;문제용도2&nbsp;&nbsp;</td>
				<td>&nbsp;&nbsp;<input type="text" class="input" name="q_uses2" size="41" disabled>
				</td>
			</tr>
		</table>
	</div>

	<div id="button">
	<input type="image" value="찾&nbsp;&nbsp;&nbsp;&nbsp;기" name="submit" src="../../images/bt_q_search_ckwyj1.gif">&nbsp;&nbsp;&nbsp;<!--<input type="button" value="닫&nbsp;&nbsp;&nbsp;&nbsp;기" onClick="window.close();">--><a href="javascript:window.close();"><img border="0" src="../../images/bt_q_search_closeyj1.gif"></a>
	</div>


	</form>

</body>