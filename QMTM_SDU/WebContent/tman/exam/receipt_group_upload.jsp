<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.poi.poifs.filesystem.POIFSFileSystem, org.apache.poi.hssf.record.*, org.apache.poi.hssf.model.*, org.apache.poi.hssf.usermodel.*, org.apache.poi.hssf.util.*, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean, qmtm.*" %>

<html>

<head>

<title>대상자 접수</title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script>
	function go(id_exam){

		Show_LayerProgressBar(false);

		alert("접수자가 등록되었습니다.");
		location.href="receipt_group_inwons.jsp?id_exam="+id_exam;
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
<!-- 상태진행바가 위치할 HTMl소스 -->

<BODY onLoad = "Show_LayerProgressBar(true);">

<%
	String realFolder = "";

	String saveFolder = "upload";
	String encType = "EUC-KR";

	String id_exam = "";
	String filename = "";
	String excelfile = "";

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
			  out.print("업로드 금지 파일 입니다.");
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

       //워크북을 생성!                
       HSSFWorkbook workbook = new HSSFWorkbook(fs);

       int sheetNum = workbook.getNumberOfSheets();

       for (int k = 0; k < sheetNum; k++) {

            //시트 이름과 시트번호를 추출
            HSSFSheet sheet = workbook.getSheetAt(k);
            int rows = sheet.getPhysicalNumberOfRows();

            for (int r = 1; r < rows; r++) { 

                // 시트에 대한 행을 하나씩 추출
                HSSFRow row   = sheet.getRow(r);
                if (row != null) { 
                     int cells = row.getPhysicalNumberOfCells();

					 String userid = "";
					 String password = "";
					 String name = "";
					 String jikwi = "";
					 String jikmu = "";
					 String company = "";
					 String sosok1 = "";
					 String sosok2 = "";
					 String sosok3 = "";
					 String sosok4 = "";
					 String home_phone = "";
					 String mobile_phone = "";
					 String email = "";
					 String home_postcode = "";
					 String home_addr1 = "";

                     for (short c = 0; c < cells; c++) {

                         // 행에대한 셀을 하나씩 추출하여 셀 타입에 따라 처리
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
                                       value = String.valueOf(cell.getStringCellValue()); //String
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
								jikwi = value;
								bean.setJikwi(jikwi);
							} else if(cell.getCellNum() == 4) {
								jikmu = value;
								bean.setJikmu(jikmu);
							} else if(cell.getCellNum() == 5) {
								company = value;
								bean.setCompany(company);
							} else if(cell.getCellNum() == 6) {
								sosok1 = value;
								bean.setSosok1(sosok1);
							} else if(cell.getCellNum() == 7) {
								sosok2 = value;
								bean.setSosok2(sosok2);
							} else if(cell.getCellNum() == 8) {
								sosok3 = value;
								bean.setSosok3(sosok3);
							} else if(cell.getCellNum() == 9) {
								sosok4 = value;
								bean.setSosok4(sosok4);
							} else if(cell.getCellNum() == 10) {
								home_phone = value;
								bean.setHome_phone(home_phone);
							} else if(cell.getCellNum() == 11) {
								mobile_phone = value;
								bean.setMobile_phone(mobile_phone);
							} else if(cell.getCellNum() == 12) {
								email = value;
								bean.setEmail(email);
							} else if(cell.getCellNum() == 13) {
								home_postcode = value;
								bean.setHome_postcode(home_postcode);
							} else if(cell.getCellNum() == 14) {
								home_addr1 = value;
								bean.setHome_addr1(home_addr1);
							}			 
							  
							if(cell.getCellNum() == 0) {
								userid = value;								
								bean.setUserid(userid);
							}

                        } 					

                    }

					if(userid == null || userid.equals("")) {
						continue;
					}

					String[] arrId_exam = id_exam.split(",");

					for(int k=0; k<arrId_exam.length; k++) {
					
						try { 
							ReceiptUtil.getMCnt(arrId_exam[k], userid, bean);
						} catch(Exception ex) {
							//out.println(ComLib.getExceptionMsg(ex, "back"));
							out.println(ex.getMessage());

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
	
	out.println("<script>go('"+id_exam+"')</script>");
%>