<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.poi.poifs.filesystem.POIFSFileSystem, org.apache.poi.hssf.record.*, org.apache.poi.hssf.model.*, org.apache.poi.hssf.usermodel.*, org.apache.poi.hssf.util.*, qmtm.admin.MemberUtil, qmtm.admin.MemberBean, qmtm.*" %>

<html>

<head>

<title>대상자 접수</title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script>
	function go(){

		Show_LayerProgressBar(false);

		alert("접수자가 등록되었습니다.");
		location.href="receipt_inwons.jsp";
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
	String encType = "euc-kr";

	String filename = "";
	String excelfile = "";

	int maxSize = 1024*1024*100;

	ServletContext context = getServletContext();

	realFolder = context.getRealPath(saveFolder);

	try {
	 
		 MultipartRequest multi = null;
		 
		 multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		 
		 Enumeration files = multi.getFileNames();
		 
		 while(files.hasMoreElements()) {
		  
			  String name = (String)files.nextElement();
			  filename = multi.getFilesystemName(name);
			  String original = multi.getOriginalFileName(name);
			  String type = multi.getContentType(name);
			  
			  File file = multi.getFile(name);
			  
			  excelfile = realFolder+"/"+filename; 
	      }
 
	 
	}catch(IOException e){
	 out.println(e);
	 if(true) return;
	}catch(Exception ex){
	 out.println(ex);
	 if(true) return;
	}

	MemberBean bean = new MemberBean();
	
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

						 String value = "";

                         if (cell != null) {                               					
							  
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
								
								String[] arrSosok = sosok1.split(" ");

								if(value.trim().equals("")) {

								} else {	
			
									if(arrSosok != null) {
										
										if(arrSosok.length == 1) {																	
											sosok2 = arrSosok[0];
											bean.setSosok2(sosok2);	
											sosok3 = "";
											bean.setSosok3(sosok3);
											sosok4 = "";
											bean.setSosok4(sosok4);	
										} else if(arrSosok.length == 2) {
											sosok2 = arrSosok[0];
											bean.setSosok2(sosok2);	
											sosok3 = arrSosok[1];
											bean.setSosok3(sosok3);
											sosok4 = "";
											bean.setSosok4(sosok4);	
										} else if(arrSosok.length > 2) {
											sosok2 = arrSosok[0];
											bean.setSosok2(sosok2);	
											sosok3 = arrSosok[1];
											bean.setSosok3(sosok3);
											sosok4 = value.substring(value.indexOf(arrSosok[2]), value.length());
											bean.setSosok4(sosok4);	
										}
									}
								}

							} else if(cell.getCellNum() == 7) {
								home_phone = value;
								bean.setHome_phone(home_phone);
							} else if(cell.getCellNum() == 8) {
								mobile_phone = value;
								bean.setMobile_phone(mobile_phone);
							} else if(cell.getCellNum() == 9) {
								email = value;
								bean.setEmail(email);
							} else if(cell.getCellNum() == 10) {
								home_postcode = value;
								bean.setHome_postcode(home_postcode);
							} else if(cell.getCellNum() == 11) {
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

					try {
						MemberUtil.getMCnt(userid, bean);
					} catch(Exception ex) {
						//out.println(ComLib.getExceptionMsg(ex, "back"));
						out.println(ex.getMessage());

					    if(true) return;
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
	
	out.println("<script>go()</script>");
%>