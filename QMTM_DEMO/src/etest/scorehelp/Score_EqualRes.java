package etest.scorehelp;

import qmtm.*;
import java.sql.*;
import java.util.*;
import java.util.regex.*;

//for exam/myTest.jsp

public class Score_EqualRes
{

    public Score_EqualRes() {}

	public static void runinit(String id_exam, int id_q) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		PreparedStatement stm2 = null;
		int iRow = 0;

		//기존 데이터 삭제
		sql.append("Delete From equal_comp_result ");
		sql.append("Where id_exam = ? and id_q = ? ");

		try	{
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, id_q);
			stm.executeQuery();
		}
        catch (SQLException ex) {
            throw new QmTmException("[Score_EqualRes.runinitA]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
		
		/*
		stm = null;
		sql.setLength(0);
		sql.append("Delete From equal_test_result2 ");
		sql.append("Where id_exam = ? and id_q = ? ");

		try	{
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, id_q);
			stm.executeQuery();
		}
        catch (SQLException ex) {
            throw new QmTmException("[Score_EqualRes.runinitB]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
        }
		*/

		Connection cnn3 = null;

		stm = null;
		sql.setLength(0);
		sql.append("Select count(userid) cnt ");
		sql.append("From exam_ans_non ");
		sql.append("Where id_exam = ? and id_q = ? and length(userans1) > 0 ");

		try	{
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, id_q);
			rst = stm.executeQuery();
			if (rst.next()) {
				iRow = rst.getInt("cnt");
			}
		}
        catch (SQLException ex) {
            throw new QmTmException("[Score_EqualRes.runinitC]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn3 != null) try { cnn3.close(); } catch (SQLException ex) {}
        }

		rst = null;
		stm = null;
		sql.setLength(0);
		sql.append("Select userid, userans1, nvl(userans2, ' ') userans2, nvl(userans3, ' ') userans3, ");
		sql.append("       nvl(userans4, ' ') userans4, nvl(userans5, ' ') userans5, nvl(userans6, ' ') userans6 ");
		sql.append("From exam_ans_non ");
		sql.append("Where id_exam = ? and id_q = ? and length(userans1) > 0 ");
		sql.append("Order by userid ");

		Connection cnn2 = null;

		try	{
			cnn2 = DBPool.getConnection();
			stm = cnn2.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, id_q);
			rst = stm.executeQuery();

			//검색이 자신을 제외한 모든 응시자의 답안을 찾는 과정 이므로 배열에 담아서 루프를 돌리도록 변경
			String[] allNon = new String[iRow];
			String[] allUserid = new String[iRow];
			String nonAns = "";
			int i = 0, j = 0, p = 0, q = 0;
			int equal_cnt = 0;
			Pattern pt = null;
			Matcher mt = null;
			String userids = "", o_t_res_rate = "", t_o_res_rate = "";
			double res1 = 0, res2 = 0;

			while (rst.next()) {
				nonAns = "";
				nonAns = rst.getString("userans1") + rst.getString("userans2") + rst.getString("userans3") + rst.getString("userans4") + rst.getString("userans5") + rst.getString("userans6");
				nonAns = nonAns.trim();
				nonAns = nonAns.replace(")","");
				nonAns = nonAns.replace("(","");
				nonAns = nonAns.replace(",","");
				nonAns = nonAns.replace(".","");
				nonAns = nonAns.replace("*","");
				nonAns = nonAns.replace("[","");
				nonAns = nonAns.replace("]","");
				nonAns = nonAns.replace("|","");
				nonAns = nonAns.replace("{","");
				nonAns = nonAns.replace("}","");
				nonAns = nonAns.replace("+","");
				nonAns = nonAns.replace("<","");
				nonAns = nonAns.replace(">","");
				nonAns = nonAns.replace("/","");
				nonAns = nonAns.replace("\\","");
				nonAns = nonAns.replace("?","");
				nonAns = nonAns.replace("\r\n", " ");

				allUserid[i] = rst.getString("userid");
				allNon[i] = nonAns;
				i++;
			}

			for (i=0; i < allNon.length; i++) {
				//검색할 답안을 설정
				String[] arrSearch = allNon[i].split(" ");
				userids = "";
				o_t_res_rate = "";
				t_o_res_rate = "";

				for (j=0; j < allNon.length; j++) {
					//같은 답안이 아닐 경우만 검색 하도록
					if (i != j) {
						userids = userids + allUserid[j] + "{|}";
						
						//현재 응시자의 기준으로 다른 응시자의 답안과 비교
						equal_cnt = 0;
						String[] arrTarget = allNon[j].split(" ");
						
						for (p=0; p<arrSearch.length; p++) {
							if (arrSearch[p].trim().length() > 0) {
								pt = Pattern.compile(arrSearch[p]);

								for(q=0; q < arrTarget.length; q++) {
									mt = pt.matcher(arrTarget[q]);

									if(mt.find()) {
										equal_cnt = equal_cnt + 1;	
										break;
									}
								}
							}
						}

						res1 = 0;
						res1 = ((equal_cnt * 1.0) / (arrSearch.length * 1.0)) * 100.0;

						
						//다른 응시자를 기준으로 현재 응시자의 답안과 비교(역비교)
						equal_cnt = 0;
						for (p=0; p<arrTarget.length; p++) {
							if (arrTarget[p].trim().length() > 0) {
								pt = Pattern.compile(arrTarget[p]);

								for(q=0; q < arrSearch.length; q++) {
									mt = pt.matcher(arrSearch[q]);

									if(mt.find()) {
										equal_cnt = equal_cnt + 1;	
										break;
									}
								}
							}
						}

						res2 = 0;
						res2 = ((equal_cnt * 1.0) / (arrTarget.length * 1.0)) * 100.0;

						res1 = Math.round(res1*100);
						res2 = Math.round(res2*100);

						res1 = res1/100;
						res2 = res2/100;

						o_t_res_rate = o_t_res_rate + Double.toString(res1) + "{|}";
						t_o_res_rate = t_o_res_rate + Double.toString(res2) + "{|}";
					}
				}
				
				if (userids != "") {
					userids = userids.substring(0, userids.length()-3);
				}

				if (o_t_res_rate != "") {
					o_t_res_rate = o_t_res_rate.substring(0, o_t_res_rate.length()-3);
				}

				if (t_o_res_rate != "") {
					t_o_res_rate = t_o_res_rate.substring(0, t_o_res_rate.length()-3);
				}

				sql.setLength(0);
				sql.append("insert into equal_comp_result ");
				sql.append("(id_exam, id_q, o_userid, t_userid, o_t_res_rate, t_o_res_rate) ");
				sql.append("values(?, ?, ?, ?, ?, ?) ");

				try	{
					stm2 = cnn2.prepareStatement(sql.toString());
					stm2.setString(1, id_exam);
					stm2.setInt(2, id_q);
					stm2.setString(3, allUserid[i]);
					stm2.setString(4, userids);
					stm2.setString(5, o_t_res_rate);
					stm2.setString(6, t_o_res_rate);
					stm2.executeQuery();
				}
				catch (SQLException ex) {					
					stm2.close();
					stm2 = null;

					try {
						stm2 = cnn2.prepareStatement(sql.toString());
						sql.setLength(0);
						sql.append("Delete From equal_comp_result ");
						sql.append("Where id_exam = ? and id_q = ? ");

						stm2.setString(1, id_exam);
						stm2.setInt(2, id_q);
						stm2.executeQuery();
					} catch (SQLException ex1) {
						throw new QmTmException("[Score_EqualRes.runinitE]" + ex1.getMessage());
					}
					finally {
						if (stm2 != null) try { stm2.close(); } catch (SQLException ex1) {}
					}

					throw new QmTmException("[Score_EqualRes.runinitD]" + ex.getMessage());
				}
				finally {
					if (stm2 != null) try { stm2.close(); } catch (SQLException ex) {}
				}
			}

		}
        catch (SQLException ex) {
            throw new QmTmException("[Score_EqualRes.runinitB]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn2 != null) try { cnn2.close(); } catch (SQLException ex) {}
        }
	}

	public static int getEqualCount(String id_exam, int id_q) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		//기존 데이터 삭제
		sql.append("Select count(id_q) as cnts ");
		sql.append("From equal_comp_result ");
		sql.append("Where id_exam = ? and id_q = ? ");

		try	{
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, id_q);
			rst = stm.executeQuery();

			if (rst.next()) {
				return rst.getInt("cnts");
			} else {
				return 0;
			}
		}
        catch (SQLException ex) {
            throw new QmTmException("[Score_EqualRes.getEqualCount]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }

	}
}
