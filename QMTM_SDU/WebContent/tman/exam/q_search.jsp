<%
//******************************************************************************
//   프로그램 : q_search.jsp
//   모 듈 명 : 문제검색 페이지
//   설    명 : 문제검색 페이지
//   테 이 블 : q
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.etc.RqtypeUtil, qmtm.admin.etc.RqtypeBean, 
//              qmtm.admin.etc.RdifficultUtil, qmtm.admin.etc.RdifficultBean, qmtm.admin.etc.QuseUtil, 
//              qmtm.admin.etc.QuseBean, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean
//   작 성 일 : 2013-02-14
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.RqtypeUtil, qmtm.tman.exam.RqtypeBean, qmtm.tman.exam.RdifficultUtil, qmtm.tman.exam.RdifficultBean, qmtm.admin.etc.QuseUtil, qmtm.admin.etc.QuseBean, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	
	if (id_exam.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String usergrade = (String)session.getAttribute("usergrade"); // 권한

	String id_category = "";
	String id_course = "";

	try {
		id_category = ExamUtil.getId_midcategory(id_exam);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	try {
		id_course = ExamUtil.getId_category(id_exam);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	ExamUtilBean[] rst = null;

    try {
	    if(chk_userid.equals("qmtm") || chk_usergrade.equals("M")) {
		    rst = ExamUtil.getCourseList(id_category);
		} else {
			rst = ExamUtil.getCourseList(id_category, chk_userid);
		}
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
	
	// 문제유형 정보 가지고오기
	RqtypeBean[] qtype = null;

    try {
	    qtype = RqtypeUtil.getBeans();
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
	
	// 난이도 정보 가지고오기
	RdifficultBean[] diff = null;

    try {
	    diff = RdifficultUtil.getBeans();
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	// 문제용도1 가지고 오기
	QuseBean[] quse = null;

    try {
	    quse = QuseUtil.getBeans();
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>문제 검색</title>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
	<link rel="stylesheet" href="../../js/jquery-ui-1.10.2/themes/base/jquery-ui.css" />
	<script src="../../js/jquery-ui-1.10.2/jquery-1.9.1.js"></script>
	<script src="../../js/jquery-ui-1.10.2/ui/jquery-ui.js"></script>
	<script src="../../js/jquery-ui-1.10.2/ui/i18n/jquery.ui.datepicker-ko.js"></script>
	<script type="text/javascript">
	$(function() {
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$( ".date_picker" ).datepicker();

		// 해당 과정으로 기본 선택
		var id_course = "<%=id_course%>";
		$("#sel_id_course option[value="+id_course+"]").attr("selected","selected");
		$("#sel_id_course").change();
	});
  </script>		
	</script>
	<script language="JavaScript">

		var subj;
		var cpt1;

		// 과목 정보 가지고오기
		function get_subj_list(subj1) {
			var frm = document.form1;
			
			Show_LayerProgressBar(true);
			
			subj = new ActiveXObject("Microsoft.XMLHTTP");
			subj.onreadystatechange = get_subj_list_callback;
			subj.open("GET", "subj.jsp?subj="+subj1, true);
			subj.send();
		}

		function get_subj_list_callback() {

			if(subj.readyState == 4) {
				if(subj.status == 200) {
					if(typeof(document.all.div_subj) == "object") {
						Show_LayerProgressBar(false);
						document.all.div_subj.innerHTML = subj.responseText;
					}
				}
			}
		}
		
		// 모듈 정보 가지고오기
		function get_cpt_list(cpts1) {
			
			var frm = document.form1;

			frm.cpt1.checked = false;			

			if(frm.cpt1.checked == true) {
				frm.chapter1.disabled = false;
			} else {
				frm.chapter1.disabled = true;
			}

			Show_LayerProgressBar(true);
			
			cpt1 = new ActiveXObject("Microsoft.XMLHTTP");
			cpt1.onreadystatechange = get_cpt_list_callback;
			cpt1.open("GET", "cpt1.jsp?cpt1="+cpts1, true);
			cpt1.send();
		}

		function get_cpt_list_callback() {

			if(cpt1.readyState == 4) {
				if(cpt1.status == 200) {
					if(typeof(document.all.div_cpt1) == "object") {
						Show_LayerProgressBar(false);
						document.all.div_cpt1.innerHTML = cpt1.responseText;
					}
				}
			}
		}
		
		// 모듈
		function checks2() {
			var frm = document.form1;
			
			if(frm.cpt1.checked == true) {
				frm.chapter1.disabled = false;
			} else {
				frm.chapter1.disabled = true;
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
			
			if(frm.explains.checked == true) {
				frm.explain1.disabled = false;
			} else {
				frm.explain1.disabled = true;
			}
		}

		function checks14() {
			var frm = document.form1;
			
			if(frm.find_kwds.checked == true) {
				frm.find_kwd1.disabled = false;
			} else {
				frm.find_kwd1.disabled = true;
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

		function Send() {

			if(document.form1.id_subject.value == "") {
				alert("과목을 선택하세요.");
				return false;
			} else {
				document.form1.submit();
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
				<td id="left" align="center" width="100">과정선택&nbsp;&nbsp;</td>
				<td>&nbsp;&nbsp;<select id="sel_id_course" name="id_course" style="width:300" onChange="get_subj_list(this.value);">
					<option value="">과정을 선택하세요</option>
					<% for(int i=0; i<rst.length; i++) { %>
						<option value="<%=rst[i].getId_course()%>"><%=rst[i].getCourse()%></option>
					<% } %>
					</select>
				</td>
			<tr>
			<tr>
				<td id="left" align="center" width="100">과목선택&nbsp;&nbsp;</td>
				<td><div id="div_subj">&nbsp;&nbsp;<select name="id_subject" style="width:300" disabled>
							<option value="">과목을 선택하세요.</option>
						</select>
					</div>
				</td>
				</td>
			<tr>
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="cpt1" onClick="checks2();">&nbsp;&nbsp;단원&nbsp;&nbsp;</td>
				<td><div id="div_cpt1">&nbsp;&nbsp;<select name="chapter1" style="width:300" disabled >
				<option value="">단원을 선택하세요</option>
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
				<td>&nbsp;&nbsp;<input type="text" class="input date_picker" name="regdate1" size="12" disabled>&nbsp;~&nbsp;<input type="text" class="input date_picker" name="regdate2" size="12" disabled>
				</td>
			</tr>
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="updates" onClick="checks9();">&nbsp;&nbsp;문제수정일&nbsp;&nbsp;</td>
				<td>&nbsp;&nbsp;<input type="text" class="input date_picker" name="updates1" size="12" disabled>&nbsp;~&nbsp;<input type="text" class="input date_picker" name="updates2" size="12" disabled>
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
				<td id="left"><input type="checkbox" value="Y" name="q_use" onClick="checks12();">&nbsp;&nbsp;문제용도&nbsp;&nbsp;</td>
				<td>&nbsp;&nbsp;<select name="q_uses" style=width:300 disabled>
					<% for(int i=0; i<quse.length; i++) { %>
						<option value="<%=quse[i].getId_q_use()%>"><%=quse[i].getQ_use()%></option>
					<% } %>
					</select>
				</td>
			</tr>
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="explains" onClick="checks13();">&nbsp;&nbsp;해설&nbsp;&nbsp;</td>
				<td>&nbsp;&nbsp;<input type="text" class="input" name="explain1" size="40" disabled>
				</td>
			</tr>
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="find_kwds" onClick="checks14();">&nbsp;&nbsp;검색키워드&nbsp;&nbsp;</td>
				<td>&nbsp;&nbsp;<input type="text" class="input" name="find_kwd1" size="40" disabled>
				</td>
			</tr>
		</table>
	</div>

	<div id="button">
	<img src="../../images/bt_q_search_ckwyj1.gif" onClick="Send();">&nbsp;&nbsp;&nbsp;<!--<input type="button" value="닫&nbsp;&nbsp;&nbsp;&nbsp;기" onClick="window.close();">--><a href="javascript:window.close();"><img border="0" src="../../images/bt_q_search_closeyj1.gif"></a>
	</div>

	</form>

</body>