<%
//******************************************************************************
//   프로그램 : q_c_lits.jsp
//   모 듈 명 : 과정내 문제 검색 관리
//   설    명 : 과정내 문제 검색 관리
//   테 이 블 : q, r_difficulty, r_qtype, c_course, q_subject
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.common.NameUtil, qmtm.qman.category.SubjectBean, 
//              qmtm.qman.category.SubjectUtil, qmtm.tman.exam.RqtypeBean, qmtm.tman.exam.RqtypeUtil,
//              qmtm.tman.exam.RdifficultBean, qmtm.tman.exam.RdifficultUtil, qmtm.qman.question.QListBean, 
//              qmtm.qman.question.QSearch, qmtm.qman.question.QSearchBean
//   작 성 일 : 2013-05-31
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.NameUtil, qmtm.qman.category.SubjectBean, qmtm.qman.category.SubjectUtil, qmtm.tman.exam.RqtypeBean, qmtm.tman.exam.RqtypeUtil, qmtm.tman.exam.RdifficultBean, qmtm.tman.exam.RdifficultUtil, qmtm.qman.question.QListBean, qmtm.qman.question.QSearch, qmtm.qman.question.QSearchBean, qmtm.admin.etc.QuseUtil, qmtm.admin.etc.QuseBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	String usergrade = (String)session.getAttribute("usergrade"); // 권한

	String id_course = request.getParameter("id_q_subject");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }	
		
	if (userid.length() == 0 || id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String bigos = request.getParameter("bigos");
	if (bigos == null) { bigos = ""; } else { bigos = bigos.trim(); }
	
	String subjects = "";
	String id_subject = "";
	String cpt1 = "";
	String chapter1 = "";		
	String qtes = "";
	String qtype = "";
	String diff = "";
	String difficultys = "";
	String cnts = "";
	String cnt1 = "";
	String cnt2 = "";
	String id_qs = "";
	String id_qs1 = "";
	String incorrects = "";
	String incorrect1 = "";	
	String src_pub_comps = "";
	String src_pub_comp1 = "";
	String correct_pcts = "";
	String correct_pct1 = "";
	String gubuns = "";
	String qs_chk = "";
	String qs = "";

	String quses = "";
	String quse1 = "";
	
	String explains = "";
	String explain1 = "";

	String find_kwds = "";
	String find_kwd1 = "";

	if(bigos.equals("Y")) {

		subjects = request.getParameter("subjects");
		if (subjects == null) { subjects = ""; } else { subjects = subjects.trim(); }
		id_subject = request.getParameter("id_subject");
		if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

		cpt1 = request.getParameter("cpt1");
		if (cpt1 == null) { cpt1 = ""; } else { cpt1 = cpt1.trim(); }
		chapter1 = request.getParameter("chapter1");
		if (chapter1 == null) { chapter1 = ""; } else { chapter1 = chapter1.trim(); }

		qtes = request.getParameter("qte");
		if (qtes == null) { qtes = ""; } else { qtes = qtes.trim(); }
		qtype = request.getParameter("qtype");
		if (qtype == null) { qtype = ""; } else { qtype = qtype.trim(); }

		diff = request.getParameter("diff");
		if (diff == null) { diff = ""; } else { diff = diff.trim(); }
		difficultys = request.getParameter("difficulty");
		if (difficultys == null) { difficultys = ""; } else { difficultys = difficultys.trim(); }

		cnts = request.getParameter("cnts");
		if (cnts == null) { cnts = ""; } else { cnts = cnts.trim(); }
		cnt1 = request.getParameter("cnt1");
		if (cnt1 == null) { cnt1 = ""; } else { cnt1 = cnt1.trim(); }
		cnt2 = request.getParameter("cnt2");
		if (cnt2 == null) { cnt2 = ""; } else { cnt2 = cnt2.trim(); }
		
		id_qs = request.getParameter("id_qs");
		if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }
		id_qs1 = request.getParameter("id_qs1");
		if (id_qs1 == null) { id_qs1 = ""; } else { id_qs1 = id_qs1.trim(); }

		incorrects = request.getParameter("incorrects");
		if (incorrects == null) { incorrects = ""; } else { incorrects = incorrects.trim(); }
		incorrect1 = request.getParameter("incorrect1");
		if (incorrect1 == null) { incorrect1 = ""; } else { incorrect1 = incorrect1.trim(); }

		src_pub_comps = request.getParameter("src_pub_comps");
		if (src_pub_comps == null) { src_pub_comps = ""; } else { src_pub_comps = src_pub_comps.trim(); }
		src_pub_comp1 = request.getParameter("src_pub_comp1");
		if (src_pub_comp1 == null) { src_pub_comp1 = ""; } else { src_pub_comp1 = src_pub_comp1.trim(); }

		correct_pcts = request.getParameter("correct_pcts");
		if (correct_pcts == null) { correct_pcts = ""; } else { correct_pcts = correct_pcts.trim(); }
		correct_pct1 = request.getParameter("correct_pct1");
		if (correct_pct1 == null) { correct_pct1 = ""; } else { correct_pct1 = correct_pct1.trim(); }
		gubuns = request.getParameter("gubuns");
		if (gubuns == null) { gubuns = ""; } else { gubuns = gubuns.trim(); }
		
		qs_chk = request.getParameter("qs_chk");
		if (qs_chk == null) { qs_chk = ""; } else { qs_chk = qs_chk.trim(); }
		
		qs = request.getParameter("qs");
		if (qs == null) { qs = ""; } else { qs = qs.trim(); }
		
		quses = request.getParameter("quses");
		if (quses == null) { quses = ""; } else { quses = quses.trim(); }
		quse1 = request.getParameter("quse1");
		if (quse1 == null) { quse1 = ""; } else { quse1 = quse1.trim(); }
		
		explains = request.getParameter("explains");
		if (explains == null) { explains = ""; } else { explains = explains.trim(); }
		explain1 = request.getParameter("explain1");
		if (explain1 == null) { explain1 = ""; } else { explain1 = explain1.trim(); }

		find_kwds = request.getParameter("find_kwds");
		if (find_kwds == null) { find_kwds = ""; } else { find_kwds = find_kwds.trim(); }
		find_kwd1 = request.getParameter("find_kwd1");
		if (find_kwd1 == null) { find_kwd1 = ""; } else { find_kwd1 = find_kwd1.trim(); }
	}
	
	// 과정명
	String course = "";

	try {
		course = NameUtil.getCourse(id_course);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
	   
	// 과목 리스트 가져오기
	SubjectBean[] rst = null;

    try {
	    rst = SubjectUtil.getBeans(id_course);
    } catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	// 문제유형 정보 가지고오기
	RqtypeBean[] qtypes = null;

    try {
	    qtypes = RqtypeUtil.getBeans();
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	// 난이도 정보 가지고오기
	RdifficultBean[] diffs = null;

    try {
	    diffs = RdifficultUtil.getBeans();
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	// 문제용도목록 가지고오기
	QuseBean[] quse = null;

	try {
		quse = QuseUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}

%>

<HTML>
 <HEAD>
  <TITLE> QMAN 과목 문제 관리 </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  <script type="text/javascript" src="../../js/tablesort.js"></script>
  <SCRIPT LANGUAGE="JavaScript" src="../../js/Script.js"></Script>

  <link rel="STYLESHEET" type="text/css" href="../../codebase/dhtmlxgrid.css">
  <link rel="stylesheet" type="text/css" href="../../dhtmlxGrid/codebase/skins/dhtmlxgrid_dhx_web.css">
  <script src="../../dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
  <script src="../../dhtmlxGrid/codebase/dhtmlxgrid.js"></script>
  <script src="../../dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
  <script src="../../dhtmlxGrid/codebase/ext/dhtmlxgrid_srnd.js"></script>

  <style>
		#q_view { }
		#q_view table { width: 500px; border: 10px solid red; }
	</style>
	<script language="JavaScript">
	
		function inits() {
			var id_subject = "<%=id_subject%>";
			var chapter1 = "<%=chapter1%>";
			
			var subjects = "<%=subjects%>";
			var cpt1 = "<%=cpt1%>";
									
			if(cpt1 == "Y") {
				get_cpt1_list(id_subject);			
			}
			
			init();
		}
		
		function checks1() {
			var frm = document.form1;
			
			if(frm.qte.checked == true) {
				frm.qtype.disabled = false;
				frm.qte.value = "Y";
			} else {
				frm.qtype.disabled = true;
				frm.qte.value = "N";
			}
		}

		function checks2() {
			var frm = document.form1;
			
			if(frm.diff.checked == true) {
				frm.difficulty.disabled = false;
				frm.diff.value = "Y";
			} else {
				frm.difficulty.disabled = true;
				frm.diff.value = "N";
			}
		}

		function checks3() {
			var frm = document.form1;
			
			if(frm.cnts.checked == true) {
				frm.cnt1.disabled = false;
				frm.cnt2.disabled = false;
				frm.cnts.value = "Y";
			} else {
				frm.cnt1.disabled = true;
				frm.cnt2.disabled = true;
				frm.cnts.value = "N";
			}
		}

		function checks5() {
			var frm = document.form1;
			
			if(frm.qs_chk.checked == true) {
				frm.qs.disabled = false;
				frm.qs_chk.value = "Y";
			} else {
				frm.qs.disabled = true;
				frm.qs_chk.value = "N";
			}
		}

		function checks6() {
			var frm = document.form1;
			
			if(frm.id_qs.checked == true) {
				frm.id_qs1.disabled = false;
				frm.id_qs.value = "Y";
			} else {
				frm.id_qs1.disabled = true;
				frm.id_qs.value = "N";
			}
		}

		function checks7() {
			var frm = document.form1;
			
			if(frm.incorrects.checked == true) {
				
				frm.incorrects.value = "Y";

				frm.qte.checked = false;
				frm.qte.disabled = true;
				frm.qtype.disabled = true;
				
				frm.diff.checked = false;
				frm.diff.disabled = true;
				frm.difficulty.disabled = true;
				
				frm.cnts.checked = false;
				frm.cnts.disabled = true;
				frm.cnt1.disabled = true;
				frm.cnt2.disabled = true;

				frm.id_qs.checked = false;
				frm.id_qs.disabled = true;
				frm.id_qs1.disabled = true;

				frm.qs_chk.checked = false;
				frm.qs_chk.disabled = true;
				frm.qs_chk.disabled = true;

				frm.incorrect1.disabled = false;

			} else {

				frm.incorrects.value = "N";

				frm.qte.disabled = false;
				frm.diff.disabled = false;
				frm.cnts.disabled = false;				
				frm.id_qs.disabled = false;
				frm.qs_chk.disabled = false;

				frm.incorrect1.disabled = true;

			}
		}
		
		function checks11() {
			var frm = document.form1;
			
			if(frm.src_pub_comps.checked == true) {
				frm.src_pub_comp1.disabled = false;
				frm.src_pub_comps.value = "Y";
			} else {
				frm.src_pub_comp1.disabled = true;
				frm.src_pub_comps.value = "N";
			}
		}

		function checks3() {
			var frm = document.form1;
			
			if(frm.cnts.checked == true) {
				frm.cnt1.disabled = false;
				frm.cnt2.disabled = false;
				frm.cnts.value = "Y";
			} else {
				frm.cnt1.disabled = true;
				frm.cnt2.disabled = true;
				frm.cnts.value = "N";
			}
		}


		function checks12() {
			var frm = document.form1;
			
			if(frm.correct_pcts.checked == true) {
				frm.correct_pct1.disabled = false;
				frm.gubuns.disabled = false;
				frm.correct_pcts.value = "Y";
			} else {
				frm.correct_pct1.disabled = true;
				frm.gubuns.disabled = true;
				frm.correct_pcts.value = "N";
			}
		}

		function checks13() {
			var frm = document.form1;
			
			if(frm.subjects.checked == true) {
				frm.id_subject.disabled = false;
				frm.subjects.value = "Y";
			} else {
				frm.id_subject.disabled = true;
				frm.subjects.value = "N";
			}
		}

		function checks14() {
			var frm = document.form1;
			
			if(frm.cpt1.checked == true) {
				frm.chapter1.disabled = false;
				frm.cpt1.value = "Y";
			} else {
				frm.chapter1.disabled = true;
				frm.cpt1.value = "N";
			}
		}

		function checks15() {
			var frm = document.form1;
			
			if(frm.quses.checked == true) {
				frm.quse1.disabled = false;
				frm.quses.value = "Y";
			} else {
				frm.quse1.disabled = true;
				frm.quses.value = "N";
			}
		}

		function checks16() {
			var frm = document.form1;
			
			if(frm.explains.checked == true) {
				frm.explain1.disabled = false;
				frm.explains.value = "Y";
			} else {
				frm.explain1.disabled = true;
				frm.explains.value = "N";
			}
		}

		function checks17() {
			var frm = document.form1;
			
			if(frm.find_kwds.checked == true) {
				frm.find_kwd1.disabled = false;
				frm.find_kwds.value = "Y";
			} else {
				frm.find_kwd1.disabled = true;
				frm.find_kwds.value = "N";
			}
		}

		function qs_search_list() {

			var frm = document.form1;

			var subjects = "N";
			var id_subject = "";

			if(frm.subjects.checked == true) {
				subjects = "Y";
				id_subject = frm.id_subject.value;
			} else {
				subjects = "N";
				id_subject = "";
			}

			var cpt1 = "N";
			var chapter1 = "";

			if(frm.cpt1.checked == true) {
				cpt1 = "Y";
				chapter1 = frm.chapter1.value;
			} else {
				cpt1 = "N";
				chapter1 = "";
			}
						
			var qte = "N";
			var qtype = "";

			if(frm.qte.checked == true) {
				qte = "Y";
				qtype = frm.qtype.value;
			} else {
				qte = "N";
				qtype = "";
			}
			
			var diff = "N";
			var difficulty = "";
			
			if(frm.diff.checked == true) {
				diff = "Y";
				difficulty = frm.difficulty.value;
			} else {
				diff = "N";
				difficulty = "";
			}
			
			var cnts = "N";
			var cnt1 = "";
			var cnt2 = "";
			
			if(frm.cnts.checked == true) {
				cnts = "Y";
				cnt1 = frm.cnt1.value;
				cnt2 = frm.cnt2.value;
			} else {
				cnts = "N";
				cnt1 = "";
				cnt2 = "";
			}
			
			var id_qs = "N";
			var id_qs1 = "";
			
			if(frm.id_qs.checked == true) {
				id_qs = "Y";
				id_qs1 = frm.id_qs1.value;
			} else {
				id_qs = "N";
				id_qs1 = "";
			}

			var incorrects = "N";
			var incorrect1 = "";

			if(frm.incorrects.checked == true) {
				incorrects = "Y";
				incorrect1 = frm.incorrect1.value;
			} else {
				incorrects = "N";
				incorrect1 = "";
			}

			var incorrects = "N";
			var incorrect1 = "";

			if(frm.incorrects.checked == true) {
				incorrects = "Y";
				incorrect1 = frm.incorrect1.value;
			} else {
				incorrects = "N";
				incorrect1 = "";
			}
			
			var quses = "N";
			var quse1 = "";

			if(frm.quses.checked == true) {
				quses = "Y";
				quse1 = frm.quse1.value;
			} else {
				quses = "N";
				quse1 = "";
			}

			var explains = "N";
			var explain1 = "";

			if(frm.explains.checked == true) {
				explains = "Y";
				explain1 = frm.explain1.value;
			} else {
				explains = "N";
				explain1 = "";
			}

			var find_kwds = "N";
			var find_kwd1 = "";

			if(frm.find_kwds.checked == true) {
				find_kwds = "Y";
				find_kwd1 = frm.find_kwd1.value;
			} else {
				find_kwds = "N";
				find_kwd1 = "";
			}
			
			var src_pub_comps = "N";
			var src_pub_comp1 = "";

			if(frm.src_pub_comps.checked == true) {
				src_pub_comps = "Y";
				src_pub_comp1 = frm.src_pub_comp1.value;
			} else {
				src_pub_comps = "N";
				src_pub_comp1 = "";
			}

			var correct_pcts = "N";
			var correct_pct1 = "";
			var gubuns = "";
			
			if(frm.correct_pcts.checked == true) {
				correct_pcts = "Y";
				correct_pct1 = frm.correct_pct1.value;
				gubuns = frm.gubuns.value;
			} else {
				correct_pcts = "N";
				correct_pct1 = "";
				gubuns = "";
			}

			var qs_chk = "N";
			var qs = "";

			if(frm.qs_chk.checked == true) {
				qs_chk = "Y";
				qs = frm.qs.value;
			} else {
				qs_chk = "N";
				qs = "";
			}
			
			frm.bigos.value = "Y";
							
			frm.submit();
		}

		function dbl_selects(id_q, id_subject, id_chapter) {
			window.open("../editor/edit_form.jsp?move_id_q="+id_q+"&id_subject="+id_subject+"&id_chapter="+id_chapter,"q_edit","width=1220, height=720, scrollbars=yes");
		}


		var cpts;

		// 단원 1 정보 가지고오기
		function get_cpt1_list(cpts1) {
			
			var frm = document.form1;
			
			if(frm.cpt1.checked == true) {
				frm.chapter1.disabled = false;
			} else {
				frm.chapter1.disabled = true;
			}

			cpts = new ActiveXObject("Microsoft.XMLHTTP");
			cpts.onreadystatechange = get_cpt1_list_callback;
			cpts.open("GET", "chapter.jsp?cpt1="+cpts1+"&selects=<%=chapter1%>", true);
			cpts.send();
		}

		function get_cpt1_list_callback() {
			if(cpts.readyState == 4) {
				if(cpts.status == 200) {
					if(typeof(document.all.div_cpt1) == "object") {
						document.all.div_cpt1.innerHTML = cpts.responseText;
					}
				}
			}
		}

	</script>
  
	<SCRIPT LANGUAGE="JavaScript">
  <!--

   function q_search() {
	   location.href = "q_c_list.jsp?id_q_subject=<%=id_course%>";
    }
   
   function q_standard() {
	 location.href = "../category/subject_list.jsp?id_course=<%=id_course%>";
   }
   

   function q_preview() {
		
		 strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			for(var i=0; i<ArrIds.length; i++) {
				selectId += mygrid.cells(ArrIds[i],0).getValue() + ",";
			}
			
		}		 		 
		 
		if(strs == "" || strs == null) {
			 alert("미리보기 할 문제를 선택해주세요.");
		 } else {
			 $.posterPopup("q_preview.jsp?id_qs="+selectId.substring(0,selectId.length-1),"preview_q","width=800, height=640, scrollbars=yes,top='+(screen.height-800)/2+', left='+(screen.width-640)/2);");
		 }
	 }

	 function q_search() {
	   location.href = "../question/q_c_list.jsp?id_q_subject=<%=id_course%>&id_q_chapter=0";
    }
	

	  var gridQString = "";//we'll save here the last url with query string we used for loading grid (see step 5 for details)
      //we'll use this script block for functions
	  var mygrid = "";
	  function init(){

		mygrid = new dhtmlXGridObject('products_grid');
        mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");        
		mygrid.setColumnsVisibility("false,false,false,false,false,false,false,false");
		mygrid.setHeader("문제코드,출제횟수,문제,문제유형,난이도,정답,정답률,등록일자,과목코드,단원코드");
		mygrid.setInitWidths("5%,5%,32%,10%,7%,10%,7%,10%,7%,7%");
        mygrid.setColAlign("center,center,left,center,center,left,center,center,center,center");
		mygrid.setColTypes("ro,ro,ro,ro,ro,ro,ro,ro,ro,ro");
		mygrid.setColSorting("int,int,str,str,str,str,int,str,str,str")
		mygrid.attachEvent("onRowDblClicked", doOnRowDblClicked);
		mygrid.setStyle("text-align:center;", "","", "");
        mygrid.setSkin("dhx_web");
		mygrid.setMultiselect(!mygrid.selMultiRows);
		mygrid.init();
        mygrid.enableSmartRendering(true);
		if (mygrid.setColspan);
	    mygrid.attachEvent("onXLE", setCounter);
		gridQString = "search_getXML.jsp?id_course=<%=id_course%>&subjects=<%=subjects%>&id_subject=<%=id_subject%>&cpt1=<%=cpt1%>&chapter1=<%=chapter1%>&qtes=<%=qtes%>&qtype=<%=qtype%>&diff=<%=diff%>&difficulty=<%=difficultys%>&cnts=<%=cnts%>&cnt1=<%=cnt1%>&cnt2=<%=cnt2%>&id_qs=<%=id_qs%>&id_qs1=<%=id_qs1%>&incorrects=<%=incorrects%>&incorrect1=<%=incorrect1%>&quses=<%=quses%>&quse1=<%=quse1%>&explains=<%=explains%>&explain1=<%=explain1%>&find_kwds=<%=find_kwds%>&find_kwd1=<%=find_kwd1%>&src_pub_comps=<%=src_pub_comps%>&src_pub_comp1=<%=src_pub_comp1%>&correct_pcts=<%=correct_pcts%>&correct_pct1=<%=correct_pct1%>&gubuns=<%=gubuns%>&qs_chk=<%=qs_chk%>&qs=<%=qs%>";
		mygrid.loadXML(gridQString);
		
	  }	 
	  
	  function doOnRowDblClicked(rowId) {          

		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";
		var input_text = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			if(ArrIds.length > 1) {
				alert("문제편집은 여러개의 문제를 진행할 수 없습니다.\n\n편집 할 문제만 선택해주세요.");

				return;
			} else {
				for(var i=0; i<ArrIds.length; i++) {
					selectId = mygrid.cells(ArrIds[i],0).getValue();
					selected_id_subject = mygrid.cells(ArrIds[i],10).getValue();
					selected_id_course = mygrid.cells(ArrIds[i],11).getValue();
				}
			}
			
		}		 		

		
	  if(strs == "" || strs == null) {
			alert("편집 할 문제를 선택해주세요.");
		} else {
			$.posterPopup("../editor/edit_form.jsp?move_id_q="+selectId+"&id_subject="+selected_id_subject+"&id_chapter="+selected_id_course,"q_edit","width=1220, height=720, scrollbars=yes,top='+(screen.height-1220)/2+', left='+(screen.width-720)/2);");			
		}
	  }

	  function setCounter() {
	    document.form1.search_cnt.value = mygrid.getRowsNum();
	  }

	  function excel_save() {
		
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			for(var i=0; i<ArrIds.length; i++) {
				selectId += mygrid.cells(ArrIds[i],0).getValue() + ",";
			}
			
		}		 		 
		 
		if(strs == "" || strs == null) {
		    alert("엑셀로 저장할 문제를 선택해주세요.");			
		 } else {
			document.forms1.q_excels.value = selectId.substring(0,selectId.length-1);
			document.forms1.action = 'q_excel_save.jsp';
			document.forms1.method = 'post';
			document.forms1.submit();
	     }
	}

	function check_enable() {
		if(mygrid) {
			mygrid.selectAll();
		}
	}

	function check_disable() {
		if(mygrid) {
			mygrid.clearSelection();
		}
	}

  //-->
  </SCRIPT>

 </HEAD>

  <% if(bigos.equals("")) { %>
	  <BODY id="qman">
  <% } else { %>
	  <BODY id="qman" onLoad="inits();">	
  <% } %>

	<form name="forms1">
		<input type="hidden" name="q_excels">
	</form>
	
	<form name="form1" method="post" action="q_c_list.jsp">
	<input type="hidden" name="bigos" >
	<input type="hidden" name="id_q_subject" value="<%=id_course%>">

  <div id="main">
				
		<div class="tab"><a href="javascript:q_search();" onfocus="this.blur();"><img src="../../images/tabqA01_.gif"></a><a href="javascript:q_standard();" onfocus="this.blur();"><img src="../../images/tabqA02.gif"></a></div>

		  <div id="mainTop">
			<div class="title">과정내 문제검색 <span>검색을 원하는 문제의 검색 조건을 입력하십시오. </span></div><div align="right" style="font: bold 14px dotum; color: #000;"><img src="../../images/icon_location.gif"> 과정명 : <%=course%></div>			
		</div>

		  <table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">			
			<tr>
				<td id="left"><input type="checkbox" name="subjects" value="Y" onClick="checks13();" <% if(subjects.equals("Y")) { %>checked<% } %>>과목선택</td>
				<td ><select name="id_subject" style=width:300 <% if(!subjects.equals("Y")) { %>disabled<% } %> onChange="get_cpt1_list(this.value);">
				<%
					if(rst == null) {
				%>
					<option value="등록된 과목이 없습니다.">
				<% 
					} else {
				%>
					<option value="">과목을선택하세요</option>
				<%
						for(int i=0; i<rst.length; i++) {
				%>
					<option value="<%=rst[i].getId_subject()%>" <% if(id_subject.equals(rst[i].getId_subject())) { %>selected<% } %>><%=rst[i].getSubject()%></option>
				<% 
						} 
					}
				%>
				</select>
				</td>
				<td id="left"><input type="checkbox" name="cpt1" value="Y" onClick="checks14();" <% if(cpt1.equals("Y")) { %>checked<% } %>>단원선택</td>
				<td ><div id="div_cpt1">
					<select name="chapter1" style="width:300" <% if(!cpt1.equals("Y")) { %>disabled<% } %> onChange="get_standarda_list(this.value);">
						<option value=""></option>
					</select>
					</div>
				</td>
			</tr>			
			<tr>
				<td id="left" width="15%"><input type="checkbox" name="qte" onClick="checks1(this);" value="Y" <% if(qtes.equals("Y")) { %>checked<% } %>>문제 유형</td>
				<td width="35%"><select name="qtype" style=width:300 <% if(!qtes.equals("Y")) { %>disabled<% } %>>
				<option value="">문제유형 선택</option>
				<% for(int i=0; i<qtypes.length; i++) { %>
				<option value="<%=qtypes[i].getId_qtype()%>" <%if(qtype.equals(qtypes[i].getId_qtype())) {%>selected<% } %>><%=qtypes[i].getQtype()%></option>
				<% } %>
				</select>
				</td>
				<td id="left" width="15%"><input type="checkbox" name="diff" onClick="checks2();" value="Y" <% if(diff.equals("Y")) { %>checked<% } %>>난이도</td>
				<td width="35%"><select name="difficulty" style=width:300 <% if(!diff.equals("Y")) { %>disabled<% } %>>
				<option value="">난이도 선택</option>
				<% for(int i=0; i<diffs.length; i++) { %>
				<option value="<%=diffs[i].getId_difficulty()%>" <%if(difficultys.equals(diffs[i].getId_difficulty())) {%>selected<% } %>><%=diffs[i].getDifficulty()%></option>
				<% } %>
				</select>
				</td>
			</tr>
			<tr>
				<td id="left"><input type="checkbox" name="cnts" onClick="checks3();" value="Y" <% if(cnts.equals("Y")) { %>checked<% } %>>출제횟수</td>
				<td><input type="text" class="input" name="cnt1" <% if(!cnts.equals("Y")) { %>disabled<% } %> size="5" value="<%=cnt1%>"> 회&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;<input type="text" class="input" name="cnt2" <% if(!cnts.equals("Y")) { %>disabled<% } %> size="5" value="<%=cnt2%>"> 회</td>
				<td id="left"><input type="checkbox" name="id_qs" onClick="checks6();" value="Y" <% if(id_qs.equals("Y")) { %>checked<% } %>>문제 코드</td>
				<td><input type="text" class="input" name="id_qs1" value="<%=id_qs1%>" size="10" disabled></td>
			</tr>			
			<tr>
				<td id="left"><input type="checkbox" name="incorrects" value="Y" onClick="checks7();" <% if(incorrects.equals("Y")) { %>checked<% } %>>오류로 인한 문제</td>
				<td ><select name="incorrect1" style=width:300 <% if(!incorrects.equals("Y")) { %>disabled<% } %>>
				<option value="" <% if(incorrect1.equals("")) { %>selected<% } %>>선택하세요</option>
				<option value="1" <% if(incorrect1.equals("1")) { %>selected<% } %>>오류 문제</option>
				<option value="2" <% if(incorrect1.equals("2")) { %>selected<% } %>>모두 정답 처리</option>
				</select>
				</td>
				<td id="left" width="15%"><input type="checkbox" name="quses" onClick="checks15();" value="Y" <% if(quse.equals("Y")) { %>checked<% } %>>문제용도</td>
				<td width="35%"><select name="quse1" style=width:300 <% if(!quse.equals("Y")) { %>disabled<% } %>>
				<option value="">문제용도 선택</option>
				<% for(int i=0; i<quse.length; i++) { %>
				<option value="<%=quse[i].getId_q_use()%>" <%if(quse1.equals(quse[i].getId_q_use())) {%>selected<% } %>><%=quse[i].getQ_use()%></option>
				<% } %>
				</select>
				</td>				
			</tr>			
			<tr>
				<td id="left"><input type="checkbox" name="src_pub_comps" onClick="checks11();" value="Y" <% if(src_pub_comps.equals("Y")) { %>checked<% } %>>출처</td>
				<td><input type="text" class="input" name="src_pub_comp1" <% if(!src_pub_comps.equals("Y")) { %>disabled<% } %> value="<%=src_pub_comp1%>" size="40"></td>
				<td id="left"><input type="checkbox" name="correct_pcts" onClick="checks12();" value="Y" <% if(correct_pcts.equals("Y")) { %>checked<% } %>>정답률</td>
				<td><input type="text" class="input" name="correct_pct1" size="4" <% if(!correct_pcts.equals("Y")) { %>disabled<% } %> value="<%=correct_pct1%>"> %&nbsp;<select name="gubuns" <% if(!correct_pcts.equals("Y")) { %>disabled<% } %>>
				<option value="plus" <% if(gubuns.equals("plus")) { %>selected<% } %>>이상</option>
				<option value="minus" <% if(gubuns.equals("minus")) { %>selected<% } %>>이하</option>
				</select></td>
			</tr>
			<tr>
				<td id="left"><input type="checkbox" name="explains" onClick="checks16();" value="Y" <% if(explains.equals("Y")) { %>checked<% } %>>해설</td>
				<td><input type="text" class="input" name="explain1" <% if(!explains.equals("Y")) { %>disabled<% } %> value="<%=explain1%>" size="60"></td>
				<td id="left"><input type="checkbox" name="find_kwds" onClick="checks17();" value="Y" <% if(find_kwds.equals("Y")) { %>checked<% } %>>검색키워드</td>
				<td><input type="text" class="input" name="find_kwd1" size="60" <% if(!find_kwds.equals("Y")) { %>disabled<% } %> value="<%=find_kwd1%>"></td>
			</tr>
			<tr>
				<td id="left"><input type="checkbox" name="qs_chk" onClick="checks5();" value="Y" <% if(qs_chk.equals("Y")) { %>checked<% } %>>문제명 검색</td>
				<td colspan="3"><input type="text" class="input" name="qs" <% if(!qs_chk.equals("Y")) { %>disabled<% } %> value="<%=qs%>" size="80"></td>				
			</tr>
			
		</table>				
		<BR><BR>		
		<div id="button" align="center">
		<input type="submit" value="검색하기" onClick="qs_search_list();" class="form">
		</div>
			
		<BR>
		
		<table border="0" width="100%">
			<tr>
				<td align="left"><img src="../../images/bt_q_list_yj1.gif" onClick="check_enable();">&nbsp;&nbsp;<img src="../../images/bt_q_list2_yj1.gif"  onClick="check_disable();">&nbsp;&nbsp;검색된 문제 수 : <input type="text" readonly class="input" name="search_cnt" size="3">&nbsp;문제&nbsp;&nbsp;<b><font color="green">(문제코드를 클릭하면 등록된 문제를 편집할 수 있습니다.)</font></b></td>
					<td align="right"><input type="button" value="미리보기" class="form" onClick="q_preview();">&nbsp;&nbsp;&nbsp;<input type="button" value="엑셀파일 다운로드" class="form" onClick="excel_save();"></td>
			</tr>
		</table>
		<BR>
		<div id="contents">
			<div id="products_grid" style="width:100%;height:550px;"></div>
		</div>		
		
	</form>
	
	</div> 