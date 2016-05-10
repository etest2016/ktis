package etest.webscore;

// Package Import
import qmtm.DBPool;
import qmtm.QmTm;
import qmtm.ComLib;
import qmtm.QmTmException;
import etest.paper.User_ExamAns;
import etest.paper.User_ExamAnsBean;

// Java API Import
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

public class User_AnswerMark
{
    public User_AnswerMark() {
    }

    public static User_AnswerMarkBean[] getBeans(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("SELECT a.userid, a.yn_mark, b.name, a.oxs ");
        sql.append("FROM exam_ans a, qt_userid b ");
        sql.append("WHERE a.id_exam = ? and a.userid <> 'tman@@2008' and a.userid = b.userid ");
        sql.append("ORDER BY a.yn_mark, b.name ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);            
            rst = stm.executeQuery();
            User_AnswerMarkBean bean = null;
            while (rst.next()) {
                bean = makeBean(rst);
                beans.add(bean);
            }
            if (beans.isEmpty()) {
                return null;
            } else {
                return (User_AnswerMarkBean[]) beans.toArray(new User_AnswerMarkBean[0]);
            }
        }
        catch (SQLException ex) {
			throw new QmTmException("������ ����� ���� �о������ ������ �߻��Ǿ����ϴ�. [User_AnswerMark.getBeans] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static User_AnswerMarkBean makeBean (ResultSet rst) throws QmTmException
    {
        try {
            User_AnswerMarkBean bean = new User_AnswerMarkBean();
            bean.setUserid(rst.getString(1));
            bean.setYn_mark(rst.getString(2));
			bean.setNames(rst.getString(3));
			bean.setOxs(rst.getString(4));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("������ ����� ���� �о������ ������ �߻��Ǿ����ϴ�. [User_AnswerMark.makeBean] " +ex.getMessage());
        }
    }

    public static void saveMarkedPoint(int nr_q, double point, double allot, String yn_mark, int qcount, User_ExamAnsBean ans) throws QmTmException
    {
        // ���� ä�� ����� �����Ѵ�.
        try
        {
			String oxs = ans.getOxs();
            String[] arrOx = oxs.split(QmTm.Q_GUBUN_re, -1);
            String points = ans.getPoints().trim();
            
			if(points == null || points.length() == 0) {
				for (int i = 0; i < qcount; i++) {
					points = points + "{:}";
				}

				points = points.substring(0, points.length()-3);
			} 
			
			String[] arrPoint = points.split(QmTm.Q_GUBUN_re, -1);			

			if (arrOx.length != arrPoint.length) {
                throw new QmTmException("[ans bean �� OXS �� POINTS �� ������ �ٸ��ϴ�]");
            }
            if (arrOx.length < nr_q) {
                throw new QmTmException("[nr_q �� ���������� Ů�ϴ�]");
            }

            String ox;
            if (point <= 0.0) {
                ox = "X";
                point = 0.0;				

            } else if (point >= allot) {
                ox = "O";
                point = allot;				
            } else {
                ox = "P";				
            }

			double tmpScore = ComLib.nullChkDbl(arrPoint[nr_q - 1]);  // ������ ����� ������ ������ �´�.

			double add_point = 0;
	        if(tmpScore > point) {
			    add_point = (tmpScore - point) * -1;
			} else {
				add_point = point - tmpScore;
	        }
			
            arrOx[nr_q - 1] = ox;
            arrPoint[nr_q - 1] = "" + point;

            oxs = QmTm.join(arrOx, QmTm.Q_GUBUN);
            points = QmTm.join(arrPoint, QmTm.Q_GUBUN);
						
			double score = ans.getScore() + add_point;
            
            if (yn_mark.length() == 0) yn_mark = "N";

            ans.setOxs(oxs);
            ans.setPoints(points);
            ans.setScore(score);
            ans.setYn_mark(yn_mark);

            User_ExamAns.update(ans);
        } catch (Exception ex) {
            throw new QmTmException("������ ����� ä�� ó���� ������ �߻��Ǿ����ϴ�. [User_AnswerMark.saveMarkedPoint] " +ex.getMessage());
        }
    }

    public static String getAnswerDisplay (int id_valid_type, int id_qtype, int cacount, String answer) throws QmTmException
    {
        String ansDisplay = "";
        try
        {
            if (id_valid_type == 2) {
                ansDisplay = "(��� ���� ó��)";
            }
            else
            {
                if (answer.length() == 0) {
                    if (id_valid_type == 9) { // �������� ���
                        ansDisplay = "(�������� �����ϴ�)";
                    } else {
                        ansDisplay = "(�������� �����ϴ�)";
                    }
                }
                else if (id_qtype == 4) { // �ܴ���
                    if (cacount > 1) { // ������
                        String[] arrCa = answer.split(QmTm.OR_GUBUN_re, -1);
                        for (int j = 0; j < arrCa.length; j++) {
                            ansDisplay += "��" + arrCa[j].replaceAll(QmTm.LIKE_GUBUN_re, " �Ǵ� ") + "<br>";
                        }
                    } else { // �ܼ���
                        ansDisplay = answer.replaceAll(QmTm.LIKE_GUBUN_re, " �Ǵ� ");
                    }
                } else { // 5:�����
                    if (id_valid_type == 9) { // �������� ���
                        ansDisplay = QmTm.delTag(answer);
                    } else {
                        ansDisplay = "N/A";
                    }
                }
            }
            return ansDisplay;
        }
        catch (Exception ex) {
            throw new QmTmException("������ ��� ���� ó���� ������ �߻��Ǿ����ϴ�. [User_AnswerMark.getAnswerDisplay] " +ex.getMessage());
        }
    }
}
