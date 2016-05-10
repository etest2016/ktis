<%
//******************************************************************************
//   ���α׷� : receipt_upload.jsp
//   �� �� �� : �������� ����� ���
//   ��    �� : �������� ����� ���
//   �� �� �� : exam_receipt, qt_userid
//   �ڹ����� : 
//   �� �� �� : 2013-02-13
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
<%@ page import="org.apache.poi.poifs.filesystem.POIFSFileSystem, org.apache.poi.hssf.record.*, org.apache.poi.hssf.model.*, org.apache.poi.hssf.usermodel.*, org.apache.poi.hssf.util.*, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean, qmtm.*, qmtm.common.*" %>
<!DOCTYPE html>
	<head>
		<title>��������</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="../../js/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
		<script src="../../js/jquery.js"></script>
		<script src="../../js/bootstrapjs/bootstrap.min.js"></script>
		<script type="text/javascript">
			function close_window() {
				
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
		<div id="alert_compelete" style="display:none;" class="alert alert-success">����ڰ� ��ϵǾ����ϴ�.</div>
	</div>
<%
	String realFolder = "";

	String saveFolder = "upload";
	String encType = "EUC-KR";

	String id_exam = "";
	String filename = "";
	String excelfile = "";

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	int maxSize = 1024*1024*100;

	ServletContext context = getServletContext();

	realFolder = context.getRealPath(saveFolder);

	try {
	 
		 MultipartRequest multi = null;
		 
		 multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

		 id_exam = multi.getParameter("id_exam");
		 
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

	ReceiptBean bean = new ReceiptBean();
	
	try {
       POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(excelfile)); 

       //��ũ���� ����!                
       HSSFWorkbook workbook = new HSSFWorkbook(fs);

       int sheetNum = workbook.getNumberOfSheets();

       for (int k = 0; k < sheetNum; k++) {

            //��Ʈ �̸��� ��Ʈ��ȣ�� ����
            HSSFSheet sheet = workbook.getSheetAt(k);
            int rows = sheet.getPhysicalNumberOfRows();

            for (int r = 1; r < rows; r++) {                 

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
					 String password = "";
					 String name = "";
					 String sosok1 = "";
					 String sosok2 = "";					 
					 String level = "";	
					 
                     for (short c = 0; c < cells; c++) {

                         // �࿡���� ���� �ϳ��� �����Ͽ� �� Ÿ�Կ� ���� ó��
                         HSSFCell cell  = row.getCell(c);
                         if (cell != null || cell.equals("")) { 
							 
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
								bean.setUserid(userid);
							} else if(cell.getCellNum() == 1) {
								password = value;
								bean.setPassword(password);
							} else if(cell.getCellNum() == 2) {
								name = value;
								bean.setName(name);
							} else if(cell.getCellNum() == 3) {
								sosok1 = value;
								bean.setSosok1(sosok1);
							} else if(cell.getCellNum() == 4) {
								sosok2 = value;
								bean.setSosok2(sosok2);
							} else if(cell.getCellNum() == 5) {
								level = value;
								bean.setLevel(level);								
							}

                        } 					

                    }

					if(!(userid == null || userid.equals(""))) {

					try {
						ReceiptUtil.getMCnt(id_exam, userid, bean);
					} catch(Exception ex) {
						out.println(ComLib.getExceptionMsg(ex, "back"));

					    if(true) return;
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

	// �������� ����� ��� �α����� ����
	StringBuffer bigos = new StringBuffer();

	bigos.append("��Ϲ�� : ");
	bigos.append("�������ϴ���ڵ��");
			
	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam(id_exam);	
	logbean.setUserid(adm_userid);
	logbean.setGubun("����ڵ��");
	logbean.setId_q("");
	logbean.setBigo(bigos.toString());

	try {
		WorkExamLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
	// �������� ����� ��� �α����� ����
%>

<Script type="text/javascript">
	$("#alert_compelete").show();
	alert("����ڰ� ��ϵǾ����ϴ�.");
	location.href="receipt_inwons.jsp?id_exam=<%=id_exam%>";
</Script>