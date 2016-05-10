<%
//******************************************************************************
//   ���α׷� : nonscore_upload.jsp
//   �� �� �� : �������� ����� ���� ���
//   ��    �� : �������� ����� ���� ���
//   �� �� �� : exam_ans, exam_ans_non, exam_paper2
//   �ڹ����� : 
//   �� �� �� : 2013-03-12
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.poi.poifs.filesystem.POIFSFileSystem, org.apache.poi.hssf.record.*, org.apache.poi.hssf.model.*, org.apache.poi.hssf.usermodel.*, org.apache.poi.hssf.util.*, qmtm.ComLib, qmtm.CommonUtil, qmtm.QmTm, qmtm.tman.answer.PracticeMarkNon, qmtm.tman.answer.PracticeMarkNonBean, qmtm.common.* " %>
<%@ include file = "/common/login_chk.jsp" %>
<!DOCTYPE html>
	<head>
		<title>����� ���� �� ���� ���</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="../../js/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
		<script src="../../js/jquery.js"></script>
		<script src="../../js/bootstrapjs/bootstrap.min.js"></script>
		<script type="text/javascript">
			function close_window() {
				opener.location.reload();
				window.close();
			}
		</script>
		<style type="text/css">
			#progress_div { margin:20px; text-align:center;}
		</style>
	</head>

<body>
	<div id="progress_div">
		<div class="progress progress-striped active">
		  <div class="bar" style="width: 0%;"></div>
		</div>
		<h1 id="current_cnt"></h1>
		<div id="alert_compelete" style="display:none;" class="alert alert-success">�����(�Ǳ���) ���� �� ������ ��ϵǾ����ϴ�.</div>
		<button id="btn_close" style="display:none;" class="btn" onclick="close_window()">���ư���</button>
	</div>
<%
	String realFolder = "";

	String saveFolder = "upload";
	String encType = "EUC-KR";

	String id_exam = "";
	String id_q = "";
	String allotting = "";

	String filename = "";
	String excelfile = "";

	int maxSize = 1024*1024*100;

	ServletContext context = getServletContext();

	realFolder = context.getRealPath(saveFolder);

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	try {
	 
		 MultipartRequest multi = null;
		 
		 multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

		 id_exam = multi.getParameter("id_exam");
		 id_q = multi.getParameter("id_q");
		 allotting = multi.getParameter("allotting");
		 
		 Enumeration files = multi.getFileNames();

		 String is_error = "N";
		 
		 while(files.hasMoreElements()) {
		  
			String name = (String)files.nextElement();
			filename = multi.getFilesystemName(name);

			String file_ext = filename.substring(filename.lastIndexOf('.') + 1);
			file_ext = file_ext.toLowerCase();
			if(!( file_ext.equalsIgnoreCase("xls") || file_ext.equalsIgnoreCase("xlsx")) ) {
				is_error = "Y";
			}

			String original = multi.getOriginalFileName(name);
			String type = multi.getContentType(name);

			File file = multi.getFile(name);

			excelfile = realFolder+"/"+filename; 
	      } 

		  if(is_error == "Y") {
			  out.print("���ε� ���� ���� �Դϴ�.");
			  if(true) return;
		  }	
		  
		}catch(IOException e){
			out.println(e);
			if(true) return;
	}catch(Exception ex){
		out.println(ex);
		if(true) return;
	}
	
	
	// �ش� ������ �������� �������� �о�´�
	int qcount = 0;

	try {
		qcount = PracticeMarkNon.getQcount(id_exam);	
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}
	
	double ExamAllotting = 0;
    int nr_q = 0;
	String old_score;
	String ox = "";
	String point = "";

	PracticeMarkNonBean rst = new PracticeMarkNonBean();
	
	try {

       POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(excelfile)); 

       //��ũ���� ����!                
       HSSFWorkbook workbook = new HSSFWorkbook(fs);

       int sheetNum = workbook.getNumberOfSheets();

       for (int k = 0; k < sheetNum; k++) {

            //��Ʈ �̸��� ��Ʈ��ȣ�� ����
            HSSFSheet sheet = workbook.getSheetAt(k);
            int rows = sheet.getPhysicalNumberOfRows();

            for (int r = 1; r <= rows; r++) { 
				// ���������Ȳ �� ���α׷�����
				int progress_percent = r * 100 / rows ;
				if (((r % 5) == 0) || (r == rows)) {
					String str_result = "<script type='text/javascript'>";
					str_result += "$('.bar').css('width','" + progress_percent + "%');";
					str_result += "$('#current_cnt').text('�����Ȳ : " + "(" + r + "/" + rows + ")');";
					str_result += "</script>";

					out.println(str_result);
					out.flush();
				}	

                // ��Ʈ�� ���� ���� �ϳ��� ����
                HSSFRow row   = sheet.getRow(r);
                if (row != null) { 
                     int cells = row.getPhysicalNumberOfCells();

					 String userid = "";
					 String score = "";
					 String score_comment = "";

                     for (short c = 0; c < cells; c++) {

                         // �࿡���� ���� �ϳ��� �����Ͽ� �� Ÿ�Կ� ���� ó��
                         HSSFCell cell  = row.getCell(c);
                         if (cell != null) { 
                              String value = "";						  
								cell.setCellType(HSSFCell.CELL_TYPE_STRING);						  

                              switch (cell.getCellType()) {

                                   case HSSFCell.CELL_TYPE_FORMULA :
                                       value = String.valueOf(cell.getCellFormula());
                                        break;
                                   case HSSFCell.CELL_TYPE_NUMERIC :
                                       value = String.valueOf(cell.getNumericCellValue()); //double
                                       break;
                                  case HSSFCell.CELL_TYPE_STRING :
                                       value = cell.getStringCellValue(); //String
                                       break;
                                  case HSSFCell.CELL_TYPE_BLANK :
                                      value = "";
                                     break;
                                 case HSSFCell.CELL_TYPE_BOOLEAN :
                                     value = String.valueOf(cell.getBooleanCellValue()); //boolean
                                    break;
                                case HSSFCell.CELL_TYPE_ERROR :
                                     value = String.valueOf(cell.getErrorCellValue()); // byte
                                     break;
                                default :
                             }						
							
							if(cell.getCellNum() == 0) {
								userid = value;									
							} else if(cell.getCellNum() == 1) {
								score = value;							
							} else if(cell.getCellNum() == 2) {
								score_comment = value;
							}

                        } 					

                    }

					if(!(userid == null || userid.equals(""))) {
						
						try {
							rst = PracticeMarkNon.getBean3(id_q, userid, id_exam);
						} catch(Exception ex) {
							out.println(ComLib.getExceptionMsg(ex, "close"));
						}

						if(rst == null) {

							out.println(ComLib.getAlertMsg("�ش� �򰡿� �����ڰ� ��� �ϰ������ ������ �� �����ϴ�. �������Ͽ� �ϰ������ ������ ������ Ȯ�����ֽñ� �ٶ��ϴ�.", "close"));

							if(true) return;
							
						} else {
													
							ExamAllotting = rst.getAllotting();
							nr_q = rst.getNr_q();      
							old_score = String.valueOf(rst.getScore()); // ������ ä�� ����  
							
							if(Double.parseDouble(score) > ExamAllotting) {
								out.println(ComLib.getAlertMsg("[" + userid + "]" + " �������� ���� ������ ��ϵǾ����ϴ�.���ε� �� �������Ͽ� ������ Ȯ���Ͻ� �� �ٽ� �������ֽñ� �ٶ��ϴ�.", "close"));

								if(true) return;
							}
					
							String oxs = rst.getOxs();
							String points = rst.getPoints();
														
							if(oxs == null || oxs.equals("")) {
								out.println(ComLib.getAlertMsg("[" + userid + "]" + "ä���� ������ ���� ���� �����ڰ� �ֽ��ϴ�. ����� �������� �ϰ�ä���� ������ �� �̿����ֽñ� �ٶ��ϴ�.", "close"));

								if(true) return;
							}

							int nonCnt = 0;

							try {
								nonCnt = PracticeMarkNon.userNonCnt(id_exam, id_q, userid);	
							} catch(Exception ex) {
								out.println(ComLib.getExceptionMsg(ex, "close"));

								if(true) return;
							}

							if(nonCnt == 0) {

								try {
									PracticeMarkNon.userNonInsert(id_exam, id_q, userid);
								} catch(Exception ex) {
									out.println(ComLib.getExceptionMsg(ex, "close"));

									if(true) return;
								}

							}
							
							if(points == null || points.equals("")) {
								for (int j = 0; j < qcount; j++) {
									points = points + "{:}";
								}
								points = points.substring(0, points.length()-3);
							} else {
								points = rst.getPoints();
							}		

							String[] ArrOxs = oxs.split(QmTm.Q_GUBUN_re, -1);
							String[] ArrPoints = points.split(QmTm.Q_GUBUN_re, -1);

							if(ExamAllotting == ComLib.nullChkDbl(score)) {
								ox = "O";
							} else if(ComLib.nullChkDbl(score) == 0.0) {
								ox = "X";
							} else {
								ox = "P";
							}

							ArrOxs[nr_q - 1] = ox;
							oxs = QmTm.join(ArrOxs, QmTm.Q_GUBUN);

							double tmpScore2 = ComLib.nullChkDbl(ArrPoints[nr_q - 1]);  // ������ ����� ������ ������ �´�.

							double add_point = 0; 
							if(tmpScore2 > Double.parseDouble(score)) {
							   add_point = (tmpScore2 - Double.parseDouble(score)) * -1;
							} else {
							   add_point = Double.parseDouble(score) - tmpScore2;
							}

							ArrPoints[nr_q - 1] = "" + score;
							points = QmTm.join(ArrPoints, QmTm.Q_GUBUN);

							double ans_score = Double.parseDouble(old_score) + add_point;

							rst.setOxs(oxs);	
							rst.setPoints(points);	
							rst.setScore(ans_score);
							rst.setScore_comment(score_comment);

							try {
								PracticeMarkNon.updateNon(id_exam, id_q, userid, rst);
							} catch(Exception ex) {
								out.println(ComLib.getExceptionMsg(ex, "close"));

								if(true) return;
							}

							try {
								PracticeMarkNon.userNonUpdate(id_exam, id_q, userid, Double.parseDouble(score));
							} catch(Exception ex) {
								out.println(ComLib.getExceptionMsg(ex, "close"));

								if(true) return;
							}
				
						}					
						
					}
					
                }
            }

       }
   } catch (Exception e) {
%>
       Error occurred:  <%= e.getMessage() %>
<%   
       e.printStackTrace();

		if(true) return;
    }

	// ������ ���� �α����� ����
	StringBuffer bigos = new StringBuffer();

	bigos.append("�����ڵ� : ");
	bigos.append(id_q);
			
	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam(id_exam);	
	logbean.setUserid(adm_userid);
	logbean.setGubun("�Ǳ���ä��");
	logbean.setId_q("");
	logbean.setBigo(bigos.toString());

	try {
		WorkExamLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
	// ������ ���� �α����� ����

%>

<Script type="text/javascript">
	$("#alert_compelete").show();
	$("#btn_close").show();
</Script>