<%
//******************************************************************************
//   프로그램 : ans_lost_find.jsp
//   모 듈 명 : 응시자 답안 유실자 검색
//   설    명 : 응시자 답안 유실자 검색
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-10-12
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, java.sql.*, java.util.*, java.net.*, java.io.*" %>

<%
    response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	LogFindBean[] rst = null;

	try {
		rst = LogFind.getBeans(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	if(rst == null) {
%>
	<Script language="JavaScript">
		alert("응시자가 없습니다.");
		window.close();
	</Script>
<%
		if(true) return ;

	} else {
		int userid_cnt = rst.length;

		String[] arrUserid = new String[userid_cnt];
		String[] arrAnswer = new String[userid_cnt];
		int[] arrNr_set = new int[userid_cnt];
				
		for(int i=0; i<rst.length; i++) {
			arrUserid[i] = rst[i].getUserid();
			arrAnswer[i] = rst[i].getAnswer();
			arrNr_set[i] = rst[i].getNr_set();
		}
		
		LogFindBean[] rst2 = null;

		for(int k=0; k<arrUserid.length; k++) {
					
			if(arrAnswer[k] == null || arrAnswer[k].equals("")) { // 답안을 작성하지 않았다면
				out.println((k+1) + ". " + arrUserid[k] + " 답안 미작성"+"<BR>");
				out.flush();
			
			} else {

				out.println((k+1) + ". " + arrUserid[k] + " 답안 분석중 <BR>");
				out.flush();

				String strFindNumber = "";

				try {
					rst2 = LogFind.getNonBeans(id_exam, arrUserid[k], arrNr_set[k]);
				} catch(Exception ex) {
					out.println(ComLib.getExceptionMsg(ex, "back"));

					if(true) return;
				}

				String[] arrAns = arrAnswer[k].split(QmTm.Q_GUBUN_re, -1);
			
				String YN_NON = "";
				String YN_Lost = "";
				String FindYn = "";
						
				if(rst2 == null) {
					YN_NON = "N";
				} else {
					YN_NON = "Y";
				
					// 응시자 답안중 미작성한 답안이 있는지 먼저 확인한다
					YN_Lost = "N";
					for(int j=0; j<rst2.length; j++) {
						if(rst2[j].getNr_q() == "") {
							YN_Lost = "Y";
							break;
						}
					}
				}			

				// 논술형 문제가 포함되었을경우 논술형 첫번째 문제 이전까지만(객관식, 단답형) 검색 하면 된다
				if(YN_Lost.equals("N")) {
					if(YN_NON.equals("Y")) {
						for(int i=0; i<rst2.length; i++) {
							if(arrAns[i].equals("")) {
								YN_Lost = "Y";
								break;
							}
						}
					} else {		
						for(int i=0; i<arrAns.length; i++) {
							if(arrAns[i].equals("")) {
								YN_Lost = "Y";
								break;
							}
						}
					}
				}

				long ans_remain_time = 9999999;
				long non_remain_time = 9999999;

				if(YN_Lost.equals("Y")) { 
				
					String[] ArrUrls = new String[1];

				    ArrUrls[0] = "http://119.194.200.83:2010/logs/"+id_exam+"/"+arrUserid[k]+"_ans.txt";

					String[] logs = new String[1];
					int svr_no = 1;

					LogAnswerBean[] log = null;
			
					try {
						log = Log.getBeans(id_exam, arrUserid[k]);
					} catch(Exception ex) {
						out.println(ComLib.getExceptionMsg(ex, "back"));

						if(true) return;
					}

					int chk = 0;
					for(int i = 0; i < ArrUrls.length; i++) 
				    {
					    File f = new File("http://119.194.200.83:2010/logs/"+id_exam+"/"+arrUserid[k]+"_ans.txt");

						if(f.exists()) {
							chk = chk + 1;
						}
					}

					if(chk > 0) { // 파일이 있을경우 진행

						for(int m = 0; m < ArrUrls.length; m++) 
					    {
							URL url = new URL(ArrUrls[m]);
	
							InputStream in = url.openStream();
							Reader reader = new InputStreamReader(in);
							BufferedReader br = new BufferedReader(reader);
						    StringWriter output = new StringWriter();
						    BufferedWriter bw = new BufferedWriter(output);
							String line = br.readLine(); // read the first line

							while(line != null) {
		     
								bw.write(line, 0, line.length());
						        bw.newLine();
						        line = br.readLine(); 
							}
			    
							br.close();
							bw.close();
	
							logs[k] = output.toString() + logs[k];

							String[] arrRecord = logs[k].split(DBPool.NL);

							Collection beans = new ArrayList();

							for (int i = 0; i < arrRecord.length-1; i++)
						    {
								String[] arr = arrRecord[i].split(DBPool.FLD_KB, -1);
	
								if(arr[2].equals("")) {
									// 일반형 답안 로그
									if(!arr[4].equals("")) {
										String[] arrTmp = arr[4].split(QmTm.Q_GUBUN_re, -1);
										for(int z = 0; z < arrAns.length; z++) {
											if(arrAns[z].equals("")) {

												if(!arrTmp[z].equals("")) {
													if(strFindNumber.equals("")) {
														strFindNumber = strFindNumber + String.valueOf(z + 1) + QmTm.Q_GUBUN;
													} else {
													
														String[] arrNum = strFindNumber.substring(0, strFindNumber.length() - QmTm.Q_GUBUN.length()).split(QmTm.Q_GUBUN, -1);
														FindYn = "N";
													
														for(int n = 0; n < arrNum.length; n++) {
															if(arrNum[n].equals(String.valueOf(z+1))) {
																FindYn = "Y";
															} // if 문 종료
														} // for 문 종료
		
														if(FindYn.equals("N")) {
															strFindNumber = strFindNumber + String.valueOf(z + 1) + QmTm.Q_GUBUN;
														}

													} // if 문 종료
												} // if 문 종료 
											
											} // if 문 종료
										} // for 문 종료
									}
								} else { // 논술형 답안 로그
								
									if(!arr[4].equals("")) {

										String userans = "";
										for(int zz = 0; zz < rst2.length; zz++) {
											if(arr[2].equals(rst2[zz].getNr_q())) {
												userans = rst2[zz].getUserans1() + rst2[zz].getUserans2() + rst2[zz].getUserans3();
												break;
											} // if 문 종료
										} // for 문 종료

										if(userans.equals("")) {

											if(strFindNumber.equals("")) {
												strFindNumber = strFindNumber + arr[2] + QmTm.Q_GUBUN;
											} else {
												String[] arrNum = strFindNumber.substring(0, strFindNumber.length() - QmTm.Q_GUBUN.length()).split(QmTm.Q_GUBUN, -1);
												FindYn = "N";

												for(int kk = 0; kk < arrNum.length; kk++) {
													if(arrNum[kk].equals(arr[2])) {
														FindYn = "Y";
													}
												}
		
												if(FindYn.equals("N")) {
													strFindNumber = strFindNumber + arr[2] + QmTm.Q_GUBUN;
												}

											}
										}

									} // if 문 종료(논술형 답안 로그)

								} // if 문 종료

							} // for 문 종료

						} // for 문 종료
					
					} // 파일이 있을경우만 진행 종료

					if(!strFindNumber.equals("")) {
						String[] arrNum = strFindNumber.substring(0, strFindNumber.length() - QmTm.Q_GUBUN.length()).split(QmTm.Q_GUBUN, -1);
					
						for(int p = 0; p < arrNum.length; p++) {
							out.println(arrUserid[k] + " 응시자의 답안 유실의심 <font color=red>" + arrNum[p] + "번</font> 문제 답안 누락<br>");
						}
								
						out.println("..................................................................................");
						out.println("<br>");
						out.flush();
					}
		
				}
			}

		} // for 문 종료
	} // if 문 종료
%>