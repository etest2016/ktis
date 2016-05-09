<%
//******************************************************************************
//   프로그램 : q_lits.jsp
//   모 듈 명 : 문제 관리
//   설    명 : 문제 목록 및 추가,수정,삭제
//   테 이 블 : q
//   자바파일 : qmtm.*, qmtm.qman.question.*
//   작 성 일 : 2008-04-16
//   작 성 자 : 이테스트 강진아
//   수 정 일 : 2008-07-07
//   수 정 자 : 이테스트 석준호
//	 수정사항 : 문제리스트 화면 수정
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.qman.question.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }	
	
	if (id_q_subject.length() == 0) {
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		history.back();
	</script>
<%	
	}

	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter = ""; } else { id_q_chapter = id_q_chapter.trim(); }	
	
	if (id_q_chapter.length() == 0) {
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		history.back();
	</script>
<%	
	}

	// 화면 Depth
	NameBean names = null;

	try {
		names = NameUtil.getSubject(id_q_subject);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
	
	// 담당자 권한 체크	
	String pt_q_edit = "";
	String pt_q_delete = "";

	LoginProcBean bean = null;

	try {
		bean = LoginProc.getQ_work(id_q_subject, userid);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	pt_q_edit = bean.getPt_q_edit();
	pt_q_delete = bean.getPt_q_delete();

    // 과목에 해당하는 문제 가져오기
	
	QListBean[] rst = null;

    try {
	    rst = QListUtil.getSBeans(userid, id_q_subject);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }

%>

<HTML>
 <HEAD>
  <TITLE> QMAN 과목 문제 관리 </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <SCRIPT LANGUAGE="JavaScript">
  <!--

	function checkAll(){
		var chkObj = document.frmdata.chnCheck;
		var objCnt = chkObj.length;

		//  체크박스가 한개일 경우
		if(chkObj.value) {
			if(document.frmdata.allCheck.checked == false) {
			chkObj.checked = false;
			}else {
			chkObj.checked = true;
			}
		} else {

			if(document.frmdata.allCheck.checked == false) {
				for(var i = 0; i < objCnt; i++) {
				 chkObj[i].checked = false;
				}

			}else {
				for(var i = 0; i < objCnt; i++) {
				 chkObj[i].checked = true;
				}
			}
		}
	}
	
	function QInsert(){
		window.open("q_qtype.jsp?id_q_subject=<%=id_q_subject%>&id_q_chapter=<%=id_q_chapter%>","QInsert","width=500,height=500,scrollbars=yes");
	}

	function QEdit(){
		window.open("q_edit.jsp?id_q_subject=<%=id_q_subject%>","QEdit","width=740,height=500");
	}

	function q_delete() {
		 var frmx = document.form1;
		 var lngLen = frmx.inwon_lists.length -1;

		 var selectId = "";
		 var k = 0;

		 for (i=0; i<=lngLen; i++) {
			 if (frmx.inwon_lists[i].selected == true) {
				 selectId = selectId + frmx.inwon_lists[i].value + ",";
				 k = k + 1;
			 }
		 }

		 if(k == 0) {
			 alert("삭제할 문제를 선택해주세요.");
		 } else {
			 var st = confirm("선택한 문제를 삭제하시겠습니까?\n\n이미 시험으로 출제된 문항은 삭제되지 않습니다." );

			 if (st == true) {
				window.open("q_delete.jsp?qs="+selectId.substring(0,selectId.length-1),"qs_del","width=600, height=250");
				//del_list(selectId.substring(0,selectId.length-1));
			 }
		 }
	 }

	 function del_list(qs) {
		qs2 = new ActiveXObject("Microsoft.XMLHTTP");
		qs2.onreadystatechange = del_list_callback;
		qs2.open("POST", "q_delete.jsp", true);
		qs2.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=euc-kr");
		qs2.send("qs="+qs);
	 }

	 function del_list_callback() {
		var val = document.form1.inwon_lists.length;

		if(qs2.readyState == 4) {
			if(qs2.status == 200) {
				if(typeof(document.all.delUsers) == "object") {

					for (var i=0; i<val; i++)
					{
						for (var j=0; j<document.form1.inwon_lists.options.length; j++)
						{
							if (document.form1.inwon_lists.options[j].selected == true)
							{
								document.form1.inwon_lists.remove(j);
								break;
					        }
						 }
					 }
					document.form1.total_inwon.value = document.form1.inwon_lists.length;
					alert("문제가 삭제되었습니다.\n\n삭제된 답안지를 복구하시려면 삭제된 답안지 목록에서 답안지 복구를 사용하세요.\n\n답안지가 삭제된 응시자는 시험 기간중이라면 다시 로그인하여 재 시험을 볼 수 있습니다.");
				}
			}
		}
	}

	function q_move() {
		 var frmx = document.form1;
		 var lngLen = frmx.inwon_lists.length -1;

		 var selectId = "";
		 var k = 0;

		 for (i=0; i<=lngLen; i++) {
			 if (frmx.inwon_lists[i].selected == true) {
				 selectId = selectId + frmx.inwon_lists[i].value + ",";
				 k = k + 1;
			 }
		 }

		 if(k == 0) {
			 alert("이동할 문제를 선택해주세요.");
		 } else {
			 window.open("q_move.jsp?id_qs="+selectId.substring(0,selectId.length-1),"move_q","width=600, height=250");
		 }
	}

	function q_copy() {
		 var frmx = document.form1;
		 var lngLen = frmx.inwon_lists.length -1;

		 var selectId = "";
		 var k = 0;

		 for (i=0; i<=lngLen; i++) {
			 if (frmx.inwon_lists[i].selected == true) {
				 selectId = selectId + frmx.inwon_lists[i].value + ",";
				 k = k + 1;
			 }
		 }

		 if(k == 0) {
			 alert("복사할 문제를 선택해주세요.");
		 } else {
			 window.open("q_copy.jsp?id_qs="+selectId.substring(0,selectId.length-1),"move_q","width=600, height=250");
		 }
	}

	function cpt_insert() {
		window.open("../../admin2/q_tree/chapter/chapter_insert.jsp?id_q_subject=<%=id_q_subject%>","insert","width=400, height=250, scrollbars=no");
    }
	
	function q_preview() {
		 var frmx = document.form1;
		 var lngLen = frmx.inwon_lists.length -1;

		 var selectId = "";
		 var k = 0;

		 for (i=0; i<=lngLen; i++) {
			 if (frmx.inwon_lists[i].selected == true) {
				 selectId = selectId + frmx.inwon_lists[i].value + ",";
				 k = k + 1;
			 }
		 }

		 if(k == 0) {
			 alert("미리보기 할 문제를 선택해주세요.");
		 } else {
			 window.open("q_preview.jsp?id_qs="+selectId.substring(0,selectId.length-1),"preview_q","width=850, height=600, scrollbars=yes");
		 }
	 }

	 function html_saves() {
		 var frmx = document.form1;
		 var lngLen = frmx.inwon_lists.length -1;

		 var selectId = "";
		 var k = 0;

		 for (i=0; i<=lngLen; i++) {
			 if (frmx.inwon_lists[i].selected == true) {
				 selectId = selectId + frmx.inwon_lists[i].value + ",";
				 k = k + 1;
			 }
		 }

		 if(k == 0) {
			 alert("HTML 저장 할 문제를 선택해주세요.");
		 } else {
			 location.href = "q_html_save.jsp?id_qs="+selectId.substring(0,selectId.length-1);
		 }
	 }

	 function selects() {
		var frmx = document.form1;
		 var lngLen = frmx.inwon_lists.length -1;

		 var selectId = "";
		 var k = 0;

		 for (i=0; i<=lngLen; i++) {
			 k = k + 1;
		 }

		 frmx.search_cnt.value = k;
	 }

	 function html_save() {

	 }

  //-->
  </SCRIPT>
 </HEAD>

 <BODY onLoad = "selects();" id="qman">
	<div id="main">
		<FORM NAME="form1">

		<div class="title">문제관리</div>

		<table border="0" cellpadding ="0" cellspacing="0" width="92%">
			<tr>
				<td width="70%">
					<% if(pt_q_edit.equals("Y")) { %><a href="javascript:QInsert();" style="padding-top: 3px; padding-left: 3px; padding-right: 3px;"><% } %><img src="../../../images/bt5_qI_1.gif"></a>
					<img src="../../../images/bt5_qI_2.gif" style="padding-top: 3px; padding-left: 3px; padding-right: 3px;">
					<% if(pt_q_delete.equals("Y")) { %><a href="javascript:q_delete();" style="padding-top: 3px; padding-left: 3px; padding-right: 3px;"><% } %><img src="../../../images/bt5_qI_3.gif"></a>					
					<% if(pt_q_edit.equals("Y")) { %><a href="javascript:q_move();"><% } %>문제이동</a>
					<% if(pt_q_edit.equals("Y")) { %><a href="javascript:q_copy();"><% } %>문제복사</a>
					<% if(pt_q_edit.equals("Y")) { %><a href="javascript:cpt_insert();"><% } %>단원등록</a>
					<a href="javascript:q_preview();" border="0"><img src="../../../images/bt5_qI_5.gif" style="padding-top: 3px; padding-left: 3px; padding-right: 3px;"></a>
					<a href="javascript:html_saves();" border="0"><img src="../../../images/bt5_qI_6.gif" style="padding-top: 3px; padding-left: 3px; padding-right: 3px;"></a>
				</td>				
			</tr>
			<tr>
				<td height="25" align="right">>> <%=names.getSubject()%>&nbsp;</td>
			</tr>
			<tr>
				<td height="5"></td>
			</tr>
		</table>

		<table border="0" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC" width="100%">
			<tr bgcolor="#FFFFFF" height="27">
				<td width="100" align="center" bgcolor="#DDDDDD">문제코드</td>
				<td width="100" align="center" bgcolor="#DDDDDD">문제유형</td>
				<td width="100" align="center" bgcolor="#DDDDDD">지문여부</td>
				<td align="center" bgcolor="#DDDDDD">문제</td>
			</tr>
		</table>

		<table border="0" width="100%">
		<tr>
			<td>
			<select name="inwon_lists" multiple size="25" style="width:100%;" ondblclick = "selects(this.value);" >
			<%
				if(rst == null) {
			%>
			<%
				} else {

					String idqs = "";
					String qs = "";
	
					for(int i=0; i<rst.length; i++) {
						if(String.valueOf(rst[i].getId_q()).length() == 1) {
							idqs = String.valueOf(rst[i].getId_q()) + "               ";
						} else if(String.valueOf(rst[i].getId_q()).length() == 2) {
							idqs = String.valueOf(rst[i].getId_q()) + "             ";
						} else if(String.valueOf(rst[i].getId_q()).length() == 3) {
							idqs = String.valueOf(rst[i].getId_q()) + "           ";
						} else if(String.valueOf(rst[i].getId_q()).length() == 4) {
							idqs = String.valueOf(rst[i].getId_q()) + "          ";
						} else if(String.valueOf(rst[i].getId_q()).length() == 5) {
							idqs = String.valueOf(rst[i].getId_q()) + "        ";
						} else if(String.valueOf(rst[i].getId_q()).length() == 6) {
							idqs = String.valueOf(rst[i].getId_q()) + "      ";
						} else {
							idqs = String.valueOf(rst[i].getId_q()) + "  ";
						}

						if(rst[i].getQ().length() > 71) {
							qs = rst[i].getQ().substring(0,70);
						} else {
							qs = rst[i].getQ();
						}

						qs = qs.replace("<","&lt");
						qs = qs.replace(">","&gt");
			%>
				<option value="<%=rst[i].getId_q()%>" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rst[i].getId_q()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rst[i].getQtype()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rst[i].getRefs()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=qs%></option>
			<%
					}
				}
			%>
			</select>
			</td>
		</tr>
		<tr height="30">
			<td align="right">검색된 문항 수 : <input type="text" class="input" name="search_cnt" size="6">&nbsp;문항&nbsp;&nbsp;</td>
		</tr>
		</table>
		</form>
	</div>
	<jsp:include page="../../copyright.jsp"/>
 </BODY>
</HTML>