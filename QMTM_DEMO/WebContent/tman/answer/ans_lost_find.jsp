<%
//******************************************************************************
//   ���α׷� : ans_lost_find.jsp
//   �� �� �� : ������ ��� ������ �˻�
//   ��    �� : ������ ��� ������ �˻�
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-10-12
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
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
		alert("�����ڰ� �����ϴ�.");
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
					
			if(arrAnswer[k] == null || arrAnswer[k].equals("")) { // ����� �ۼ����� �ʾҴٸ�
				out.println((k+1) + ". " + arrUserid[k] + " ��� ���ۼ�"+"<BR>");
				out.flush();
			
			} else {

				out.println((k+1) + ". " + arrUserid[k] + " ��� �м��� <BR>");
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
				
					// ������ ����� ���ۼ��� ����� �ִ��� ���� Ȯ���Ѵ�
					YN_Lost = "N";
					for(int j=0; j<rst2.length; j++) {
						if(rst2[j].getNr_q() == "") {
							YN_Lost = "Y";
							break;
						}
					}
				}			

				// ����� ������ ���ԵǾ������ ����� ù��° ���� ����������(������, �ܴ���) �˻� �ϸ� �ȴ�
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

					if(chk > 0) { // ������ ������� ����

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
									// �Ϲ��� ��� �α�
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
															} // if �� ����
														} // for �� ����
		
														if(FindYn.equals("N")) {
															strFindNumber = strFindNumber + String.valueOf(z + 1) + QmTm.Q_GUBUN;
														}

													} // if �� ����
												} // if �� ���� 
											
											} // if �� ����
										} // for �� ����
									}
								} else { // ����� ��� �α�
								
									if(!arr[4].equals("")) {

										String userans = "";
										for(int zz = 0; zz < rst2.length; zz++) {
											if(arr[2].equals(rst2[zz].getNr_q())) {
												userans = rst2[zz].getUserans1() + rst2[zz].getUserans2() + rst2[zz].getUserans3();
												break;
											} // if �� ����
										} // for �� ����

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

									} // if �� ����(����� ��� �α�)

								} // if �� ����

							} // for �� ����

						} // for �� ����
					
					} // ������ ������츸 ���� ����

					if(!strFindNumber.equals("")) {
						String[] arrNum = strFindNumber.substring(0, strFindNumber.length() - QmTm.Q_GUBUN.length()).split(QmTm.Q_GUBUN, -1);
					
						for(int p = 0; p < arrNum.length; p++) {
							out.println(arrUserid[k] + " �������� ��� �����ǽ� <font color=red>" + arrNum[p] + "��</font> ���� ��� ����<br>");
						}
								
						out.println("..................................................................................");
						out.println("<br>");
						out.flush();
					}
		
				}
			}

		} // for �� ����
	} // if �� ����
%>