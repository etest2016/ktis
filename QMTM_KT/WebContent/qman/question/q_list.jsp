<%
//******************************************************************************
//   프로그램 : q_lits.jsp
//   모 듈 명 : 문제 관리
//   설    명 : 문제 목록 및 추가,수정,삭제
//   테 이 블 : q
//   자바파일 : qmtm.*, qmtm.qman.question.*
//   작 성 일 : 2008-04-16
//   작 성 자 : 이테스트 강진아
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.qman.question.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = CommonUtil.get_Cookie(request, "userid");

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
	if (id_q_chapter == null) { id_q_chapter = "-1"; } else { id_q_chapter = id_q_chapter.trim(); }	
	
	if (id_q_chapter.length() == 0) {
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		history.back();
	</script>
<%	
	}

    // 단원에 해당하는 문제 가져오기
	
	QListBean[] rst = null;

    try {
	    rst = QListUtil.getUBeans(userid, id_q_subject, id_q_chapter);
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

	function QSearch(){
		window.open("q_search.jsp?id_q_subject=<%=id_q_subject%>","QSearch","width=900,height=650, scrollbars=yes");
	}

	function QEdit(){
		window.open("q_edit.jsp?id_q_subject=<%=id_q_subject%>","QEdit","width=740,height=500");
	}

	function QDelete(id_q){
		var st = confirm("해당 문제를 삭제하시겠습니까?" );
		var id_q;
		if (st == true) {
			location.href = "q_delete.jsp?id_q="+id_q;
		}
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
			 window.open("q_preview.jsp?id_qs="+selectId.substring(0,selectId.length-1),"preview_q","top=0, left=0, width=800, height=640, scrollbars=yes");
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

  //-->
  </SCRIPT>
 </HEAD>

 <BODY onLoad = "selects();" id="qman">
	<div id="main">
		<FORM NAME="form1">

		<div class="title">문제관리11</div>

		<!--div style="font-size: 9pt;" style="width: 100%; background-color: #ebf3fd; padding: 7px 10px 7px 10px; border-top: 1px dotted #d1d1d1; ">
			<input type="button" value="> 문제추가(개별)" onclick="QInsert();" style="font-size: 9pt; background-color: #FFF; border: 1px solid #CCC; padding-top: 3px;">
			<input type="button" value="> 문제추가(일괄)" style="font-size: 9pt; background-color: #FFF; border: 1px solid #CCC; padding-top: 3px;">
			<input type="button" value="> 문제삭제" style="font-size: 9pt; background-color: #FFF; border: 1px solid #CCC; padding-top: 3px;">
			<input type="button" value="> 문제검색"onclick="QSearch();" style="font-size: 9pt; background-color: #FFF; border: 1px solid #CCC; padding-top: 3px;">
			<input type="button" value="> 미리보기" style="font-size: 9pt; background-color: #FFF; border: 1px solid #CCC; padding-top: 3px;">
			<input type="button" value="> HTML저장" style="font-size: 9pt; background-color: #FFF; border: 1px solid #CCC; padding-top: 3px;">
		</div-->

		<table border="0" cellpadding ="0" cellspacing="0" >
			<tr>
				<td >
					<a href="javascript:QInsert();" style="padding-top: 3px; padding-left: 3px; padding-right: 3px;"><img src="../../../images/bt5_qI_1.gif"></a>
					<!--input type="button" value="> 문제추가(개별)" onclick="QInsert();" style="font-size: 9pt; background-color: #FFF; border: 1px solid #CCC; padding-top: 3px;"-->
					<img src="../../../images/bt5_qI_2.gif" style="padding-top: 3px; padding-left: 3px; padding-right: 3px;">
					<!--input type="button" value="> 문제추가(일괄)" style="font-size: 9pt; background-color: #FFF; border: 1px solid #CCC; padding-top: 3px;"-->
					<a href="javascript:QDelete();" style="padding-top: 3px; padding-left: 3px; padding-right: 3px;"><img src="../../../images/bt5_qI_3.gif"></a>
					<!--input type="button" value="> 문제삭제" style="font-size: 9pt; background-color: #FFF; border: 1px solid #CCC; padding-top: 3px;"-->
					<a href="javascript:QSearch();" style="padding-top: 3px; padding-left: 3px; padding-right: 3px;"><img src="../../../images/bt5_qI_4.gif"></a>
					<!--input type="button" value="> 문제검색"onclick="QSearch();" style="font-size: 9pt; background-color: #FFF; border: 1px solid #CCC; padding-top: 3px;"-->
					<a href="javascript:q_preview();" border="0"><img src="../../../images/bt5_qI_5.gif" style="padding-top: 3px; padding-left: 3px; padding-right: 3px;"></a>
					<!--input type="button" value="> 미리보기" style="font-size: 9pt; background-color: #FFF; border: 1px solid #CCC; padding-top: 3px;"-->
					<img src="../../../images/bt5_qI_6.gif" style="padding-top: 3px; padding-left: 3px; padding-right: 3px;">
					<!--input type="button" value="> HTML저장" style="font-size: 9pt; background-color: #FFF; border: 1px solid #CCC; padding-top: 3px;"-->
				</td>
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